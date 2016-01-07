#!/bin/bash
#-----------------------------------------------------
#  Arquivo:       run.sh
#  Descricao:     Arquivo de configuração de ambiente
#                 do container Apache + PHP
#  Autor:         Arnaldo Bertoni Júnior
#----------------------------------------------------

echo "Began the container..."
echo ""

ifconfig eth0 | grep inet | awk '{ print $2 }'

/sbin/service httpd start

# Put here your projects that must be used
# Don't forget to insert the file configuration with the
# same name declared here
# The basic sctruct of this array is 
# name, beginalias, finishalias, createfolder
# For each project will be need to create
# these 4 values
projects=("projectsite" 0 3 true "projectblog" 3 4 false)
# Put here your alias that must be created in hosts
# In the order that was described above
alias=("projectsite.com" "www.projectsite.com" "ww3.projectsite.com" "blog.projectsite.com")

i=0;

if [ ${#projects[@]} -gt 0 ]; then

	echo "Will be used $((${#projects[@]}/4)) projects"
	echo ""
	
	while [ $i -lt ${#projects[@]} ]; do
		echo "Initializing the process with the project '${projects[$i]}'"
		echo ""
		
		let control=i+3
		if [ "${projects[$control]}" = true ]; then
			chown -R apache: /var/www/html/"${projects[$i]}"
			chmod 2775 /var/www/html/"${projects[$i]}"
		fi
		
		cp /tmp/external/"${projects[$i]}".conf /etc/httpd/conf.d/"${projects[$i]}".conf
		chown root: /etc/httpd/conf.d/"${projects[$i]}".conf
		
		let offset=i+1
		let length=i+2
		
		for ((x=${projects[$offset]};x<${projects[$length]};x++)); do
			echo "127.0.0.1 ${alias[$x]}" >> /etc/hosts
		done
		
		let i++
		let i++
		let i++
		let i++
	done

fi

/sbin/service httpd restart

sleep 5

tail -f /var/log/httpd/error_log
