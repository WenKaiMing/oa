<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<o:MultiLanguage>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>{*[log.operation.log]*}</title>
		<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
		<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
		<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
		<script type="text/javascript">
			jQuery(document).ready(function(){
				window.top.toThisHelpPage("domain_log_info");
			});
			function doExit(){
				var contentform = document.getElementById("contentform");
				contentform.submit();
			}
		</script>
</head><s:bean name="cn.myapps.core.logger.action.LogHelper" id="logHelper" />
<body id="domain_fieldextends_info" class="contentBody">
<form id="contentform" action="list.action" method="post" >
	<div id="contentActDiv">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[log.operation.log]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="Back" title="{*[Back]*}" class="justForHelp button-image" onClick="doExit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Back]*}
					</button>
				</div>
			</td></tr>
	</table>
	</div>
	<!-- 信息提示 -->
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<%@include file="/common/basic.jsp" %>
	<div id="contentMainDiv" class="contentMainDiv" style="padding-top: 20px;">
		<table class="" border="0" width="90%" align="center">
			<tr>
				<td width="10%">{*[log.operator]*}:</td>
				<td width="40%" align="left"><s:property value="content.operator" /></td>
				<td width="10%">{*[Type]*}:</td>
				<td width="40%" align="left"><s:property value='content.type' /></td>
			</tr>
			<tr>
				<td width="10%">{*[Description]*}:</td>
				<td width="40%" align="left"><s:property value='content.description' /></td>
				<td width="10%">{*[Date]*}:</td>
				<td width="40%" align="left"><s:date name="content.date" format="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td width="10%">IP:</td>
				<td width="40%" align="left"><s:property value='content.ip' /></td>
				<td width="10%">&nbsp;</td>
				<td width="40%" align="left">&nbsp;</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
</o:MultiLanguage>