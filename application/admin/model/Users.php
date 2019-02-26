<?php
namespace app\admin\model;

use think\Model;
/**
* 
*/
class Users extends Model
{
	// 项目数据库配置，加载位置app\admin\config.php，具体配置位置app\database2.php
	protected $connection = 'db2_config';
	
	// 当前模型对应的完整数据表名称
	protected $table = 'users';

	// 消息码配置feedback code
	protected static $fb_code = [];

	// 账号注册
	public function register($arr)
	{
		// 上来就先取配置信息
		self::setConfig();

		// 参数不足
		if (count($arr) < 4) return self::$fb_code['fb11'];

		$uname = $arr[0];
		$pword = $arr[1];

        // 如果通过字符检测
		if (!$res = self::checkChar($uname, $pword)) {
		    // 如果此用户名还没被注册
			if (!$res = self::checkUser($uname)) {
				// 则记录到数据库
				return $this->recordUser($arr);
		    // 此用户名已被注册
			} else { return $res;}
        // 字符不合法
		} else { return $res;}
	}

	// 账号登录（未选择服务器）
	public function login($arr)
	{
		// 上来就先取配置信息
		self::setConfig();

		// 参数不足
		if (count($arr) < 2) self::$fb_code['fb11'];

		$uname = $arr[0];
		$pword = $arr[1];

		// 检查用户是否存在
		if (!self::checkUser($uname)) return self::$fb_code['fb02'];

		// 获取用户数据
		$udata = self::getUser($uname);
		// 密码验证
		// $pword = password_hash($pword, PASSWORD_DEFAULT);
		if ($pword != $udata['password']) return self::$fb_code['fb05'];

		return implode('|', [self::$fb_code['fb00'], $udata['id']]);
	}

	// 游戏登录（当选择服务器的时候）
	public static function loginGame()
	{
		# code...
	}

	// 玩家退出
	public static function logout($value='')
	{
		# code...
	}

	// -----------------   以上是业务逻辑  -------------------- //







	// -----   我是喧哗上等的超级无敌勇猛之一夜七次分割线  ---- // 






	// -----------------   以下是辅助方法  -------------------- //



	// 把账号和密码等相关信息记录到数据库
	private function recordUser($arr)
	{
		// 因为data是实例属性(参考tp5框架中的模型),所以当前方法不设为静态方法
		$this->data([
		    'username' => $arr[0],
		    'password' => $arr[1],
		    'pid'      => $arr[2],
		    'cid'      => $arr[3],
		    // 'ukey'     => $this->guid(),
		    'ctime'    => time(),
		    'status'   => 1,
		    // 'telphone' => '1383233212',
		    // 'email'    => 'someene@ebe.con',
		    // 'status'   =>$arr->status,
		    // 'telphone' =>$arr->telphone,
		    // 'email'    =>$arr->email,
		    ]);
		$res = $this->isUpdate(false)->save();

		return $res? self::$fb_code['fb00']: self::$fb_code['fb13'];
	}

	/*
	* 该函数来自网络(关键字: php guid uuid)，用于生成类似下面那样的唯一标识
	* '6221C957-5FDB-09B1-CF47-9E69D69899CF'
	* '3AF9092D-8697-7BA0-ACE9-3161B35FA36E'
	* '94161090-EE4C-949B-C985-52DBE65381D5'
	*/
	/*private function guid()
	{
		if (function_exists('com_create_guid')) return com_create_guid();

        mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $hyphen = chr(45);// "-"
        $uuid   = chr(39)// "'"
            .substr($charid, 0, 8).$hyphen
            .substr($charid, 8, 4).$hyphen
            .substr($charid,12, 4).$hyphen
            .substr($charid,16, 4).$hyphen
            .substr($charid,20,12)
            .chr(39);    // "'"
        return $uuid;
	}*/

	// 检查账号是否存在
	private static function checkUser($uname)
	{
		if (self::where('username', $uname)->find()) return self::$fb_code['fb01'];
		return 0;
	}

	// 校验账号
	private static function checkChar($uname, $pword)
	{
		// 清除空格
		$uname = trim($uname);
		
		// 获取长度
		$un_len = strlen($uname);

		// 正则表达式
		$un_pt = "/[^a-zA-Z0-9]+/";

		// 长度为6-20
		if ($un_len<6 or $un_len>20) return self::$fb_code['fb03'];

		// 匹配到合法字符之外的字符
		if (preg_match($un_pt, $uname)) return self::$fb_code['fb04'];

		// 验证通过
		return 0;
	}

	// 获取用户数据
	private static function getUser($uname)
	{
		return self::getByUsername($uname);
	}

	private static function loginLog($value='')
	{
		# code...
	}

	private static function setConfig()
	{
		self::$fb_code = config('feedback');
	}
}

?>