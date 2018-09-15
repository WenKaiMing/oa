<%@ page contentType="text/html; charset=UTF-8"%>
<%@page buffer="50kb"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/smartweb" prefix="s" %>
<%
String contextPath = request.getContextPath();
String isnew = request.getParameter("ISNEW");
String edit = request.getParameter("ISEDIT");
boolean isedit = edit!=null&&edit.trim().equalsIgnoreCase("TRUE");

String id = request.getParameter("id");
String docid = request.getParameter("docid");
String name = request.getParameter("name");
%>
<html:html>
<head>
<title>{*[Manuscript editor]*} </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/css/info.css" type="text/css">
<script src="<%= contextPath %>/js/billitem.js"></script>
<script src="<%= contextPath %>/js/check.js"></script>
<script src="<%= contextPath %>/js/util.js"></script>
<script language="JavaScript">
<!--
var contextPath = '<%=contextPath %>';
var hoststr = 'http://'+window.location.host+'/';
function ev_save() {
	var cmdSavefiles = hoststr+'<%= contextPath %>/dynaform/document/saveitem.do?id=<%=id%>&docid=<%=docid%>&name=<%=name%>';
	document.HANDWRITING.upload(cmdSavefiles);
}

function ev_onLoad() {
	var isnew = <%=isnew%>;
	var filename = '';
	if (!isnew) {
		filename = hoststr+'<%= contextPath %>/dynaform/document/downloadattachfile.do?id=<c:out value="${ItemForm.id}" />&refresh=<%=System.currentTimeMillis()%>';
	}
	document.HANDWRITING.load(filename);
}

-->
</script>
</head>
<body <%=isedit?"onload='ev_onLoad()'":""%> leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0 scroll=no>
<html:form action="/dynaform/document/edititem.do" styleId="formItem" method="post">
<input type='button' name='save' value='{*[Save]*}' onclick='ev_save()' id='btnsave' style="display:none">
<input type='hidden' name='ISNEW' value='<%=isnew%>'>
<html:errors/>
<html:hidden property="id"/>
<html:hidden property="docid"/>
<html:hidden property="name"/>
<SCRIPT LANGUAGE="JavaScript">
<!--
//-->
</SCRIPT>
<table width="98%" height="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="list-datas">
	<%if(isedit){%>
	<APPLET 
		codebase = "/dynaform/form/handwritingfield" 
		CODE="com.cyberway.component.applet.signature.SignatureApplet.class" 
		archive  = "signatureapp.jar"
		name = "HANDWRITING"
		WIDTH="100%" 
		HEIGHT="100%">
	</APPLET>
	<%}else{%>
		<img src="<%= contextPath %>/dynaform/document/downloadattachfile.do?id=<c:out value="${ItemForm.id}" />">
	<%}%>
	</td>
  </tr>
</table>
<s:KeepCondition form="formItem"/>
</html:form>
</body>
</html:html>


