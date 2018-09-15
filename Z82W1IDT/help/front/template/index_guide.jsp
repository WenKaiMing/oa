<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<o:MultiLanguage>
<head>
<title>{*[Wizard]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src='template.js'></script>
<link href="template.css" rel="stylesheet">
<style>
#domain {
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
   <div id="domain" class="title">{*[Wizard]*}[<a href="<s:url value="/help/front/welcome/index.jsp"/>">{*[Back]*}</a>]</div>
<div align="left">
	<table width="90%" height="30" border="0">
		<tr>
	        <td width="121" height="25" rowspan="1" align="center" valign="middle">&nbsp;
    		<div align="center"><strong>{*[Wizard]*}</strong></div></td>
	    	<td height="25">&nbsp;{*[myapps.homepage.default.create.system.within.ten.min]*}</td>
			<td height="0" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/guide.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
     	</tr>
	</table>
</div>
</div>
</body>
</o:MultiLanguage>
</html>