<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/common/tags.jsp"%>
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src='template.js'></script>
<link href="template.css" rel="stylesheet">
<style>
#form_id {
	height: 26px;
	width: 100%;
	background-image: url(<s:url value = '/resource/template/domain/frame_header.gif'/>);
	border: 0px solid #9dbae4;
	font-size: 12px;
	color: #3764a0;
	font-weight: bold;
	background-repeat: repeat-x;
	padding-right: 3px;
	padding-top: 4px;
}

#container {
	border: 1px solid #99bbe8;
	background-color: #f8f8f8;
	border-top: 1px solid #99bbe8;
}
</style>
</head>

<body class="body-front" style="overflow: auto">
<div id="container" style="ooverflow: hidden;">
   <div id="form_id" class="title">{*[myapps.homepage.default.iScript]*}[<a href="<s:url value="/help/front/welcome/index.jsp"/>">{*[Back]*}</a>]</div>
<div align="left">
	<table width="90%" height="100" border="0">
		<tr>
		    <td height="25" rowspan="25" valign="middle"><div align="center"><strong>&nbsp;{*[myapps.homepage.default.iScript]*}</strong></div></td>
		       <td height="25">&nbsp;Calendar View</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/Calendar View.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		          <td height="25" bgcolor="#e1f3fe">&nbsp;countNext(countLabel)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/countNext(countLabel).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		         <td height="25">&nbsp;countSubDocument</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/countSubDocument.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		           <td height="25" bgcolor="#e1f3fe">&nbsp;{*[myapps.homepage.default.iScript.number.function]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/DigitalFunction.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		          <td height="25">&nbsp;getOptionsByDQL</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getOptionsByDQL.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		          <td height="25" bgcolor="#e1f3fe">&nbsp;{*[myapps.homepage.default.iScript.roles_users_departments.id]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/RoleofuserdepartmentsID.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		         <td height="25">&nbsp;getDocProcess</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getDocProcess.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25" bgcolor="#e1f3fe">&nbsp;findDocument(docid)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/findDocument(docid).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25">&nbsp;getAllUsers()</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getAllUsers().html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25" bgcolor="#e1f3fe">&nbsp;getApplication()</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getApplication().html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25">&nbsp;getCurrentDocument()</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getCurrentDocument().html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25" bgcolor="#e1f3fe">&nbsp;getDepartmentsByParent(parent)getUsersByDptId(dptid)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getDepartmentsByParent(parent)getUsersByDptId(dptid).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25">&nbsp;getDocItemValue(docid, fieldName)</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getDocItemValue(docid, fieldName).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25" bgcolor="#e1f3fe">&nbsp;getItemValue(fieldName) {*[AND]*} countNext2</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getItemValue(fieldName)andcountNext2.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25">&nbsp;getItemValueAsString(fieldName)</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getItemValueAsString(fieldName).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25" bgcolor="#e1f3fe">&nbsp;getLastCount(countLabel)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getLastCount(countLabel).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25">&nbsp;getParentDocument</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getParentDocument.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		 <tr>
		       <td height="25" bgcolor="#e1f3fe">&nbsp;getUsersByDptIdAndRoleId(dptid,roleid)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getUsersByDptIdAndRoleId(dptid,roleid).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		       <td height="25">&nbsp;getUsersByRoleId(roleid)</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/getUsersByRoleId(roleid).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25" bgcolor="#e1f3fe">&nbsp;isNumberText(str)</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/isNumberText(str).html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25">&nbsp;queryByDQL</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/queryByDQL.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25" bgcolor="#e1f3fe">&nbsp;queryByDQLDomain</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/queryByDQLDomain.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td height="25">&nbsp;WEB.getParamsTable()</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/WEB.getParamsTable().html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
		    <tr>
		        <td bgcolor="#e1f3fe">&nbsp;{*[myapps.homepage.default.iScript.local.call.dll]*}</td>
			<td align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/calllocaldll.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
	</table>
</div>
</div>
</body>
</o:MultiLanguage>
</html>