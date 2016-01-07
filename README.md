Minimal environment for CentOs + Apache + PHP
=============================================

Use with Docker http://www.docker.io

This Dockerfile provide an environment Centos + Apache + PHP for to be used in the developing environment, for to be faster and more productive create environments of develop.
Questions as security and performance were not thought.


Was used the following versions:

	CentOS release 6.7 (Final)
	Apache/2.2.15
	PHP 5.6.16
	

To construct the image

	cd <path/Dockerfile/downloaded>
    docker build -t <name_of_your_choice> .


To run the container

    docker run -i -t --name app -p 80:80 -v <path_with_conf>:/tmp/external -v <path_your_project1_in_your_machine>:/var/www/html/<name_your_project1> <name_of_your_choice>

To exit of the container press Ctrl+p+q

To enter in the container terminal

    List the containers
    docker ps -a
    
    Enter in the mysql conatiner
    docker exec -i -t <container_id> bash

Obs:

:: Remember of give execution permission for the file run.sh [chmod a+x /run.sh]

:: Put your file configurations in the same folder of the file run.sh. The files names need to be the same of the projects configurated in run.sh

:: Change the file run.sh and include the names of the projects and your alias to be used

:: Didn't forget to include the urls in your hosts
