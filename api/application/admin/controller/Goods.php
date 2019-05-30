<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-09 10:49:12
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-10 17:04:35
 */
namespace app\admin\controller;
use app\admin\model\Goods as goodsModel;

class Goods extends Common
{
    // 商品 列表
    public function goods()
    {
        $param = _request();
        goodsModel::goodsRun($param);
    }
    // 商品 添加
    public function goodsAdd()
    {
        $param = _request();
        goodsModel::goodsAddRun($param);
    }
    // 商品 编辑
    public function goodsEdit()
    {
        $param = _request();
        goodsModel::goodsEditRun($param);
    }
    // 商品 删除
    public function goodsDel()
    {
        $param = _request();
        goodsModel::goodsDelRun($param);
    }
    // 商品 状态
    public function goodsStatus()
    {
        $param = _request();
        goodsModel::typeStatusRun($param);
    }





	// 分类 列表
    public function type()
    {
        $param = _request();
        goodsModel::typeRun($param);
    }
    // 分类 添加
    public function typeAdd()
    {
        $param = _request();
        goodsModel::typeAddRun($param);
    }
    // 分类 编辑
    public function typeEdit()
    {
        $param = _request();
        goodsModel::typeEditRun($param);
    }
    // 分类 删除
    public function typeDel()
    {
        $param = _request();
        goodsModel::typeDelRun($param);
    }
    // 分类 状态
    public function typeStatus()
    {
        $param = _request();
        goodsModel::typeStatusRun($param);
    }
    // 分类 获取
    public function typeGet()
    {
        $param = _request();
        goodsModel::typeGetRun($param);
    }
}