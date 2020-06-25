
INSERT INTO `items` (`name`, `label`) VALUES
	('bodybandage','Body Bandage'),
	('armbrace','Arm Brace'),
	('legbrace','Leg Brace'),
	('neckbrace','Neck Brace');

ALTER TABLE `users`
	ADD `skellydata` LONGTEXT NOT NULL;
