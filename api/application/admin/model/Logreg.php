<?php

/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2019-01-29 15:45:08
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-04-24 17:11:07
 */
namespace app\admin\model;

class Logreg
{
    // 登录
    public static function signRun()
    {
        $param = input('param.');
        $admin = db('admin') -> where(['account' => $param['account'], 'password' => $param['password']]) -> find();
        if(empty($admin)) _error('账号或密码错误');
        if($admin['status']) _error('账号被锁定');
        
        // 更新admin数据
        $token = substr(md5(uniqid(mt_rand(), true)), 8, 16);
        $data = ['id'=>$admin['id'], 'sign_ip'=>request()->ip(), 'sign_datetime'=>date('Y-m-d H:i:s'), 'token'=>$token];
        if(db('admin')->update($data)){
            // 添加登录日志
            $data = _arr_handle($data, ['sign_ip','sign_datetime']);
            $data['admin_id'] = $admin['id'];
            db('admin_log') -> insert($data);
            // 存入session
            session('uid', $admin['id']);
            session('token', $token);
            // 返回
            $admin['token'] = $token;
            _success($admin);
        }else{
            _error();
        }
    }
}