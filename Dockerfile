FROM node:18-alpine AS builder

WORKDIR /app

COPY . . 

RUN npm install

#chạy trực tiếp, nếu chạy với nginx thì phải chạy RUN npm run build
CMD [ "npm", "start" ]      


