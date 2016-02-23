FROM jdeathe/centos-ssh

MAINTAINER Arnaldo Bertoni Júnior <arnaldo.bertoni01@fatec.sp.gov.br>

RUN	echo "Starting..." \
	&& yum -y update \
	&& yum -y install httpd \
	&& /sbin/service httpd start \
	&& chkconfig httpd on \
	&& rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm \
	&& yum -y install php56w \
	&& yum -y install php56w-pear php56w-pecl-apcu php56w-cli php56w-pdo php56w-mysql php56w-pgsql php56w-pecl-memcache php56w-gd php56w-mbstring php56w-mcrypt php56w-xml php56w-pecl-xdebug \
	&& echo 'date.timezone = "America/Sao_paulo"' > /etc/php.d/date.ini \
	&& sed -i -e"s/^;date.timezone\s*=\s*/date.timezone = \"America\/Sao_paulo\"/" /etc/php.ini \
	&& mkdir /opt/composer \
	&& cd /opt/composer \
	&& curl -sS https://getcomposer.org/installer | php \
	&& cp composer.phar /usr/local/bin \
	&& mv /usr/local/bin/composer.phar /usr/local/bin/composer \
	&& echo "Stopping..."

CMD ["/tmp/external/run.sh"]

EXPOSE 80
