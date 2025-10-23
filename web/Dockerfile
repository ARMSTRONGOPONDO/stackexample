FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
COPY js /usr/share/nginx/html/js
COPY questions /usr/share/nginx/html/questions
COPY login /usr/share/nginx/html/login
COPY web/nginx.conf /etc/nginx/conf.d/default.conf
COPY web/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
