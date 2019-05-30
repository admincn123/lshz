<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-04-05 22:04:44
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-23 15:17:40
 */
namespace app\admin\model;
use think\Db;

class System
{
    // 权限菜单 列表
    public static function accessRun()
    {
        // 页面操作节点集
        $nodes = controller('Common') -> nodes();
        // 列表
        $access = db('admin_access') -> order('sort') -> select();
        if(!empty($access)){
        	foreach ($access as $k => $v) {
	        	$access[$k]['title'] = $v['name'];
            }
        }
        _success($access, '', $nodes);
    }
    // 权限菜单 添加
    public static function accessAddRun($param)
    {
        $db_admin_access = db('admin_access');
        $param['date'] = date('Y-m-d');
        if(!array_key_exists('node',$param)){
            // 添加菜单
            $result = $db_admin_access ->insertGetId($param);
        }else{
            // 添加节点
            $data = [];
            foreach ($param['node'] as $k => $v) {
                $str = explode('|', $v);
                array_push($data, [
                    'pid'=>$param['pid'], 'name'=>$str[0], 'node'=>$str[1], 'icon'=>$str[2],
                    'node_color'=>$str[3], 'date'=>$param['date'], 'open_mode'=>1, 'sort'=>$k+1
                ]);
            }
            $result = $db_admin_access -> insertAll($data);
        }
        if($result){
            _success();
        }else{
            _error();
        }
    }
    // 权限菜单 编辑
    public static function accessEditRun($param)
    {
        if(db('admin_access')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 权限菜单 删除
    public static function accessDelRun($param)
    {
        $db_access = db('admin_access');
        $result = $db_access->select();
        // 查找当前ids下的所有子id集
        $childs_id = [];
        require 'api/extend/lib/Arr.php';
        $Arr = new \Arr();
        foreach ($param['ids'] as $k => $v) {
            array_push($childs_id, $Arr -> getChildsId($result, $v));
        }
        $childs_id = $Arr -> multiTo1($childs_id);
        $idsAll = array_merge($param['ids'], $childs_id);

        if($db_access->delete($idsAll)){
            _success();
        }else{
            _error();
        }
    }
    // 权限菜单 状态
    public static function accessStatusRun($param)
    {
        if(db('admin_access')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 权限菜单 排序
    public static function accessSortRun($param)
    {
        $val = '';
        for ($i=0; $i<count($param['data']); $i++) { 
            $val .="('".$param['data'][$i]['id']."','".$param['data'][$i]['sort']."'),";
        }
        $val=rtrim($val,',');
        if(Db::execute("insert into db_admin_access (id,sort) values ".$val."on duplicate key update sort=values(sort)")){
            _success();
        }else{
            _error('排序无变化');
        }
    }




    // 角色 列表
    public static function roleRun($param)
    {
        // 页面操作节点集
        $nodes = controller('Common') -> nodes();
        $db_role = db('admin_role');
        $result = $db_role -> limit(($param['page']-1) * $param['limit'],$param['limit']) -> order('id') -> select();
        if(!empty($result)){
            _success($result, $db_role->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 角色 添加
    public static function roleAddRun($param)
    {
        $param['date'] = date('Y-m-d');
        if(db('admin_role')->insertGetId($param)){
            _success();
        }else{
            _error();
        }
    }
    // 角色 编辑
    public static function roleEditRun($param)
    {
        if(db('admin_role')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 角色 删除
    public static function roleDelRun($param)
    {
        if(db('admin_role')->delete($param['ids'])){
            _success();
        }else{
            _error();
        }
    }
    // 角色 获取
    public static function roleGetRun()
    {
        $result = db('admin_role') -> select();
        if(!empty($result)){
            _success($result);
        }else{
            _nothing('角色为空，请先前往添加角色');
        }
    }





    // 用户 列表
    public static function adminRun($param)
    {
        // 页面操作节点集
        $nodes = controller('Common') -> nodes();
        $db_admin = db('admin');
        $result = $db_admin -> limit(($param['page']-1) * $param['limit'],$param['limit']) -> select();
        if(!empty($result)){
            foreach ($result as $k => $v) {
                $role_name = db('admin_role') -> where('id',$v['role_id']) -> value('name');
                $result[$k]['role_name'] = $role_name;
            }
            _success($result, $db_admin->count(), $nodes);
        }else{
            _nothing('', $nodes);
        }
    }
    // 用户 添加
    public static function adminAddRun($param)
    {
        $param['register_datetime'] = date('Y-m-d H:i:s');
        $param['register_ip'] = request()->ip();
        if(db('admin')->insertGetId($param)){
            _success();
        }else{
            _error();
        }
    }
    // 用户 编辑
    public static function adminEditRun($param)
    {
        if(db('admin')->update($param)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
    // 用户 删除
    public static function adminDelRun($param)
    {
        if(db('admin')->delete($param['ids'])){
            _success();
        }else{
            _error();
        }
    }
    // 用户 状态
    public static function adminStatusRun($param)
    {
        if(db('admin')->update($param)){
            _success();
        }else{
            _error();
        }
    }
    // 仓库管理
    public static function adminLibraryRun($param)
    {
        $warehouse_ids = '';
        foreach($param['warehouse_ids'] as $k => $v){
            $warehouse_ids .= $k.',';
        }
        $warehouse_ids = rtrim($warehouse_ids, ',');
        if(db('admin') -> where('id',$param['id']) -> setField('warehouse_ids', $warehouse_ids)){
            _success();
        }else{
            _error('数据无变化');
        }
    }
}