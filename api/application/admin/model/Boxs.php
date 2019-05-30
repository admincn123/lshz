<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-14 16:03:34
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-28 15:12:30
 */
namespace app\admin\model;
use think\Db;

class Boxs
{

    // 盒子 列表
    public static function boxsRun($param)
    {
        $nodes = controller('Common') -> nodes();
        $where[] = ['status','=',2];
        if(array_key_exists('keyword', $param)){
            $keyword = $param['keyword'];
            if($keyword['goods_total_money']) $where[] = ['goods_total_money','<=',$keyword['goods_total_money']];
            if($keyword['area_id']) $where[] = ['area_id','=',$keyword['area_id']];
            if($keyword['agent_id'] == 'Y') $where[] = ['agent_id','<>',0];
            if($keyword['agent_id'] == 'N') $where[] = ['agent_id','=',0];
        }
        $db_boxs = db('boxs');
        if(array_key_exists('page', $param)){
            $result = $db_boxs->where($where)->limit(($param['page']-1)*$param['limit'],$param['limit'])->order('id DESC')->select();
            if(!empty($result)){
                $area = db('boxs_area')->select();
                require 'api/extend/lib/Arr.php';
                $Arr = new \Arr();

                foreach ($result as $k => $v) {
                    // 分区 查找当前id的所有父级
                    $area_parents = $Arr -> getParents($area, $v['area_id']);
                    $area_parents_name = '';
                    foreach ($area_parents as $key => $val) {
                        $area_parents_name .= ' - '.$val['name'];
                    }
                    $result[$k]['area_parents'] = $area_parents_name;
                }
                _success($result, $db_boxs->count(), $nodes);
            }else{
                _nothing('', $nodes);
            }
        }else{
            $where[] = ['agent_id','=',0];
            $result = $db_boxs -> where($where) -> order('id DESC') -> select();
            if(!empty($result)){
                _success($result);
            }else{
                _nothing('请前往添加盒子');
            }
        }        
    }
    // 盒子 添加
    public static function boxsAddRun($param)
    {
        $db_boxs = db('boxs');
        if($db_boxs -> insertAll($param['data'])){
            $boxs = $db_boxs -> where('web_url',NULL) -> select();
            $data = [];

            require 'api/vendor/qrcode/phpqrcode.php';
            $QRcode = new \QRcode();
            $iframeSrc = imagecreatefromstring(file_get_contents(_root().'/api/public/uploads/images/qrcode-iframe.png'));
            foreach ($boxs as $k => $v) {
                // 生成 原始二维码
                $value = _host().'/user.php/Login/home?boxs='.$v['id'];
                $qrcodeSrc = _root().'/api/public/uploads/images/'.$v['name'].'.png';
                $QRcode -> png($value, $qrcodeSrc, 'L', 6, 2);
                // 生成 专属二维码
                $qrcodeSrc = imagecreatefromstring(file_get_contents($qrcodeSrc));
                imagecopyresampled($iframeSrc, $qrcodeSrc, 300, 686, 0, 0, 560, 560, imagesx($qrcodeSrc), imagesy($qrcodeSrc));
                $qrcodeBgSrc = _root().'/api/public/uploads/images/'.$v['name'].'-bg.png';
                $state = imagepng($iframeSrc, $qrcodeBgSrc);
                // 更新数据
                if($state) $data[] = ['id'=>$v['id'], 'web_url'=>$value];
            }
            // 更新 新添加数据的web_url字段
            $val = '';
            for ($i=0; $i<count($data); $i++) { 
                $val .="('".$data[$i]['id']."','".$data[$i]['web_url']."'),";
            }
            $val=rtrim($val,',');
            Db::execute("insert into db_boxs (id,web_url) values ".$val."on duplicate key update web_url=values(web_url)");
            _success();
        }
    }
    // 盒子 编辑
    public static function boxsEditRun($param)
    {
        if(db('boxs') -> update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 盒子 删除
    public static function boxsDelRun($param)
    {
        if(db('warehouse') -> whereIn('id', $param['ids']) -> setField('status',1)){
            _success();
        }else{
            _error();
        }
    }
    // 备货
    public static function boxsStockupRun($param)
    {
        $goods_tpl_lines = db('goods_tpl_lines') -> where('id',$param['tpl_id']) -> field(['goods_id','goods_number']) -> select();
        $dateTime = date('Y-m-d H:i:s');
        if(!empty($goods_tpl_lines)){
            foreach ($goods_tpl_lines as $k => $v) {
                $goods_tpl_lines[$k]['stock'] = $v['goods_number'];
                $goods_tpl_lines[$k]['quantity'] = $v['goods_number'];
                unset($goods_tpl_lines[$k]['goods_number']);
                $goods_tpl_lines[$k]['boxs_id'] = $param['id'];
                $goods_tpl_lines[$k]['time'] = $dateTime;
            }
        }
        db('boxs_list') -> insertAll($goods_tpl_lines);
        $goods_tpl = db('goods_tpl') -> where('id',$param['tpl_id']) -> find();
        db('boxs') -> where('id',$param['id']) -> update([
            'goods_total_number' => $goods_tpl['goods_total_number'],
            'goods_total_money' => $goods_tpl['goods_total_money']
        ]);
        _success();
    }
    // 盘点记录
    public static function inventorylogRun($param)
    {
        $ids = explode('|', $param['ids']);
        $result = db('agent_inventory')
        -> alias('a')
        -> whereIn('a.boxs_id',$ids)
        -> leftJoin('agent_inventory_list b','a.id = b.inventory_id')
        -> leftJoin('goods c','b.goods_id = c.id')
        -> field('a.*, b.goods_real_number, b.message, c.name as goods_name')
        -> order('a.boxs_id DESC')
        -> select();
        if(!empty($result)){
            _success($result);
        }else{
            _nothing();
        }
    }
    // 交易记录
    public static function tradelogRun($param)
    {
        $ids = explode('|', $param['ids']);
        $result = db('user_order')
        -> alias('a')
        -> whereIn('a.boxs_id',$ids)
        -> leftJoin('user_order_lines b','a.id = b.order_id')
        -> leftJoin('user c','a.user_id = c.id')
        -> field('a.boxs_id, a.order_number, a.goods_total_money, a.goods_total_number, a.time, a.status, b.goods_name, c.nickname')
        -> order('a.boxs_id DESC')
        -> select();
        if(!empty($result)){
            _success($result);
        }else{
            _nothing();
        }
    }



    // 分区 列表
    public static function areaRun()
    {
        $nodes = controller('Common') -> nodes();
        // 列表
        $result = db('boxs_area') -> select();
        if(!empty($result)){
        	foreach ($result as $k => $v) {
        		$boxs = db('boxs')->where('area_id',$v['id'])->find();
        		$result[$k]['boxs_name'] = $boxs['name'];
        		$result[$k]['goods_total_number'] = $boxs['goods_total_number'];
        	}
        }
        _success($result, '', $nodes);
    }
    // 分区 添加
    public static function areaAddRun($param)
    {
        if(db('boxs_area')->insert($param)){
            _success();
        }else{
            _error();
        }
    }
    // 分区 编辑
    public static function areaEditRun($param)
    {
        if(db('boxs_area')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 分区 删除
    public static function areaDelRun($param)
    {
        $db_area = db('boxs_area');
        $result = $db_area->select();
        // 查找当前ids下的所有子id集
        $childs_id = [];
        require 'api/extend/lib/Arr.php';
        $Arr = new \Arr();
        foreach ($param['ids'] as $k => $v) {
            array_push($childs_id, $Arr -> getChildsId($result, $v));
        }
        $childs_id = $Arr -> multiTo1($childs_id);
        $idsAll = array_merge($param['ids'], $childs_id);

        if($db_area->delete($idsAll)){
            _success();
        }else{
            _error();
        }
    }
    // 分区 状态
    public static function areaStatusRun($param)
    {
        if(db('boxs_area')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 分区 排序
    public static function areaSortRun($param)
    {
        $val = '';
        for ($i=0; $i<count($param['data']); $i++) { 
            $val .="('".$param['data'][$i]['id']."','".$param['data'][$i]['sort']."'),";
        }
        $val=rtrim($val,',');
        if(Db::execute("insert into db_boxs_area (id,sort) values ".$val."on duplicate key update sort=values(sort)")){
            _success();
        }else{
            _error('排序无变化');
        }
    }
}