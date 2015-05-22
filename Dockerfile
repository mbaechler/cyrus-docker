from debian:8.0

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade

RUN echo "cyrus-common cyrus-common/removespools boolean true" | debconf-set-selections

RUN apt-get -y install cyrus-imapd cyrus-admin sasl2-bin

RUN mkdir -p /run/cyrus/proc && chown -R cyrus /run/cyrus

ADD cyrus.conf /etc/cyrus.conf
ADD imapd.conf /etc/imapd.conf

# create some default use, cyrus is configured as admin in imapd.conf
RUN echo "cyrus"|saslpasswd2 -u test -c cyrus -p
RUN echo "bob"|saslpasswd2 -u test -c bob -p
RUN echo "alice"|saslpasswd2 -u test -c alice -p

CMD /usr/sbin/cyrmaster

