<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.addApp.all_applications]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>

<script>

function ev_submit() {
	document.forms[0].action='<s:url action="confirm"></s:url>';
	document.forms[0].submit();
}

function reset(){
	var element=document.getElementsByName("_selects");
	for(var i=0;i<element.size();i++){
		if (element[i].checked){
			element[i].checked = false;
		}
	}
}
jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("domain_application_list_addApplication");
});

</script>

<body id="application_list" class="listbody">
<s:actionerror />
<s:form name="formList" action="addApp" method="post">
<%@include file="/common/basic.jsp" %>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.holdApp.application_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="ev_submit()"><img	src="<s:url value='/resource/imgnew/act/act_4.gif'/>" />{*[Confirm]*}</button>
					<button type="button" class="button-image" onClick="reset();"><img src="<s:url value='/resource/imgnew/act/act_10.gif'/>">{*[Reset]*}</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();"><img src="<s:url value='/resource/imgnew/act/act_10.gif'/>">{*[Exit]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
		<div id="searchFormTable">
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[cn.myapps.core.domain.holdApp.application_name]*}:	<input class="input-cmd" type="text" name="sm_name"	value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Description]*}:	<input class="input-cmd" type="text" name="sm_description" value='<s:property value="#parameters['sm_description']" />' size="10" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				<tr><td>
			</table>
		</div>
		<div id="contentTable">
			<table>
				<s:if test="hasFieldErrors()">
					<span class="errorMessage"><br>
					<s:iterator value="fieldErrors">
					</s:iterator> </span>
				</s:if>
				<table class="table_noborder">
					<tr>
						<td class="column-head2" scope="col"><input type="checkbox"
							onclick="selectAll(this.checked)"></td>
						<td class="column-head" scope="col"><o:OrderTag field="name"
							css="ordertag">{*[cn.myapps.core.domain.holdApp.application_name]*}</o:OrderTag></td>
						<td class="column-head" scope="col"><o:OrderTag
							field="description" css="ordertag">{*[Description]*}</o:OrderTag></td>
						<td class="column-head" scope="col"><o:OrderTag
							field="activated" css="ordertag">{*[State]*}</o:OrderTag></td>
					</tr>
					<s:iterator value="datas.datas" status="index">
						<tr>
						<td class="table-td"><input type="checkbox" name="_selects"
							value="<s:property value="id" />"></td>
						<td><s:property value="name" /></td>
						<td><s:property value="description.length()>40?description.substring(0,40)+'...':description" /></td>
						<td>
							<s:if test="activated">
								{*[cn.myapps.core.domain.holdApp.activation]*}
							</s:if>
							<s:elseif test="!activated">
								{*[cn.myapps.core.domain.holdApp.disable]*}
							</s:elseif>
						</td>
						</tr>
					</s:iterator>
				</table>
				<table class="table_noborder">
					<tr>
						<td align="right" class="pagenav"><o:PageNavigation
							dpName="datas" css="linktag" /></td>
					</tr>
				</table>
			</table>
		</div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
