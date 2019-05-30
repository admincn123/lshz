<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-01-29 13:08:05
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-05-23 10:06:20
 */
namespace app\admin\controller;
use think\Controller;

class Common extends Controller
{
    public function initialize()
    {
        // 身份认证 || !db('admin') -> where('token',session('token')) -> find()
        if(!session('uid') || !session('token')){
            $this -> redirect('Logreg/login');
            session(null);
        }
        // 分离身份认证
        // $param = _request('', true);
        // if(!array_key_exists('uid', $param) || !array_key_exists('token', $param)|| !db('admin') -> where('token',$param['token']) -> find()){
        //     _error('请重新登录');
        // }
    }
    // 系统菜单
    public function nav()
    {
        $role_id = db('admin') -> where('id',session('uid')) -> value('role_id');
        // 当前用户下的系统菜单
        $access_ids = db('admin_role') -> where('id',$role_id) -> value('access_ids');
        $where = [['id','IN', explode('|', $access_ids)],['route',['<>',''],['<>','0']],['status','=','']];

        // 系统超级管理员
        if($access_ids === 'all') $where = _arr_handle($where,[0],false);

        $result = db('admin_access') -> where($where) -> order('sort') -> select();

        if(!$access_ids || empty($result)) _error('用户无权限');
        // 转树形菜单
        require 'api/extend/lib/Arr.php';
        $Arr = new \Arr();
        $result = $Arr -> getTree($result);
        _success($result);
    }
    // 当前页面下的操作节点集
    public function nodes()
    {
        $param = _request();
        if(array_key_exists('route', $param)){
            if($pid =  db('admin_access') -> where('route',$param['route']) -> value('id')){
                $result = db('admin_access') -> where([
                    ['pid','=',$pid],
                    ['node',['<>',''],['<>','0']],
                    ['status','=','']
                ]) -> order('sort') -> select();
                if(!empty($result)) return $result;
            }
        }
    }
    // 判断用户是否有该节点权限
    public function isNode()
    {
        $param = _request();
        $role_id = db('admin') -> where('id',session('uid')) -> value('role_id');
        $access_ids = db('admin_role') -> where('id',$role_id) -> value('access_ids');
        // 系统超级管理员
        if($access_ids === 'all') _success();
        if(!$role_id || !$access_ids || !in_array($param['access_id'], explode('|',$access_ids))){
            _error('权限不足');
        }else{
            _success();
        }
    }
    // 上传图片
    public function uploads()
    {
        $files = $_FILES;
        $result = _uploads($files);
        echo json_encode($result);
    }
}