<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<title>JavaScript Console</title>
	<LINK title=Style href="css/style.css" type=text/css rel=stylesheet>
	<LINK title=Style href="css/style-ie.css" type=text/css rel=stylesheet>
	<link rel="stylesheet" href="<s:url value='/resource/css/style.jsp'/>" />

	<script src='<s:url value="/dwr/interface/DebugGui.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	
	<% 
		String sessionId = request.getSession().getId();
	%>
	<script type="text/javascript">
		var url = "log.jsp?sessionId=<%=sessionId %>";
		
		function refresh() {
			var logEl = window.frames["log"];
			logEl.location.href = url;
		}
		
		function clearLog() {
			var clearUrl = url + "&clear=true";
			var logEl = window.frames["log"];
			logEl.location.href = clearUrl;
		}
	</script>
	<style>
	button {
		border: 0px solid white;
		background-color: #dfe8f6;
		vertical-align: middle;
		height: 20px;
		line-height: 20px;
		cursor: pointer;
	}
	</style>
	</head>
	
	<body style="overflow: hidden" class="body-front">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="act_table">
		<tr>
			<td>
				<button type="button" name='refresh' value='Refresh' onclick='refresh()'><img
					src="<s:url value='/resource/imgv2/back/debugger/refresh.gif'/>" />{*[Refresh]*}</button>
				<button type="button" name='clear' value='Clear' onclick='clearLog()'><img
					src="<s:url value='/resource/imgv2/back/debugger/clear.gif'/>" />{*[Clear]*}</button>
			</td>	
		</tr>
		<tr>
			<td>
				<iframe id="log" name="log" src="log.jsp?sessionId=<%=sessionId %>" scrolling="yes"  style="width: 100%;height: 600px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>

	</body>
</o:MultiLanguage>
</html>
