<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.base.action.BaseAction" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="cn.myapps.constans.Web" %>
<%@ taglib uri="/struts-tags" prefix="s"%><%@page import="cn.myapps.core.email.util.Constants"%>
<%
	String contextPath = request.getContextPath();
%>
<s:bean id="resourceUtil"
	name="cn.myapps.core.resource.action.ResourceHelper" />

<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh">
	<s:param name="application" value="%{#parameters.application}" />
</s:bean>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.resource.menu_info]*}</title>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/LinkHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ResourceUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/CrossReportHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/RunQianReportHelper.js"/>'></script>
	<script src="<s:url value='/script/util.js'/>"></script>

	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<link rel="stylesheet" href="<s:url value='/core/fonts/awesome/font-awesome.min.css'/>" type="text/css" />
		
	<!-- 颜色选择取插件 -->
	<link rel="stylesheet" type="text/css" href="<s:url value='/script/bgrins-spectrum/spectrum.css'/>">
	<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/spectrum.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/script/bgrins-spectrum/i18n/jquery.spectrum-zh-cn.js'/>"></script>

	<script>
	var orginImgVal;   //原图片数据
	var orginFontVal;  //原文字数据

	var contextPath = '<%=contextPath%>';
	var email_url = '<%=Constants.EMAIL_BASE_URL%>';

	//菜单类型改变事件
	function ev_typechange(value){
		var _type_mobile = document.getElementById("_type_mobile");
		var _type_page = document.getElementById("_type_page");
		var def = '<s:property value="content.linkType"/>';
		if(!def || def == null){
			def = '';
		}
		DWREngine.setAsync(false);
		if (value=='100'){
			var set_tpye_value = document.getElementById("_type").value;
			if(set_tpye_value == '00' || set_tpye_value == '01' )
				_type_mobile.value = set_tpye_value;
			_type_mobile.style.display = '';
			_type_page.style.display = 'none';
			LinkHelper.get_MbLinkType(function(options) {
				addOptions("_type", options, def);
			});
		}else{
			var set_tpye_value = document.getElementById("_type").value;
			if(set_tpye_value != '')
				_type_page.value = set_tpye_value;
			_type_mobile.style.display = 'none';
			_type_page.style.display = '';
			LinkHelper.get_AllLinkType(function(options) {
				addOptions("_type", options, def);
			});
		}
		ResourceUtil.get_menus('<s:property value="content.id"/>',value,'<s:property value="#parameters.application"/>','_superiorid','<s:property value="_superiorid"/>',function(str) {var func=eval(str);func.call();});
		DWREngine.setAsync(true);
	}

	function ev_mbIcochange(s_ico){
		var img = document.getElementById("img_mbico");
		img.src = "../../resource/imgnew/mobile/d"+s_ico.value+".png";
	}
	/**
	function ev_change2(n){
		var rb;
		   if(n==null||n=='')
		   {
		    rb = eval("formItem.elements('isview')");
		   		for(var i=0; i< rb.length; i++){
		   			if(rb[i].checked){
		   				n=rb[i].value;
		   			}
		   		}
		   }
		
		if(n == 'private'){
			dm.style.display='';
		}
		if(n == 'public'){
			dm.style.display='none';
		}
	}*/
	
	function ev_load(){
		if ('<s:property value="#parameters['refresh']" />'=='true') {
			parent.frames[0].location.reload();
		}
		ev_typechange('<s:property value="content.type"/>');
		//ev_change2('<s:property value="isview"/>');
		//sort("s_mbIco");
		var img = '<s:property value="content.ico"/>';
		if(img.length==0){
			document.getElementById("_iconImg").style.display = 'none';
		}
	}
	
	function sort(sId) {
	 	if(!document.getElementById(sId)){//如果传过来的ID没有找到，就提示一下；
	  		return;
	 }
	 var lst = document.getElementById(sId); //得到select 的ID；
	 var selectValue = '<s:property value="content.mobileIco"/>';
	 var ops = []; //设一个空的数组
	 while(lst.options.length){ 
	  var b = lst.options[lst.options.length - 1];
	  ops.unshift(lst.removeChild(b)); //从节点中移除并存在数组中
	 }
	 ops.sort(function (a,b){return a.value-b.value;}); //排列用的一个匿名函数
	 while(ops.length){
	  lst.appendChild(ops.shift()); //重新填加在节点上
	 }
	 if (selectValue){
	 var i = 0;
	 while(i<lst.options.length){
	 	if (lst.options[i].value==selectValue){
	 		lst.options[i].selected=true;
	 		break;
	 	}
	 	i++;
	 }
	 }else{
	 	lst.options[0].selected=true;
	 }
	 lst = null;
	}

	function checkForm(){
		var name=jQuery("input[name='content.description'").val();
		if(name == null || name == ""){
			alert("{*[cn.myapps.core.resource.please_input_name]*}");
			return false;
		}
		
		var type = jQuery("#_type_page").val();
		var module = jQuery("#module").val();
		var actionForm = jQuery("#actionForm").val();
		var actionView = jQuery("#actionView").val();
		var actionReport = jQuery("#actionReport").val();
		var actionExcelImport = jQuery("#actionExcelImport").val();
		var externalLinks = jQuery("#externalLinks").val();

		if(type == "00"){
			if(module == null || module == ""){
				alert("{*[cn.myapps.core.resource.please_select_module]*}");
				return false;
			} else {
				if(actionForm == null || actionForm == ""){
					alert("{*[cn.myapps.core.resource.please_select_form]*}");
					return false;
				}
			}
		}
		
		if(type == "01"){
			if(module == null || module == ""){
				alert("{*[cn.myapps.core.resource.please_select_module]*}");
				return false;
			} else {
				if(actionView == null || actionView == ""){
					alert("{*[cn.myapps.core.resource.please_select_view]*}");
					return false;
				}
			}
		}
		if(type == "02"){
			if(module == null || module == ""){
				alert("{*[cn.myapps.core.resource.please_select_module]*}");
				return false;
			} else {
				if(actionReport == null || actionReport == ""){
					alert("{*[cn.myapps.core.resource.please_select_report]*}");
					return false;
				}
			}
		}
		if(type == "03"){
			if(actionExcelImport == null || actionExcelImport == ""){
				alert("{*[cn.myapps.core.resource.please_select_excel]*}");
				return false;
			}
		}
		if(type == "05"){
			if(externalLinks == null || externalLinks == ""){
				alert("{*[cn.myapps.core.resource.please_input_link]*}");
				return false;
			}
		}
		if(type == "06"){
			if(externalLinks == null || externalLinks == ""){
				alert("{*[cn.myapps.core.resource.please_input_link]*}");
				return false;
			}
		}
		if(type == "09"){
			if(actionReport == null || actionReport == ""){
				alert("{*[cn.myapps.core.resource.please_select_report]*}");
				return false;
			}
		}
		return true;
	}
	
	function Save(type){
		if(checkForm()){
			if(buildActionContent()){
				document.getElementsByName('content.queryString')[0].value = buildQueryString();
				if (type == "saveAndNew")
					document.forms[0].action="saveAndNew.action";
	
				document.getElementById("btn_saveAndNew").disabled = true;
				document.getElementById("btn_save").disabled = true;
				document.forms[0].submit();
			}
		}
	}
	
	function uploadIco(){
		var applicationid = document.getElementById("applicationid").value;
		document.forms[0].elements['content.ico'].value=uploadFile('RESOURCE_PATH','icoid','','','','','',applicationid);
	}
	
	//选择链接
	function selectLink(){
		var url =  contextPath + '/core/links/selectlink.action?application=<s:property value="#parameters.application"/>';
		//var rtn = showframe('{*[Please choose a Link]*}', url);
		
		OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.resource.select_link]*}',
				close: function(link) {
					window.top.toThisHelpPage("application_info_generalTools_menu_info");
					if (link.id == '') {
						document.getElementById("_link").value='';
						document.getElementById("link").value='';
					}
					else{
					    document.getElementById("link").value = link.id;
					    document.getElementById("_link").value =link.name;
					    parseType(link.type);
					    showOrHideTotalRowTR(link.id);
					}
				}
		});
	}

	function showOrHideTotalRowTR(linkid){
		DWREngine.setAsync(false);
		ResourceUtil.isLinkToView(linkid,function(data){
			if(data!=null && data==true){
				jQuery("#showtotalrowtrtitle").css("display","");
				jQuery("#showtotalrowtrcontent").css("display","");
			}else{
				jQuery("#showtotalrowtrtitle").css("display","none");
				jQuery("#showtotalrowtrcontent").css("display","none");
			}
		});
	}
	
	function parseType(type){
		switch (type){
		case '00':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[Form]*})';
			break;
		case '01':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[View]*})';
			break;
		case '02':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[cn.myapps.core.resource.report]*})';
			break;
		case '03':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[cn.myapps.core.resource.excel_import]*})';
			break;
		case '05':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[cn.myapps.core.resource.manual_input_links]*})';
			break;
		case '07':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[cn.myapps.core.resource.script_links]*})';
			break;
		case '12':
			document.getElementById("_link").value=document.getElementById("_link").value+' ({*[View]*})';
			break;
		}
	}
	
	jQuery(document).ready(function(){
		window.parent.init_MenuTree();
		ev_load();
		ev_load2();
		var icon = document.getElementsByName("content.ico")[0].value;
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
						document.getElementsByName("content.ico")[0].value = "{\"icon\":\"/uploads/lib/icon/"+rtn+"\",\"icontype\":\"img\"}"
						jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + '/uploads/lib/icon/' + rtn));
					}
				}
			});
		});
		
		//选取字体图标绑定事件
		jQuery("#browseFontServer").bind("click",function(){
			var url = contextPath + '/core/resource/iconFontLib_Awesome.jsp' ;
			OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '选取字体图标',
				close: function(rtn) {
					if(rtn != "" && rtn){	
						var iconVal = jQuery("#_icon").val();
						var iconJson = setValueJson(iconVal);
						document.getElementsByName("content.ico")[0].value = "{\"icon\":\"/uploads/lib/icon/"+rtn+"\",\"icontype\":\"img\"}"
						iconJson.icontype = "font";
						iconJson.icon = rtn;
						jQuery("#_icon").val(JSON.stringify(iconJson));
						jQuery(".oicon_font>i").removeClass().addClass(rtn);
					}
				}
			});
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
				var iconVal = jQuery("#_icon").val();
				var iconJson = setValueJson(iconVal);
				iconJson.iconFontColor = color.toHexString();
				jQuery("#_icon").val(JSON.stringify(iconJson));				
				jQuery("#oicon_tr .oicon_font").find("i").css("color",color.toHexString());				
			}
		});
		jQuery("#oicontype_tr input").on("click",function(){
			var typeVal = jQuery(this).val();
			iconTypeChange(typeVal);
		});
		removeDeprecatedMenuTypeOption();
		window.top.toThisHelpPage("application_info_generalTools_menu_info");
	});
	
	//根据图片形式显示值切换显示内容
	function iconShowChange(){
		
		var $iconShow = jQuery("#iconShow_tr input");
		if($iconShow.attr("checked") == "checked"){
			jQuery("#oheight_tr").hide();
		}else {
			jQuery("#oheight_tr").show();
		}
	}

	//判断旧数据 利用json2.js将字符串转对象
	function setValueJson(val){
		var oldVal = false;
		var iconJson;
		try { 
			iconJson = JSON.parse(val);
		}catch(e){ 
			oldVal = true;
		} 
		if(oldVal == true){
			iconJson = {};
			iconJson.icon = val;
		}
		return iconJson;
	}
	
	//初始化图标类型
	function initIconType(typeVal){
		var iconVal = jQuery("#_icon").val();
		if(typeVal == "font"){
			
			//初始化图标
		    var img = "/portal/H5/resource/images/icon_menu_default.png";
		    document.getElementsByName("content.ico")[0].value = img;
			jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + img));
			
			var iconJson = new Object();
			iconJson.icon = img;
			iconJson.icontype ="img";
			
		    orginImgVal = JSON.stringify(iconJson);   //原图片数据
		    orginFontVal = iconVal ;  //原文字数据
		    
		    jQuery("#_icon").val(orginImgVal);
		    
		    iconTypeChange("font")
		    
		}else if(typeVal == "img"){
			
			 //初始化文字
			 var icon = "fa fa-gear";
		     var iconJson = new Object();
		     iconJson.icon = icon;
		     iconJson.icontype ="font";
		     iconJson.iconFontColor="#000";
		     document.getElementsByName("iconFontColor")[0].value ="#000";
			 orginImgVal = iconVal;   //原图片数据
			 orginFontVal = JSON.stringify(iconJson); //原文字数据
			 
			 jQuery("#_icon").val(orginFontVal);
			 
			 iconTypeChange("img")
		}else{
			 //初始化文字
		     var icon = "fa fa-gear";
		     var iconJson = new Object();
		     iconJson.icon = icon;
		     iconJson.icontype ="font";
		     iconJson.iconFontColor="#000";
		     orginFontVal = JSON.stringify(iconJson);   //原文字数据
		  
		    
		     //初始化图标
	         var img = "/portal/H5/resource/images/icon_menu_default.png";
	         document.getElementsByName("content.ico")[0].value = img;
		     jQuery("img[name=_iconImg]").css("display","").attr("src",(contextPath + img));
		     var _iconJson = new Object();
		     _iconJson.icon =  img;
		     _iconJson.icontype ="img";
			
		     orginImgVal = JSON.stringify(_iconJson);   //原图片数据
		     jQuery("#_icon").val(orginImgVal);
		     
		     iconTypeChange("img");
			
		     //设置颜色
		     document.getElementsByName("iconFontColor")[0].value ="#000";
		}
	}
	
	//图标类型
	function iconTypeChange(typeVal){
		jQuery("#oicon_tr td>div").hide();
		jQuery("#oicon_tr").find(".oicon_"+typeVal).show();
		jQuery("#oicontype_tr").find("input[value='"+typeVal+"']").attr("checked",'2');
		var iconVal = jQuery("#_icon").val();
		var iconJson = setValueJson(iconVal);
		
		if(typeVal == "font"){
			var fontVal = setValueJson(orginFontVal);
			jQuery("#_icon").val(orginFontVal);
			jQuery(".oicon_font>i").removeClass().addClass(fontVal.icon);
			document.getElementsByName("iconFontColor")[0].value = fontVal.iconFontColor;
			orginImgVal = JSON.stringify(iconJson);
		}else {
		    jQuery("#_icon").val(orginImgVal);
		    orginFontVal = JSON.stringify(iconJson);
		}
	}

	</script>
	<!-- link script -->
	<script type="text/javascript" language="javascript">
	var contextPath = '<%=contextPath%>';
	
	function onTypeChange(type){
		var omodule_tr = document.getElementById('omodule_tr');
		var oview_tr = document.getElementById('oview_tr');
		var oform_tr = document.getElementById('oform_tr');
		var oreport_tr = document.getElementById('oreport_tr');
		var oexcelimport_tr = document.getElementById('oexcelimport_tr');
		var oexternal_tr = document.getElementById('oexternal_tr');
		var directory = document.getElementById('directory');
		var oscript_tr = document.getElementById('oscript_tr');
		var showtotalrowtrtitle = document.getElementById('showtotalrowtrtitle');
		var showtotalrowtrcontent = document.getElementById('showtotalrowtrcontent');
		var runqianreport_tr = document.getElementById('runqianreport_tr');
		var _type = document.getElementById("_type");
		var shwotype_tr = document.getElementById("showtype_tr");
		omodule_tr.style.display='none';
		oview_tr.style.display='none';
		oform_tr.style.display='none';
		oreport_tr.style.display='none';
		oexcelimport_tr.style.display='none';
		oexternal_tr.style.display='none';
		directory.style.display='none';
		oscript_tr.style.display='none';
		showtotalrowtrtitle.style.display='none';
		showtotalrowtrcontent.style.display='none';
		runqianreport_tr.style.display = 'none';
		shwotype_tr.style.display = 'none';
		var def =  document.getElementById("actionContent").value;
		//document.getElementById('module').options[0].selected = true;
		
		switch (type){
		case '':
			_type.value = '';
			break;
		case '00':
			omodule_tr.style.display='inline';
			oform_tr.style.display='inline';
			shwotype_tr.style.display ='inline';
			createFormOptionByModule('actionForm');
			_type.value = '00';
			break;
		case '01':
			omodule_tr.style.display='inline';
			oview_tr.style.display='inline';
			showtotalrowtrtitle.style.display='inline';
			showtotalrowtrcontent.style.display='inline';
			createViewOptionByModule('actionView');
			_type.value = '01';
			break;
		case '02':
			omodule_tr.style.display='inline';
			oreport_tr.style.display='inline';
			createReportOptionByModule('actionReport');
			_type.value = '02';
			break;
		case '03':
			oexcelimport_tr.style.display='inline';
			_type.value = '03';
			break;
		case '04':
			//oexcelimport_tr.style.display='inline';
			_type.value = '04';
			break;
		case '05':
			oexternal_tr.style.display='';
			directory.style.display='inline';
			_type.value = '05';
			//document.getElementById("externalLinks").value = def;
			break;
		case '06':
			oexternal_tr.style.display='inline';
			_type.value = '06';
			//document.getElementById("externalLinks").value = def;
			break;
		case '07':
			oscript_tr.style.display='inline';
			_type.value = '07';
			break;
			//document.getElementById("actionScript").value = def;
		case '08':
			var object = document.getElementById("actionContent");
			object.value = email_url;
			_type.value = '08';
			break;
		case '09':
			oreport_tr.style.display='inline';
			var def =  document.getElementById("actionContent").value;
			CrossReportHelper.creatReport('customize','<s:property value="#parameters.application"/>','',def,function(str) {var func=eval(str);func.call();});
			_type.value = '09';
			break;
		case '10':
			_type.value = '10';
			break;
		case '11':
			_type.value = '11';
			break;	
		case '12':
			omodule_tr.style.display='inline';
			oview_tr.style.display='inline';
			showtotalrowtrtitle.style.display='inline';
			showtotalrowtrcontent.style.display='inline';
			runqianreport_tr.style.display='inline';
			createViewOptionByModule('actionView');
			createRunqianReportFiles('actionRunqianReport');
			_type.value = '12';
			break;
		}
	}
	
	function onModuleChange(){
		var type = document.getElementById("_type").value;
		switch (type){
		case '00':
			createFormOptionByModule('actionForm');
			break;
		case '01':
			createViewOptionByModule('actionView');
			break;
		case '02':
			createReportOptionByModule('actionReport');
			break;
		case '12':
			createViewOptionByModule('actionView');
			createRunqianReportFiles('actionRunqianReport');
			break;
		}
		
	}
	
	function createFormOptionByModule(relatedFieldId){
		var moduleid = document.getElementById("module").value;
		var def =  document.getElementById("actionContent").value;
		//if (module.value=='') {
			//moduleid = '<s:property value="content.link.moduleid"/>';
		//}
		FormHelper.get_NormalAndMappingFormListByModules(moduleid, function(options) {
			addOptions(relatedFieldId, options, def);
		});
	}

	//通过模块视图
	function createViewOptionByModule(view){
		var moduleid = document.getElementById("module").value;
		var def =  document.getElementById("actionContent").value;
		var _type = document.getElementById("_type").value;
		if(_type=='12'){//当为润乾报表类型时，切割字段获取视图编号，让视图回选
			def = def.substring(def.indexOf("_viewid")+8);
		}
		//if (moduleid=='') {
			//moduleid = '<s:property value="content.link.moduleid"/>';
		//}
		ApplicationUtil.creatView(view,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call();});
		
	}

    //获取润乾报表模板
	function createRunqianReportFiles(report){
		var def =  document.getElementById("actionContent").value;
		var _type = document.getElementById("_type").value;
		if(_type=='12'){//当为润乾报表类型时，切割字段润乾报表模板文件回选
			def = def.substring(0,def.indexOf("_viewid")-1);
		}
		RunQianReportHelper.getReportFiles(report,def,function(str) {
			var func=eval(str);
			func.call();});
		
	}
	
	function createReportOptionByModule(report){
		var moduleid = document.getElementById("module").value;
		var def =  document.getElementById("actionContent").value;
		//if (moduleid=='') {
			//moduleid = '<s:property value="content.link.moduleid"/>';
		//}
		CrossReportHelper.creatReport(report,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call();});
		
	}
	
	function addOptions(relatedFieldId, options, defValues){
		var el = document.getElementById(relatedFieldId);
		var temp = el.value;//谷歌浏览器执行DWRUtil.addOptions会改变relatedFieldId的值,先保存后设置回去
		if(relatedFieldId){
			DWRUtil.removeAllOptions(relatedFieldId);
			DWRUtil.addOptions(relatedFieldId, options);
		}
		el.value = temp;
		if (defValues) {
			DWRUtil.setValue(relatedFieldId, defValues);
		}
	}
	
	
	
	function buildActionContent(){
		var type = document.getElementById("_type").value;
		switch (type){
		case '00':
			document.getElementById("actionContent").value = document.getElementById("actionForm").value;
			break;
		case '01':
			document.getElementById("actionContent").value = document.getElementById("actionView").value;
			break;
		case '02':
			document.getElementById("actionContent").value = document.getElementById("actionReport").value;
			break;
		case '03':
			document.getElementById("actionContent").value = document.getElementById("actionExcelImport").value;
			break;
		case '05':
			document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
			break;
		case '06':
			document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
			break;
		case '07':
			document.getElementById("actionContent").value = document.getElementById("actionScript").value;
			break;
		case '08':
			//document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
			break;
		case '09':
			document.getElementById("actionContent").value = document.getElementById("actionReport").value;
			break;
		case '10':
			var url = '/bbs/index.htm';
			document.getElementById("actionContent").value = url;
			break;
		case '12':
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
		}
		return true;
	}
	
	function buildActionUrl(){
		var type = document.getElementById("_type").value;
		switch (type){
		case '00':
			var id = document.getElementById("actionForm").value;
			var url = contextPath + '/portal/dynaform/document/new.action?_formid='+id+'&_isJump=1';
			document.getElementById("actionUrl").value = url;
			break;
		case '01':
			var id = document.getElementById("actionView").value;
			var url = contextPath+'/portal/dynaform/view/displayView.action?_viewid='+id+'&clearTemp=true';
			document.getElementById("actionUrl").value = url;
			break;
		case '02':
			var id = document.getElementById("actionReport").value;
			var url = contextPath+'/portal/report/crossreport/runtime/runreport.action?reportId='+id;
			document.getElementById("actionUrl").value = url;
			break;
		case '03':
			var id = document.getElementById("actionExcelImport").value;
			var applicationid = document.getElementById("applicationid").value;
			var url = contextPath+'/portal/share/dynaform/dts/excelimport/importbyid.jsp?id='+id+"&applicationid="+applicationid;
			document.getElementById("actionUrl").value = url;
			break;
		case '05':
			var url = document.getElementById("externalLinks").value;
			document.getElementById("actionUrl").value = url;
			break;
		case '10':
			var url = '/bbs/index.htm';
			document.getElementById("actionUrl").value = url;
			break;
		case '12':
			var id = document.getElementById("actionView").value;
			var url = contextPath+'/portal/share/report/runqianreport/content.jsp?_viewid='+id+'&clearTemp=true';
			document.getElementById("actionUrl").value = url;
			break;
		}
	}
	
	//生成请求参数
	function buildQueryString(){
		var pkey = document.getElementsByName("paramKey");
		var pvalue = document.getElementsByName("paramValue");
		var str = '[';
		for (var i=0;i<pkey.length;i++) {
			if (pkey[i].value != '' && pvalue[i].value != '' ){
					str += '{';
					str += pkey[i].name +':\''+pkey[i].value+'\',';
					str += pvalue[i].name +':\''+pvalue[i].value+'\'';
					str += '},';
			}
		}
		str += ']';
		return  str;	
	
	}
	
	//根据mapping str获取data array
	function parseRelStr(str) {
		var obj = eval(str);
		if (obj instanceof Array) {
			return obj;
		} else {
			return new Array();	
		}
	}
	
	
	function ev_load2(){
		var type = document.getElementById("_type").value;
		var content = document.getElementById("actionContent").value;
		switch (type){
			case '05':
				document.getElementById("externalLinks").value = content;
				break;
			case '06':
				document.getElementById("externalLinks").value = content;
				break;
			case '07':
				document.getElementById("actionScript").value = content;
				break;
				
		}
		onTypeChange(type);
		onModuleChange();
		
		var str = document.getElementsByName('content.queryString')[0].value;
		var datas = parseRelStr(str);
		addRows(datas);
		
	}
	
	var rowIndex = 0;
	var getParamKey = function(data) {
			if (data != null && data != undefined) {
		  	var s =''; 
			s +='<input type="text" id="paramKey'+ rowIndex +'" name="paramKey" style="width:100" value="'+HTMLDencode(data.paramKey)+'" />';
			return s; 
		}
	};
	
	var getParamValue = function(data) {
		if (data != null && data != undefined) {
		  	var s =''; 
			s +='<input type="text" id="paramValue'+ rowIndex +'" name="paramValue" style="width:100" value="'+HTMLDencode(data.paramValue)+'" />';
			return s; 
		}
	};
	
	var getDelete = function(data) {
		if (data != null && data != undefined) {
			
		  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
		  	rowIndex ++;
		  	return s;
		}
	};
	
	// 根据数据增加行
	function addRows(datas) {
		var cellFuncs = [getParamKey, getParamValue, getDelete];
	
		var rowdatas = datas;
		if (!datas || datas.length == 0) {
			var data = {paramKey:'', paramValue:''};
			rowdatas = [data];
		}
		DWRUtil.addRows("tb", rowdatas, cellFuncs);
		
	}
	
	// 删除一行
	function delRow(elem, row) {
		if (elem) {
			elem.deleteRow(row.rowIndex);
			//rowIndex --;
		}
	}
	
	function selectMultiLanguage(actionName, field){
		var url = contextPath + '/core/multilanguage/'+ actionName +'.action?application=' + '<s:property value="%{#parameters.application}" />';
		
		var oField = document.getElementsByName(field)[0];
		OBPM.dialog.show({
			opener:window.parent,
			width: 610,
			height: 440,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.resource.select_multiLanguage]*}',
			close: function(rtn) {
				if(rtn){
					oField.value = rtn;
				} else if (rtn == '') {
					oField.value = rtn;
				}
			}
		});
		
	}

	/**
	 * 删除过时的菜单动作类型选项
	 */
	function removeDeprecatedMenuTypeOption(){
		var id = document.getElementsByName("content.id")[0].value;
		if( !id || id.length==0){
			var types = document.getElementById("_type_page");
			for(var i=0;i<types.options.length;i++){
				var value = types.options[i].value;
				if(value=='11'){//需要屏蔽的动作类型
					 types.options.remove(i);
				}
			}
		}
	}
	</script>
</head>
<body id="application_info_generalTools_menu_info" class="contentBody" style="padding: 0px;margin: 0px;">
	<s:form action="save" method="post" theme="simple" name="formItem"
		validate="true">
		<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh" />
		<s:bean name="cn.myapps.core.resource.action.ResourceHelper" id="rh" />
		<table cellpadding="0" cellspacing="0" width="100%" style="border-bottom: 1px solid #D8DADC; ">
			<tr>
				<td align="right">
						<a id="btn_saveAndNew" class="button-image" onclick="Save('saveAndNew')"><img
							src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</a>
						<a id="btn_save" class="button-image" onClick="Save();"><img
							src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</a>
				</td>
			</tr>
		</table>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="contentMainDiv" class="contentMainDiv" style="border: 0px">
		<table class="table_noborder id1">
			<s:textfield cssStyle="display:none;" name="tab" value="1" />
			<s:textfield cssStyle="display:none;" name="selected"
				value="%{'btnResource'}" />
			<%@include file="/common/page.jsp"%>
			<tr>
				<td style="width: 50%;" valign="top">
				<table>
					<tr>
						<td align="left"><span class="commFont commLabel">{*[Name]*}：</span><br>
						<s:textfield theme="simple" cssClass="input-cmd"
							label="{*[Description]*}" name="content.description" /></td>
					</tr>
					<tr>
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.multilanguage.label]*}：</span><br>
						<s:textfield theme="simple" cssClass="input-cmd" readonly="true" cssStyle="width:255px"
							label="{*[cn.myapps.core.multilanguage.label]*}" name="content.multiLanguageLabel" />
							<button type="button" class="button-image" onClick="selectMultiLanguage('selectlist','content.multiLanguageLabel');">
								<img src='<s:url value="/resource/image/search.gif"/>'/>
							</button>	
						</td>
					</tr>
					<tr class="seperate" >
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.page.label.permission_type]*}</span><br>
						<div ><s:radio
							name="content.permissionType" theme="simple"
							list="#{'public':'{*[cn.myapps.core.resource.attr.permission_type.public]*}','private':'{*[cn.myapps.core.resource.attr.permission_type.private]*}'}"  /></div>
						</td>
					</tr>
					<tr class="seperate" id='showtotalrowtrtitle'
						style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.show_total]*}：</span><br>
						<div id="showtotalrowtrcontent"><s:radio
							name="content.showtotalrow" theme="simple"
							list="#{false:'{*[No]*}',true:'{*[Yes]*}'}" /></div>
						</td>
					</tr>

					<tr>
						<td align="left"><span class="commFont commLabel">{*[Superior]*}：</span><br>
						<s:select theme="simple" cssClass="input-cmd" name="_superiorid"
							id="_superiorid" list="{}" /></td>
					</tr>

					<tr>
						<td align="left"><span class="commFont commLabel">{*[SerialNum]*}：</span><br>
						<s:textfield theme="simple" cssClass="input-cmd"
							label="*[SerialNum]*}" name="content.orderno" /></td>
					</tr>

					<tr>
						<td align="left"><span class="commFont commLabel">{*[Type]*}：</span><br>
						<s:select cssClass="input-cmd" label="{*[Type]*}"
							onchange='ev_typechange(this.value)' name="content.type"
							list="#{'00':'{*[cn.myapps.core.resource.general_menu]*}','10':'{*[cn.myapps.core.resource.webpage_menu]*}','100':'{*[cn.myapps.core.resource.mobile_menu]*}'}"
							required="true" theme="simple" /></td>
					</tr>

					<tr>
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.open_link]*}：</span><br>
						<s:select cssClass="input-cmd" label="{*[Type]*}"
							name="content.opentarget"
							list="#{'detail':'{*[cn.myapps.core.resource.workarea_open]*}','target':'{*[cn.myapps.core.resource.newwindow_open]*}'}"
							required="true" theme="simple" /></td>
					</tr>

					<%-- <tr>
						<td align="left" width="50%">
						<div id="l_mbIco" style="display: none;">{*[cn.myapps.core.resource.mobile_icon]*}:</div>
						<img id='img_mbico' style="display: none;" src="" width='45px'
							height='45px' /><s:select id='s_mbIco' cssStyle="display:none;"
							cssClass="input-cmd" label="{*[cn.myapps.core.resource.mobile_icon]*}"
							name="content.mobileIco" list="#rh.getMobileIcons()"
							onchange="ev_mbIcochange(this)" required="true" /></td>
					</tr> --%>
				</table>
				</td>

				<!-- Links -->
				<td style="word-break: break-all;" valign="top">

				<table class="table_1">
					<!-- 此Table 是以前的链接页面 -->
					<!--  
					<s:hidden id="link" name="linkId" />
					-->
					<s:hidden id="actionContent" name="content.actionContent" />
					<s:hidden id="applicationid" value="%{#parameters.application}"/>
					<s:hidden name="content.applicationid"
						value="%{#parameters.application}" />
					<tr>
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.links_type]*}：</span><br>
						<s:select  cssClass="input-cmd"
							onchange="onTypeChange(this.value)" name="_type_mobile" cssStyle="display:none"
							id="_type_mobile" 
							list="#{'':'{*[Select]*}','00':'{*[Form]*}','01':'{*[View]*}'}"
							required="true" theme="simple" />
							<s:select  cssClass="input-cmd" 
							onchange="onTypeChange(this.value)" name="_type_page"
							id="_type_page" 
							list="#{'':'{*[Select]*}','00':'{*[cn.myapps.core.resource.form]*}','01':'{*[View]*}'
							,'02':'{*[cn.myapps.core.resource.report]*}'
							,'09':'{*[cn.myapps.core.resource.customize_report]*}'
							,'12':'{*[cn.myapps.core.resource.raq_report]*}'
							,'03':'{*[cn.myapps.core.resource.excel_import]*}'
							,'05':'{*[cn.myapps.core.resource.customize_links_internal]*}'
							,'06':'{*[cn.myapps.core.resource.customize_links_external]*}'
							,'07':'{*[cn.myapps.core.resource.script_links]*}'
							,'08':'{*[cn.myapps.core.resource.email_links]*}'
							,'11':'{*[cn.myapps.core.resource.network_disk_links]*}'}"
							required="true" theme="simple" />
							<s:select  cssClass="input-cmd" cssStyle="display:none"
							onchange="onTypeChange(this.value)" name="content.linkType"
							id="_type"
							list="#{'':'{*[Select]*}','00':'{*[Form]*}','01':'{*[View]*}'
							,'02':'{*[cn.myapps.core.resource.report]*}'
							,'09':'{*[cn.myapps.core.resource.customize_report]*}'
							,'12':'{*[cn.myapps.core.resource.raq_report]*}'
							,'03':'{*[cn.myapps.core.resource.excel_import]*}'
							,'05':'{*[cn.myapps.core.resource.customize_links_internal]*}'
							,'06':'{*[cn.myapps.core.resource.customize_links_external]*}'
							,'07':'{*[cn.myapps.core.resource.script_links]*}'
							,'08':'{*[cn.myapps.core.resource.email_links]*}'
							,'10':'{*[Forum.Links]*}'
							,'11':'{*[cn.myapps.core.resource.network_disk_links]*}'}"
							required="true" theme="simple" />
							</td>
					</tr>
					<tr id="omodule_tr" style="display: ;">
						<td align="left"><span class="commFont commLabel">{*[Module]*}：</span>
						<BR />
						<s:select  id="module"
							name="content.moduleid"
							list="#mh.getModuleSel(#parameters.application)"
							cssClass="input-cmd" onchange="onModuleChange();" /></td>
					</tr>
					<tr id="oview_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.view.OnActionView]*}：</span><br>
						<s:select id="actionView" 
							emptyOption="true" name="actionView" list="{}" /></td>
					</tr>
					
					<tr id="runqianreport_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.raq_report_template_file]*}：</span><br>
						<s:select id="actionRunqianReport" 
							emptyOption="true" name="actionRunqianReport" list="{}" /></td>
					</tr>

					<tr id="oform_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.view.OnActionForm]*}：</span><br>
						<s:select id="actionForm" 
							emptyOption="true" name="actionForm" list="{}" /></td>
					</tr>


					<tr id="oreport_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.view.OnActionReport]*}：</span><br>
						<s:select id="actionReport" 
							emptyOption="true" name="actionReport" list="{}" /></td>
					</tr>
					<tr id="oexcelimport_tr" style="display: none;">
						<s:bean name="cn.myapps.core.links.action.LinkHelper" id="lh" />
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.view.OnActionExcelImport]*}：</span><br>
						<s:select id="actionExcelImport" cssClass="input-cmd"
							 name="actionExcelImport" value="content.actionContent"
							list="#lh.get_ExcelImportCfgList(#parameters.application)" /></td>
					</tr>

					<tr id="oexternal_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.customize_links]*}：
						</span><div>
						<s:select cssClass="input-cmd" label="{*[Directory]*}"
							id="directory"
							name="content.directory"
							list="#{'portal':'portal/'}"
							cssStyle="display:none; width:24%;" theme="simple" />
						<s:textfield id="externalLinks" cssClass="input-cmd"
							 theme="simple" name="externalLinks" /></div></td>
					</tr>
					<tr id="oscript_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[Script]*}:</span><br>
						<s:textarea id="actionScript" cssClass="input-cmd"
							 name="actionScript" cols="50" rows="3" />
						<button class="button-image"
							onclick="openIscriptEditor('actionScript','{*[cn.myapps.core.resource.script_editor]*}','{*[cn.myapps.core.resource.links]*}','content.description','{*[cn.myapps.core.resource.sava_succeed]*}');"><img
							alt="{*[page.Open_with_IscriptEditor]*}"
							src="<s:url value='/resource/image/editor.png' />" /></button>
						</td>
					</tr>

					<tr id="omanualLink_tr" style="display: none;">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.manual_link]*}：</span><br>
						<s:textarea id="actionScript" cssClass="input-cmd"
							 name="actionScript" cols="50" rows="3" />
						</td>
					</tr>

					<tr>
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.parameter]*}：</span><br>
						<table class="table_hasborder" border=1 cellpadding="0"
							cellspacing="0" bordercolor="gray">
							<tbody id="tb">
								<tr>
									<td align="left" class="commFont">{*[cn.myapps.core.resource.parameter_name]*}</td>
									<td align="left" class="commFont">{*[cn.myapps.core.resource.parameter_value]*}</td>
									<td align="left"><input type="button" value="{*[Add]*}"
										onclick="addRows()" /></td>
								</tr>
							</tbody>
						</table>
						<s:hidden id="queryString" name="content.queryString" /></td>
					</tr>
					<tr id="showtype_tr">
						<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.resource.showtype]*}：</span><br>
						<s:select id="showtype" 
							name="content.showType" list="#{0:'{*[cn.myapps.core.resource.showtype.both]*}',1:'{*[cn.myapps.core.resource.showtype.menu]*}',2:'{*[cn.myapps.core.resource.showtype.flowcenter]*}'}" /></td>
					</tr>
				</table>
				<fieldset>
					<legend>图标设置</legend>
					<table>
						<tr id="oicontype_tr">
							<td align="left" >
								<span class="commFont commLabel">图标类型：</span><br>
								<s:radio name="icontype" theme="simple" list="#{'img':'图片','font':'字体图标'}" value="%{content.icontype + ''}" />
							</td>
						</tr>
						<tr id="oicon_tr">
							<td align="left"><span class="commFont commLabel">{*[Icon]*}：</span></br>
							<s:hidden id="_icon" name="content.ico" />
								<div class="oicon_img">
									<img id="_iconImg" name="_iconImg" alt="" src='<s:url value="/uploads/lib/icon/" /><s:property value="content.ico"/>'>
									<input type="button" value="{*[Select]*}" id="browseServer"/>
								</div>
								<div class="oicon_font">
									<i class="" style="font-size: 24px;"></i>
									<input type="button" value="{*[Select]*}" id="browseFontServer"/>
									<span class="oicon_font_color"><s:textfield name="iconFontColor" /></span>
								</div>
							</td>
						</tr>
					</table>
				</fieldset>
				</td>
			</tr>



			<!-- display -->
			<!-- 
			<tr class="seperate" style="display: none">
				<td>
				<table id="dm" style="display: none; width: 100%">
					<tr>
						<td align="left">{*[Domain]*}:</td>
					</tr>
					<tr>
						<td><s:bean
							name="cn.myapps.core.resource.action.ResourceHelper" id="rh"></s:bean>
						<s:checkboxlist list="#rh.getAllDomain()" cssClass="input-cmd"
							label="Module" name="colids"></s:checkboxlist></td>
					</tr>
				</table>
				</td>
			</tr>
			 -->

		</table>
		</div>
	</s:form>

	</body>
</o:MultiLanguage>
</html>
