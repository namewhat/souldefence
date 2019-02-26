<?php 
class Test 
{
	private static $ip   = '127.0.0.1';
	private static $port = '2008';
	private static $char = 'abcdefghijklnmopqrstuvwsyzABCDEFGHIJKLNMOPQRSTUVWXYZ1234567890';
	private static $map  = [1,2,3,4,5,6,7,8,9];

	private static $su = 1;
	private static $si = 2;
	private static $ck = 12;

	public static function execute($arr, $class, $method)
	{
		error_reporting(E_ALL); 

		set_time_limit(0);
		
		return call_user_func_array([$class, $method], [$arr]);
	}

	private static function signup($arr)
	{
		if (!$arr) return 0;

		$s = self::createSocket();

		$c = self::connectSocket($s, self::$ip, self::$port);

		$b = self::packup($arr, self::$su);

		$w = self::send($s, $b);

		$m = self::get($s);

		return $m;
	}

	private static function signin($arr)
	{
		if (!$arr) return 0;

		$s = self::createSocket();

		$c = self::connectSocket($s, self::$ip, self::$port);

		$b = self::packup($arr, self::$si);

		$w = self::send($s, $b);

		$m = self::get($s);

		return $m;
	}

	private static function createKey($arr)
	{
		if (!$arr) return 0;

		$s = self::createSocket();

		$c = self::connectSocket($s, self::$ip, self::$port);

		$b = self::packup($arr, self::$ck);

		$w = self::send($s, $b);

		$m = self::get($s);

		return $m;
	}

	public static function setHost($ip, $port)
	{
		self::$ip   = $ip;
		self::$port = $port;
	}
	
	private static function createSocket()
	{
		$s = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);

		return ($s<0) ? socket_strerror($s) : $s ; 
	}

	private static function connectSocket($socket, $ip, $port)
	{
		$c = socket_connect($socket, $ip, $port);

		return ($c<0) ? socket_strerror($c) : $c ;
	}

	private static function packup($arr, $type, $net=0, $pid=0)
	{
		$bin_body = json_encode($arr);

		$bin_head = pack("SSNN", strlen($bin_body)+12, $type, $net, $pid);

		return $bin_data = $bin_head.$bin_body;
	}

	private static function send($socket, $data)
	{
		$w = socket_write($socket, $data, strlen($data));

		return ($w) ? $w : socket_strerror($socket) ;
	}

	private static function get($socket, $size=8192)
	{
		// 读取包头
		$b = @socket_read($socket, 12);
		// 解压包头
		$h = unpack("Sa/Sb/Nc/Nd", $b);
		// 所要读取的数据长度
		$nr = $h['a'];
		// 已读取的长度
		$rd = 0;
		// 已读数据
		$msg = '';

		while ($rd < $nr-12) {
			// 读取一部分字节流
			$r = socket_read($socket, $size, PHP_BINARY_READ);
			// 保存已读字节流
			$msg .= $r;
			// 更新已读长度
			$rd += strlen($r);
		}

		$msg = json_decode($msg, true);

		socket_close($socket);

		return $h['d'] == 0 ? $msg : $h['d'];
	}

	public static function getChar($len)
	{
		$l = strlen(self::$char);
		
		$c = '';

		for ($i=0; $i < $len; $i++) { 
		
			$j = rand(0, $l-1);
		
			$c .= substr(self::$char, $j, 1);
		}

		return $c;
	}

	public static function getId()
	{
		$l = count(self::$map);

		$i = rand(1,$l-1);
		
		return self::$map[$i];
	}
}
$t1 = microtime(true);

$data = [];
for ($i=0; $i < 1; $i++) { 
	$arr   = [];
	$arr[] = Test::getChar(6);
	$arr[] = Test::getChar(6);
	$arr[] = Test::getId();
	$arr[] = Test::getId();
	$data[] = $arr;
	echo "注册接收数据样本：";
	var_dump(json_encode([$arr]));
	$msg   = Test::execute([$arr], "Test", "signup");
}
foreach ($data as $k => $v) {
	echo "登录接收数据样本：";
	var_dump(json_encode([$v]));
	$msg = Test::execute([$v], "Test", "signin");
	$data[$k][] = $msg['msg'][1];
}
foreach ($data as $k => $v) {
	$s = Test::getId();
	echo "角色码接收数据样本：";
	var_dump(json_encode([[$v[0], $v[1], $v[4], $s]]));
	$msg = Test::execute([[$v[0], $v[1], $v[4], $s]], "Test", "createKey");
	$data[$k][] = $msg;
}
$t2 = microtime(true);
echo "运行时长：".(($t2-$t1)*1000).'ms';
?> 
