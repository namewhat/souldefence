<?php
namespace app\admin\model;

use think\Model;
/**
* 
*/
class RolesKey extends Model
{
	// 项目数据库配置，加载位置app\admin\config.php，具体配置位置app\database2.php
	protected $connection = 'db2_config';
	
	// 当前模型对应的完整数据表名称
	protected $table = 'roles_key';

	// 消息码配置feedback code
	protected static $fb_code = [];

	// 服务器(id):计数(counter)
	private static $map = [];

	// 每个服务器的最大数值
	protected static $max_counter = 30000000;

	public function createRole($arr)
	{
		// 上来就是获取配置信息
		self::setConfig();

		// 检查参数是否足够
		if (count($arr) < 2) return self::$fb_code['fb11'];

		// 检查当前用户在当前服务器下是否创建过角色
		if ($res = self::checkRole($arr[2], $arr[3])) return $res;
		
		// 创建角色码
		$res = $this->recordRole($arr);

		// 返回结果
		return $res;
	}

	private static function getKey($sid)
	{
		if (empty($sid)) return false;

		$server = "server{$sid}";

		// 判断当前服务器是否有计数
		if (!array_key_exists($server, self::$map)) {
			// 如果没有，就设置为1
			self::$map[$server] = 1;
		} else {
			// 如果有，就增1
			self::$map[$server] ++;
		}

		$base = $sid<<20;
		// 返回角色唯一码（算法可自行与服务器端约定）
		return self::$map[$server] + $base;
	}

	// 检查角色是否存在
	private static function checkRole($uid, $sid)
	{
		if ($res = self::get(['uid'=>$uid, 'sid'=>$sid])) return  implode('|', [self::$fb_code['fb01'], $res->rkey]);
		return 0;
	}

	// 记录角色
	private function recordRole($arr)
	{
		$rkey = self::getKey($arr[3]);

		// sid与rkey联合唯一
		if (self::get(['sid'=>sid, 'rkey'=>$rkey])) self::recordRole($arr);

		// 达到服务器容量上限
		if ($rkey> self::$max_counter) return self::$fb_code['fb13'];

		echo "当前码：$rkey\n";

		$this->data([
			'uid'   => $arr[2],
			'sid'   => $arr[3],
			'rkey'  => $rkey,
		]);
		$res = $this->isUpdate(false)->save();
		
		return $res? implode('|', [0, $this->rkey]): self::$fb_code['fb14'];
	}

	// 读取配置
	private static function setConfig()
	{
		self::$fb_code = config('feedback');
	}
}

?>