FROM drupal
RUN rm -rf /etc/apache2ss
ADD . /app
WORKDIR /app
