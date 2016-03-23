FROM tutum/apache-php

# Github deployment key to speed up install
ARG GH_OAUTH

RUN apt-get update
RUN apt-get install -y \
    git \
    wget \
    php5-intl \
    php5-mcrypt

RUN php5enmod mcrypt

RUN a2enmod rewrite

RUN echo "date.timezone = \"Europe/Paris\"" >> /etc/php5/cli/php.ini && \
    echo "date.timezone = \"Europe/Paris\"" >> /etc/php5/apache2/php.ini

RUN composer self-update

RUN composer config -g github-oauth.github.com ${GH_OAUTH}
RUN composer create-project --prefer-dist akeneo/pim-community-standard /pim "1.5.*@stable"

#RUN composer install --prefer-dist 

ADD ./sites-enabled/akeneo-pim.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./run.sh /run.sh
RUN chmod +x /run.sh

RUN rm -rf /src/app/cache/* && \
    rm -fr /src/app/logs/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done; \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80

CMD ["/run.sh"]
