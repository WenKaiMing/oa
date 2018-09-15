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
		tdCls3:"form-text3",
		tdCls2:"single",
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
		_right ="portal_r",
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
			0 :function(){return "w25 w75 wnone";}(),
			1 :function(){return "w75 w25 wnone";}(),
			2 :function(){return "w33 w66 wnone";}(),
			3 :function(){return "w66 w33 wnone";}(),
			4 :function(){return "w25 w50 w25";}(),
			5 :function(){return "w25 w25 w50";}(),
			6 :function(){return "w50 w25 w25";}(),
			7 :function(){return "w33 w33 w33";}(),
			8 :function(){return "w50 w50 wnone";}(),
			9 :function(){return "w00 wnone wnone";}()
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
	
	//转换星期
	date2Week:function(date,num){
		var dateArray = new Array();      
        dateArray = date.split('-');
        var dateWeek = new Date(dateArray[0],parseInt(dateArray[1]-1),dateArray[2]);   
        var dateWeekTxt;
        var dateWeekNum = dateWeek.getDay() + num;
        if(dateWeekNum>7){
        	dateWeekNum = dateWeekNum - 7;
        }
        
        switch(dateWeekNum) {
			case 1:
				dateWeekTxt = "星期一";
			break;
			case 2:
				dateWeekTxt = "星期二";
			break;
			case 3:
				dateWeekTxt = "星期三";
			break;
			case 4:
				dateWeekTxt = "星期四";
			break;
			case 5:
				dateWeekTxt = "星期五";
			break;
			case 6:
				dateWeekTxt = "星期六";
			break;
			case 7:
				dateWeekTxt = "星期日";
			break;
		}
        return dateWeekTxt;
	},
	//设置天气图标
	weatherIcon:function(wday,wnight){
		if(wday == ""){
			wday = "na"
		}
		if(wnight == ""){
			wnight = "na"
		}
		var day=new Date();      
		var D=day.getHours();
		var daytype;
		if (D<=18 && D > 6)    {      
			weatherType = wday;
			daytype = "_0";
		}else{      
			weatherType = wnight;
			daytype = "_0";
		}  
		var weatherPicUrl;

        switch(weatherType) {
        	
	        case "na":
				weatherPicUrl = "resource/images/weather/na.png";
			break;
			case "xiaoyu":
			case "zhongyu":
			case "dayu":
			case "baoyu":
				weatherPicUrl = "resource/images/weather/yu"+daytype+".png";
			break;
			default:
				weatherPicUrl = "resource/images/weather/"+weatherType+daytype+".png";
			break;
		}
        return weatherPicUrl;
	},
	//设置cookie
	setCookie:function(name,value){ 
	    var Days = 30; 
	    var exp = new Date(); 
	    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
	    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
	},
	//获取cookie
	getCookie:function(name){ 
	    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	    if(arr=document.cookie.match(reg)){
	    	return unescape(arr[2]); 
	    }else{
	    	return null; 
	    }    
	},
	setIcon:function(widgetType){
		var defaultIcon;
		var _defaultIcon = {
				iconCustomizeReport : '/portal/H5/resource/images/icon-other.png',
				iconIscript : '/portal/H5/resource/images/icon-other.png',
				iconLink : '/portal/H5/resource/images/icon-link.png',
				iconPage : '/portal/H5/resource/images/icon-extlink.png',
				iconReport : '/portal/H5/resource/images/icon-other.png',
				iconRunquanReport : '/portal/H5/resource/images/icon-other.png',
				iconSummary : '/portal/H5/resource/images/icon-summary.png',
				iconSystemAnnouncement : '/portal/H5/resource/images/icon-announcement.png',
				iconSystemWorkflow : '/portal/H5/resource/images/icon-workflow.png',
				iconSystemWeather : '/portal/H5/resource/images/icon-weather.png',
				iconView : '/portal/H5/resource/images/icon-view.png',
				iconWorkflowAnalyzer : '/portal/H5/resource/images/icon-other.png',
				iconOther : '/portal/H5/resource/images/icon-other.png'
		};
		switch (widgetType) {
			case "customizeReport":
				defaultIcon = _defaultIcon.iconCustomizeReport;
				break;
			case "iscript":
				defaultIcon = _defaultIcon.iconIscript;
				break;
			case "link":
				defaultIcon = _defaultIcon.iconLink;
				break;
			case "page":
				defaultIcon = _defaultIcon.iconPage;
				break;
			case "report":
				defaultIcon = _defaultIcon.iconReport;
				break;
			case "summary":
				defaultIcon = _defaultIcon.iconSummary;
				break;
			case "system_announcement":
				defaultIcon = _defaultIcon.iconSystemAnnouncement;
				break;
			case "system_workflow":
				defaultIcon = _defaultIcon.iconSystemWorkflow;
				break;
			case "system_weather":
				defaultIcon = _defaultIcon.iconSystemWeather;
				break;
			case "view":
				defaultIcon = _defaultIcon.iconView;
				break;
			case "workflow_analyzer":
				defaultIcon = _defaultIcon.iconWorkflowAnalyzer;
				break;
			default:
				defaultIcon = _defaultIcon.iconOther;
				break;
		}
		return defaultIcon;
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
			$("<div id='configBtn'><span class='configImg'></span></div>")
			.hover(function(){
				//addClass("")
			},function(){

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
				_div = $("<ul/>").addClass(Jh.Config.layCls)
				  				  .append(me._createA("1"))
								  .append(me._createA("1:1"))
								  .append(me._createA("1:2"))
								  .append(me._createA("2:1"))
//								  .append(me._createA("1:3"))
//								  .append(me._createA("3:1"))
								  .append(me._createA("1:1:1"))
//							 	  .append(me._createA("1:1:2"))
//								  .append(me._createA("1:2:1"))
//								  .append(me._createA("2:1:1"))
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
			var _save= $("<a class='button b'>\u4FDD\u5B58\u914D\u7F6E</a>");
			me._ele.atd.append(_save);
			me._bindSave(_save);
			var _reset = $("<a class='button b'>重置配置</a>");
			me._bindReset(_reset);
			me._ele.atd.append(_reset);
			var _cancel = $("<a class='button b'>取消操作</a>");
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
			return $("<li><a href='javascript:void(0);' rel='"+text+"'>"+text+"</a><span class='ok' style='display:none;'></span></li>");
		},
		
		_createLi:function(key,o){//创建li
			//不渲染天气widget
			if(key != "system_weather"){
				var setIcon
				if(o.icon == "" || o.icon == "null"){
					setIcon = Jh.Util.setIcon(o.type);
				}else{
					setIcon = o.icon;
				}
				 
				var $li = $("<li/>").append("<a href='javascript:void(0);' rel='"+key+"' titleColor='"+o.titleColor+"' icon='"+setIcon+"' type='"+o.type+"' titleBColor='"+o.titleBColor+"' iconShow='"+o.iconShow+"' >"+o.name+"</a>").append("<span class='ok'></span>");
				////--todo
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
		
		_bindCancel:function(obj){//取消操作模块
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
		_bindSave:function(obj){//保存配置模块
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
//					_layout="\u9ED8\u8BA4";
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
						
					// me._ele.ul.append(me._createLi(key,name));//添加功能标签
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
			$("."+Jh.Config.layCls+" li").click(function(){
				var _this = $(this);
				var _v = _this.find("a").attr("rel");
				me._ToLayout(_v);
				$("."+Jh.Config.layCls+" li").find("a").removeClass("active");
				_this.find("a").addClass("active");
				_this.find("span").show().end().siblings().find("span").hide();
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
				currentModule.removeClass("w25 w33 w50 w66 w75 w00 wnone").addClass(ary[s]);//增加css
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
					+ '</a>',
			icon_arrow_up: '<span class="icon-arrow glyphicon glyphicon-chevron-up" style="width:100%"></span>',
			icon_arrow_down: '<span class="icon-arrow glyphicon glyphicon-chevron-down" style="width:100%"></span>'
	};
	return me = {
		init : function(iconLink){
			$("body").append("<div id='iconLink-box'></div>");
			me.create(iconLink);
			me.loadUrl();
			
			var $iconLink = $("#iconLink");
			
			$iconLink.height($("#iconLink-box").height()-50);
			
			$("#portal_i").slimScroll({
		        height: $("#iconLink-box").height()-50-40,
		        position: 'left',
				distance: '-10px'
		    });
			
			$iconLink.find(".glyphicon-chevron-up").click(function(){
				var scrollHeight = $("#portal_i")[0].scrollHeight;
				var scrollDivHeight = $(this).siblings(".slimScrollDiv").height();
				var scroll = $(this).siblings(".slimScrollDiv").find("#portal_i").scrollTop();
				var scrollTo = scroll + 64 - (scroll % 64);
				$(this).siblings(".slimScrollDiv").find("#portal_i").animate({scrollTop: scrollTo+"px"}, 200);				
			})
			
			$iconLink.find(".glyphicon-chevron-down").click(function(){
				var scrollHeight = $("#portal_i")[0].scrollHeight;
				var scrollDivHeight = $(this).siblings(".slimScrollDiv").height();
				var scroll = $(this).siblings(".slimScrollDiv").find("#portal_i").scrollTop();
				if(scroll % 64<=64 && scroll % 64!=0){
					var scrollTo = scroll - (scroll % 64);
				}else{
					var scrollTo = scroll - 64 - (scroll % 64);
				}
				$(this).siblings(".slimScrollDiv").find("#portal_i").animate({scrollTop: scrollTo+"px"}, 200);
				
			})
			
			$("#portal_i").scroll(function() {
				var $this = $(this);
				var scrollHeight = $this[0].scrollHeight;
				var scrollDivHeight = $this.parent(".slimScrollDiv").height();
				var scroll = $this.scrollTop();
				
				if(scroll >= scrollHeight - scrollDivHeight){
					$iconLink.find(".glyphicon-chevron-up").css("color","#ffffff");
					$iconLink.find(".glyphicon-chevron-down").css("color","#ced6db");
				}else if(scroll <= 0){
					$iconLink.find(".glyphicon-chevron-up").css("color","#ced6db");
					$iconLink.find(".glyphicon-chevron-down").css("color","#ffffff");
				}else{
					$iconLink.find(".glyphicon-chevron-up").css("color","#ced6db");
					$iconLink.find(".glyphicon-chevron-down").css("color","#ced6db");
				}
			});
		},
		create : function(iconLink){	//插入body
			var $icon_p = $(_template.icon_p);
			var $iconLink = $(_template.iconLink).append($icon_p);
			$iconLink.prepend(_template.icon_arrow_up).append(_template.icon_arrow_down);
			$("#iconLink-box").append($iconLink);
			if(iconLink || iconLink!=undefined){
				$.each(iconLink,function(key,obj){
					me.createIconOne(key,obj);
				});
			}
		},
		
		createIconOne : function(key,obj){	//替换参数
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
					var _url = "../share/report/oReport/oReport.jsp?id="+$con.attr("_actionContent")+"&application="+$con.attr("applicationId")+"&_resourceid="+$con.attr("_actionContent")+"&clearTemp=true&_backURL=../../../portal/closeTab.jsp";
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
			portalWrap:"<div id='{key}' _type='{type}' class='"+Jh.Config._groupItemClass+"'/>",
			itemHeader:"<div class='"+Jh.Config._groupItemHead+"'"
					+ " titleColor='{titleColor}' titleBColor='{titleBColor}'"
					+ "'><span>{icon}</span><span style='color:{titleColor};background-color:{titleBColor};'>{name}</span></div>",
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
			Jh.Iconlink.init(_userCfg.appIcon);	//初始化图标链接--必须在最后,不好看 要优化
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
			me.box.append('<div class="nowidget" style="display:none;position:fixed;left:0px;right:85px;z-index:10;">'
					+'<table height="100%" width="100%" border="0" style="margin-top:20%;"><tr>'
					+'<td align="center" valign="middle">'
					+'<div class="content-space-pic iconfont-h5" style="width:100%;font-size:80px;text-align:center;color:#adadad;">&#xe050;</div>'
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
			
			if (key!="layoutStyle" && key!="appIcon")//添加内容部分,即：非layoutStyle
				$.each(item,function(k,o){
					if (me._isFnExist(k))
						mWrap.append(me._createPortalOne(k,o));
				});
		},
		
		_createPortalOne:function(key,o){//创建单个portal item
			//不渲染天气widget
			if(key != "system_weather"){
				var itemHeader  =  me._createItemHeader(o),//header
			    itemContent =  me._createItemContent();//content
				var portalWrap  = Jh.Util.format(_template.portalWrap,{"key":key});
				portalWrap = $(Jh.Util.format(portalWrap,{"type":o.type})).append(itemHeader).append(itemContent);
				return portalWrap;
			}
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
			//$("\"."+classname+"\"").append("<span class='glyphicon glyphicon-search' aria-hidden='true'></span>");
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
					
				var $table = $("#header").find("table");
				
				if ($table.is(":hidden")) {
					$table.show();
				} else {
					$table.hide();
				}

				_p.fadeOut('500',function(){//500毫秒后移除
					var _this = $(this);
					var _id = _this.attr("id");//得到模块id			
					var _a  = $(".tag-list").find("a[rel='"+_id+"']");
					//_this.remove();
					_a.trigger("click");
				});					
			});
		},
		
		_renderSummary:function($me){//渲染摘要
			var refreshId = $me.closest("div.groupItem").addClass("widget-summary").attr("id");

			//添加More，大于6条时显示
			var _total = $me.next("#total").attr("_total");
			
			if (_total>5){
				$("<span class='more'><a class='btn btn-default' _url='pending.jsp' role='button'>更多»</a></span>").click(function(){
					parent.addTab("tabs_flowcenter","&#27969;&#31243;","flowCenter.jsp");
				}).appendTo($me);
			}
			if(_total==0){
				var $null = $("<p class='zhanwei'>当前没有数据<span style=''>。。。</span><img src='../H5/resource/homepage/images/null.png' class='animated'/></p>");
				$null.appendTo($me.parent());
				$me.parent().find(".zhanwei img").animate({left: '0px'}, "slow");
			}
			//绑定待办点击事件，实现打开一个新TAB
			$me.find("li").click(function(){
				var $this = $(this);
				var id = $this.attr("id");
				var title = $this.text();
				var url = $this.attr("_url")+"&_backURL="+closeUrlStr+"?refreshId="+refreshId;
				parent.addTab(id,title,url);
			});
		},

		_renderView:function($me) {//渲染视图
			var refreshId = $me.closest("div.groupItem").addClass("widget-view").attr("id");
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
				//列宽
				if($td.attr("colwidth") && $td.attr("colwidth") != ""){
					$td.width($td.attr("colwidth"));
				}
				//字体大小
				if($td.attr("colColor") && $td.attr("colColor") != ""){
					$td.css("color",$td.attr("colColor"));
				}
				//字体颜色
				if($td.attr("colFontSize") && $td.attr("colFontSize") != ""){
					$td.css("font-size",$td.attr("colFontSize")+"px");
				}
			});

			$table.find("tr.header>td").css("font-weight","bold");
			
			$table.find("tr").each(function(){
				var url = "", $tr = $(this), docid, formid,viewTemplateForm;
				$tr.children().each(function(index){
					var $td = $(this);	
					if($td.attr("ishiddencolumn") == "true" || $td.attr("ishidden") == "true" || $td.attr("isvisible") == "false"){
						$td.hide();
						$table.find("tr:gt(0)").each(function(){
							$(this).find(" td:eq("+index+")").attr("isHidden", $td.attr("isHiddenColumn"));
						});
					}
					//渲染状态标签数据
					if($tr.attr("trtype") == "dataTr"){
						
						if($td.attr("colFieldName") == "$StateLabel"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							if(divhtml.indexOf("[")>=0){
								var divdata = JSON.parse(divhtml.substring(1,divhtml.length-1));
								var objdata = eval(divdata.nodes);
								var stateLabel = ""
								for(var i=0;i<objdata.length;i++){  
									stateLabel = objdata[i].stateLabel;   
								}
								divtype.empty().append(stateLabel);
							}
							
							return $tdHtml;
						}
						if($td.attr("colFieldName") == "$PrevAuditNode"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							if(divhtml.indexOf("[")>=0){
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
							}
							return $tdHtml;
						}
						if($td.attr("colFieldName") == "$PrevAuditUser"){
							var $tdHtml=jQuery(this);
							var divtype=$tdHtml.children("div[name=result]");
							var divhtml=divtype.html();
							if(divhtml.indexOf("[")>=0){
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
							}
							
							return $tdHtml;
						}
						if("COLUMN_TYPE_ROWNUM"==$td.attr("colType")){
							var $tdHtml=$(this); 
							$tdHtml.find("div[name='result']").text(column_no);
							column_no++;
							return $tdHtml;
						}
						//渲染word控件数据
						if("genericwordfield" == $td.attr("fieldtype") || "wordfield" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result && _result != "" && _result != " "){
								var aHtml = "";
								var resultObj = JSON.parse(_result);
								aHtml = "<img class='genericword' src='../share/images/view/genericword.jpg' "+
												"data-title='"+$td.showword+"' "+
												"data-fileName='"+resultObj.filename+"' "+
												"data-path='"+resultObj.path+"' "+
												"data-type='"+resultObj.type+"' "+
												"data-colFieldName='"+$td.colFieldName+"'/>";
								$tdHtml.find("div[name='result']").html(aHtml);
								return $tdHtml;
							}
						}
						//渲染在线拍照控件数据
						if("onlinetakephoto" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							var divHtml = '<div name="result">';
							var aHtml = "";
							if(_result && _result != "" && _result != " "){
								var _url = $(_result).attr("url").replace(/\\'/g,"");
								aHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
										"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
										"</div>";
								divHtml += aHtml;
								
							}
							divHtml += '</div>';
							$tdHtml.html(divHtml);
							return $tdHtml;
						}
						//渲染录音控件数据
						if("weixinrecordfield" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result && _result != "" && _result != " "){
								var aHtml = "";
								aHtml+='<div class="weixin_record">';
								aHtml+= '<img src="../share/images/view/voice.png" width="21px"/>';
								aHtml+='</div>';
								$tdHtml.find("div[name='result']").html(aHtml);
								return $tdHtml;
							}
						}
						//渲染微信GPS控件
						if("weixingpsfield" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result && _result != "" && _result != " "){
								var aHtml = "";
								var location = JSON.parse(_result);
								aHtml+='<div class="gps_col">';
								if($td.showType=="00"){//真实值
									aHtml+='<a href="#" class="gps_col_link" data-location=\''+result+'\'>';
									aHtml+='<span class="gps_col_text">'+location.address+'</span>';
									aHtml+='</a>';
								}else{//显示值
									aHtml+='<span class="gps_col_text">'+location.address+'</span>';
								}
								aHtml+='</div>';
								$tdHtml.find("div[name='result']").html(aHtml);
								return $tdHtml;
							}
						}
						//渲染图片上传控件数据
						if("imageupload" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result && _result != "" && _result != " "){
								var aHtml = "";
								var _images = JSON.parse(_result);
								for(var i = 0; i < _images.length; i++){
									var _url = contextPath + _images[i].path;
									var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
											"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
											"</div>";
									aHtml += _picHtml;
								}
								$tdHtml.find("div[name='result']").html(aHtml);
								return $tdHtml;
							}
						}
						
						//渲染文件控件数据
						if("attachmentupload" == $td.attr("fieldtype")){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result && _result != "" && _result != " "){
								var aHtml = "";
								var _images = JSON.parse(_result);
								for(var i = 0; i < _images.length; i++){
									var _name = _images[i].name;
									var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ encodeURI(_name) + "&filepath=" + _images[i].path);
									var _picHtml = "<a href='" + url + "' target='_about'>" + _name + "</a>";
									aHtml += _picHtml;
								}
								$tdHtml.find("div[name='result']").html(aHtml);
								return $tdHtml;
							}
						}
						
						//视图列样式
						//1.截断字符串
						if($td.attr("coldisplaylength") && $td.attr("coldisplaylength") > 0 ){
							var $tdHtml=$(this); 
							var _result = $tdHtml.find("div[name='result']").html();
							if(_result.length > $td.attr("coldisplaylength")){
								_result = _result.substring(0,$td.attr("coldisplaylength"))+"...";
							}
							$tdHtml.find("div[name='result']").html(_result);
						}
						//2.列图标
						if($td.attr("showicon")  && $td.attr("showicon").length  > 0 ){
							var $tdHtml=$(this); 
							var icon =  "<img style='' src='../../lib/icon/" + $td.attr("showicon") + "'/>";
							$tdHtml.find("div[name='result']").html(icon);
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
							var title = $(this).parent().find("td > div").first().text();
							parent.addTab(docid, title, url);
						} 
						else if (e.target && $(e.target).closest("div[name=result]").length > 0 ){
							var title = $(this).parent().find("td > div").first().text();
							parent.addTab(docid, title, url);
						}
						else if (e.target && $(e.target).is("a")){
							url = $(e.target).attr("href");
							$(e.target).attr("href");
							if (url!="" && url!="#") {
								parent.addTab(docid, "...", url);
							}
							return false;
						} 
						else{
							return false;
						}
					});
				}
				
			});

			//超过5条数据时显示更多
			if($table.find("tr").size()>5){
				var $a = $("<div class='bottom-menu text-right'><a class='btn btn-default'>更多»</a></div>").bind("click",function(){
					var url = "../dynaform/view/displayView.action?_viewid="+viewId+"&application="+applicationId;
					parent.addTab(viewId, "...", url);
				}).insertAfter($table.parent());
			}
			if($table.find("tr").size()==1){
				var $null = $("<p class='zhanwei'>当前没有数据<span>。。。</span><img src='../H5/resource/homepage/images/null.png' class='animated'/></p>");
				$null.insertAfter($table);
				$(".zhanwei img").animate({left: '0px'}, "slow");
			}
			var h = $me.attr("_height");
			if (h && h!='') {
				$me.height(h);
			}
			
		},

		_renderLink:function($me) {//渲染内部链接
			$me.closest("div.groupItem").addClass("widget-link");
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
			$me.closest("div.groupItem").addClass("widget-extlink");
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
				_groupItem.find(".itemContent>ul").load(refreshUrl, function(data){
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
						case "workflow":
							me._renderWorkflow($content);
						break;
						case "weather":
							//me._renderWeather($content);
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
			var refreshId = $me.closest("div.groupItem").addClass("widget-announcement").attr("id");
			var $table = $me.find("table");
			
			if($table.find("tr").size()>5){
				var $a = $("<div class='bottom-menu text-right'><a class='btn btn-default'>更多»</a></div>").bind("click",function(){
					var url = contextPath + "/message/message.jsp";
					parent.addTab("message", "消息中心", url);
				}).insertAfter($table);
			}
			if($table.find("tr").size()==1){
				var $null = $("<p class='zhanwei'>当前没有数据<span>。。。</span><img src='../H5/resource/homepage/images/null.png' class='animated'/></p>");
				$null.insertAfter($table);
				$(".zhanwei img").animate({left: '0px'}, "slow");
			}
			
			//打开一个新TAB
			$table.find("tr").not("tr:eq(0)").click(function(){
				var $this = $(this);
				var id = $this.attr("id");
				var title = $this.attr("title");
				var url = $this.attr("_url");
				//$this.find(">span.unread").removeClass("unread");
				parent.addTab("message","消息中心",url);
			}).each(function(i){
				if(i > 4){
					$(this).remove();
				}
			});	
		},
		
		_renderWeather:function($me){//天气预报
			var refreshId = $me.closest("div.groupItem").addClass("widget-weather").attr("id");
			$me.parent().css("padding","0px");
			
			
			var cookieCity = Jh.Util.getCookie("widget-weather-city");
			if(cookieCity == null){
				cookieCity = ""
			}
			
			$me.on("click",".weather-city-change",function(e){
				$("#weather-city-select").toggleClass("weather-city-select-active");
				$("#weather-city-select").citySelect({
					prov:"北京",
					nodata:"none"
				});
			});
			
			$me.on("click","#weather-city-btn",function(e){				
				var cityValue;
				if($("#weather-city-select").find(".dist").is(":hidden")){
					cityValue = $("#weather-city-select").find(".prov").val();
				}else{
					cityValue = $("#weather-city-select").find(".city").val();
				}
				Jh.Util.setCookie("widget-weather-city",cityValue);
				$me.parents("#system_weather").find(".refresh").trigger("click");
			});
			
			
			
			$.getScript('https://yun.weioa365.com/iframe/index/w_cl.php?code=js&day=4&city='+cookieCity+'&dfc=1&charset=utf-8',
				function(a){
					var s="",r="",q="";
					if(window.SWther.w.length > 0){
						for(s in window.SWther.w){
					    	q=SWther.w[s][0];
					        r={
				                city:s,
				                date:SWther.add.now.split(" ")[0]||"",
				                day_weather:q.s1,
				                night_weather:q.s2,
				                day_temp:q.t1,
				                night_temp:q.t2,
				                day_wind:q.p1,
				                night_wind:q.p2
					        }

					        $me.find(".weather-icon-title").text(Jh.Util.date2Week(r.date,0));
					        $me.find(".weather-small").find(".weather-icon-title").html("<span>今天 ● "+Jh.Util.date2Week(r.date,0)+"</span>");
					        $me.find(".weather-city>.weather-city-name").text(r.city);
					        $me.find(".weather-icon-pic>img").attr("src",Jh.Util.weatherIcon(q.f1,q.f2));
					        $me.find(".weather-info-time").text("更新于 "+r.date);
					        
					        if(r.day_temp == r.night_temp){
					        	$me.find(".weather-info-num").text(r.day_temp+"°C");
					        }else{
					        	$me.find(".weather-info-num").text(r.day_temp+"°C~"+r.night_temp+"°C");
					        }
					        				        
					        if(r.day_weather == r.night_weather){
					        	$me.find(".weather-info-weather").text(r.day_weather);
					        }else{
					        	$me.find(".weather-info-weather").text(r.day_weather+"~"+r.night_weather);
					        }
					        
					        if(r.day_wind == r.night_wind){
					        	$me.find(".weather-info-rank").text("风力 "+r.day_wind);
					        }else{
					        	$me.find(".weather-info-rank").text("风力 "+r.day_wind+"~"+r.night_wind);
					        }
					        if($me.width()<=580){
					        	$me.find(".weather-today:eq(0)").hide();
					        	$me.find(".weather-future").hide();
					        	$me.find(".weather-small").addClass("weather-small-show");
					        }else{
					        	$me.find(".weather-small").removeClass("weather-small-show");
					        	$.each(SWther.w[s],function(i){
						        	var weatherFutureTmp = '<div class="weather-future-list">'
										        		+'<div>{wFWeek}</div>'
										        		+'<div><img src="{wFIcon}"></div>'
										        		+'<div>{wFWeather}</div></div>';				    
						        	if(i>0 && i<=3){
						        		var _wFWeek = Jh.Util.date2Week(r.date,i);
						        		var _wFIcon = Jh.Util.weatherIcon(this.f1,this.f2);
						        		if(i==4){
						        			if(this.t1==""){
						        				var _wFWeather = "未知";
						        			}else{
						        				var _wFWeather = this.t1+"°C";
						        			}
						        		}else{
						        			if(this.t1=="" && this.t2==""){
						        				var _wFWeather = "未知";
						        			}else{
						        				if(this.t2==""){
						        					var _wFWeather = this.t1+"°C";
						        				}else{
						        					var _wFWeather = this.t1+"°C~"+this.t2+"°C";
						        				}
						        			}
						        		}
						        		var weatherFuture = Jh.Util.format(weatherFutureTmp , {'wFWeek' : _wFWeek});
						        		weatherFuture = Jh.Util.format(weatherFuture , {'wFIcon' : _wFIcon});
						        		weatherFuture = Jh.Util.format(weatherFuture , {'wFWeather' : _wFWeather});
						        		$me.find(".weather-future").append($(weatherFuture));
						        	}

						        });
					        }
					    }
					}else{
						var errorHtml = '<div style="position: absolute;top: 0;width: 100%;text-align: center;bottom: 0;padding: 10px;">'
								+ '<div style="background: rgba(0, 0, 0, 0.26);border-radius: 3px;height: 100%;color: #fff;">数据发生错误</div></div>';
						$me.append($(errorHtml))
					}
				    
				});
		},
		
		_renderWorkflow:function($me){//流程处理
		//tabWidget : function(){
			var refreshId = $me.closest("div.groupItem").addClass("widget-tab").attr("id");

			var _template = {
					tabPanel : '<div class="itemContent"><div class="swiper-container" role="tabpanel"></div></div>',
					tabUl : '<ul class="nav nav-tabs swiper-wrapper" role="tablist"></ul>',
					tabNav : '<li role="presentation" class="swiper-slide">'
					+'<a href="#pending" aria-controls="pending" role="pending" data-toggle="tab">待办<span class="badge"></span></a>'
					+'</li><li role="presentation" class="swiper-slide">'
					+'<a href="#processing" aria-controls="processing" role="processing" data-toggle="tab">经办<span class="badge"></span></a>'
					+'</li>',
					tabConBox : '<div class="tab-content">'
					+'<div role="tabpanel" class="tab-pane" id="pending">'
					+'<ul style="padding:10px;margin:0px;"></ul><p class="zhanwei" style="display:none">当前没有数据<span>。。。</span><img src="../H5/resource/homepage/images/null.png" class="animated"/></p><div class="bottom-menu text-right"><a class="btn btn-default" _url="pending.jsp" role="button" style="display:none">更多&raquo;</a></div></div>'
					+'<div role="tabpanel" class="tab-pane" id="processing">'
					+'<ul style="padding:10px;margin:0px;"></ul><p class="zhanwei" style="display:none">当前没有数据<span>。。。</span><img src="../H5/resource/homepage/images/null.png" class="animated"/></p><div class="bottom-menu text-right"><a class="btn btn-default" _url="processing.jsp" role="button" style="display:none">更多&raquo;</a></div></div></div>',
					tabLi : '<li class="widgetItem" id="{tabDocID}" _url="{tabUrl}" _isRead ="{tabIsRead}">'
						+ '<div class="tabLiFace">{tabAvatar}'
						+ '<span class="{tabIsReadClass}"></span>'
						+ '</div>'
						+ '<div class="tabLiCon">'
						+ '<div class="tabLiConBox">'
						+ '<div class="tabLiConA text-left">'
						+ '<span class="tabLiCon-text">[{tabName}] {tabCon}</span>'
						+ '</div>'
						+ '<div class="tabLiConB"><div class="tabLiTagLeft">'
						+ '<span class="tabLiCon-auditornames" _initiator="{tabInitiator}" _initiatorId="{tabInitiatorID}" title="{tabDept}{tabInitiator}">{tabDept}{tabInitiator}</span>'
						+ '<span class="tabLiCon-lastprocesstime timeago" title="{tabTime}">{tabTime}</span>'
						+ '</div>'
						+ '<div class="tabLiTagRight text-right">'
						+ '<span class="tabLiCon-status" title="{tabState}">{tabState}</span>'
						+ '</div>'
						+ '</div>'
						+ '</li>'
			};

			$me.append(_template.tabPanel);
			$me.find(".swiper-container").append(_template.tabUl);
			$me.find(".swiper-container").append(_template.tabConBox);
			$me.find(".nav-tabs").append(_template.tabNav);

			var $pendingList = $("input[name='pendingList']");
			var $processedList = $("input[name='processedList']");
			var _pendappId = $pendingList.attr("_appId");
			var _processedappId = $processedList.attr("_appId");
			var $accordionPending = $("<div class='panel-group' id='accordion-pending'></div>");
			var $accordionProcessing = $("<div class='panel-group' id='accordion-processing'></div>");
			$me.append($accordionPending);
			$me.append($accordionProcessing);
			
			$pendingList.each(function(){
				$accordionPending.load($pendingList.attr("_url"), function(response,status) {
					var $accorPend = $("#accordion-pending");
					var pendingLi = "";
					if(status=="success"){
						$accorPend.find("li").each(function(i){
							var $li = $(this);
							var _flowname = $li.attr("_flowname");
							var _url = $li.attr("_url");
							var _tabDocID = $li.attr("_docid");
							var _time = $li.attr("_lastprocesstime");
							var _initiator = $li.attr("_initiator");
							var _initiatorID = $li.attr("_initiatorId");
							var _initiatorDept = $li.attr("_initiatorDept");
							var _isRead = $li.attr("_isRead");

							if( i < 5 ){
								var flowTime = new Date(_time);
								var timeFixArr = _time.split(/[- :]/); 
								var timeFixDate = new Date(timeFixArr[0], timeFixArr[1]-1, timeFixArr[2], timeFixArr[3], timeFixArr[4]);
								var _timeAgo = Common.Util.calculateTime(_time);
								var _avatar;
								var avatar = Common.Util.getAvatar(_initiatorID);
								var Month = timeFixDate.getMonth() + 1; 
								var Day = timeFixDate.getDate(); 
								var Hour = timeFixDate.getHours(); 
								var Minute = timeFixDate.getMinutes(); 
							
								if(avatar!="" && avatar!=undefined){
									_avatar = "<img src ="+avatar+">";
								}else{
									_avatar = "<div class='noAvatar'>"+ _initiator.substr(_initiator.length-2, 2) +"</div>";
								}
								
								var _stateLabel = $li.attr("_stateLabel");
								var $pendingBox = $(".tab-content").find("#pending>ul");
								var tabLi = Jh.Util.format(_template.tabLi , {'tabID' : _flowname});
								tabLi = Jh.Util.format(tabLi , {'tabCon' : $li.text()});
								tabLi = Jh.Util.format(tabLi , {'tabUrl' : _url});
								tabLi = Jh.Util.format(tabLi , {'tabName' : _flowname});
								tabLi = Jh.Util.format(tabLi , {'tabTime' : _timeAgo});
								tabLi = Jh.Util.format(tabLi , {'tabDocID' : _tabDocID});
								tabLi = Jh.Util.format(tabLi , {'tabIsRead' : _isRead});
								if(_isRead == "false"){
									tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : 'noread'});
								}else{
									tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : 'isread'});
								}
								tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : _isRead});
								tabLi = Jh.Util.format(tabLi , {'tabIsReadText' : _isRead});
								tabLi = Jh.Util.format(tabLi , {'tabInitiator' : _initiator});
								tabLi = Jh.Util.format(tabLi , {'tabInitiatorID' : _initiatorID});
								tabLi = Jh.Util.format(tabLi , {'tabAvatar' : _avatar});
								tabLi = Jh.Util.format(tabLi , {'tabDept' : _initiatorDept});
								tabLi = Jh.Util.format(tabLi , {'tabState' : _stateLabel});
								
								pendingLi += tabLi;	
							}else{
								$("#pending").find(".btn").show();
							};
//							$(".nav-tabs").find("a[aria-controls='pending']>.badge").text((i+1)>200?'200+':(i+1));	//设置总数
							$li.remove();
						});
						var rowcount = parseInt($accordionPending.find("#_rowcount").val());
						$(".nav-tabs").find("a[aria-controls='pending']>.badge").text(rowcount+1<1000?rowcount:'999+');	//设置总数
						if(pendingLi == ""){//数据为空，占位符展示
							$("#pending").find(".zhanwei").show();
							$("#pending .zhanwei img").animate({left: '0px'}, "slow");
						}else{
							$("#pending").find(".zhanwei").hide();
						}

						$(".widget-tab").find("#pending>ul").css("padding","0px").append(pendingLi);
						
						$(".widget-tab").find("#pending li.widgetItem").unbind().bind("click",function(){
							var $this = $(this);
							$this.find("span.noread").removeClass("noread");
							var id = $this.attr("id");
							var title = $this.find("span.tabLiCon-text").text();
							var url = $this.attr("_url");
							if(typeof(parent.addTab) == "function"){
								parent.addTab(id,title,url);
							}else{
								window.open(url);
							}
						});
						$(".widget-tab").find("#pending>.bottom-menu>a").click(function(){
							var $this = $(this);
							var id = "pending";
							var title = "待办";
							var url = $this.attr("_url");
							if(typeof(parent.addTab) == "function"){
								parent.addTab(id,title,url);
							}else{
								window.open(url);
							}
						});
					}
					if(status=="error"){
						
					}
					$accordionPending.remove();
				});
			});
			
			$processedList.each(function(){
				$accordionProcessing.load($processedList.attr("_url"), function(response,status) {
					var $accorProcess = $("#accordion-processing");
					var processingLi = "";
					if(status=="success"){
						$accorProcess.find("li").each(function(i){
							var $li = $(this);
							var _flowname = $li.attr("_flowname");
							var _url = $li.attr("_url");
							var _tabDocID = $li.attr("_docid");
							var _time = $li.attr("_lastprocesstime");
							var _initiator = $li.attr("_initiator");
							var _initiatorID = $li.attr("_initiatorId");
							var _initiatorDept = $li.attr("_initiatorDept");
							var _isRead = $li.attr("_isRead");

							if( i < 5 ){
								var flowTime = new Date(_time);
								var timeFixArr = _time.split(/[- :]/); 
								var timeFixDate = new Date(timeFixArr[0], timeFixArr[1]-1, timeFixArr[2], timeFixArr[3], timeFixArr[4]);
								var _timeAgo = Common.Util.calculateTime(_time);
								var _avatar;
								var avatar = Common.Util.getAvatar(_initiatorID);
								var Month = timeFixDate.getMonth() + 1; 
								var Day = timeFixDate.getDate(); 
								var Hour = timeFixDate.getHours(); 
								var Minute = timeFixDate.getMinutes(); 
							
								if(avatar!="" && avatar!=undefined){
									_avatar = "<img src ="+avatar+">";
								}else{
									_avatar = "<div class='noAvatar'>"+ _initiator.substr(_initiator.length-2, 2) +"</div>";
								}
								
								var _stateLabel = $li.attr("_stateLabel");
								var $pendingBox = $(".tab-content").find("#processing>ul");
								var tabLi = Jh.Util.format(_template.tabLi , {'tabID' : _flowname});
								tabLi = Jh.Util.format(tabLi , {'tabCon' : $li.text()});
								tabLi = Jh.Util.format(tabLi , {'tabUrl' : _url});
								tabLi = Jh.Util.format(tabLi , {'tabName' : _flowname});
								tabLi = Jh.Util.format(tabLi , {'tabTime' : _timeAgo});
								tabLi = Jh.Util.format(tabLi , {'tabDocID' : _tabDocID});
								tabLi = Jh.Util.format(tabLi , {'tabIsRead' : _isRead});
								if(_isRead == "false"){
									tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : 'noread'});
								}else{
									tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : 'isread'});
								}
								tabLi = Jh.Util.format(tabLi , {'tabIsReadClass' : _isRead});
								tabLi = Jh.Util.format(tabLi , {'tabIsReadText' : _isRead});
								tabLi = Jh.Util.format(tabLi , {'tabInitiator' : _initiator});
								tabLi = Jh.Util.format(tabLi , {'tabInitiatorID' : _initiatorID});
								tabLi = Jh.Util.format(tabLi , {'tabAvatar' : _avatar});
								tabLi = Jh.Util.format(tabLi , {'tabDept' : _initiatorDept});
								tabLi = Jh.Util.format(tabLi , {'tabState' : _stateLabel});
								
								processingLi += tabLi;	
							}else{
								$("#processing").find(".btn").show();
							};
							
//							$(".nav-tabs").find("a[aria-controls='processing']>.badge").text((i+1)>200?'200+':(i+1));	//设置总数
							$li.remove();
						});
						var rowcount = parseInt($accorProcess.find("#_rowcount").val());
						$(".nav-tabs").find("a[aria-controls='processing']>.badge").text(rowcount+1<1000?rowcount:'999+');
						if(processingLi == ""){//数据为空，占位符展示
							$("#processing").find(".zhanwei").show();
							$("#processing .zhanwei img").animate({left: '0px'}, "slow");
						}else{
							$("#processing").find(".zhanwei").hide();
						}
						
						$(".widget-tab").find("#processing>ul").css("padding","0px").append(processingLi)
						
						$(".widget-tab").find("#processing li.widgetItem").unbind().bind("click",function(){
							var $this = $(this);
							var id = $this.attr("id");
							var title = $this.find("span.tabLiCon-text").text();
							var url = $this.attr("_url");
							if(typeof(parent.addTab) == "function"){
								parent.addTab(id,title,url);
							}else{
								window.open(url);
							}
						});
						$(".widget-tab").find("#processing>.bottom-menu>a").click(function(){
							var $this = $(this);
							var id = "processing";
							var title = "经办";
							var url = $this.attr("_url");
							if(typeof(parent.addTab) == "function"){
								parent.addTab(id,title,url);
							}else{
								window.open(url);
							}
						});
					}
					if(status=="error"){
						
					}
					$accordionProcessing.remove();
				});
			});
			$me.find("li.swiper-slide:eq(0)").addClass("active");
			$me.find("div.tab-pane:eq(0)").addClass("active");
		},
		
		_eventSortable:function(){//绑定排序
			$("."+Jh.Config._groupWrapperClass).sortable({
				connectWith: "."+Jh.Config._groupWrapperClass,								
				opacity :"0.6",	
				dropOnEmpty:true,
				change:function(){$("#header>table").show();},//显示隐藏的工具面板
				stop: function(event, ui) {
					var id = $(ui.item).attr("id");
					if(id == "system_weather"){
						$(ui.item).find("."+Jh.Config.refresh).trigger("click");
					}
				}
			}).disableSelection();	

			$(".icon_p").sortable({
				connectWith: ".icon_p",								
				opacity :"0.6",	
				dropOnEmpty:true,
				change:function(){$("#header>table").show();}//显示隐藏的工具面板
			}).disableSelection();	
		},
		
		_eventHover:function(){//绑定Hover,实现激活的动画效果
			$("."+Jh.Config._groupItemClass).hover(
				function(){
					var $this = $(this);
					if ($this.prev().size()>0) {
						//$(this).css("margin-bottom","22px").prev().css("margin-bottom","18px");
					} 
					else {
						//$(this).css("margin-top","3px").css("margin-bottom","22px");
					}
					$this.find(">."+Jh.Config._groupItemContent).css("background-color","#fff");
				},
				function(){
					var $this = $(this);
					if ($this.prev().size()>0) {
						//$(this).css("margin-bottom","15px").prev().css("margin-bottom","15px");
					} 
					else {
						//$(this).css("margin-top","5px").css("margin-bottom","15px");
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