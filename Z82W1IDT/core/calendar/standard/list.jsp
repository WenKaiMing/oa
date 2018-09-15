<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<title>{*[Working-weeks]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>

<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script type="text/javascript">

function viewDOC(docid) {
		var url = '<s:url value="/core/calendar/standard/edit.action"></s:url>';
		url += '?id=' + docid+'&_calendarid=<s:property value="_calendarid"/>&domain=<s:property value="#parameters.domain"/>';
		
		//var rtn = showframe('{*[Standard]*}', url);
	  	OBPM.dialog.show({
				opener:window.parent,
				width: 600,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.standard.list.working_weeks_info]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("domain_workCalendar_info_workWeek_list");
					document.forms[0].submit();
					OBPM.dialog.doRetrun(rtn);
				}
		});
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_workCalendar_info_workWeek_list");
});

</script>
<body style="margin-right:0px;">
<s:actionerror />
<s:form name="formList" action="list" method="post">
<%@include file="/common/basic.jsp"%>
<s:hidden name="_calendarid" ></s:hidden>
<table width="100%" height="30">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.domain.displayView.working-weeks_list]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
						&nbsp;
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
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
<%@include file="/portal/share/common/msgbox/msg.jsp"%>
</s:if>
<table class="list-table" border="0" cellpadding="1" cellspacing="1"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="calendar.name"
				css="ordertag">{*[cn.myapps.core.domain.calendarlist.calendar_name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="weekDays"
				css="ordertag">{*[Week]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="workingDayStatus"
				css="ordertag">{*[cn.myapps.core.domain.standard.list.runing]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="remark"
				css="ordertag">{*[Description]*}</o:OrderTag></td>
		</tr>
    <s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
		
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"/></td>
				<td><a
					href="javascript:viewDOC('<s:property value="id"/>')">{*[<s:property value="calendar.name" />]*}
				</a></td>
			<td>
			<s:if test="weekDays==0">
			    {*[Sunday]*}
			</s:if>
			<s:elseif test="weekDays==1">
				{*[Monday]*}
			</s:elseif>
			<s:elseif test="weekDays==2">
				{*[Tuesday]*}
			</s:elseif>
			<s:elseif test="weekDays==3">
				{*[Wednesday]*}
			</s:elseif>
			<s:elseif test="weekDays==4">
				{*[Thursday]*}
			</s:elseif>
			<s:elseif test="weekDays==5">
				{*[Friday]*}
			</s:elseif>
			<s:elseif test="weekDays==6">
				{*[Saturday]*}
			</s:elseif>
			</td>
			<td>
			<s:if test="workingDayStatus=='01'">
				{*[Working-day]*}
			</s:if>
			<s:elseif test="workingDayStatus=='02'">
				{*[Day-off]*}
			</s:elseif>
			</td>
			<td><s:property value="remark" /></td>
			</tr>
		</s:iterator>
	</table>
 
</s:form>

</body>

</o:MultiLanguage></html>

