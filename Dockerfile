FROM node:18-alpine AS builder

WORKDIR /app

COPY . . 

RUN npm install

#chạy trực tiếp, nếu chạy với nginx thì phải chạy RUN npm run build
# CMD [ "npm", "start" ] 
RUN npm run build     

#Thêm stage này build ra sẽ nhẹ hơn nhiều (lúc trước không dùng 467 MB, có nó chỉ ra 21MB)
#Thế nginx ở đây là cái gì thế ???? Project VueJS hay ReactJS khi chạy sẽ cần một webserver để có thể chạy được nó, và Nginx ở đây chính là webserver. Ở local có cần Nginx gì đâu nhỉ? Vì ở local khi chạy npm run dev thì các nhà phát triển VueJS đã thiết lập sẵn cho chúng ta 1 local webserver rồi nhé, nhưng khi chạy thật thì không nên dùng nhé, phải có 1 webserver xịn, và Nginx thì rất là xịn nhé
FROM nginx:1.17-alpine as production-stage
#copy file builder đã build trước đó vào nginx /usr/share/nginx/ 
COPY --from=builder /app/build /usr/share/nginx/ 
CMD ["nginx", "-g", "daemon off;"]