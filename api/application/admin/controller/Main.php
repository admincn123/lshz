<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-03-11 01:00:44
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-24 10:38:53
 */
namespace app\admin\controller;
use app\admin\model\Main as mainModel;

class Main extends Common
{
    // 统计
    public function countAll()
    {
        mainModel::countAllRun();
    }
    // 修改密码
    public function editPwd()
    {
        $param  = _request();
        mainModel::editPwdRun($param);
    }
    // 登录日志
    public function signLog()
    {
        $param = _request();
        mainModel:: signLogRun($param);
    }
    // 清除登录日志前100条
    public function signLogDel()
    {
        mainModel::signLogDelRun();
    }
}