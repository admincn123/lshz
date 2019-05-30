<?php

namespace app\admin\model;

class Advert
{

    public static function advertDel($param)
    {
        $db_advert = db('advert');
        $result = $db_advert->whereIn('id', $param['ids'])->update(['status'=>1]);
        if(!$result){
            _error('删除失败');
        }
        _success();
    }

    // 用户列表
    public static function add($param)
    {
        $tip = '';
        if (!$param['name']) {
            $tip = '广告名称必须';
        }
        if (!$param['url']) {
            $tip = '广告图片或视频必须';
        }
        if (!$param['position']) {
            $tip = '广告位置必须';
        }
        if (!$param['path']) {
            $tip = '广告链接必须';
        }
        $param['time'] = date('Y-m-d H:i:s');
        $param['type'] = $param['type'] === '1' ? 'video' : 'img';
        $param['status'] = 2;
        if (db('advert')->insertGetId($param)) {
            _success();
        }
        _error($tip);
    }

    public static function advertEdit($param)
    {
        $update = [];
        if ($param['name']) {
            $update['name'] = $param['name'];
        }
        if ($param['url']) {
            $update['url'] = $param['url'];
        }
        if ($param['position']) {
            $update['position'] = $param['position'];
        }
        if ($param['path']) {
            $update['path'] = $param['path'];
        }
        if(isset($param['type'])){
            $update['type'] = $param['type'] === '1' ? 'video' : 'img';

        }
        if (db('advert')->where('id', '=', $param['id'])->update($update)) {
            _success();
        }
        _error('');
    }



    public static function adverts($param)
    {
        $nodes = controller('Common')->nodes();
        $db_advert = db('advert');
        $result = $db_advert->where('status','=', '2')->limit(($param['page'] - 1) * $param['limit'], $param['limit'])->order('time DESC')->select();
        _success($result, $db_advert->count(), $nodes);
    }

}
