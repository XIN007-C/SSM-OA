/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : oa

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2020-08-31 19:25:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `claim_voucher`
-- ----------------------------
DROP TABLE IF EXISTS `claim_voucher`;
CREATE TABLE `claim_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cause` varchar(100) DEFAULT NULL,
  `create_sn` char(5) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `next_deal_sn` char(5) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`next_deal_sn`),
  KEY `FK_Reference_3` (`create_sn`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`next_deal_sn`) REFERENCES `employee` (`sn`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`create_sn`) REFERENCES `employee` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of claim_voucher
-- ----------------------------
INSERT INTO `claim_voucher` VALUES ('1', '请客户吃饭', '10006', '2020-05-11 23:46:49', '10006', '1000', '新创建');
INSERT INTO `claim_voucher` VALUES ('2', '客户', '10003', '2020-05-11 23:51:56', null, '2000', '已终止');
INSERT INTO `claim_voucher` VALUES ('3', '工伤', '10004', '2020-05-11 23:55:51', null, '6000', '已打款');
INSERT INTO `claim_voucher` VALUES ('4', '客户', '10006', '2020-05-12 22:01:07', '10006', '500', '新创建');
INSERT INTO `claim_voucher` VALUES ('5', '客户', '10006', '2020-05-12 22:01:31', '10006', '1000', '新创建');
INSERT INTO `claim_voucher` VALUES ('6', '工伤', '10005', '2020-05-12 22:02:57', '10005', '6000', '新创建');
INSERT INTO `claim_voucher` VALUES ('7', '出差', '10004', '2020-05-12 22:50:33', '10003', '3000', '已提交');
INSERT INTO `claim_voucher` VALUES ('8', '客户', '10004', '2020-05-20 19:56:56', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('9', '公司安排', '10004', '2020-08-30 15:14:48', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('10', '公司安排', '10004', '2020-08-30 15:16:32', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('11', '公司安排', '10004', '2020-08-30 15:20:59', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('12', '公司安排', '10004', '2020-08-30 15:37:19', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('13', '公司安排', '10004', '2020-08-30 23:43:22', null, '2000', '已打款');
INSERT INTO `claim_voucher` VALUES ('14', '公司安排', '10004', '2020-08-31 15:21:29', null, '1000', '已打款');
INSERT INTO `claim_voucher` VALUES ('15', '公司安排', '10004', '2020-08-31 17:12:31', null, '3000', '已打款');
INSERT INTO `claim_voucher` VALUES ('16', '公司安排', '10004', '2020-08-31 17:13:04', null, '6000', '已打款');
INSERT INTO `claim_voucher` VALUES ('17', '公司安排', '10004', '2020-08-31 17:17:28', null, '3000', '已打款');
INSERT INTO `claim_voucher` VALUES ('18', '公司安排', '10004', '2020-08-31 17:17:38', null, '6000', '已打款');
INSERT INTO `claim_voucher` VALUES ('19', '公司安排', '10004', '2020-08-31 17:21:40', '10002', '3000', '已审核');
INSERT INTO `claim_voucher` VALUES ('20', '', '10004', '2020-08-31 17:21:54', '10001', '9000', '待复审');

-- ----------------------------
-- Table structure for `claim_voucher_item`
-- ----------------------------
DROP TABLE IF EXISTS `claim_voucher_item`;
CREATE TABLE `claim_voucher_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `claim_voucher_id` int(11) DEFAULT NULL,
  `item` varchar(20) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`claim_voucher_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`claim_voucher_id`) REFERENCES `claim_voucher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of claim_voucher_item
-- ----------------------------
INSERT INTO `claim_voucher_item` VALUES ('1', '1', '餐饮', '1000', '');
INSERT INTO `claim_voucher_item` VALUES ('2', '2', '住宿', '2000', '我没钱了');
INSERT INTO `claim_voucher_item` VALUES ('3', '3', '办公', '3000', '我虚了');
INSERT INTO `claim_voucher_item` VALUES ('4', '4', '交通', '500', '火车票');
INSERT INTO `claim_voucher_item` VALUES ('5', '5', '住宿', '1000', '酒店');
INSERT INTO `claim_voucher_item` VALUES ('6', '6', '办公', '6000', '');
INSERT INTO `claim_voucher_item` VALUES ('7', '7', '交通', '3000', '飞机票');
INSERT INTO `claim_voucher_item` VALUES ('9', '8', '交通', '1000', '火车票');
INSERT INTO `claim_voucher_item` VALUES ('10', '9', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('11', '10', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('12', '11', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('13', '12', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('14', '13', '住宿', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('16', '13', '餐饮', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('17', '3', '交通', '3000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('18', '14', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('19', '15', '餐饮', '3000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('20', '16', '餐饮', '3000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('21', '16', '办公', '2000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('22', '16', '交通', '1000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('23', '17', '交通', '3000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('24', '18', '餐饮', '3000', '');
INSERT INTO `claim_voucher_item` VALUES ('25', '18', '交通', '3000', '');
INSERT INTO `claim_voucher_item` VALUES ('26', '19', '交通', '3000', '谢谢啦');
INSERT INTO `claim_voucher_item` VALUES ('27', '20', '住宿', '3000', '');
INSERT INTO `claim_voucher_item` VALUES ('28', '20', '交通', '3000', '');
INSERT INTO `claim_voucher_item` VALUES ('29', '20', '办公', '3000', '');

-- ----------------------------
-- Table structure for `deal_record`
-- ----------------------------
DROP TABLE IF EXISTS `deal_record`;
CREATE TABLE `deal_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `claim_voucher_id` int(11) DEFAULT NULL,
  `deal_sn` char(5) DEFAULT NULL,
  `deal_time` datetime DEFAULT NULL,
  `deal_way` varchar(20) DEFAULT NULL,
  `deal_result` varchar(20) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_5` (`claim_voucher_id`),
  KEY `FK_Reference_6` (`deal_sn`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`claim_voucher_id`) REFERENCES `claim_voucher` (`id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`deal_sn`) REFERENCES `employee` (`sn`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deal_record
-- ----------------------------
INSERT INTO `deal_record` VALUES ('1', '13', '10004', '2020-08-31 11:23:53', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('2', '12', '10004', '2020-08-31 11:23:57', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('3', '11', '10004', '2020-08-31 11:24:02', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('4', '10', '10004', '2020-08-31 12:30:16', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('5', '9', '10004', '2020-08-31 12:50:31', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('6', '13', '10003', '2020-08-31 15:08:56', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('7', '12', '10003', '2020-08-31 15:09:00', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('8', '11', '10003', '2020-08-31 15:09:04', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('9', '10', '10003', '2020-08-31 15:09:07', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('10', '9', '10003', '2020-08-31 15:09:12', '打回', '已打回', '');
INSERT INTO `deal_record` VALUES ('11', '9', '10004', '2020-08-31 15:09:36', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('12', '9', '10003', '2020-08-31 15:09:58', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('13', '13', '10002', '2020-08-31 15:12:09', '打款', '已打款', 'ok');
INSERT INTO `deal_record` VALUES ('14', '12', '10002', '2020-08-31 15:12:11', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('15', '11', '10002', '2020-08-31 15:12:14', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('16', '10', '10002', '2020-08-31 15:12:17', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('17', '9', '10002', '2020-08-31 15:12:20', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('18', '2', '10003', '2020-08-31 15:13:18', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('19', '2', '10003', '2020-08-31 15:13:27', '拒绝', '已终止', '');
INSERT INTO `deal_record` VALUES ('20', '7', '10004', '2020-08-31 15:15:43', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('21', '8', '10004', '2020-08-31 15:20:56', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('22', '14', '10004', '2020-08-31 15:21:59', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('23', '3', '10004', '2020-08-31 15:22:03', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('24', '14', '10003', '2020-08-31 15:22:24', '通过', '已审核', 'ok');
INSERT INTO `deal_record` VALUES ('25', '3', '10003', '2020-08-31 15:22:28', '通过', '待复审', '');
INSERT INTO `deal_record` VALUES ('26', '3', '10001', '2020-08-31 15:22:48', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('27', '14', '10002', '2020-08-31 15:23:09', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('28', '3', '10002', '2020-08-31 15:23:14', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('29', '16', '10004', '2020-08-31 17:13:13', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('30', '15', '10004', '2020-08-31 17:13:14', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('31', '16', '10003', '2020-08-31 17:13:35', '通过', '待复审', 'ok');
INSERT INTO `deal_record` VALUES ('32', '15', '10003', '2020-08-31 17:13:42', '通过', '已审核', 'ok');
INSERT INTO `deal_record` VALUES ('33', '16', '10001', '2020-08-31 17:14:06', '通过', '已审核', 'ok');
INSERT INTO `deal_record` VALUES ('34', '16', '10002', '2020-08-31 17:14:24', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('35', '15', '10002', '2020-08-31 17:14:28', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('36', '18', '10004', '2020-08-31 17:17:41', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('37', '17', '10004', '2020-08-31 17:17:42', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('38', '18', '10003', '2020-08-31 17:17:55', '通过', '待复审', '');
INSERT INTO `deal_record` VALUES ('39', '17', '10003', '2020-08-31 17:17:59', '通过', '已审核', 'ok');
INSERT INTO `deal_record` VALUES ('40', '18', '10001', '2020-08-31 17:18:14', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('41', '18', '10002', '2020-08-31 17:18:28', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('42', '17', '10002', '2020-08-31 17:18:31', '打款', '已打款', '');
INSERT INTO `deal_record` VALUES ('43', '20', '10004', '2020-08-31 17:21:56', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('44', '19', '10004', '2020-08-31 17:21:57', '提交', '已提交', '无');
INSERT INTO `deal_record` VALUES ('45', '20', '10003', '2020-08-31 17:22:20', '通过', '待复审', '');
INSERT INTO `deal_record` VALUES ('46', '19', '10003', '2020-08-31 17:22:23', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('47', '8', '10003', '2020-08-31 17:22:26', '通过', '已审核', '');
INSERT INTO `deal_record` VALUES ('48', '8', '10002', '2020-08-31 17:23:45', '打款', '已打款', 'ok');

-- ----------------------------
-- Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `sn` char(5) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('10001', '总经理办公室', '火星');
INSERT INTO `department` VALUES ('10002', '财务部', '火星');
INSERT INTO `department` VALUES ('10003', '事业部', '火星');
INSERT INTO `department` VALUES ('10004', '保安科', '火星');

-- ----------------------------
-- Table structure for `employee`
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `sn` char(5) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `department_sn` char(5) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`sn`),
  KEY `FK_Reference_1` (`department_sn`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`department_sn`) REFERENCES `department` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('10001', '000000', '猪头', '10001', '总经理');
INSERT INTO `employee` VALUES ('10002', '000000', '小可爱', '10002', '财务');
INSERT INTO `employee` VALUES ('10003', '000000', '艾尼', '10003', '部门经理');
INSERT INTO `employee` VALUES ('10004', '000000', '憨憨', '10003', '员工');
INSERT INTO `employee` VALUES ('10005', '000000', '张三', '10003', '员工');
INSERT INTO `employee` VALUES ('10006', '000000', '李四', '10003', '员工');
INSERT INTO `employee` VALUES ('10007', '000000', '小test', '10004', '员工');
