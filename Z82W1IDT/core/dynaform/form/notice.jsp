<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
<HTML>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
</script>
<title>{*[Notice]*}</title>
</head>
<body>
<s:if test="confirms.size() > 0">
<% 
	boolean flag = true;
%>
<div align="center">{*[fix.errores.save.again]*}!</div>
	<table width="100%" class="display_view-table">
		<tr class="column-head">
			<th>{*[Level]*}</th>
			<th>{*[Description]*}</th>
		</tr>
		<s:iterator value="confirms" status="row">
		<s:if test="#row.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
		</s:else>
			<s:if test="msgKeyCode == 3">
				<td style="color: #FF8800">{*[Warn]*}</td>
				<td><s:property value="message" /></td>
			</s:if>
			<s:else>
				<td style="color: #FF0000">{*[Error]*}</td>
				<td><s:property value="message" /></td>
				<% 
					flag = false; 
				%>
			</s:else>
		</tr>
		</s:iterator>
		
		<tr>
			<td colspan="3" height="20px">
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<% 
					if (flag) {
				%>
				<button type="button" id="notice_btn_ok">{*[OK]*}</button>
				<% 
					}
				%>
				<button type="button" id="notice_btn_back">{*[Back]*}</button>
			</td>
		</tr>
		
	</table>	
</s:if>
</body>
</o:MultiLanguage>
</html>