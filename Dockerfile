FROM nginx:1.17.0-alpine
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d
COPY docker/dist /var/www/tool
