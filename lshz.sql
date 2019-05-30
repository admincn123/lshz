-- --------------------------------------------------------
-- 主机:                           120.55.59.235
-- 服务器版本:                        5.7.19-log - Source distribution
-- 服务器操作系统:                      Linux
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 lshz 的数据库结构
CREATE DATABASE IF NOT EXISTS `lshz` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `lshz`;


-- 导出  表 lshz.db_admin 结构
CREATE TABLE IF NOT EXISTS `db_admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `role_id` int(10) DEFAULT NULL COMMENT '角色ID',
  `warehouse_ids` text COMMENT '管理仓库ID集',
  `account` char(32) DEFAULT NULL COMMENT '账号',
  `phone` char(11) DEFAULT NULL COMMENT '手机',
  `password` char(32) DEFAULT NULL COMMENT '密码',
  `token` char(32) DEFAULT NULL COMMENT 'token',
  `password_pay` char(32) DEFAULT NULL COMMENT '支付密码',
  `register_datetime` datetime DEFAULT NULL COMMENT '注册时间',
  `register_ip` char(15) DEFAULT NULL COMMENT '注册IP',
  `sign_datetime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `sign_ip` char(32) DEFAULT NULL COMMENT '上次登录IP',
  `status` int(1) DEFAULT '0' COMMENT '0：开启、其它：关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_admin 的数据：3 rows
/*!40000 ALTER TABLE `db_admin` DISABLE KEYS */;
INSERT INTO `db_admin` (`id`, `pid`, `role_id`, `warehouse_ids`, `account`, `phone`, `password`, `token`, `password_pay`, `register_datetime`, `register_ip`, `sign_datetime`, `sign_ip`, `status`) VALUES
	(1, 0, 1, '1,2,3,4,5', 'admin', '13118517131', 'e10adc3949ba59abbe56e057f20f883e', '09d688d06f81d17b', '', NULL, '', '2019-05-29 17:42:20', '111.121.95.105', 0),
	(2, 0, 2, '2,5', 'damao', '', 'e10adc3949ba59abbe56e057f20f883e', 'f6b735846bbd1a4d', '', '2019-01-23 19:55:22', '127.0.0.1', '2019-05-23 17:16:01', '111.121.80.86', 0),
	(5, NULL, 4, '2', 'admin1', NULL, 'e10adc3949ba59abbe56e057f20f883e', '098c9f4eb0112ac0', NULL, '2019-05-28 10:04:32', '111.121.96.138', '2019-05-29 09:56:01', '111.121.96.138', 0);
/*!40000 ALTER TABLE `db_admin` ENABLE KEYS */;


-- 导出  表 lshz.db_admin_access 结构
CREATE TABLE IF NOT EXISTS `db_admin_access` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT '0' COMMENT '父级ID',
  `name` char(32) DEFAULT NULL COMMENT '权限菜单名/操作节点名',
  `route` char(60) DEFAULT NULL COMMENT '路由地址',
  `sort` int(10) DEFAULT '0' COMMENT '排序值',
  `icon` char(60) DEFAULT NULL COMMENT '图样className',
  `open_mode` char(15) DEFAULT NULL COMMENT 'page：页面；layer：窗口层',
  `node` char(32) DEFAULT NULL COMMENT '操作节点ID',
  `node_color` char(7) DEFAULT NULL COMMENT '节点颜色值',
  `date` date DEFAULT NULL COMMENT '创建时间',
  `status` int(1) DEFAULT '0' COMMENT '0：开启、其它：关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_admin_access 的数据：71 rows
/*!40000 ALTER TABLE `db_admin_access` DISABLE KEYS */;
INSERT INTO `db_admin_access` (`id`, `pid`, `name`, `route`, `sort`, `icon`, `open_mode`, `node`, `node_color`, `date`, `status`) VALUES
	(1, 0, '系统管理', 'system', 1, 'layui-icon-set', 'page', '', '', '2019-01-15', 0),
	(2, 1, '权限菜单', 'system/access', 1, 'layui-icon-component', 'page', '', '', '2019-01-15', 0),
	(3, 2, '查看', '', 1, 'layui-icon-search', 'layer', 'read', '', '2019-01-15', 0),
	(4, 2, '添加', '', 2, 'layui-icon-add-1', 'layer', 'add', '', '2019-01-15', 0),
	(5, 2, '编辑', '', 3, 'layui-icon-edit', 'layer', 'edit', '', '2019-01-15', 0),
	(6, 2, '删除', '', 4, 'layui-icon-delete', 'layer', 'del', '', '2019-01-15', 0),
	(7, 2, '列表操作', '', 5, 'layui-icon-set-fill', '', 'list', '', '2019-01-23', 0),
	(8, 2, '保存排序', '', 6, '', '', 'sort', '', '2019-01-23', 0),
	(99, 95, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-10', 0),
	(98, 95, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-10', 0),
	(97, 95, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-10', 0),
	(96, 95, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-10', 0),
	(95, 1, '角色管理', 'system/role', 3, 'layui-icon-tabs', 'page', NULL, NULL, '2019-05-10', 0),
	(14, 1, '后台管理员', 'system/admin', 14, 'layui-icon-username', 'page', '', '', '2019-01-23', 0),
	(15, 14, '查看', '', 1, 'layui-icon-search', '', 'read', '', '2019-01-23', 0),
	(16, 14, '添加', '', 2, 'layui-icon-add-1', '', 'add', '', '2019-01-23', 0),
	(17, 14, '分配角色', '', 3, 'layui-icon-edit', '', 'edit', '', '2019-01-23', 0),
	(18, 14, '删除', '', 4, 'layui-icon-delete', '', 'del', '', '2019-01-23', 0),
	(19, 14, '列表操作', '', 5, 'layui-icon-set-fill', '', 'list', '', '2019-01-23', 0),
	(26, 0, '用户管理', 'user', 2, 'layui-icon-user', 'page', '', '', '2019-04-19', 1),
	(35, 0, '代理管理', 'agent', 7, 'layui-icon-tabs', 'page', NULL, NULL, '2019-05-06', 0),
	(42, 47, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-06', 0),
	(41, 0, '盒子管理', 'boxs', 6, 'layui-icon-template-1', 'page', NULL, NULL, '2019-05-06', 0),
	(106, 0, '系统设置', 'setting', 12, 'layui-icon-set-fill', 'page', NULL, NULL, '2019-05-22', 0),
	(39, 35, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(38, 35, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(37, 35, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(36, 35, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-06', 0),
	(43, 47, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(44, 47, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(45, 47, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(47, 41, '盒子列表', 'boxs/list', 33, 'layui-icon-list', 'page', NULL, NULL, '2019-05-06', 0),
	(48, 41, '分区管理', 'boxs/type', 34, 'layui-icon-table', 'page', NULL, NULL, '2019-05-06', 0),
	(49, 48, '添加', NULL, 1, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(50, 48, '编辑', NULL, 2, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(51, 48, '删除', NULL, 3, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(52, 0, '订单管理', 'order', 8, 'layui-icon-note', 'page', NULL, NULL, '2019-05-06', 0),
	(53, 52, '删除', NULL, 1, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(54, 0, '补货模板', 'cpfrtpl', 5, 'layui-icon-layouts', 'page', NULL, NULL, '2019-05-06', 0),
	(55, 54, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-06', 0),
	(56, 54, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(57, 54, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(58, 54, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(59, 0, '仓库管理', 'library', 3, 'layui-icon-flag', 'page', NULL, NULL, '2019-05-06', 0),
	(60, 59, '添加', NULL, 1, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(61, 59, '编辑', NULL, 2, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(62, 59, '删除', NULL, 3, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(63, 0, '广告管理', 'banner', 9, 'layui-icon-link', 'page', NULL, NULL, '2019-05-06', 0),
	(65, 0, '商品管理', 'goods', 4, 'layui-icon-star', 'page', NULL, NULL, '2019-05-06', 0),
	(66, 65, '商品列表', 'goods/list', 52, 'layui-icon-list', 'page', NULL, NULL, '2019-05-06', 0),
	(67, 65, '商品分类', 'goods/type', 53, 'layui-icon-table', 'page', NULL, NULL, '2019-05-06', 0),
	(68, 66, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-06', 0),
	(69, 66, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(70, 66, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(71, 66, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(72, 67, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-06', 0),
	(73, 67, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-06', 0),
	(74, 67, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-06', 0),
	(75, 67, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-06', 0),
	(93, 92, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-08', 0),
	(92, 0, '用户反馈', 'feedback', 10, 'layui-icon-chat', 'page', NULL, NULL, '2019-05-08', 0),
	(105, 0, '公告管理', 'placard', 11, 'layui-icon-list', 'page', NULL, NULL, '2019-05-22', 0),
	(82, 47, '盘点记录', NULL, 6, 'layui-icon-list', '1', 'inventorylog', '', '2019-05-07', 0),
	(83, 47, '二维码', NULL, 8, 'layui-icon-snowflake', '1', 'qrcode', '', '2019-05-07', 0),
	(84, 47, '交易记录', NULL, 7, 'layui-icon-senior', '1', 'tradelog', '', '2019-05-07', 0),
	(86, 59, '列表操作', NULL, 1, 'layui-icon-set-fill', '1', 'list', '', '2019-05-08', 0),
	(87, 63, '查看', NULL, 1, 'layui-icon-search', '1', 'read', '', '2019-05-08', 0),
	(88, 63, '添加', NULL, 2, 'layui-icon-add-1', '1', 'add', '', '2019-05-08', 0),
	(89, 63, '编辑', NULL, 3, 'layui-icon-edit', '1', 'edit', '', '2019-05-08', 0),
	(90, 63, '删除', NULL, 4, 'layui-icon-delete', '1', 'del', '', '2019-05-08', 0),
	(94, 67, '列表操作', NULL, 5, 'layui-icon-set-fill', '1', 'list', '', '2019-05-09', 0);
/*!40000 ALTER TABLE `db_admin_access` ENABLE KEYS */;


-- 导出  表 lshz.db_admin_log 结构
CREATE TABLE IF NOT EXISTS `db_admin_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `sign_datetime` datetime DEFAULT NULL COMMENT '登录时间',
  `sign_ip` varchar(15) DEFAULT NULL COMMENT '登录IP',
  `status` int(1) DEFAULT '0' COMMENT '0：正常；其它：异常',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COMMENT='后台登录日志';

-- 正在导出表  lshz.db_admin_log 的数据：52 rows
/*!40000 ALTER TABLE `db_admin_log` DISABLE KEYS */;
INSERT INTO `db_admin_log` (`id`, `admin_id`, `sign_datetime`, `sign_ip`, `status`) VALUES
	(152, 1, '2019-05-29 17:42:20', '111.121.95.105', 0),
	(151, 1, '2019-05-29 15:05:01', '127.0.0.1', 0),
	(150, 1, '2019-05-29 14:50:59', '111.121.96.138', 0),
	(149, 1, '2019-05-29 12:33:27', '111.85.255.137', 0),
	(148, 1, '2019-05-29 12:02:38', '111.121.95.105', 0),
	(147, 1, '2019-05-29 11:36:52', '111.121.96.138', 0),
	(146, 1, '2019-05-29 10:36:22', '111.121.96.138', 0),
	(145, 1, '2019-05-29 10:35:49', '111.121.96.138', 0),
	(144, 1, '2019-05-29 10:35:24', '111.121.96.138', 0),
	(143, 1, '2019-05-29 09:58:07', '111.121.96.138', 0),
	(142, 5, '2019-05-29 09:56:01', '111.121.96.138', 0),
	(141, 5, '2019-05-29 09:53:47', '111.121.96.138', 0),
	(140, 5, '2019-05-28 15:30:31', '111.121.96.138', 0),
	(139, 1, '2019-05-28 15:28:25', '111.121.96.138', 0),
	(138, 1, '2019-05-28 15:16:33', '111.121.96.138', 0),
	(137, 5, '2019-05-28 15:15:25', '111.121.96.138', 0),
	(136, 5, '2019-05-28 15:13:43', '111.121.96.138', 0),
	(135, 1, '2019-05-28 15:06:04', '111.121.82.223', 0),
	(134, 1, '2019-05-28 14:35:23', '111.121.82.223', 0),
	(133, 5, '2019-05-28 14:11:39', '111.121.96.138', 0),
	(132, 5, '2019-05-28 10:35:30', '111.121.96.138', 0),
	(131, 1, '2019-05-28 10:20:07', '111.121.82.223', 0),
	(130, 5, '2019-05-28 10:04:53', '111.121.96.138', 0),
	(129, 1, '2019-05-28 09:56:26', '111.121.96.138', 0),
	(128, 1, '2019-05-28 09:45:30', '127.0.0.1', 0),
	(127, 1, '2019-05-28 09:44:30', '111.121.96.138', 0),
	(126, 1, '2019-05-28 09:44:28', '111.121.82.223', 0),
	(125, 1, '2019-05-28 09:43:29', '111.121.96.138', 0),
	(124, 1, '2019-05-27 18:37:12', '111.121.101.179', 0),
	(123, 1, '2019-05-27 15:46:51', '111.121.82.223', 0),
	(122, 1, '2019-05-27 15:18:33', '111.121.82.223', 0),
	(121, 1, '2019-05-27 09:26:33', '127.0.0.1', 0),
	(120, 1, '2019-05-24 17:38:57', '111.121.92.3', 0),
	(119, 1, '2019-05-24 10:03:23', '111.121.92.3', 0),
	(118, 1, '2019-05-24 09:44:44', '127.0.0.1', 0),
	(117, 1, '2019-05-23 17:54:53', '127.0.0.1', 0),
	(101, 1, '2019-05-23 09:32:23', '127.0.0.1', 0),
	(102, 1, '2019-05-23 09:48:28', '111.121.92.3', 0),
	(103, 1, '2019-05-23 09:48:39', '127.0.0.1', 0),
	(104, 1, '2019-05-23 09:49:29', '111.121.92.3', 0),
	(105, 1, '2019-05-23 09:50:04', '127.0.0.1', 0),
	(106, 1, '2019-05-23 09:52:13', '111.121.92.3', 0),
	(107, 1, '2019-05-23 09:56:00', '127.0.0.1', 0),
	(108, 1, '2019-05-23 09:58:39', '111.121.92.3', 0),
	(109, 1, '2019-05-23 10:38:05', '111.121.92.3', 0),
	(110, 1, '2019-05-23 10:45:58', '111.121.92.3', 0),
	(111, 1, '2019-05-23 10:47:50', '111.121.92.3', 0),
	(112, 1, '2019-05-23 11:53:26', '111.121.92.3', 0),
	(113, 1, '2019-05-23 12:00:52', '111.121.92.3', 0),
	(114, 1, '2019-05-23 16:35:04', '111.121.80.86', 0),
	(115, 1, '2019-05-23 17:05:13', '111.121.80.86', 0),
	(116, 2, '2019-05-23 17:16:01', '111.121.80.86', 0);
/*!40000 ALTER TABLE `db_admin_log` ENABLE KEYS */;


-- 导出  表 lshz.db_admin_role 结构
CREATE TABLE IF NOT EXISTS `db_admin_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(32) DEFAULT NULL COMMENT '角色名称',
  `detail` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `access_ids` text COMMENT '权限ID集',
  `date` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_admin_role 的数据：4 rows
/*!40000 ALTER TABLE `db_admin_role` DISABLE KEYS */;
INSERT INTO `db_admin_role` (`id`, `name`, `detail`, `access_ids`, `date`) VALUES
	(1, '超级管理员', '所有权限', 'all', '2019-01-22 00:00:00'),
	(2, '管理员', '管理部分权限', '1|2|5|9|10|14|15|16|17|18|19', '2019-01-22 00:00:00'),
	(3, '普通管理员', '管理一般权限', '', '2019-01-22 00:00:00'),
	(4, '超级管理员1', '超级管理员1', '1|2|3|4|5|6|7|8|95|96|97|98|99|14|15|16|17|18|19|26|59|60|86|61|62|65|66|68|69|70|71|67|72|73|74|75|94|54|55|56|57|58|41|47|42|43|44|45|82|84|83|48|49|50|51|35|36|37|38|39|52|53|63|87|88|89|90|92|93|105|106', '2019-05-28 00:00:00');
/*!40000 ALTER TABLE `db_admin_role` ENABLE KEYS */;


-- 导出  表 lshz.db_admin_warehouse 结构
CREATE TABLE IF NOT EXISTS `db_admin_warehouse` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员仓库匹配表';

-- 正在导出表  lshz.db_admin_warehouse 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `db_admin_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_admin_warehouse` ENABLE KEYS */;


-- 导出  表 lshz.db_advert 结构
CREATE TABLE IF NOT EXISTS `db_advert` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '广告名称',
  `type` char(16) DEFAULT NULL COMMENT '广告类型',
  `position` int(4) DEFAULT NULL COMMENT '广告位置 ',
  `url` char(255) DEFAULT NULL COMMENT '广告网络地址',
  `is_show` int(4) DEFAULT NULL COMMENT '是否显示',
  `path` char(128) DEFAULT NULL COMMENT '跳转路径',
  `status` int(4) DEFAULT NULL COMMENT '状态',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_advert 的数据：1 rows
/*!40000 ALTER TABLE `db_advert` DISABLE KEYS */;
INSERT INTO `db_advert` (`id`, `name`, `type`, `position`, `url`, `is_show`, `path`, `status`, `time`) VALUES
	(1, '99dfdf', 'img', 2, 'http://lshz.dazyun.cn/api/public/uploads/images/1c99e8cacf.gif', 1, 'https:..fdfd', 1, '2019-05-23 10:09:01');
/*!40000 ALTER TABLE `db_advert` ENABLE KEYS */;


-- 导出  表 lshz.db_agent 结构
CREATE TABLE IF NOT EXISTS `db_agent` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '所属仓库ID',
  `account` char(16) DEFAULT NULL COMMENT '代理商账号',
  `password` char(32) DEFAULT NULL COMMENT '账号密码',
  `name` char(64) DEFAULT NULL COMMENT '代理商名称',
  `face_path` char(255) DEFAULT NULL COMMENT '头像地址',
  `phone` char(11) DEFAULT NULL COMMENT '手机号',
  `wechat` char(30) DEFAULT NULL COMMENT '微信号',
  `money` float(10,2) DEFAULT NULL COMMENT '销售总额',
  `time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(4) DEFAULT '2' COMMENT '状态',
  `pid` int(10) DEFAULT NULL COMMENT '父级ID',
  `route_ids` varchar(526) DEFAULT 'all' COMMENT '路由ID权限集',
  `token` varchar(16) DEFAULT NULL,
  `kf_phone` char(11) DEFAULT NULL COMMENT '客服电话',
  `kf_wechat` char(30) DEFAULT NULL COMMENT '客服微信号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent 的数据：4 rows
/*!40000 ALTER TABLE `db_agent` DISABLE KEYS */;
INSERT INTO `db_agent` (`id`, `warehouse_id`, `account`, `password`, `name`, `face_path`, `phone`, `wechat`, `money`, `time`, `status`, `pid`, `route_ids`, `token`, `kf_phone`, `kf_wechat`) VALUES
	(1, 1, 'qweqwe', '25f9e794323b453885f5181f1b624d0b', '敖江来巡逻', 'http://xl.dazyun.cn/user.png', '14785564430', 'sw992105539123', 12.00, '2019-05-07 17:25:38', 2, NULL, 'all', 'yqneUtGDkFAKKx5U', NULL, NULL),
	(2, 1, 'admin', '25f9e794323b453885f5181f1b624d0b', '大毛 来巡逻', 'http://xl.dazyun.cn/user.png', '13658558420', 'sw99210553', 12.00, '2019-05-07 17:25:38', 2, NULL, 'all', 'y3IseGHCcokJmkq2', NULL, NULL),
	(3, 4, NULL, '78900000', '张三', NULL, '13658558420', NULL, NULL, '2019-05-21 16:04:59', 2, NULL, 'all', NULL, NULL, NULL),
	(4, 5, 'abc15208513996', '25f9e794323b453885f5181f1b624d0b', '潘进伟', NULL, '15208513996', NULL, NULL, '2019-05-28 15:20:51', 2, NULL, 'all', 'NH1G2V0FthQZejnp', NULL, NULL);
/*!40000 ALTER TABLE `db_agent` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_auth 结构
CREATE TABLE IF NOT EXISTS `db_agent_auth` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent_auth 的数据：0 rows
/*!40000 ALTER TABLE `db_agent_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_agent_auth` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_goods_return 结构
CREATE TABLE IF NOT EXISTS `db_agent_goods_return` (
  `id` int(10) DEFAULT NULL COMMENT 'ID',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库ID',
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `goods_total_number` int(10) DEFAULT NULL COMMENT '商品总个数',
  `goods_total_money` float(16,2) DEFAULT NULL COMMENT '商品总金额',
  `time` datetime DEFAULT NULL COMMENT '申请时间',
  `status` int(4) DEFAULT NULL COMMENT '状态',
  `admin_id` int(10) DEFAULT NULL COMMENT '处理者ID,收货人ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent_goods_return 的数据：1 rows
/*!40000 ALTER TABLE `db_agent_goods_return` DISABLE KEYS */;
INSERT INTO `db_agent_goods_return` (`id`, `warehouse_id`, `agent_id`, `goods_total_number`, `goods_total_money`, `time`, `status`, `admin_id`) VALUES
	(1, 5, 1, 21, 60.50, '2019-05-13 17:23:20', 10, 1);
/*!40000 ALTER TABLE `db_agent_goods_return` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_goods_return_lines 结构
CREATE TABLE IF NOT EXISTS `db_agent_goods_return_lines` (
  `id` int(10) DEFAULT NULL COMMENT 'ID',
  `goods_return_id` int(10) DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品数量',
  `time` datetime DEFAULT NULL COMMENT '添加时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent_goods_return_lines 的数据：3 rows
/*!40000 ALTER TABLE `db_agent_goods_return_lines` DISABLE KEYS */;
INSERT INTO `db_agent_goods_return_lines` (`id`, `goods_return_id`, `goods_id`, `goods_number`, `time`) VALUES
	(1, 1, 1, 10, '2019-05-13 18:41:19'),
	(1, 1, 2, 6, NULL),
	(1, 1, 3, 5, NULL);
/*!40000 ALTER TABLE `db_agent_goods_return_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_inventory 结构
CREATE TABLE IF NOT EXISTS `db_agent_inventory` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `goods_total_money` float(16,2) DEFAULT NULL COMMENT '盘点商品总金额',
  `goods_total_number` int(10) DEFAULT NULL COMMENT '盘点商品数量',
  `time` datetime DEFAULT NULL COMMENT '盘点时间',
  `admin_id` int(10) DEFAULT NULL COMMENT '盘点人ID',
  `name` varchar(64) DEFAULT NULL COMMENT '盘点人姓名',
  `phone` char(11) DEFAULT NULL COMMENT '盘点人电话',
  `goods_loss_number` int(11) DEFAULT NULL COMMENT '损耗商品总个数',
  `goods_loss_money` float(16,2) DEFAULT NULL COMMENT '损耗商品总金额',
  `is_settle` int(4) DEFAULT '16' COMMENT '16未结算\r\n17已结算',
  `goods_more_number` int(11) DEFAULT '0',
  `goods_more_money` float(16,2) DEFAULT '0.00',
  `loss_filling` int(4) DEFAULT '18' COMMENT '详情查查db_code id',
  `loss_filling_money` float(16,2) DEFAULT '0.00' COMMENT '补款多少钱',
  `message` varchar(150) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='代理商盘点';

-- 正在导出表  lshz.db_agent_inventory 的数据：8 rows
/*!40000 ALTER TABLE `db_agent_inventory` DISABLE KEYS */;
INSERT INTO `db_agent_inventory` (`id`, `boxs_id`, `agent_id`, `goods_total_money`, `goods_total_number`, `time`, `admin_id`, `name`, `phone`, `goods_loss_number`, `goods_loss_money`, `is_settle`, `goods_more_number`, `goods_more_money`, `loss_filling`, `loss_filling_money`, `message`) VALUES
	(1, 16, 3, 300.00, 50, '2019-05-16 17:52:36', 1, NULL, NULL, 1, 10.00, 17, 0, 0.00, 18, 0.00, NULL),
	(2, 15, 3, 100.00, 10, '2019-05-18 10:47:34', 2, NULL, NULL, 2, 2.00, 17, 0, 0.00, 19, 0.00, NULL),
	(3, 17, 2, 478.00, 20, '2019-05-17 11:07:28', 3, NULL, NULL, 5, 33.00, 16, 0, 0.00, 20, 0.00, NULL),
	(4, 14, 4, 503.00, 42, '2019-05-17 11:08:12', 4, NULL, NULL, 7, 57.00, 16, 0, 0.00, 21, 0.00, NULL),
	(6, 1, 1, 359.00, 80, '2019-05-17 16:28:57', NULL, '敖江来巡逻', '14785564430', -21, -111.00, 16, 0, 0.00, 18, 0.00, NULL),
	(7, 1, 1, 359.00, 80, '2019-05-23 09:49:47', NULL, '敖江来巡逻', '14785564430', -1, -6.00, 16, 0, 0.00, 19, 0.00, '测试备注阿萨德'),
	(8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16, 0, 0.00, 21, 0.00, 'asasdsasd'),
	(9, 8, 4, 6.00, 1, '2019-05-28 15:34:12', NULL, '潘进伟', '15208513996', -1, -6.00, 16, 0, 0.00, 18, 0.00, NULL);
/*!40000 ALTER TABLE `db_agent_inventory` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_inventory_list 结构
CREATE TABLE IF NOT EXISTS `db_agent_inventory_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `inventory_id` int(10) DEFAULT NULL COMMENT '盘点ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品剩余数量',
  `goods_real_number` int(10) DEFAULT NULL COMMENT '商品实际数量',
  `message` varchar(126) DEFAULT NULL COMMENT '备注',
  `time` datetime DEFAULT NULL COMMENT '盘点时间',
  `status` int(4) DEFAULT NULL COMMENT '盘点状态(已查看/未查看)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent_inventory_list 的数据：19 rows
/*!40000 ALTER TABLE `db_agent_inventory_list` DISABLE KEYS */;
INSERT INTO `db_agent_inventory_list` (`id`, `inventory_id`, `goods_id`, `goods_number`, `goods_real_number`, `message`, `time`, `status`) VALUES
	(1, 1, 1, 10, 6, 'abcxzfewaw', '2019-05-17 11:02:46', NULL),
	(2, 1, 3, 20, 13, 'svdaferfawf', '2019-05-17 14:48:36', NULL),
	(3, 6, 21, 10, 8, '', '2019-05-17 16:28:57', 14),
	(4, 6, 2, 10, 7, '', '2019-05-17 16:28:57', 14),
	(5, 6, 3, 10, 10, '', '2019-05-17 16:28:57', 14),
	(6, 6, 4, 10, 8, '', '2019-05-17 16:28:57', 14),
	(7, 6, 5, 10, 7, '', '2019-05-17 16:28:57', 14),
	(8, 6, 6, 10, 5, '', '2019-05-17 16:28:57', 14),
	(9, 6, 7, 10, 9, '', '2019-05-17 16:28:57', 14),
	(10, 6, 8, 10, 5, '', '2019-05-17 16:28:57', 14),
	(11, 7, 21, 10, 9, '', '2019-05-23 09:49:47', 14),
	(12, 7, 2, 10, 10, '', '2019-05-23 09:49:47', 15),
	(13, 7, 3, 10, 10, '', '2019-05-23 09:49:47', 15),
	(14, 7, 4, 10, 10, '', '2019-05-23 09:49:47', 15),
	(15, 7, 5, 10, 10, '', '2019-05-23 09:49:47', 15),
	(16, 7, 6, 10, 10, '', '2019-05-23 09:49:47', 15),
	(17, 7, 7, 10, 10, '', '2019-05-23 09:49:47', 15),
	(18, 7, 8, 10, 10, '', '2019-05-23 09:49:47', 15),
	(19, 9, 21, 1, 0, '', '2019-05-28 15:34:12', 14);
/*!40000 ALTER TABLE `db_agent_inventory_list` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_inventory_pay 结构
CREATE TABLE IF NOT EXISTS `db_agent_inventory_pay` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `inventory_id` int(10) DEFAULT NULL COMMENT 'db_agent_inventory ID ',
  `order_number` varchar(32) DEFAULT NULL COMMENT '订单号',
  `money` float(16,2) DEFAULT '0.00' COMMENT '订单金额',
  `is_pay` int(4) DEFAULT '12' COMMENT '12未支付 13已支付',
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理盘点补款支付表(db_agent_inventory_pay)';

-- 正在导出表  lshz.db_agent_inventory_pay 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `db_agent_inventory_pay` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_agent_inventory_pay` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_inventory_pay_lines 结构
CREATE TABLE IF NOT EXISTS `db_agent_inventory_pay_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pay_id` int(10) DEFAULT NULL COMMENT 'db_agent_inventory_pay ID',
  `list_id` int(10) DEFAULT NULL COMMENT 'db_agent_inventory_list ID',
  `goods_number` int(10) DEFAULT '0' COMMENT '数量',
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理盘点补款支付详情表';

-- 正在导出表  lshz.db_agent_inventory_pay_lines 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `db_agent_inventory_pay_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_agent_inventory_pay_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_recycle 结构
CREATE TABLE IF NOT EXISTS `db_agent_recycle` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `quantity` int(10) DEFAULT '0' COMMENT '总数量',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='代理回收商品';

-- 正在导出表  lshz.db_agent_recycle 的数据：~8 rows (大约)
/*!40000 ALTER TABLE `db_agent_recycle` DISABLE KEYS */;
INSERT INTO `db_agent_recycle` (`id`, `agent_id`, `boxs_id`, `goods_id`, `quantity`, `time`) VALUES
	(1, 1, 1, 2, 20, '2019-05-23 11:59:33'),
	(2, 1, 1, 21, 10, '2019-05-23 12:05:03'),
	(3, 1, 1, 3, 10, '2019-05-23 12:05:03'),
	(4, 1, 1, 4, 10, '2019-05-23 12:05:03'),
	(5, 1, 1, 5, 10, '2019-05-23 12:05:03'),
	(6, 1, 1, 6, 10, '2019-05-23 12:05:03'),
	(7, 1, 1, 7, 10, '2019-05-23 12:05:03'),
	(8, 1, 1, 8, 10, '2019-05-23 12:05:03');
/*!40000 ALTER TABLE `db_agent_recycle` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_recycle_lines 结构
CREATE TABLE IF NOT EXISTS `db_agent_recycle_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `recycle_id` int(10) DEFAULT NULL COMMENT '代理回收商品 ID',
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `list_id` int(10) DEFAULT NULL COMMENT 'boxs_list ID',
  `quantity` int(10) DEFAULT NULL COMMENT '数量',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='代理回收商品详情表';

-- 正在导出表  lshz.db_agent_recycle_lines 的数据：~9 rows (大约)
/*!40000 ALTER TABLE `db_agent_recycle_lines` DISABLE KEYS */;
INSERT INTO `db_agent_recycle_lines` (`id`, `recycle_id`, `agent_id`, `boxs_id`, `goods_id`, `list_id`, `quantity`, `time`) VALUES
	(1, 1, 1, 1, 2, 2, 10, '2019-05-23 11:59:33'),
	(2, 2, 1, 1, 21, 1, 10, '2019-05-23 12:05:03'),
	(3, 1, 1, 1, 2, 2, 10, '2019-05-23 12:05:03'),
	(4, 3, 1, 1, 3, 3, 10, '2019-05-23 12:05:03'),
	(5, 4, 1, 1, 4, 4, 10, '2019-05-23 12:05:03'),
	(6, 5, 1, 1, 5, 5, 10, '2019-05-23 12:05:03'),
	(7, 6, 1, 1, 6, 6, 10, '2019-05-23 12:05:03'),
	(8, 7, 1, 1, 7, 7, 10, '2019-05-23 12:05:03'),
	(9, 8, 1, 1, 8, 8, 10, '2019-05-23 12:05:03');
/*!40000 ALTER TABLE `db_agent_recycle_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_route 结构
CREATE TABLE IF NOT EXISTS `db_agent_route` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `route` char(128) DEFAULT NULL COMMENT '路由',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(4) DEFAULT NULL COMMENT '状态',
  `name` char(64) DEFAULT NULL COMMENT '路由名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_agent_route 的数据：8 rows
/*!40000 ALTER TABLE `db_agent_route` DISABLE KEYS */;
INSERT INTO `db_agent_route` (`id`, `route`, `time`, `status`, `name`) VALUES
	(1, '/pages/home/home', '2019-05-07 17:21:41', 1, '首页'),
	(2, '/pages/home/warehouse_management/warehouse_management', '2019-05-07 17:21:41', 1, '库存管理'),
	(3, '/pages/home/warehouse_record/warehouse_record', '2019-05-07 17:21:41', 1, '库存列表'),
	(4, '/pages/home/warehouse_add/warehouse_add', '2019-05-07 17:21:41', 1, '添加库存'),
	(5, '/pages/box/box', '2019-05-07 17:21:41', 1, '盒子'),
	(6, '/pages/send/send', '2019-05-07 17:21:41', 1, '配送'),
	(7, '/pages/person/person', '2019-05-07 17:21:41', 1, '我的'),
	(8, '/pages/login/login', '2019-05-07 17:21:41', 1, '登录界面');
/*!40000 ALTER TABLE `db_agent_route` ENABLE KEYS */;


-- 导出  表 lshz.db_agent_settle 结构
CREATE TABLE IF NOT EXISTS `db_agent_settle` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '代理ID',
  `agent_id` int(10) NOT NULL COMMENT '代理商ID',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `sell_money` float(16,2) NOT NULL DEFAULT '0.00' COMMENT '销售金额',
  `loss_money` float(16,2) NOT NULL DEFAULT '0.00' COMMENT '损耗金额',
  `pay_money` float(16,2) DEFAULT '0.00' COMMENT '应结金额',
  `time` datetime DEFAULT NULL COMMENT '结算时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='代价结账记录表';

-- 正在导出表  lshz.db_agent_settle 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `db_agent_settle` DISABLE KEYS */;
INSERT INTO `db_agent_settle` (`id`, `agent_id`, `start_time`, `end_time`, `sell_money`, `loss_money`, `pay_money`, `time`) VALUES
	(1, 3, '2019-05-16 00:00:00', '2019-05-18 23:59:59', 200.00, 12.00, 188.00, '2019-05-22 15:18:12');
/*!40000 ALTER TABLE `db_agent_settle` ENABLE KEYS */;


-- 导出  表 lshz.db_banner 结构
CREATE TABLE IF NOT EXISTS `db_banner` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `url` char(255) DEFAULT NULL COMMENT '图片网络地址',
  `name` char(64) DEFAULT NULL COMMENT '图片名称',
  `path` char(128) DEFAULT NULL COMMENT '图片跳转地址',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(4) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_banner 的数据：0 rows
/*!40000 ALTER TABLE `db_banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_banner` ENABLE KEYS */;


-- 导出  表 lshz.db_boxs 结构
CREATE TABLE IF NOT EXISTS `db_boxs` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(150) DEFAULT NULL COMMENT '盒子名称',
  `original_qrcode` char(150) DEFAULT NULL COMMENT '原始二维码',
  `tailor_qrcode` char(150) DEFAULT NULL COMMENT '专属二维码',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(4) DEFAULT '2' COMMENT '状态',
  `agent_id` int(10) DEFAULT '0' COMMENT '代理ID',
  `area_id` int(10) DEFAULT '0' COMMENT '分区ID',
  `goods_total_number` float(16,2) DEFAULT '0.00' COMMENT '商品个数',
  `goods_total_money` float(16,2) DEFAULT '0.00' COMMENT '商品价格',
  `message` varchar(128) DEFAULT NULL COMMENT '盒子说明',
  `notification` varchar(64) DEFAULT NULL COMMENT '盒子通知',
  `phone` char(11) DEFAULT NULL COMMENT '手机号',
  `wechat` char(64) DEFAULT NULL COMMENT '微信号',
  `web_url` varchar(150) DEFAULT NULL COMMENT '网络地址',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_boxs 的数据：10 rows
/*!40000 ALTER TABLE `db_boxs` DISABLE KEYS */;
INSERT INTO `db_boxs` (`id`, `name`, `original_qrcode`, `tailor_qrcode`, `time`, `status`, `agent_id`, `area_id`, `goods_total_number`, `goods_total_money`, `message`, `notification`, `phone`, `wechat`, `web_url`) VALUES
	(1, 'iBox-1', 'http://lshz.cn/api/public/uploads/images/iBox-1.png', 'http://lshz.cn/api/public/uploads/images/iBox-1-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=1'),
	(2, 'iBox-2', 'http://lshz.cn/api/public/uploads/images/iBox-2.png', 'http://lshz.cn/api/public/uploads/images/iBox-2-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=2'),
	(3, 'iBox-3', 'http://lshz.cn/api/public/uploads/images/iBox-3.png', 'http://lshz.cn/api/public/uploads/images/iBox-3-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=3'),
	(4, 'iBox-4', 'http://lshz.cn/api/public/uploads/images/iBox-4.png', 'http://lshz.cn/api/public/uploads/images/iBox-4-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=4'),
	(5, 'iBox-5', 'http://lshz.cn/api/public/uploads/images/iBox-5.png', 'http://lshz.cn/api/public/uploads/images/iBox-5-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=5'),
	(6, 'iBox-6', 'http://lshz.cn/api/public/uploads/images/iBox-6.png', 'http://lshz.cn/api/public/uploads/images/iBox-6-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 21.00, 175.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=6'),
	(7, 'iBox-7', 'http://lshz.cn/api/public/uploads/images/iBox-7.png', 'http://lshz.cn/api/public/uploads/images/iBox-7-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 0.00, 0.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=7'),
	(8, 'iBox-8', 'http://lshz.cn/api/public/uploads/images/iBox-8.png', 'http://lshz.cn/api/public/uploads/images/iBox-8-bg.png', '2019-05-28 15:01:50', 2, 4, 3, 8.00, 33.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=8'),
	(9, 'iBox-9', 'http://lshz.cn/api/public/uploads/images/iBox-9.png', 'http://lshz.cn/api/public/uploads/images/iBox-9-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 1.00, 119.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=9'),
	(10, 'iBox-10', 'http://lshz.cn/api/public/uploads/images/iBox-10.png', 'http://lshz.cn/api/public/uploads/images/iBox-10-bg.png', '2019-05-28 15:01:50', 2, 0, 3, 4.00, 131.00, '', '', '', '', 'http://lshz.cn/user.php/Login/home?boxs=10');
/*!40000 ALTER TABLE `db_boxs` ENABLE KEYS */;


-- 导出  表 lshz.db_boxs_area 结构
CREATE TABLE IF NOT EXISTS `db_boxs_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) DEFAULT '0' COMMENT '父级ID',
  `name` char(150) DEFAULT NULL COMMENT '分区名称',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_boxs_area 的数据：9 rows
/*!40000 ALTER TABLE `db_boxs_area` DISABLE KEYS */;
INSERT INTO `db_boxs_area` (`id`, `pid`, `name`, `time`) VALUES
	(1, 0, '贵州大学', '2019-05-08 17:41:00'),
	(2, 1, '东校区', '2019-05-08 17:41:15'),
	(3, 1, '南校区', '2019-05-08 17:41:15'),
	(4, 1, '北校区', '2019-05-08 17:41:15'),
	(7, 0, '西校区', '2019-05-08 17:41:15'),
	(11, 2, '东1', NULL),
	(10, 7, 'AAA', NULL),
	(12, 0, 'A校区', NULL),
	(15, 12, '第一栋', NULL);
/*!40000 ALTER TABLE `db_boxs_area` ENABLE KEYS */;


-- 导出  表 lshz.db_boxs_list 结构
CREATE TABLE IF NOT EXISTS `db_boxs_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `quantity` int(10) DEFAULT '0' COMMENT '商品历史总进货数量',
  `stock` int(10) DEFAULT NULL COMMENT '商品当前数量',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `loss` int(10) DEFAULT '0' COMMENT '历史损耗',
  `redundant` int(10) DEFAULT '0' COMMENT '历史多余',
  `recycle` int(10) DEFAULT '0' COMMENT '回收数量',
  `status` int(4) DEFAULT '2' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_boxs_list 的数据：4 rows
/*!40000 ALTER TABLE `db_boxs_list` DISABLE KEYS */;
INSERT INTO `db_boxs_list` (`id`, `boxs_id`, `goods_id`, `quantity`, `stock`, `time`, `loss`, `redundant`, `recycle`, `status`) VALUES
	(39, 6, 32, 1, 1, '2019-05-28 15:20:21', 0, 0, 0, 2),
	(38, 8, 21, 1, 1, '2019-05-28 15:18:03', 0, 0, 0, 2),
	(37, 9, 23, 2, 2, '2019-05-28 15:15:43', 0, 0, 0, 2),
	(36, 10, 32, 1, 1, '2019-05-28 15:13:19', 0, 0, 0, 2);
/*!40000 ALTER TABLE `db_boxs_list` ENABLE KEYS */;


-- 导出  表 lshz.db_code 结构
CREATE TABLE IF NOT EXISTS `db_code` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `value` char(64) DEFAULT NULL COMMENT '描述',
  `table` varchar(32) DEFAULT NULL,
  `message` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_code 的数据：21 rows
/*!40000 ALTER TABLE `db_code` DISABLE KEYS */;
INSERT INTO `db_code` (`id`, `value`, `table`, `message`) VALUES
	(1, NULL, '', '无效的、删除了的'),
	(2, NULL, '', '有效的'),
	(3, '需补货', 'db_boxs', '盒子急需补货'),
	(4, '急需盘点', 'db_boxs', '盒子急需盘点'),
	(5, '申请中', 'db_distribution_order', '申请中'),
	(6, '配送中', 'db_distribution_order', '配送中'),
	(7, '配送完成', 'db_distribution_order', '配送完成'),
	(8, '取消配送', 'db_distribution_order', '取消配送'),
	(9, '申请中', 'db_agent_goods_return', '申请中'),
	(10, '已接货', 'db_agent_goods_return', '已接货'),
	(11, '已入库', 'db_agent_goods_return', '已入库'),
	(12, '未支付', 'db_user_order', '未支付'),
	(13, '已支付', 'db_user_order', '已支付'),
	(14, '已查看', 'db_agent_inventory_list', NULL),
	(15, '未查看', 'db_agent_inventory_list', NULL),
	(16, '未结算', NULL, '代理未结算'),
	(17, '已结算', NULL, '代理已结算'),
	(18, NULL, 'db_agent_inventory', '空则没有损耗'),
	(19, '损耗未补款', 'db_agent_inventory', '损耗未补款'),
	(20, '损耗已补款', 'db_agent_inventory', '损耗已补款'),
	(21, '无需补款', 'db_agent_inventory', '无需补款');
/*!40000 ALTER TABLE `db_code` ENABLE KEYS */;


-- 导出  表 lshz.db_distribution_order 结构
CREATE TABLE IF NOT EXISTS `db_distribution_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库ID',
  `order_number` int(10) DEFAULT NULL COMMENT '订单号',
  `order_from` char(32) DEFAULT NULL COMMENT '订单来源: admin/agent/user',
  `apply_id` int(10) DEFAULT NULL COMMENT '订单发起者ID',
  `time` datetime DEFAULT NULL COMMENT '申请时间',
  `goods_total_number` int(10) DEFAULT NULL COMMENT '商品个数',
  `goods_total_money` float(16,2) DEFAULT NULL COMMENT '商品金额',
  `status` int(4) DEFAULT NULL COMMENT '状态(申请中/配送中/配送完成/取消配送)',
  `cloud_print` int(10) DEFAULT '0' COMMENT '云打印次数',
  `replenish_time` datetime DEFAULT NULL COMMENT '补货时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_distribution_order 的数据：28 rows
/*!40000 ALTER TABLE `db_distribution_order` DISABLE KEYS */;
INSERT INTO `db_distribution_order` (`id`, `boxs_id`, `warehouse_id`, `order_number`, `order_from`, `apply_id`, `time`, `goods_total_number`, `goods_total_money`, `status`, `cloud_print`, `replenish_time`) VALUES
	(1, 1, 4, 7895686, 'admin', 1, '2019-05-13 15:30:37', 10, 120.00, 6, 0, NULL),
	(2, 14, 1, 53271, 'agent', 1, '2019-05-13 17:42:50', 20, 30.00, 5, 0, NULL),
	(3, 14, 1, 82061, 'agent', 1, '2019-05-13 17:44:56', 10, 15.00, 5, 0, NULL),
	(4, 14, 1, 49931, 'agent', 1, '2019-05-13 17:45:26', 10, 15.00, 5, 0, NULL),
	(5, 14, 1, 92941, 'agent', 1, '2019-05-13 18:14:36', 1, 1.50, 5, 0, NULL),
	(6, 13, 1, 61971, 'agent', 1, '2019-05-13 18:16:13', 10, 15.00, 5, 0, NULL),
	(7, 13, 1, 78241, 'agent', 1, '2019-05-13 18:16:19', 10, 15.00, 5, 0, NULL),
	(8, 13, 1, 45501, 'agent', 1, '2019-05-13 18:16:54', 9, 28.50, 5, 0, NULL),
	(9, 13, 1, 11241, 'agent', 1, '2019-05-13 18:22:26', 2, 7.00, 5, 0, NULL),
	(10, 13, 1, 27171, 'agent', 1, '2019-05-13 18:24:43', 2, 7.00, 5, 0, NULL),
	(11, 13, 1, 78081, 'agent', 1, '2019-05-13 18:25:12', 2, 7.00, 5, 0, NULL),
	(12, 13, 1, 33821, 'agent', 1, '2019-05-13 18:26:25', 2, 7.00, 5, 0, NULL),
	(13, 9, 1, 36401, 'agent', 1, '2019-05-13 18:44:18', 2, 7.00, 5, 0, NULL),
	(14, 14, 1, 23101, 'agent', 1, '2019-05-13 18:44:58', 2, 7.00, 5, 0, NULL),
	(15, 14, 1, 65991, 'agent', 1, '2019-05-13 18:50:31', 2, 7.00, 5, 0, NULL),
	(16, 14, 1, 26681, 'agent', 1, '2019-05-13 18:50:43', 2, 7.00, 5, 0, NULL),
	(17, 14, 1, 95381, 'agent', 1, '2019-05-13 18:52:06', 2, 7.00, 5, 0, NULL),
	(18, 14, 1, 87371, 'agent', 1, '2019-05-13 18:52:39', 1, 1.50, 5, 0, NULL),
	(19, 14, 1, 65781, 'agent', 1, '2019-05-13 18:53:44', 1, 1.50, 5, 0, NULL),
	(20, 14, 1, 42941, 'agent', 1, '2019-05-13 18:55:18', 1, 1.50, 5, 0, NULL),
	(21, 14, 1, 69911, 'agent', 1, '2019-05-13 18:58:29', 1, 1.50, 5, 0, NULL),
	(22, 14, 1, 53081, 'agent', 1, '2019-05-13 18:58:53', 1, 1.50, 5, 0, NULL),
	(23, 14, 1, 73201, 'agent', 1, '2019-05-13 19:01:43', 1, 1.50, 5, 0, NULL),
	(24, 14, 1, 52621, 'agent', 1, '2019-05-13 19:26:47', 1, 1.50, 5, 0, NULL),
	(25, 14, 1, 95401, 'agent', 1, '2019-05-13 19:26:51', 1, 1.50, 5, 0, NULL),
	(26, 14, 1, 61141, 'agent', 1, '2019-05-16 18:56:25', 11, 26.00, 5, 0, NULL),
	(27, 14, 1, 60731, 'agent', 1, '2019-05-16 18:57:22', 5, 9.50, 5, 0, NULL),
	(28, 0, 1, 78581, 'agent', 1, '2019-05-24 17:08:39', 9, 25.50, 5, 0, NULL);
/*!40000 ALTER TABLE `db_distribution_order` ENABLE KEYS */;


-- 导出  表 lshz.db_distribution_order_lines 结构
CREATE TABLE IF NOT EXISTS `db_distribution_order_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_order_id` int(10) DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_name` char(64) DEFAULT NULL COMMENT '商品名称',
  `goods_price` float(16,2) DEFAULT NULL COMMENT '商品价格',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品数量',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_distribution_order_lines 的数据：44 rows
/*!40000 ALTER TABLE `db_distribution_order_lines` DISABLE KEYS */;
INSERT INTO `db_distribution_order_lines` (`id`, `distribution_order_id`, `goods_id`, `goods_name`, `goods_price`, `goods_number`, `time`) VALUES
	(1, 2, 1, '泡面搭档', 1.50, 10, '2019-05-13 17:42:50'),
	(2, 2, 1, '泡面搭档', 1.50, 10, '2019-05-13 17:42:50'),
	(3, 3, 1, '泡面搭档', 1.50, 10, '2019-05-13 17:44:56'),
	(4, 4, 1, '泡面搭档', 1.50, 10, '2019-05-13 17:45:26'),
	(5, 5, 1, '泡面', 1.50, 1, '2019-05-13 18:14:36'),
	(6, 6, 1, '泡面搭档', 1.50, 10, '2019-05-13 18:16:13'),
	(7, 7, 1, '泡面搭档', 1.50, 10, '2019-05-13 18:16:19'),
	(8, 8, 1, '泡面', 1.50, 3, '2019-05-13 18:16:54'),
	(9, 8, 2, '泡面', 5.50, 3, '2019-05-13 18:16:54'),
	(10, 8, 3, '麻辣', 2.50, 3, '2019-05-13 18:16:54'),
	(11, 9, 1, '泡面', 1.50, 1, '2019-05-13 18:22:26'),
	(12, 9, 2, '泡面', 5.50, 1, '2019-05-13 18:22:26'),
	(13, 10, 1, '泡面', 1.50, 1, '2019-05-13 18:24:43'),
	(14, 10, 2, '泡面', 5.50, 1, '2019-05-13 18:24:43'),
	(15, 11, 1, '泡面', 1.50, 1, '2019-05-13 18:25:12'),
	(16, 11, 2, '泡面', 5.50, 1, '2019-05-13 18:25:12'),
	(17, 12, 1, '泡面', 1.50, 1, '2019-05-13 18:26:25'),
	(18, 12, 2, '泡面', 5.50, 1, '2019-05-13 18:26:25'),
	(19, 13, 1, '泡面', 1.50, 1, '2019-05-13 18:44:18'),
	(20, 13, 2, '泡面', 5.50, 1, '2019-05-13 18:44:18'),
	(21, 14, 1, '泡面', 1.50, 1, '2019-05-13 18:44:58'),
	(22, 14, 2, '泡面', 5.50, 1, '2019-05-13 18:44:58'),
	(23, 15, 1, '泡面', 1.50, 1, '2019-05-13 18:50:31'),
	(24, 15, 2, '泡面', 5.50, 1, '2019-05-13 18:50:31'),
	(25, 16, 1, '泡面', 1.50, 1, '2019-05-13 18:50:43'),
	(26, 16, 2, '泡面', 5.50, 1, '2019-05-13 18:50:43'),
	(27, 17, 1, '泡面', 1.50, 1, '2019-05-13 18:52:06'),
	(28, 17, 2, '泡面', 5.50, 1, '2019-05-13 18:52:06'),
	(29, 18, 1, '泡面', 1.50, 1, '2019-05-13 18:52:39'),
	(30, 19, 1, '泡面', 1.50, 1, '2019-05-13 18:53:44'),
	(31, 20, 1, '泡面', 1.50, 1, '2019-05-13 18:55:18'),
	(32, 21, 1, '泡面', 1.50, 1, '2019-05-13 18:58:29'),
	(33, 22, 1, '泡面', 1.50, 1, '2019-05-13 18:58:53'),
	(34, 23, 1, '泡面', 1.50, 1, '2019-05-13 19:01:43'),
	(35, 24, 1, '泡面搭档', 1.50, 1, '2019-05-13 19:26:47'),
	(36, 25, 1, '泡面搭档', 1.50, 1, '2019-05-13 19:26:51'),
	(37, 26, 1, '泡面搭档', 1.50, 3, '2019-05-16 18:56:25'),
	(38, 26, 2, '康师傅版面', 5.50, 1, '2019-05-16 18:56:25'),
	(39, 26, 3, '龙卫大面筋', 2.50, 2, '2019-05-16 18:56:25'),
	(40, 26, 4, '豆角干', 1.00, 1, '2019-05-16 18:56:25'),
	(41, 26, 6, '康师傅矿泉水', 2.00, 2, '2019-05-16 18:56:25'),
	(42, 26, 7, '薯片', 3.00, 2, '2019-05-16 18:56:25'),
	(43, 27, 1, '泡面搭档', 1.50, 3, '2019-05-16 18:57:22'),
	(44, 27, 3, '龙卫大面筋', 2.50, 2, '2019-05-16 18:57:22');
/*!40000 ALTER TABLE `db_distribution_order_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_feedback 结构
CREATE TABLE IF NOT EXISTS `db_feedback` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `name` char(32) DEFAULT NULL COMMENT '用户姓名',
  `phone` char(11) DEFAULT NULL COMMENT '用户电话',
  `content` varchar(126) DEFAULT NULL COMMENT '反馈内容',
  `time` datetime DEFAULT NULL COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_feedback 的数据：1 rows
/*!40000 ALTER TABLE `db_feedback` DISABLE KEYS */;
INSERT INTO `db_feedback` (`id`, `user_id`, `name`, `phone`, `content`, `time`) VALUES
	(1, 1, 'tttt', '15185092655', 'fdfdf', '2019-05-23 10:09:36');
/*!40000 ALTER TABLE `db_feedback` ENABLE KEYS */;


-- 导出  表 lshz.db_goods 结构
CREATE TABLE IF NOT EXISTS `db_goods` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `classify_id` int(10) DEFAULT NULL COMMENT '商品分类ID',
  `name` char(150) DEFAULT NULL COMMENT '商品名称',
  `photo` char(150) DEFAULT NULL COMMENT '商品图片',
  `original_price` float(16,2) DEFAULT NULL COMMENT '商品原价',
  `price` float(16,2) DEFAULT NULL COMMENT '商品零售价',
  `quantity` int(10) DEFAULT NULL COMMENT '商品历史总的进货数量',
  `stock` int(10) DEFAULT NULL COMMENT '商品当前库存',
  `status` int(4) DEFAULT '2' COMMENT '商品状态',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_goods 的数据：29 rows
/*!40000 ALTER TABLE `db_goods` DISABLE KEYS */;
INSERT INTO `db_goods` (`id`, `classify_id`, `name`, `photo`, `original_price`, `price`, `quantity`, `stock`, `status`, `time`) VALUES
	(1, 1, '泡面搭档', 'https://img1.ibanling.com/weixin/sk/20180809/561fd293090ee19385a38035a8ba08e51604d496.png@!square-small', 1.05, 1.50, 20, 20, 2, '2019-05-08 17:29:15'),
	(2, 1, '康师傅版面', 'https://img1.ibanling.com/weixin/sk/20180809/f74cf997e46e00c8ee0d80cb6b0ef7d3307026a3.png@!square-small', 4.00, 5.50, 30, 30, 2, '2019-05-08 17:29:52'),
	(3, 2, '龙卫大面筋', 'https://img1.ibanling.com/weixin/sk/20180817/7555f856d0ef725901167f6c1310f6e74b3cdf34.png@!square-small', 2.00, 2.50, 10, 10, 2, '2019-05-08 17:30:32'),
	(4, 2, '豆角干', 'http://img1.ibanling.com/weixin/sk/20181130/a897608b11c4b81c7eb2520ef2ec7739f5b1a8ca.jpg@!square-small', 2.00, 1.00, 12, 12, 2, '2019-05-08 17:31:04'),
	(5, 3, '红牛', 'https://img1.ibanling.com/weixin/sk/20180809/dc79a50d7955eda2827641bd90a40b5caf90fdaf.jpg@!square-small', 4.80, 6.00, 45, 45, 2, '2019-05-08 17:31:37'),
	(6, 3, '康师傅矿泉水', 'http://img1.ibanling.com/weixin/sk/20181101/fed944584124fb29a8fde1a873ef74ecea6ebb19.jpg@!square-small', 1.20, 2.00, 23, 23, 2, '2019-05-08 17:32:02'),
	(7, 4, '薯片', 'http://img1.ibanling.com/weixin/sk/20190324/017f2a0399dd74f19f98c650911f05b93cbaa665.jpg@!square-small', 2.50, 3.00, 45, 45, 2, '2019-05-08 17:32:34'),
	(8, 4, '绿箭口香糖', 'https://img1.ibanling.com/weixin/sk/20180815/bb40c2eda72584d25e1b4a50388f57e0e18b27f1.png@!square-small', 8.50, 9.90, 12, 12, 2, '2019-05-08 17:33:08'),
	(9, 1, '泡面搭档', 'https://img1.ibanling.com/weixin/sk/20180809/561fd293090ee19385a38035a8ba08e51604d496.png@!square-small', 1.05, 1.50, 20, 20, 2, '2019-05-08 17:29:15'),
	(10, 1, '康师傅版面', 'https://img1.ibanling.com/weixin/sk/20180809/f74cf997e46e00c8ee0d80cb6b0ef7d3307026a3.png@!square-small', 4.00, 5.50, 30, 30, 2, '2019-05-08 17:29:52'),
	(11, 2, '龙卫大面筋', 'https://img1.ibanling.com/weixin/sk/20180817/7555f856d0ef725901167f6c1310f6e74b3cdf34.png@!square-small', 2.00, 2.50, 10, 10, 2, '2019-05-08 17:30:32'),
	(12, 2, '豆角干', 'http://img1.ibanling.com/weixin/sk/20181130/a897608b11c4b81c7eb2520ef2ec7739f5b1a8ca.jpg@!square-small', 2.00, 1.00, 12, 12, 2, '2019-05-08 17:31:04'),
	(13, 3, '红牛', 'https://img1.ibanling.com/weixin/sk/20180809/dc79a50d7955eda2827641bd90a40b5caf90fdaf.jpg@!square-small', 4.80, 6.00, 45, 45, 2, '2019-05-08 17:31:37'),
	(14, 3, '康师傅矿泉水', 'http://img1.ibanling.com/weixin/sk/20181101/fed944584124fb29a8fde1a873ef74ecea6ebb19.jpg@!square-small', 1.20, 2.00, 23, 23, 2, '2019-05-08 17:32:02'),
	(15, 4, '薯片', 'http://img1.ibanling.com/weixin/sk/20190324/017f2a0399dd74f19f98c650911f05b93cbaa665.jpg@!square-small', 2.50, 3.00, 45, 45, 2, '2019-05-08 17:32:34'),
	(16, 4, '绿箭口香糖', 'https://img1.ibanling.com/weixin/sk/20180815/bb40c2eda72584d25e1b4a50388f57e0e18b27f1.png@!square-small', 8.50, 9.90, 12, 12, 2, '2019-05-08 17:33:08'),
	(17, 1, '泡面搭档', 'https://img1.ibanling.com/weixin/sk/20180809/561fd293090ee19385a38035a8ba08e51604d496.png@!square-small', 1.05, 1.50, 20, 20, 2, '2019-05-08 17:29:15'),
	(18, 1, '康师傅版面', 'https://img1.ibanling.com/weixin/sk/20180809/f74cf997e46e00c8ee0d80cb6b0ef7d3307026a3.png@!square-small', 4.00, 5.50, 30, 30, 2, '2019-05-08 17:29:52'),
	(19, 2, '龙卫大面筋', 'https://img1.ibanling.com/weixin/sk/20180817/7555f856d0ef725901167f6c1310f6e74b3cdf34.png@!square-small', 2.00, 2.50, 10, 10, 2, '2019-05-08 17:30:32'),
	(20, 2, '豆角干', 'http://img1.ibanling.com/weixin/sk/20181130/a897608b11c4b81c7eb2520ef2ec7739f5b1a8ca.jpg@!square-small', 2.00, 1.00, 12, 12, 2, '2019-05-08 17:31:04'),
	(21, 3, '红牛', 'https://img1.ibanling.com/weixin/sk/20180809/dc79a50d7955eda2827641bd90a40b5caf90fdaf.jpg@!square-small', 4.80, 6.00, 45, 45, 2, '2019-05-08 17:31:37'),
	(22, 3, '康师傅矿泉水', 'http://img1.ibanling.com/weixin/sk/20181101/fed944584124fb29a8fde1a873ef74ecea6ebb19.jpg@!square-small', 1.20, 2.00, 23, 23, 2, '2019-05-08 17:32:02'),
	(23, 4, '薯片', '', 2.50, 3.00, 45, 45, 2, '2019-05-08 17:32:34'),
	(24, 4, '绿箭口香糖', 'https://img1.ibanling.com/weixin/sk/20180815/bb40c2eda72584d25e1b4a50388f57e0e18b27f1.png@!square-small', 8.50, 9.90, 12, 12, 1, '2019-05-08 17:33:08'),
	(30, 2, 'a', 'http://lshz.cn/api/public/uploads/images/00fba3edf3.jpg', 20.00, 30.00, NULL, 320, 1, '2019-05-09 18:09:49'),
	(31, 1, 'b', 'http://lshz.cn/api/public/uploads/images/e0451e3f78.png', 12.00, 15.00, NULL, 300, 1, '2019-05-09 18:10:20'),
	(32, 9, '商品1', 'http://lshz.dazyun.cn/api/public/uploads/images/e3dd680fcd.jpg', 100.00, 119.00, NULL, 3, 2, '2019-05-23 10:51:02'),
	(33, 9, '1211', 'http://lshz.dazyun.cn/api/public/uploads/images/c3872e5dbb.png', 11.00, 11.00, NULL, 11, 1, '2019-05-27 18:38:04'),
	(34, 9, '5555', 'http://lshz.dazyun.cn/api/public/uploads/images/d8c232cea9.jpg', 2.00, 1.00, NULL, 1, 1, '2019-05-28 10:05:44');
/*!40000 ALTER TABLE `db_goods` ENABLE KEYS */;


-- 导出  表 lshz.db_goods_classify 结构
CREATE TABLE IF NOT EXISTS `db_goods_classify` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(255) DEFAULT NULL COMMENT '分类名称',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(4) DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_goods_classify 的数据：7 rows
/*!40000 ALTER TABLE `db_goods_classify` DISABLE KEYS */;
INSERT INTO `db_goods_classify` (`id`, `name`, `time`, `status`) VALUES
	(1, '泡面', '2019-05-08 17:27:01', 2),
	(2, '麻辣', '2019-05-08 17:27:01', 2),
	(3, '饮料', '2019-05-08 17:27:01', 2),
	(4, '休息食品', '2019-05-08 17:27:01', 2),
	(7, '果冻', '2019-05-10 15:59:57', 1),
	(8, '水果', '2019-05-23 10:50:00', 1),
	(9, '水果1', '2019-05-23 10:50:22', 2);
/*!40000 ALTER TABLE `db_goods_classify` ENABLE KEYS */;


-- 导出  表 lshz.db_goods_replenish 结构
CREATE TABLE IF NOT EXISTS `db_goods_replenish` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_goods_replenish 的数据：0 rows
/*!40000 ALTER TABLE `db_goods_replenish` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_goods_replenish` ENABLE KEYS */;


-- 导出  表 lshz.db_goods_tpl 结构
CREATE TABLE IF NOT EXISTS `db_goods_tpl` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(150) DEFAULT NULL COMMENT '模板名称',
  `time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(4) DEFAULT '2' COMMENT '状态',
  `goods_total_number` int(10) DEFAULT '0' COMMENT '商品数量',
  `goods_total_money` float(16,2) DEFAULT '0.00' COMMENT '商品总金额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_goods_tpl 的数据：4 rows
/*!40000 ALTER TABLE `db_goods_tpl` DISABLE KEYS */;
INSERT INTO `db_goods_tpl` (`id`, `name`, `time`, `status`, `goods_total_number`, `goods_total_money`) VALUES
	(1, '测试模板一', '2019-05-28 15:09:52', 2, 4, 131.00),
	(2, '测试模板二', '2019-05-28 15:14:44', 2, 1, 119.00),
	(3, '测试模板三', '2019-05-28 15:16:09', 2, 8, 33.00),
	(4, '测试模板四', '2019-05-28 15:19:58', 2, 21, 175.00);
/*!40000 ALTER TABLE `db_goods_tpl` ENABLE KEYS */;


-- 导出  表 lshz.db_goods_tpl_lines 结构
CREATE TABLE IF NOT EXISTS `db_goods_tpl_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tpl_id` int(10) DEFAULT NULL COMMENT '模板id',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_price` float(16,2) DEFAULT '0.00' COMMENT '商品单价',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='模板商品关联表';

-- 正在导出表  lshz.db_goods_tpl_lines 的数据：~15 rows (大约)
/*!40000 ALTER TABLE `db_goods_tpl_lines` DISABLE KEYS */;
INSERT INTO `db_goods_tpl_lines` (`id`, `tpl_id`, `goods_id`, `goods_price`, `goods_number`) VALUES
	(1, 25, 32, 119.00, 1),
	(2, 25, 23, 3.00, 2),
	(3, 25, 21, 6.00, 1),
	(4, 1, 32, 0.00, 1),
	(8, 2, 32, 0.00, 1),
	(9, 2, 23, 0.00, 3),
	(10, 3, 23, 3.00, 1),
	(11, 3, 22, 2.00, 3),
	(12, 3, 21, 6.00, 4),
	(13, 4, 32, 119.00, 1),
	(14, 4, 23, 3.00, 2),
	(15, 4, 22, 2.00, 3),
	(16, 4, 21, 6.00, 4),
	(17, 4, 20, 1.00, 5),
	(18, 4, 19, 2.50, 6);
/*!40000 ALTER TABLE `db_goods_tpl_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_params 结构
CREATE TABLE IF NOT EXISTS `db_params` (
  `id` int(10) DEFAULT NULL COMMENT 'ID',
  `wx_open_id` varchar(64) DEFAULT NULL COMMENT '微信公众号openid',
  `wx_app_secret` varchar(128) DEFAULT NULL COMMENT '微信公众号app_secret',
  `wx_redirect_uri` varchar(256) DEFAULT NULL COMMENT '微信公众号授权地址',
  `wx_token` varchar(64) DEFAULT NULL COMMENT '微信公众号token',
  `wx_mchid` char(32) DEFAULT NULL COMMENT '微信商户平台号',
  `wx_key` varchar(32) DEFAULT NULL COMMENT '微信商户平台秘钥',
  `wx_apiclient_cert` varchar(1024) DEFAULT NULL COMMENT '微信商户平台支付证书cert',
  `wx_apiclient_key` varchar(1024) DEFAULT NULL COMMENT '微信商户平台支付证书key',
  `mini_appid` varchar(64) DEFAULT NULL COMMENT '小程序appid',
  `mini_app_secret` varchar(128) DEFAULT NULL COMMENT '小程序app_secret',
  `logo` varchar(128) DEFAULT NULL COMMENT '公司logo',
  `apply_replenish_money_range` varchar(128) DEFAULT NULL COMMENT '申请补货金额范围',
  `replenish_remind` float(16,2) DEFAULT NULL COMMENT '补货提醒',
  `no_order_remind_day` int(4) DEFAULT '1' COMMENT '未产生交易提示的天数',
  `goods_discount` int(2) DEFAULT '0' COMMENT '商品折扣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_params 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `db_params` DISABLE KEYS */;
INSERT INTO `db_params` (`id`, `wx_open_id`, `wx_app_secret`, `wx_redirect_uri`, `wx_token`, `wx_mchid`, `wx_key`, `wx_apiclient_cert`, `wx_apiclient_key`, `mini_appid`, `mini_app_secret`, `logo`, `apply_replenish_money_range`, `replenish_remind`, `no_order_remind_day`, `goods_discount`) VALUES
	(1, '1', '1', '2', '2', '2', '2', '2', '2', '2323', '232323', 'http://lshz.dazyun.cn/api/public/uploads/images/f21c6eabb5.jpg', NULL, NULL, 1, 0);
/*!40000 ALTER TABLE `db_params` ENABLE KEYS */;


-- 导出  表 lshz.db_placard 结构
CREATE TABLE IF NOT EXISTS `db_placard` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` int(10) NOT NULL COMMENT '管理员ID',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '公告内容',
  `time` datetime NOT NULL COMMENT '公告修改时间',
  `status` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户公告表';

-- 正在导出表  lshz.db_placard 的数据：3 rows
/*!40000 ALTER TABLE `db_placard` DISABLE KEYS */;
INSERT INTO `db_placard` (`id`, `admin_id`, `content`, `time`, `status`) VALUES
	(1, 1, '你好', '2019-05-23 10:00:53', NULL),
	(2, 1, '你好辅导费', '2019-05-23 10:01:03', NULL),
	(3, 1, '你好辅导费333', '2019-05-23 10:38:44', NULL);
/*!40000 ALTER TABLE `db_placard` ENABLE KEYS */;


-- 导出  表 lshz.db_print 结构
CREATE TABLE IF NOT EXISTS `db_print` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(64) NOT NULL COMMENT '打印的表名称',
  `table_id` int(10) DEFAULT NULL COMMENT '打印的表名称ID',
  `print_id` int(10) DEFAULT NULL COMMENT '打印者ID',
  `print_count` int(10) DEFAULT '0' COMMENT '打印次数',
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品模板代理打印关联表（dg_goods_tpl_print）';

-- 正在导出表  lshz.db_print 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `db_print` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_print` ENABLE KEYS */;


-- 导出  表 lshz.db_user 结构
CREATE TABLE IF NOT EXISTS `db_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `openid` char(64) DEFAULT NULL COMMENT 'openid',
  `face_path` char(255) DEFAULT NULL COMMENT '头像地址',
  `nickname` char(255) DEFAULT NULL COMMENT '微信昵称',
  `phone` char(11) DEFAULT NULL COMMENT '手机号',
  `total_money` float(16,2) DEFAULT '0.00' COMMENT '消费总金额',
  `time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_user 的数据：2 rows
/*!40000 ALTER TABLE `db_user` DISABLE KEYS */;
INSERT INTO `db_user` (`id`, `openid`, `face_path`, `nickname`, `phone`, `total_money`, `time`) VALUES
	(1, '13655abc', 'http://xl.dazyun.cn/user.png', '魏大毛', '14785564430', 0.00, '2019-05-23 09:48:34'),
	(2, '13655abc', 'http://xl.dazyun.cn/user.png', '敖江', '14785564430', 0.00, '2019-05-23 09:48:34');
/*!40000 ALTER TABLE `db_user` ENABLE KEYS */;


-- 导出  表 lshz.db_user_order 结构
CREATE TABLE IF NOT EXISTS `db_user_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `boxs_id` int(10) DEFAULT NULL COMMENT '盒子ID',
  `order_number` varchar(126) DEFAULT NULL COMMENT '订单号',
  `goods_total_money` float(16,2) DEFAULT '0.00' COMMENT '商品总价格',
  `goods_total_number` int(10) DEFAULT '0' COMMENT '商品总个数',
  `goods_total_profit` float(16,2) DEFAULT '0.00' COMMENT '商品总利润',
  `time` datetime DEFAULT NULL COMMENT '创建时间',
  `agent_id` int(10) DEFAULT NULL COMMENT '代理ID',
  `status` int(4) DEFAULT '13' COMMENT '订单结账状态(已结/未结)',
  `is_settle` int(4) DEFAULT '16' COMMENT '16未结算\\r\\n17已结算',
  `is_delete` int(4) DEFAULT '1' COMMENT '是否删除,1有效，2删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_user_order 的数据：2 rows
/*!40000 ALTER TABLE `db_user_order` DISABLE KEYS */;
INSERT INTO `db_user_order` (`id`, `user_id`, `boxs_id`, `order_number`, `goods_total_money`, `goods_total_number`, `goods_total_profit`, `time`, `agent_id`, `status`, `is_settle`, `is_delete`) VALUES
	(1, 1, 10, '1000', 100.00, 0, 20.00, '2019-05-27 14:19:25', 1, 13, 17, 1),
	(2, 1, 60, '1000', 150.00, 0, 32.00, '2019-05-27 23:59:59', 1, 13, 17, 1);
/*!40000 ALTER TABLE `db_user_order` ENABLE KEYS */;


-- 导出  表 lshz.db_user_order_lines 结构
CREATE TABLE IF NOT EXISTS `db_user_order_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(10) DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_name` char(64) DEFAULT NULL COMMENT '商品名称',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品数量',
  `goods_price` float(16,2) DEFAULT NULL COMMENT '商品价格',
  `time` datetime DEFAULT NULL COMMENT '时间',
  `stock_prev` int(10) DEFAULT '0' COMMENT '支付前剩余库存',
  `stock_next` int(10) DEFAULT '0' COMMENT '支付后剩余库存',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_user_order_lines 的数据：4 rows
/*!40000 ALTER TABLE `db_user_order_lines` DISABLE KEYS */;
INSERT INTO `db_user_order_lines` (`id`, `order_id`, `goods_id`, `goods_name`, `goods_number`, `goods_price`, `time`, `stock_prev`, `stock_next`) VALUES
	(1, 1, 1, '测试1', 10, 10.00, '2019-05-15 14:22:47', 0, 0),
	(2, 2, 2, '测试2', 10, 10.00, '2019-05-15 14:22:47', 0, 0),
	(3, 1, 3, '测试3', 10, 10.00, '2019-05-15 14:22:47', 0, 0),
	(4, 1, 4, '测试4', 10, 10.00, '2019-05-15 14:22:47', 0, 0);
/*!40000 ALTER TABLE `db_user_order_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_user_replenish_apply_order 结构
CREATE TABLE IF NOT EXISTS `db_user_replenish_apply_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `time` datetime DEFAULT NULL COMMENT '申请时间',
  `status` int(4) DEFAULT NULL COMMENT '状态(申请中/待配送/配送中/配送完成/取消配送)',
  `agent_id` int(10) DEFAULT NULL,
  `boxs_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_user_replenish_apply_order 的数据：1 rows
/*!40000 ALTER TABLE `db_user_replenish_apply_order` DISABLE KEYS */;
INSERT INTO `db_user_replenish_apply_order` (`id`, `user_id`, `time`, `status`, `agent_id`, `boxs_id`) VALUES
	(1, 1, '2019-05-23 14:05:19', NULL, 1, 1);
/*!40000 ALTER TABLE `db_user_replenish_apply_order` ENABLE KEYS */;


-- 导出  表 lshz.db_user_replenish_apply_order_lines 结构
CREATE TABLE IF NOT EXISTS `db_user_replenish_apply_order_lines` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(10) DEFAULT NULL COMMENT '订单ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_name` char(64) DEFAULT NULL COMMENT '商品名称',
  `goods_price` float(16,2) DEFAULT NULL COMMENT '商品价格',
  `goods_number` int(10) DEFAULT NULL COMMENT '商品数量',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_user_replenish_apply_order_lines 的数据：0 rows
/*!40000 ALTER TABLE `db_user_replenish_apply_order_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_user_replenish_apply_order_lines` ENABLE KEYS */;


-- 导出  表 lshz.db_warehouse 结构
CREATE TABLE IF NOT EXISTS `db_warehouse` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` char(64) DEFAULT NULL COMMENT '仓库名称',
  `time` datetime DEFAULT NULL COMMENT '时间',
  `status` int(1) DEFAULT '2' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  lshz.db_warehouse 的数据：5 rows
/*!40000 ALTER TABLE `db_warehouse` DISABLE KEYS */;
INSERT INTO `db_warehouse` (`id`, `name`, `time`, `status`) VALUES
	(1, '贵州大学大粮仓', '2019-05-08 17:37:06', 2),
	(2, '贵州大学大粮仓A', '2019-05-08 17:37:06', 2),
	(3, '仓库一', '2019-05-13 11:14:18', 2),
	(4, '仓库二', '2019-05-13 13:30:14', 2),
	(5, '仓库A', '2019-05-23 10:53:31', 2);
/*!40000 ALTER TABLE `db_warehouse` ENABLE KEYS */;


-- 导出  表 lshz.db_warehouse_list 结构
CREATE TABLE IF NOT EXISTS `db_warehouse_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `warehouse_id` int(11) DEFAULT NULL COMMENT '仓库ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `goods_stock` int(10) DEFAULT NULL COMMENT '商品库存',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='仓库详情';

-- 正在导出表  lshz.db_warehouse_list 的数据：~19 rows (大约)
/*!40000 ALTER TABLE `db_warehouse_list` DISABLE KEYS */;
INSERT INTO `db_warehouse_list` (`id`, `warehouse_id`, `goods_id`, `goods_stock`, `time`) VALUES
	(1, 1, 1, 10, '2019-05-08 17:38:03'),
	(2, 1, 2, 16, '2019-05-08 17:38:03'),
	(3, 1, 3, 16, '2019-05-08 17:38:03'),
	(4, 1, 4, 19, '2019-05-08 17:38:03'),
	(5, 1, 5, 20, '2019-05-08 17:38:03'),
	(6, 1, 6, 18, '2019-05-08 17:38:03'),
	(7, 1, 7, 18, '2019-05-08 17:38:03'),
	(8, 2, 8, 20, '2019-05-08 17:38:03'),
	(19, 3, 23, 1, '2019-05-13 13:20:56'),
	(20, 3, 22, 2, '2019-05-13 13:20:56'),
	(21, 3, 21, 3, '2019-05-13 13:20:56'),
	(25, 4, 21, 10, '2019-05-13 13:31:00'),
	(26, 4, 20, 12, '2019-05-13 13:31:00'),
	(27, 4, 19, 5, '2019-05-13 13:31:00'),
	(28, 5, 32, 2, '2019-05-23 10:53:31'),
	(29, 5, 23, 2, '2019-05-23 10:53:31'),
	(30, 5, 22, 3, '2019-05-23 10:53:31'),
	(31, 5, 21, 3, '2019-05-23 10:53:31'),
	(32, 5, 20, 3, '2019-05-23 10:53:31');
/*!40000 ALTER TABLE `db_warehouse_list` ENABLE KEYS */;


-- 导出  函数 lshz.func_d_order_f 结构
DELIMITER //
CREATE DEFINER=`lshz`@`%` FUNCTION `func_d_order_f`(`_order_from` char(32),`_apply_id` int(10)) RETURNS int(10)
BEGIN
	#判断db_distribution_order 配送订单来源信息
	#订单来源: admin/agent/user
	declare v_return char(128) DEFAULT '';
	declare v_split char(2) DEFAULT '||';

	if _order_from = 'admin' THEN
		select CONCAT(account,v_split,phone,v_split,'管理员',v_split,id) from db_admin where id = _apply_id into v_return;
	elseif _order_from = 'agent' THEN
		select CONCAT(`name`,v_split,phone,v_split,'代理商',v_split,id) from db_agent where id = _apply_id into v_return;
	else
		select CONCAT(b.nickname,v_split,b.phone,v_split,'用户',v_split,b.id)
		from db_user_replenish_apply_order a
		LEFT JOIN db_user b on b.id = a.user_id
		where a.id = 1
		into v_return;
	end if;
	RETURN v_return;
END//
DELIMITER ;


-- 导出  函数 lshz.func_has_d_o 结构
DELIMITER //
CREATE DEFINER=`lshz`@`%` FUNCTION `func_has_d_o`(`_boxs_id` int(10)) RETURNS int(10)
BEGIN
	#判断某个盒子是否有订单
	declare v_id int(10) DEFAULT 0;

	select id into v_id from db_distribution_order where boxs_id = _boxs_id limit 1;

	RETURN v_id;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
