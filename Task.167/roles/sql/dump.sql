CREATE TABLE `app_test` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
INSERT INTO app_test (id, name, value) VALUES 
(1,'app_test1','I am in the db'),
(2,'app_test2','I am in the db'),
(3,'app_test3','I am in the db')