FROM ubuntu:xenial

RUN apt-get update -y \
    && apt-get install -y vim zip curl apache2 php libapache2-mod-php php-mcrypt php-mysql php-cli

 # Configure apache
RUN a2enmod rewrite
RUN a2enmod ssl

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN rm -rf /var/www/html/* && echo '<?php phpinfo(); ?>' > /var/www/html/index.php

EXPOSE 80
COPY httpd.sh /usr/bin/httpd.sh
RUN chmod 777 /usr/bin/httpd.sh
CMD ["/usr/bin/httpd.sh"]