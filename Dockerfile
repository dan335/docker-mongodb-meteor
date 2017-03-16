FROM mvertes/alpine-mongo:3.2.3
MAINTAINER Zadkiel Aslafy-Aharonian

COPY repl_init.sh /
RUN chmod +x /repl_init.sh

ENTRYPOINT sh -c '/repl_init.sh; /root/run.sh mongodb'
