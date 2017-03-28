FROM ubuntu:14.04

ENV VERSION 1.80

RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
   automake curl build-essential libfuse-dev libcurl4-openssl-dev libtool \
   libxml2-dev mime-support tar checkinstall \
 && curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v${VERSION}.tar.gz | \
    tar zxv -C /usr/src \
 && cd /usr/src/s3fs-fuse-${VERSION} \
 && ./autogen.sh \
 && ./configure --prefix=/usr \
 && make \
 && checkinstall --install -y --pkgname s3fs --pkgversion ${VERSION}-0 \
    --requires libxml2,libfuse2,libcurl3 \
    -D make install \
 && apt-get autoremove -y --purge automake curl build-essential libfuse-dev \
    libcurl4-openssl-dev libtool libxml2-dev mime-support checkinstall

ADD entrypoint.sh /
CMD ["/entrypoint.sh"]
