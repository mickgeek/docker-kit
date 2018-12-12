FROM mysql:5.7.20

COPY ./mysqld.cnf /etc/mysql/mysql.conf.d/
COPY ./mysql.cnf /etc/mysql/conf.d/
RUN chmod 644 \
    /etc/mysql/mysql.conf.d/mysqld.cnf \
    /etc/mysql/conf.d/mysql.cnf
