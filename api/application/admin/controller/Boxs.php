<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-14 16:01:55
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-20 10:11:08
 */
namespace app\admin\controller;
use app\admin\model\Boxs as boxsModel;

class Boxs extends Common
{
    // 盒子 列表
    public function boxs()
    {
        $param = _request();
        boxsModel::boxsRun($param);
    }
    // 盒子 添加
    public function boxsAdd()
    {
        $param = _request();
        boxsModel::boxsAddRun($param);
    }
    // 盒子 编辑
    public function boxsEdit()
    {
        $param = _request();
        boxsModel::boxsEditRun($param);
    }
    // 盒子 删除
    public function boxsDel()
    {
        $param = _request();
        boxsModel::boxsDelRun($param);
    }
    // 盒子 状态
    // public function boxsStatus()
    // {
    //     $param = _request();
    //     boxsModel::typeStatusRun($param);
    // }
    // 备货
    public function boxsStockup()
    {
        $param = _request();
        boxsModel::boxsStockupRun($param);
    }
    // 盘点记录
    public function inventorylog()
    {
        $param = _request();
        boxsModel::inventorylogRun($param);
    }
    // 交易记录
    public function tradelog()
    {
        $param = _request();
        boxsModel::tradelogRun($param);
    }






    // 分区 列表
    public function area()
    {
        boxsModel::areaRun();
    }
    // 分区 添加
    public function areaAdd()
    {
        $param = _request();
        boxsModel::areaAddRun($param);
    }
    // 分区 编辑
    public function areaEdit()
    {
        $param = _request();
        boxsModel::areaEditRun($param);
    }
    // 分区 删除
    public function areaDel()
    {
        $param = _request();
        boxsModel::areaDelRun($param);
    }
    // 分区 状态
    public function areaStatus()
    {
        $param = _request();
        boxsModel::areaStatusRun($param);
    }
    // 分区 排序
    public function areaSort()
    {
        $param = _request();
        boxsModel::areaSortRun($param);
    }
}