<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-09 10:50:46
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-15 17:50:13
 */
namespace app\admin\model;

class Goods
{
    // 商品 列表
    public static function goodsRun($param)
    {
        $nodes = controller('Common') -> nodes();
        $db_goods = db('goods');
        $result = $db_goods -> where('status',2) -> limit(($param['page']-1) * $param['limit'],$param['limit']) -> order('id DESC') -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $type_name = db('goods_classify') -> where('id',$v['classify_id']) -> value('name');
                $result[$k]['type_name'] = $type_name;
                $status_name = db('code') -> where('id',$v['status']) -> value('message');
                $result[$k]['status_name'] = $status_name;
            }
            _success($result, $db_goods->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 商品 添加
    public static function goodsAddRun($param)
    {
        $param['time'] = date('Y-m-d H:i:s');
        if(db('goods')->insertGetId($param)){
            _success();
        }else{
            _error();
        }
    }
    // 商品 编辑
    public static function goodsEditRun($param)
    {
        if(db('goods')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 商品 删除
    public static function goodsDelRun($param)
    {
        $msg = '';
        foreach ($param['ids'] as $k => $v) {
            // 如该商品已添加到盒子，禁止删除
            if(db('boxs_list') -> where('goods_id',$v) -> find()) $msg = '禁止删除盒子商品 ID：'.$v;
        }
        if(!$msg){
            foreach ($param['ids'] as $k => $v) {
                db('goods') -> where('id',$v) -> setField('status',1);
            }
            _success();
        }else{
            _error($msg);
        }
    }
    // 商品 状态
    public static function goodsStatusRun($param)
    {
        if(db('goods')->update($param)){
            _success();
        }else{
            _error();
        }
    }




	// 分类 列表
    public static function typeRun($param)
    {
        // 页面操作节点集
        $nodes = controller('Common') -> nodes();
        $db_type = db('goods_classify');
        $result = $db_type -> where('status',2) -> limit(($param['page']-1) * $param['limit'],$param['limit']) -> order('id DESC') -> select();
        if(!empty($result)){
            _success($result, $db_type->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 分类 添加
    public static function typeAddRun($param)
    {
        $param['time'] = date('Y-m-d H:i:s');
        if(db('goods_classify')->insertGetId($param)){
            _success();
        }else{
            _error();
        }
    }
    // 分类 编辑
    public static function typeEditRun($param)
    {
        if(db('goods_classify')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 分类 删除
    public static function typeDelRun($param)
    {
        $msg = '';
        foreach ($param['ids'] as $k => $v) {
            // 禁止删除有商品的分类
            if(db('goods') -> where('classify_id',$v) -> find()) $msg = '禁止删除有商品的分类 ID：'.$v;
        }
        if(!$msg){
            foreach ($param['ids'] as $k => $v) {
                db('goods_classify') -> where('id',$v) -> setField('status',1);
            }
            _success();
        }else{
            _error($msg);
        }
    }
    // 分类 状态
    public static function typeStatusRun($param)
    {
        if(db('goods_classify')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 获取 分类
    public static function typeGetRun($param)
    {
        $where[] = ['status','=',2];
        if(array_key_exists('id', $param)) array_push($where, ['id','=',$param['id']]);
        $result = db('goods_classify') -> where($where) -> order('id DESC') -> select();
        if(!empty($result)){
            _success($result);
        }else{
            _nothing('请先添加分类');
        }
    }
}

// 真实删除
// 图片处理
// $goodsDb = db('goods');
// $goods = $goodsDb->whereIn('id',$param['ids'])->field('photo')->select();

// for($i=0; $i<count($goods); $i++) {
//     $photo = explode('/images/', $goods[$i]['photo']);
//     @unlink(_root().'/api/public/uploads/images/'.$photo[1]);
// }
// if($goodsDb->delete($param['ids'])){
//     _success();
// }else{
//     _error('删除失败，请稍后重试...');
// }