/*
* @Author: 魏大毛 [1920660234@qq.com]
* @Date:   2018-10-30 10:47:10
* @Last Modified by:   魏大毛
* @Last Modified time: 2019-05-24 17:43:06
*/
layui.define(function(exports){
    exports('echarts', {
        /**
         * [_line 拆线图]
         * @param  {[type]}  obj         [作用域]
         * @param  {[type]}  xname       [x轴名称]
         * @param  {[type]}  xdata       [x轴数据]
         * @param  {[type]}  yname       [y轴名称]
         * @param  {[type]}  ydata       [y轴数据]
         * @param  {[type]}  lineColor   [所有线的颜色值]
         * @param  {[type]}  shadowColor [线下边的阴影/背景色]
         * @param  {Boolean} transparent [是否开启线下边背景透明，目前未使用]
         */
        _line: function(obj, xname, xdata, yname, ydata, lineColor='#009688', shadowColor='#6BC3BB', transparent=true){
            var option = {
                //grid: {x:50, x2:70, y:50, y2:50},
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {lineStyle:{color:lineColor}},
                    formatter: function(params) {
                        for(var i=0; i<params.length; i++){
                            res = xname+' : '+params[0].name+'<br/>' +
                            params[0].seriesName + ' : ' + params[0].value+'<br/>'+
                            params[1].seriesName + ' : ' + params[1].value;
                        }
                        return res;
                    }
                },
                xAxis : [
                    {
                        name:xname,
                        splitArea : {show : true},
                        axisLine:{lineStyle:{color:lineColor, width:2}},
                        axisLabel: {textStyle:{color:'#333'}},
                        axisTick:{show:false},
                        data : xdata
                    }
                ],
                yAxis : [
                    {
                        name:yname,
                        splitLine:{show: false},
                        splitArea : {show : true},
                        axisLine:{lineStyle:{color:lineColor, width:2}},
                        axisLabel: {textStyle:{color:'#333'}},
                        axisTick:{show:false},
                    }
                ],
                series : [
                    {
                        name:'销售',
                        type:'line',
                        areaStyle: {normal: {
                            color: new echarts.graphic.LinearGradient( 0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#1E9FFF'},
                                    {offset: 0.5, color: '#5AB1EF'},
                                    {offset: 1, color: 'transparent'}
                                ]
                            )
                        }},
                        symbolSize:8,
                        itemStyle: {normal:{color:'#5AB1EF', borderColor:'#1E9FFF', borderWidth:2, lineStyle:{color:'#1E9FFF'}, areaStyle:{type:'default'}}},
                        data:ydata[0]
                    },
                    {
                        name:'利润',
                        type:'line',
                        areaStyle: {normal: {
                            color: new echarts.graphic.LinearGradient( 0, 0, 0, 1,
                                [
                                    {offset: 0, color: lineColor},
                                    {offset: 0.5, color: shadowColor},
                                    {offset: 1, color: 'transparent'}
                                ]
                            )
                        }},
                        symbolSize:8,
                        itemStyle: {normal:{color:shadowColor, borderColor:lineColor, borderWidth:2, lineStyle:{color:lineColor}, areaStyle:{type:'default'}}},
                        data:ydata[1]
                    }
                ]
            };
            echarts.init(document.getElementById(obj)).setOption(option);
        },
        /**
         * [_bar 柱状图]
         * @param  {[type]}  obj         [作用域]
         * @param  {[type]}  xname       [x轴名称]
         * @param  {[type]}  xdata       [x轴数据]
         * @param  {[type]}  yname       [y轴名称]
         * @param  {[type]}  ydata       [y轴数据]
         * @param  {[type]}  lineColor   [所有线的颜色值]
         * @param  {[type]}  shadowColor [线下边的阴影/背景色]
         */
        _bar: function(obj, xname, xdata, yname, ydata, lineColor, shadowColor){
            option = {
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {lineStyle:{color:lineColor}},
                    formatter: function(params) {
                        for(var i=0; i<params.length; i++){
                            res = xname+' : '+params[0].name+'<br/>' + params[0].seriesName + ' : ' + params[i].value;
                        }
                        return res;
                    }
                },
                xAxis : [
                    {
                        name:xname,
                        splitArea : {show : true},
                        axisLine:{lineStyle:{color:lineColor, width:2}},
                        axisLabel: {textStyle:{color:'#333'}},
                        axisTick:{show:false},
                        data : xdata
                    }
                ],
                yAxis : [
                    {
                        name:yname,
                        splitLine:{show: false},
                        splitArea : {show : true},
                        axisLine:{lineStyle:{color:lineColor, width:2}},
                        axisLabel: {textStyle:{color:'#333'}},
                        axisTick:{show:false},
                    }
                ],
                series : [
                    {
                        name:yname,
                        type:'bar',
                        areaStyle: {normal: {
                            color: new echarts.graphic.LinearGradient( 0, 0, 0, 1,
                                [
                                    {offset: 0, color: lineColor},
                                    {offset: 0.5, color: shadowColor},
                                    {offset: 1, color: 'transparent'}
                                ]
                            )
                        }},
                        symbolSize:8,
                        barWidth: 36,
                        itemStyle: {normal:{color:shadowColor, borderColor:lineColor, borderWidth:2, lineStyle:{color:lineColor}, areaStyle:{type:'default'}}},
                        data:ydata
                    }
                ]
            }
            echarts.init(document.getElementById(obj)).setOption(option);
        },
        /**
         * [_pie 饼图]
         * @param  {[type]}  obj         [作用域]
         * @param  {[type]}  xname       [x轴名称]
         * @param  {[type]}  xdata       [x轴数据]
         * @param  {[type]}  yname       [y轴名称]
         * @param  {[type]}  ydata       [y轴数据]
         */
        _pie: function(obj, xname, xdata, yname, ydata){
            option = {
                 tooltip : {
                    trigger: 'item',
                    formatter: "{a} : {b} <br/>访问量 : {c} ( 占本周 : {d}% )"
                },
                legend: {
                    orient : 'vertical',
                    x : 'right',
                    data:xdata
                },
                series : [
                    {
                        name:'星期',
                        type:'pie',
                        data:ydata
                    }
                ]
            },
            echarts.init(document.getElementById(obj)).setOption(option);
        }
    });
});