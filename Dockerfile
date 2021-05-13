FROM jenkins/jenkins:lts
ENV JAVA_OPTS -Xms256m -Xmx512m
ENTRYPOINT []
CMD /sbin/tini -s -- /usr/local/bin/jenkins.sh --httpPort=$PORT
