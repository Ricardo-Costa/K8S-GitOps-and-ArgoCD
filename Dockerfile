FROM node:14.18.0-alpine3.14
WORKDIR /app
COPY . .
RUN npm install
CMD ["node","./src/app.js"]