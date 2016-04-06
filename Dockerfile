FROM ubuntu:trusty
MAINTAINER sleepz2000@yahoo.fr

RUN apt-get update && apt-get install -y \
	autoconf \
	autopoint \
	build-essential \
	curl \
	gettext \
	libavcodec54 \
	libavformat54 \
	libavutil52 \
	libexif12 \
	libflac8 \
	libid3tag0 \
	libjpeg8 \
	libjpeg-turbo8 \
	libogg0 \
	libsqlite3-0 \
	libvorbis0a \
	libvorbisenc2 \
	libvorbisfile3 \
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

RUN curl -o minidlna.zip https://sourceforge.net/code-snapshots/git/u/u/u/takeshich/minidlna.git/u-takeshich-minidlna-df08fc74b66fb288d85fbe84b9d03409b6a1f331.zip \
 && unzip minidlna.zip

RUN cd `ls -d u-takeshich-minidlna*` \
	&& ./autogen.sh \
	&& ./configure  \
	&& make \
	&& make install 
RUN rm -rf `ls -d u-takeshich-minidlna*`

RUN apt-get remove -y \
        autoconf \
        autopoint \
        build-essential \
        curl \
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
        unzip 


RUN mkdir -p /media/files
RUN mkdir -p /media/minidlna.cache

COPY minidlna.conf /etc/minidlna.conf

EXPOSE 1900/udp
ENTRYPOINT ["/usr/local/sbin/minidlnad","-S"]
CMD ["-f /etc/minidlna.conf"]
