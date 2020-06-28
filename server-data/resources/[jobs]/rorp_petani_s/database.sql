INSERT INTO `items` (`name`, `label`, `weight`, `limit`, `rare`, `can_remove`) VALUES
	('padi', 'Padi', 1, -1, 0, 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('petani', 'Petani', 0);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('petani', 0, 'employee', 'Petani', 200, '{}', '{}');