<?php
/**
* 
*/
namespace app\admin\controller\pay;

use think\View;
use think\Config;
use think\Request;
use think\Session;
use app\admin\Controller;

class PayPlayerBackUp extends Controller
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