FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# update the repo
COPY php56-centos6/assets/ius-release-1.0-14.ius.centos6.noarch.rpm /tmp/ius-release-1.0-14.ius.centos6.noarch.rpm
COPY php56-centos6/assets/xcache-3.2.0-2.tar /tmp/xcache-3.2.0-2.tar
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
RUN yum -y update && yum -y install epel-release

RUN yum -y localinstall /tmp/ius-release-1.0-14.ius.centos6.noarch.rpm
#RUN sed -i "s/enabled=0/enabled=1/" /etc/yum.repos.d/ius-archive.repo

RUN yum -y update && yum -y install httpd  bash-completion pwgen supervisor sendmail mysql56u libmemcached10 \
                                    php56w php56w-common php56w-cli php56w-bcmath php56w-dba php56w-xml php56w-process \
                                    php56w-xmlrpc php56w-gd php56w-mysqlnd php56w-mcrypt php56w-mbstring php56w-soap \
                                    php56w-pecl-memcached php56w-pecl-geoip php56w-pecl-xdebug php-pear-XML-Parser \
                                    php-pear-Mail php-pear-Mail-Mime php-pear-DB php-pear-HTML-Common \
                                    php-pear-Auth-SASL php-pear-phing php-pear-Pager perl-IPC-Signal \
                                    perl-Proc-WaitStat  perl-mime-construct liblockfile lockfile-progs \
                                    logcheck mod_ssl openssl install tar zip

# install xcache 3.2.0 which works with php5.6, unfortunately, have to compile yourself
RUN yum -y groupinstall 'Development Tools' 'Development Libraries' && yum -y install php56w-devel
RUN tar xf /tmp/xcache-3.2.0-2.tar && \
     pushd /xcache-3.2.0/ && phpize && popd &>/dev/null \
     && pushd /xcache-3.2.0/ && ./configure --enable-xcache && popd &>/dev/null \
     && pushd /xcache-3.2.0/ && make install && popd &>/dev/null \
     && mkdir /var/www/xcache && cp -rf /xcache-3.2.0/htdocs/* /var/www/xcache/ \
     && rm -rf /xcache-3.2.0

RUN yum clean all

# add website apache configs.
COPY php56-centos6/configs/apache-configs/httpd.conf /etc/httpd/conf/httpd.conf

# Add custom ini files
COPY php56-centos6/ini/xcache.ini /etc/php.d/xcache.ini
COPY php56-centos6/ini/php.ini /etc/php.ini

RUN rm /etc/httpd/conf.d/ssl.conf

# Simple startup script to avoid some issues observed with container restart
ADD php56-centos6/run-httpd.sh /usr/bin/run-httpd.sh

CMD ["/usr/bin/run-httpd.sh"]