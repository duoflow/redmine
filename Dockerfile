### Dockerfile.yml
FROM redmine:4.1

# ref https://github.com/danmunn/redmine_dmsf/issues/901

RUN apt-get update && apt-get upgrade && apt-get install -y make gcc xapian-omega ruby-xapian libxapian-dev xpdf \ 
    poppler-utils antiword unzip catdoc libwpd-tools libwps-tools gzip unrtf catdvi djview djview3 uuid uuid-dev \ 
    xz-utils libemail-outlook-message-perl

#RUN apt-get update && apt-get upgrade && apt-get install -y make gcc ruby-full \
#    libxapian-dev libxapian30 xapian-doc xapian-examples xapian-tools xapian-omega libxapian-dev xpdf antiword \
#    unzip catdoc libwpd-0.10-10 libwps-0.4-4 gzip unrtf catdvi djview djview3 uuid uuid-dev

# ref https://github.com/danmunn/redmine_dmsf/issues/984
RUN sed -i -e 's/config.eager_load = true/config.eager_load = false/g' config/environments/production.rb

# add modified redmine_dmsf
ADD --chown=redmine:redmine ./customization/redmine_dmsf ./plugins/redmine_dmsf

COPY ./customization/install_dmfs.sh /usr/src/redmine/
RUN chmod +x /usr/src/redmine/install_dmfs.sh
RUN cd /usr/src/redmine/

#CMD ["/usr/src/redmine/install_dmfs.sh"]
