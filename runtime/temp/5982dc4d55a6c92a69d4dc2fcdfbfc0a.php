<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:92:"D:\wamp64\www\souldefence\public/../application/admin\view\pay\pay_player_back_up\index.html";i:1502242581;}*/ ?>
<?php
/**
* 
*/
namespace app\admin\controller\recharge;

use think\View;
use think\Config;
use think\Request;
use think\Session;
use app\admin\Controller;

class LifeTimeValue extends Controller
{
	
	function __construct()
	{
		if (null === $this->view) {
		    $this->view = View::instance(Config::get('template'), Config::get('view_replace_str'));
		}
		if (null === $this->request) {
		    $this->request = Request::instance();
		}

		// 用户ID
		defined('UID') or define('UID', Session::get(Config::get('rbac.user_auth_key')));
	}

	public function index()
	{
		# code...
		return $this->view->fetch();
	}
}
?>