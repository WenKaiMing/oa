<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>OnlineUsers</title>
</head>

<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />

<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function change_pagelines(obj){
	document.getElementsByName("_pagelines")[0].value = obj.value;
	document.forms[0].submit();
}

function ev_refresh() {
	document.forms[0].submit();
}

function ev_exit(){
	document.forms[0].action = '<s:url value="/core/jamon/monitor.jsp"/>';
	document.forms[0].submit();
}
function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-80;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}
jQuery(document).ready(function(){
	cssListTable(); /*in list.js*/
	adjustDataIteratorSize();
});
</script>

<body>
<s:form action="/core/user/onlineUsersList.action" method="POST" theme="simple">
	<table class="table_noborder">
			<tr>
				<td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.onlineUsersList.online_users]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="ref_btn" style="width:70" class="button-image" onClick="ev_refresh()">
							<img src="<s:url value="/resource/imgnew/act/reset.gif"/>" align="top">{*[Refresh]*}</button>				
						<button type="button" class="button-image" style="width:60" onClick="ev_exit()">
							<img align="top" src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td>
			</tr>
	</table>
	<div id="main" style="overflow-y:auto;overflow-x:hidden;">
	  		<input type="hidden" name="_currpage" value='<s:property value="dpg.pageNo"/>' />
			<input type="hidden" name="_pagelines" value='<s:property value="dpg.linesPerPage"/>' />
			<input type="hidden" name="_rowcount" value='<s:property value="dpg.rowCount"/>' />
			<div>{*[cn.myapps.core.domain.onlineUsersList.online_count]*}: <span style='color:red;'><s:property value="dpg.rowCount"/></span>
					  &nbsp;&nbsp;&nbsp;{*[Domain]*}:
					  <s:select name="sm_domainid" list="#dh.getDomains()" listKey="id" listValue="name" theme="simple" emptyOption="false" onchange='submit()' />
					  &nbsp;&nbsp;&nbsp;{*[cn.myapps.core.domain.onlineUsersList.page_user_pageline]*}:
					  <s:select cssClass='input-cmd' id='perPageline' name="dpg.linesPerPage" list="#{10:'10',25:'25',50:'50',100:'100'}" onchange='change_pagelines(this)' />
			</div>
			<!-- 在线用户列表 -->
			<div id="contentTable">
			<table  class="table_noborder" border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[User_Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col">{*[Account]*}</td>
					<td class="column-head" scope="col">{*[Email]*}</td>
					<td class="column-head" scope="col">{*[Mobile]*}</td>
					<td class="column-head" scope="col"><o:OrderTag field="loginTime"
						css="ordertag">{*[cn.myapps.core.domain.onlineUsersList.page_user_pageline]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="dpg.datas" status="index">
					<tr>
					<td ><s:property value="name" /></td>
					<td ><s:property value="loginno" /></td>
					<td ><s:property value="email" /></td>
					<td ><s:property value="telephone" /></td>
					<td ><s:date name="loginTime" format="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="dpg"
					css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>