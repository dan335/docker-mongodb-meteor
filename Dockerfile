FROM mvertes/alpine-mongo:3.2.3
MAINTAINER Zadkiel Aslafy-Aharonian

COPY repl_init.sh run.sh /root/
RUN chmod +x /root/*.sh

ENTRYPOINT /root/run.sh
CMD mongod
