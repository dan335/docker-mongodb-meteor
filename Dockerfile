FROM mongo:3.0
MAINTAINER Daniel Phillips (http://danp.us)

# timezone
RUN echo "Etc/UTC" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

COPY assets/replInit.sh /replInit.sh
COPY assets/mongo.sh /mongo.sh
RUN chmod 755 /replInit.sh
RUN chmod 755 /mongo.sh

CMD ["/mongo.sh"]
