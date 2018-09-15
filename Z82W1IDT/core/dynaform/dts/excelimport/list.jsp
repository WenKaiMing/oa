<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[IMPMappingConfigInfo]*}{*[List]*}</title>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}
function contentTableH(){
	var bodyH = document.getElementById("application_info_advancedTools_excelConf_list").offsetHeight;
	var searchFormTableH = document.getElementById("searchFormTable").offsetHeight;
	var tab_table_allH = document.getElementById("tab_table_all").offsetHeight;
	var navigation_titleH = document.getElementsByClassName("navigation_title")[0].offsetHeight
	var contentTableH = bodyH - searchFormTableH - tab_table_allH - navigation_titleH;
	document.getElementById("contentTable").style.height= contentTableH +"px";
	document.getElementById("contentTable").style.overflowY = "auto";
}
jQuery(document).ready(function(){
	inittab();
	cssListTable();
	window.top.toThisHelpPage("application_info_advancedTools_excelConf_list");
	contentTableH();
});
</script>
</head>
<body id="application_info_advancedTools_excelConf_list" class="body-back">
<s:form name="formList" theme="simple" action="list" method="post">
<s:textfield name="tab" cssStyle="display:none;" value="3" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnExcelConf'}" />
<%@include file="/common/list.jsp"%>
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
<s:param name="application" value="#parameters.application" />

<table cellpadding="0" cellspacing="0" width="100%" id="tab_table_all">
	<tr style="height:27px;">
		<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
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
<div class="navigation_title">{*[cn.myapps.core.validate.repository.excelconf]*}</div>
<div id="searchFormTable">
	<table border="0">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				size="30" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/></td>
		<tr>
	</table>
</div>
<div id="contentTable">
	<table class="table_noborder">
	   	<tr>
	   		<td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"></td>
	   		<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<tr>
		   	 	<td class="table-td">
	  	 			<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
	  	 		<td><a href='<s:url value="edit.action">
	  	 					<s:param name="id" value="id"/>
	  	 					<s:param name="_currpage" value="datas.pageNo" />
							<s:param name="_pagelines" value="datas.linesPerPage" />
							<s:param name="_rowcount" value="datas.rowCount" />
							<s:param name="application" value='#parameters.application'/>
							<s:param name="tab" value="3" />
							<s:param name="selected" value="%{'btnExcelConf'}" />
							<s:param name="sm_name" value="#parameters.sm_name"/>
	  	 				 </s:url>'>
	  	 			<s:property value="name" />
	  	 		</a></td>
	 		</tr>
	    </s:iterator>
	</table>
	<table class="table_noborder">
	  <tr>
	    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
	  </tr>
	</table>
</div>
</s:form>
</body>
</o:MultiLanguage></html>