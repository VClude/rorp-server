CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1',
  `weight` int(11) NOT NULL DEFAULT '1',
  `limit` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rtx_ammo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner` text COLLATE utf8mb4_bin NOT NULL,
  `hash` text COLLATE utf8mb4_bin NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `rtx_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` text COLLATE utf8mb4_bin NOT NULL,
  `type` text COLLATE utf8mb4_bin,
  `data` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin AUTO_INCREMENT=53 ;

CREATE TABLE IF NOT EXISTS `rtx_inventory_itemdata` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_bin NOT NULL,
  `description` text COLLATE utf8mb4_bin,
  `weight` int(11) NOT NULL DEFAULT '0',
  `closeonuse` tinyint(1) NOT NULL DEFAULT '0',
  `max` int(11) NOT NULL DEFAULT '100',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin AUTO_INCREMENT=1 ;
