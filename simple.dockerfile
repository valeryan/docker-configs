FROM nginx

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

# Turn of sendfile
RUN sed -i '/^ *sendfile/s/on/off/' /etc/nginx/nginx.conf

# Change Nginx config here...
RUN rm /etc/nginx/conf.d/default.conf
ADD ./nginx/simple.conf /etc/nginx/conf.d/
