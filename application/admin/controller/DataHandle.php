<?php
namespace app\admin\controller;

use think\Controller;
use app\admin\model\Users;
use app\admin\model\RolesKey;

/**
* 
*/
class DataHandle extends Controller
{
	// 协议配置
	protected static $type_config = [];
	// 共同配置
	protected static $cm_config   = [];
	// 服务器ip配置
	protected static $server_ip   = [];
	// 当前操作ip
	protected static $remote_ip   = '';

	// 数据处理入口
	public static function handle($arr=[], $ip)
	{
		if (empty($arr)) return false;

		// 读取配置
		self::setConfig();
		self::$remote_ip = $ip;

		// 根据协议号判定行为
		$type = $arr['type_num'];
		switch ($type) {
			// 10000
			case self::$type_config['pr']:
				$user = new Users;
				return self::execute($arr, $user, "register", self::$type_config['prf']);
				break;
			// 10001
			case self::$type_config['pl']:
				$user = new Users;
				return self::execute($arr, $user, "login", self::$type_config['plf']);
				break;
			// 10010
			case self::$type_config['cr']:
				// 该操作只接收来自服务器的数据，即操作不能绕过服务器
				if (!in_array(self::$remote_ip, self::$server_ip)) return self::$cm_config['fb12'];
				$role = new RolesKey;
				return self::execute($arr, $role, "createRole", self::$type_config['crf']);
				break;
		}
	}
/*
	// 注册
	private static function register($arr=[])
	{
		if (empty($arr)) return false;
		$user = new Users();
		$message = self::object_to_array($arr['message']);
		$status = $user->register($message['msg']);
		return self::buildData(self::$type_config['prf'], $status);
	}

	// 登录
	private static function login($arr=[])
	{
		if (empty($arr)) return false;
		$user = new Users();
		$message = self::object_to_array($arr['message']);
		$status = $user->login($message['msg']);
		return self::buildData(self::$type_config['plf'], $status);
	}

	// 创建角色id
	private static function createRole($arr=[])
	{
		if (empty($arr)) return false;
		$role = new Roles();
		$message = self::object_to_array($arr['message']);
		$status = $role->createRole($message['msg']);
		return self::buildData(self::$type_config['crf'], $status);
	}*/

	private static function execute($arr, $obj, $method, $type)
	{
		if (empty($arr)) return false;
		// 转换数据格式
		$message = self::object_to_array($arr['message']);
		// 得到返回消息码
		$fb_msg = call_user_func_array([$obj, $method], $message);
		// 返回信息
		return self::buildData($type, $arr['net_id'], $fb_msg);
	}

	// 构造返回消息
	private static function buildData($type, $net, $msg)
	{
		if (preg_match('/\|/', $msg)) {
			$msg = explode('|', $msg);
		} else {
			$msg = [$msg];
		}
		if ($type == self::$type_config['crf'] and $msg[0]==0) {
			return [
				0 => $type,
				1 => $net,
				2 => (int)$msg[1],
				3 => '',
			];
		} 
		if ($type == self::$type_config['plf'] and $msg[0]==0)
		{
			return [
				0 => $type,
				1 => $net,
				2 => 0,
				3 => [
					(int)$msg[0],
					(int)$msg[1],
				],
		];
		}
		return [
			0 => $type,
			1 => $net,
			2 => 0,
			3 => $msg,

		];

	}

	// 读取配置
	private static function setConfig()
	{
		// 配置文件位置：application/admin/config
		self::$type_config = config('protocol_type');
		self::$server_ip   = config('server_ip');
		self::$cm_config   = config('feedback');
	}

	// stdClass对象转换成数组
	private static function object_to_array($arr)
	{
		if (is_object($arr)) $arr = (array)$arr;

		if (is_array($arr)) {
			foreach ($arr as $k => $v) {
				$arr[$k] = self::object_to_array($v);
			}
		}

		return $arr;
	}
}
?>