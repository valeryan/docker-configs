FROM nginx

# Turn of sendfile
RUN sed -i '/^ *sendfile/s/on/off/' /etc/nginx/nginx.conf

# Change Nginx config here...
RUN rm /etc/nginx/conf.d/default.conf
ADD ./etc/nginx/extra.conf /etc/nginx/conf.d/
ADD ./etc/nginx/api.conf /etc/nginx/conf.d/

ENV APP_ENV docker
