<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[SuperUser]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function reset(){
	var element=document.getElementsByName("_selects");
	for(var i=0;i<element.size();i++){
		if (element[i].checked){
			element[i].checked = false;
		}
	}
}

jQuery(document).ready(function(){
	cssListTable(); /*in list.js*/
	window.top.toThisHelpPage("domain_manager_list_addManager");	
});
</script>
</head>
<body class="listbody">
<s:form name="formList" action="addAdmin" method="post"  theme="simple">
	<%@include file="/common/basic.jsp" %>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table class="table_noborder">
		<tr>
		<td >
			<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.holdAdmin.administrator_list]*}</div>
		</td>
		<td>
			<div class="actbtndiv">
				<button type="button" class="button-image" onClick="forms[0].action='<s:url value="/core/domain/confirmAdmin.action"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Confirm]*}</button>
				<button type="button" class="button-image" onClick="reset();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Reset]*}</button>
				<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();"><img src="<s:url value='/resource/imgnew/act/act_10.gif'/>">{*[Exit]*}</button>
			</div>
		</td>
		</tr>
	</table>
	<div id="main">
		<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[User_Name]*}:	<input class="input-cmd" type="text" name="sm_name"	value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Account]*}:	<input class="input-cmd" type="text" name="sm_loginno" value='<s:property value="#parameters['sm_loginno']" />' size="10" />
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
						css="ordertag">{*[User_Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="loginno"
						css="ordertag">{*[Account]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="email"
						css="ordertag">{*[Email]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="email"
						css="ordertag">{*[cn.myapps.core.domain.holdAdmin.user_type]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="defaultDepartment"
						css="ordertag">{*[cn.myapps.core.domain.addAdmin.default_department]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
						<td class="table-td"><input type="checkbox" name="_selects"
							value="<s:property value="id"/>"></td>
						<td><s:property value="name" /></td>
						<td><s:property value="loginno" /></td>
						<td><s:property value="email" /></td>
					<s:if test="superAdmin==true">
						<td>{*[SuperAdmin]*}</td>
					</s:if>
					<s:if test="domainAdmin==true">
						<td>{*[DomainAdmin]*}</td>
					</s:if>
						<td><s:property value="defaultDepartment" /></td>
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
<script>
</script>
</body>
</o:MultiLanguage></html>
