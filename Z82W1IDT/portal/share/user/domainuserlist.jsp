<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path=request.getContextPath();
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[User]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script>
	function doReturn() {
	  var sis = document.getElementsByName("_selects");
	  var rtn = new Array();
	  var p = 0;
	
	  if (sis.length != null) {
		  for (var i=0; i<sis.length; i++) {
		    var e = sis[i];
		    if (e.type == 'checkbox') {
		      if (e.checked && e.value) {
		        rtn[p++] = e.value;
		      }
		    }
		  }
	  }
	  else {
	    var e = sis;
	    if (e.type == 'checkbox') {
	      if (e.checked && e.value) {
	        rtn[p++] = e.value;
	      }
	    }
	  }
	  OBPM.dialog.doReturn(rtn.toString());
	}

	jQuery(document).ready(function(){
		OBPM.dialog.resize(jQuery(window).width()+20, jQuery(window).height()+75);
	});

</script>
</head>
<body align="left">
<s:form name="formList" action="listuser" method="post">
	<%@include file="/common/basic.jsp" %>
<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[User_List]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
						<button type="button" class="button-image"
						onClick="doReturn();"><img
						src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Confirm]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
</table>
	
	<table>
		<tr>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name"
				value='<s:property value="#parameters['sm_name']" />' size="10" /></td>
			<td class="head-text">{*[Account]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_loginno"
				value='<s:property value="#parameters['sm_loginno']" />' size="10" /></td>
			<td class="head-text">{*[Department]*}:</td>
			<td><s:select cssClass="input-cmd" theme="simple" value="#parameters['sm_userDepartmentSets.departmentId']"
					label="%{getText('core.user.department')}" name="sm_userDepartmentSets.departmentId"
					list="_departmentTree" emptyOption="true" />
			<td class="head-text">{*[Role]*}:</td>
			<td><s:select cssClass="input-cmd" theme="simple" value="#parameters['sm_userRoleSets.roleId']"
					label="{*[Role]*}" name="sm_userRoleSets.roleId" list="_domainOfRoles" emptyOption="true" 
					listKey="id" listValue="name"/>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" /></td>					
			</td>
		<tr>
	</table>
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
			<td><s:property value="name" /></td>
			<td><s:property value="loginno" /></td>
			<td><s:property value="email" /></td>
			<td><s:property value="telephone" /></td>
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
