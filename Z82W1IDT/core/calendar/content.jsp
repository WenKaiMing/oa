<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.content.title.new_calendar]*}</title>
	<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
		<s:param name ="domain" value="#parameters.domain"/>
	</s:bean>		
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"	type="text/css">
	<script language="javascript">
		function submit(){ 
			document.forms[0].submit();
			//OBPM.dialog.doReturn('<s:property value="content.id" />');
		}
		function init(){
			window.returnValue = document.getElementById("cldid").value;
			var contentid = jQuery("#contentid").val();
			if (contentid != "") {
				jQuery("#cldid").attr("disabled", "disabled");
			}
		}
	</script>
</head>

<body class="body-back" onload="init();" style="width: 95%;">
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Working-weeks]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" class="button-image" onClick="submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();"><img	src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
    <%@include file="/portal/share/common/msgbox/msg.jsp"%>
    </s:if>
	<div id="contentMainDiv" class="contentMainDiv" style="padding: 20px;">		
		<table class="id1" width="100%">
			<s:form action="save" method="post">
			<s:hidden name="content.id" id="contentid" />
			<s:hidden name="content.type" />
			<s:hidden name="content.workingTime" />
			<s:hidden name="content.domainid" />
			<%@include file="/common/basic.jsp"%>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td width="10%">{*[cn.myapps.core.domain.content.from_calendar]*}:</td>
					<td align="left" width="20%">
						<s:select id="cldid" theme="simple" name="_calendarid" list="#ch.getWorkCalendars()"/>
					</td>
					<td width="30%" align="right">{*[cn.myapps.core.domain.content.copy_to]*}&nbsp;&nbsp;&nbsp;&nbsp;{*[cn.myapps.core.domain.content.new-calendar-name]*}:</td>
					<td align="left">
						<input size="20" name="content.name" class="input-cmd" value="{*[<s:property value="content.name" />]*}" />
					</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td>{*[Description]*}:</td>
					<td align="left" colspan="3">
						<textarea rows="4" cols="50" id="remark" class="input-cmd" name="content.remark">{*[<s:property value="content.remark" />]*}</textarea>
					</td>
				</tr>
			</s:form>
		</table>
	</div>
</body>
</o:MultiLanguage></html>