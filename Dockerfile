from debian:8.0

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade

RUN echo "cyrus-common cyrus-common/removespools boolean true" | debconf-set-selections

RUN apt-get -y install cyrus-imapd cyrus-admin sasl2-bin

RUN mkdir -p /run/cyrus/proc && chown -R cyrus /run/cyrus

ADD cyrus.conf /cyrus.conf
ADD imapd.conf /imapd.conf

CMD /usr/sbin/cyrmaster -M /cyrus.conf -C /imapd.conf
