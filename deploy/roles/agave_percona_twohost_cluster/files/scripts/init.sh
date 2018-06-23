#/usr/bin/env bash
set -x
if [[ ! -f /var/lib/mysql/ibdata1 ]]; then
    mysql_install_db
    /usr/bin/mysqld_safe &
    sleep 10s

    x="root123"
    cat > "/tmp/secure.sql" << EOF
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test; DELETE FROM mysql.db WHERE DB='test' OR DB='test\\_%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$x' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY '$x' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.42.1' IDENTIFIED BY '$x' WITH GRANT OPTION;
CREATE USER 'agaveapi'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'agaveapi'@'%';
CREATE USER 'maxscale'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`db` TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`user` TO 'maxscale'@'%';
FLUSH PRIVILEGES;
EOF
    echo "*** Securing MySQL ($host)..."
    /usr/bin/mysql -uroot -h127.0.0.1 < /tmp/secure.sql; rm -f /tmp/secure.sql

    killall -15 mysqld_safe mysqld
    chown -R mysql.mysql /var/lib/mysql
    sleep 10s
fi
# mount fix
grep -v rootfs /proc/mounts > /etc/mtab
/usr/bin/mysqld_safe &

/usr/bin/supervisord
