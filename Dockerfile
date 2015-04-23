FROM debian:wheezy
MAINTAINER Darius Bakunas-Milanowski <bakunas@gmail.com>

RUN apt-get update -yqq && apt-get install -yqq \
	dnsutils \
	host \
	libapache2-mod-php5 \
	php5-curl \
	php5-gd \
	php5-mysql \
	supervisor \
	wget

WORKDIR /opt
RUN wget http://bruteforce.gr/wp-content/uploads/kippo-graph-1.5.tar.gz && \
	tar zxvf kippo-graph-1.5.tar.gz

RUN chown -R www-data:www-data kippo-graph-1.5 && \
	ln -s kippo-graph-1.5 kippo-graph && rm *.tar.gz

WORKDIR /opt/kippo-graph

RUN chmod 777 generated-graphs && cp -p config.php.dist config.php

# configure apache
WORKDIR /etc/apache2/sites-available 

ADD kippo-graph.conf /etc/apache2/sites-available/kippo-graph.conf

RUN chmod 644 kippo-graph.conf && \
	a2ensite kippo-graph.conf && \
	a2dissite 000-default.conf && \
	a2dissite default-ssl.conf

# add config for supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# start supervisor on launch
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
