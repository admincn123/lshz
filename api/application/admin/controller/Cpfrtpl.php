<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-14 14:07:30
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-14 15:14:47
 */
namespace app\admin\controller;
use app\admin\model\Cpfrtpl as cpfrtplModel;

class Cpfrtpl extends Common
{
    // 补货模板 列表
    public function cpfrtpl()
    {
        $param = _request();
        cpfrtplModel::cpfrtplRun($param);
    }
    // 补货模板 添加
    public function cpfrtplAdd()
    {
        $param = _request();
        cpfrtplModel::cpfrtplAddRun($param);
    }
    // 补货模板 编辑
    public function cpfrtplEdit()
    {
        $param = _request();
        cpfrtplModel::cpfrtplEditRun($param);
    }
    // 补货模板 删除
    public function cpfrtplDel()
    {
        $param = _request();
        cpfrtplModel::cpfrtplDelRun($param);
    }
    // 补货模板 状态
    public function cpfrtplStatus()
    {
        $param = _request();
        cpfrtplModel::typeStatusRun($param);
    }
    // 已选择的商品
    public function goodsTplLines()
    {
        $param = _request();
        cpfrtplModel::goodsTplLinesRun($param);
    }
}