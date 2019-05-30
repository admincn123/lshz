<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-05-21 09:32:36
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-22 15:28:55
 */
namespace app\admin\controller;
use app\admin\model\Agent as agentModel;

class Agent extends Common
{
    // 代理商 列表
    public function agent()
    {
        $param = _request();
        agentModel::agentRun($param);
    }
    // 代理商 添加
    public function agentAdd()
    {
        $param = _request();
        agentModel::agentAddRun($param);
    }
    // 代理商 编辑
    public function agentEdit()
    {
        $param = _request();
        agentModel::agentEditRun($param);
    }
    // 代理商 删除
    public function agentDel()
    {
        $param = _request();
        agentModel::agentDelRun($param);
    }
    // 代理商 结账查询盘点
    public function settleQuery()
    {
        $param = _request();
        agentModel::settleQueryRun($param);
    }
    // 代理商 结账
    public function settle()
    {
        $param = _request();
        agentModel::settleRun($param);
    }
    // 结账记录
    public function settleLog()
    {
        $param = _request();
        agentModel::settleLogRun($param);
    }
}