/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2018-12-18 13:44:34
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-04-01 17:34:08
*/
layui.define(['conf'], function(exports){

    var conf = layui.conf,
        layer = layui.layer,
        o = layui.jquery,
        element = layui.element;

    exports('route', {
        /**
         * [_hash 通过hash值获取页面]
         * @param  {[type]} hashval [hash值]
         */
        _hash: function(hashval){
            var templatePath = conf._templatePath(), file = '', hashval = location.hash.substring(1);
            if(!hashval){
                file = templatePath + 'main/index.html'
            }else{
                file = templatePath + hashval+'.html';
                // 默认指向index.html文件
                if(hashval.indexOf('/') < 0) file = templatePath + hashval + '/index.html';
            }
            o.get({
                url: file, dataType: 'html',
                success: function(response){
                    o('.layui-body').html(response);
                },
                error: function(){
                    layui.jquery.get(templatePath + 'error/404.html', function(response){
                        o('.layui-body').html(response);
                    });
                }
            });
        },
        /**
         * [_jump 页面跳转]
         * @param  {[type]} msg    [跳转前提示字符]
         * @param  {[type]} href   [跳转地址]
         * @param  {[type]} target [顶级/父级/默认普通跳转]
         * @param  {Number} t      [延时：毫秒]
         */
        _jump: function(msg, href, target, t=1000){
            if(msg) layer.msg(msg);
            if(target == 'top'){
                // 顶级页面跳转
                window.setTimeout("top.location.href = '"+conf.serverPath+href+"'",t);
            }else if(target == 'up'){
                // 让父级页面跳转
                window.parent.setTimeout("window.location = '"+conf.serverPath+href+"'",t);
            }else{
                // 当前页面普通跳转
                window.setTimeout("window.location = '"+conf.serverPath+href+"'",t);
            }
        },
        /**
         * [_reload 页面刷新]
         * @param  {[type]} msg    [刷新前提示字符]
         * @param  {[type]} target [顶级/父级/默认当前页面]
         * @param  {Number} t      [延时：毫秒]
         */
        _reload: function(msg, target, t=1000){
            if(msg) layer.msg(msg);
            setTimeout(function(){
                if(target == 'top'){
                    // 顶级页面刷新
                    top.location.reload();
                }else if(target == 'up'){
                    // 让父级页面刷新
                    parent.location.reload();
                }else{
                    // 当前页面刷新
                    self.location.reload();
                }
            },t)
        }
    });
    // 初始监听hash值
    if(location.href.indexOf('/logreg/') < 0){
        layui.route._hash();
    }
    // 监听hash变化
    window.addEventListener("hashchange", function(){
        layui.route._hash();
    });
    // 点击左边菜单
    element.on('nav(nav-left)', function(elem){
        if(!elem.context.nextElementSibling){
            var curr_route = this.getAttribute('route');
            if(curr_route) location.hash = curr_route;
        }
    });
});