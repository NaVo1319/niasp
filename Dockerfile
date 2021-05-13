FROM drupal
RUN mkdir /app
RUN rm -rf /etc/apache2ss
ADD . /app
WORKDIR /app
