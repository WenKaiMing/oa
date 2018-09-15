<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html><o:MultiLanguage>
<head>
<title>{*[ValidateLibs]*}{*[List]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}
function contentTableH(){
	var bodyH = document.getElementById("application_info_libraries_validateLibs_list").offsetHeight;
	var querydspH = document.getElementById("Querydsp").offsetHeight;
	var tab_table_allH = document.getElementById("tab_table_all").offsetHeight;
	var navigation_titleH = document.getElementsByClassName("navigation_title")[0].offsetHeight
	var contentTableH = bodyH - querydspH - tab_table_allH - navigation_titleH;
	document.getElementById("contentTable").style.height= contentTableH +"px";
	document.getElementById("contentTable").style.overflowY = "auto";
}
jQuery(document).ready(function(){
	inittab();
	cssListTable();
	window.top.toThisHelpPage("application_info_libraries_validateLibs_list");
	contentTableH();
});
</script>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />"	type="text/css">
</head>
<body id="application_info_libraries_validateLibs_list" class="body-back">
<s:form theme="simple" name="formList" action="list" method="post">
<%@include file="/common/list.jsp"%>
<s:hidden name="_moduleid" value="%{#parameters.s_module}" />
<s:hidden name="s_module" value="%{#parameters.s_module}" />
<s:hidden name="mode" value="%{#parameters.mode}" />
<s:textfield name="tab" cssStyle="display:none;" value="2" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnValidateLibs'}" />
<table cellpadding="0" cellspacing="0" width="100%" id="tab_table_all">
	<tr class="nav-td" style="height:27px;">
		<td rowspan="2"><div style="width:400px"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr class="nav-s-td" >
		<td class="nav-s-td" align="right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
						<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
<div class="navigation_title">{*[ValidateLibs]*}</div>
 <table border="0" id="Querydsp">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				size="10" /></td>
		
			<td class="head-text">{*[Content]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_content" value='<s:property value="#parameters['sm_content']"/>'
				size="10" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/></td>
		</tr>
	</table>
	
<div id="contentTable">
<table class="table_noborder">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			
			<td class="column-head" scope="col">{*[Content]*}</td>
		</tr>

		<s:iterator value="datas.datas" status="index">
			<tr>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id" />"></td>
			<td ><a
				href="<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="mode" value="#parameters.mode" />
				<s:param name="application" value="#parameters.application" />
			    <s:param name="_moduleid" value="#parameters.s_module" />
			    <s:param name="tab" value="2" />
				<s:param name="selected" value="%{'btnValidateLibs'}" />
				<s:param name="sm_name" value="#parameters.sm_name"/>
				<s:param name="sm_content" value="#parameters.sm_content"/>
				</s:url>">
			<s:property value="name" /></a></td>
			<td><s:property value="(content!=null && content.length()>60) ? content.substring(0,60): content" /></td>
			</tr>
		</s:iterator>
	</table>

	<table class="table_noborder">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
	</div>
</s:form>
</body>

</o:MultiLanguage></html>
