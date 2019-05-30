<?php
namespace app\admin\model;

class User
{
    // 用户列表
    public static function userRun($param)
    {
        $nodes = controller('Common') -> nodes();
        $db_user = db('user');
        $result = $db_user->limit(($param['page']-1)*$param['limit'], $param['limit'])->order('total_money  DESC')->select();

        if(empty($result)){
            _error('', $nodes);
        }
        _success($result, $db_user->count(), $nodes);
    }

}
