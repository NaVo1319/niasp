FROM node:6.6
WORKDIR =/usr/src/app
COPY ./ ./
RUN  npm install
RUN  npm install express
CMD node index.js --bind 0.0.0.0:$PORT