<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

namespace think\worker;

use Workerman\Worker;

/**
 * Worker控制器扩展类
 */
abstract class Server
{
    protected $worker;
    protected $socket    = '';
    protected $protocol  = 'http';
    protected $host      = '0.0.0.0';
    protected $port      = '2346';
    protected $processes = 4;

    /**
     * 架构函数
     * @access public
     */
    public function __construct()
    {
        // 实例化 Websocket 服务
        $this->worker = new Worker($this->socket ?: $this->protocol . '://' . $this->host . ':' . $this->port);
        // 设置进程数
        $this->worker->count = $this->processes;
        // 初始化
        $this->init();

        // 设置回调
        foreach ([
            // 当客户端的连接上发生错误时触发
            'onError', 
            // 当客户端连接与Workerman断开时触发
            'onClose', 
            // 当客户端通过链接发来数据时(Workerman收到数据时)触发
            'onMessage', 
            // 当客户端与Workerman建立链接时(TCP三次握手完成后)触发的回调函数。每个连接只会触发一次onConnect回调
            'onConnect', 
            // 当Worker关闭后立即执行
            'onWorkerStop', 
            // 当超过TcpConnection::$maxSendBufferSize上限时触发
            'onBufferFull',
            // 当Worker启动后立即执行 
            'onWorkerStart', 
            // 当应用层发送缓冲区数据全部发送完毕后触发
            'onBufferDrain',
            // 当Worker重启后立即执行
            'onWorkerReload'
            ] as $event) {
            if (method_exists($this, $event)) {
                $this->worker->$event = [$this, $event];
            }
        }
        // Run worker
        Worker::runAll();
    }

    protected function init()
    {
    }

}
