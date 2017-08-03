use weekreport;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS content CASCADE ;

CREATE TABLE content
(
	id INT  not null PRIMARY key auto_increment,
	content text
)ENGINE=INNODB DEFAULT CHARSET=utf8;