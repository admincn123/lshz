<?php

namespace app\admin\controller;

use app\admin\model\Order as orderModel;

class Order extends Common
{
    // 订单 列表
    public function orders()
    {
        $param = _request();
        orderModel::ordersRun($param);
    }

    public function orderDel()
    {
        $param = _request();
        orderModel::orderDel($param);
    }


}