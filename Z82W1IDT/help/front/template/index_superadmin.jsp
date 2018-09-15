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
#domain_id {
	height: 26px;
	width: 100%;
	background-image: url(<s:url value = '/resource/template/frame_header.gif'/>);
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
   <div id="domain_id" class="title">{*[SuperAdmin]*}[<a href="<s:url value="/help/front/welcome/index.jsp"/>">{*[Back]*}</a>]</div>
<div align="left">
	<table width="90%" height="100" border="0">
		 <tr>
	     	<td width="121" height="25" rowspan="4" align="center" valign="middle">&nbsp;
	       		<div align="center"><strong>{*[SuperAdmin]*}</strong></div>
	       	</td>
		    <td width="438" height="25" >&nbsp;{*[New]*}{*[Developer]*}</td>
			<td width="119" height="25" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/createDeveloper.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
	     <tr>
		    <td height="25" bgcolor="#e1f3fe">&nbsp;{*[New]*}{*[DomainAdmin]*}</td>
			<td height="0" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/createDomainAdmin.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
		 </tr>
	     <tr>
		    <td height="25">&nbsp;Debug</td>
			<td height="0" align="center" valign="middle">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/debugMacro.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
	     </tr>
	     <tr>
		    <td height="25" bgcolor="#e1f3fe">&nbsp;{*[Flex_Print]*}</td>
			<td height="0" align="center" valign="middle" bgcolor="#e1f3fe">&nbsp;<img src="../../../resource/template/arrow_002.gif" > <a href="../../flash/DynamicPrint.html" target="flashWindow">{*[myapps.homepage.default.click.demo]*}<a></td>
	     </tr>
		<!-- tr>
			<td rowspan="2" onmouseover="this.className='table-tr-onchange';"  width="70" onmouseout="this.className='table-tr';"><img alt="新建域"
				src="<s:url value='/resource/template/superadmin/superadmin_01.gif'/>"></td>
			<td>新建开发者<br><font style="font-weight: normal;font-size: 12px;">新建专属创建应用<br>软件的工作帐号</font></td>
			<td rowspan="2" onmouseover="this.className='table-tr-onchange';" width="70" onmouseout="this.className='table-tr';"><img alt="新建域组织架构"
				src="<s:url value='/resource/template/superadmin/superadmin_02.gif'/>"</td>
			<td>新建域管理员<br><font style="font-weight: normal;font-size: 12px;">用于专属管理企<br>业员工帐号的工作者</font></td>
		</tr>
		<tr>
			<td><a href="javascript:opens('../../flash/createDeveloper.html')">演示</a></td>
			<td><a href="javascript:opens('../../flash/createDomainAdmin.html')">演示</a></td>
		</tr> -->
	</table>
</div>
</div>

</body>
</o:MultiLanguage>
</html>