<?php

namespace app\admin\controller;

use app\admin\model\Placard as PlacardModel;

class Placard extends Common
{
    public function save()
    {
        $param = _request('POST');
        $placard = new PlacardModel();
        $placard->content = $param['content'];
        $placard->time = date('Y-m-d H:i:s');
        $placard->admin_id = session('uid');

        if ($placard->save()) {
            _success();
        }
        _error();
    }

    public function first()
    {
        $placard = PlacardModel::order('time', 'DESC')->find();
        _success($placard);
    }
}