/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : tpadmin_source

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2016-12-17 12:15:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 创建数据库
-- ----------------------------
DROP   DATABASE IF EXISTS `tp_admin`;
CREATE DATABASE           `tp_admin`;
USE                       `tp_admin`;

-- ----------------------------
-- 权限表
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_access`;
CREATE TABLE `tp_admin_access` (
  `role_id` smallint(6) unsigned NOT NULL DEFAULT '0', -- 角色ID
  `node_id` smallint(6) unsigned NOT NULL DEFAULT '0', -- 节点ID
  `level`   tinyint(1)  unsigned NOT NULL DEFAULT '0', -- 等级
  `pid`     smallint(6) unsigned NOT NULL DEFAULT '0', -- 父ID
  KEY `groupId` (`role_id`),
  KEY `nodeId`  (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tp_admin_access
-- ----------------------------

-- ----------------------------
-- 分组表，左侧菜单的第一级菜单
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_group`;
CREATE TABLE `tp_admin_group` (
  `id`          smallint(3)  unsigned NOT NULL AUTO_INCREMENT,
  `name`        varchar(50)           NOT NULL DEFAULT '',   -- 分组菜单的名称
  `icon`        varchar(255)          NOT NULL DEFAULT '' COMMENT 'icon小图标',
  `sort`        int      unsigned NOT NULL DEFAULT '50', -- 排序
  `status`      tinyint(1)   unsigned NOT NULL DEFAULT '1',  -- 1启用 | 0禁用
  `remark`      varchar(255)          NOT NULL DEFAULT '',   -- 备注
  `isdelete`    tinyint(1)   unsigned NOT NULL DEFAULT '0',  -- 1删除 | 0未删
  `create_time` int      unsigned NOT NULL DEFAULT '0',  -- 创建时间
  `update_time` int      unsigned NOT NULL DEFAULT '0',  -- 更新时间
  PRIMARY KEY (`id`),
  KEY `sort`  (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- 前2条记录为默认添加的分组，不建议修改，因为与下面的节点相对应；后面的根据需求自定义
-- ----------------------------
INSERT INTO `tp_admin_group` 
SELECT '1', '系统管理', '&#xe61d;', '1', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
SELECT '2', '系统工具', '&#xe63c;', '2', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
SELECT '3', '数据统计', '&#xe61a;', '3', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
SELECT '4', '运营管理', '&#xe62d;', '4', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
SELECT '5', '客服管理', '&#xe6d0;', '5', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()); -- UNION
-- SELECT '6', '消息通知', '&#xe68a;', '6', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
-- SELECT '7', '数据分析', '&#xe635;', '7', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
-- SELECT '8', '玩家数据', '&#xe683;', '8', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now()) UNION
-- SELECT '9', '游戏管理', '&#xe62e;', '9', '1', '', '0',UNIX_TIMESTAMP(now()),UNIX_TIMESTAMP(now());

-- ----------------------------
-- 节点表，左侧菜单的第二级菜单
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_node`;
CREATE TABLE `tp_admin_node` (
  `id`       smallint(6)  unsigned NOT NULL AUTO_INCREMENT,
  `pid`      smallint(6)  unsigned NOT NULL DEFAULT '0',  -- 父ID
  `group_id` tinyint(3)   unsigned NOT NULL DEFAULT '0',  -- 分组ID
  `name`     varchar(255)          NOT NULL DEFAULT '',   -- 节点名，英文表示
  `title`    varchar(50)           NOT NULL DEFAULT '',   -- 节点名，中文表示
  `remark`   varchar(255)          NOT NULL DEFAULT '',
  `level`    tinyint(1)   unsigned NOT NULL DEFAULT '0',  
  `type`     tinyint(1)   unsigned NOT NULL DEFAULT '1' COMMENT '节点类型，1-控制器 | 0-方法',
  `sort`     smallint(6)  unsigned NOT NULL DEFAULT '50', -- 排序
  `status`   tinyint(1)            NOT NULL DEFAULT '0',  -- 1启用 | 0禁用
  `isdelete` tinyint(1)   unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY    (`id`),
  KEY `level`    (`level`),
  KEY `pid`      (`pid`),
  KEY `status`   (`status`),
  KEY `name`     (`name`),
  KEY `isdelete` (`isdelete`),
  KEY `sort`     (`sort`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- 给默认的分组添加节点
-- ----------------------------
INSERT INTO `tp_admin_node` VALUES ('1',  '0',  '1', 'Admin',      '后台管理', '后台管理，不可更改', '1', '1', '1', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('2',  '1',  '1', 'AdminGroup', '分组管理', '', '2', '1', '1',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('3',  '1',  '1', 'AdminNode',  '节点管理', '', '2', '1', '2',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('4',  '1',  '1', 'AdminRole',  '角色管理', '', '2', '1', '3',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('5',  '1',  '1', 'AdminUser',  '用户管理', '', '2', '1', '4',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('6',  '1',  '0', 'Index',      '首页',     '', '2', '1', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('7',  '6',  '0', 'welcome',    '欢迎页',   '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('8',  '6',  '0', 'index',      '未定义',   '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('9',  '1',  '2', 'Generate',   '代码自动生成',  '', '2', '1', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('10', '1',  '2', 'Demo/excel', 'Excel一键导出', '', '2', '0', '2',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('11', '1',  '2', 'Demo/download',      '下载',  '', '2', '0', '3',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('12', '1',  '2', 'Demo/downloadImage', '远程图片下载', '', '2', '0', '4',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('13', '1',  '2', 'Demo/mail',          '邮件发送',     '', '2', '0', '5',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('14', '1',  '2', 'Demo/qiniu',         '七牛上传',     '', '2', '0', '6',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('15', '1',  '2', 'Demo/hashids',       'ID加密',       '', '2', '0', '7',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('16', '1',  '2', 'Demo/layer',         '丰富弹层',     '', '2', '0', '8',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('17', '1',  '2', 'Demo/tableFixed',    '表格溢出',     '', '2', '0', '9',  '1', '0');
INSERT INTO `tp_admin_node` VALUES ('18', '1',  '2', 'Demo/ueditor',       '百度编辑器',   '', '2', '0', '10', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('19', '1',  '2', 'Demo/imageUpload',   '图片上传',     '', '2', '0', '11', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('20', '1',  '2', 'Demo/qrcode',        '二维码生成',   '', '2', '0', '12', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('21', '1',  '1', 'NodeMap',  '节点图',   '', '2', '1', '5', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('22', '1',  '1', 'WebLog',   '操作日志', '', '2', '1', '6', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('23', '1',  '1', 'LoginLog', '登录日志', '', '2', '1', '7', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('59', '1',  '2', 'one.two.three.Four/index', '多级节点', '', '2', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('24', '23', '0', 'index',  '首页',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('25', '22', '0', 'index',  '列表',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('26', '22', '0', 'detail', '详情',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('27', '21', '0', 'load',   '自动导入', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('28', '21', '0', 'index',  '首页',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('29', '5',  '0', 'add',    '添加',     '', '3', '0', '51', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('30', '21', '0', 'edit',   '编辑',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('31', '21', '0', 'deleteForever', '永久删除', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('32', '9',  '0', 'index',         '首页',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('33', '9',  '0', 'generate',      '生成方法', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('34', '5',  '0', 'password',      '修改密码', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('35', '5',  '0', 'index',  '首页',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('36', '5',  '0', 'add',    '添加',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('37', '5',  '0', 'edit',   '编辑',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('38', '4',  '0', 'user',   '用户列表', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('39', '4',  '0', 'access', '授权',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('40', '4',  '0', 'index',  '首页',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('41', '4',  '0', 'add',    '添加',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('42', '4',  '0', 'edit',   '编辑',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('43', '4',  '0', 'forbid', '默认禁用操作',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('44', '4',  '0', 'resume', '默认恢复操作',     '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('45', '3',  '0', 'load',   '节点快速导入测试', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('46', '3',  '0', 'index',  '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('47', '3',  '0', 'add',    '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('48', '3',  '0', 'edit',   '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('49', '3',  '0', 'forbid', '默认禁用操作', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('50', '3',  '0', 'resume', '默认恢复操作', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('51', '2',  '0', 'index',  '首页', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('52', '2',  '0', 'add',    '添加', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('53', '2',  '0', 'edit',   '编辑', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('54', '2',  '0', 'forbid', '默认禁用操作', '', '3', '0', '51', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('55', '2',  '0', 'resume', '默认恢复操作', '', '3', '0', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('56', '1',  '2', 'one',   '一级菜单', '', '2', '1', '13', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('60', '56', '2', 'two',   '二级菜单', '', '3', '1', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('61', '60', '2', 'three', '三级菜单', '', '4', '1', '50', '1', '0');
INSERT INTO `tp_admin_node` VALUES ('62', '61', '2', 'Four',  '四级菜单', '', '5', '1', '50', '1', '0');


-- 以下数据自定义的
INSERT INTO `tp_admin_node` VALUES
(63, 1,  3, 'basedata',   '基础数据', '', 2, 1, 0, 1, 0),
(64, 63, 3, 'NewPlayer',  '新增玩家', '', 3, 1, 0, 1, 0),
(65, 63, 3, 'StayOrGone', '玩家留存', '', 3, 1, 0, 1, 0),
(66, 63, 3, 'TotalRMB',   '总金额',   '', 3, 1, 0, 1, 0),

(70, 1,  3, 'PlayerStatistic', '玩家统计', '', 2, 1, 0, 1, 0),
(71, 70, 3, 'NewPlayer',       '玩家新增', '', 3, 1, 0, 1, 0),
(72, 70, 3, 'PlayerActiveIn',  '玩家活跃', '', 3, 1, 0, 1, 0),
(73, 70, 3, 'PlayerGone',      '玩家流失', '', 3, 1, 0, 1, 0),
(74, 70, 3, 'PlayerStayed',    '玩家留存', '', 3, 1, 0, 1, 0),
(75, 70, 3, 'PlayerBack',      '玩家回归', '', 3, 1, 0, 1, 0),

(80, 1,  3, 'PayStatistic', '充值统计',     '', 2, 1, 0, 1, 0),
(81, 80, 3, 'ArpuOrArppu',  'arpu/arppu',   '', 3, 1, 0, 1, 0),
(82, 80, 3, 'LTV',          'LTV',          '', 3, 1, 0, 1, 0),
(83, 80, 3, 'PayPlayer',    '充值玩家统计', '', 3, 1, 0, 1, 0),
(84, 80, 3, 'PayRMB',       '充值金额统计', '', 3, 1, 0, 1, 0),

(90, 1,  3, 'GameData', '游戏数据', '', 2, 1, 0, 1, 0),
(91, 90, 3, 'Tasks',    '任务',     '', 3, 1, 0, 1, 0),
(92, 90, 3, 'Props',    '道具',     '', 3, 1, 0, 1, 0),
(93, 90, 3, 'Fight',    '战斗',     '', 3, 1, 0, 1, 0),


(100, 1,   4, 'PublicNoticesSetting',  '公告配置', '', 2, 1, 0, 1, 0),
(101, 100, 4, 'NoticesForLogin',       '登录公告', '', 3, 1, 0, 1, 0),
(102, 100, 4, 'NoticesForGame',        '游戏公告', '', 3, 1, 0, 1, 0),
(103, 100, 4, 'BroadCast',             '广播设置', '', 3, 1, 0, 1, 0),

(110, 1,   4, 'PropsGrant',            '道具发放',   '', 2, 1, 0, 1, 0),
(112, 110, 4, 'PropsGrant',            '道具发放',   '', 3, 1, 0, 1, 0),
(113, 110, 4, 'PackagesCodeWarehouse', '礼包码库',   '', 3, 1, 0, 1, 0),
(114, 110, 4, 'PackagesCodeGrant',     '礼包码发放', '', 3, 1, 0, 1, 0),
(115, 110, 4, 'EmailGrant',            '邮件发放',   '', 3, 1, 0, 1, 0),
(116, 110, 4, 'EmailBack',             '回归邮件',   '', 3, 1, 0, 1, 0),

(120, 1,   4, 'ActivitiesPannel',      '活动面板', '', 2, 1, 0, 1, 0),

(130, 1,   4, 'PlayersManagement',     '玩家管理', '', 2, 1, 0, 1, 0),
(131, 130, 4, 'ForceOutAndNoChat',     '封停禁言', '', 3, 1, 0, 1, 0),
(132, 130, 4, 'WhiteList',             '白名单',   '', 3, 1, 0, 1, 0),
(133, 130, 4, 'RolesTransfer',         '角色转移', '', 3, 1, 0, 1, 0),

(140, 1,   4, 'ServersManagement',     '服务器管理', '', 2, 1, 0, 1, 0),
(141, 140, 4, 'OpenServers',           '开服',       '', 3, 1, 0, 1, 0),
(142, 140, 4, 'StopServers',           '关服',       '', 3, 1, 0, 1, 0),

(150, 1, 5, 'CustomerServicePannel', '客服面板',   '', 2, 1, 0, 1, 0),
(160, 1, 5, 'PropsList',             '道具流水',   '', 2, 1, 0, 1, 0),
(170, 1, 5, 'SigninLog',             '登录日志',   '', 2, 1, 0, 1, 0),
(180, 1, 5, 'PayLost',               '掉单的充值', '', 2, 1, 0, 1, 0),
(190, 1, 5, 'GMOperationLog',        'GM操作日志', '', 2, 1, 0, 1, 0);
-- (63, 1,  5, 'getplayer',          '玩家获取',         '', 2, 1, 0, 1, 0),
-- (64, 63, 5, 'NewPlayerInThisDay', '日新登玩家',       '', 3, 1, 0, 1, 0),
-- (65, 63, 5, 'OnceChatInThisDay',  '日一次会话',       '', 3, 1, 0, 1, 0),
-- (66, 63, 5, 'CostOfGotNewPlayer', '获取玩家成本',     '', 3, 1, 0, 1, 0),
-- (67, 63, 5, 'StatisticOfTimes',   '新登玩家时间统计', '', 3, 1, 0, 1, 0),
-- (68, 63, 5, 'StatisticOfChannel', '新登玩家渠道统计', '', 3, 1, 0, 1, 0),

-- (69, 1,  5, 'player',              '玩家活跃',     '', 2, 1, 0, 1, 0),
-- (70, 69, 5, 'PlayerLoginLog',            '登录日志',     '', 3, 1, 0, 1, 0),
-- (71, 69, 5, 'OnLineStatisticOfTimes',    '在线统计',     '', 3, 1, 0, 1, 0),
-- (72, 69, 5, 'OnLineForTotalTime',        '在线总时长',   '', 3, 1, 0, 1, 0),
-- (73, 69, 5, 'PlayerActiveInThisDay',     '日活跃玩家',   '', 3, 1, 0, 1, 0),
-- (74, 69, 5, 'PlayerActiveInFrequent',    '高活跃玩家',   '', 3, 1, 0, 1, 0),
-- (75, 69, 5, 'PlayerActiveInEachChannel', '各渠道日活',   '', 3, 1, 0, 1, 0),
-- (76, 69, 5, 'PlayerActiveInEachZones',   '各区服日活',   '', 3, 1, 0, 1, 0),
-- (77, 69, 5, 'PlayerActiveInEachLevels',  '各等级日活',   '', 3, 1, 0, 1, 0),
-- (78, 69, 5, 'OnLineOnAverageOfThisDay',  '日均在线时长', '', 3, 1, 0, 1, 0),

-- (79, 1,  5, 'stayedorgone',      '留存&流失', '', 2, 1, 0, 1, 0),
-- (80, 79, 5, 'StayedInTomorrow',  '次日留存',  '', 3, 1, 0, 1, 0),
-- (81, 79, 5, 'StayedInThisWeek',  '当周留存',  '', 3, 1, 0, 1, 0),
-- (82, 79, 5, 'StayedInThisMonth', '当月留存',  '', 3, 1, 0, 1, 0),
-- (83, 79, 5, 'GoneInTomorrow',    '次日流失',  '', 3, 1, 0, 1, 0),
-- (84, 79, 5, 'GoneInThreeDays',   '三日流失',  '', 3, 1, 0, 1, 0),
-- (85, 79, 5, 'GoneInThisWeek',    '当周流失',  '', 3, 1, 0, 1, 0),
-- (86, 79, 5, 'LevelsOfPlayerGone','流失玩家等级分布', '', 3, 1, 0, 1, 0),

-- (87, 1, 3, 'pay.PayDetail',       '充值流水',         '', 2, 1, 0, 1, 0),
-- (88, 1, 3, 'pay.PayPlayers',      '充值玩家统计',     '', 2, 1, 0, 1, 0),
-- (89, 1, 3, 'pay.LifeTimeValue',   '生命周期价值',     '', 2, 1, 0, 1, 0),
-- (90, 1, 3, 'pay.PayPlayerGone',   '充值玩家流失',     '', 2, 1, 0, 1, 0),
-- (91, 1, 3, 'pay.PayPlayerBackUp', '充值玩家回流',     '', 2, 1, 0, 1, 0),
-- (92, 1, 3, 'pay.PayTimes',        '充值时间段统计',   '', 2, 1, 0, 1, 0),
-- (93, 1, 3, 'pay.PayRanges',       '充值金额段统计',   '', 2, 1, 0, 1, 0),
-- (94, 1, 3, 'pay.PayPlayerLevels', '充值玩家等级统计', '', 2, 1, 0, 1, 0),

-- (95,  1, 4, 'gamedata.StatisticPVE',        'PVE统计',  '', 2, 1, 0, 1, 0),
-- (96,  1, 4, 'gamedata.StatisticPVP',        'PVP统计',  '', 2, 1, 0, 1, 0),
-- (97,  1, 4, 'gamedata.StatisticShop',       '商城统计', '', 2, 1, 0, 1, 0),
-- (98,  1, 4, 'gamedata.StatisticSkins',      '皮肤统计', '', 2, 1, 0, 1, 0),
-- (99,  1, 4, 'gamedata.StatisticTasks',      '任务统计', '', 2, 1, 0, 1, 0),
-- (100, 1, 4, 'gamedata.StatisticProps',      '道具统计', '', 2, 1, 0, 1, 0),
-- (110, 1, 4, 'gamedata.StatisticActivities', '活动统计', '', 2, 1, 0, 1, 0),

-- (102, 1,   8, 'querydata.playermessageingame', '玩家游戏内资料',   '', 2, 1, 0, 1, 0),
-- (103, 102, 8, 'QueryProps',                    '玩家道具查询',     '', 3, 1, 0, 1, 0),
-- (104, 102, 8, 'QueryFightScore',               '玩家战绩查询',     '', 3, 1, 0, 1, 0),
-- (105, 102, 8, 'QueryCoupons',                  '玩家点券明细查询', '', 3, 1, 0, 1, 0),
-- (106, 102, 8, 'QueryGoldCoin',                 '玩家金币明细查询', '', 3, 1, 0, 1, 0),

-- (107, 1, 8, 'querydata.PlayerTasks',       '玩家任务查询', '', 2, 1, 0, 1, 0),
-- (108, 1, 8, 'querydata.PlayerSkins',       '玩家皮肤查询', '', 2, 1, 0, 1, 0),
-- (109, 1, 8, 'querydata.PlayerOnLine',      '玩家在线查询', '', 2, 1, 0, 1, 0),
-- (110, 1, 8, 'querydata.PlayerRegister',    '玩家注册信息', '', 2, 1, 0, 1, 0),
-- (111, 1, 8, 'querydata.PlayerActivities',  '玩家活动查询', '', 2, 1, 0, 1, 0),
-- (112, 1, 8, 'querydata.PlayerAccountList', '玩家账号列表', '', 2, 1, 0, 1, 0),

-- (113, 1, 9, 'gm.Mail',                '邮件', '', 2, 1, 0, 1, 0),
-- (114, 1, 9, 'gm.ForceOut',            '封停', '', 2, 1, 0, 1, 0),
-- (115, 1, 9, 'gm.BroadCast',           '广播', '', 2, 1, 0, 1, 0),
-- (116, 1, 9, 'gm.ForbidChat',          '禁言', '', 2, 1, 0, 1, 0),
-- (117, 1, 9, 'gm.PublicNotices',       '公告', '', 2, 1, 0, 1, 0),
-- (118, 1, 9, 'gm.ServerStatus',        '服务器状态', '', 2, 1, 0, 1, 0),
-- (119, 1, 9, 'gm.PublicNoticesInside', '游戏内公告', '', 2, 1, 0, 1, 0);

-- ----------------------------
-- 快速导入的节点
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_node_load`;
CREATE TABLE `tp_admin_node_load` (
  `id`     int(10)      unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title`  varchar(255)          NOT NULL DEFAULT ''     COMMENT '标题',
  `name`   varchar(255)          NOT NULL DEFAULT ''     COMMENT '名称',
  `status` tinyint(4)   unsigned NOT NULL DEFAULT '1'    COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='节点快速导入';

-- ----------------------------
-- 默认导入的节点
-- ----------------------------
INSERT INTO `tp_admin_node_load`(`title`, `name`) VALUES 
('编辑', 'edit'  ),
('添加', 'add'   ),
('首页', 'index' ),
('删除', 'delete');

-- ----------------------------
-- 角色表
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_role`;
CREATE TABLE `tp_admin_role` (
  `id`          smallint(6)  unsigned NOT NULL AUTO_INCREMENT,
  `pid`         smallint(6)  unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name`        varchar(20)           NOT NULL DEFAULT ''  COMMENT '名称',
  `remark`      varchar(255)          NOT NULL DEFAULT ''  COMMENT '备注',
  `status`      tinyint(1)   unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `isdelete`    tinyint(1)   unsigned NOT NULL DEFAULT '0',
  `create_time` int      unsigned NOT NULL DEFAULT '0',
  `update_time` int      unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY    (`id`),
  KEY `parentId` (`pid`),
  KEY `status`   (`status`),
  KEY `isdelete` (`isdelete`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- 默认添加的角色
-- ----------------------------
INSERT INTO `tp_admin_role`(`name`, `create_time`, `update_time`)
SELECT '管理员', UNIX_TIMESTAMP(NOW()), UNIX_TIMESTAMP(NOW()) UNION
SELECT '运营',   UNIX_TIMESTAMP(NOW()), UNIX_TIMESTAMP(NOW()) UNION
SELECT '客户',   UNIX_TIMESTAMP(NOW()), UNIX_TIMESTAMP(NOW());

-- ----------------------------
-- 用户与角色的关系表
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_role_user`;
CREATE TABLE `tp_admin_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL,
  `user_id` char(32)              DEFAULT NULL,
  KEY `group_id` (`role_id`),
  KEY `user_id`  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of tp_admin_role_user
-- ----------------------------

-- ----------------------------
-- 用户表
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin_user`;
CREATE TABLE `tp_admin_user` (
  `id`              mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `account`         char(32)              NOT NULL DEFAULT '',
  `realname`        varchar(255)          NOT NULL DEFAULT '',
  `password`        char(32)              NOT NULL DEFAULT '',
  `last_login_time` int      unsigned NOT NULL DEFAULT '0',
  `last_login_ip`   char(15)              NOT NULL DEFAULT '127.0.0.1',
  `login_count`     mediumint(8) unsigned NOT NULL DEFAULT '0',
  `email`           varchar(50)           NOT NULL DEFAULT '',
  `mobile`          char(11)              NOT NULL DEFAULT '',
  `remark`          varchar(255)          NOT NULL DEFAULT '',
  `status`          tinyint(1)   unsigned NOT NULL DEFAULT '50',
  `isdelete`        tinyint(1)   unsigned NOT NULL DEFAULT '0',
  `create_time`     int      unsigned NOT NULL DEFAULT '0',
  `update_time`     int      unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY           (`id`),
  KEY `accountpassword` (`account`,`password`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- 超级用户，必须保证其id为1，这是本框架的约定
-- ----------------------------
INSERT INTO `tp_admin_user`(`id`, `account`, `realname`, `password`, `email`, `mobile`, `remark`, `status`, `create_time`, `update_time`)  
SELECT 1, 'admin', '超级管理员', 'e10adc3949ba59abbe56e057f20f883e', 'tp_game@gmail.com', '1383838438', '我是超级管理员', '1', UNIX_TIMESTAMP(now()), UNIX_TIMESTAMP(now());

-- ----------------------------
-- Table structure for tp_file
-- ----------------------------
DROP TABLE IF EXISTS `tp_file`;
CREATE TABLE `tp_file` (
  `id`       int(10)      unsigned NOT NULL AUTO_INCREMENT,
  `cate`     tinyint(3)   unsigned NOT NULL DEFAULT '1' COMMENT '文件类型，1-image | 2-file',
  `name`     varchar(255)          NOT NULL DEFAULT ''  COMMENT '文件名',
  `original` varchar(255)          NOT NULL DEFAULT ''  COMMENT '原文件名',
  `domain`   varchar(255)          NOT NULL DEFAULT '',
  `type`     varchar(255)          NOT NULL DEFAULT '',
  `size`     int(10)      unsigned NOT NULL DEFAULT '0',
  `mtime`    int(10)      unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp_file
-- ----------------------------

-- ----------------------------
-- 登录日志表
-- ----------------------------
DROP TABLE IF EXISTS `tp_login_log`;
CREATE TABLE `tp_login_log` (
  `id`             int(10)      unsigned NOT NULL AUTO_INCREMENT,
  `uid`            mediumint(8) unsigned NOT NULL DEFAULT '0',
  `login_ip`       char(15)              NOT NULL DEFAULT '',
  `login_location` varchar(255)          NOT NULL DEFAULT '',
  `login_browser`  varchar(255)          NOT NULL DEFAULT '',
  `login_os`       varchar(255)          NOT NULL DEFAULT '',
  `login_time`     timestamp             NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid`   (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp_login_log
-- ----------------------------

-- ----------------------------
-- 节点图表
-- ----------------------------
DROP TABLE IF EXISTS `tp_node_map`;
CREATE TABLE `tp_node_map` (
  `id`         int(10)      unsigned NOT NULL AUTO_INCREMENT,
  `module`     varchar(255) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(255) NOT NULL DEFAULT '' COMMENT '控制器',
  `action`     varchar(255) NOT NULL DEFAULT '' COMMENT '方法',
  `method`     char(6)      NOT NULL DEFAULT '' COMMENT '请求方式',
  `comment`    varchar(255) NOT NULL DEFAULT '' COMMENT '节点图描述',
  PRIMARY KEY (`id`),
  KEY `map`   (`method`,`module`,`controller`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点图';

-- ----------------------------
-- Records of tp_node_map
-- ----------------------------

-- ----------------------------
-- 四级菜单表
-- ----------------------------
DROP TABLE IF EXISTS `tp_one_two_three_four`;
CREATE TABLE `tp_one_two_three_four` (
  `id`          int      unsigned NOT NULL AUTO_INCREMENT COMMENT '四级控制器主键',
  `field1`      varchar(255) DEFAULT NULL COMMENT '字段一',
  `option`      varchar(255) DEFAULT NULL COMMENT '选填',
  `select`      varchar(255) DEFAULT NULL COMMENT '下拉框',
  `radio`       varchar(255) DEFAULT NULL COMMENT '单选',
  `checkbox`    varchar(255) DEFAULT NULL COMMENT '复选框',
  `password`    varchar(255) DEFAULT NULL COMMENT '密码',
  `textarea`    varchar(255) DEFAULT NULL COMMENT '文本域',
  `date`        varchar(255) DEFAULT NULL COMMENT '日期',
  `mobile`      varchar(255) DEFAULT NULL COMMENT '手机号',
  `email`       varchar(255) DEFAULT NULL COMMENT '邮箱',
  `sort`        smallint(5)  DEFAULT '50' COMMENT '排序',
  `status`      tinyint(1)   unsigned NOT NULL DEFAULT '1' COMMENT '状态，1-正常 | 0-禁用',
  `isdelete`    tinyint(1)   unsigned NOT NULL DEFAULT '0' COMMENT '删除状态，1-删除 | 0-正常',
  `create_time` int(10)      unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10)      unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `sort`  (`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='四级控制器';

-- ----------------------------
-- 该记录可随意修改
-- ----------------------------
INSERT INTO `tp_one_two_three_four` VALUES ('1', 'yuan1994', 'tpadmin', '2', '1', null, '2222', 'https://github.com/yuan1994/tpadmin', '2016-12-07', '13012345678', 'tianpian0805@gmail.com', '50', '1', '0', '1481947278', '1481947353');

-- ----------------------------
-- 网站日志表001
-- ----------------------------
DROP TABLE IF EXISTS `tp_web_log_001`;
CREATE TABLE `tp_web_log_001` (
  `id`         int(10)      unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `uid`        smallint(5)  unsigned NOT NULL DEFAULT '0'    COMMENT '用户id',
  `ip`         char(15)     NOT NULL DEFAULT ''              COMMENT '访客ip',
  `location`   varchar(255) NOT NULL DEFAULT ''              COMMENT '访客地址',
  `os`         varchar(255) NOT NULL DEFAULT ''              COMMENT '操作系统',
  `browser`    varchar(255) NOT NULL DEFAULT ''              COMMENT '浏览器',
  `url`        varchar(255) NOT NULL DEFAULT ''              COMMENT 'url',
  `module`     varchar(255) NOT NULL DEFAULT ''              COMMENT '模块',
  `controller` varchar(255) NOT NULL DEFAULT ''              COMMENT '控制器',
  `action`     varchar(255) NOT NULL DEFAULT ''              COMMENT '方法',
  `method`     char(6)      NOT NULL DEFAULT ''              COMMENT '请求方式',
  `data`       text                                          COMMENT '请求的param数据，serialize后的',
  `create_at`  int(10)      unsigned NOT NULL DEFAULT '0'    COMMENT '操作时间',
  PRIMARY KEY     (`id`),
  KEY `ip`        (`ip`),
  KEY `uid`       (`uid`),
  KEY `create_at` (`create_at`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='网站日志';

-- ----------------------------
-- Records of tp_web_log_001
-- ----------------------------

-- ----------------------------
-- 网站的所有日志表
-- ----------------------------
DROP TABLE IF EXISTS `tp_web_log_all`;
CREATE TABLE `tp_web_log_all` (
  `id`         int(10)      unsigned NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `uid`        smallint(5)  unsigned NOT NULL DEFAULT '0'    COMMENT '用户id',
  `ip`         char(15)     NOT NULL DEFAULT ''              COMMENT '访客ip',
  `location`   varchar(255) NOT NULL DEFAULT ''              COMMENT '访客地址',
  `os`         varchar(255) NOT NULL DEFAULT ''              COMMENT '操作系统',
  `browser`    varchar(255) NOT NULL DEFAULT ''              COMMENT '浏览器',
  `url`        varchar(255) NOT NULL DEFAULT ''              COMMENT 'url',
  `module`     varchar(255) NOT NULL DEFAULT ''              COMMENT '模块',
  `controller` varchar(255) NOT NULL DEFAULT ''              COMMENT '控制器',
  `action`     varchar(255) NOT NULL DEFAULT ''              COMMENT '方法',
  `method`     char(6)      NOT NULL DEFAULT ''              COMMENT '请求方式',
  `data`       text                                          COMMENT '请求的param数据，serialize后的',
  `create_at`  int(10)      unsigned NOT NULL DEFAULT '0'    COMMENT '操作时间',
  PRIMARY KEY     (`id`),
  KEY `ip`        (`ip`)        USING BTREE,
  KEY `uid`       (`uid`)       USING BTREE,
  KEY `create_at` (`create_at`) USING BTREE
) ENGINE=MRG_MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC INSERT_METHOD=LAST UNION=(`tp_web_log_001`) COMMENT='网站日志';

-- ----------------------------
-- Records of tp_web_log_all
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;


-- ---------------------------------------------  以上为系统数据库  -------------------------------------------------------








-- ------------------------------------------------------------------------------------------------------------------------
-- --------------------             我是宇宙超级无敌优雅、可爱、端庄的分割线           ------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------










-- ---------------------------------------------  以下为项目数据库  -------------------------------------------------------

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 核心数据库
-- ----------------------------
DROP   DATABASE IF EXISTS `sd_core`;
CREATE DATABASE           `sd_core`;
USE                       `sd_core`;

-- ----------------------------
-- 账号表
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
  `id`       int unsigned  NOT NULL AUTO_INCREMENT,
  `username` varchar(60)   NOT NULL DEFAULT '' COMMENT '账号',
  `password` char(60)      NOT NULL DEFAULT '' COMMENT '密码',
  `pid`      smallint(2)   NOT NULL            COMMENT '平台ID',
  `cid`      smallint(2)   NOT NULL            COMMENT '渠道ID',
  `ctime`    char(10)      NOT NULL DEFAULT '' COMMENT '创建时间',
  `status`   smallint(2)   NOT NULL DEFAULT 0  COMMENT '账号状态 -2删号|-1封号|0正常|1VIP',
  -- `telphone` char(11)      NOT NULL DEFAULT '' COMMENT '手机号',
  -- `email`    varchar(255)  NOT NULL DEFAULT '' COMMENT '邮箱',
  `remark`   varchar(1000)          DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`),
  UNIQUE   uname(`username`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 游戏发行商表
-- ----------------------------
-- DROP TABLE IF EXISTS `publishers`;
-- CREATE TABLE `publishers`(
--   `id` smallint(2) unsigned NOT NULL AUTO_INCREMENT,
--   `name` varchar(100) NOT NULL DEFAULT '' COMMENT '发行商名称',
--   ``

-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 运营平台表
-- ----------------------------
DROP TABLE IF EXISTS `platform`;
CREATE TABLE `platform`(
  `id`     smallint(2) unsigned NOT NULL AUTO_INCREMENT,
  `icon`   int        unsigned  NOT NULL            COMMENT '平台图标',
  `api`    varchar(255)         NOT NULL DEFAULT '' COMMENT '平台接口',
  `name`   varchar(100)         NOT NULL DEFAULT '' COMMENT '平台名称',
  `status` tinyint(1)           NOT NULL DEFAULT 1  COMMENT '状态 -1删除|0禁用|1正常',
  `remark` varchar(1000)         DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 渠道表
-- ----------------------------
DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel`(
  `id`     int unsigned NOT NULL AUTO_INCREMENT,
  `api`    varchar(200) NOT NULL DEFAULT '' COMMENT '渠道接口',
  `name`   varchar(100) NOT NULL DEFAULT '' COMMENT '渠道名称',
  `icon`   int          NOT NULL            COMMENT '渠道图标',
  `status` tinyint(1)   NOT NULL DEFAULT 1  COMMENT '渠道状态 -1删除|0禁用|1正常',
  `remark` varchar(1000)         DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- 服务器表
-- ----------------------------
DROP TABLE IF EXISTS `servers`;
CREATE TABLE `servers`(
  `id`          smallint(2) unsigned NOT NULL AUTO_INCREMENT,
  `name`        varchar(100)         NOT NULL DEFAULT '' COMMENT '服务器名称',
  `host`        varchar(15)          NOT NULL DEFAULT '' COMMENT '服务器地址',
  `port`        varchar(5)           NOT NULL DEFAULT '' COMMENT '服务器端口',
  `status`      tinyint(1)           NOT NULL DEFAULT 1  COMMENT '服务器状态 -2删除|-1停机|0维护|1良好|2繁忙|3爆满|4火爆',
  `ctime`       char(10)             NOT NULL DEFAULT '' COMMENT '开服时间',
  `recommend`   tinyint(1)           NOT NULL DEFAULT 0  COMMENT '推荐度 0无|1新服|2推荐|3热门',
  `remark`      varchar(1000)                 DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 角色码表
-- ----------------------------
DROP TABLE IF EXISTS `roles_key`;
CREATE TABLE `roles_key`(
  `id`     int unsigned NOT NULL AUTO_INCREMENT,
  `uid`    int unsigned NOT NULL            COMMENT '玩家ID',
  `sid`    smallint(2)  NOT NULL            COMMENT '服务器ID',
  `rkey`   int unsigned NOT NULL            COMMENT '角色唯一码',
  `status` tinyint(1)   NOT NULL DEFAULT 1  COMMENT '角色状态 -1删除|0禁用|1正常',
  `remark` varchar(1000)         DEFAULT '' COMMENT '备注',
  PRIMARY  KEY(`id`),
  UNIQUE   sid_rkey_index(`sid`, `rkey`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 充值流水表
-- ----------------------------
-- DROP TABLE IF EXISTS `payed_log`;
-- CREATE TABLE `payed_log`(
--   `id` int unsigned NOT NULL AUTO_INCREMENT,
--   `uid`  int NOT NULL DEFAULT '' COMMENT '玩家ID',
--   `sid`  smallint(2) NOT NULL DEFAULT '' COMMENT '服务器ID',
--   `cid`  smallint(2) NOT NULL DEFAULT '' COMMENT '渠道ID',
--   `pay_func_id`          NOT NULL DEFAULT '' COMMENT '',
--   `pay_type_id`         NOT NULL DEFAULT '' COMMENT '',
--   `pay_post_url`        NOT NULL DEFAULT '' COMMENT '',
--   `payed_notice_url`     NOT NULL DEFAULT '' COMMENT '',
--   `exchange_rate`     NOT NULL DEFAULT '' COMMENT '',
--   `pay_unit`           NOT NULL DEFAULT '' COMMENT '',
--   `pay_currency`       NOT NULL DEFAULT 0  COMMENT ''
--   `pay_currency`       NOT NULL DEFAULT 0  COMMENT ''
-- )ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS=1;


-- ---------------------------------------------------------------------------


SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 日志相关数据库
-- ----------------------------
DROP   DATABASE IF EXISTS `sd_log`;
CREATE DATABASE           `sd_log`;
USE                       `sd_log`;

-- ----------------------------
-- 登录日志表
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`(
  `id`     int unsigned NOT NULL AUTO_INCREMENT,
  `uid`    int unsigned NOT NULL            COMMENT '玩家ID',
  `pid`    smallint(2)  NOT NULL            COMMENT '平台ID',
  `sid`    smallint(2) unsigned  NOT NULL   COMMENT '服务器ID',
  `cid`    smallint(2) unsigned  NOT NULL   COMMENT '渠道ID',
  `ip`     varchar(15)  NOT NULL DEFAULT '' COMMENT 'IP',
  `time`   char(10)     NOT NULL DEFAULT '' COMMENT '时间',
  `status` tinyint(1)   NOT NULL DEFAULT 1  COMMENT '状态 0失败|1成功',
  `client` varchar(32)  NOT NULL DEFAULT '' COMMENT '客户端',
  `remark` varchar(1000)         DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- 退出日志表
-- ----------------------------
DROP TABLE IF EXISTS `logout_log`;
CREATE TABLE `logout_log`(
  `id`     int unsigned NOT NULL AUTO_INCREMENT,
  -- `sid`    smallint(2) unsigned  NOT NULL   COMMENT '服务器ID',
  -- `cid`    smallint(2) unsigned  NOT NULL   COMMENT '渠道ID',
  -- `ip`     varchar(15)  NOT NULL DEFAULT '' COMMENT 'IP',
  -- `client` varchar(32)  NOT NULL DEFAULT '' COMMENT '客户端',
  `uid`    int unsigned NOT NULL            COMMENT '玩家ID',
  `time`   char(10)     NOT NULL DEFAULT '' COMMENT '时间',
  `status` tinyint(1)   NOT NULL DEFAULT 1  COMMENT '状态 0失败|1成功',
  `remark` varchar(1000)         DEFAULT '' COMMENT '备注',
  PRIMARY KEY(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS=1;