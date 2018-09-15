<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.domain.special.list.special_day]*}</title>
	<script src="<s:url value="/script/list.js"/>"></script>

	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	</head>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
	<script type="text/javascript">
function viewDOC(docid) {
		wx = '700px';
	    wy = '500px';  
		var url = '<s:url value="/core/calendar/special/edit.action"></s:url>' ;
		url += '?id=' + docid+'&_calendarid=<s:property value="_calendarid"/>&domain=<s:property value="#parameters.domain"/>';
		
	  	OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.special.list.title.edit_special_day]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("domain_workCalendar_info_exceptionDay_list");
			  		document.forms[0].submit();
			  		OBPM.dialog.doRetrun(rtn);
				  		//window.returnValue = rtn;
				}
		});
}

wx = '700px';
wy = '500px';
function createView(){

      var url = '<s:url value="/core/calendar/special/new.action"/>' + '?domain=' + '<%=request.getParameter("domain")%>' + '&_calendarid=' + '<%=request.getParameter("_calendarid")%>';

	  OBPM.dialog.show({
		  		opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.special.list.new_special_day]*}',
				close: function(rtn) {
				  	window.top.toThisHelpPage("domain_workCalendar_info_exceptionDay_list");
			  		document.forms[0].submit();
			  		OBPM.dialog.doRetrun(rtn);
				}
		});
}

function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	window.returnValue='1';
    	listform.submit();
    }
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_workCalendar_info_exceptionDay_list");
});
</script>
	<body style="margin-right:0px">
	<s:form name="formList" action="list" method="post">
		<%@include file="/common/basic.jsp"%>
		<s:hidden name="_calendarid"/>
		<table width="100%" height="30">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.domain.special.list.special_day]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
					<button type="button" class="button-image" onClick="createView();"><img
							src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					</td>
					<td width="60" valign="top">
						<button type="button" class="button-image"
							onClick="doDelete()"><img
							src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
					<td class="column-head" scope="col"><o:OrderTag
						field="calendar.name" css="ordertag">{*[cn.myapps.core.domain.calendarlist.calendar_name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="startDate" css="ordertag">{*[cn.myapps.core.domain.special.list.start_date]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="endDate" css="ordertag">{*[cn.myapps.core.domain.special.list.end_date]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="workingDayStatus" css="ordertag">{*[cn.myapps.core.domain.standard.list.runing]*}</o:OrderTag></td>
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
						value="<s:property value="id" />"></td>
					<td><a href="javascript:viewDOC('<s:property value="id"/>')">{*[<s:property
						value="calendar.name" />]*} </a></td>

					<td><s:date name="startDate" format="yyyy-MM-dd HH:mm" /></td>
					<td><s:date name="endDate" format="yyyy-MM-dd HH:mm" /></td>
					<td><s:if test="workingDayStatus=='01'">
				{*[Working-day]*}
			</s:if> <s:elseif test="workingDayStatus=='02'">
				{*[Day-off]*}
			</s:elseif></td>
					<td><s:property value="remark" /></td>
					</tr>
				</s:iterator>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" class="pagenav"><o:PageNavigation
						dpName="datas" css="linktag" /></td>
				</tr>
			</table>
			</s:form>
	</body>
</o:MultiLanguage>
</html>
