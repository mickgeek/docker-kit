FROM httpd:2.4.53-alpine

COPY ./vhosts/ ${HTTPD_PREFIX}/conf/vhosts/

RUN { \
        echo "LoadModule rewrite_module modules/mod_rewrite.so"; \
        echo "LoadModule proxy_module modules/mod_proxy.so"; \
        echo "LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so"; \
        echo; \
        echo "AddHandler proxy:fcgi://php-fpm:9000 .php"; \
        echo; \
        echo "Include conf/vhosts/*.conf"; \
    } | tee -a ${HTTPD_PREFIX}/conf/httpd.conf

EXPOSE 80
EXPOSE 443
