<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-14 14:06:47
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-28 15:18:50
 */
namespace app\admin\model;

class Cpfrtpl
{
    // 补货模板 列表
    public static function cpfrtplRun($param)
    {
    	$nodes = controller('Common') -> nodes();
        $db_cpfrtpl = db('goods_tpl');
        $where[] = ['status','=',2];
    	if(array_key_exists('keyword', $param)) array_push($where, ['name','like','%'.strtoupper($param['keyword']).'%']);
        if(array_key_exists('page', $param)){
            $result = $db_cpfrtpl->where($where)->limit(($param['page']-1)*$param['limit'],$param['limit'])->order('id DESC')->select();
        }else{
            $result = $db_cpfrtpl -> where($where) -> select();
        }
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $result[$k]['goods_count'] = db('goods_tpl_lines') -> where('tpl_id',$v['id']) -> count();
            }
            _success($result, $db_cpfrtpl->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 补货模板 添加
    public static function cpfrtplAddRun($param)
    {
        $dataTime = date('Y-m-d H:i:s');
        $goods_total_number = 0;
        $goods_total_money = 0;
        // 模板商品总数量、总价格
        foreach ($param['goods'] as $k => $v) {
            $goods_total_number += $v['goods_number'];
            $goods_total_money += $v['goods_price'] * $v['goods_number'];
        }
        $tpl_id = db('goods_tpl') -> insertGetId([
            'name' => $param['name'],
            'goods_total_number' => $goods_total_number,
            'goods_total_money' => $goods_total_money,
            'time' => $dataTime
        ]);
        foreach ($param['goods'] as $k => $v) {
            $param['goods'][$k]['tpl_id'] = $tpl_id;
        }
        db('goods_tpl_lines') -> insertAll($param['goods']);
        _success();
    }
    // 补货模板 编辑
    public static function cpfrtplEditRun($param)
    {
        db('goods_tpl') -> update(['id'=>$param['id'],'name'=>$param['name']]);
        // 模板商品处理
        $db_goods_tpl_lines = db('goods_tpl_lines');
        $db_goods_tpl_lines -> where('tpl_id',$param['id']) ->delete();
        foreach ($param['goods'] as $k => $v) {
            $param['goods'][$k]['tpl_id'] = $param['id'];
        }
        $db_goods_tpl_lines -> insertAll($param['goods']);
        _success();
    }
    // 补货模板 删除
    public static function cpfrtplDelRun($param)
    {
        foreach ($param['ids'] as $k => $v) {
            db('warehouse') -> where('id',$v) -> setField('status',1);
        }
        _success();
    }
    // 补货模板 状态
    public static function cpfrtplStatusRun($param)
    {
        if(db('cpfrtpl')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 已选择的商品
    public static function goodsTplLinesRun($param)
    {
        $result = db('goods_tpl_lines') -> where('tpl_id',$param['tpl_id']) -> select();
        if(!empty($result)) _success($result);
    }
}