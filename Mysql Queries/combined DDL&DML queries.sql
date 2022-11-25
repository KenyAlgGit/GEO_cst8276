use cst8276;

drop table if exists `geolocation`;
drop table if exists `polyline`;
drop table if exists `polygon`;

CREATE TABLE `geolocation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(250) NOT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `polyline` (
  `id` int NOT NULL AUTO_INCREMENT,
  `polyline_name` varchar(255) DEFAULT NULL,
  `start_point_address` varchar(255) DEFAULT NULL,
  `start_lat` varchar(255) DEFAULT NULL,
  `start_lng` varchar(255) DEFAULT NULL,
  `end_point_address` varchar(255) DEFAULT NULL,
  `end_point_lat` varchar(255) DEFAULT NULL,
  `end_point_lng` varchar(255) DEFAULT NULL,
  `polyline_route` json DEFAULT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `polygon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `polygon_name` varchar(255) DEFAULT NULL,
  `start_point_address` varchar(255) DEFAULT NULL,
  `start_lat` varchar(255) DEFAULT NULL,
  `start_lng` varchar(255) DEFAULT NULL,
  `end_point_address` varchar(255) DEFAULT NULL,
  `end_point_lat` varchar(255) DEFAULT NULL,
  `end_point_lng` varchar(255) DEFAULT NULL,
  `polygon_route` json DEFAULT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

drop procedure if exists polyline_update;
DELIMITER $$
CREATE DEFINER=`DBcst8276`@`localhost` PROCEDURE `polyline_update`()
BEGIN
	update polyline
	set start_lat = (select latitude from geolocation ge where ge.address = polyline.start_point_address), 
	start_lng = (select longitude from geolocation ge where ge.address = polyline.start_point_address);
    
    update polyline
	set end_point_lat = (select latitude from geolocation ge where ge.address = polyline.end_point_address), 
	end_point_lng = (select longitude from geolocation ge where ge.address = polyline.end_point_address);
END$$
DELIMITER ;

drop procedure if exists polygon_update;
DELIMITER $$
CREATE DEFINER=`DBcst8276`@`localhost` PROCEDURE `polygon_update`()
BEGIN
	update polygon
	set start_lat = (select latitude from geolocation ge where ge.address = polygon.start_point_address), 
	start_lng = (select longitude from geolocation ge where ge.address = polygon.start_point_address);
    
    update polygon
	set end_point_lat = (select latitude from geolocation ge where ge.address = polygon.end_point_address), 
	end_point_lng = (select longitude from geolocation ge where ge.address = polygon.end_point_address);
END$$
DELIMITER ;



delete from `cst8276`.`polyline`;
insert into polyline (
    polyline_name, 
    start_point_address, 
    end_point_address)
values(
    'route1',
    'Algonquin College',
    'CF Rideau Centre'
);

delete from `cst8276`.`polygon`;
insert into polygon (
    polygon_name, 
    start_point_address, 
    end_point_address)
values(
    'polygon1',
    'Algonquin College',
    'CF Rideau Centre'
);