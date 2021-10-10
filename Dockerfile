FROM node:14.18.0
WORKDIR /app
COPY . .
CMD ["node","./src/app.js"]