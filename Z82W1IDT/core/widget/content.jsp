<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%
	String appid =(String)request.getParameter("application");
%>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>

<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<!-- <link rel="stylesheet" href="<s:url value='/core/fonts/awesome/font-awesome.min.css'/>" type="text/css" />-->
<link rel="stylesheet" href="<s:url value='/core/fonts/custom/widget_icon_lib.css'/>" type="text/css" />
<style type="text/css">
.widgetTypeTip {
	color: green;
}
</style>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script type='text/javascript' src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/CrossReportHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/RunQianReportHelper.js"/>'></script>

<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>

<!-- 颜色选择取插件 -->
<link rel="stylesheet" type="text/css" href="<s:url value='/script/bgrins-spectrum/spectrum.css'/>">
<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/spectrum.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/i18n/jquery.spectrum-zh-cn.js'/>"></script>

<script>
	var contextPath = '<%=request.getContextPath()%>';
	var applicationId =  "<%=appid%>";
	
	var orginImgVal;   //原图片数据
	var orginFontVal;  //原图表数据
	
	function onTypeChange(type){
		var omodule_tr = document.getElementById('omodule_tr');
		var oview_tr = document.getElementById('oview_tr');
		var oreport_tr = document.getElementById('oreport_tr');
		var page_tr = document.getElementById('page_tr');
		var link_tr = document.getElementById('link_tr');
		var iconShow_tr = document.getElementById('iconShow_tr');
		var osummary_tr = document.getElementById('osummary_tr');
		var owidth_tr = document.getElementById('owidth_tr');
		var oheight_tr = document.getElementById('oheight_tr');
		var runqianreport_tr = document.getElementById('runqianreport_tr');
		var customizeReport_tr = document.getElementById('customizeReport_tr');
		var workflow_analyzer_type_tr = document.getElementById('workflow_analyzer_type_tr');
		var workflow_analyzer_dateRange_tr = document.getElementById('workflow_analyzer_dateRange_tr');
		var iscript_tr = document.getElementById('iscript_tr');
		
		
		omodule_tr.style.display='none';
		oview_tr.style.display='none';
		oreport_tr.style.display='none';
		page_tr.style.display='none';
		link_tr.style.display='none';
		iconShow_tr.style.display='none';
		osummary_tr.style.display='none';
		owidth_tr.style.display='none';
		oheight_tr.style.display='none';
		runqianreport_tr.style.display='none';
		customizeReport_tr.style.display='none';
		workflow_analyzer_type_tr.style.display='none';
		workflow_analyzer_dateRange_tr.style.display='none';
		iscript_tr.style.display='none';
		
		//视图类型只支持网页端
		jQuery("input[name='content.widgetType']").show().next().show();
		jQuery("#widgetTypeTip").hide();
	
		var def =  document.getElementById("actionContent").value;
		
		
		switch (type){
		case 'summary':
			osummary_tr.style.display='inline';
			jQuery("#iconShow_tr input").attr("checked",false);
			break;
		case 'page':
			page_tr.style.display='inline';
			oheight_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			iconShowChange();	//根据图片形式显示值切换显示内容
			break;
		case 'link':
			link_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			//oheight_tr.style.display='inline';
			changeSupportType();	//快速入口只支持网页端
			break;
		case 'view':
			oview_tr.style.display='inline';
			omodule_tr.style.display='inline';
			//oheight_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			createViewOptionByModule('actionView');
			jQuery("#height").val("");
			break;
		case 'report':
			oreport_tr.style.display='inline';
			omodule_tr.style.display='inline';
			//oheight_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			break;
		case 'runquanReport':
			runqianreport_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			omodule_tr.style.display='inline';
			oview_tr.style.display='inline';
			//oheight_tr.style.display='inline';
			createViewOptionByModule('actionView');
			createRunqianReportFiles('actionRunqianReport');
			break;
		case 'customizeReport':
			customizeReport_tr.style.display='inline';
			iconShow_tr.style.display='inline';
			CrossReportHelper.createCustomizeReportOptions('customizeReport','<s:property value="#parameters.application"/>',def,function(str) {var func=eval(str);func.call();});
			break;
		case 'workflow_analyzer':
			workflow_analyzer_type_tr.style.display='inline';
			jQuery("#iconShow_tr input").attr("checked",false);
			//workflow_analyzer_dateRange_tr.style.display='inline';
			break;
		case 'iscript':
			iscript_tr.style.display='inline';
			oheight_tr.style.display='inline';
			jQuery("#iconShow_tr input").attr("checked",false);
			break;
		}
	}
	
	function onModuleChange(){
		var type = document.getElementById("_type").value;
		switch (type){
		case 'view':
			createViewOptionByModule('actionView');
			break;
		case 'report':
			createReportOptionByModule('actionReport');
			break;
		case 'runquanReport':
			runqianreport_tr.style.display='inline';
			createViewOptionByModule('actionView');
			createRunqianReportFiles('actionRunqianReport');
			break;
		}
		
	}
	
	function createViewOptionByModule(view){
		var moduleid = document.getElementById("module").value;
		var def =  document.getElementById("actionContent").value;
	
		if (moduleid=='') {
			moduleid = '<s:property value="content.moduleid"/>';
		}
		ApplicationUtil.creatView(view,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call()});
		
	}
	function createReportOptionByModule(report){
		var moduleid = document.getElementById("module").value;
		var def =  document.getElementById("actionContent").value;
		if (moduleid=='') {
			moduleid = '<s:property value="content.moduleid"/>';
		}
		
		CrossReportHelper.creatReport(report,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call()});
		
	}
	//获取润乾报表模板
	function createRunqianReportFiles(report){
		var def =  document.getElementById("actionContent").value;
		var _type = document.getElementById("_type").value;
		if(_type=='runquanReport'){//当为润乾报表类型时，切割字段润乾报表模板文件回选
			def = def.substring(0,def.indexOf("_viewid")-1);
		}
		RunQianReportHelper.getReportFiles(report,def,function(str) {
			var func=eval(str);
			func.call();});
		
	}
	
	function addOptions(relatedFieldId, options, defValues){
		var el = document.getElementById(relatedFieldId);
		if(relatedFieldId){
			DWRUtil.removeAllOptions(relatedFieldId);
			DWRUtil.addOptions(relatedFieldId, options);
		}
		if (defValues) {
			DWRUtil.setValue(relatedFieldId, defValues);
		}
	}
	function buildActionContent(){
		var type = document.getElementById("_type").value;
		switch (type){
		case 'page':
			document.getElementById("actionContent").value = document.getElementById("actionUrl").value;
			break;
		case 'link':
			document.getElementById("actionContent").value = document.getElementById("linkContent").value;
			break;
		case 'view':
			document.getElementById("actionContent").value = document.getElementById("actionView").value;
			break;
		case 'report':
			document.getElementById("actionContent").value = document.getElementById("actionReport").value;
			break;
		case 'runquanReport':
			var viewid = document.getElementById("actionView").value;
			var actionRunqianReport = document.getElementById("actionRunqianReport").value;
			if(viewid==null || viewid =="" || viewid =="none"){
				alert("请选择视图作为润乾报表数据来源");
				return false;
			}else if(actionRunqianReport==null || actionRunqianReport =="" || actionRunqianReport =="none"){
				alert("请选择润乾报表模板文件");
				return false;
			}
			document.getElementById("actionContent").value = actionRunqianReport+"&_viewid="+viewid;
			break;
		case 'customizeReport':
			document.getElementById("actionContent").value = document.getElementById("customizeReport").value;
			break;
		case 'workflow_analyzer':
			/**
			var workflow_analyzer_setting = {};
			workflow_analyzer_setting.type = jQuery("input[name='workflow_analyzer_type']:checked").val();
			workflow_analyzer_setting.dateRange = jQuery("input[name='workflow_analyzer_dateRange']:checked").val();
			document.getElementById("actionContent").value = JSON.stringify(workflow_analyzer_setting);
			**/
			document.getElementById("actionContent").value = jQuery("input[name='workflow_analyzer_type']:checked").val();
			break;
		case 'iscript':
			document.getElementById("actionContent").value = document.getElementById("iscript").value;
			break;
		}
	}

	
	
	function ev_load(){
		var type = document.getElementById("_type").value;
		var content = document.getElementById("actionContent").value;
		switch (type){
			case 'page':
				document.getElementById("actionUrl").value = content;
				break;
			case 'link':
				document.getElementById("linkContent").value = content;
				break;
			case 'summary':
				document.getElementById("actionSummary").value = '<s:property value="summaryName"/>';
				break;
			case 'workflow_analyzer':
				/**
				if(content && content.indexOf('dateRange')>=0){
					var workflow_analyzer_setting = JSON.parse(content);
					jQuery("input[name=workflow_analyzer_type][value="+workflow_analyzer_setting.type+"]").attr("checked",true);
					jQuery("input[name=workflow_analyzer_dateRange][value="+workflow_analyzer_setting.dateRange+"]").attr("checked",true);
				}
				**/
				jQuery("input[name=workflow_analyzer_type][value="+content+"]").attr("checked",true);
				break;
			case 'iscript':
				document.getElementById("iscript").value = content;
				break;
				
		}
		onTypeChange(type);
		onModuleChange();
		
	}
	
	jQuery(document).ready(function(){
		var isExit = '<s:property value="_isExit" />';
		if(isExit == 'yes'){
			//var rtn = '<s:property value="content.id" />'+'\''+'<s:property value="content.name"/>';
			OBPM.dialog.doReturn('success');
		}
		iconShowChange();
		ev_load();
		var icon = document.getElementsByName("content.icon")[0].value;
		var iconJson = setValueJson(icon);
		if(iconJson.icontype == "font"){
			jQuery(".oicon_font>i").addClass(iconJson.icon);
			if(iconJson.iconFontColor && iconJson.iconFontColor!=""){
				jQuery(".oicon_font>i").css("color",iconJson.iconFontColor);
			}
			initIconType("font");
		}else if(iconJson.icontype == "img"){
			jQuery("img[name=_iconImg]").attr("src",(contextPath + iconJson.icon));
			initIconType("img");
		}else{ //新建初始化默认数据
			initIconType("init");
			jQuery("#widget_content_orderno").val(0);
		}
		//选取图片绑定事件
		jQuery("#browseServer").bind("click",function(){
			var url = contextPath+ '/core/resource/iconLib.jsp';
			OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '选取图标',
				close: function(rtn) {
					if(rtn){
						document.getElementsByName("content.icon")[0].value = "{\"icon\":\"/uploads/lib/icon/"+rtn+"\",\"icontype\":\"img\"}"
						jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + '/uploads/lib/icon/' + rtn));
					}
				}
			});
		});
		
		//选取字体图标绑定事件
		jQuery("#browseFontServer").bind("click",function(){
			var url = contextPath+ '/core/resource/iconFontLib.jsp';
			OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '选取字体图标',
				close: function(rtn) {
					if(rtn != "" && rtn){	
						var iconVal = jQuery("#widget_content_icon").val();
						var iconJson = setValueJson(iconVal);
						iconJson.icon = rtn;
						jQuery("#widget_content_icon").val(JSON.stringify(iconJson));
						jQuery(".oicon_font>i").removeClass().addClass(rtn);
					}
				}
			});
		});
		
		//初始化颜色选择器--标题
		jQuery("#otitleColor_tr input").spectrum({
			showPalette:true,
			hideAfterPaletteSelect:true,
			showInput: true,
			showInitial: true,
			allowEmpty: true,
			showPalette: true,
			showSelectionPalette: true,
			clickoutFiresChange: true,
			preferredFormat: "hex3",
			palette: [
				["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
				["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
				["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
				["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
				["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
				["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
				["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
				["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
			],
			change: function(color) {
				if(color){
					color = color.toHexString();
				}else{
					color = "";
				}
				jQuery("#widget_content_titleColor").val(color);
			}
		});

		//初始化颜色选择器--标题背景
		jQuery("#otitleBColor_tr input").spectrum({
			showPalette:true,
			hideAfterPaletteSelect:true,
			showInput: true,
			showInitial: true,
			allowEmpty: true,
			showPalette: true,
			showSelectionPalette: true,
			clickoutFiresChange: true,
			preferredFormat: "hex3",
			palette: [
				["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
				["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
				["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
				["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
				["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
				["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
				["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
				["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
			],
			change: function(color) {
				if(color){
					color = color.toHexString();
				}else{
					color = "";
				}
				jQuery("#widget_content_titleBColor").val(color);
			}
		});
		
		//初始化颜色选择器--字体图标
		jQuery("#oicon_tr .oicon_font_color input").spectrum({
			showPalette:true,
			hideAfterPaletteSelect:true,
			showInput: true,
			showInitial: true,
			allowEmpty: true,
			showPalette: true,
			showSelectionPalette: true,
			clickoutFiresChange: true,
			preferredFormat: "hex3",
			palette: [
				["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
				["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
				["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
				["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
				["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
				["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
				["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
				["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
			],
			change: function(color) {
				if(color){
					color = color.toHexString();
				}else{
					color = "";
				}
				var iconVal = jQuery("#widget_content_icon").val();
				var iconJson = setValueJson(iconVal);
				iconJson.iconFontColor = color;
				jQuery("#widget_content_icon").val(JSON.stringify(iconJson));				
				jQuery("#oicon_tr .oicon_font").find("i").css("color",color);				
				jQuery("#widget_content_iconFontColor").val(color);
			}
		});
		
		jQuery("#iconShow_tr input").bind("click",function(){
			iconShowChange();	//根据图片形式显示值切换显示内容
		});
		
		jQuery("#oicontype_tr input").on("click",function(){
			var typeVal = jQuery(this).val();
			iconTypeChange(typeVal);
			
		});
	});
	
	//初始化图标类型
	function initIconType(typeVal){
		var iconVal = jQuery("#widget_content_icon").val();
		if(typeVal == "font"){
			
			//初始化图标
		    var img = "/uploads/lib/icon/16x16_0020/application.png";
		    document.getElementsByName("content.icon")[0].value = img;
			jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + img));
			
			var iconJson = new Object();
			iconJson.icon = img;
			iconJson.icontype ="img";
			
		    orginImgVal = JSON.stringify(iconJson);   //原图片数据
		    orginFontVal = iconVal ;  //原文字数据
		    
		    jQuery("#widget_content_icon").val(orginImgVal);
		    
		    iconTypeChange("font")
		    
		}else if(typeVal == "img"){
			
			 //初始化文字
			 var icon = "if-lib icon-xinwenxinxi";
		     var iconJson = new Object();
		     iconJson.icon = icon;
		     iconJson.icontype ="font";
		     iconJson.iconFontColor="#000";
		     document.getElementsByName("iconFontColor")[0].value ="#000";
			 orginImgVal = iconVal;   //原图片数据
			 orginFontVal = JSON.stringify(iconJson); //原文字数据
			 
			 jQuery("#widget_content_icon").val(orginFontVal);
			 
			 iconTypeChange("img")
		}else{
			 //初始化文字
		     var icon = "if-lib icon-xinwenxinxi";
		     var iconJson = new Object();
		     iconJson.icon = icon;
		     iconJson.icontype ="font";
		     iconJson.iconFontColor="#000";
		     orginFontVal = JSON.stringify(iconJson);   //原文字数据
		  
		    
		     //初始化图标
	         var img = "/uploads/lib/icon/16x16_0020/application.png";
	         document.getElementsByName("content.icon")[0].value = img;
		     jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + img));
		     var _iconJson = new Object();
		     _iconJson.icon =  img;
		     _iconJson.icontype ="img";
			
		     orginImgVal = JSON.stringify(_iconJson);   //原图片数据
		     jQuery("#widget_content_icon").val(orginImgVal);
		     
		      iconTypeChange("font")
			
		     //设置颜色
		     document.getElementsByName("iconFontColor")[0].value ="#000";
		     document.getElementsByName("content.titleColor")[0].value ="#000";
		}
	}
	
	//图标类型
	function iconTypeChange(typeVal){
		jQuery("#oicon_tr td>div").hide();
		jQuery("#oicon_tr").find(".oicon_"+typeVal).show();
		jQuery("#oicontype_tr").find("input[value='"+typeVal+"']").attr("checked",'2');
		var iconVal = jQuery("#widget_content_icon").val();
		var iconJson = setValueJson(iconVal);
		
		if(typeVal == "font"){
			var fontVal = setValueJson(orginFontVal);
			jQuery("#widget_content_icon").val(orginFontVal);
			jQuery(".oicon_font>i").removeClass().addClass(fontVal.icon);
			document.getElementsByName("iconFontColor")[0].value = fontVal.iconFontColor;
			orginImgVal = JSON.stringify(iconJson);
		}else {
		    jQuery("#widget_content_icon").val(orginImgVal);
		    orginFontVal = JSON.stringify(iconJson);
		}
		
	}
	
	//判断旧数据 利用json2.js将字符串转对象
	function setValueJson(val){
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
	}
	
	//改变支持类型的值，视图类型只支持网页端
	function changeSupportType(){
		jQuery("input[name='content.widgetType'][value=1]").prop("checked",true);
		jQuery("input[name='content.widgetType'][value=0],input[name='content.widgetType'][value=2]").hide().next().hide();
		jQuery("#widgetTypeTip").show();
	}
	
	//根据图片形式显示值切换显示内容
	function iconShowChange(){
		var type = document.getElementById("_type").value;
		var $iconShow = jQuery("#iconShow_tr input");
		if($iconShow.attr("checked") == "checked"){
			jQuery("#oheight_tr").hide();
		}else {
			if(type == "page" || type == "iscript"){
				jQuery("#oheight_tr").show();
			}
		}
	}
	
	function ev_save() {
		buildActionContent();
		if(document.getElementsByName("content.name")[0].value.length<=0){
			alert("请输入名称！");
			return false;
		}
		if(document.getElementsByName("content.height")[0].value.length>0 && isNaN(document.getElementsByName("content.height")[0].value)){ 
			   alert('高度必须是数字！');
			   return false; 
		}
		if(jQuery("input[name='content.orderno']")[0].value.trim().length<=0 || isNaN(jQuery("input[name='content.orderno']")[0].value)){ 
			   alert('排序号不能为空且必须是数字！');
			   return false; 
		}
		if(document.getElementsByName("content.actionContent")[0].value.length<=0){
			alert("请配置内容！");
			return false;
		}
		
	
		document.forms[0].action = '<s:url action="save_exit" namespace="/core/widget" />';
		document.forms[0].submit();
	}
	
	function ev_selectSummary() {
		var url = contextPath+ "/core/dynaform/summary/list.action?application=" + applicationId+"&n_scope=0|6";
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {},
			title: '{*[Add]*}{*[Summary]*}',
			close: function(rtn) {
				if(rtn == null || rtn == ""){
					//alert("未选择元素，返回值为空值");
				}else{
					var rtns = rtn.split("'");
					document.getElementById("actionSummary").value=rtns[1];
					document.getElementsByName("content.actionContent")[0].value=rtns[0];
				}
			}
		});
	}
	
	//切换角色
	function doChangeRoles(Obj){
		if(Obj.value == 0){
			jQuery("#contentDisplay").css("display","none");
		}else{
			jQuery("#contentDisplay").css("display","block");
		}
	}
	
	//选择角色
	function selectRole() {
		var roles = document.getElementById("content.authRolesId").value;
		var path = "<%=request.getContextPath()%>";
		var url = path+'/core/role/linkRole.action?application='+applicationId+'&tempRoles='+roles;
		OBPM.dialog.show({
					opener:window.parent,
					width: 800,
					height: 500,
					url: url,
					args: {"tempRoles":roles},
					title: '{*[cn.myapps.core.user.select_role]*}',
					close: function(rtn) {
						//window.top.toThisHelpPage("application_info_generalTools_homePage_info");
						if (rtn){
							if (rtn == 'clear') {
								document.getElementById("content.authRolesId").value = "";
								document.getElementById("content.authRolesName").value = "";
							}else{
								document.getElementById("content.authRolesId").value = rtn;
								RoleUtil.findRoleNames(rtn, insertName);
							}
						}
					}
			});
	}
	//清除角色
	function clearRole(){
		document.getElementById("content.authRolesId").value = "";
		document.getElementById("content.authRolesName").value = "";
	}
	function insertName(data) {
		document.getElementById("content.authRolesName").value = data;
	}
</script>
</head>
<body class="contentBody">
<div class="ui-layout-center" id="div_content">
<s:form name="widget" id="widget" action="" method="post" theme="simple">
<div id="contentActDiv">
	<table class="table_noborder">
			<tr>
			<td>
				<div class="actbtndiv">
					<button type="button" id="exit_btn" class="justForHelp button-image" onclick="ev_save();" /><img src="<s:url value='/resource/imgnew/add.gif'/>">{*[cn.myapps.core.widget.btn.lable.ok]*}</button>
					<button type="button" id="exit_btn" class="justForHelp button-image" onclick="OBPM.dialog.doReturn();" /><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[cn.myapps.core.widget.btn.lable.exit]*}</button>
				</div>
			</td></tr>
	</table>
</div>
<div id="contentMainDiv" class="contentMainDiv">
	<table class="table_noborder id1" width="98%">
		<s:textfield cssStyle="display:none;" name="tab" value="1" />
		<s:textfield cssStyle="display:none;" name="selected"
			value="%{'btnLinks'}" />
		<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
			id="mh">
			<s:param name="application" value="%{#parameters.application}" />
		</s:bean>	
		<s:hidden name="content.id" />
		<s:hidden id="actionContent" name="content.actionContent" />
		<s:hidden name="content.applicationid" value="%{#parameters.application}" />
		<s:hidden name="application" id="applicationid" value="%{#parameters.application}" />
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Name]*}：</span><br>
			<s:textfield cssClass="input-cmd" theme="simple" name="content.name" cssStyle="width:350px;"/></td>
		</tr>
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Type]*}：</span><br>
			<s:select cssStyle="width:350px;" cssClass="input-cmd"
					onchange="onTypeChange(this.value)"
					name="content.type" id="_type"
					list="#{'':'{*[Select]*}','summary':'{*[Summary]*}','view':'{*[View]*}','link':'{*[cn.myapps.core.widget.type.link]*}','page':'{*[cn.myapps.core.widget.type.page]*}','customizeReport':'{*[cn.myapps.core.resource.customize_report]*}','report':'{*[cn.myapps.core.dynaform.links.report]*}','runquanReport':'{*[cn.myapps.core.dynaform.links.raq_report]*}','workflow_analyzer':'{*[cn.myapps.core.widget.type.workflow_analyzer]*}','iscript':'{*[cn.myapps.core.widget.type.iscript]*}'}"
					required="true" theme="simple" /></td>
		</tr>
		
		<tr id="osummary_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Summary]*}：</span><br>
			<s:textfield id="actionSummary" cssStyle="width:230px;" name="actionSummary" value="" /> <input type="button" id="btn_selectSummary" value="{*[Choose]*}" onclick="ev_selectSummary();"  /></td>
		</tr>
		
		<tr id="omodule_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Module]*}：</span>
				<BR/><s:select cssStyle="width:350px;" id="module" name="content.moduleid" list="#mh.getModuleSel(#parameters.application)"
				cssClass="input-cmd" onchange="onModuleChange();" /></td>
		</tr>

		<tr id="oview_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionView]*}：</span><br>
			<s:select id="actionView" cssStyle="width:350px;" emptyOption="true" name="actionView" list="{}" /></td>
		</tr>
		
		<tr id="oreport_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionReport]*}：</span><br>
			<s:select id="actionReport" cssStyle="width:350px;" emptyOption="true" name="actionReport" list="{}" /></td>
		</tr>
		
		<tr id="customizeReport_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionReport]*}：</span><br>
			<s:select id="customizeReport" cssStyle="width:350px;" emptyOption="true" name="customizeReport" list="{}" /></td>
		</tr>
		
		<tr id="runqianreport_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.raq_report_module_file]*}：</span><br>
						<s:select id="actionRunqianReport" 
							emptyOption="true" name="actionRunqianReport" list="{}" /></td>
		</tr>
		
		<tr id="page_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.page_addr]*}</span><br>
			<s:textarea id="actionUrl" cssClass="input-cmd" cssStyle="width:350px;" name="actionUrl" cols="50" rows="3" />
			</td>
		</tr>
		<tr id="link_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.link_content]*}</span><br>
			<s:textarea id="linkContent" cssClass="input-cmd" cssStyle="width:350px;" name="linkContent" cols="50" rows="3" placeholder="<a href='aa.jsp'>AAA</a> <a href='bb.jsp'>BBB</a>" />
			</td>
		</tr>
		<tr id="iconShow_tr">
			<td align="left">
				<s:checkbox id="content.iconShow" name="content.iconShow" ></s:checkbox>
				<span class="commFont commLabel">图标形式显示</span>
			</td>
		</tr>
		<tr id="workflow_analyzer_type_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.workflow_analyzer_type]*}</span><br>
			<s:radio id="workflow_analyzer_type" name="workflow_analyzer_type" list="#{'analyzerActorTimeConsumingTopX':'{*[cn.myapps.core.widget.workflow_analyzer.type.analyzer_actor_time_consuming_topx]*}','flowTimeConsumingAccounting':'{*[cn.myapps.core.widget.workflow_analyzer.type.flowtime_consuming_accounting]*}','flowAndNodeTimeConsuming':'{*[cn.myapps.core.widget.workflow_analyzer.type.flow_and_node_time_consuming]*}','flowAccounting':'{*[cn.myapps.core.widget.workflow_analyzer.type.flow_accounting]*}'}"></s:radio>
			</td>
		</tr>
		<tr id="workflow_analyzer_dateRange_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.workflow_analyzer_date_range]*}：</span><br>
			<s:radio id="workflow_analyzer_dateRange" name="workflow_analyzer_dateRange" list="#{'today':'今天','thisweek':'本周','thismonth':'本月','thisyear':'本年'}"></s:radio>
			</td>
		</tr>
		<tr id="iscript_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.iscript]*} <button type="button" class="button-image" onclick="openIscriptEditor('iscript','{*[Script]*}{*[Editor]*}','Iscript','content.name','{*[Save]*}{*[Success]*}');"><img src="<s:url value='/resource/image/editor.png' />"/></button></span><br>
			<s:textarea placeholder="脚本返回HTML语法格式的字符串" id="iscript" cssClass="input-cmd" cssStyle="width:350px;" name="iscript" cols="50" rows="3" />
			</td>
		</tr>
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.order_number]*}：</span><br>
			<s:textfield cssClass="input-cmd" theme="simple" name="content.orderno" cssStyle="width:350px;"/></td>
		</tr>
		<tr id="1oheight_tr" >
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.widget.lable.auth_mode]*}：</span><br>
			<s:radio name="content.authMode"  onclick="doChangeRoles(this)" list="#{'0':'{*[cn.myapps.core.widget.attr.authMode.all_roles]*}', '1':'{*[cn.myapps.core.widget.attr.authMode.same_roles]*}'}" theme="simple"/>
				<s:if test="content.authMode == 0">
				<div id="contentDisplay" style="display:none;">
				</s:if>
				<s:else>
				<div id="contentDisplay" style="display:block;">
				</s:else>
					<s:textfield cssClass="input-cmd" id="content.authRolesName" readonly="true" name="content.authRolesName"/>
					<s:hidden id="content.authRolesId" name="content.authRolesId"/>
					<button type="button" class="button-image" style="color: #1E50C4" onclick="selectRole()">{*[Choose]*}</button>
					<button type="button" class="button-image" style="color: #1E50C4" onclick="clearRole()">{*[Clear]*}</button>
				</div>
			</td>
		</tr>
		<tr id="widgetType_tr" >
			<td align="left" ><span class="commFont commLabel">支持类型：</span><br>
						<s:radio name="content.widgetType" theme="simple" 
						list="#{'0':'{*[cn.myapps.core.widget.general_widget]*}','1':'{*[cn.myapps.core.widget.webpage_widget]*}','2':'{*[cn.myapps.core.widget.mobile_widget]*}'}"
						value="%{content.widgetType}" />
						<span id="widgetTypeTip" class="widgetTypeTip">(此类型暂时只支持网页端)</span>
			</td>
		</tr>
		<tr id="22oheight_tr" >
			<td align="left" ><span class="commFont commLabel">{*[cn.myapps.core.user.label.publish_or_not]*}：</span><br>
						<s:radio name="content.published" theme="simple" list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.user.no]*}'}" 
						value="%{content.published + ''}" />
			</td>
		</tr>
		<tr id="owidth_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Width]*}：</span><br>
			<s:textfield id="width" cssClass="input-cmd" cssStyle="width:350px;" name="content.width" />
			</td>
		</tr>
		<tr id="oheight_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Height]*}：</span><br>
			<s:textfield id="height" cssClass="input-cmd" cssStyle="width:100px;" name="content.height" />&nbsp;px
			</td>
		</tr>
		<tr id="oicontype_tr">
			<td align="left" >
				<span class="commFont commLabel">图标类型：</span><br>
				<s:radio name="icontype" theme="simple" list="#{'img':'图片','font':'字体图标'}" value="%{content.icontype + ''}" />
			</td>
		</tr>
		<tr id="oicon_tr">
			<td align="left"><span class="commFont commLabel">图标：</span><br>
				<s:hidden name="content.icon" />
				<div class="oicon_img">
					<img src="" border="0" name="_iconImg" />
					<input type="button" value="选取" id="browseServer"/>
				</div>
				<div class="oicon_font">
					<i class="" style="font-size: 24px;"></i>
					<input type="button" value="选取" id="browseFontServer"/>
					<span class="oicon_font_color"><s:textfield name="iconFontColor" /></span>
				</div>
			</td>
		</tr>		
		<tr id="otitleColor_tr">
			<td align="left"><span class="commFont commLabel">标题颜色：</span><br>
				<s:textfield name="content.titleColor"  />
			</td>
		</tr>
		<tr id="otitleBColor_tr">
			<td align="left"><span class="commFont commLabel">标题背景颜色：</span><br>
				<s:textfield name="content.titleBColor" />
			</td>
		</tr>
		
<%-- 		<tr >
			<td align="left"><span class="commFont commLabel">{*[Parameter]*}：</span><br>
			<table class="table_hasborder" border=1 cellpadding="0" cellspacing="0" bordercolor="gray" >
				<tbody id="tb">
					<tr>
						<tr>
							<td align="left" class="commFont">{*[Parameter]*}{*[Name]*}</td>
							<td align="left" class="commFont">{*[Parameter]*}{*[Value]*}</td>
							<td align="left"><input type="button" value="{*[Add]*}" onclick="addRows()" />
						</td>
					</tr>
				</tbody>
			</table>
			<s:hidden id="queryString" name="content.queryString" />
			</td>
		</tr>
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Description]*}：</span><br>
			<s:textarea cssStyle="width:350px;" cssClass="input-cmd" theme="simple" name="content.description" /></td>
		</tr>
 --%>
</table>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
