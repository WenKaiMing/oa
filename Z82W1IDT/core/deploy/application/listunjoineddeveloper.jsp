<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/util.js"/>'></script>
<title>{*[cn.myapps.core.deploy.application.unjoined_developer]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script>
function confirm(){
	document.forms[0].action='<s:url value="/core/deploy/application/addDeveloper.action"></s:url>';
	document.forms[0].submit();
}

jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("application_info_advancedTools_developer_list_addDeveloper");
});
</script>
</head>
<body style="margin: 0;padding: 0;overflow:auto;padding-top: 5px;width: 98%;">
<s:form name="formList" action="listUnjoinedDeveloper" method="post">
	<s:hidden name="id" value="%{#parameters.id}"/>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.deploy.application.developer_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="confirm()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Add]*}
					</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">
						<img src="<s:url value="/resource/imgnew/act/act_9.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
	</table>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="main">
		<%@include file="/common/basic.jsp" %>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.deploy.application.search_form]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Account]*}:<input class="input-cmd" type="text" name="sm_loginno" value='<s:property value="#parameters['sm_loginno']" />' size="10" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				<tr><td>
			</table>
		</div>
		<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Name]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="loginno"
					css="ordertag">{*[Account]*}</o:OrderTag></td>
				<td class="column-head" scope="col"><o:OrderTag field="email"
					css="ordertag">{*[Email]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td>
					<s:property value="name" /></td>
				<td><s:property value="loginno" /></td>
				<td><s:property value="email" /></td>
				</tr>
			</s:iterator>
		</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav">
				<o:PageNavigation dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
