-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: web_store_test
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(155) DEFAULT NULL,
  `alias` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'default.png',
  `enabled` tinyint NOT NULL,
  `parent_id` int DEFAULT NULL,
  `all_parent_ids` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category_category1` (`parent_id`),
  CONSTRAINT `fk_category_category1` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Phones','phones','phones.png',1,NULL,NULL),(2,'Clothes','clothes','clothes.png',1,NULL,NULL),(3,'TV','tv','tv.png',1,NULL,NULL),(4,'Watches','watches','watch.png',1,NULL,NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `orders_id` int NOT NULL,
  `status` enum('Обработка','Отправлено','Отмена','Доставлено') NOT NULL DEFAULT 'Обработка',
  PRIMARY KEY (`orders_id`),
  KEY `fk_delivery_orders1_idx` (`orders_id`),
  CONSTRAINT `fk_delivery_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_basket`
--

DROP TABLE IF EXISTS `order_basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_basket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_basket_product1_idx` (`product_id`),
  KEY `fk_order_basket_user1_idx` (`user_id`),
  CONSTRAINT `fk_order_basket_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_order_basket_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_basket`
--

LOCK TABLES `order_basket` WRITE;
/*!40000 ALTER TABLE `order_basket` DISABLE KEYS */;
INSERT INTO `order_basket` VALUES (2,1,3,1),(4,3,4,1),(6,3,1,1),(7,2,1,1),(8,3,5,3),(9,2,5,3);
/*!40000 ALTER TABLE `order_basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_status` enum('Оплачено','Отмена','Ожидание','Обработка','Выполнен') NOT NULL,
  `user_id` int NOT NULL,
  `shipping_type` int NOT NULL,
  `city` varchar(155) DEFAULT NULL,
  `address` varchar(155) DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_user1_idx` (`user_id`),
  CONSTRAINT `fk_orders_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(155) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `description` longtext,
  `price` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `vendor_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_vendor1` (`vendor_id`),
  KEY `fk_product_category1` (`category_id`),
  CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_vendor1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Apple iPhone 13 Pro Max 128GB Vàng',' apple_iPhone_13_Pro_Max ','Đường chéo màn hình 6,7\", Độ phân giải màn hình 2778x128478х1284',44999,'284924180.jpg',1,1),(2,'Samsung Galaxy S9','samsung_Galaxy_S9',NULL,9000,'samsung_galaxy_s9.png',2,1),(3,'Áo choàng dài của phụ nữ','ao_choang_nu',NULL,560,'photo_2021-11-05_20-53-27.jpg',3,2),(4,'Tivi LG','LG_55qauhd ',NULL,800,'237518843.jpg',4,3),(5,'Tivi Samsung QE50Q60AAUXUA','tivi_ss_QE50','Màn hình chéo 50\", hỗ trợ Smart TV, Độ phân giải 3840x2160',23999,'279813767.jpg',2,3),(6,'Tivi LG 43UP81006LA','tivi_LG_43UP','Màn hình chéo 43\", hỗ trợ Smart TV, Độ phân giải 3840x2160',18999,'240234430.jpg',4,3),(7,'Tivi LG 50UP77006LB','tivi_LG_50UP','Màn hình chéo 50\", hỗ trợ Smart TV, Độ phân giải 3840x2160',17999,'237519282.jpg',4,3),(8,'Tivi Samsung UE58AU7100UXUA','tivi_samsung_UE58','Màn hình chéo 58\", hỗ trợ Smart TV, Độ phân giải 3840x2160',19500,'181479242.jpg',2,3),(9,'Điện thoại Apple iPhone 12 mini 128GB Xanh','apple_iPhone_12_mini_xanh','Màn hình (5.4\", OLED (Super Retina XDR), 2340x1080',24199,'284920851.jpg',1,1),(10,'Điện thoại Samsung Galaxy M52 5G 6/128GB Đen','Samsung_M52','Màn hình (6,7\", Super AMOLED Plus, 2400x1080) / Qualcomm Snapdragon 778G',12999,'samsung_galaxy_m52.png',2,1),(11,'Đánh bóng áo choàng nam 50-60','ao_choang_nam','Size 50-60, Màu sắc, bardot, đỏ',600,'img_5018.jpg',3,2),(14,'iphone 16','apple_iphone_16','<div><table><tbody><tr><td>Đường chéo màn hình 6,7\", Độ phân giải màn hình 2778x128478х1284</td></tr></tbody></table></div>',5,'152740976.jpg',1,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(155) NOT NULL,
  `password` varchar(155) NOT NULL,
  `role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2y$12$edo/8bJAnpSX43XKE8Abz.jbsCjw7qF83Gm2gtTBiaDnbOVV48ob2','ADMIN','nguyenhieu2802@gmail.com'),(2,'Dima','$2y$12$edo/8bJAnpSX43XKE8Abz.jbsCjw7qF83Gm2gtTBiaDnbOVV48ob2','USER','igorTop@gmail.com'),(3,'Natalia','$2y$12$edo/8bJAnpSX43XKE8Abz.jbsCjw7qF83Gm2gtTBiaDnbOVV48ob2','USER','darinkaApelsinka@gmail.com'),(4,'Aleks','$2y$12$edo/8bJAnpSX43XKE8Abz.jbsCjw7qF83Gm2gtTBiaDnbOVV48ob2','USER','MishaTop@gmail.com'),(5,'Hieuba','$2y$12$edo/8bJAnpSX43XKE8Abz.jbsCjw7qF83Gm2gtTBiaDnbOVV48ob2','USER','nguyenhieu28022003@gmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `user_info_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`user_info_id`),
  CONSTRAINT `fk_user_details_user1` FOREIGN KEY (`user_info_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'Hieu','Nguyen','0964970349','nguyenhieu2802@gmail.com'),(2,'Igor','Cheeeeeel','0907284523','igorTop@gmail.com'),(3,'Darina','ToKu','0972383452','darinkaApelsinka@gmail.com'),(4,'Misha','Mỉa','0983785834','MishaTop@gmail.com'),(5,'Hiếu','Nguyễn','0964970349','nguyenhieu28022003@gmail.com');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (1,'Apple'),(2,'Samsung'),(3,'Sandy'),(4,'LG'),(5,'Dell');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-12 13:01:49
