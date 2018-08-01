FROM java:8

ENV FTB_URL https://www.feed-the-beast.com/projects/ftb-continuum/files/2582098/download

RUN curl -SL $FTB_URL -o /tmp/ftb.zip && \
    unzip /tmp/ftb.zip -d /opt/minecraft && \
    find /opt/minecraft -name "*.log" -exec rm -f {} \; && \
    rm -rf /opt/minecraft/ops.* /opt/minecraft/whitelist.* /opt/minecraft/logs/* /tmp/*

ADD eula.txt /opt/minecraft/eula.txt

ENV MINECRAFT_VERSION 1.12.2
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx4096m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBserver-1.12.2-14.23.4.2730-universal.jar

VOLUME /opt/minecraft/world

EXPOSE 25565
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
