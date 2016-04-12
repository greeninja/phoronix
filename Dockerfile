FROM ubuntu:trusty
MAINTAINER James Wilkins <james.wilkins@Fasthosts.co.uk>

RUN apt-get update \
    && apt-get -y install \
          build-essential wget unzip perl perl-base perl-modules libsdl-perl \
          libperl-dev libpcre3-dev mesa-utils php5-cli php5-gd php5-json \
    && cd /tmp \
    && wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_6.2.1_all.deb \
    && dpkg -i phoronix-test-suite_6.2.1_all.deb \
    && rm -f phoronix-test-suite_6.2.1_all.deb
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN sysctl -p
RUN echo ynny | /usr/bin/phoronix-test-suite batch-setup
ENTRYPOINT ["/usr/bin/phoronix-test-suite phoromatic.connect phoronix-benchmarks.perf-paas.fasthosts.net.uk:80/8RUWV1"]

