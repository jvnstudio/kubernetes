FROM nginx:alpine
LABEL maintainer="Your Name <your@email.address>"
COPY website /usr/share/nginx/website
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
