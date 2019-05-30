/**
 * @Author: 魏大毛 [1920660234@qq.com]
 * @Date:   2017-11-28 17:23:33
 * @Last Modified by:   魏大毛
 * @Last Modified time: 2019-04-07 02:55:29
 */
layui.define(['form'], function(exports) {
	
	var form = layui.form,
		o = layui.jquery;

	var verify = form.verify({

		href: 		[/^(?=^.{3,255}$)(http(s)?:\/\/)?(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*([\?&]\w+=\w*)*$/, '域名地址输入不正确'],

		route: 		[/^[a-zA-Z]+\/?([a-zA-Z])+\/?([a-zA-Z])+\/?([a-zA-Z])+$/, '格式不正确，顶级路由：###；子级路由：### / ### / ### ...'],

		zipcode: 	[/^[1-9][0-9]{5}$/, '邮政编码不正确'],

		idcard: 	[/(^\d{15}$)|(^\d{17}([0-9]|X)$)/, '身份证输入不正确'],

		name: 		[/^[\u4E00-\u9FA5\uf900-\ufa2d·s]{2,20}$/, '姓名输入不正确'],

		bank: 		[/^([1-9]{1})(\d{14}|\d{18})$/, '银行账号不正确'],

		qq: 		[/^[1-9][0-9]{4,14}$/, 'QQ号码不正确'],

		letter: 	[/^[a-zA-Z]{3,16}$/, '请输入3-16位英文字母'],

		chinese: 	[/^[\u4e00-\u9fa5]+$/, '必须输入汉字'],

		account: function(val, e, msg='请输入账号，3-16位字母或数字组成'){
			if(!(/^[a-zA-Z0-9_-]{3,16}$/.test(val))){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		password: function(val, e, msg='请输入密码，3-16位字母或数字组成'){
			if(!(/^[a-zA-Z0-9_-]{3,16}$/.test(val))){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		notempty: function(val, e, msg='必填项不能为空'){
			if(!val){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		sync: function(val, e, msg='与指定域值输入不一样'){
			if(val != o(e).parents('form').find('input[name="'+o(e).attr('lay-than')+'"]').val()){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		notsync: function(val, e, msg='与指定域值输入一样'){
			if(val == o(e).parents('form').find('input[name="'+o(e).attr('lay-than')+'"]').val()){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		code: function(val, e, msg='验证码输入不正确'){
			if(val.length != 4 || val.toLowerCase() != o(e).parents('form').find('.code').html().toLowerCase()){
				return msg;
			}
		},
		phoneCode: function(val, msg='短信验证码输入不正确'){
			if(!(/^[0-9]{4,6}$/.test(val))){
				return msg;
			}
		},
		telephone: function(val, e, msg='座机号码输入不正确'){
			if(!(/^([0-9]{3,4}-)?[0-9]{7,8}$/.test(val))){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				return msg;
			}
		},
		checkbox: function(val, e, msg='至少选择一项'){
			var state = false;
			o(e).children('input').each(function(){
				if(o(e).is(":checked") || o(this).is(":checked")) state = true;
			});
			if(!state){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				o(e).css('border','1px solid #FF5722');
				return msg;
			}
		},
		layedit: function(val, e, msg='内容不能为空'){
			var body = o(e).next('.layui-layedit').find('iframe').contents().find('body'), val = body.html();
			if(!val){
				if(o(e).attr('placeholder')) msg = o(e).attr('placeholder');
				o(e).next('.layui-layedit').css('border-color','#FF5722');
				layer.tips(msg,o(e).parents('.layui-form-item'),{tips:1});
				return msg;
			}
		}
	});
	
	exports('verify', verify);
});