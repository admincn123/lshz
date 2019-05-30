<?php

namespace app\admin\model;

class Order
{

    // 订单列表
    public static function ordersRun($param)
    {
        $nodes = controller('Common')->nodes();
        $db_order = db('user_order');
        $query = $db_order->alias('o')->leftJoin('user u', 'u.id = o.user_id')
            ->leftJoin('agent a', 'a.id = o.agent_id')
            ->leftJoin('boxs b', 'b.id = o.boxs_id')
            ->leftJoin('code c', 'o.status=c.id')
            ->where('o.is_delete', '=', 1);

        if (isset($param['start_date']) && $param['start_date']) {
            $query->where('o.time', '>=', $param['start_date']);
        }
        if (isset($param['end_date']) && $param['end_date']) {
            $query->where('o.time', '<=', $param['end_date']);
        }


        $result = $query
            ->limit(($param['page'] - 1) * $param['limit'], $param['limit'])->order('o.time  DESC')
            ->field('o.id, o.order_number, o.goods_total_money, o.status, o.time, u.nickname, a.name agent_name, b.name , c.message status_text')
            ->select();

        $orderIds = array_column($result, 'id');
        $ordersLines = db('user_order_lines')->whereIn('order_id', $orderIds)->order('time ASC')->select();

        foreach ($result as &$item){
            $goodsNames = [];
            foreach ($ordersLines as $k=>$line){
                if($item['id'] === $line['order_id']){
                    $goodsNames[]= $line['goods_name'];
                    unset($ordersLines[$k]);
                }
            }
            $item['goods_names'] = implode('|', $goodsNames);
        }
        
        _success($result, $query->count(), $nodes);
    }

    public static function orderDel($param)
    {
        $result  = db('user_order')->whereIn('id', $param['ids'])->update(['is_delete'=>'2']);
        if($result < 1 ){
            _error('删除失败');
        }
        _success();
    }

}
