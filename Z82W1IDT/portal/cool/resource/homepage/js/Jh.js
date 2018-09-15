/*
 Jh.js
 Jquery Portal layout 
 可拖拽布局 
 Copyright (C) Jh 2012.4.11
 @author xiaofan
*/
var Jh = {	
	Config:{//CLASS样式配置
		tableCls:"form-list",
		tdCls:"form-text",
		tdCls2:"single",
		tdCls3:"form-text3",
		ulCls : "tag-list",
		layCls :"layout-list",
		min :"min",
		mintext:"\u6536\u8D77",
		max :"max",
		maxtext:"\u5C55\u5F00",
		close :"close",
		closetext :"\u5173\u95ED",
		refreshtext:"\u5237\u65B0",
		refresh :"refresh",
		_groupItemContent : "itemContent",
		_groupItemHead : "itemHeader",
		_groupWrapperClass  : "groupWrapper",
		_groupItemClass : "groupItem"
	}	
};

function FormBaiduMap(FieldID,applicationid,displayType){
	var oField = jQuery("#"+ FieldID);
	var url="../../portal/share/component/map/form/baiduMap.jsp?type=dialog&applicationid="+applicationid+"&displayType="+displayType;
	var title_map = '{*[map]*}';
	OBPM.dialog.show({
		title : title_map,
		url : url,
		args: {"fieldID":FieldID,"mapData":oField.val()},
		width : 1000,
		height : 600,
		close : function(result) {
		}
	});
}

Jh.Layout=function(me){
	var _winwidth = $(window).width();
	
	var _left = "portal_l"	,
		_center ="portal_m",
		_right ="portal_r";
		_icon ="portal_i";
	return me = {
		location:{//三列容器
			left:_left,
			center:_center,
			right:_right,
			icon:_icon
		},
		locationId : {
			left:"#"+_left,
			center:"#"+_center,
			right:"#"+_right,
			icon:"#"+_icon
		},
		layoutCss : {
//			0:"1:3",
//			1:"3:1",
			2:"1:2",
			3:"2:1",
//			4:"1:2:1",
//			5:"1:1:2",
//			6:"2:1:1",
			7:"1:1:1",
			8:"1:1",
			9:"1"
		},
		layoutText : {
			//0 :function(){if (_winwidth<1200){return "w200 w600 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w250 w750 wnone";} else if (_winwidth>=1600){return "w300 w900 wnone";}}(),
			//1 :function(){if (_winwidth<1200){return "w600 w200 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w750 w250 wnone";} else if (_winwidth>=1600){return "w900 w300 wnone";}}(),
			2 :function(){if (_winwidth<1200){return "w250 w500 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w300 w600 wnone";} else if (_winwidth>=1600){return "w400 w800 wnone";}}(),
			3 :function(){if (_winwidth<1200){return "w500 w250 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w600 w300 wnone";} else if (_winwidth>=1600){return "w800 w400 wnone";}}(),
			//4 :function(){if (_winwidth<1200){return "w400 w200 w200";} else if (_winwidth>=1200 && _winwidth<1600){return "w500 w250 w250";} else if (_winwidth>=1600){return "w600 w300 w300";}}(),
			//5 :function(){if (_winwidth<1200){return "w250 w250 w250";} else if (_winwidth>=1200 && _winwidth<1600){return "w300 w300 w300";} else if (_winwidth>=1600){return "w400 w400 w400";}}(),
			//6 :function(){if (_winwidth<1200){return "w400 w400 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w500 w500 wnone";} else if (_winwidth>=1600){return "w600 w600 wnone";}}(),
			7 :function(){if (_winwidth<1200){return "w300 w300 w300";} else if (_winwidth>=1200 && _winwidth<1600){return "w300 w300 w300";} else if (_winwidth>=1600){return "w400 w400 w400";}}(),
			8 :function(){if (_winwidth<1200){return "w400 w400 wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w500 w500 wnone";} else if (_winwidth>=1600){return "w600 w600 wnone";}}(),
			9 :function(){if (_winwidth<1200){return "w800 wnone wnone";} else if (_winwidth>=1200 && _winwidth<1600){return "w1000 wnone wnone";} else if (_winwidth>=1600){return "w1200 wnone wnone";}}()
		}
	};
}();

Jh.Util = {//工具类
	format : function (str, model) {//格式化指定键值的模板
		for (var k in model) {
			var re = new RegExp("{" + k + "}", "g");
			str = str.replace(re, model[k]);
		}
		return str;
	},
	refresh:function(){//刷新3个布局
		$("#"+Jh.Layout.location.left).sortable('refresh');
		$("#"+Jh.Layout.location.center).sortable('refresh');
		$("#"+Jh.Layout.location.right).sortable('refresh');
		$("#"+Jh.Layout.location.icon).sortable('refresh');
		
	},
	toBody:function(o){//往Body添加对象
		$("body").prepend(o);
	},
	configToString:function(val,cfg){
		name = "'"+val+"':" + cfg + ",";
		return name;
	},
	//判断旧数据 利用json2.js将字符串转对象
	setValueJson:function(val){
		var oldVal = false;
		var iconJson
		try { 
			iconJson = JSON.parse(val);
		}catch(e){ 
			oldVal = true;
		} 
		if(oldVal == true){
			iconJson = {}
			iconJson.icon = val;
		}
		return iconJson
	},
	setUserWidget:function(userCfg, defaultCfg){//往Body添加对象
		var _userCfg = "";
		var _appIcon = "";
		var _appL = "";
		var _appM = "";
		var _appR = "";
		
		$.each(userCfg, function(i, value) {
			if(value && value.length > 0){
				if(i=="appIcon"){
					$.each(value,function(j,val) {
						if(defaultCfg.appIcon[val] || defaultCfg.appIcon[val]!=undefined){
							_appIcon += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appIcon[val]));
						}else if(defaultCfg.appL[val] || defaultCfg.appL[val]!=undefined){
							_appIcon += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appL[val]));
						}else if(defaultCfg.appM[val] || defaultCfg.appM[val]!=undefined){
							_appIcon += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appM[val]));
						}else if(defaultCfg.appR[val] || defaultCfg.appR[val]!=undefined){
							_appIcon += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appR[val]));
						}
					 })
				}
				if(i=="appL"){
					$.each(value,function(j,val) { 
						if(defaultCfg.appIcon[val] || defaultCfg.appIcon[val]!=undefined){
							_appL += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appIcon[val]));
						}else if(defaultCfg.appL[val] || defaultCfg.appL[val]!=undefined){
							_appL += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appL[val]));
						}else if(defaultCfg.appM[val] || defaultCfg.appM[val]!=undefined){
							_appL += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appM[val]));
						}else if(defaultCfg.appR[val] || defaultCfg.appR[val]!=undefined){
							_appL += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appR[val]));
						}
					 })
				}
				if(i=="appM"){
					$.each(value,function(j,val) {
						if(defaultCfg.appIcon[val] || defaultCfg.appIcon[val]!=undefined){
							_appM += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appIcon[val]));
						}else if(defaultCfg.appL[val] || defaultCfg.appL[val]!=undefined){
							_appM += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appL[val]));
						}else if(defaultCfg.appM[val] || defaultCfg.appM[val]!=undefined){
							_appM += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appM[val]));
						}else if(defaultCfg.appR[val] || defaultCfg.appR[val]!=undefined){
							_appM += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appR[val]));
						}
					 })
				}
				if(i=="appR"){
					$.each(value,function(j,val) {
						if(defaultCfg.appIcon[val] || defaultCfg.appIcon[val]!=undefined){
							_appR += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appIcon[val]));
						}else if(defaultCfg.appL[val] || defaultCfg.appL[val]!=undefined){
							_appR += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appL[val]));
						}else if(defaultCfg.appM[val] || defaultCfg.appM[val]!=undefined){
							_appR += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appM[val]));
						}else if(defaultCfg.appR[val] || defaultCfg.appR[val]!=undefined){
							_appR += Jh.Util.configToString(val,JSON.stringify(defaultCfg.appR[val]));
						}
					 })
				}
				if(i=="layoutStyle"){
					_userCfg += "'layoutStyle':'";
					_userCfg += userCfg.layoutStyle;
					_userCfg += "'";
				}
			}
		});
		
		if (_appL.length > 0)
			_appL = _appL.substring(0,_appL.length - 1);
		if (_appM.length > 0)
			_appM = _appM.substring(0,_appM.length - 1);
		if (_appR.length > 0)
			_appR = _appR.substring(0,_appR.length - 1);
		if (_appIcon.length > 0)
			_appIcon = _appIcon.substring(0,_appIcon.length - 1);
		
		return ("{" + "'appIcon':{"+ _appIcon +"}," 
			+ "'appL':{"+ _appL +"}," 
			+ "'appM':{"+ _appM +"}," 
			+ "'appR':{"+ _appR +"}," 
			+ _userCfg
			+ "}");
	},
	setIcon:function(){
		return defaultIcon = "/lib/icon/16x16_0040/application_view_list.png";
	}
};
Jh.fn = function(me){//功能区
	return me = {
		init:function(data,defaultConfig){//初始化
			me._ele = {};
			me._create();
			me._createWrap(data,defaultConfig);
			me._bindEvent();
			//设置默认layout
			$("#header>table a[rel='"+data.layoutStyle+"']").trigger("click");
		},
		
		_create:function(){//创建自己
			var _box = $("<div id='header'/>");
			$("<span id='configBtn'></span>").css("opacity",0.2)
			.hover(function(){
				$(this).stop().fadeTo(500, 1);
			},function(){
				$(this).stop().fadeTo(500, 0.2);
			})
			.click(function(){
				var $table = $("#header").find("table");
				if ($table.is(":hidden")) {
					$table.show();
				}
				else {
					$table.hide();
				}
			}).appendTo(_box);
			if(!widget_custom){//myapp配置文件，配置是否可自定义排序widget
				_box.hide();
			}
			me.box = _box; 
			Jh.Util.toBody(_box);//往Body里添加自己
		},
		
		_createWrap:function(d,defaultConfig){//创建外层容器
			var _table = me._createTable(Jh.Config.tableCls);
			me._ele.table = _table;
			me._createModuleList(defaultConfig);
			me._createActionButton();
			me._addPanel(_table);
			_table.hide();//初始化隐藏
		},
		
		_createTable:function(clsName){	//创建表格		
			var _t = $("<table/>").addClass(clsName);
			$("<tbody/>")
								.append(me._createLayoutTr())
								.append(me._createBaseTr())
								.append(me._createBaseTr2())
								.append(me._createActionTr())
								.appendTo(_t);	
			return _t; 	
		},

		_createBaseTr:function(){//图标链接设置tr
			var	_td = me._createTd(Jh.Config.tdCls2),
				_tr = $("<tr>").append(me._createTd(Jh.Config.tdCls3,"\u56fe\u6807\u94fe\u63a5\u8bbe\u7f6e:"))
							   .append(_td);
			me._ele.mtd = _td;				   
			return _tr;
		},
		
		_createBaseTr2:function(){//创建功能模块tr
			var	_td = me._createTd(Jh.Config.tdCls2),
				_tr = $("<tr>").append(me._createTd(Jh.Config.tdCls3,"\u6A21\u5757\u8BBE\u7F6E:"))
							   .append(_td);
			me._ele.mtd2 = _td;				   
			return _tr;
		},
		
		_createActionTr:function(){//创建按钮tr
			var _td = me._createTd(Jh.Config.tdCls2),
				_tr = $("<tr>").append(me._createTd(Jh.Config.tdCls))
							.append(_td);
			me._ele.atd = _td;	
			return _tr;
		},
		
		_createLayoutTr:function(){//创建布局
			var _td = me._createTd(Jh.Config.tdCls2),
				_div = $("<div/>").addClass(Jh.Config.layCls)
								  .append(me._createA("1"))
								  .append(me._createA("1:1"))
								  .append(me._createA("1:2"))
								  .append(me._createA("2:1"))
				//				  .append(me._createA("1:3"))
				//				  .append(me._createA("3:1"))
								  .append(me._createA("1:1:1"))
				//			 	  .append(me._createA("1:1:2"))
				//				  .append(me._createA("1:2:1"))
				//				  .append(me._createA("2:1:1"))
								  .appendTo(_td),
				_tr = $("<tr>").append(me._createTd(Jh.Config.tdCls,"\u5E03\u5C40\u8BBE\u7F6E:")).append(_td);

			me._ele.layoutTd = _td;
			return _tr;
		},
		
		_createModuleList:function(data){//创建模块list
			var _ul = $("<ul/>").addClass(Jh.Config.ulCls);
			//初始化icon
			me._createLis(data.appIcon,_ul);
			
			me._ele.ul = _ul;
			_ul.appendTo(me._ele.mtd);

			var _ul = $("<ul/>").addClass(Jh.Config.ulCls);
			//初始化左中右
			me._createLis(data.appL,_ul);
			me._createLis(data.appM,_ul);
			me._createLis(data.appR,_ul);
			me._ele.ul2 = _ul;
			_ul.appendTo(me._ele.mtd2);
		},
		
		_createActionButton:function(){//创建功能按钮
			var _save= $("<a class='button b' href='#' >\u4FDD\u5B58\u914D\u7F6E</a>");
			me._ele.atd.append(_save);
			me._bindSave(_save);
			var _reset = $("<a class='button b'>重置配置</a>");
			me._bindReset(_reset);
			me._ele.atd.append(_reset);
			var _cancel = $("<a class='button b' href='#' >取消操作</a>");
			me._bindCancel(_cancel);
			me._ele.atd.append(_cancel);
		},		
		
		_createLis:function(obj,_ul){//创建li列表
			$.each(obj,function(key,o){				
				_ul.append(me._createLi(key,o));
			});
		},
		
		_createHr:function(_ul){//创建分割线
			_ul.append("<hr style='clear:both'/>");
		},
		
		_createA:function(text){//创建A
			return $("<a href='javascript:void(0);' rel='"+text+"'>"+text+"</a>");
		},
		
		_createLi:function(key,o){//创建li
			
			var setIcon
			if(o.icon == "" || o.icon == "null"){
				setIcon = Jh.Util.setIcon();
			}else{
				setIcon = o.icon;
			}
			
			var $li = "";
			if(key != "system_weather" && key != "system_workflow"){
				$li = $("<li/>").append("<a href='#' rel='"+key+"' titleColor='"+o.titleColor+"' icon='"+setIcon+"' type='"+o.type+"' titleBColor='"+o.titleBColor+"' iconShow='"+o.iconShow+"' >"+o.name+"</a>").append("<span class='ok'></span>");			
				var	_m = $("#"+key); //模块div 
				if (_m.size()>0) {
					$li.find(".ok").show();
				}
				else {
					$li.find(".ok").hide();
				}
				return $li;
			}
		},
		
		_createTd:function(clsName,text){//创建td
			var t = $("<td>").addClass(clsName);
			if(text!=undefined){
				t.text(text);
			}
			return  t; 
		},
		_addPanel:function(o){
			me.box.append(o);		
		},
		
		_bindCancel:function(obj){//添加模块
			obj.click(function(){
				location.reload();
			});
		
		},
		
		_bindReset:function(obj){//重置配置模块
			obj.click(function(){
				$("#header>table").hide();
				$.post('../user/saveAtHomePage.action', {
					'userId' : $('#userId').val()
				}, function(data) {
					location.reload();
				});
			});
		
		},
		_bindSave:function(obj){//保存模块配置
			obj.click(function(){
				var	_l = $("#"+Jh.Layout.location.left).sortable('toArray'),
				_m = $("#"+Jh.Layout.location.center).sortable('toArray'),
				_r = $("#"+Jh.Layout.location.right).sortable('toArray'),
				_i = $("#"+Jh.Layout.location.icon).sortable('toArray'),
				_a = $("."+Jh.Config.layCls+" a"),
				_layout ="";
				var _lText="",_mText="",_rText="",_iText="";
				
				$.each(_l, function(index, value){
					var $div = $("#"+value);
					if (index>0) _lText += ',';
					//_lText += '"'+$div.attr("id")+'":{"name":"'+$div.find(">div>span").text()
					//		+'","titleColor":"'+$div.find(">div").attr("titleColor")
					//		+'","titleBColor":"'+$div.find(">div").attr("titleBColor")
					//		+'","icon":"'+$div.find(">div").attr("icon")+'","type":"'+$div.attr("_type")+'","iconshow":"false"}';
					_lText += '"'+$div.attr("id")+'"';
				});
				$.each(_m, function(index, value){
					var $div = $("#"+value);
					if (index>0) _mText += ',';
					//_mText += '"'+$div.attr("id")+'":{"name":"'+$div.find(">div>span").text()
					//+'","titleColor":"'+$div.find(">div").attr("titleColor")
					//+'","titleBColor":"'+$div.find(">div").attr("titleBColor")
					//+'","icon":"'+$div.find(">div").attr("icon")+'","type":"'+$div.attr("_type")+'","iconshow":"false"}';
					_mText += '"'+$div.attr("id")+'"';
				});
				$.each(_r, function(index, value){
					var $div = $("#"+value);
					if (index>0) _rText += ',';
					//_rText += '"'+$div.attr("id")+'":{"name":"'+$div.find(">div>span").text()
					//	+'","titleColor":"'+$div.find(">div").attr("titleColor")
					//	+'","titleBColor":"'+$div.find(">div").attr("titleBColor")
					//	+'","icon":"'+$div.find(">div").attr("icon")+'","type":"'+$div.attr("_type")+'","iconshow":"false"}';
					_rText += '"'+$div.attr("id")+'"';
				});
				$.each(_i, function(index, value){
					var $div = $("#"+value);
					if (index>0) _iText += ',';
					//_iText += '"'+$div.attr("id")+'":{"name":"'+$div.find(".text").text()
					//	+'","titleColor":"","titleBColor":"","icon":"'+$div.find(".icon_s").attr("_ico")+'","type":"'+$div.attr("_type")+'","iconshow":"true"}';
					_iText += '"'+$div.attr("id")+'"';
				});
				
				_a.each(function(){
					if($(this).hasClass("active")){
						_layout = $(this).attr("rel");
					}
				});
				
				if(_layout=="1:1:1"){
	//				_layout="\u9ED8\u8BA4";
				}
				var templateElement = '{"layoutStyle":"'+_layout+'","appIcon":['+_iText+'],"appL":['+_lText+'],"appM":['+_mText+'],"appR":['+_rText+']}';


				 //执行保存动作
				 $('#templateElement').val(templateElement);
				 $.post('../user/saveAtHomePage.action', {
					'userId' : $('#userId').val(),
					'templateElement' : $('#templateElement').val()
				}, function(data) {
				 
				$("#header>table").hide();//保存完成后，隐藏功能面板
				});
			});
		
		},
		
		_bindEvent:function(){//事件绑定
			me._moduleLiClick();
			me._layoutAClick();
		},
		
		_moduleLiClick:function(){//绑定模块LI单击事件
			$("."+Jh.Config.ulCls+" li").on("click",function(){
				var _this = $(this),
					_mName = _this.find("a").attr("rel"),//获取模块名
					_m = $("#"+_mName), //模块div 
					_d = _this.find(".ok");//对号

					if (_m.size()<=0) {//判断是否已经存在，避免二次添加
						var	o = {},
							key  = _mName,	
							layout = "left",
							position ;
						
							o["name"] = _this.find("a").text();
							o["titleColor"] = _this.find("a").attr("titleColor");
							o["titleBColor"] = _this.find("a").attr("titleBColor");
							o["icon"] = _this.find("a").attr("icon");
							o["iconShow"] = _this.find("a").attr("iconShow");
							o["type"] = _this.find("a").attr("type");
						
						if (o["iconShow"]=="true"){
							Jh.Iconlink.createIconOne(key,o);
						}
						else {
							if(layout=='left'){
								position = $("#"+Jh.Layout.location.left);
							}else if(layout=='center'){
								position = $("#"+Jh.Layout.location.center);
							}else{
								position = $("#"+Jh.Layout.location.right);
							}
							// me._ele.ul.append(me._createLi(key,name));//添加功能标签
							position.append(Jh.Portal._createPortalOne(key,o));//添加portal
							Jh.Portal._eventRefresh();//重新绑定刷新事件并触发
						}
					}
					
				if(_d.is(":visible")){//判断是否显示
					_d.hide();//隐藏对号
					//_m.hide();//隐藏模块
					_m.remove();
				}else{
					_d.show();//显示对号
					_m.show();//显示模块
				}
				
				if($("#iconLink").find(".icon_con").size()<=0){
					$("#iconLink-box").hide();
				}else{
					$("#iconLink-box").show();
				}
				
				//控制占位符
				if(Jh.Portal.box.find(".groupItem").size() <= 0){
					Jh.Portal.box.find(".nowidget").show();
				}else{
					Jh.Portal.box.find(".nowidget").hide();
				}
				
				Jh.Util.refresh();
				
			});
		},
		
		_layoutAClick:function(){//绑定布局列表A 单击事件
			$("."+Jh.Config.layCls+" a").click(function(){
				var _this = $(this);
				var _v = _this.attr("rel");
				me._ToLayout(_v);
				_this.addClass("active").siblings().removeClass("active");
			});
		},
		
		_ToLayout:function(v){//刷新布局
			var CssMode= Jh.Layout.layoutCss, //布局模式  
				CssText= Jh.Layout.layoutText,//css 
				ModulesId= Jh.Layout.locationId, //模块id
				CssTextId=0,//默认css数组编号
				ModuleItems="";//模块数组
			$.each(CssMode, function(m, mn){
				if(v==mn) CssTextId=m;//css 赋值
			});	
	
			$.each(ModulesId, function(s, sn){					
				var currentModule = $(sn),				
					cssName = CssText[CssTextId],
					ary = cssName ? cssName.split(/\s+/) : "";//得到当前布局css数组
				switch(s){
					case "left": s =0;
					break;
					case "center": s =1;
					break;
					case "right":s = 2;
				}	
				if(ary[s]=='wnone') {//出现布局由3->2的变化	,最右边栏目的内容搬到最左边
					ModuleItems=currentModule.sortable('toArray');//获取最新的的元素
					$.each( ModuleItems, function(m, mn){				
						$("#"+Jh.Layout.location.left).append($("#"+mn));//注意在两栏三栏间切换的时候 返回已经丢失的模块,而且只能够逐个添加元素，不可以一次添加多个
					});
					currentModule.empty();//摧毁原有的元素，以免重复出现冲突
				}		
				currentModule.removeClass("w250 w300 w400 w500 w600 w800 w1000 wnone").addClass(ary[s]);//增加css
			});
	
		}
		
	};

}();

Jh.Iconlink = function(me){	//iconLink对象
	var _template = {
			iconLink : '<div class="iconLink" id="iconLink"></div>',
			icon_p : '<div class="icon_p" id="portal_i"></div>',
			icon_con: '<a class="icon_con" id="{id}" _type="{type}" refreshid="{id}" applicationId="{applicationId}">'
					+ '<div class="icon_s">{icon}</div>'
					+ '<div class="text" style="color:{titleColor};background-color:{titleBColor}">{name}</div>'
					+ '</a>'
	};
	return me = {
		init : function(iconLink){
			$("body").append("<div id='iconLink-box'></div>")
			me.create(iconLink);
			me.loadUrl();
			$("#portal").css("padding-bottom","70px");
			
			var count = 0;
			$.each(iconLink,function(key,obj){
				count++;
			});
			if(count==0){
				$("#iconLink-box").hide();
			}
			
		},		
		create : function(iconLink){	//插入body
			var $icon_p = $(_template.icon_p);
			var $iconLink = $(_template.iconLink).append($icon_p);
			$("#iconLink-box").append($iconLink);
			if(iconLink || iconLink!=undefined){
				$.each(iconLink,function(key,obj){
					me.createIconOne(key,obj);
				});
			}
		},
		createIconOne : function(key,obj){	//替换参数
			
			
			var $iconListNum = $("#iconLink").find(".icon_con").size();
			$("#iconLink").find(".icon_p").width(($iconListNum+1)*70);

			var setIcon
			if(obj.icon == "" || obj.icon == "null"){
				setIcon = Jh.Util.setIcon(obj.type);
			}else{
				var iconJson = Jh.Util.setValueJson(obj.icon);
				if(iconJson.icontype == "font"){
					setIcon = "<i class='"+ iconJson.icon +"' style='color:" + iconJson.iconFontColor + "'></i>";
				}else{
					setIcon = "<img src=\"" + contextPath + iconJson.icon +"\" />";
				}
			}
			var con_html = Jh.Util.format(_template.icon_con,{'name' : obj.name});
				con_html = Jh.Util.format(con_html,{'icon' : setIcon});
				con_html = Jh.Util.format(con_html,{'titleColor' : obj.titleColor});
				con_html = Jh.Util.format(con_html,{'titleBColor' : obj.titleBColor});
				con_html = Jh.Util.format(con_html,{'id' : key});
				con_html = Jh.Util.format(con_html,{'type' : obj.type});
				con_html = Jh.Util.format(con_html,{'applicationId' : obj.applicationId});				
			var $con_html = $(con_html);
				if(obj.actionContent){
					$con_html.attr("_actionContent",obj.actionContent);
				}
				
			$("#iconLink-box").find(".icon_p").append($con_html);

			if($("#iconLink").find(".icon_con").size()<=0){
				$("#iconLink-box").hide();
			}else{
				$("#iconLink-box").show();
			}
		},
		
		loadUrl : function(){	//加载url并设置
			$("#iconLink .icon_con").each(function(){
				$con = $(this);
				switch ($con.attr("_type")) {
				case "link":
					var $temp = $("<div></div>");
					var _url = "../widget/displayWidget.action?id="+$con.attr("id");
					
					$temp.appendTo($con);
					$temp.load(_url,function(){
						$cur = $(this);
						var _href = $cur.find("a").attr("href");
						$cur.parent().attr("_href",_href);
						$cur.parent().click(function(){
							parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
						});
						$cur.remove();
					});
					break;
				case "view":
					var _url = "../../portal/dynaform/view/displayViewWithPermission.action?_viewid="
						+ $con.attr("_actionContent") + "&clearTemp=true&_backURL=../../../portal/cool/closeTab.jsp";
					
					$con.attr("_href",_url).click(function(){
						parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
					});
					break;
				case "page":
					$con.attr("_href",$con.attr("_actionContent")).click(function(){
						parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
					});
					break;
				case "runquanReport":  //润乾报表 --报错
					var _url = "../../"+ $con.attr("_actionContent") + "&clearTemp=true&_backURL=../../../portal/closeTab.jsp";
					$con.attr("_href",_url).click(function(){
						parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
					});
					break;
				case "report": //报表
					var _url = "../.."+ $con.attr("_actionContent")+"?application="+$con.attr("applicationId")+"&_resourceid="+$con.attr("refreshid")+"&clearTemp=true&_backURL=../../../portal/closeTab.jsp";
					$con.attr("_href",_url).click(function(){
						parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
					});	
					break;
				case "crossreport": //交叉报表	
					break;
				case "customizeReport": //自定义报表
					var _url = "../share/report/oReport/oReport.jsp?application="+$con.attr("applicationId")+"&_resourceid="+$con.attr("_actionContent")+"&clearTemp=true&_backURL=../../../portal/closeTab.jsp";
					$con.attr("_href",_url).click(function(){
						parent.addTab($(this).attr("id"),$(this).text(),$(this).attr("_href"));
					});
					break;
				default:
					break;
				}
			});
		}
	};
}();

Jh.Portal = function(me){//Portal对象
	var _box = "<div id='portal'></div>",
		_template = {//模板
			l :"<div id='"+Jh.Layout.location.left+"' class='"+Jh.Config._groupWrapperClass+" w250'/>",
			m :"<div id='"+Jh.Layout.location.center+"' class='"+Jh.Config._groupWrapperClass+" w250'/>",
			r :"<div id='"+Jh.Layout.location.right+"' class='"+Jh.Config._groupWrapperClass+" w250'/>",
			portalWrap:"<div id='{key}' class='"+Jh.Config._groupItemClass+"'/>",
			itemHeader:"<div class='"+Jh.Config._groupItemHead+"' style='color:{titleColor};"
					+ "background-color:{titleBColor}' titleColor='{titleColor}' titleBColor='{titleBColor}'"
					+ "'><span>{icon}</span><span>{name}</span></div>",
			itemContent:"<div class='"+Jh.Config._groupItemContent+"'/>"
		};
	var _defaultCfg;
	var _userCfg;
	return me={	
		init:function(userCfg, defaultCfg){//初始化
			if(widget_custom && userCfg && userCfg!=undefined){
				_userCfg = eval("("+Jh.Util.setUserWidget(userCfg, defaultCfg)+")");
			}else{
				_userCfg = defaultCfg
			}
			_defaultCfg = defaultCfg;
			//初始化Portal
			me._create();
			me._bindData(_userCfg);
			Jh.Iconlink.init(_userCfg.appIcon);	//初始化图标链接--必须在最后
			me._bindEvent();
			
			Jh.fn.init(_userCfg,_defaultCfg);//初始化功能面板
			
		},
		
		_isFnExist:function(widgetId){//判断是否WidgetKey存在
			var flag = false;
			$.each(_defaultCfg.appL, function(k, o){
				if (widgetId == k) {
					flag = true;
					return;
				}
			});
			$.each(_defaultCfg.appM, function(k, o){
				if (widgetId == k) {
					flag = true;
					return;
				}
			});
			$.each(_defaultCfg.appR, function(k, o){
				if (widgetId == k) {
					flag = true;
					return;
				}
			});
			return flag;
		},

		_create:function(){//创建
			me.box = $(_box);
			me._elements = {};		
			me._createModulesWrap();
			Jh.Util.toBody(me.box.append("<div style='clear:both;'></div>"));	
			//占位符
			me.box.prepend('<div class="nowidget" style="display:none;">'
					+'<table height="100%" width="100%" border="0" style="margin-top:20%"><tr>'
					+'<td align="center" valign="middle">'
					+'<div class="content-space-txt text-center" style="width:100%;font-size:22px;text-align:center;color:#adadad;margin-bottom:18px;">当前没有widget</div>'
					+'</td></tr></table></div>');
		},	
		
		_bindData:function(op){//绑定数据
			var noWidget = true;
			
			$.each(op,function(key,item){
				if(!$.isEmptyObject(item)){
					me._createPortal(key,item);
					if(key != "layoutStyle" && key != "appIcon"){
						noWidget = false;
					}
				}
			});
			
			//首页无widget时添加占位符
			if(noWidget){
				me.box.find(".nowidget").show();
			}else{
				me.box.find(".nowidget").hide();
			}
		},
		
		_createModulesWrap:function(){//创建模块外层容器
			me._elements.m_l = $(_template.l);
			me._elements.m_m = $(_template.m);
			me._elements.m_r = $(_template.r);
			me._addPanel(me._elements.m_l);
			me._addPanel(me._elements.m_m);
			me._addPanel(me._elements.m_r);
		},
		
		_addPanel:function(o){//往容器里添加
			me.box.append(o);
		},
		
		_createPortal:function(key,item){//创建portal
			var mWrap ;
			switch(key){
			   case "appL":mWrap = me._elements.m_l;
				break;
			   case "appM":mWrap = me._elements.m_m;
				break;
			   case "appR":mWrap = me._elements.m_r;
				break;
			}
			
			if (key!="layoutStyle")//添加内容部分,即：非layoutStyle
				$.each(item,function(k,o){
					if (me._isFnExist(k))
						mWrap.append(me._createPortalOne(k,o));
				});
		},
		
		_createPortalOne:function(key,o){//创建单个portal item
			var itemHeader  =  me._createItemHeader(o),//header
			    itemContent =  me._createItemContent(),//content
			    portalWrap  = $(Jh.Util.format(_template.portalWrap,{"key":key}))
							.append(itemHeader)
							.append(itemContent);
			
			return portalWrap;
		},
		
		_createItemHeader:function(o){//创建Head
			//旧数据兼容
			if(typeof(o)=="string"){o = {"name":o,"titleColor":"","icon":"/lib/icon/16x16_0040/application_view_list.png","titleBColor":""};}
			var setIcon
			if(o.icon == "" || o.icon == "null"){
				setIcon =  "<img src=\"" + contextPath + Jh.Util.setIcon(o.type) +"\" />";
			}else{
				var iconJson = Jh.Util.setValueJson(o.icon);
				if(iconJson.icontype == "font"){
					setIcon = "<i class='"+ iconJson.icon +"' style='color:" + iconJson.iconFontColor + "'></i>";
				}else{
					setIcon = "<img src=\"" + contextPath + iconJson.icon +"\" />";
				}
			}
			var _itemHtml = Jh.Util.format(_template.itemHeader,{"name":o.name});
			_itemHtml = Jh.Util.format(_itemHtml,{"titleColor":o.titleColor});
			_itemHtml = Jh.Util.format(_itemHtml,{"titleBColor":o.titleBColor});
			_itemHtml = Jh.Util.format(_itemHtml,{"icon":setIcon});

			var  _itemHeader = $(_itemHtml),//格式化header
				_actionWrap =  me._createDiv("action").hide().appendTo(_itemHeader);//创建一个div
			
			me._createA(Jh.Config.refresh,Jh.Config.refreshtext,true).appendTo(_actionWrap);
			me._createA(Jh.Config.min,Jh.Config.mintext,true).appendTo(_actionWrap);
			me._createA(Jh.Config.max,Jh.Config.maxtext,false).appendTo(_actionWrap);
			me._createA(Jh.Config.close,Jh.Config.closetext,true).appendTo(_actionWrap);
			
			_itemHeader.hover(function(){//滑过标题出现删除图标
				$(this).find(".action").show();			
			},function(){
				$(this).find(".action").hide();
				
			});
			return _itemHeader;
		},
		
		_createItemContent:function(){//创建content
			var _content = $(_template.itemContent);
			$("<ul style='padding:10px;margin:0px;'><li>Loading...</li></ul>").appendTo(_content);
			return _content;
		},
		
		_createDiv:function(classname){
			var _div = $("<div/>").addClass(classname);
			return _div;
		},
		
		_createA:function(classname,title,isShow){//创建A 
			var _a = $("<a href='javascript:void(0);' class='"+classname+"' title='"+title+"'/>");
			if(!isShow){
				_a.hide();
			}
			return _a ;
		},

		_eventMin :function(){		
			$("."+Jh.Config.min).on("click",function(){//关闭面板
				var _me = $(this);
				var _groupItem = _me.parent().parent().parent();
				_groupItem.find("."+Jh.Config._groupItemContent).hide();
				_groupItem.find("."+Jh.Config.max).show();
				_me.hide();
			});	
		},
		
		_eventMax:function(){			
			$("."+Jh.Config.max).on("click",function(){//展开面板
				var _me = $(this),
					_groupItem = _me.parent().parent().parent();
				_groupItem.find("."+Jh.Config._groupItemContent).show();
				_groupItem.find("."+Jh.Config.min).show();
				_me.hide();
			});
		},
		
		_eventRemove:function(){
			$("."+Jh.Config.close).on("click",function(){//移除面板
				var _this  = $(this),
					_p  = _this.parent().parent().parent();//得到当前父级面板				
				_p.fadeOut('500',function(){//500毫秒后移除
					var _this = $(this);
					var _id = _this.attr("id");//得到模块id			
					var _a  = $(".tag-list").find("a[rel='"+_id+"']");
					_this.remove();
					_a.parent().remove();//移除功能列表中的li
				});			
			});
		},
		
		_renderSummary:function($me){//渲染摘要
			var refreshId = $me.closest("div.groupItem").attr("id");

			//添加More，大于6条时显示
			var _total = $me.next("#total").attr("_total");
			if (_total>5){
				$("<span class='more'><a>More(<span style='color:#f00'>"+_total+"</span>)&gt;&gt;</a></span>").click(function(){
					parent.addTab("tabs_flowcenter","&#27969;&#31243;","flowCenter.jsp");
				}).appendTo($me);
			}
			
			//绑定待办点击事件，实现打开一个新TAB
			$me.find("li").click(function(){
				var $this = $(this);
				var id = $this.attr("id");
				var title = $this.text();
				title = !title || $.trim(title).length == 0 ? "..." : $.trim(title);
				title = title.length > 5 ? title.substring(0, 5) + ".." : title;
				var url = $this.attr("_url")+"&_backURL="+closeUrlStr+"?refreshId="+refreshId;
				$this.find(">span.unread").removeClass("unread");
				parent.addTab(id,title,url);
			}).each(function(){
				var $li = $(this),
				$span = $("<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>");
				if ($li.attr("_isread")=="false") {
					$span.addClass("unread");						
				}
				$li.prepend($span);
			});			
		},

		_renderView:function($me) {//渲染视图
			var refreshId = $me.closest("div.groupItem").attr("id");
			var urlTemplate = "../dynaform/document/view.action?_formid={formid}&_docid={docid}&application={appid}";
			var applicationId = $me.attr("_applicationId");
			var viewId = $me.attr("_viewid");
			var $table = $me.find("table");
			var column_no = 1;
			
			var userAgent = window.navigator.userAgent.toLowerCase();
			$table.css("display","table").css("width","100%");
			if (userAgent.indexOf('msie')<=0) {
				$table.find("tr.header").css("font-size","15");
			}
			
			//处理Column属性所应该有的相关表现
			$table.find("td").each(function(){
				var $td = $(this);
				if ($td.attr("isshowtitle")!="true") {
					$td.removeAttr("title");
				}
			});

			$table.find("tr.header>td").css("font-weight","bold");
			
			$table.find("tr").each(function(){
				var url = "", $tr = $(this), docid, formid,viewTemplateForm;
				
				$tr.children().each(function(){
					var $td = $(this);	
					if($td.attr("ishiddencolumn") == "true" || $td.attr("ishidden") == "true" || $td.attr("isvisible") == "false"){
						$td.hide();
					}
					//渲染状态标签数据
					if($tr.attr("trtype") == "dataTr"){
						if($td.attr("colFieldName") == "$StateLabel"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							var divdata = JSON.parse(divhtml.substring(1,divhtml.length-1));
							var objdata = eval(divdata.nodes);
							var stateLabel = ""
							for(var i=0;i<objdata.length;i++){  
								stateLabel = objdata[i].stateLabel;   
							}
							divtype.empty().append(stateLabel);
							return $tdHtml;
						}
						if($td.attr("colFieldName") == "$PrevAuditNode"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							var divdata = JSON.parse(divhtml);
							var prevAuditNode = ""
							for(var i=0;i<divdata.length;i++){  
								prevAuditNode += divdata[i].prevAuditNode+",";
							}
							if(prevAuditNode.length>0){
								prevAuditNode = prevAuditNode.substring(0,prevAuditNode.length-1);
							}
							divtype.empty().append(prevAuditNode);
							$tdHtml.find("div[name='result']").text(prevAuditNode);
							return $tdHtml;
						}
						if($td.attr("colFieldName") == "$PrevAuditUser"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							var divdata = JSON.parse(divhtml);
							var prevAuditUser = ""
							for(var i=0;i<divdata.length;i++){  
								prevAuditUser += divdata[i].prevAuditUser+",";
							}
							if(prevAuditUser.length>0){
								prevAuditUser = prevAuditUser.substring(0,prevAuditUser.length-1);
							}
							divtype.empty().append(prevAuditUser);
							$tdHtml.find("div[name='result']").text(prevAuditUser);
							return $tdHtml;
						}
						if("COLUMN_TYPE_ROWNUM"==$td.attr("colType")){
							var $tdHtml=$(this); 
							$tdHtml.find("div[name='result']").text(column_no);
							column_no++;
							return $tdHtml;
						}
					}
					//渲染地图控件数据
					if($td.attr("fieldinstanceofmapfield") == "true"){
						var convert2HTMLEncode = function(str){
							var s = str;
							if("COLUMN_TYPE_FIELD" == $td.attr("colType") && !$td.attr("colFieldName").substr(0,1) == "$" && !$td.attr("colFlowReturnCss")){
								s = s.replace(new RegExp(">","gm"),"&gt;");
								s = s.replace(new RegExp("<","gm"),"&lt;");
							}
							return s;
						};
						var $tdHtml=jQuery(this);
						var divtype=$tdHtml.children("div[name=result]");
						var application = jQuery("body",parent.document).find("#application").val();
						var fieldVal = "";
						var displayType = 1;
						var docId = $tdHtml.attr('docId');
						docId = docId?docId:'';
						var f_id = docId + "_" + $td.attr("colFieldName");
						var valhtml = convert2HTMLEncode($td.attr("title")) == " "?"":"value = '" + convert2HTMLEncode($td.attr("title")) + "'";
						var btnHtml = "<input type='hidden' id = '" + f_id + "' " + valhtml + ">";
						btnHtml += "<img src='../../portal/share/images/view/map.png' style='margin: 0 5px;'";
						btnHtml += " onclick=\"FormBaiduMap('";
						btnHtml += f_id + "', '";
						btnHtml += application + "', '";
						btnHtml += displayType + "')\"";
						btnHtml +="/>";
						divtype.empty().append(btnHtml);
						return $tdHtml;
					}
				});
				
				$tr.addClass("widgetItem").find("td").each(function(){
					if (url == "") {
						var $td = $(this);
						formid = $td.attr("docformid");
						viewTemplateForm = $td.attr("viewTemplateForm");
						docid = $td.attr("docid");
						
						if (formid && docid && applicationId) {
							url = urlTemplate.replace(/\{formid\}/g,formid).replace(/\{docid\}/g, docid).replace(/\{appid\}/g,applicationId);
							if(viewTemplateForm){
								url+= "&_templateForm="+viewTemplateForm;
							}
							url += "&_backURL="+closeUrlStr+"?refreshId="+refreshId;
						}
						
					}
				});
				if (url != "") {
					$tr.find(">td[isreadonly!='true']").click(function(e){
						if(e.target && $(e.target).attr("name")=="result"){//阻止冒泡事件触发打开新页签的行为
							parent.addTab(docid, "...", url);
						} else if (e.target && $(e.target).is("a")){
							url = $(e.target).attr("href");
							$(e.target).attr("href");
							if (url!="" && url!="#") {
								parent.addTab(docid, "...", url);
							}
							return false;
						} else{
							return false;
						}
					});
				}
			});

			//超过5条数据时显示更多
			if($table.find("tr").size()>5){
				var $a = $("<span class='more'><a>More&gt;&gt;</a></span>").bind("click",function(){
					var url = "../dynaform/view/displayView.action?_viewid="+viewId+"&application="+applicationId;
					parent.addTab(viewId, "...", url);
				}).insertAfter($table);
			}
			
			var h = $me.attr("_height");
			if (h && h!='') {
				$me.height(h);
			}
			
		},

		_renderLink:function($me) {//渲染内部链接
			$me.find("a").wrap("<div style='width:100%' class='widgetItem link' />").each(function(){
				var $a = $(this),url=$a.attr("_href");
				$a.attr("_href",$a.attr("href")).removeAttr("href");//移除href属性，避免重复打开2次
				$a.closest("div").click(function(){
					var $a = $(this).find(">a"),url=$a.attr("_href");
					parent.addTab($a.text(),$a.text(),url);
				});
			});
		},

		_renderExtLink:function($me) {//渲染外部Widget内容，由于Ajax的安全限制，不能直接通过load方法载入，而需要服务器通过http协议方式获得内容并返回。
			$me.find("iframe").load(function(){
				var $iframe = $(this);
				var scrollHeight = 0;
				try {
					if (this.contentDocument) {
						scrollHeight = this.contentDocument.body.widgetBody.scrollHeight;
					}
					else if (this.document) {
						scrollHeight = this.document.body.widgetBody.scrollHeight;
					}
				}catch(e){}

				var h = $iframe.parent().attr("_height");
				if (h && h!='') {
					$iframe.height(h);
				}
				
				$iframe.height( h > scrollHeight && scrollHeight > 0 ? scrollHeight :  h);
			});
		},

		_eventRefresh:function(){	
			$("."+Jh.Config.refresh).unbind("click").bind("click",function(){//刷新
				var _me = $(this),
					_groupItem = _me.parent().parent().parent();
				var refreshUrl = "../widget/displayWidget.action?id="+_groupItem.attr("id");
				_groupItem.find("ul").load(refreshUrl, function(data){
					var $content = $(this).find(".widgetContent");
					switch($content.attr("_type")) {
						case "summary":
							me._renderSummary($content);
						break;
						case "view":
							me._renderView($content);
						break;
						case "link":
							me._renderLink($content);
						break;
						case "extlink":
							me._renderExtLink($content);
						break;
						case "announcement":
							me._renderAnnouncement($content);
						break;
						case "weather":
							$("#system_weather").remove();
						break;
						case "workflow":
							$("#system_workflow").remove();
						break;
					}
				});
			}).trigger("click");
			//添加刷新事件
			$("."+Jh.Config.refresh).closest("div.groupItem").unbind("refresh").bind("refresh",function(){
				$(this).find("."+Jh.Config.refresh).trigger("click");
			}).each(function(){//添加refreshId属性，为后面查找刷新对象做准备
				$(this).attr("refreshId", $(this).attr("id"));
			});
		},
		_renderAnnouncement:function($me){//通知公告
			var refreshId = $me.closest("div.groupItem").attr("id");

			//打开一个新TAB
			$me.find("li").click(function(){
				var $this = $(this);
				var id = $this.attr("id");
				var title = $this.text();
				var url = $this.attr("_url");
				$this.find(">span.unread").removeClass("unread");
				parent.addTab(id,title,url);
			}).each(function(){
				var $li = $(this),
				$span = $("<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>");
				if ($li.attr("_isread")=="false") {
					$span.addClass("unread");						
				}
				$li.prepend($span);
			});			
		},
		
		_eventSortable:function(){//绑定排序
			$("."+Jh.Config._groupWrapperClass).sortable({
				connectWith: "."+Jh.Config._groupWrapperClass,								
				opacity :"0.6",	
				dropOnEmpty:true,
				change:function(){$("#header>table").show();}//显示隐藏的工具面板
			}).disableSelection();	
			$(".icon_p").sortable({
				connectWith: ".icon_p",								
				opacity :"0.6",	
				dropOnEmpty:true,
				change:function(){$("#header>table").show();}//显示隐藏的工具面板
			}).disableSelection();	
		},
		
		_eventHover:function(){//绑定Hover,实现激活的动画效果
			$("."+Jh.Config._groupItemClass).css("margin-top","5px").css("margin-bottom","20px").hover(
				function(){
					var $this = $(this);
					if ($this.prev().size()>0) {
						$(this).css("margin-bottom","22px").prev().css("margin-bottom","18px");
					} 
					else {
						$(this).css("margin-top","3px").css("margin-bottom","22px");
					}
					$this.find(">."+Jh.Config._groupItemContent).css("background-color","#fff");
				},
				function(){
					var $this = $(this);
					if ($this.prev().size()>0) {
						$(this).css("margin-bottom","20px").prev().css("margin-bottom","20px");
					} 
					else {
						$(this).css("margin-top","5px").css("margin-bottom","20px");
					}
					$this.find("."+Jh.Config._groupItemContent).css("background-color","");
				}
			);
			
		},
		
		_bindEvent:function(){	//绑定面板所有事件
			me._eventSortable();
			me._eventHover();
			me._eventRefresh();
			me._eventRemove();
			me._eventMax();
			me._eventMin();
		}	
	
	};
}();