FROM drupal
RUN mkdir /app
WORKDIR /app
RUN npm install
CMD npm start