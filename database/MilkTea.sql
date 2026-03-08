-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: milktea
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE `milktea`;

-- Giải phóng lock nếu lần chạy trước bị giữ lại (tránh lỗi 1100 khi DROP TABLE)
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_don_hang`
--

DROP TABLE IF EXISTS `chi_tiet_don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_don_hang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `don_hang` int DEFAULT NULL,
  `san_pham` int DEFAULT NULL,
  `size` int DEFAULT 1,
  `soLuong` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang`
--

LOCK TABLES `chi_tiet_don_hang` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang` VALUES (1,1,1,2,1),(2,2,3,1,1),(3,2,5,3,1),(4,3,4,1,1),(5,4,14,3,1),(6,5,13,2,1),(7,6,10,1,1),(8,7,1,2,1),(9,7,2,1,1),(10,8,3,3,1),(11,8,6,1,1),(12,9,4,2,1),(13,9,5,3,1),(14,10,14,1,1),(15,10,13,2,1),(16,11,15,3,1),(17,11,10,1,1),(18,12,1,2,1),(19,12,2,3,1),(20,13,3,1,1),(21,13,6,2,1),(22,14,4,3,1),(23,14,5,1,1),(24,15,14,2,1),(25,15,13,3,1),(26,16,15,1,1),(27,16,10,2,1),(28,17,1,3,1),(29,17,2,1,1),(30,18,3,2,1),(31,18,6,3,1),(32,19,4,1,1),(33,19,5,2,1),(34,20,14,3,1),(35,20,13,1,1),(36,21,15,2,1),(37,21,10,3,1),(38,22,1,1,1),(39,22,2,2,1),(40,23,3,3,1),(41,23,6,1,1),(42,24,4,2,1),(43,24,5,3,1),(44,25,14,1,1),(45,25,13,2,1),(46,26,15,3,1),(47,26,10,1,1);
/*!40000 ALTER TABLE `chi_tiet_don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_don_hang_topping`
--

DROP TABLE IF EXISTS `chi_tiet_don_hang_topping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_don_hang_topping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chi_tiet_don_hang` int DEFAULT NULL,
  `topping` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chi_tiet_don_hang` (`chi_tiet_don_hang`),
  KEY `topping` (`topping`),
  CONSTRAINT `chi_tiet_don_hang_topping_ibfk_1` FOREIGN KEY (`chi_tiet_don_hang`) REFERENCES `chi_tiet_don_hang` (`id`),
  CONSTRAINT `chi_tiet_don_hang_topping_ibfk_2` FOREIGN KEY (`topping`) REFERENCES `topping` (`MaTopping`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_don_hang_topping`
--

LOCK TABLES `chi_tiet_don_hang_topping` WRITE;
/*!40000 ALTER TABLE `chi_tiet_don_hang_topping` DISABLE KEYS */;
INSERT INTO `chi_tiet_don_hang_topping` VALUES (1,7,1),(2,7,5),(3,8,2),(4,8,6),(5,9,6),(6,10,NULL),(7,11,2),(8,11,5),(9,12,3),(10,12,8),(11,13,6),(12,13,3),(13,14,2),(14,15,6),(15,15,3),(16,16,NULL),(17,17,1),(18,17,5),(19,18,2),(20,18,6),(21,19,6),(22,20,NULL),(23,21,2),(24,21,5),(25,22,3),(26,22,8),(27,23,6),(28,23,3),(29,24,2),(30,25,6),(31,25,3),(32,26,NULL),(33,27,1),(34,27,5),(35,28,2),(36,28,6),(37,29,6),(38,30,NULL),(39,31,2),(40,31,5),(41,32,3),(42,32,8),(43,33,6),(44,33,3),(45,34,2),(46,35,6),(47,35,3),(48,36,NULL),(49,37,1),(50,37,5),(51,38,2),(52,38,6),(53,39,6),(54,40,NULL),(55,41,2),(56,41,5),(57,42,3),(58,42,8),(59,43,6),(60,43,3),(61,44,2),(62,45,6),(63,45,3),(64,46,NULL);
/*!40000 ALTER TABLE `chi_tiet_don_hang_topping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_san_pham`
--

DROP TABLE IF EXISTS `chi_tiet_san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_san_pham` (
  `MaCTSP` int NOT NULL AUTO_INCREMENT,
  `MaSP` int DEFAULT NULL,
  `NguyenLieu` text COLLATE utf8mb4_unicode_ci,
  `HuongDanSuDung` text COLLATE utf8mb4_unicode_ci,
  `LoiIch` text COLLATE utf8mb4_unicode_ci,
  `GhiChu` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`MaCTSP`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `chi_tiet_san_pham_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `san_pham` (`MaSP`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_san_pham`
--

LOCK TABLES `chi_tiet_san_pham` WRITE;
/*!40000 ALTER TABLE `chi_tiet_san_pham` DISABLE KEYS */;
INSERT INTO `chi_tiet_san_pham` VALUES (1,1,'Trà Thái xanh, sữa đặc, sữa tươi, nước cốt dừa, đường, đá viên','Khuấy đều trước khi uống. Ngon hơn khi uống lạnh.','Giúp tỉnh táo, thư giãn và bổ sung năng lượng tức thì.','Thêm topping như trân châu đen, thạch rau câu hoặc pudding theo sở thích.'),(2,2,'Trà đen nguyên chất, sữa đặc, bột kem béo, đường cát','Ngon nhất khi uống lạnh. Không cần lắc.','Vị trà mạnh mẽ kết hợp độ béo vừa phải, giúp tỉnh táo và tạo cảm giác no lâu.','Phù hợp khi thưởng thức cùng bạn bè hoặc trong lúc làm việc.'),(3,3,'Bột Matcha Nhật Bản nguyên chất, sữa tươi không đường, bột kem béo, đường mía','Khuấy đều trước khi uống. Thưởng thức ngon hơn khi dùng lạnh hoặc đá xay.','Giàu chất chống oxy hóa, hỗ trợ tỉnh táo, giảm stress và làm đẹp da.','Không nên dùng khi đói vì matcha có thể gây cồn cào nhẹ với người nhạy cảm.'),(4,4,'Sữa tươi thanh trùng, khoai lang tím nghiền nhuyễn, kem béo thực vật, đường nâu','Uống lạnh. Khuấy đều trước khi dùng để cảm nhận trọn vẹn hương vị và độ mịn.','Giàu năng lượng, chứa vitamin A, chất xơ và chất chống oxy hóa từ khoai lang tím.','Hương vị độc đáo, màu sắc bắt mắt – xu hướng mới của giới trẻ yêu thích healthy drink.'),(5,5,'Trà đen đậm vị, bột cacao nguyên chất, sữa tươi, kem tươi, đường mía','Uống lạnh để cảm nhận rõ vị cacao hoà quyện cùng trà. Dùng kèm topping sẽ ngon hơn.','Tăng cường dopamine, kích thích vị giác và cải thiện tâm trạng hiệu quả.','Hạn chế uống cùng đồ ăn mặn để tránh làm mất hương vị đặc trưng.'),(6,6,'Cà phê đen nguyên chất pha phin truyền thống, sữa đặc có đường, đá viên','Thưởng thức ngay sau khi pha. Khuấy đều trước khi uống để hương vị hoà quyện.','Giúp tỉnh táo, tăng khả năng tập trung và nâng cao hiệu suất làm việc.','Không nên uống khi bụng đói hoặc vào buổi tối để tránh mất ngủ.'),(7,7,'Sữa đặc có đường, một chút cà phê phin, sữa tươi, đá viên','Uống lạnh. Khuấy đều trước khi dùng để vị cà phê và sữa hoà quyện.','Giúp tỉnh nhẹ, tạo cảm giác thư giãn và dễ chịu.','Phù hợp với người mới bắt đầu uống cà phê hoặc yêu thích vị ngọt dịu.'),(8,8,'Cà phê đen nguyên chất pha phin, nước nóng, đá viên','Uống lạnh. Có thể thêm ít đường nếu cần, nhưng không dùng sữa.','Tỉnh táo tức thì, kích thích trí não và tăng khả năng tập trung cao độ.','Phù hợp với người yêu thích vị đắng mạnh mẽ và thuần khiết của cà phê.'),(9,9,'Chanh muối lâu năm, nước lọc tinh khiết, đá viên','Dùng lạnh để đạt hiệu quả giải nhiệt tối đa. Khuấy nhẹ trước khi uống.','Bổ sung điện giải tự nhiên, hỗ trợ thanh lọc cơ thể và hồi phục năng lượng nhanh chóng.','Không khuyến khích dùng khi đau dạ dày hoặc đang viêm họng do có vị mặn và chua.'),(10,10,'Cam tươi nguyên chất, đường (nếu cần)','Lắc đều hoặc khuấy nhẹ trước khi uống để vị cam được hoà quyện.','Bổ sung vitamin C tự nhiên, tăng cường sức đề kháng và hỗ trợ làm đẹp da.','Ngon nhất khi uống lạnh với đá viên, thích hợp cho bữa sáng hoặc giải khát mùa hè.'),(11,11,'Dứa tươi, sữa đặc có đường, đá viên, một ít đường (tùy khẩu vị)','Xay nhuyễn rồi thưởng thức lạnh, có thể thêm đá nếu thích.','Giàu vitamin C, enzyme tự nhiên giúp tăng cường hệ tiêu hoá và làm đẹp da.','Tránh uống khi đói vì tính axit có thể gây kích ứng dạ dày.'),(12,12,'Bơ chín, sữa đặc, sữa tươi, đá viên','Xay nhuyễn và thưởng thức ngay khi còn lạnh để giữ được độ mượt mà của bơ.','Cung cấp chất béo tốt, vitamin E và các dưỡng chất thiết yếu cho cơ thể.','Lý tưởng cho bữa sáng nhẹ, cung cấp năng lượng dài lâu mà không gây no quá mức.'),(13,13,'Sữa tươi không đường, trân châu đen, sốt đường đen, đá viên','Lắc đều để sốt đường đen hòa quyện với sữa, thưởng thức ngay khi còn lạnh.','Vị ngọt thơm mát, giúp giải khát và tạo cảm giác no lâu.','Không nên dùng quá nhiều topping để tránh ảnh hưởng đến cân nặng.'),(14,14,'Trà đen, sữa tươi không đường, kem phô mai tươi nướng, đường, đá viên','Dùng lạnh, khuấy nhẹ để lớp phô mai hòa quyện cùng trà sữa.','Bổ sung canxi và protein, vị béo mặn nhẹ giúp cân bằng vị giác.','Nên thưởng thức ngay sau khi rót ra để giữ độ thơm béo của phô mai nướng.'),(15,15,'Trà đen, sữa đặc, sữa tươi, kem trứng đánh bông, lớp caramel cháy','Khuấy đều phần kem trứng trước khi uống để hoà quyện hương vị. Uống lạnh là ngon nhất.','Giàu năng lượng, béo thơm đậm đà, tạo cảm giác \"nâng mood\" liền tay.','Không nên để lâu vì lớp caramel sẽ tan mất chất lượng ban đầu.');
/*!40000 ALTER TABLE `chi_tiet_san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc`
--

DROP TABLE IF EXISTS `danh_muc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danh_muc` (
  `MaDM` int NOT NULL AUTO_INCREMENT,
  `TenDM` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`MaDM`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc`
--

LOCK TABLES `danh_muc` WRITE;
/*!40000 ALTER TABLE `danh_muc` DISABLE KEYS */;
INSERT INTO `danh_muc` VALUES (1,'Trà sữa'),(2,'Cà phê'),(3,'Nước trái cây'),(4,'Đồ uống đặc biệt');
/*!40000 ALTER TABLE `danh_muc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `don_hang`
--

DROP TABLE IF EXISTS `don_hang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `don_hang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `MaND` int DEFAULT NULL,
  `ten` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diachi` text COLLATE utf8mb4_unicode_ci,
  `sdt` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ngaydat` datetime DEFAULT NULL,
  `voucher` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tongTien` decimal(10,0) DEFAULT NULL,
  `status` int DEFAULT 0 COMMENT '0=Chờ order, 1=Đã xác nhận, 2=Pha chế xong, 3=Đã thanh toán',
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `discount_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `don_hang`
--

LOCK TABLES `don_hang` WRITE;
/*!40000 ALTER TABLE `don_hang` DISABLE KEYS */;
INSERT INTO `don_hang` (`id`,`MaND`,`ten`,`diachi`,`sdt`,`ngaydat`,`voucher`,`tongTien`,`status`,`discount_amount`,`discount_type`,`discount_value`) VALUES (1,NULL,'Nguyễn Thị Mai','123 Đường Láng, Đống Đa, Hà Nội','0987654321','2025-05-14 09:15:00','NEWCUST10',459000,1,NULL,NULL,NULL),(2,NULL,'Trần Văn An','456 Minh Khai, Hai Bà Trưng, Hà Nội','0912345678','2025-05-14 10:20:00',NULL,115000,0,NULL,NULL,NULL),(3,NULL,'Lê Hoàng','12A Nguyễn Trãi, Thanh Xuân, Hà Nội','0901122334','2025-05-13 18:40:00',NULL,49000,2,NULL,NULL,NULL),(4,NULL,'Phạm Quỳnh Trang','89 Phố Huế, Hoàn Kiếm, Hà Nội','0977888999','2025-05-14 14:05:00','VIP30',476000,1,NULL,NULL,NULL),(5,NULL,'Đỗ Minh Đức','27 Kim Mã, Ba Đình, Hà Nội','0988997766','2025-05-14 11:10:00',NULL,54000,0,NULL,NULL,NULL),(6,NULL,'Hoàng Anh','Số 9, Trần Duy Hưng, Cầu Giấy, Hà Nội','0966668888','2025-05-14 11:58:00',NULL,34000,0,NULL,NULL,NULL),(7,NULL,'Nguyễn Văn An','123 Đường Láng, Đống Đa, Hà Nội','0987654321','2025-05-15 08:30:00','NEWCUST10',135000,2,15000.00,'PERCENT',10.00),(8,NULL,'Trần Thị Bình','456 Minh Khai, Hai Bà Trưng, Hà Nội','0912345678','2025-05-15 09:15:00','SUMMER15',204000,2,36000.00,'PERCENT',15.00),(9,NULL,'Lê Văn Cường','789 Nguyễn Trãi, Thanh Xuân, Hà Nội','0901122334','2025-05-15 10:00:00','VIP30',245000,2,105000.00,'PERCENT',30.00),(10,NULL,'Phạm Thị Dung','321 Kim Mã, Ba Đình, Hà Nội','0977888999','2025-05-15 11:30:00','FLASH100K',180000,2,100000.00,'VALUE',100000.00),(11,NULL,'Hoàng Văn Em','654 Trần Duy Hưng, Cầu Giấy, Hà Nội','0988997766','2025-05-15 12:45:00','FLASH100K',150000,2,100000.00,'VALUE',100000.00),(12,NULL,'Đỗ Thị Phương','987 Phố Huế, Hoàn Kiếm, Hà Nội','0966668888','2025-05-15 13:20:00',NULL,115000,2,NULL,NULL,NULL),(13,NULL,'Nguyễn Văn Giang','147 Lê Văn Lương, Thanh Xuân, Hà Nội','0955557777','2025-05-15 14:10:00',NULL,95000,2,NULL,NULL,NULL),(14,NULL,'Trần Thị Hương','258 Đội Cấn, Ba Đình, Hà Nội','0944446666','2025-05-15 15:00:00',NULL,145000,2,NULL,NULL,NULL),(15,NULL,'Lê Văn Hùng','369 Nguyễn Khang, Cầu Giấy, Hà Nội','0933335555','2025-05-15 16:30:00',NULL,125000,2,NULL,NULL,NULL),(16,NULL,'Phạm Thị Khanh','741 Láng Hạ, Đống Đa, Hà Nội','0922224444','2025-05-15 17:15:00',NULL,165000,2,NULL,NULL,NULL),(17,NULL,'Hoàng Văn Long','852 Nguyễn Chí Thanh, Đống Đa, Hà Nội','0911113333','2025-05-15 18:00:00',NULL,135000,2,NULL,NULL,NULL),(18,NULL,'Đỗ Thị Mai','963 Đại Cồ Việt, Hai Bà Trưng, Hà Nội','0900002222','2025-05-15 19:30:00',NULL,155000,2,NULL,NULL,NULL),(19,NULL,'Nguyễn Văn Nam','159 Tây Sơn, Đống Đa, Hà Nội','0899991111','2025-05-15 20:15:00',NULL,175000,2,NULL,NULL,NULL),(20,NULL,'Trần Thị Oanh','357 Nguyễn Văn Cừ, Long Biên, Hà Nội','0888880000','2025-05-15 21:00:00',NULL,195000,2,NULL,NULL,NULL),(21,NULL,'Lê Văn Phúc','753 Nguyễn Văn Linh, Long Biên, Hà Nội','0877779999','2025-05-15 22:30:00',NULL,185000,2,NULL,NULL,NULL),(22,NULL,'Phạm Thị Quỳnh','951 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội','0866668888','2025-05-15 23:15:00',NULL,205000,2,NULL,NULL,NULL),(23,NULL,'Hoàng Văn Rạng','852 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội','0855557777','2025-05-16 00:00:00',NULL,215000,2,NULL,NULL,NULL),(24,NULL,'Đỗ Thị Sương','741 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội','0844446666','2025-05-16 01:30:00',NULL,225000,2,NULL,NULL,NULL),(25,NULL,'Nguyễn Văn Tú','963 Nguyễn Văn Huyên, Cầu Giấy, Hà Nội','0833335555','2025-05-16 02:15:00',NULL,235000,2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `don_hang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kho`
--

DROP TABLE IF EXISTS `kho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kho` (
  `maNguyenLieu` int NOT NULL AUTO_INCREMENT,
  `tenNguyenLieu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soLuong` decimal(10,2) NOT NULL DEFAULT '0.00',
  `donViTinh` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngayNhap` date NOT NULL,
  `hanSuDung` date DEFAULT NULL,
  `maNhaCungCap` int DEFAULT NULL,
  `ghiChu` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`maNguyenLieu`),
  KEY `maNhaCungCap` (`maNhaCungCap`),
  CONSTRAINT `kho_ibfk_1` FOREIGN KEY (`maNhaCungCap`) REFERENCES `nhacungcap` (`maNhaCungCap`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kho`
--

LOCK TABLES `kho` WRITE;
/*!40000 ALTER TABLE `kho` DISABLE KEYS */;
INSERT INTO `kho` VALUES (1,'Trà Ô Long',50.00,'gram','2025-05-10','2025-12-10',1,'Dùng pha trà sữa Ô Long'),(2,'Sữa tươi không đường',100.00,'lít','2025-05-12','2025-06-12',2,'Sữa tươi Vinamilk'),(3,'Bột kem béo Indo',75.00,'kg','2025-05-09','2026-01-01',3,'Tạo độ béo cho sữa'),(4,'Trà đen Bá Tước',40.00,'gram','2025-05-05','2025-10-01',1,'Thích hợp cho milk tea truyền thống'),(5,'Trân châu đen',20.00,'kg','2025-05-11','2025-06-11',5,'Luộc trước khi dùng'),(6,'Đường trắng tinh luyện',60.00,'kg','2025-05-01','2025-08-20',7,'Đường mía An Giang'),(7,'Syrup Dâu',25.00,'lít','2025-05-08','2025-09-08',8,'Dùng cho trà sữa dâu'),(8,'Syrup Bạc Hà',15.00,'lít','2025-05-10','2025-10-10',8,'Tạo hương bạc hà mát lạnh'),(9,'Chai nhựa 500ml',200.00,'chai','2025-05-03','2025-06-12',9,'Đựng trà mang đi'),(10,'Ly nhựa 700ml',500.00,'ly','2025-05-06','2025-08-12',10,'Ly dùng cho trà sữa size lớn');
/*!40000 ALTER TABLE `kho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nguoi_dung`
--

DROP TABLE IF EXISTS `nguoi_dung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nguoi_dung` (
  `MaND` int NOT NULL AUTO_INCREMENT,
  `HoTen` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `TenDangNhap` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MatKhau` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SoDienThoai` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MaQuyen` int DEFAULT NULL,
  `DiaChi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AnhDaiDien` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xacThucToken` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otpCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TrangThai` tinyint(1) DEFAULT '1',
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MaND`),
  UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  KEY `MaQuyen` (`MaQuyen`),
  CONSTRAINT `nguoi_dung_ibfk_1` FOREIGN KEY (`MaQuyen`) REFERENCES `phan_quyen` (`MaQuyen`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nguoi_dung`
--

LOCK TABLES `nguoi_dung` WRITE;
/*!40000 ALTER TABLE `nguoi_dung` DISABLE KEYS */;
INSERT INTO `nguoi_dung` VALUES (1,'Trần Kiên Cường','chuquan01','123','trankiencuong30072003@gmail.com','0369702376',1,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(2,'Nguyễn Minh Dũng','quanly1','123','nguyenminhdung@gmail.com','0907654321',2,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(3,'Nguyễn Thành Đạt','order01','123','nguyenthanhdat@gmail.com','0912834502',3,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(4,'Nguyễn Quyền Linh','thungan01','123','nguyenquyenlinh@gmail.com','0928046281',4,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(5,'Nguyễn Thị Dung','phache01','123','nguyenthidung@gmail.com','0396225584',5,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(6,'Nguyễn Thị Như','kho01','123','nguyenthinhu@gmail.com','0942784793',6,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54'),(7,'Hoàng Thị Loan','khach01','123','hoangthiloan@gmail.com','0982654335',7,'Hà Nội','/resources/images/avatars/users-icon.jpg',NULL,NULL,1,'2025-06-21 09:39:54');
/*!40000 ALTER TABLE `nguoi_dung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhacungcap`
--

DROP TABLE IF EXISTS `nhacungcap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhacungcap` (
  `maNhaCungCap` int NOT NULL AUTO_INCREMENT,
  `TenNhaCungCap` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diaChi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soDienThoai` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`maNhaCungCap`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhacungcap`
--

LOCK TABLES `nhacungcap` WRITE;
/*!40000 ALTER TABLE `nhacungcap` DISABLE KEYS */;
INSERT INTO `nhacungcap` VALUES (1,'Công ty TNHH Trà Xanh Việt','12 Lê Văn Sỹ, Quận 3, TP.HCM','0909123456'),(2,'Sữa Tươi Thanh Long','88 Nguyễn Trãi, Hà Nội','0911223344'),(3,'Thực Phẩm Đại Hưng','23 Nguyễn Đình Chiểu, Đà Nẵng','0909112233'),(4,'Nguyên Liệu Hòa Phát','56 Trường Chinh, Hà Nội','0977888999'),(5,'Trân Châu QueenPearl','71 Hoàng Văn Thụ, TP.HCM','0933445566'),(6,'Công ty Hương Liệu Hương Việt','109 Phan Xích Long, TP.HCM','0988997788'),(7,'Đường Mía An Giang','Thị trấn Chợ Mới, An Giang','0966554433'),(8,'Syrup & Topping Phúc Lộc','5A Lý Tự Trọng, Cần Thơ','0944332211'),(9,'Chai Nhựa Bình Minh','123 CMT8, Quận 10, TP.HCM','0911002200'),(10,'Bao Bì Việt Long','15B Trần Quang Khải, Hà Nội','0933221144');
/*!40000 ALTER TABLE `nhacungcap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phan_quyen`
--

DROP TABLE IF EXISTS `phan_quyen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phan_quyen` (
  `MaQuyen` int NOT NULL AUTO_INCREMENT,
  `TenQuyen` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`MaQuyen`),
  UNIQUE KEY `TenQuyen` (`TenQuyen`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phan_quyen`
--

LOCK TABLES `phan_quyen` WRITE;
/*!40000 ALTER TABLE `phan_quyen` DISABLE KEYS */;
INSERT INTO `phan_quyen` VALUES (1,'Chủ quán'),(7,'Khách hàng'),(6,'Nhân viên kho'),(3,'Nhân viên order'),(5,'Nhân viên pha chế'),(4,'Nhân viên thu ngân'),(2,'Quản lý');
/*!40000 ALTER TABLE `phan_quyen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `san_pham`
--

DROP TABLE IF EXISTS `san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `san_pham` (
  `MaSP` int NOT NULL AUTO_INCREMENT,
  `TenSP` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DonGia` decimal(10,2) NOT NULL,
  `MaDM` int DEFAULT NULL,
  `MoTa` text COLLATE utf8mb4_unicode_ci,
  `HinhAnh` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SoLuong` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TrangThai` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`MaSP`),
  KEY `MaDM` (`MaDM`),
  CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`MaDM`) REFERENCES `danh_muc` (`MaDM`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `san_pham`
--

LOCK TABLES `san_pham` WRITE;
/*!40000 ALTER TABLE `san_pham` DISABLE KEYS */;
INSERT INTO `san_pham` VALUES (1,'Trà Sữa Thái Xanh',30000.00,1,'Trà sữa đậm vị Thái, ngọt dịu và thơm mùi sữa','thai-xanh.jpg','100',1),(2,'Trà Sữa Hồng Kông',32000.00,1,'Trà sữa vị Hồng Kông truyền thống, béo ngậy','hong-kong.jpg','100',1),(3,'Trà Xanh Nhật Bản',35000.00,1,'Matcha Nhật Bản nguyên chất, thanh mát','matcha.jpg','100',1),(4,'Trà Sữa Khoai Lang',33000.00,1,'Trà sữa kết hợp vị khoai lang tím béo mịn','khoai-lang.jpg','100',1),(5,'Trà Sữa Socola',34000.00,1,'Trà sữa đậm đà cùng socola nguyên chất, thơm ngon khó cưỡng','socola.jpg','100',1),(6,'Cà Phê Sữa Đá',25000.00,2,'Cà phê pha phin, sữa đặc, đậm đà và thơm lừng','cafe-sua.jpg','100',1),(7,'Bạc Xỉu',27000.00,2,'Sữa nhiều hơn cà phê, thích hợp cho người mê ngọt','bac-xiu.jpg','100',1),(8,'Cà Phê Đen Đá',22000.00,2,'Cà phê nguyên chất, không đường, vị đắng mạnh mẽ','cafe-den.jpg','100',1),(9,'Nước Chanh Muối',20000.00,3,'Chanh muối thanh mát, giải khát mùa hè','chanh-muoi.jpg','100',1),(10,'Nước Cam Ép',24000.00,3,'Cam tươi nguyên chất, cung cấp vitamin C','cam-ep.jpg','100',1),(11,'Sinh Tố Dứa',27000.00,3,'Sinh tố dứa tươi, chua nhẹ và mát lạnh','sinh-to-dua.jpg','100',1),(12,'Sinh Tố Bơ',29000.00,3,'Sinh tố bơ béo ngậy, thơm ngon','sinh-to-bo.jpg','100',1),(13,'Sữa Tươi Trân Châu Đường Đen',36000.00,1,'Sữa tươi kết hợp trân châu dẻo và sốt đường đen thơm lừng','sua-tuoi-tran-chau-duong-den.jpg','100',1),(14,'Trà Sữa Phô Mai Tươi Nướng',38000.00,4,'Trà sữa đậm vị kết hợp với topping phô mai tươi nướng thơm lừng, béo ngậy và độc đáo.','tra-sua-pho-mai-tuoi-nuong.jpg','100',1),(15,'Trà Sữa Kem Trứng Cháy',38000.00,4,'Trà sữa hòa quyện cùng lớp kem trứng cháy béo ngậy, thơm lừng, ngọt ngào khó cưỡng','tra-sua-kem-trung-chay.jpg','100',1);
/*!40000 ALTER TABLE `san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size_san_pham`
--

DROP TABLE IF EXISTS `size_san_pham`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size_san_pham` (
  `MaSize` int NOT NULL AUTO_INCREMENT,
  `TenSize` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `HeSoGia` decimal(3,2) DEFAULT '1.00',
  PRIMARY KEY (`MaSize`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size_san_pham`
--

LOCK TABLES `size_san_pham` WRITE;
/*!40000 ALTER TABLE `size_san_pham` DISABLE KEYS */;
INSERT INTO `size_san_pham` VALUES (1,'M',1.00),(2,'L',1.20),(3,'XL',1.50);
/*!40000 ALTER TABLE `size_san_pham` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topping`
--

DROP TABLE IF EXISTS `topping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topping` (
  `MaTopping` int NOT NULL AUTO_INCREMENT,
  `TenTopping` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DonGia` decimal(10,2) NOT NULL,
  `TrangThai` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`MaTopping`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topping`
--

LOCK TABLES `topping` WRITE;
/*!40000 ALTER TABLE `topping` DISABLE KEYS */;
INSERT INTO `topping` VALUES (1,'Trân Châu Trắng',5000.00,1),(2,'Trân Châu Đường Đen',6000.00,1),(3,'Pudding Trứng',7000.00,1),(4,'Thạch Cà Phê',5000.00,1),(5,'Thạch Dừa',4000.00,1),(6,'Kem Cheese',8000.00,1),(7,'Đậu Xanh',5000.00,1),(8,'Marshmallow',6000.00,1);
/*!40000 ALTER TABLE `topping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ma` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ten` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mota` text COLLATE utf8mb4_unicode_ci,
  `ngaybatdau` datetime DEFAULT NULL,
  `ngayketthuc` datetime DEFAULT NULL,
  `phantramgiamgia` decimal(10,0) DEFAULT NULL,
  `giatrigiamgia` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (1,'NEWCUST10','Giảm 10% cho khách mới','Chương trình khuyến mãi dành cho khách hàng đăng ký lần đầu','2026-01-01 00:00:00','2026-12-31 23:59:59',10,NULL),(2,'SUMMER15','Ưu đãi hè 15%','Giảm giá toàn bộ đơn hàng vào tháng 6','2026-06-01 00:00:00','2026-06-30 23:59:59',15,NULL),(3,'VIP30','Voucher VIP giảm 30%','Chỉ áp dụng cho khách hàng VIP hạng Vàng trở lên','2026-03-01 00:00:00','2026-08-31 23:59:59',30,NULL),(4,'FLASH100K','Flash Sale giảm 100K','Giảm ngay 100.000đ cho 100 đơn đầu tiên mỗi ngày','2026-05-01 00:00:00','2026-05-31 23:59:59',NULL,100000),(5,'TETSALE','Tết Rộn Ràng – Giảm 20%','Áp dụng cho tất cả đơn hàng từ 20/01 đến 30/01','2026-01-20 00:00:00','2026-01-30 23:59:59',20,NULL);
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_gia`
--

DROP TABLE IF EXISTS `danh_gia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `danh_gia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `MaSP` int NOT NULL,
  `Diem` tinyint NOT NULL COMMENT '1-5 sao',
  `NoiDung` text COLLATE utf8mb4_unicode_ci,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `MaND` (`MaND`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoi_dung` (`MaND`) ON DELETE CASCADE,
  CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `san_pham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_gia`
--

LOCK TABLES `danh_gia` WRITE;
/*!40000 ALTER TABLE `danh_gia` DISABLE KEYS */;
INSERT INTO `danh_gia` VALUES (1,7,1,5,'Trà sữa Thái xanh rất ngon, vị thanh mát, sẽ ủng hộ dài dài!','2026-03-01 10:00:00'),(2,1,1,4,'Sản phẩm ổn, giá hợp lý.','2026-03-02 11:30:00'),(3,2,1,5,'Điểm 5 sao cho trà sữa này.','2026-03-03 09:15:00'),(4,7,2,4,'Trà sữa Hồng Kông đậm vị, béo ngậy.','2026-03-04 14:20:00'),(5,7,3,5,'Matcha Nhật Bản chuẩn vị, rất thích!','2026-03-05 16:45:00'),(6,3,1,5,'Chủ quán làm trà sữa ngon lắm, khách nào cũng khen.','2026-03-06 08:20:00'),(7,4,2,4,'Quản lý thường order món này cho nhân viên, ai cũng thích.','2026-03-06 09:15:00'),(8,5,3,5,'Matcha pha chuẩn, màu đẹp vị đậm.','2026-03-06 10:30:00'),(9,6,4,4,'Trà sữa khoai lang lạ miệng, béo mịn.','2026-03-06 11:00:00'),(10,7,5,5,'Trà sữa socola đậm đà, con nhỏ rất thích.','2026-03-06 14:00:00'),(11,1,6,5,'Cà phê sữa đá đúng vị phin, sáng nào cũng uống.','2026-03-07 07:30:00'),(12,2,7,4,'Bạc xỉu ngọt vừa, hợp người không quen đắng.','2026-03-07 08:45:00'),(13,3,8,5,'Cà phê đen đá tỉnh táo, nhân viên order hay gọi.','2026-03-07 10:00:00'),(14,4,9,5,'Chanh muối giải nhiệt, mùa hè uống rất đã.','2026-03-07 11:20:00'),(15,5,10,4,'Nước cam ép tươi, vitamin C đầy đủ.','2026-03-07 13:00:00'),(16,6,11,5,'Sinh tố dứa chua mát, rất hợp trưa nắng.','2026-03-07 14:30:00'),(17,7,12,5,'Sinh tố bơ béo ngậy, bữa sáng no lâu.','2026-03-07 16:00:00'),(18,1,13,4,'Sữa trân châu đường đen đúng trend, giới trẻ thích.','2026-03-08 09:00:00'),(19,2,14,5,'Trà sữa phô mai nướng đặc sản quán, ai đến cũng gọi.','2026-03-08 10:15:00'),(20,3,15,5,'Kem trứng cháy béo thơm, ăn kèm trà sữa tuyệt.','2026-03-08 11:30:00'),(21,4,1,5,'Trà Thái xanh bán chạy nhất quán.','2026-03-08 12:00:00'),(22,5,6,4,'Cà phê sữa đá phục vụ nhanh, chất lượng ổn định.','2026-03-08 13:45:00'),(23,6,9,5,'Chanh muối mát lạnh, khách về nóng hay ghé mua.','2026-03-08 15:00:00'),(24,7,14,4,'Phô mai nướng hơi ngọt nhưng vẫn ngon.','2026-03-08 16:20:00'),(25,1,4,4,'Khoai lang tím béo, hợp khẩu vị người lớn.','2026-03-08 17:00:00');
/*!40000 ALTER TABLE `danh_gia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `binh_luan`
--

DROP TABLE IF EXISTS `binh_luan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `binh_luan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `MaSP` int NOT NULL,
  `NoiDung` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `MaND` (`MaND`),
  KEY `MaSP` (`MaSP`),
  CONSTRAINT `binh_luan_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoi_dung` (`MaND`) ON DELETE CASCADE,
  CONSTRAINT `binh_luan_ibfk_2` FOREIGN KEY (`MaSP`) REFERENCES `san_pham` (`MaSP`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `binh_luan`
--

LOCK TABLES `binh_luan` WRITE;
/*!40000 ALTER TABLE `binh_luan` DISABLE KEYS */;
INSERT INTO `binh_luan` VALUES (1,7,1,'Mình order size L, uống vừa phải, không quá ngọt. Recommend!','2026-03-01 10:05:00'),(2,1,1,'Cửa hàng ship nhanh, trà sữa còn mát.','2026-03-02 12:00:00'),(3,2,1,'Lần sau sẽ thử thêm topping trân châu.','2026-03-03 09:30:00'),(4,7,2,'Trà Hồng Kông hợp với đá ít đường.','2026-03-04 15:00:00'),(5,3,1,'Khách hay hỏi món này, mình cũng thích uống.','2026-03-06 08:25:00'),(6,4,2,'Thu ngân recommend món này cho khách mới, feedback tốt.','2026-03-06 09:20:00'),(7,5,3,'Pha matcha đúng công thức là ra vị chuẩn như này.','2026-03-06 10:35:00'),(8,6,4,'Khoai lang tím nhập về tươi, trà sữa ra màu đẹp.','2026-03-06 11:05:00'),(9,7,5,'Cho thêm trân châu đen vào trà socola rất hợp.','2026-03-06 14:10:00'),(10,1,6,'Sáng order cà phê sữa đá mang đi, tiện.','2026-03-07 07:45:00'),(11,2,7,'Bạc xỉu ít đá uống lâu hơn.','2026-03-07 08:50:00'),(12,3,8,'Cà phê đen không đường đúng gu mình.','2026-03-07 10:05:00'),(13,4,9,'Chanh muối order cho cả văn phòng, ai cũng khen.','2026-03-07 11:25:00'),(14,5,10,'Cam ép không đường vẫn ngọt tự nhiên.','2026-03-07 13:10:00'),(15,6,11,'Sinh tố dứa nên uống lạnh mới ngon.','2026-03-07 14:35:00'),(16,7,12,'Sinh tố bơ no lắm, uống xong bỏ bữa trưa luôn.','2026-03-07 16:05:00'),(17,1,13,'Trân châu đường đen dẻo vừa, không cứng.','2026-03-08 09:10:00'),(18,2,14,'Phô mai nướng nên uống ngay khi còn nóng lớp trên.','2026-03-08 10:20:00'),(19,3,15,'Kem trứng cháy ngọt béo, hôm nào mệt uống cái là phê.','2026-03-08 11:35:00'),(20,7,3,'Matcha size L uống cả ngày không chán.','2026-03-08 16:25:00'),(21,1,14,'Quán làm phô mai nướng đúng kiểu Hàn, đã thử nhiều chỗ rồi.','2026-03-08 17:05:00');
/*!40000 ALTER TABLE `binh_luan` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- Bổ sung cột MaND cho đơn hàng (chạy thủ công nếu bảng đã tồn tại trước khi thêm cột)
-- ALTER TABLE `don_hang` ADD COLUMN `MaND` int DEFAULT NULL COMMENT 'Khách hàng đặt' AFTER `id`;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-08 10:25:06
