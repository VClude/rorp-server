create table if not exists rtx_property
(
    id bigint unsigned auto_increment,
    name text not null,
    sold tinyint(1) default 0 null,
    price int default 0 not null,
    locked tinyint(1) default 1 null,
    constraint id
        unique (id)
);

alter table rtx_property
    add primary key (id);

create table if not exists rtx_property_garage_vehicles
(
    id bigint unsigned auto_increment,
    name text not null,
    plate text not null,
    props longtext not null,
    constraint id
        unique (id)
);

alter table rtx_property_garage_vehicles
    add primary key (id);

create table if not exists rtx_property_inventory
(
    id bigint unsigned auto_increment,
    inventory_name text null,
    data longtext null,
    constraint id
        unique (id)
);

alter table rtx_property_inventory
    add primary key (id);

create table if not exists rtx_property_owners
(
    id bigint unsigned auto_increment,
    name text null,
    identifier text null,
    active tinyint(1) default 1 null,
    owner tinyint(1) default 0 null,
    constraint id
        unique (id)
);

alter table rtx_property_owners
    add primary key (id);

INSERT INTO `rtx_property` (`id`, `name`, `sold`, `price`, `locked`) VALUES
	(1, '3655 Wild Oats Drive', 0, 300000, 1),
	(2, '2044 North Conker Avenue', 0, 250000, 1),
	(3, '2044 Hillcrest Avenue', 0, 275000, 1),
	(4, '2862 Hillcrest Avenue', 0, 265000, 1),
	(5, '2868 Hillcrest Avenue', 0, 200000, 1),
	(6, '2045 North Conker Avenue', 0, 235000, 1),
	(7, '2677 Whispymound Drive', 0, 150000, 1),
	(8, '2133 Mad Wayne Thunder Drive', 0, 125000, 1),
	(9, '1052 Grove Street', 0, 65000, 1),
	(10, '3092 West Mirror Park Drive', 0, 105000, 1);
	
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES 
('kosmetickasada', 'Make-UP', 1, 0, 1);	