<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<title>{*[cn.myapps.core.domain.holdAdmin.administrator_list]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/generic.js"/>"></script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>

<script>
function showUsers() {
	var url='<s:url value="/core/domain/addAdmin.action"></s:url>?domain=<%=request.getParameter("domain")%>';
	OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.holdAdmin.title.add_administrator]*}',
				close: function(rtn) {
					if(rtn=="success"){
						document.forms[0].submit();
					}
					window.top.toThisHelpPage("domain_manager_list");
				}
		});
}

function removeUsers() {
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		document.forms[0].action='<s:url action="removeAdmin"></s:url>';
		document.forms[0].submit();
    }
}

jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("domain_manager_list");
});

</script>
</head>
<body id="domain_manager_list" class="listbody">
<div>
<s:form name="formList" theme="simple" action="holdAdmin" method="post">
	<%@include file="/common/basic.jsp" %>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.holdAdmin.administrator_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="Add_Administrator" title="{*[cn.myapps.core.domain.holdAdmin.title.add_administrator]*}" class="justForHelp button-image" onClick="showUsers()"><img src="<s:url value="/resource/imgnew/add.gif"/>">{*[Add]*}</button>
					<button type="button" id="Remove_Application" title="{*[cn.myapps.core.domain.holdApp.title.add_application]*}" class="justForHelp button-image" onClick="removeUsers()"><img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Remove]*}</button>
				</div>
			</td></tr>
	</table>
<div id="main">
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.holdAdmin.title.search_administrator]*}">
		<table class="table_noborder">
			<tr><td class="head-text">
				{*[Name]*}:	<input pid="searchFormTable" title="{*[cn.myapps.core.domain.holdAdmin.title.by_administrator_name]*}" class="justForHelp input-cmd" type="text" name="sm_name" id="sm_name" value='<s:property value="#parameters['sm_name']"/>' size="30" />
				<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.holdAdmin.title.search_administrator]*}" class="justForHelp button-cmd" type="submit" value="{*[Query]*}" />
				<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/>
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
			<td class="column-head" scope="col">{*[cn.myapps.core.domain.holdAdmin.user_type]*}</td>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<tr>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id"/>"></td>
			<td><s:property value="name" /></td>
			<td><s:property value="loginno" /></td>
			<td><s:property value="email" /></td>
			<td>
			<s:if test="superAdmin">
				{*[SuperAdmin]*}
			</s:if>
			<s:else>
				<s:if test="domainAdmin">
					{*[DomainAdmin]*}
					<s:if test="developer">
					 & {*[Developer]*}
					</s:if>
				</s:if>
				<s:elseif test="developer">
					{*[Developer]*}
				</s:elseif>
			</s:else>
			</td>
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
</div>
</s:form>
</div>
<script>
</script>
</body>
</o:MultiLanguage></html>
