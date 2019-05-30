<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-04-05 22:02:03
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-23 10:46:27
 */
namespace app\admin\controller;
use app\admin\model\System as systemModel;

class System extends Common
{
    // 权限菜单 列表
    public function access()
    {
        systemModel::accessRun();
    }
    // 权限菜单 添加
    public function accessAdd()
    {
        $param = _request();
        systemModel::accessAddRun($param);
    }
    // 权限菜单 编辑
    public function accessEdit()
    {
        $param = _request();
        systemModel::accessEditRun($param);
    }
    // 权限菜单 删除
    public function accessDel()
    {
        $param = _request();
        systemModel::accessDelRun($param);
    }
    // 权限菜单 状态
    public function accessStatus()
    {
        $param = _request();
        systemModel::accessStatusRun($param);
    }
    // 权限菜单 排序
    public function accessSort()
    {
        $param = _request();
        systemModel::accessSortRun($param);
    }
    




    // 角色 列表
    public function role()
    {
        $param = _request();
        systemModel::roleRun($param);
    }
    // 角色 添加
    public function roleAdd()
    {
        $param = _request();
        systemModel::roleAddRun($param);
    }
    // 角色 编辑
    public function roleEdit()
    {
        $param = _request();
        systemModel::roleEditRun($param);
    }
    // 角色 删除
    public function roleDel()
    {
        $param = _request();
        systemModel::roleDelRun($param);
    }
    // 角色 获取
    public function roleGet()
    {
        systemModel::roleGetRun();
    }




    
    // 用户 列表
    public function admin()
    {
        $param = _request();
        systemModel::adminRun($param);
    }
    // 用户 添加
    public function adminAdd()
    {
        $param = _request();
        systemModel::adminAddRun($param);
    }
    // 用户 编辑
    public function adminEdit()
    {
        $param = _request();
        systemModel::adminEditRun($param);
    }
    // 用户 删除
    public function adminDel()
    {
        $param = _request();
        systemModel::adminDelRun($param);
    }
    // 用户 状态
    public function adminStatus()
    {
        $param = _request();
        systemModel::adminStatusRun($param);
    }
    // 管理仓库
    public function adminLibrary()
    {
        $param = _request();
        systemModel::adminLibraryRun($param);
    }
}