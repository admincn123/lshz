<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-21 09:34:24
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-28 14:45:47
 */
namespace app\admin\model;

class Agent
{
    // 代理商 列表
    public static function agentRun($param)
    {
    	$nodes = controller('Common') -> nodes();

        $db_agent = db('agent');
        $where[] = ['status','=',2];
    	if(array_key_exists('keyword', $param)) $where[] = ['name|phone','like','%'.strtoupper($param['keyword']).'%'];
        $result = $db_agent->where($where)->limit(($param['page']-1)*$param['limit'],$param['limit'])->order('id DESC')->select();

        if(!empty($result)){
            foreach ($result as $k => $v) {
                $result[$k]['boxs'] = db('boxs') -> where('agent_id',$v['id']) -> select();
            }
            _success($result, $db_agent->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 代理商 添加
    public static function agentAddRun($param)
    {
        $boxs_id = [];
        foreach ($param['boxs_id'] as $k => $v) {
            $boxs_id[] = $k;
        }
        $param = _arr_handle($param, ['boxs_id'], 'del');
        $param['time'] = date('Y-m-d H:i:s');
        if($agent_id = db('agent') -> insertGetId($param)){
            db('boxs') -> whereIn('id',$boxs_id) -> setField('agent_id',$agent_id);
            _success();
        }else{
            _error();
        }
    }
    // 代理商 编辑
    public static function agentEditRun($param)
    {
        $boxs_id = [];
        foreach ($param['boxs_id'] as $k => $v){
            $boxs_id[] = $k;
        }
        $param = _arr_handle($param, ['boxs_id'], 'del');
        if(db('agent') -> update($param))
        db('boxs') -> where('agent_id',$param['id']) -> setField('agent_id',0);
        db('boxs') -> whereIn('id',$boxs_id) -> setField('agent_id',$param['id']);
        _success();
    }
    // 代理商 删除
    public static function agentDelRun($param)
    {
        if(db('agent') -> whereIn('id',$param['ids']) -> setField('status',1)){
            _success();
        }else{
            _error();
        }
        
    }
    // 代理商 结账查询
    public static function settleQueryRun($param)
    {
        // 查询盘点损耗统计
        $where = [
            ['agent_id','=',$param['agent_id']],
            ['is_settle','=',16],
            ['time','between',[$param['stime'],$param['etime']]]
        ];
        $agent_inventory = db('agent_inventory') -> where($where) -> select();
        // 查询用户订单总价统计
        $user_order = db('user_order') -> where($where) -> select();
        if(!empty($agent_inventory) && !empty($user_order)){
            // 损耗统计
            $agent_inventory_ids = []; $shje = 0;
            foreach ($agent_inventory as $k => $v) {
                $agent_inventory_ids[] = $v['id'];
                $shje += $v['goods_loss_money'];
            }
            // 用户订单总价统计
            $user_order_ids = []; $xsje = 0;
            foreach ($user_order as $k => $v) {
                $user_order_ids[] = $v['id'];
                $xsje += $v['goods_total_money'];
            }
            $data = [
                "agent_inventory_ids" => $agent_inventory_ids,
                "shje" => $shje,
                "user_order_ids" => $user_order_ids,
                "xsje" => $xsje,
                "yjje" => $xsje - $shje
            ];
            _success($data);
        }else{
             _nothing('暂无结账数据');
        }
    }
    // 代理商 结账
    public static function settleRun($param)
    {
        // 更新盘点表状态
        db('agent_inventory') -> whereIn('id',$param['agent_inventory_ids']) -> setField('is_settle',17);
        // 更新用户订单表状态
        db('user_order') -> whereIn('id',$param['user_order_ids']) -> setField('is_settle',17);
        // 插入结账记录
        db('agent_settle') -> insert([
            'agent_id' => $param['agent_id'],
            'start_time' => $param['stime'],
            'end_time' => $param['etime'],
            'sell_money' => $param['xsje'],
            'loss_money' => $param['shje'],
            'pay_money' => $param['yjje'],
            'time' => date('Y-m-d H:i:s')
        ]);
        _success();
    }
    // 结账记录
    public static function settleLogRun($param)
    {
        $result = db('agent_settle')
        -> where('agent_id',$param['agent_id'])
        -> limit(($param['page']-1) * $param['limit'], $param['limit'])
        -> order('id DESC')
        -> select();
        if(!empty($result)){
            _success($result);
        }else{
            _nothing();
        }
    }
}