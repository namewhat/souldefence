<?php
namespace app\admin\controller\querydata;

use think\Controller;

use app\admin\model\Users;
/**
* 
*/
class PlayerAccountList extends Controller
{
	
	public function index()
	{
		$model = new Users();

		$map = [];
		
		$fields = 'u.*';

		$rows = 20;

		$list = $model->alias('u')->field($fields)->where($map)->order('u.id desc')->paginate(['query' => $this->request->get()]);

		$this->assign('list', $list);
		$this->assign('page', $list->render());
		$this->assign('count', $list->total());
		
		return $this->fetch();
	}
}
?>