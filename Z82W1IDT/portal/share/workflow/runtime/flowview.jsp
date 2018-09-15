<%@ page language="java" contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
	String docid = request.getParameter("_docid");
	String instanceId = request.getParameter("_instanceId");
	String contextPath = request.getContextPath();

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
table {
	font-size: 12px;
}
</style>
<script type="text/javascript">
function ev_onload() {
	OBPM.dialog.resize(document.body.scrollWidth+20, document.body.scrollHeight+70);
	
	var frameContent = parent.document.getElementById("FrameContent");
	if (frameContent) {
		frameContent.style.width = document.body.scrollWidth;
		frameContent.style.height = document.body.scrollHeight;
	}
}

</script>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">  
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><%=request.getParameter("title")%></title>

	</head>
	<body onload="ev_onload()">
	<table>
		<tr>
			<td>{*[Caption]*}：</td>
			<td><div>1、<font color="red"><b>{*[core.workflow.storage.runtime.view.RedLine]*}</b></font>{*[core.workflow.storage.runtime.view.currentNode]*}；2、<font
				color="green"><b>{*[core.workflow.storage.runtime.view.GreenLine]*}</b></font>{*[core.workflow.storage.runtime.view.processedLine]*}；3、<b>{*[core.workflow.storage.runtime.view.BlackLine]*}</b>
				{*[core.workflow.storage.runtime.view.processingLine]*}；</div></td>
		</tr>
		<tr>
			<td></td><td><div>4、<span style="background-color:yellow;"><b>{*[core.workflow.storage.runtime.view.YellowBackground]*}</b>
				</span>{*[core.workflow.storage.runtime.view.workflowTerminated]*}。</div></td>
		</tr>
	</table>
	<img name="flowImg"
		src="<%= "../../../uploads/billflow/" + instanceId +  ".jpg" %>
		?tempid=<%=Math.random()%> "/>
	</body>

</o:MultiLanguage>
</html>
