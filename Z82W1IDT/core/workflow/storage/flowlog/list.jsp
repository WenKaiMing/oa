<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html><o:MultiLanguage>
<head>
<head>
<title>FlowLog</title>
<script src="<s:url value="/script/list.js"/>"></script>
</head>
<body>
<h3>FlowLog</h3>

<s:actionerror />
<s:form action="list">
<%@include file="/common/list.jsp"%>	
	<input type="image" alt="{*[New]*}"
		onclick="forms[0].action='<s:url action="new"/>'" />
	<input type="image" alt="{*[Delete]*}"
		onclick="forms[0].action='<s:url action="delete"/>'" />
	<table>
		<tr>
			<th><input type="checkbox" onclick="selectAll(this.checked)"></th>
			<th><o:OrderTag field="writername">writername</o:OrderTag></th>
		</tr>
		<s:iterator value="datas.datas">
			<tr>
				<td><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td><a
					href="<s:url action="edit">
							<s:param name="id" value="id"/>
							  <s:param name="ISEDIT" value="'FALSE'"/>
						  </s:url>">
				<s:property value="id" /></a></td>
			</tr>
		</s:iterator>
	</table>
	
</s:form>
</body>
</o:MultiLanguage></html>
