-- Adminer 4.8.1 MySQL 8.0.41-0ubuntu0.24.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE `activity_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `action` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `created_at`) VALUES
(1,	10,	'Вход в систему',	'2025-04-10 15:57:30'),
(2,	10,	'Вход в систему',	'2025-04-10 15:58:10'),
(3,	3,	'Вход в систему',	'2025-04-10 15:59:09');

DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `announcements` (`id`, `text`, `created_at`) VALUES
(1,	'прввет тут обявления',	'2025-04-10 15:11:49');

DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `banners` (`id`, `title`, `url`, `image`) VALUES
(1,	'Акция',	'http://82.118.19.91/product',	'82.118.19.91/img/test.png');

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `description`, `image`) VALUES
(1,	'Категория 1',	'описания первой категории',	''),
(2,	'Категория 2',	'отписания второй категории',	''),
(3,	'Категория 3',	'описания третьей категории',	'');

DROP TABLE IF EXISTS `nav`;
CREATE TABLE `nav` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `nav_links`;
CREATE TABLE `nav_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `seller_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `name`, `price`, `seller_id`, `created_at`, `category_id`) VALUES
(2,	'Тестовый товар 2',	250.50,	2,	'2025-04-10 14:34:00',	1),
(3,	'Тестовый товар 3',	401.00,	1,	'2025-04-10 14:34:00',	2);

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_user` int NOT NULL,
  `to_user` int NOT NULL,
  `rating` tinyint NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reviews` (`id`, `from_user`, `to_user`, `rating`, `comment`, `created_at`) VALUES
(1,	2,	8,	5,	'Комментарий номер 1',	'2025-04-10 14:41:36'),
(2,	3,	8,	3,	'Комментарий номер 2',	'2025-04-09 14:41:36'),
(3,	2,	7,	2,	'Комментарий номер 3',	'2025-04-08 14:41:36'),
(4,	3,	6,	3,	'Комментарий номер 4',	'2025-04-07 14:41:36'),
(5,	2,	8,	5,	'Комментарий номер 5',	'2025-04-06 14:41:36'),
(6,	5,	8,	2,	'Комментарий номер 6',	'2025-04-05 14:41:36'),
(7,	5,	7,	2,	'Комментарий номер 7',	'2025-04-04 14:41:36'),
(8,	2,	10,	1,	'Комментарий номер 8',	'2025-04-03 14:41:36'),
(9,	2,	8,	3,	'Комментарий номер 9',	'2025-04-02 14:41:36'),
(10,	4,	10,	3,	'Комментарий номер 10',	'2025-04-01 14:41:36');

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `settings` (`id`, `setting_key`, `value`) VALUES
(1,	'access_price',	'10');

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `type` enum('buyer','seller') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `bitcoin_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tx_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','confirmed','failed') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jabber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('admin','moderator','seller','buyer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('inactive','active','banned') COLLATE utf8mb4_unicode_ci DEFAULT 'inactive',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jabber` (`jabber`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `jabber`, `password_hash`, `type`, `status`, `slug`, `created_at`, `updated_at`) VALUES
(1,	'asdkj@dffd.com',	'$2y$10$We5PtoOELwEHyeMN.u58ue8Fo7byn7w30Aa.WtBS.9ncHYYSNsmQK',	'buyer',	'inactive',	NULL,	'2025-04-10 10:50:47',	'2025-04-10 10:50:47'),
(2,	'aa@aa.com',	'$2y$10$1Cnb15u4UDQfPUJ5Y9I95Oz8wtaaDYgmmZ.Nuoxo.usFmLY8SXWva',	'buyer',	'inactive',	NULL,	'2025-04-10 10:54:33',	'2025-04-10 10:54:33'),
(3,	'123@123.com',	'$2y$10$0i04859vSb/73iXeEmTlSe7Q.UEYgJBbL/Kkp3X7r1yQ71qPYNrjW',	'admin',	'active',	NULL,	'2025-04-10 10:56:17',	'2025-04-10 10:56:17'),
(6,	'222@222.com',	'$2y$10$8WRTIWvqiotGrpXTAd/CtucIOetjIYGsbUTMryDKD1q4j3gsA/mH2',	'seller',	'inactive',	NULL,	'2025-04-10 13:08:58',	'2025-04-10 13:08:58'),
(7,	'333@333.com',	'$2y$10$FVOSA39un8gCK9wq4IigDe5SuR5phW/8DE4XRKXm5O6awlDNQDk2K',	'seller',	'inactive',	NULL,	'2025-04-10 13:44:41',	'2025-04-10 14:14:54'),
(8,	'asdasd@dfdf.com',	'$2y$10$RbCcpzLJvq9SffpyjLhzt.k0mM9pWsTX49vEmHiKR.Sb/dI1HUIba',	'buyer',	'inactive',	NULL,	'2025-04-10 14:53:18',	'2025-04-10 14:53:18'),
(9,	'user@thesecure.biz',	'$2y$10$/.6CSzINmw7C6tvnn3zOGe8gel2sVIrYnHGHCKm4FrkKYqn1.nsDy',	'admin',	'active',	NULL,	'2025-04-10 14:53:48',	'2025-04-10 14:56:01'),
(10,	'999@999.com',	'$2y$10$yGzA.WAmmTMjr0EmuHSeaOQb0hRfRwVT3q7OzF9B6Wu1qN1zdashq',	'seller',	'active',	NULL,	'2025-04-10 15:39:20',	'2025-04-10 15:49:17');

-- 2025-04-10 17:37:22
