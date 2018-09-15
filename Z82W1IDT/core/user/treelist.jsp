<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[User]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"><s:param name="id" value="#parameters.id" /></s:url>';
    	listform.submit();
    }
}
</script>
</head>
<body class="body-back">

<s:form name="formList" action="treelist" method="post">
	<%@include file="/common/basic.jsp" %>

<!--  顶栏-->
<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr>
		<td class="nav-s-td">{*[User_List]*}</td>
		<td class="nav-s-td" align="right">
		<table align="right" width="120" border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top">
					<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="new"><s:param name="domain" value="#parameters.id" /></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
				</td>
				<td valign="top">
					<button type="button" class="button-image"
					onClick="doDelete()"><img
					src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
	
	<!-- 新增用户 -->
	<table>
		<tr>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name"
				value='<s:property value="#parameters.sm_name" />' size="10" /></td>
			<td class="head-text">{*[Account]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_loginno"
				value='<s:property value="#parameters.sm_loginno" />' size="10" /></td>
			<td class="head-text">{*[Role]*}:</td>
			<td><s:select cssClass="input-cmd" theme="simple" value="#parameters['sm_userRoleSets.roleId']"
					label="{*[Role]*}" name="sm_userRoleSets.roleId" list="_softRoles" emptyOption="true" 
					/>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" /></td>					
			</td>
		<tr>
	</table>
	
	<!-- 用户列表 -->
	<table class="list-table" border="0" cellpadding="2" cellspacing="2"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="loginno"
				css="ordertag">{*[Account]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="email"
				css="ordertag">{*[Email]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="telephone"
				css="ordertag">{*[Mobile]*}</o:OrderTag></td>
			<td class="column-head" scope="col">{*[Department]*}</td>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id"/>"></td>
			<td><a
				href="javascript:document.forms[0].action='<s:url action="edit">
				<s:param name="id" value="id"/></s:url>';
				document.forms[0].submit();">
				<s:property value="name" /></a></td>
			<td><s:property value="loginno" /></td>
			<td><s:property value="email" /></td>
			<td><s:property value="telephone"/></td>
			<td><s:iterator value="departments" status="index">
              <s:property value="name"/><s:if test="!#index.last">&nbsp;&nbsp;|&nbsp;&nbsp;</s:if>			
			</s:iterator></td>
			</tr>
		</s:iterator>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
	<div>
</s:form>
<script>
</script>
</body>
</o:MultiLanguage></html>
