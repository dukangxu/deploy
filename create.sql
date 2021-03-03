create database piwigo;
create user 'piwigo'@'%' identified by 'piwigo';
grant all privileges on piwigo.* to piwigo@'%' identified by 'piwigo';
flush privileges;