/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2019-02-13 17:06:44
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-05-17 14:18:57
*/
layui.define(function(exports){
    var layer   = layui.layer,
        o       = layui.jquery
        conf = layui.conf;

    exports('lay', {
        /**
         * [_layconfirm 确认提示]
         * @param  {String}   msg      [提示字符]
         * @param  {Function} callback [确认后回调]
         * @return {[type]}            [description]
         */
        _confirm(msg, callback){
            if(!msg) msg = '系统消息';
            layer.confirm(msg, {
                id: 'layer-confirm',icon: 3,title: '系统消息',btn: ['确定','取消']
            },function(index){
                layer.close(index);
                if(typeof callback == 'function') callback();
            });
        },
        /**
         * [_tableReload layui table刷新]
         * @param  {[type]} msg [刷新前提示字符]
         * @param  {[type]} obj [table ID对象]
         * @param  {Number} t   [延时：毫秒]
         */
        _tableReload: function(msg, obj, t=1000){
            if(msg) layer.msg(msg);
            setTimeout(function(){
                layui.use('table', function(){
                    layer.closeAll();
                    layui.table.reload(obj);
                });
            }, t);
        },
        /**
         * [_layer layui打开窗口]
         * @param  {[type]}   title     [窗口title]
         * @param  {[type]}   filter    [显示监听的按钮]
         * @param  {[type]}   modalFile [需要打开的模态文件]
         * @param  {[type]}   callback  [数据或回调函数]
         * @param  {[type]}   width     [窗体宽度]
         * @param  {[type]}   height    [窗体高度]
         * @param  {[type]}   id        [窗体ID]
         * 
         * 打开iframe子页面时 获取参数
         * var body = layer.getChildFrame('body', index);               // body:iframe子页面查找对象
         * var iframeWindow = layero.find('iframe')[0].contentWindow;   // iframeWindow:iframe子页面渲染对象
         * if(typeof callback == 'function') callback(body, iframeWindow);
         */
        _layer: function(title, filter, modalFile, callback, width, height, id){
            if(!id) var id = 'layer-modal';
            if(!width) var width = '60%';
            if(!height) var height = '70%';
            var ue = false;     // 百度编辑器初始删除
            o.get(conf._templatePath()+modalFile+'.html', function(html){
                layer.open({
                    title:title, area:[width,height], type:1, id:id, content:html, maxmin:true,
                    success: function(layero, index){
                        if(filter) layero.find('.layer-btn-box > div').append('<button type="button" class="layui-btn layui-btn-sm layui-btn-normal" lay-filter="'+filter+'" lay-submit="">确认</button>');
                        if(typeof callback == 'function') callback(layero, index);
                        if(typeof callback == 'object'){
                            layero.find('form input,form select,form textarea').each(function(){
                                var _that = o(this),json = {}, key = _that.prop('name'), value = '';
                                for(var item in callback){
                                    if(key == item) value = callback[item];
                                }
                                json[key] = value;
                                layui.form.val('form',json);
                            });
                        }
                        layui.form.render();
                    }
                });
            });
        },
        /**
          * [_uploads 文件上传]
          * @param  {[type]}  object    [上传作用域对象]
          * @param  {[type]}  url       [上传地址]
          * @param  {[type]}  edit_file [编辑时 原文件数据]
          * @param  {Boolean} multiple  [是否多文件上传]
          * @param  {String}  accept    [上传类型：images video audio file(所有文件)]
          */
        _uploads: function(object, url, edit_file, multiple = false, accept = 'images'){
            layui.use('upload', function(){
                var upload = layui.upload,
                    obj = o('#'+object);
                // 编辑时 渲染原有文件
                if(edit_file){
                    var str = '';
                    // 多文件
                    if(Array.isArray(edit_file)){
                        for(var i=0; i<edit_file.length; i++){
                            // 判断文件类型
                            if(accept == 'images') str +='<a href="'+edit_file[i]+'" target="_blank"><img class="file" src="'+edit_file[i]+'"></a>';
                            if(accept == 'file') str += '<a href="'+edit_file[i]+'" target="_blank"><i class="layui-icon layui-icon-file"></i><br><span class="file" src="'+edit_file[i]+'">第'+edit_file.length+'个文件</span></a>';
                            if(accept == 'video') str += '<a href="'+edit_file[i]+'" target="_blank"><i class="layui-icon layui-icon-video"></i><br><span class="file" src="'+edit_file[i]+'">第'+edit_file.length+'个视频</span></a>';
                            if(accept == 'audio') str += '<a href="'+edit_file[i]+'" target="_blank"><i class="layui-icon layui-icon-headset"></i><br><span class="file" src="'+edit_file[i]+'">第'+edit_file.length+'个音频</span></a>';
                        }
                    }else{
                        // 单文件
                        if(accept == 'images') str ='<a href="'+edit_file+'" target="_blank"><img class="file" src="'+edit_file+'"></a>';
                        if(accept == 'file') str = '<a href="'+edit_file+'" target="_blank"><i class="layui-icon layui-icon-file"></i><br><span class="file" src="'+edit_file+'">文件</span></a>';
                        if(accept == 'video') str = '<a href="'+edit_file+'" target="_blank"><i class="layui-icon layui-icon-video"></i><br><span class="file" src="'+edit_file+'">视频</span></a>';
                        if(accept == 'audio') str = '<a href="'+edit_file+'" target="_blank"><i class="layui-icon layui-icon-headset"></i><br><span class="file" src="'+edit_file+'">音频</span></a>';
                    }
                    obj.find('.body-view').append(str);
                }
                // 上传文件
                upload.render({
                    elem: obj.find('button'),
                    url: layui.conf.serverPath+url,
                    multiple: multiple,
                    accept: accept,
                    before: function(obj){
                        //预读本地文件示例，不支持ie8
                        obj.preview(function(index, file, result){});
                    },
                    done: function(res){
                        //上传完毕
                        if(res.code > 0){ 
                            // 上传失败
                            return layer.msg(res.msg);
                        }else{
                            obj.find('.layui-upload-file').remove();
                            // 上传成功
                            obj.find('input[name="'+object+'"]').val(res.data.src);
                            // 成功后预览 循环file获取文件
                            if(accept == 'images'){
                                var str = '<a href="'+res.data.src+'" target="_blank"><img class="file" src="'+ res.data.src +'"></a>';
                            }
                            if(accept == 'file'){
                                var str = '<a href="'+res.data.src+'" target="_blank"><i class="layui-icon layui-icon-file"></i><br><span class="file" src="'+res.data.src+'">'+res.data.file_name+'</span></a>';
                            }
                            if(accept == 'video'){
                                var str = '<a href="'+res.data.src+'" target="_blank"><i class="layui-icon layui-icon-video"></i><br><span class="file" src="'+res.data.src+'">'+res.data.file_name+'</span></a>';
                            }
                            if(accept == 'audio'){
                                var str = '<a href="'+res.data.src+'" target="_blank"><i class="layui-icon layui-icon-headset"></i><br><span class="file" src="'+res.data.src+'">'+res.data.file_name+'</span></a>';
                            }
                            if(multiple){
                                obj.find('.body-view').append(str);
                            }else{
                                obj.find('.body-view').html(str);
                            }
                        }
                    }
                });
            });
        },
        /**
         * [_layedit 创建layui编辑器]
         * @param  {[type]} obj    [作用域id名]
         * @param  {[type]} url    [编辑器图片上传地址]
         * @param  {[type]} h      [编辑器高度]
         */
        _layedit: function(obj, url, h){
            if(!h) h = 'auto';
            layui.use('layedit', function(){
                var layedit = layui.layedit;
                // 编辑器中图片上传
                layedit.set({
                    uploadImage: {url:layui.conf.serverPath+url, type:'post'}
                });
                // 创建一个layui百度编辑器
                layedit.build(''+obj+'',{height: h});
            });
        }
    });
});