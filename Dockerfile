FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# the default command from nginx is to start up the nginx server for us
# EXPOSE 80 - elastic beanstalk uses this to map port, 
#   does nothing locally except to let developers know the port that can be exposed