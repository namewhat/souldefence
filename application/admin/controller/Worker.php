<?php
namespace app\admin\controller;

use think\worker\Server;
use Workerman\Connection\AsyncTcpConnection;

use app\admin\controller\DataHandle;
use app\admin\controller\DataSendBack;

class Worker extends Server
{
    protected $socket = 'JsonNL://0.0.0.0:2008';

    /**
     * 收到信息
     * @param $connection
     * @param $data
     */
    public function onMessage($connection, $data)
    {
        print_r($data);
        $remote_ip = $connection->getRemoteIp();
        // 数据处理
        $result = DataHandle::handle($data, $remote_ip);
        echo "数据返回样本：";
        print_r($result);
        // 根据状态码构建返回消息
        // $send_back_msg = DataSendBack::build($result);
        // 返回消息的同时关闭连接
        $connection->send($result);
        /*// -------------------1-------------------
        // 每个连接接收100个请求后就不再接收数据
        $limit = 100;
        if(++$connection->messageCount > $limit)
        {
            $connection->pauseRecv();
            // 30秒后恢复接收数据
            Timer::add(30, function($connection){$connection->resumeRecv();}, array($connection), false);
        }

        // ------------------2--------------------
        $connection->send("爸爸已收到你的信息\n");*/

    }

    /**
     * 当连接建立时触发的回调函数
     * @param $connection
     */
    public function onConnect($connection)
    {
        // --------------------1----------------------
        // 给connection对象动态添加一个属性，用来保存当前连接发来多少个请求
        $connection->messageCount = 0;

        // -------------------3-----------------------
        $remove_ip = $connection->getRemoteIp();
        echo "new client address: $remove_ip\n";

       /* // -------------------4--------------------
        // 建立本地80端口的异步连接
        $connection_to_80 = new AsyncTcpConnection('tcp://127.0.0.1:80');
        // 设置将当前客户端连接的数据导向80端口的连接
        $connection->pipe($connection_to_80);
        // 设置80端口连接返回的数据导向客户端连接
        $connection_to_80->pipe($connection);
        // 执行异步连接
        $connection_to_80->connect();*/
    }

    /**
     * 当连接断开时触发的回调函数
     * @param $connection
     */
    public function onClose($connection)
    {
        $remove_ip = $connection->getRemoteIp();
        echo "closed address: $remove_ip\n";
    }

    /**
     * 当客户端的连接上发生错误时触发
     * @param $connection
     * @param $code
     * @param $msg
     */
    public function onError($connection, $code, $msg)
    {
        echo "error $code $msg\n";
    }

    /**
     * 每个进程启动
     * @param $worker
     */
    public function onWorkerStart($worker)
    {
        echo "worker starting...\n";
    }
}