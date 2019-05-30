<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-10 11:25:40
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-29 15:09:29
 */
namespace app\admin\controller;
use app\admin\model\Library as libraryModel;

class Library extends Common
{
    // 仓库 列表
    public function library()
    {
        $param = _request();
        libraryModel::libraryRun($param);
    }
    // 仓库 添加
    public function libraryAdd()
    {
        $param = _request();
        libraryModel::libraryAddRun($param);
    }
    // 仓库 编辑
    public function libraryEdit()
    {
        $param = _request();
        libraryModel::libraryEditRun($param);
    }
    // 仓库 删除
    public function libraryDel()
    {
        $param = _request();
        libraryModel::libraryDelRun($param);
    }
    // 仓库 状态
    public function libraryStatus()
    {
        $param = _request();
        libraryModel::typeStatusRun($param);
    }
    // 仓库商品分配值
    public function warehouseList()
    {
        $param = _request();
        libraryModel::warehouseListRun($param);
    }
    // 仓库 详情
    public function libraryDetail()
    {
        $param = _request();
        libraryModel::libraryDetailRun($param);
    }
    // 配送记录
    public function give()
    {
        $param = _request();
        libraryModel::giveRun($param);
    }
    // 配送操作 确认/取消
    public function giveOper()
    {
        $param = _request();
        libraryModel::giveOperRun($param);
    }
    // 退货记录
    public function back()
    {
        $param = _request();
        libraryModel::backRun($param);
    }
    // 退货详情
    public function backDetail()
    {
        $param = _request();
        libraryModel::backDetailRun($param);
    }
    // 提交入库
    public function backEnter()
    {
        $param = _request();
        libraryModel::backEnterRun($param);
    }
    // 云打印退货记录
    public function printing()
    {
        libraryModel::printingRun();
    }
}