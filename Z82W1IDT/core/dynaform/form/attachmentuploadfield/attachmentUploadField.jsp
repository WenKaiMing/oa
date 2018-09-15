<%@ page contentType="text/html; charset=UTF-8"%>
<%@page buffer="50kb"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/smartweb" prefix="s" %>
<%
String contextPath = request.getContextPath();
String isnew = request.getParameter("ISNEW");
String isedit = request.getParameter("ISEDIT");

%>
<html:html>
<head>
<title>{*[Image upload]*} </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/css/info.css" type="text/css">
<script src="<%= contextPath %>/js/billitem.js"></script>
<script src="<%= contextPath %>/js/check.js"></script>
<script src="<%= contextPath %>/js/util.js"></script>
<script language="JavaScript">
<!--
var contextPath = '<%=contextPath %>';
var isnew = <%=isnew%>;

function ev_save() {
  formItem.submit();
}

function ev_download() {
	window.open('<%= contextPath %>/dynaform/document/downloadattachfile.do?id=<c:out value="${ItemForm.id}" />', '_blank');
}
-->
</script>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0 scroll=no>
<tr><td>
<html:form action="/dynaform/document/saveitem.do" styleId="formItem" method="post" enctype="multipart/form-data">
<input type='button' name='save' value='{*[Save]*}' onclick='ev_save()' id='btnsave' style='display:none'>
<input type='hidden' name='ISNEW' value='<%=isnew%>'>
<input type='hidden' name='ISEDIT' value='<%=isedit%>'>
<input type='hidden' name='_type' value='attachmentupload'>
<html:errors/>
<html:hidden property="id"/>
<html:hidden property="docid"/>
<html:hidden property="name"/>
<html:hidden property="filename"/>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="list-datas">
      <c:choose>
        <c:when test="${!empty param.ISEDIT and param.ISEDIT eq 'TRUE'}" >
		  <c:if test="${!empty ItemForm.filename and ItemForm.filename ne ''}">
		    <a href="javascript:ev_download()">
			  <c:out value="${ItemForm.filename}" />
			</a>
  		  </c:if>
          <input type='file' name="value" value='abc'>
		</c:when>
        <c:otherwise>
		  <c:if test="${!empty ItemForm.filename and ItemForm.filename ne ''}">
		    <a href="javascript:ev_download()">
			  <c:out value="${ItemForm.filename}" />
			</a>
  		  </c:if>
		</c:otherwise>
      </c:choose>
	</td>
  </tr>
</table>
</html:form>
</body>
</html:html>


