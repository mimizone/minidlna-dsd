FROM ubuntu:trusty
MAINTAINER sleepz2000@yahoo.fr

#https://sourceforge.net/code-snapshots/git/u/u/u/takeshich/minidlna.git/u-takeshich-minidlna-df08fc74b66fb288d85fbe84b9d03409b6a1f331.zip
RUN apt-get update && apt-get install -y \
	autoconf \
	autopoint \
	build-essential \
	curl \
	gettext \
	libavcodec-dev \
	libavformat-dev \
	libavutil-dev \
	libexif-dev \
	libflac-dev \
	libid3tag0-dev \
	libjpeg-dev \
	libogg-dev \
	libsqlite3-dev \
	libvorbis-dev \
	unzip \
&& rm -rf /var/lib/apt/lists/*

RUN curl -o minidlna.zip https://sourceforge.net/code-snapshots/git/u/u/u/takeshich/minidlna.git/u-takeshich-minidlna-df08fc74b66fb288d85fbe84b9d03409b6a1f331.zip

RUN unzip minidlna.zip

RUN cd `ls -d u-takeshich-minidlna*` \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

RUN mkdir -p /media/files
RUN mkdir -p /media/minidlna.cache

COPY minidlna.conf /etc/minidlna.conf

#RUN cd `ls -d u-takeshich-minidlna*` && cp linux/minidlna.init.d.script /etc/init.d/minidlna
#RUN chmod a+x /etc/init.d/minidlna

EXPOSE 1900/udp

ENTRYPOINT ["/usr/local/sbin/minidlnad"]
CMD ["-d -f /etc/minidlna.conf"]

