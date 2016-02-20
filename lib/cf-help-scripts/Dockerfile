FROM phusion/baseimage:0.9.16

RUN     apt-get update && apt-get install -y \
            build-essential \
            sed \
            wget

RUN     wget -O cf_cli.deb 'https://cli.run.pivotal.io/stable?release=debian64&version=6.11.2&source=github-rel'
RUN     dpkg -i cf_cli.deb

RUN     locale-gen en_US.UTF-8

RUN     groupadd -r setupuser && useradd -r -g setupuser setupuser

RUN     ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts
RUN     chown -R setupuser:setupuser /tmp

USER    setupuser

ENV     HOME /tmp/build
RUN     mkdir /tmp/build
WORKDIR /tmp/build

ENV     LC_ALL en_US.UTF-8

ADD     . /tmp/build/
