<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
String contextPath = request.getContextPath();
%>
<html:html>
<head>
<title>{*[Edit information]*} </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/css/css.jsp" type="text/css">
<script src="<%= contextPath %>/js/billitem.js"></script>
<script src="<%= contextPath %>/js/check.js"></script>
<script src="<%= contextPath %>/js/util.js"></script>

<script language="JavaScript">
var contextPath = '<%= contextPath %>';

cmdSave = '/dynaform/form/savejs.do';

function ev_checkval() {
  return true;
}

// {*[On tab click]*}
function cardClick(cardID){
	var obj;
	for (var i=1;i<6;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<6;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

</script>

</HEAD>

<BODY>
<html:form action="/dynaform/form/savejs.do" styleId="formItem" method="post">
<html:hidden property="id"/>
<html:hidden property="name"/>
<html:hidden property="type"/>
<html:hidden property="discript"/>
<html:hidden property="ewebcontent"/>
<html:hidden property="channelid"/>
<html:hidden property="templateid"/>
<html:hidden property="ischange"/>
<html:hidden property="siteid"/>
<html:hidden property="pagecss"/>
<html:hidden property="pagetitle"/>
<table border=0 cellpadding=0 cellspacing=0 width="100%">
   <tr><td align="right" height="30">
    		<input type="button"  class="bt-enter" onclick="doSave()" value="{*[OK]*}">
    		<input type="button" class="bt-cancel" onclick="window.close()" value="{*[Cancel]*}">
    </td></tr>
<tr valign=top><td>

<table border=0 cellpadding=3 cellspacing=0 width="100%">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Script bef open]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(2)" id="card2">{*[Script aft open]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(3)" id="card3">{*[Script bef save]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Script aft save]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Script for exit]*}</td>
	<td width=2></td>
</tr>

<tr>
	<td bgcolor=#ffffff align=center valign=middle colspan=10>

 <table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd" id="content1">
	<tr>
		<td bgcolor="#FFFFFF" width="15%">{*[Script bef open]*}</td>
		<td bgcolor="#FFFFFF" width="85%"><html:textarea styleClass="input-area" property="beforopenscript" cols="40"  rows="15"/></td>
	</tr>
	</table>
	<table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd" id="content2">
	<tr>
		<td bgcolor="#FFFFFF" width="15%">{*[Script aft open]*}</td>
		<td bgcolor="#FFFFFF" width="85%"><html:textarea styleClass="input-area" property="afteropenscript" cols="40"  rows="15"/></td>
	</tr>
	</table>
	<table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd" id="content3">
	<tr>
		<td bgcolor="#FFFFFF" width="15%">{*[Script bef save]*}</td>
		<td bgcolor="#FFFFFF" width="85%"><html:textarea styleClass="input-area" property="beforsavescript" cols="40"  rows="15"/></td>
	</tr>
	</table>
	<table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd" id="content4">
	<tr>
		<td bgcolor="#FFFFFF" width="15%">{*[Script aft save]*}</td>
		<td bgcolor="#FFFFFF" width="85%"><html:textarea styleClass="input-area" property="aftersavescript" cols="40"  rows="15"/></td>
	</tr>
	</table>
	<table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd" id="content5">
	<tr>
		<td bgcolor="#FFFFFF" width="15%">{*[Script for exit]*}</td>
		<td bgcolor="#FFFFFF" width="85%"><html:textarea styleClass="input-area" property="onexitscript" cols="40"  rows="15"/></td>
	</tr>
	</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>
</html:form>

<script language=javascript>
cardClick(1);
<c:if test="${!empty requestScope.SAVESUCCESS and requestScope.SAVESUCCESS eq 'true'}">
	window.close();
</c:if>

</script>

</body>
</html:html>
