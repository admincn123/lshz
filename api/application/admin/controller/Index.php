<?php
namespace app\admin\controller;
use app\admin\model\System;

class Index extends Common
{
    // 首页视图
    public function index()
    {
        return $this -> fetch();
    }
}