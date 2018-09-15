<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<title>{*[cn.myapps.core.report.crossreport.list]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

	jQuery(document).ready(function(){
		window.onload();
		cssListTable();
		window.top.toThisHelpPage("application_module_crossReport_list");
	});
</script>
</head>
<body id="application_module_crossReport_list" class="body-back">
<s:form name="formList" theme="simple" action="list" method="post">
<%@include file="/common/list.jsp"%>
<s:hidden name="module" value="%{#parameters.module}"/>
<s:hidden name="sm_module" value="%{#parameters.module}"/>
<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr>
		<td class="nav-s-td">{*[cn.myapps.core.report.crossreport.name]*}</td>
		<td class="nav-s-td" align="right">
		<table width="120" align="right" border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td width="60" valign="top">
					<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
				</td>
				<td  valign="top">
					<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div id="main">
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="searchFormTable">
	<table>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />'
				size="10" /></td>

			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetQuery()"/></td>
		</tr>
	</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Name]*}</o:OrderTag></td>
				</tr>
			<s:iterator value="datas.datas" status="index">
				<s:if test="type=='CrossReport'">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
					<td><a
						href='<s:url action="edit">
						<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
						<s:param name="application" value="#parameters.application" />
						<s:param name="module" value="#parameters.module" />
						<s:param name="id" value="id"/>
						<s:param name="sm_name" value="#parameters.sm_name"/>
						</s:url>'>
						<s:property	value="name" /></a></td>
					</tr>
				</s:if>
			</s:iterator>
		</table>
		<table class="table_noborder" >
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>
