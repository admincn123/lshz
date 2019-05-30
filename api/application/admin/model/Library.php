<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-10 11:28:39
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-29 17:43:11
 */
namespace app\admin\model;
use think\Db;
class Library
{
    // 仓库 列表
    public static function libraryRun($param)
    {
        $nodes = controller('Common') -> nodes();
    	$where[] = ['status','=',2];
    	if(array_key_exists('keyword', $param)) $where[] =  ['name','like','%'.strtoupper($param['keyword']).'%'];
        $db_library = db('warehouse');

        if(array_key_exists('page', $param)){
            $warehouse_ids = db('admin') -> where('id',session('uid')) -> value('warehouse_ids');
            if($warehouse_ids) $where[] = ['id','in',$warehouse_ids];
            
            $result = $db_library->where($where)->limit(($param['page']-1)*$param['limit'],$param['limit'])->order('id DESC')->select();
            $goods_count_price = 0;
            if(!empty($result)){
                $admin = db('admin') -> select();
                foreach ($result as $k => $v) {
                    // 商品数量/商品金额
                    $goods_list = db('warehouse_list') -> where('warehouse_id',$v['id']) -> select();
                    $price_sum = 0;
                    if(!empty($goods_list)){
                        // 每个商品价格*数量的总价
                        foreach ($goods_list as $key => $value) {
                            $price_sum += $value['goods_stock'] * db('goods') -> where('id',$value['goods_id']) -> value('price');
                        }
                    }
                    // 仓库商品总价
                    $goods_count_price += $price_sum;
                    $result[$k]['goods_count_price'] = $goods_count_price;
                    $result[$k]['goods_count'] = count($goods_list);
                    $result[$k]['admin'] = $admin;
                }
                _success($result, $db_library->count(), $nodes);
            }else{
                _nothing('', $nodes);
            }
        }else{
            $result = $db_library -> where($where) -> select();
            if(!empty($result)){
                _success($result);
            }else{
                _nothing('请先添加仓库');
            }
        }
        
    }
    // 仓库 添加
    public static function libraryAddRun($param)
    {
        $dataTime = date('Y-m-d H:i:s');
        if(!$id = db('warehouse') -> insertGetId(['name'=>$param['name'],'time'=>$dataTime])) _error('添加仓库失败');
        foreach ($param['goods'] as $k => $v) {
            $param['goods'][$k]['warehouse_id'] = $id;
            $param['goods'][$k]['time'] = $dataTime;
        }
        if(!db('warehouse_list') -> insertAll($param['goods'])) _error('分配商品失败');
        _success('添加成功');
    }
    // 仓库 编辑
    public static function libraryEditRun($param)
    {
        db('warehouse') -> update(['id'=>$param['id'],'name'=>$param['name']]);
        // 分配商品处理
        $db_warehouse_list = db('warehouse_list');
        $db_warehouse_list -> where('warehouse_id',$param['id']) ->delete();
        foreach ($param['goods'] as $k => $v) {
            $param['goods'][$k]['warehouse_id'] = $param['id'];
            $param['goods'][$k]['time'] = date('Y-m-d H:i:s');
        }
        $db_warehouse_list -> insertAll($param['goods']);
        _success();
    }
    // 仓库 删除
    public static function libraryDelRun($param)
    {
        foreach ($param['ids'] as $k => $v) {
            db('warehouse') -> where('id',$v) -> setField('status',1);
        }
        _success();
    }
    // 仓库 状态
    public static function libraryStatusRun($param)
    {
        if(db('warehouse')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 仓库商品分配值
    public static function warehouseListRun($param)
    {
        $result = db('warehouse_list') -> where('warehouse_id',$param['warehouse_id']) -> select();
        if(!empty($result)) _success($result);
    }
    // 仓库详情
    public static function libraryDetailRun($param)
    {
        $result = db('warehouse_list') -> where('warehouse_id',$param['id']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $result[$k]['goods'] = db('goods') -> where('id',$v['goods_id']) -> find();
            }
            _success($result);
        }else{
            _error('该仓库下暂无分配商品');
        }
    }
    // 配送记录
    public static function giveRun($param)
    {
        $result = db('distribution_order') -> where('warehouse_id',$param['id']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                // 盒子信息
                $result[$k]['boxs'] = db('boxs') -> where('id',$v['boxs_id']) -> value('name');
                // 申请人信息
                if($v['order_from'] == 'admin'){
                    $fqr = db('admin') -> where('id',$v['apply_id']) -> find();
                    $result[$k]['sqr_info'] = $fqr['account'].':'.$fqr['phone'];
                }else if($v['order_from'] == 'agent'){
                    $fqr = db('agent') -> where('id',$v['apply_id']) -> find();
                    $result[$k]['sqr_info'] = $fqr['name'].':'.$fqr['phone'];
                }else{
                    $fqr = db('user') -> where('id',$v['apply_id']) -> find();
                    $result[$k]['sqr_info'] = $fqr['nickname'].':'.$fqr['phone'];
                }
                // 状态
                $result[$k]['status_str'] = db('code') -> where([['table','=','db_distribution_order'],['id','=',$v['status']]]) -> value('value');
            }
            _success($result);
        }else{
            _error('暂无配送信息');
        }
    }
    // 配送操作 确认/取消
    public static function giveOperRun($param)
    {
        if(db('distribution_order') -> update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 退货记录
    public static function backRun($param)
    {
        $result = db('agent_goods_return') -> where('warehouse_id',$param['id']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                // 申请人信息
                $agent = db('agent') -> where('id',$v['agent_id']) -> find();
                $result[$k]['sqr_info'] = $agent['account'].'/'.$agent['phone'];
                // 收货人信息/确认人
                $admin = db('admin') -> where('id',$v['admin_id']) -> find();
                $result[$k]['jhr_info'] = $admin['account'].'/'.$admin['phone'];
                // 状态
                $result[$k]['status_str'] = db('code') -> where([['table','=','db_agent_goods_return'],['id','=',$v['status']]]) -> value('value');
            }
            _success($result);
        }else{
            _error('暂无记录');
        }
    }
    // 退货详情
    public static function backDetailRun($param)
    {
        $result = db('agent_goods_return_lines') -> where('goods_return_id',$param['id']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $goods = db('goods') -> where('id',$v['goods_id']) -> find();
                $result[$k]['goods_name'] = $goods['name'];
                $result[$k]['goods_price'] = $goods['price'];
            }
            _success($result);
        }else{
            _error('暂无记录');
        }
    }
    // 提交入库
    public static function backEnterRun($param)
    {
        // 更新退货详情
        $val = '';
        for ($i=0; $i<count($param['lines']); $i++) { 
            $val .="('".$param['lines'][$i]['id']."','".$param['lines'][$i]['goods_number']."'),";
        }
        $val=rtrim($val,',');
        Db::execute("insert into db_agent_goods_return_lines (id,goods_number) values ".
            $val."on duplicate key update goods_number=values(goods_number)");
        // 更新退货订单
        db('agent_goods_return')->where('id',$param['agent_goods_return_id'])->update([
            'goods_total_money'=>$param['goods_total_money'],
            'status' => 11
        ]);
        _success();
    }
    // 云打印退货记录
    public static function printingRun()
    {
        $param = _request();
        $result = db('agent_goods_return_lines') -> where('goods_return_id',$param['id']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $goods = db('goods') -> where('id',$v['goods_id']) -> find();
                $result[$k]['goods_name'] = $goods['name'];
                $result[$k]['goods_price'] = $goods['price'];
            }
            $info = ''; $total_amount = 0; $total_money = 0;
            foreach ($result as $k => $v) {
                $info .= $v['goods_name'].'   '.$v['goods_price'].'   '.$v['goods_number'].'   '.$v['goods_price'] * $v['goods_number'].'<BR>';
                $total_amount += $v['goods_number'];
                $total_money += $v['goods_price'] * $v['goods_number'];
            }
            $orderInfo = '<CB>退货详情</CB><BR>';
            $orderInfo .= '名称　　　　　 单价  数量 金额<BR>';
            $orderInfo .= '--------------------------------<BR>';
            $orderInfo .= $info;
            $orderInfo .= '--------------------------------<BR>';
            $orderInfo .= '商品总数：'.$total_amount.'（件/个）<BR>';
            $orderInfo .= '商品总金额：'.$total_money.'（元）<BR>';
            $orderInfo .= '申请人/电话：'.$param['sqr_info'].'<BR>';
            $orderInfo .= '接货人/电话：'.$param['jhr_info'].'<BR>';
            $orderInfo .= '订单ID号：'.$param['id'].'<BR>';
            $orderInfo .= '--------------------------------<BR>';
            $orderInfo .= '订单时间：'.$param['time'].'<BR>';
            $orderInfo .= '订单时间：'.$param['status_str'];
            // 对接打印机
            $time = time();
            $content = array(           
                'user'=>config('vendor.USER'), 'stime'=>$time,
                'sig'=>sha1(config('vendor.USER').config('vendor.UKEY').$time),
                'apiname'=>'Open_printMsg', 'sn'=>config('vendor.SN'),
                'content'=>$orderInfo, 'times'=>1//打印次数
            );
            require 'api/vendor/feieyun/HttpClient.class.php';
            $client = new \HttpClient(config('vendor.IP'),config('vendor.PORT'));
            if(!$client->post(config('vendor.PATH'),$content)){
                _error();
            }else{
                //服务器返回的JSON字符串，建议要当做日志记录起来
                //echo $client->getContent();
                _success();
            }
        }else{
            _error('暂无记录');
        }        
    }
}