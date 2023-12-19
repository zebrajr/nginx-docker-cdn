FROM nginx:alpine
COPY ./src/html /usr/share/nginx/html
COPY ./src/nginx/default.conf /etc/nginx/conf.d/default.conf

# Set permissions for the images directory
RUN mkdir -p /usr/share/nginx/html/images && chmod -R 755 /usr/share/nginx/html/images

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
