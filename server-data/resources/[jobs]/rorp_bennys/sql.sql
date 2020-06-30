INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_bennys', 'Bennys', 1);

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(222, 'society_bennys', 0, NULL);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('bennys', 'Bennys', 1, '');

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(56, 'bennys', 0, 'zacatecnik', 'Začátečník', 12, '{}', '{"glasses_2":-1,"bracelets_2":-1,"watches_1":-1,"torso_2":0,"mask_2":0,"glasses_1":-1,"shoes_1":52,"ears_1":-1,"mask_1":0,"bags_2":0,"arms_2":0,"shoes_2":0,"watches_2":-1,"tshirt_1":2,"arms":0,"torso_1":286,"pants_2":20,"bags_1":0,"chain_2":0,"ears_2":-1,"tshirt_2":0,"helmet_2":-1,"bracelets_1":-1,"pants_1":92,"chain_1":0,"helmet_1":-1}'),
(57, 'bennys', 1, 'mechanik', 'Mechanik', 24, '{}', '{}'),
(58, 'bennys', 2, 'profesional', 'Profesionál', 36, '{}', '{}'),
(59, 'bennys', 3, 'manazer', 'Manažer', 48, '{}', '{}'),
(60, 'bennys', 4, 'boss', 'Šéf', 0, '{}', '{}');

ALTER TABLE `owned_vehicles` ADD `tunerdata` LONGTEXT NOT NULL;
