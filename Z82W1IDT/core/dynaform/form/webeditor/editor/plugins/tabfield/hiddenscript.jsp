<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@include file="/common/tags.jsp" %>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<title>Hidden Script</title>

<STYLE type=text/css>
body, a, table, div, span, td, th, input, select{font:9pt;font-family: Arial,  "{*[SongTi]*}", Verdana,Helvetica, sans-serif;}
body {padding:5px}
.card {cursor:hand;background-color:#3A6EA5;text-align:center;}
table{
	border-color: #FFFFFF;
	border-collapse: collapse;
	background-image: none;
	border-top: 0px solid #FFFFFF;
}
table.content td {border-color:#000000;vertical-align:middle;cursor:hand;}
table.content {border-color:#000000;width:100%;}
</STYLE>
<script>
	function ev_ok() {
		var rtn = document.getElementsByName('hiddenScript')[0].value;
		if(rtn){
			OBPM.dialog.doReturn(rtn);
		}else{
			OBPM.dialog.doReturn(' ');
		}
		//window.returnValue = rtn;
		//window.close();
	}

	function ev_cancel() {
		OBPM.dialog.doExit();
  		//window.close();
	}
</script>
</head>
<body>
<form name="temp">	
	<table border=1 cellpadding=3 cellspacing=1 class="content">
	<tr>
		<td width="15%"><span id ="span"></span></td>
		<td width="85%"><textarea name="hiddenScript" cols="55" style="width:95%"  rows="10"></textarea>
		<!--  
		<button type="button" style="border:0px;cursor: pointer;" onclick="openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','','{*[Save]*}{*[Success]*}');"><img alt="Open with IscriptEditor" src="<s:url value='/resource/image/editor.png' />"/></button>
		-->
		</td>
	</tr>
	<tr align="center"><td colspan="12">
		<input type=button value="{*[OK]*}" onclick="ev_ok()">
		<input type=button value="{*[Cancel]*}" onclick="ev_cancel()">
		<input type="reset" value="{*[Clear]*}">
	</td></tr>
	</table>
</form>
</body>
	<script>
		var args = OBPM.dialog.getArgs();
		document.getElementsByName('hiddenScript')[0].value = args['value'];
		document.getElementById("span").innerHTML = args['title'];
	</script>
</o:MultiLanguage></html>