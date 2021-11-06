FROM debian:bookworm-slim
MAINTAINER Nandan Desai <nkdesai409@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN \
  apt-get install -y wget apache2 php-xdebug libapache2-mod-php php mariadb-server php-mysql pwgen php-gd php-xml php-mbstring zip unzip php-zip curl php-curl debconf-utils && \
  echo mariadb-server mysql-server/root_password password mypassword | debconf-set-selections && \
  echo mariadb-server mysql-server/root_password_again password mypassword | debconf-set-selections
  

RUN \
  rm -rf /var/lib/apt/lists/* && \
  cd /var/www/html && \
  wget https://github.com/digininja/DVWA/archive/master.zip && \
  unzip master.zip && \
  cp -r DVWA-master/* . && \
  rm -rf DVWA-master && \
  rm index.html master.zip && \
  mv config/config.inc.php.dist config/config.inc.php && \
  echo 'session.save_path = "/tmp"' >> /etc/php/7.4/apache2/php.ini && \
  sed -ri -e "s/^allow_url_include.*/allow_url_include = On/" /etc/php/7.4/apache2/php.ini && \
  echo "\n[mysqld] \nbind-address = 0.0.0.0\n" >> /etc/mysql/my.cnf && \
  chmod a+w hackable/uploads && \
  chmod a+w external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

RUN service mariadb restart && \
    sleep 3 && \
    mysql -uroot -pmypassword -e "CREATE USER dvwa@'%' IDENTIFIED BY 'p@ssw0rd';CREATE DATABASE dvwa;GRANT ALL privileges ON dvwa.* TO 'dvwa'@'%';"

EXPOSE 80 3306
COPY main.sh /
ENTRYPOINT ["/main.sh"]

