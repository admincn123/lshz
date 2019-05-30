<?php

namespace app\admin\controller;
use app\admin\model\User as userModel;

class User extends Common
{
    // 用户 列表
    public function users()
    {
        $param = _request();
        userModel::userRun($param);
    }
}