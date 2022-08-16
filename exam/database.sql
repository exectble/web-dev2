-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_1947_exam2
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

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

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('195d604305dc');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genres`
--

DROP TABLE IF EXISTS `book_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`book_id`,`genre_id`),
  KEY `fk_book_genres_genre_id_genres` (`genre_id`),
  KEY `fk_book_genres_book_id_books` (`book_id`),
  CONSTRAINT `fk_book_genres_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_book_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genres`
--

LOCK TABLES `book_genres` WRITE;
/*!40000 ALTER TABLE `book_genres` DISABLE KEYS */;
INSERT INTO `book_genres` VALUES (78,76,1),(76,74,5),(77,75,5),(79,77,5);
/*!40000 ALTER TABLE `book_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `short_description` text NOT NULL,
  `year` int(11) NOT NULL,
  `publishing_house` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `pages` int(11) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (74,'1984','«1984» – это роман о том, как репрессивная машина тоталитарного государства может уничтожить любую личность. Даже Смит, который до последнего сопротивлялся тирании, в конце концов сдался. Сначала его уничтожили физически (в прямом смысле слова – он начал терять зубы и т. д.). Затем он, наконец, лишился своих убеждений. ',1949,'Secker and Warburg','Джордж Оруэлл[',320,0,0,'2022-08-16 18:54:42'),(75,'Унесенные ветром','Апрель 1861 г. Плантация Тара, раскинувшаяся в двадцати пяти милях от Атланты, штат Джорджия.\n\nБлизнецы Тарлтоны, Стюарт и Брент, влюблённые в очаровательную дочь хозяина Тары, шестнадцатилетнюю Скарлетт, сообщают ей две новости. Во-первых, вот-вот начнётся война между Севером и Югом. Во-вторых, Эшли Уилкс женится на Мелани Гамильтон, о чем будет объявлено завтра, когда в доме Уилксов состоится большой приём.\n\nВести о надвигающейся войне для Скарлетт — ничто по сравнению с сообщением о женитьбе Эшли. Предмет воздыхании чуть ли не всех молодых людей округи, Скарлетт сама любит только Эшли, который, как ей кажется, и сам к ней неравнодушен. Она не может взять в толк, что он нашёл в Мелани, этом самом настоящем синем чулке.\n\nСкарлетт делится своими переживаниями с отцом, но Джералд О’Хара убеждён, что его дочь и Эшли отнюдь не идеальная пара. ',1936,'Маргарет Митчелл','Маргарет Митчелл',640,0,0,'2022-08-16 18:58:19'),(76,'Маленький принц','Повествование ведется от первого лица — летчика, которому повстречался Маленький принц. Экзюпери отчасти наделяет его своими чертами. Он также использует в сюжете эпизод из собственной биографии. В 1935 году писатель предпринял попытку поставить мировой рекорд при перелете Париж–Сайгон, но потерпел аварию в Ливийской пустыне. С похожей истории начинается и повесть-сказка Экзюпери «Маленький принц». Краткое содержание стоит начать с рассказа героя о своем детстве. Будучи шестилетним мальчиком, он прочитал о том, как удав целиком заглатывает свою жертву. Этот факт сильно впечатлил ребенка, и он нарисовал удава, который проглотил слона. Такая картинка совсем не понравилась взрослым, они посоветовали больше не рисовать змей и заняться учебой. Герой вырастает, становится летчиком и во время одного из перелетов совершает вынужденную посадку в пустыне Сахара из-за поломки двигателя. Пилот весь день безуспешно пытается починить мотор самолета и засыпает среди бесконечных песков. Утром он его будит маленький мальчик. Читайте больше: https://www.nur.kz/family/school/1850741-malenkij-princ-kratkoe-soderzanie-i-analiz/',1943,'Антуан де Сент-Экзюпери','Антуан де Сент-Экзюпери',104,0,0,'2022-08-16 19:00:20'),(77,'Крестный отец','Вито Андолини было двенадцать лет, когда убили его отца, не поладившего с сицилийской мафией. Поскольку мафия охотится и за сыном, Вито отсылают в Америку. Там он меняет фамилию на Корлеоне — по названию деревни, откуда он родом. Юный Вито поступает работать в бакалейную лавку Аббандандо. В восемнадцать лет он женится, и на третий год брака у него появляется сын Сантино, которого все ласково называют Сонни, а затем и другой — Фредерико, Фредди.\n\nФануччи — гангстер, вымогающий деньги у лавочников, — пристраивает на место Вито своего племянника, оставив Вито без работы, и Вито вынужден присоединиться к своему приятелю Клеменце и его сообщнику Тессио, которые устраивают налёты на грузовики с шёлковыми платьями, — иначе его семья умрёт от голода. Когда же Фануччи требует свою часть от вырученных на этом денег, Вито, тщательно все рассчитав, хладнокровно убивает его. Это делает Вито уважаемым человеком в квартале. Клиентура Фануччи переходит к нему. В конце концов он основывает на пару со своим другом Дженко Аббандандо торговый дом по ввозу оливкового масла. Лавочниками, которые не желают запасаться их маслом, занимаются Клеменца и Тессио — пылают склады, умирают люди... Во времена сухого закона под прикрытием торгового дома Вито занимается контрабандой спиртного, после отмены сухого закона переходит на игорный бизнес. Все больше и больше людей работает на него, и каждому Вито Корлеоне обеспечивает безбедную жизнь и защиту от полиции. К его имени начинают прибавлять слово «дон», его уважительно именуют Крестным отцом.',1969,'Марио Пьюзо','Марио Пьюзо',540,0,0,'2022-08-16 19:08:27');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(100) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `object_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_covers_md5_hash` (`md5_hash`),
  KEY `fk_covers_book_id_books` (`book_id`),
  CONSTRAINT `fk_covers_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES ('10827aad-2543-443c-ae03-cbd19e40ef9c','1cee9611-0ce7-41f2-b96f-50a202b3b3c6.jpg','image/jpeg','6f6467c9e445b9e19371eaaefd0196a3',NULL,NULL,NULL),('5ac30f57-d40b-4bb3-b104-72d28bd216e5','little-prince.jpg','image/jpeg','e25a67417d0f4c45aac5ed1a2dbce032',76,NULL,'books'),('6ef7dca4-486d-4fcb-8b9a-bc5feca3a619','gone-wild.jpg','image/jpeg','9a41e60b15873dd9a2d95f3cbfe3f99e',75,NULL,'books'),('88c56a4b-10a6-476d-828b-e5f4f984c2f1','godfather.jpg','image/jpeg','f71065d5bb36c4ca6a38a23a27a44e88',77,NULL,'books'),('bca5c125-7249-486a-8476-6f82c23ae59e','1984.jpg','image/jpeg','0bafe0cac400a597c63a4e315dee1f7f',74,NULL,'books');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (2,'Научный'),(4,'Приключения'),(5,'Роман'),(1,'Сказка'),(3,'Фантастика');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','Суперюзер'),(2,'Модератор','модератор обычный'),(3,'Пользователь','Обычный юзер');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','pbkdf2:sha256:260000$7On5W3XzpQk8l51p$4690655e7a939f3ccee08c25297ce70029725d0df8de736e10740f9d46479cbe','Иванов','Иван',NULL,1),(2,'user1','pbkdf2:sha256:260000$7On5W3XzpQk8l51p$4690655e7a939f3ccee08c25297ce70029725d0df8de736e10740f9d46479cbe','Сидоров','Иван',NULL,2),(3,'user2','pbkdf2:sha256:260000$7On5W3XzpQk8l51p$4690655e7a939f3ccee08c25297ce70029725d0df8de736e10740f9d46479cbe','Петров','Иван',NULL,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-16 19:30:30
