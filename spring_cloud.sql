/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.21-log : Database - spring_cloud
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`spring_cloud` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `spring_cloud`;

/*Table structure for table `commodity` */

DROP TABLE IF EXISTS `commodity`;

CREATE TABLE `commodity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) NOT NULL COMMENT '商品名称',
  `price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价',
  `ct_id` bigint(20) unsigned NOT NULL COMMENT '类型Id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `ct_id` (`ct_id`),
  CONSTRAINT `commodity_ibfk_1` FOREIGN KEY (`ct_id`) REFERENCES `commodity_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='商品';

/*Data for the table `commodity` */

insert  into `commodity`(`id`,`name`,`price`,`ct_id`,`create_time`,`update_time`) values (1,'加湿器','200.00',1,'2019-03-06 19:28:05','2019-03-06 19:28:05'),(2,'暖风机','120.00',1,'2019-03-06 19:28:05','2019-03-06 19:28:05'),(3,'鼠标','30.00',2,'2019-03-06 19:28:05','2019-03-06 19:28:05'),(4,'键盘','100.00',2,'2019-03-06 19:28:05','2019-03-06 19:28:05'),(5,'iphoneX','6577.00',3,'2019-03-06 19:28:05','2019-03-06 19:28:05'),(6,'小米8','3600.00',3,'2019-03-06 19:28:05','2019-03-06 19:28:05');

/*Table structure for table `commodity_type` */

DROP TABLE IF EXISTS `commodity_type`;

CREATE TABLE `commodity_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) NOT NULL COMMENT '类型名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商品类型';

/*Data for the table `commodity_type` */

insert  into `commodity_type`(`id`,`name`,`create_time`,`update_time`) values (1,'家电','2019-03-06 19:24:13','2019-03-06 19:24:30'),(2,'数码','2019-03-06 19:24:13','2019-03-06 19:24:30'),(3,'手机','2019-03-06 19:24:13','2019-03-06 19:24:30');

/*Table structure for table `order_detail` */

DROP TABLE IF EXISTS `order_detail`;

CREATE TABLE `order_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `om_id` bigint(20) unsigned NOT NULL COMMENT '订单Id',
  `c_id` bigint(20) unsigned NOT NULL COMMENT '商品Id',
  `number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `price` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `c_id` (`c_id`),
  KEY `om_id` (`om_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `commodity` (`id`),
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`om_id`) REFERENCES `order_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='订单详情';

/*Data for the table `order_detail` */

insert  into `order_detail`(`id`,`om_id`,`c_id`,`number`,`price`,`create_time`,`update_time`) values (1,1,3,1,'30.00','2019-03-07 17:21:41','2019-03-07 17:21:41'),(2,1,3,1,'30.00','2019-03-07 17:24:36','2019-03-07 17:24:36'),(3,1,3,1,'30.00','2019-03-07 17:25:58','2019-03-07 17:25:58'),(4,1,3,1,'30.00','2019-03-07 17:30:48','2019-03-07 17:30:48'),(5,1,3,1,'30.00','2019-03-07 17:33:07','2019-03-07 17:33:07'),(6,7,3,1,'30.00','2019-03-07 17:35:26','2019-03-07 17:35:26'),(7,8,3,1,'30.00','2019-03-07 17:47:52','2019-03-07 17:47:52'),(8,9,4,2,'100.00','2019-03-07 17:48:06','2019-03-07 17:48:06'),(9,10,4,2,'100.00','2019-03-08 16:11:30','2019-03-08 16:11:30');

/*Table structure for table `order_master` */

DROP TABLE IF EXISTS `order_master`;

CREATE TABLE `order_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `code` varchar(20) NOT NULL COMMENT '编号',
  `amount` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未支付;1:已支付',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='订单';

/*Data for the table `order_master` */

insert  into `order_master`(`id`,`code`,`amount`,`status`,`create_time`,`update_time`) values (1,'1','2.00',0,'2019-03-07 10:25:00','2019-03-07 10:25:00'),(2,'206863615139','30.00',0,'2019-03-07 17:21:41','2019-03-07 17:21:41'),(3,'382045561676','30.00',0,'2019-03-07 17:24:36','2019-03-07 17:24:36'),(4,'463859918765','30.00',0,'2019-03-07 17:25:58','2019-03-07 17:25:58'),(5,'754185598141','30.00',0,'2019-03-07 17:30:48','2019-03-07 17:30:48'),(6,'802446538983','30.00',0,'2019-03-07 17:33:00','2019-03-07 17:33:00'),(7,'031417659367','30.00',0,'2019-03-07 17:35:26','2019-03-07 17:35:26'),(8,'777865766199','30.00',0,'2019-03-07 17:47:52','2019-03-07 17:47:52'),(9,'792378016637','100.00',0,'2019-03-07 17:48:06','2019-03-07 17:48:06'),(10,'462048982417','100.00',0,'2019-03-08 16:11:29','2019-03-08 16:11:29');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `user_name` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码（MD5加密）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`user_name`,`password`,`create_time`,`update_time`) values (1,'1','1','2019-03-14 20:46:50','2019-03-14 20:46:50'),(2,'2','2','2019-03-14 20:46:54','2019-03-14 20:46:54');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
