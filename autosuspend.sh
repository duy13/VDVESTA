#!/bin/bash
# echo '0 */5 * * * root bash /root/autosuspend.sh' >> /etc/crontab
PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin
source ~/.bashrc  >/dev/null 2>&1
source ~/.bash_profile  >/dev/null 2>&1


# If autosuspend.sh is still running:
if [ -f /root/autosuspend.tmp ]; then
exit 0
fi

# Update user information:
/usr/local/vesta/bin/v-update-user-stats
/usr/local/vesta/bin/v-update-sys-queue webstats
/usr/local/vesta/bin/v-update-sys-queue traffic
/usr/local/vesta/bin/v-update-sys-queue disk

# Get list of users (except admin):
listuserraw=`/usr/local/vesta/bin/v-list-users`
listuser=`echo "$listuserraw" | awk {'print $1'}| tail -n +4`
echo "$listuser" > /root/autosuspend.tmp


ten_file_chua_list="/root/autosuspend.tmp"
so_dong_file_chua_list=`cat $ten_file_chua_list | grep . | wc -l`
so_dong_bat_dau_tim=1

dong=$so_dong_bat_dau_tim
while [ $dong -le $so_dong_file_chua_list ]
do
user=$(awk " NR == $dong " $ten_file_chua_list)

#
timenow=`date +"[DATE=%d-%m-%Y_TIME=%Hh%M]"`
info_user_raw=`/usr/local/vesta/bin/v-list-user $user`

user_suspend_status=`echo "$info_user_raw" |grep "SUSPENDED:" | awk {'print $2'}| awk {'print $1'}`
# If the user has been suspended, do not check again:
if [ "$user_suspend_status" = "no" ]; then

	user_disk_space_used=`echo "$info_user_raw" |grep "DISK:" | awk {'print $2'}| tr '/' ' '| awk {'print $1'}`
	user_disk_space_limit=`echo "$info_user_raw" |grep "DISK:" | awk {'print $2'}| tr '/' ' '| awk {'print $2'}`
	# If the user is not restricted (unlimited), do not recheck:
	if [ "$user_disk_space_limit" != "unlimited" ]; then
		# If the user overuse, will be temporarily disabled (suspended):
		if [ "$user_disk_space_used" -gt "$user_disk_space_limit" ]; then
		/usr/local/vesta/bin/v-suspend-user $user
		echo "$timenow WARNING: Suspend user $user - Use too much hard drive space [$user_disk_space_used/$user_disk_space_limit]"
		# If the user has not exceeded disk space, switch to bandwidth check:
		else
		user_bandwidth_used=`echo "$info_user_raw" |grep "BANDWIDTH:" | awk {'print $2'}| tr '/' ' '| awk {'print $1'}`
		user_bandwidth_limit=`echo "$info_user_raw" |grep "BANDWIDTH:" | awk {'print $2'}| tr '/' ' '| awk {'print $2'}`
			# If the user is not restricted (unlimited), do not recheck:
			if [ "$user_bandwidth_limit" != "unlimited" ]; then
				# If the user overuse, will be temporarily disabled (suspended):
				if [ "$user_bandwidth_used" -gt "$user_bandwidth_limit" ]; then
				/usr/local/vesta/bin/v-suspend-user $user
				echo "$timenow WARNING: Suspend user $user - Use too much bandwidth [$user_bandwidth_used/$user_bandwidth_limit]"
				fi
			fi
		fi
	fi
fi
#


dong=$((dong + 1))
done

# Remove to end this process:
rm -rf /root/autosuspend.tmp

