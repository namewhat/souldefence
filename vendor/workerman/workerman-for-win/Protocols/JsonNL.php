<?php
namespace Workerman\Protocols;

use Workerman\Connection\AsyncTcpConnection;

class JsonNL extends AsyncTcpConnection
{
    // 协议头长度
    const PACKAGE_HEAD_LEN = 12;

    // 包头的压包/解包参数
    protected static $net_char = 'N';
    protected static $head_char = 'S';
    protected static $type_char  = 'S';
    protected static $player_char = 'N';

    // 包结构
    protected static $total_len; // 总长度, 2字节, 消息体的总长度 = 协议头长度（12字节） + 消息本身的长度（XX字节）
    protected static $type_num;  // 协议号, 2字节
    protected static $net_id;    // 网络号, 4字节
    protected static $player_id; // 玩家id, 4字节
    protected static $message;   // 消息体，x字节

    public static function input($recv_buffer)
    {
        // 如果不够一个协议头的长度，则继续等待
        if(strlen($recv_buffer) < self::PACKAGE_HEAD_LEN)
        {
            return 0;
        }
        // 解包
        // $package_data = unpack(
        //     self::$head_char."total_len/".
        //     self::$type_char."type_num/".
        //     self::$net_char."net_id/".
        //     self::$player_char."player_id", $recv_buffer
        // );
        $package_data = unpack(self::$head_char."total_len", $recv_buffer);
        // 返回包长
        return $package_data['total_len'];
    }


    public static function decode($recv_buffer)
    {
        // 解包
        $package_data = unpack(
            self::$head_char."total_len/".
            self::$type_char."type_num/".
            self::$net_char."net_id/".
            self::$player_char."player_id", $recv_buffer
        );
        // 返回解包后的数据
        $tmp = substr($recv_buffer, self::PACKAGE_HEAD_LEN);
        $package_data['message'] = json_decode($tmp);
        return $package_data;
    }

    public static function encode($data)
    {
        /*
        包结构：
        ---------------------------------------------------------
        |   字段   |     字节数    |   说明                     |
        ---------------------------------------------------------
        |   包头   | 定长（12字节）| 每个通信消息必须包含的内容 |
        ---------------------------------------------------------
        |   包体   | 不定长        | 根据消息的不同而变化       |
        ---------------------------------------------------------

        包头结构：
        ------------------------------------------------
        |     字段      | 字节数 | 类型  |  说明       |
        ------------------------------------------------
        |   total_len   |    2   | short |整个包的长度 |
        ------------------------------------------------
        |   type_num    |    2   | short |协议号       |
        ------------------------------------------------
        |   net_id      |    4   | int   |网络号       |
        ------------------------------------------------
        |   player_id   |    4   | int   |玩家ID       |
        ------------------------------------------------

        包体：
        ------------------------------------------------
        |   data        |   未知  | char |通信消息     |
        ------------------------------------------------
        */
        if (is_array($data)) {
            self::$type_num  = $data[0];
            self::$net_id    = $data[1];
            self::$player_id = $data[2];
            self::$message   = $data[3];

            // 1.构造包体
            $bin_body  = json_encode(['msg'=>self::$message]);
        } else {
            self::$type_num  = $data;
            self::$net_id    = 0;
            self::$player_id = 0;

            // 1.构造包体
            $bin_body = '';
        }

        // 2.构造包头
        self::$total_len = self::PACKAGE_HEAD_LEN + strlen($bin_body);
        $bin_head = pack(
            self::$head_char.
            self::$type_char.
            self::$net_char.
            self::$player_char,
            
            self::$total_len,
            self::$type_num,
            self::$net_id,
            self::$player_id
        );

        // 3.返回消息包
        $bin_data = $bin_head . $bin_body;
        return $bin_data;
    }  
}
