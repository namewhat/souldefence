<?php
/**
 * tpAdmin [a web admin based ThinkPHP5]
 *
 * @author    yuan1994 <tianpian0805@gmail.com>
 * @link      http://tpadmin.yuan1994.com/
 * @copyright 2016 yuan1994 all rights reserved.
 * @license   http://www.apache.org/licenses/LICENSE-2.0
 */

use \think\Request;

// 引入自定义数据库配置，非框架自带
$database2_config = require_once(APP_PATH.'/database2.php');

$basename = Request::instance()->root();
if (pathinfo($basename, PATHINFO_EXTENSION) == 'php') {
    $basename = dirname($basename);
}

return [
    // 模板参数替换
    'view_replace_str' => [
        '__ROOT__'   => $basename,
        '__STATIC__' => $basename . '/static/admin',
        '__LIB__'    => $basename . '/static/admin/lib',
    ],

    // traits 目录
    'traits_path'      => APP_PATH . 'admin' . DS . 'traits' . DS,

    // 异常处理 handle 类 留空使用 \think\exception\Handle
    'exception_handle' => '\\TpException',

    'template' => [
        // 模板引擎类型 支持 php think 支持扩展
        'type'            => 'Think',
        // 模板路径
        'view_path'       => '',
        // 模板后缀
        'view_suffix'     => '.html',
        // 预先加载的标签库
        'taglib_pre_load' => 'app\\admin\\taglib\\Tp',
        // 默认主题
        'default_theme'   => '',
    ],


    // +----------------------------------------------------------------------
    // | 自定义应用设置，非框架自带
    // +----------------------------------------------------------------------
    'db2_config' => $database2_config,

    // Socket类配置
    'remote_server' => [
        'host' => [
            '192.168.95.137',
            '127.0.0.1',
        ],
        'port' => [
            '8003',
            '8001',
        ],
    ],

    // 服务器ip
    'server_ip' => [
        '127.0.0.1',
        '192.168.50.80',
        '192.168.50.54',
    ],

    // 与服务器约定的协议号，可自行约定
    'protocol_type' => [
        'pr'  => 1,   // 账号注册(player register)
        'pl'  => 2,   // 账号登录(player login)
        'cr'  => 12,  // 创建角色码(create role)
        'gl'  => 4,   // 
        'prf' => 101, // 账号注册消息反馈(player register feedback)
        'plf' => 102, // 账号登录消息反馈(player login feedback)
        'crf' => 112, // 创建角色码消息反馈(create role feedback)
        'glf' => 104, // 
    ],

    // 消息返回码
    'feedback' => [
        'fb05' =>  5, // 密码不正确
        'fb04' =>  4, // 字符非法
        'fb03' =>  3, // 长度非法
        'fb02' =>  2, // 不存在
        'fb01' =>  1, // 已存在
        'fb00' =>  0, // 操作成功
        'fb11' => -1, // 参数不足
        'fb12' => -2, // 信息不是来自服务器
        'fb13' => -3, // 达到容量上限
        'fb14' => -4, // 系统错误
        'fb15' => -5, // 未知错误
    ],

];
