FROM drupal
RUN mkdir /app
ADD . /app
WORKDIR /app
