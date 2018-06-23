CREATE USER 'agaveapi'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'agaveapi'@'%';
CREATE USER 'maxscale'@'%' IDENTIFIED BY 'd3f@ult$';
GRANT ALL PRIVILEGES ON *.* TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`db` TO 'maxscale'@'%';
GRANT SELECT ON `mysql`.`user` TO 'maxscale'@'%';
FLUSH PRIVILEGES;

