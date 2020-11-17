#!/bin/bash
#Maintainer:- Bibhuti Narayan
#Purpose of script:- To check SSL certificate expired day.
#Dependency of script:- "url_list". Put all url inside this file without "https://".
echo " " >script_output.out
for i in `cat url_list`
          do
                   data=`echo | openssl s_client -servername $i -connect $i:443 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##'`
                   ssldate=`date -d "${data}" '+%s'`
                   nowdate=`date '+%s'`
                   diff="$((${ssldate}-${nowdate}))"
                   left_days="$((${diff}/86400))"
                   echo "$i $left_days Days|">> script_output.out
done
cat script_output.out | column -t  -s "  " -c 3
