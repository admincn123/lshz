/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2019-01-29 13:27:15
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-05-24 16:43:53
*/
layui.extend({

    route: './common/route',
    conf: './common/conf',
    basic: './common/basic',
    handle: './common/handle',
    lay: './common/lay',
    verify: './common/verify',
    iconPicker: './extend/iconPicker',
    Tree: './extend/Tree',
    echarts:'./common/echarts'

}).define(['layer','element','jquery','route','conf','basic','handle','lay','verify','iconPicker','Tree','echarts'], function(exports){
    exports('app', {
        o: layui.jquery,
        route: layui.route,
        conf: layui.conf,
        basic:layui.basic,
        Tree: layui.Tree,
        handle: layui.handle,
        lay: layui.lay,
        iconPicker: layui.iconPicker,
        echarts: layui.echarts
    });
});