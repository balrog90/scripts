#!/bin/bash
grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" /home/python/auth.log | sort | uniq -c | sed 's/^[ \t]*//g' > ip.txt
awk '$1 >= 10 { print $2 }' ip.txt > ip_for_iptables.txt
cat /home/python/ip_for_iptables.txt

file=$(cat /home/python/ip_for_iptables.txt)
for ip in $file
do
sudo ipset -A blackip  $ip
done

sudo iptables -A INPUT -m set --match-set blackip src -j DROP | tee > info.txt

