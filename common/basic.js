/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2019-04-07 02:12:12
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-05-27 16:00:56
*/
layui.define(['conf'], function(exports){

	var layer = layui.layer,
		o = layui.jquery,
		conf = layui.conf;

	exports('basic', {
		/**
         * [_ajax  ajax请求]
         * @param  {[type]}   url      [请求地址]
         * @param  {[type]}   data     [发送数据]
         * @param  {Function} callback [回调函数]
         * @param  {[type]}   load     [是否开启请求layer加载]
         * @param  {[type]}   method   [请求方式]
         * @param  {[type]}   async    [是否异步]
         * @return {[type]}            [结果集]
         */
        _ajax: function(url, data='', callback, load=true, method='POST', async=true){
            var token = sessionStorage.getItem('token');
            (!data)? data = {'token':token} : data['token'] = token;
            if(load && typeof load == 'boolean') var index = layer.load(0, {shade:0.1});
            if(load && typeof load == 'string') var index = layer.msg('官人莫急，生成二维码需要一定时间！',{icon:16,shade:0.1,time:60000});
            o.ajax(conf.serverPath+url,{
                data: data, type: method, dataType: 'JSON', timeout: 60000, async: async,
                success:function(result){
                    if(index) layer.close(index);
                    if(result.msg && result.msg != '请求成功') layer.msg(result.msg);
                    if(result.code == 0 && typeof callback == 'function') callback(result);
                }
                ,error:function(){
                    if(index) layer.close(index);
                    layer.msg('请求超时，请稍后重试...');
                    return false;
                }
            },false);
        },
        /**
         * [_getPage 获取文件]
         * @param  {[type]}   file     [文件资源]
         * @param  {[type]}   filter   [操作按钮]
         * @param  {Function} callback [回调]
         */
        _getPage: function(file, filter, callback){
            o.get(conf._templatePath()+file+'.html', function(html){
                if(filter) html = html.replace('<slot></slot>', '<button lay-filter="'+filter+'" lay-submit="" class="layui-btn layui-btn-sm layui-btn-normal" type="button">确认</button>');
                callback(html);
            })
        },
        /**
         * [_toolCheck table tool点击选中当前行]
         * @param  {[type]} obj [点击的对象]
         */
        _toolCheck: function(obj){
            obj.tr.siblings('tr').find('input[type="checkbox"]').prop('checked', false);
            obj.tr.find('input[type="checkbox"]').prop('checked', true);
            layui.form.render('checkbox');
        },
        /**
         * [_toolCheckData 获取table tool点击行的数据]
         * @param  {[type]} obj [table定义的ID]
         * @return {[type]}     [返回tool点击行的数据]
         */
        _toolCheckData: function(obj){
            var checkData = {};
            o('div[lay-id="'+obj+'"]').find('tr.layui-table-click').children('td').each(function(i){
                var _that = o(this);
                if(i > 0) checkData[_that.attr('data-field')] = _that.text();
            });
            return checkData;
        },
        /**
         * [_nav 系统菜单]
         * @param  {[type]} data [菜单树形数据集]
         */
        _nav: function(data){
            if(data){
                var liStr= "";
                // 遍历生成主菜单
                for( var i=0; i <data.length; i++){
                    // 判断是否存在子菜单
                    if(data[i].childs != null && data[i].childs.length > 0){
                        liStr += '<li class="layui-nav-item">'+
                            '<a href="javascript:;" route="'+data[i].route+'" curr-id="'+data[i].id+'">'+
                                '<i class="layui-icon '+data[i].icon+'" data-icon="'+data[i].icon+'"></i>'+
                                '<cite>'+data[i].name+'</cite>'+
                            '</a>'+
                            '<dl class="layui-nav-child">';
                            // 遍历获取子菜单
                            for(var k=0; k <data[i].childs.length; k++){
                                liStr += this._getChilds(data[i].childs[k]);
                            }
                        liStr += "</dl></li>";
                    }else{
                        liStr += '<li class="layui-nav-item">'+
                            '<a href="javascript:;" route="'+data[i].route+'" curr-id="'+data[i].id+'">'+
                                '<i class="layui-icon '+data[i].icon+'" data-icon="'+data[i].icon+'"></i>'+
                                '<cite>'+data[i].name+'</cite>'+
                            '</a>'+
                        '</li>';
                    }
                };
                var navStr = '<li class="layui-nav-item"><a href="javascript:;" route="#"><i class="layui-icon layui-icon-home"></i><cite>系统主页</cite></a></li>';
                document.getElementById('nav-left').innerHTML = navStr+liStr;
                layui.use('element', function(){
                    layui.element.render();
                });
                // 当前选中菜单处理
                var route = location.hash.substring(1);
                if(route){
                    o('#nav-left li a').each(function(i, el){
                        var _that = o(this);
                        if(_that.attr('route') == route){
                            _that.parent().addClass('layui-this');
                            _that.parents('li').addClass('layui-nav-itemed');
                        }
                    });
                }else{
                    o('a[route="#"]').parent('li').addClass('layui-this');
                }
            }
        },
        /**
         * [_getChilds 递归生成子菜单]
         * @param  {[type]} subMenu [子菜单树形数据集]
         * @return {[type]}         [返回拼装菜单字符集]
         */
        _getChilds: function(subMenu) {
            var subStr = "";
            if(subMenu.childs != null && subMenu.childs.length > 0){
                subStr += '<dd>'+
                    '<a href="javascript:;" route="'+subMenu.route+'" curr-id="'+subMenu.id+'">'+
                        '<i class="layui-icon '+subMenu.icon+'" data-icon="'+subMenu.icon+'"></i>'+
                        '<cite>'+subMenu.name+'</cite>'+
                    '</a>'+
                    '<dl class="layui-nav-child">';
                for(var j=0; j<subMenu.childs.length; j++){
                    subStr += this._getChilds(subMenu.childs[j]);
                }
                subStr += "</dl></dd>";
            }else{
                subStr += '<dd>'+
                    '<a href="javascript:;" route="'+subMenu.route+'" curr-id="'+subMenu.id+'">'+
                        '<i class="layui-icon '+subMenu.icon+'" data-icon="'+subMenu.icon+'"></i>'+
                        '<cite>'+subMenu.name+'</cite>'+
                    '</a>'+
                '</dd>';
            }
            return subStr;
        },
        /**
         * [_nodes 渲染当前页面操作节点]
         * @param  {[type]} data [节点数据集]
         * @return {[type]}      [description]
         */
        _nodes: function(data){
            if(data){
                var btnStr = '',
                    obj_toolBar = document.querySelector('.layui-body .layui-table-tool-temp'),
                    obj_tool = document.querySelectorAll('.layui-body .layui-table-body input, .layui-body .layui-table-body a');
                
                data.forEach(function(el, i){
                    if(el.node != 'read' && el.node != 'list') btnStr += '<button class="layui-btn layui-btn-sm layui-btn-primary" style="background: '+el.node_color+'" lay-event="'+el.node+'" access-id="'+el.id+'"><i class="layui-icon '+el.icon+'"></i>'+el.name+'</button>';
                    if(el.node == 'list'){
                        for(var i=0; i<obj_tool.length; i++){
                           obj_tool[i].setAttribute('access-id',el.id); 
                        }
                    }
                });
                obj_toolBar.innerHTML = '<div class="layui-btn-container layui-btn-group">'+btnStr+'</div>';
                layui.form.render();
            }
        },
        /**
         * [_isNode 判断用户是否有该节点权限]
         * @param  {[type]}   access_id [当前操作的节点ID]
         * @param  {Function} callback  [满足权限后回调]
         */
        _isNode: function(access_id, callback){
            var param = {"uid":sessionStorage.getItem('uid'),"access_id":access_id};
            this._ajax('admin.php/Common/isNode', param, function(){
                callback();
            });
        },
		/**
         * [_confirm 询问框]
         * @param  {[type]} msg [提示字符]
         * @return {[type]}     [返回]
         */
        _confirm:function(msg){
            if(!confirm(msg)){
                return false;
            }else{
                return true;
            }
        },
        /**
         * [_getCode 获取随机字符编码]
         * @param  {[int]} len [获取长度]
         * @return {[string]}  [随机字符]
         */
        _getCode: function(len){
            var value = '',code = '',
                arr = [
                    1,2,3,4,5,6,7,8,9,0,'a','b','c','d','e','f','g','h','j','k','l','m','n','p','q','r','s','t','u','v','w',
                    'x','y','z','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z'
                ];
            for(var i=0; i<len; i++){
                value = Math.round(Math.random() * (arr.length-1));
                code += arr[value];
            }
            return code;
        },
        /**
         * [_ueditor 创建百度编辑器]
         * @param  {[type]}  obj      [作用域]
         * @param  {[type]}  width    [实体宽度]
         * @param  {Number}  height   [实体高度]
         * @param  {Boolean} disabled [是否禁止编辑，默认：可编辑]
         * @return {[type]}           [description]
         */
        _ueditor: function(obj, width, height=500, disabled=true){
            if(!width) width = $('#'+obj).parent().width()-19;
            // 删除百度编辑器实体
            UE.delEditor(obj);
            // 渲染百度编辑器
            var ue = UE.getEditor(obj, {
                initialFrameWidth:width, initialFrameHeight:height, zIndex:19891017
            });
            if(!disabled) ue.ready(function(){ ue.setDisabled(); });
        },
        /**
         * [_formDisabled 表单禁止编辑]
         * @param  {[type]} obj [表单禁止编辑]
         * @return {[type]}     [表单禁止编辑]
         */
        _formDisabled(obj){
            var $input = document.querySelectorAll('#'+obj+' .layui-form input');
            for(var i=0; i<$input.length; i++){
                $input[i].setAttribute('disabled','disabled');
            }
            var $select = document.querySelectorAll('#'+obj+' .layui-form select');
            for(var i=0; i<$select.length; i++){
                $select[i].setAttribute('disabled','disabled');
            }
            var $textarea = document.querySelectorAll('#'+obj+' .layui-form textarea');
            for(var i=0; i<$textarea.length; i++){
                $textarea[i].setAttribute('disabled','disabled');
            }
        },
        /**
         * [_getHrefParam 页面传参获取]
         * @param  {[type]} name [参数名]
         * @param  {[type]} url  [页面地址，为空时取当面页面地址]
         * @return {[type]}      [参数值]
         */
        _getHrefParam: function(name,url){
            var up = url;
            if(typeof up == 'undefined' || up==null || up=='')  up = decodeURI(window.location.search);
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                var r = up.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        },
        /**
         * [_getHrefPath 获取href当前相对路径]
         * @return {[type]} [前相对路径]
         */
        _getHrefPath: function(){
            var url = document.location.toString(),
            	arrUrl = url.split("//"),
            	start = arrUrl[1].indexOf("/"),
            	relUrl = arrUrl[1].substring(start); //stop省略，截取从start开始到结尾的所有字符
            if(relUrl.indexOf("?") != -1){
            	relUrl = relUrl.split("?")[0];
            }
            return relUrl;
        }
	});
});