<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/common/tags.jsp"%>
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src='template.js'></script>
<link href="template.css" rel="stylesheet">
<style>
#demo {
	height: 26px;
	width: 100%;
	padding-right:0px;
	background-image: url(<s:url value ='/resource/template/domain/frame_header.gif'/>);
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
<div id="container" >
   <div id="demo" class="title">{*[New]*}{*[Flow]*}[<a href="<s:url value="/help/front/template/index_developers.jsp"/>">{*[Back]*}</a>]</div>
<div align="left">
	<table width="90%" height="200" border="0">
		<tr>
			<td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[Branch]*}{*[Flow]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/branch flow.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
		<tr>
		    <td height="25" >&nbsp;　　　　 - {*[SubFlow]*}</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/sub process.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" bgcolor="#e1f3fe">&nbsp;　　　　 - {*[myapps.homepage.default.create.flow.repeat]*}</td>
			<td height="25" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/repeat.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	    <tr>
		    <td height="25" >&nbsp;　　　　 - {*[myapps.homepage.default.create.flow.free]*}</td>
			<td height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/free flow.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		</tr>
	</table>
</div>
</div>

</body>
</o:MultiLanguage>
</html>