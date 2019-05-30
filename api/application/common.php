<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------
// 应用公共文件

// 跨域解决方案
header('Access-Control-Allow-Origin:*');

// 获取服务器ip地址
function _host(){
    return 'http://'.$_SERVER['HTTP_HOST'];
}
// 项目根目录
function _root(){
    return $_SERVER['DOCUMENT_ROOT'];
}
/**
 * [_request 请求方法]
 * @param  string  $method [允许的请求方式]
 * @param  boolean $token  [返回是否保留token值]
 * @return [array]         [返回请求的数据集]
 */
function _request($method='', $token=false){
    // 判断请求方式
    $state = true; $curr_method = request() -> method();
    if($method && strtoupper($method) != strtoupper($curr_method)) $state = false;
    if(!$state){
        // (new ExceptionHandle())->isHandle('非'.$method.'请求方式'); // 抛出异常
        _error('非'.$method.'请求方式');
    }else{
        $data = request() -> param();
        if(!$token) unset($data['token']);
        return $data;
    }
}
/**
 * [_arr_handle 一维数组key保留删除处理]
 * @param  array   $arr   [数据集]
 * @param  array   $field [需处理的字段集/key]
 * @param  boolean $fun   [默认:保留处理/false:删除处理]
 * @return [type]         [处理后新的数据集]
 */
function _arr_handle($arr=[], $field=[], $fun='save')
{
    if(!empty($arr) && !empty($field)){
        foreach ($arr as $key => $value) {
            if($fun != 'save'){
                // 删除的字段集
                if(in_array($key, $field)){
                    unset($arr[$key]);
                    // 恢复索引值
                    if(is_int($key)) $arr = array_values($arr);
                }
            }else{
                // 需要的字段集
                if(!in_array($key, $field)){
                    unset($arr[$key]);
                    if(is_int($key)) $arr = array_values($arr);
                }
            }
        }
    }
    return $arr;
}
/**
 * [uploads 上传文件]
 * @param  [type]  $files  [文件信息]
 * @param  string  $accept [文件类型: images/其它文件]
 * @param  integer $width  [定义图片宽]
 * @param  integer $height [定义图片高]
 * @return [type]          [上传结果集]
 */
function _uploads($files, $accept='images', $width=0, $height=0){
    // 获取上传文件类型
    $type = strtolower(substr(strrchr($files['file']['name'], '.'), 1));
    if($accept == 'images'){
        // 判断文件类型
        $typeArr = array('png','jpg','jpeg','gif','PNG','JPG','JPEG','GIF');
        if(!in_array($type, $typeArr)) return $arr = ['code' => 1,'msg' =>'不支持该文件类型'];
    }
    // 定义上传文件名
    $file_name = substr(md5(uniqid(mt_rand(), true)), 8, 10).'.'.$type;
    // 上传目录 以文件类型为父级文件夹
    $uploaddir = iconv("UTF-8", "GBK", _root().'/api/public/uploads/'.$accept.'/');
    // 如果文件夹不存在 创建文件夹
    if(!file_exists($uploaddir)) mkdir($uploaddir,0777,true);
    // 上传
    if(move_uploaded_file($files['file']['tmp_name'], $uploaddir . iconv("UTF-8", "GBK", $file_name))){
        // 图片尺寸处理
        if($width || $height){
            // 获取已上传的图片尺寸
            $upImgSize = getimagesize($uploaddir . $file_name);
            // 定义图片尺寸活动范围值
            $range = [-20,0,20];
            if(!in_array($width - $upImgSize[0],$range) || !in_array($height - $upImgSize[1],$range)){
                // 删除图片
                @unlink($uploaddir . $file_name);
                return $arr = ['code' => 1,'msg' =>'该图片尺寸不符'];
            }
        }
        $arr = [
            'code' => 0,
            'msg' => '上传成功',
            'data' => [
                // 文件名称
                'file_name' => $file_name,
                // 富文本框图片alt名称
                'title' => $file_name,
                // 文件路径
                'src' => _host().'/api/public/uploads/'.$accept.'/'.$file_name,
                // 文件类型
                'accept' => $accept
            ]
        ];  
    }else{
        $arr = ['code'=>1,'msg'=>'上传失败，请联系程序员...'];
    }
    return $arr;
}
/**
 * [_success 请求成功]
 * @param  string $arr      [数据结果集]
 * @param  string $count    [数据统计]
 * @param  string $other    [其它返回集]
 * @param  string $msg      [提示]
 */
function _success($arr='', $count='', $other='', $msg='请求成功')
{
    $result = ['code'=>0, 'msg'=>$msg, 'data'=>$arr, 'count'=>$count, 'other'=>$other];
    echo json_encode($result);
    exit();
}
/**
 * [_error 请求失败]
 * @param  string  $msg  [提示字符]
 * @param  integer $code [失败编码]
 */
function _error($msg='', $other='')
{
    if(!$msg) $msg='操作失败，请稍后重试';
    $result = ['code' => 1,'msg' => $msg, 'other' => $other];
    echo json_encode($result);
    exit();
}
/**
 * [_nothing 请求为空]
 * @param  string $msg   [提示字符]
 * @param  string $other [其它返回集]
 */
function _nothing($msg='', $other='')
{
    if(!$msg) $msg='暂无数据';
    $result = ['code' => -1,'msg' => $msg, 'other' => $other];
    echo json_encode($result);
    exit();
}