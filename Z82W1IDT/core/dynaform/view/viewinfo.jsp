<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.dynaform.view.info]*}</title>


<script src="<s:url value='/script/util.js'/>"></script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url id="url" value='/resourse/main.css'/>" />
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script>
function ev_isPagination(item) {
	var oTR = document.getElementById("pl_tr");
	oTR.style.display="";
	if (item.value != undefined) {
		if (item.value == 'true') {
			oTR.style.display="";
			document.getElementsByName('content.pagelines')[0].value="10";
		} else {
			oTR.style.display="none";
			document.getElementsByName('content.pagelines')[0].value="";	
		}
	}
	
}
function ev_showTreeDialog() {
	var url = contextPath + '/core/formula/tree.jsp';
	var moduleid = '<s:property value="#parameters.s_module" />';
	var filterScript = document.getElementsByName('content.filterScript')[0].value;
	//var include = "#include \"doclib\"; \n";
	if (moduleid != null && moduleid != '') {
		url = url + '?s_module=' + moduleid;
	} 
	if (filterScript != null && filterScript.trim != '') {
		filterScript = ev_filtrate(filterScript);
		url = addParam(url, 'content', filterScript);
	}
	var rtn = showframe('tree', url);
	
	if (rtn != undefined && rtn != '' && rtn != null) {
		document.getElementsByName('content.filterScript')[0].value = "\""+ rtn + "\""; 
	}
}

	function ev_filtrate(content) { //过滤掉#和"号;
		//var newcontent = content.substring(include.length + 1, content.length);
		var oldcontent
		do {
			oldcontent = content;
		  	content = content.replace("#","%23");
		  	content = content.replace("\"","");
		   	//content = content.replace(" ","&nbsp;")
		}

		while(oldcontent != content);
		return content;
	}
	 //去所有空格   
    String.prototype.trimAll = function(){   
        return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
    };  
    
	function doNew(){
		var thisform = document.getElementById("thisform");
		var name = document.getElementsByName('content.name')[0].value.trimAll();
		document.getElementsByName('content.name')[0].value=name;
		if(name==""){
			alert("{*[page.name.notexist]*}");
		}else{
			thisform.action='<s:url action="saveviewinfo"></s:url>';
			thisform.submit();
		}
	}

	//禁止直接回车键提交(新建)视图
	function forbidEnter(){
		//alert(event.srcElement.type+" "+event.keyCode);
		if(event.keyCode==13){
			if(event.srcElement.type!='button'){
				return false;
			}
		}

		return true;
	}  
    document.onkeydown=forbidEnter; 
    jQuery(document).ready(function(){
    	window.top.toThisHelpPage("application_module_view_basicinfo");
    });
</script>

<body onload="ev_isPagination(document.getElementsByName('_isPagination')[0])">
<s:form id="thisform" name="thisform" action="save" method="post">
	
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.dynaform.view.create_view]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="doNew()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Confirm]*}</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border-top: 1px solid dotted; border-color: black;">
			</td>
		</tr>
	</table>
	
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<%@include file="/common/page.jsp"%> 
<s:bean name="cn.myapps.core.style.repository.action.StyleRepositoryHelper" id="sh">
				<s:param name="moduleid" value="#parameters.s_module" />
			</s:bean> <s:bean
				name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh">
				<s:param name="moduleid" value="#parameters.s_module" />
			</s:bean> <input type="hidden" name="s_module"
				value="<s:property value='#parameters.s_module'/>" /> <input
				type="hidden" name="_moduleid"
				value="<s:property value='#parameters.s_module'/>" /> <input
				type="hidden" name="applicationid"
				value="<s:property value='#parameters.application'/>"> <input
				type="hidden" name="s_application"
				value="<s:property value='#parameters.application'/>"> <s:hidden
				name="_resourceid" />
	<table class="table_noborder viewinfoid1">
		<tr>
			<td class="commFont">{*[Name]*}:</td>
			<td class="commFont">{*[cn.myapps.core.dynaform.view.search_template]*}:</td>
		</tr>
		<tr>	
			<td><s:textfield cssClass="input-cmd" theme="simple" name="content.name"/></td>
			<td ><s:select label="{*[cn.myapps.core.dynaform.view.search_template]*}" name="_searchformid" cssClass="input-cmd"
				list="#vh.get_searchForm(#parameters.application)" listKey="id"
				listValue="name" theme="simple" emptyOption="true" /></td>
		</tr>
		<tr>
			<td class="commFont">{*[StyleLib]*}:</td>
			<td class="commFont">{*[cn.myapps.core.dynaform.view.open_type]*}:</td>
		</tr>
		<tr>
			<td><s:select cssClass="input-cmd" theme="simple" name="_styleid" list="#sh.get_listStyleByApp(#parameters.application)" listKey="id"
				listValue="name" emptyOption="true" /></td>
			<td ><s:select label="{*[cn.myapps.core.dynaform.view.open_type]*}" name="content.openType" cssClass="input-cmd" theme="simple" list="_OPENTYPE" /></td>
		</tr>
		<tr>
			<td class="commFont">{*[Pagination]*}:</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><s:radio id="_isPagination" name="_isPagination" listValue="value" value="'true'" onclick="ev_isPagination(this)"
				list="#{'true':'{*[Yes]*}','false':'{*[cn.myapps.core.dynaform.view.no]*}'}"  theme="simple" /></td>
			<td>
			<table>
				<tr id="pl_tr">
					<td><s:select cssClass="input-cmd" cssStyle="width:215px;" label="{*[PageLines]*}" name="content.pagelines" 
						list="#{'05':'5','10':'10','15':'15'}"
						theme="simple"  /><span>{*[page.view.pageline]*}</span></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr><td>{*[core.dynaform.form.action.FormHelper.relatedFrom]*}:</td></tr>
		<tr><td><s:select name="content.relatedForm"
							list="#fh.getNormalFormList(#parameters.application)"
							listKey="id" id="relatedForm" listValue="name" theme="simple"
							cssClass="input-cmd" />
						</td></tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
