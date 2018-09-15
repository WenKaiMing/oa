<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.versions.util.VersionsUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />" type="text/css">
<script type="text/javascript">
function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-80;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}
jQuery(document).ready(function(){
	adjustDataIteratorSize();
});
</script>
<title>{*[cn.myapps.core.versions.versions_logs]*}</title>
</head>
<body id="" class="body-back">
<s:form id="formList" name="formList" action="/core/versions/list.action" theme="simple" method="post">
<%@include file="/common/basic.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<fieldset >
<legend>{*[cn.myapps.core.versions.versions_info]*}</legend>
		<%
		out.print(VersionsUtil.toHTMLText());
		%>
</fieldset>
<fieldset >
<legend>{*[cn.myapps.core.versions.logs_info]*}</legend>
<div id="main" style="overflow-y:auto;overflow-x:hidden;">
<div class="navigation_title">{*[cn.myapps.core.versions.logs_info_list]*}</div>
	<div id="searchFormTable">
	<table width="100%">
		<tr>
			<td class="head-text">
			{*[cn.myapps.core.versions.version_name]*}:
			<input class="input-cmd" type="text" name="sm_version_name"
				value='<s:property value="#parameters['sm_version_name']"/>' size="10" />
			{*[cn.myapps.core.versions.type]*}:
			<s:select name="sm_type" value="%{#parameters.sm_type}"
				list="#{'':'','1':'{*[cn.myapps.core.versions.type_sourcecode_upgrade]*}','2':'{*[cn.myapps.core.versions.type_data_upgrade]*}'}" theme="simple" />
			<input class="button-cmd" type="submit"  value="{*[Query]*}" />
			<input class="button-cmd" type="button" value="{*[Reset]*}"
				onclick="resetQuery('sm_version_name');resetQuery('sm_type');" />
			</td>
			<td align="right">
				&nbsp;
			</td>
		</tr>
	</table>
	</div>
	<div id="contentTable">
	 <table class="table_noborder">
	   	<tr>
	   		<td class="column-head"><o:OrderTag field="version_name" css="ordertag">{*[cn.myapps.core.versions.version_name]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="version_number" css="ordertag">{*[cn.myapps.core.versions.version_number]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="type" css="ordertag">{*[cn.myapps.core.versions.type]*}</o:OrderTag></td>
			<td class="column-head" width="20%"><o:OrderTag field="upgrade_date" css="ordertag">{*[cn.myapps.core.versions.upgrade_date]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="remark" css="ordertag">{*[cn.myapps.core.versions.remark]*}</o:OrderTag></td>
		</tr> 
		<s:iterator value="datas.datas" status="index">
			<tr>
	  	 		<td>
	  	 			<s:property value="version_name" />
	  	 		</td>
	 			<td>
	 				<s:property value="version_number" />
	 			</td>
	 			<s:if test="type == 1">
	 				<td>{*[cn.myapps.core.versions.type_sourcecode_upgrade]*}</td>
	 			</s:if><s:elseif test="type == 2">
	 				<td>{*[cn.myapps.core.versions.type_data_upgrade]*}</td>
	 			</s:elseif><s:else>
	 				<td></td>
	 			</s:else>
	 			<td nowrap>
	 				<s:date name="upgrade_date" format="yyyy-MM-dd HH:mm:ss" />
	 			</td>
	 			<td>
	 				<s:property value="remark" />
	 			</td>
	 		</tr>
	    </s:iterator>
	</table>
	<table class="table_noborder">
	  <tr>
	    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
	  </tr>
	</table>
</div>
</div>
</fieldset>
</s:form>
</body>
</o:MultiLanguage></html>