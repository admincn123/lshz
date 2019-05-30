<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// [ 应用入口文件 ]
namespace think;

// 加载基础文件
require __DIR__ . '/api/thinkphp/base.php';

// 定义应用目录
define('APP_PATH', __DIR__ . '/api/application/');

// 定义模块名称
define('MODULE_NAME','index');

// 执行应用并响应
Container::get('app')->path(APP_PATH)->bind(MODULE_NAME)->run()->send();
