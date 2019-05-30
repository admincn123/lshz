<?php

namespace app\admin\controller;

use app\admin\model\Advert as advertModel;

class Advert extends Common
{
    // 用户 列表
    public function add()
    {
        $param = _request('POST');
        advertModel::add($param);
    }

    public function advertEdit(){
        $param = _request('POST');
        advertModel::advertEdit($param);
    }

    public function advertDel(){
        $param = _request();
        advertModel::advertDel($param);
    }

    public function adverts()
    {
        $param = _request();
        advertModel::adverts($param);
    }
}