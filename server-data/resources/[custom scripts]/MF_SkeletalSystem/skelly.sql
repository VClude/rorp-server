
INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('bodybandage','Body Bandage', 5),
	('armbrace','Arm Brace', 5),
	('legbrace','Leg Brace', 5),
	('neckbrace','Neck Brace', 5);

ALTER TABLE `users`
	ADD `skellydata` LONGTEXT NOT NULL;
