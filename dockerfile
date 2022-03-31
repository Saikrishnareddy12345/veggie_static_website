FROM httpd
COPY . /usr/local/apache2/htdocs
RUN rm -rf /usr/local/apache2/htdocs/k8s
RUN rm -rf /usr/local/apache2/htdocs/dockerfile