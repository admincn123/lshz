<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-01-29 13:09:47
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-04-17 16:28:49
 */
namespace app\admin\controller;
use think\Controller;
use app\admin\model\Logreg as logregModel;

class Logreg extends Controller
{
    // 登录视图
    public function login()
    {
        return $this -> fetch();
    }
    // 登录
    public function sign()
    {
        logregModel::signRun();
    }
    // 退出
    public function signOut()
    {
        session(null);
        _success();
    }
}