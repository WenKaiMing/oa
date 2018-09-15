<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src='template.js'></script>
<link href="template.css" rel="stylesheet">
<style>
#form {
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


<body class="body-front">
<div id="container">
   <div id="form" class="title">{*[New]*}{*[Form]*}[<a href="<s:url value="/help/front/template/index_developers.jsp"/>">{*[Back]*}</a>]</div>
<div align="left">
	<table width="90%" height="200" border="0">
		<tr>
			<td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[myapps.homepage.default.create.form.fatherchildform]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/Fatherchildform.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" >&nbsp;　　　　 - {*[Mapping]*}{*[Form]*}</td>
			<td height="25" align="center" valign="middle" >&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/mappingform.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
			<td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[myapps.homepage.default.create.form.formactive]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/formactivefront.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" >&nbsp;　　　　 - {*[myapps.homepage.default.create.form.formcount]*}</td>
			<td height="25" align="center" valign="middle" >&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/formcount.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[Validate_Script]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/formverify.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" >&nbsp;　　　　 - {*[myapps.homepage.default.create.form.tabsform]*}</td>
			<td height="25" align="center" valign="middle" >&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/tabsform.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[Validate_Libraries]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/verify.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	</table>
</div>
</div>
</body>
</o:MultiLanguage>
</html>