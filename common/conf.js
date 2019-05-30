/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2018-08-15 11:18:39
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-04-02 10:28:32
*/
layui.define(function(exports){
	exports('conf', {
		// 服务端地址
		serverPath: 'http://lshz.cn/',
		// hash视图模板地址
		_templatePath: function(){
            if(location.href.indexOf('/admin.php') < 0){
            	return 'template/index/';
            }else{
            	return 'template/admin/';
            }
		}
	});
});