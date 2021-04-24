FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Adding EXPOSE <port> does nothing in local env, 
# However Elasticbeanstalk is capable of interpreting this
# and maps this port for incoming traffic
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html