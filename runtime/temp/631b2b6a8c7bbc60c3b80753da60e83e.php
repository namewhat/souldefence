<?php if (!defined('THINK_PATH')) exit(); /*a:3:{s:96:"D:\wamp64\www\9d_admin\public/../application/admin\view\querydata\player_account_list\index.html";i:1504059374;s:74:"D:\wamp64\www\9d_admin\public/../application/admin\view\template\base.html";i:1499221492;s:85:"D:\wamp64\www\9d_admin\public/../application/admin\view\template\javascript_vars.html";i:1499219805;}*/ ?>
﻿<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <title><?php echo \think\Config::get('site.title'); ?></title>
    <link rel="Bookmark" href="__ROOT__/favicon.ico" >
    <link rel="Shortcut Icon" href="__ROOT__/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="__LIB__/html5.js"></script>
    <script type="text/javascript" src="__LIB__/respond.min.js"></script>
    <script type="text/javascript" src="__LIB__/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/Hui-iconfont/1.0.7/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/h-ui.admin/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="__STATIC__/css/app.css"/>
    <link rel="stylesheet" type="text/css" href="__LIB__/icheck/icheck.css"/>
    
    <!--[if IE 6]>
    <script type="text/javascript" src="__LIB__/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <!--定义JavaScript常量-->
<script>
    window.THINK_ROOT = '<?php echo \think\Request::instance()->root(); ?>';
    window.THINK_MODULE = '<?php echo \think\Url::build("/" . \think\Request::instance()->module(), "", false); ?>';
    window.THINK_CONTROLLER = '<?php echo \think\Url::build("___", "", false); ?>'.replace('/___', '');
</script>
</head>
<body>

<nav class="breadcrumb">
    <div id="nav-title"></div>
    <a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:;" title="刷新"><i class="Hui-iconfont"></i></a>
</nav>


	 <table class="table table-border table-bordered table-hover table-bg mt-20">
	    <caption>我是不会溢出的表格</caption>
	    <thead>
	    <tr>
	        <th width="50">编号</th>
	        <th width="100">用户名</th>
	        <th width="100">类型</th>
	        <th width="100">第三方关联标识</th>
	        <th width="100">创建时间</th>
	        <th width="100">账号状态</th>
	        <th width="100">手机号</th>
	        <th width="200">备注</th>
	        <th width="200">操作</th>
	    </tr>
	    </thead>
	    <tbody>
	<?php if(is_array($list) || $list instanceof \think\Collection || $list instanceof \think\Paginator): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?>
		<tr class="text-c">
			<th><?php echo $vo['id']; ?></th>		
			<th><?php echo $vo['username']; ?></th>		
			<th>暂无</th>		
			<th>暂无</th>		
			<th><?php echo $vo['ctime']; ?></th>		
			<th><?php echo $vo['status']; ?></th>		
			<th>暂无</th>		
			<th>暂无</th>		
			<th>暂无</th>		
		</tr>
	<?php endforeach; endif; else: echo "" ;endif; ?>
	    </tbody>
	</table>
    <div class="page-bootstrap"><?php echo $page; ?></div>

<script type="text/javascript" src="__LIB__/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="__LIB__/layer/2.4/layer.js"></script>
<script type="text/javascript" src="__STATIC__/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="__STATIC__/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="__STATIC__/js/app.js"></script>
<script type="text/javascript" src="__LIB__/icheck/jquery.icheck.min.js"></script>

</body>
</html>