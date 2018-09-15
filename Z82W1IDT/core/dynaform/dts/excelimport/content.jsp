<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();
%>
<html>
<o:MultiLanguage>
<head>
<title>Excel Import Mapping Config</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script src="<%= contextPath %>/js/billitem.js"></script>
<script src="<%= contextPath %>/js/check.js"></script>
<script src="<%= contextPath %>/js/util.js"></script>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script language="JavaScript">
<!--
var contextPath = '<%= contextPath %>';

function ev_checkval() {
  return true;
}

function ev_save() {
  formItem.elements['content.xml'].value=document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
  doSave();
}
function save() {
  formItem.elements['content.xml'].value=document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
  //alert(formItem.elements['content.xml'].value);
  forms[0].action="<s:url action='save'></s:url>";
  forms[0].submit();
}


//-->
</script>
<SCRIPT LANGUAGE="JavaScript">

/**
 * 后台文件上传
 * 
 * @param {}
 *            pathname 文件目录
 * @param {}
 *            pathFieldId 文件路径域ID
 * @param {}
 *            viewid 视图ID
 * @param {}
 *            allowedTypes 允许上传的类型
 * @param {}
 *            maximumSize 最大值
 * @param {}
 *            fileSaveMode 文件保存模式
 * @return {} 文件网络路径
 */
function uploadFile(pathname, pathFieldId, viewid, allowedTypes,
		maximumSize, layer, fileSaveMode, applicationid) {
	var url = contextPath + '/core/upload/upload.jsp?path=' + pathname
			+ "&applicationid=" + applicationid;

	var oField = jQuery("#" + pathFieldId);
	OBPM.dialog.show( {
		opener : window.parent.parent,
		width : 800,
		height : 600,
		url : url,
		args : {},
		title : '文件上传',
		close : function(result) {
			if (result && oField) {
				oField.val(result);
			}

		}
	});
}

function attechmentupload(excelpath){
	 uploadFile(excelpath,'path','','','','','',applicationid);
}

function addMasterSheet()
{
	document.ExcelMapping.addMasterSheet("","","");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditMasterSheet.jsp";
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 400,
			url: url,
			args: {},
			title: '{*[Add]*}{*[MasterSheet]*}',
			close: function(rtn) {
				document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.addMasterSheet(rtn.name,rtn.formName,"");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}

function addDetailSheet()
{
	document.ExcelMapping.addDetailSheet("","","");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditDetailSheet.jsp";
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 400,
			url: url,
			args: {},
			title: '{*[Add]*}{*[DetailSheet]*}',
			close: function(rtn) {
				document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.addDetailSheet(rtn.name,rtn.formName,"");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}

function addColumn()
{
	document.ExcelMapping.addColumn("","","","",false, "");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditColumn.jsp";
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 500,
			url: url,
			args: {},
			title: '{*[Add]*}{*[Column]*}',
			close: function(rtn) {
				document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.addColumn(rtn.name,rtn.fieldName,rtn.valueScript,rtn.validateRule,rtn.primaryKey, "");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}


function addRelation()
{
	document.ExcelMapping.addRelation();

}

function editMasterSheet()
{
	document.ExcelMapping.editMasterSheet(rtn.name,rtn.formName,"");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	//document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditMasterSheet.jsp";
	var oldAttr = new Object();
	oldAttr.name = document.ExcelMapping.getCurrToEditElement().name;
	oldAttr.formName = document.ExcelMapping.getCurrToEditElement().formName;
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 400,
			url: url,
			args: {"oldAttr":oldAttr},
			title: '{*[Edit]*}{*[MasterSheet]*}',
			close: function(rtn) {
				//document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.editMasterSheet(rtn.name,rtn.formName,"");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}

function editDetailSheet()
{
	document.ExcelMapping.editDetailSheet("","","");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	//document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditDetailSheet.jsp";
	var oldAttr = new Object();
	oldAttr.name = document.ExcelMapping.getCurrToEditElement().name;
	oldAttr.formName = document.ExcelMapping.getCurrToEditElement().formName;
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 400,
			url: url,
			args: {"oldAttr":oldAttr},
			title: '{*[Edit]*}{*[DetailSheet]*}',
			close: function(rtn) {
				//document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.editDetailSheet(rtn.name,rtn.formName,"");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}

function editColumn()
{
	document.ExcelMapping.editColumn("","","","",false,"");
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	/*
	//document.getElementById("appletcontent").style.display="none";
	url= contextPath + "/core/dynaform/dts/excelimport/EditColumn.jsp";
	var oldAttr = new Object();
	oldAttr.name = document.ExcelMapping.getCurrToEditElement().name;
	oldAttr.fieldName = document.ExcelMapping.getCurrToEditElement().fieldName;
	oldAttr.valueScript = document.ExcelMapping.getCurrToEditElement().valueScript;
	oldAttr.validateRule = document.ExcelMapping.getCurrToEditElement().validateRule;
	oldAttr.primaryKey = document.ExcelMapping.getCurrToEditElement().primaryKey;
	OBPM.dialog.show({
			opener:window.parent,
			width: 500,
			height: 500,
			url: url,
			args: {"oldAttr":oldAttr},
			title: '{*[Edit]*}{*[Column]*}',
			close: function(rtn) {
				//document.getElementById("appletcontent").style.display="";
				if(rtn!=null){
					document.ExcelMapping.editColumn(rtn.name,rtn.fieldName,rtn.valueScript,rtn.validateRule,rtn.primaryKey,"");
				}
				window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
			}
	});*/
}


function removeElement()
{
document.ExcelMapping.removeElement()
}

function saveToXML()
{
returnValue=document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");

}

function refresh()
{
var xmlstr=document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
frm1.xml.value = xmlstr;
}

function editElement()
{
  var toEdit = document.ExcelMapping.getCurrToEditElement1();
  if (toEdit != null) {
    if (toEdit=="cn.myapps.core.dynaform.dts.excelimport.MasterSheet") {
    	editMasterSheet();
    }
    else if (toEdit=="cn.myapps.core.dynaform.dts.excelimport.DetailSheet") {
    	editDetailSheet();
    }
    else if (toEdit=="cn.myapps.core.dynaform.dts.excelimport.Column") {
    	editColumn();
    }
  }
}

function ev_switchsheet(id) {
	var isChrome = navigator.userAgent.indexOf("Chrome")>0?true:false;
	if(isChrome){
		document.getElementById('appletcontent').style.display="none";
		document.getElementById('xmlcontent').style.display="none";
		document.getElementById(id).style.display = "";
		if (id == 'appletcontent') {
			var xml = document.getElementsByName('content.xml')[0].value;
			document.WorkFlowDiagram.loadXML(xml);
		} else {
			document.getElementsByName('content.xml')[0].value = document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
		}
	}else{
		document.getElementById('appletcontent').style.display="none";
		document.getElementById('xmlcontent').style.display="none";
		if (id == 'appletcontent') {
			document.getElementById('appletcontent').style.display="";
			var xml = document.getElementsByName('content.xml')[0].value;
			//alert("xml--->" + xml);
			if (xml) {
				document.ExcelMapping.loadXML(xml);
			}
			//document.getElementsByName('modify')[0].checked = false;
		} else {
			document.getElementsByName('content.xml')[0].value = document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
			document.getElementById('xmlcontent').style.display="";
		}
	}
}

function ev_onsubmit() 
{
  	//var modify = document.getElementsByName('modify')[0].checked;
  	//if (!modify) {
  		//
	//}
	document.getElementsByName('content.xml')[0].value = document.ExcelMapping.saveToXML().replace(/%5c/gi,"\\");
	if(formItem.elements['content.path'].value==null || formItem.elements['content.path'].value==""){
		alert('{*[cn.myapps.core.dynaform.dts.excelimport.none_upload_template]*}');
		return;
	}
	if(document.getElementsByName('content.xml')[0].value.length==0){
		alert("{*[ExcelConf]*}{*[none]*}{*[Configuration]*}");
		return;
	}
	formItem.action='<s:url action="save"></s:url>'; 
	formItem.submit();
}

/**
*
*  Base64 encode / decode
*
*  @author haitao.tu
*  @date   2010-04-26
*  @email  tuhaitao@foxmail.com
*
*/
 
function Base64() {
 
	// private property
	_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
 
	// public method for encoding
	this.encode = function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
		input = _utf8_encode(input);
		while (i < input.length) {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
			output = output +
			_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
			_keyStr.charAt(enc3) + _keyStr.charAt(enc4);
		}
		return output;
	}
 
	// public method for decoding
	this.decode = function (input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
		while (i < input.length) {
			enc1 = _keyStr.indexOf(input.charAt(i++));
			enc2 = _keyStr.indexOf(input.charAt(i++));
			enc3 = _keyStr.indexOf(input.charAt(i++));
			enc4 = _keyStr.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output = output + String.fromCharCode(chr1);
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		}
		output = _utf8_decode(output);
		return output;
	}
 
	// private method for UTF-8 encoding
	_utf8_encode = function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
		return utftext;
	}
 
	// private method for UTF-8 decoding
	_utf8_decode = function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
		while ( i < utftext.length ) {
			c = utftext.charCodeAt(i);
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			} else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			} else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}
		return string;
	}
}

function bsae64encode(str){
	var b = new Base64();
	var str2 = b.encode(str);
	document.getElementsByName('content.xml')[0].value = str2;
}

function base64decode(){
	var b = Base64();
	return b.decode(document.getElementsByName('content.xml')[0].value);
}

/**
 * 给Excel导入配置脚本调用
 * @param WorkFlowDiagram流程编辑器对象
 * @param fieldName
 * @param title
 * @return
 */
function flexOpenIsCriptEditor(str){
	var strs = JSON.parse(str);
	var nodeId = strs.nodeId;
	var fieldName = strs.fieldName;
	var label = strs.label;
	var value = document.ExcelMapping.getScriptValueToFieldName(nodeId,fieldName);
	var url = contextPath+ '/core/macro/editor/iscripteditor/iscripteditorFlow.jsp';
	var t = window.top;
	hiddenDiv();
	OBPM.dialog.show({
	width : t.document.body.clientWidth-200,
	height : t.document.body.clientHeight-100,
	url : url,
	args : {'fieldName' : value,'label' : label,'feedbackMsg' : '','parent' : window},
	title : '{*[Script]*}{*[Editor]*}',
	close: function(result) {
		showDiv();
		if (result != null && result != 'undefined' && result != 'null')
		document.ExcelMapping.setScriptValueToFieldName(nodeId,fieldName,result);
	}

	});
}

function hiddenDiv(){
	/* var isFirefox = navigator.userAgent.indexOf("Firefox")>0?true:false;
	//是火狐浏览器不给定位，因为定位后再返回会刷新flash。
	if(!isFirefox){
		document.getElementById("appletcontent").style.position="absolute";
		document.getElementById("appletcontent").style.top=-1000+"px";
	} */
}
function showDiv(){
	/* document.getElementById("appletcontent").style.position="static"; */
}

jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_info");
	jQuery("#save_btn").removeAttr("disabled");
});
</SCRIPT>
<script src="<%= contextPath %>/js/attachments.js"></script>
</head>
<body id="application_info_advancedTools_excelConf_info" class="contentBody">
<s:form theme="simple" id="formItem" action="save" method="post">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td"  style="height:27px;">
			<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button id="save_btn" type="button" class="button-image" disabled="disabled"
								onClick="ev_onsubmit();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="navigation_title">{*[cn.myapps.core.validate.repository.excelconf]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1" border="0">
			<s:textfield name="tab" cssStyle="display:none;" value="3" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnExcelConf'}" />
			<tr>
				<td>
					<table border="0">
						<tr>
							<td valign="top" style="width: 400px;">
								<table border="0">
								    <tr>
								    	<td class="commFont" valign="left" style="width: 101px; ">{*[Name]*}:</td>
							    	</tr>
							    	<tr>
								    	<td valign="left"><s:textfield cssClass="input-cmd" theme="simple" name="content.name"/> </td>
								    </tr>
							    </table>
							</td>
						<td>
			    		<table>
						    <tr>
								<td class="commFont">{*[cn.myapps.core.dynaform.dts.excelimport.upload_template]*}:</td>
							</tr>
							<tr>
								<td>
								<s:textfield id="path" name="content.path" cssStyle="width:260px;" readonly="true" theme="simple"/>
						      	<button type="button" name='upload' class="button-image" onClick="attechmentupload('EXCELTEMPLATE_PATH')"><img src="<s:url value="/resource/image/search.gif"/>"></button>
								</td>
								<td></td>
						    </tr>
						</table>
						</td>
					</table>
				</td>
		    </tr>
		    <tr> <td><table><tr><td>
		    	<button type="button"  onClick="ev_switchsheet('appletcontent')">{*[Diagram]*}</button>
				<button type="button"  onClick="ev_switchsheet('xmlcontent')">{*[Code]*}</button>
				</td></tr>
		    </table>
			</td></tr>
		    <tr id="xmlcontent" style="display:none" height="250">
				<td>
					<table>
						
						<tr><td>{*[Modify]*}:
						<s:checkbox name="modify" theme="simple" onclick="document.getElementsByName('content.xml')[0].readOnly = !this.checked;document.getElementsByName('content.xml')[0].style.color = this.checked ? 'black' : 'gray'" /></td>
						</tr>
						
						<tr><td>
							<s:textarea name="content.xml"  readonly="true" cssStyle="width:800px;height:300px;color:gray">
							</s:textarea>
						</td></tr>
					</table>
				</td>
			</tr>
			<tr id="appletcontent">
				<td>
				<table>
				<tr>
				<td>
				<Script language="JavaScript">
	            //document.write('<applet');
	            //document.write('  codebase = "."');
	            //document.write('  code     = "cn.myapps.core.dynaform.dts.excelimport.ExcelMappingApplet.class"');
	            //document.write('  archive  = "MinML.jar,MXML.jar"');
	            //document.write('  name     = "BFApplet"');
	            //document.write('  width    = "700"');
	            //document.write('  height   = "250"');
	            //document.write('  hspace   = "0"');
	            //document.write('  vspace   = "0"');
	            //document.write('  align    = "top"');
	            //document.write(' MAYSCRIPT');
	            //document.write('>');
	            //document.write('<param name="xmlStr" value="' + formItem.elements['content.xml'].value + '">');
	            //document.write('</applet>');
	            var canvasHeight = document.body.clientHeight;
	            var canvasWidth = document.body.offsetWidth;
	            var cHeight = canvasHeight - 220;
	            var cWidth = canvasWidth - 50;
				if(cHeight < 250) cHeight = 250;
				if(cWidth < 800) cWidth = 800;
	            document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
	            document.write('id="ExcelMapping" width="'+cWidth+'" height="'+cHeight+'"');
	            document.write('codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">');
	            document.write('<param name="movie" value="../../../common/flash/ExcelMapping.swf" />');
	            document.write('<param name="quality" value="high" />');
	            document.write('<param name="wmode" value="opaque">');
	            document.write('<param name="bgcolor" value="#ffffff" />');
	            document.write('<param name="wmode" value="opaque">');
	            document.write('<param name="FlashVars" value="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'"');
	            document.write('<param name="allowScriptAccess" value="sameDomain" />');
	            document.write('<embed src="../../../common/flash/ExcelMapping.swf" quality="high" bgcolor="#ffffff"');
	            document.write('width="'+cWidth+'" height="'+cHeight+'" name="ExcelMapping" align="middle" wmode="opaque" ');
	            document.write('FlashVars="canvasWidth='+canvasWidth+'&canvasHeight='+canvasHeight+'" ');
	            document.write('play="true" loop="false" quality="high" allowScriptAccess="sameDomain" wmode="opaque"');
	            document.write('type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer">');
	            document.write('</embed>');
	            document.write('</object>');
	            
	            function getXML(){
	            	var xml = document.getElementsByName('content.xml')[0].value;
	            	return xml;
	            }
	            </Script>
				</td>
				
			</tr>
			<tr>
				<td style="width:100%;">
					<input type="button" name="addActor" value="{*[Add]*} {*[MasterSheet]*}" onClick="addMasterSheet()">
					<input type="button" name="addActor" value="{*[Add]*} {*[DetailSheet]*}" onClick="addDetailSheet()">
					<input type="button" name="addGroup" value="{*[Add]*} {*[Column]*}" onClick="addColumn()">
					<input type="button" name="addActor" value="{*[Add]*} {*[Relation]*}" onClick="addRelation()">
					<input type="button" name="addActor" value="{*[Remove]*}" onClick="removeElement()">
					<!-- 
					<input type="button" name="addActor" value="{*[Edit]*}" onClick="editElement()">
					 -->
				</td>
				</tr>
				</table>
				</td>
			</tr>
			
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
