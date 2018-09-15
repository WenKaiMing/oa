<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.util.sequence.Sequence,cn.myapps.util.sequence.SequenceException" %>
<%
String contextPath = request.getContextPath();
String fileFileName = request.getParameter("fileFileName");
String uploadPath = request.getParameter("path");
String temp = Sequence.getSequence();
%>
<html><o:MultiLanguage>
<head>
<title>{*[Upload file]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/css/css.jsp" type="text/css">
<script src="<%=contextPath %>/script/util.js"></script>
<script language="JavaScript">
<!--
function ev_add() {
    tips.style.display='';
    frm.style.display='none';
    var fileName = document.uploadForm.file.value;
    var startwith = fileName.lastIndexOf(".");   
    fileName = fileName.substring(startwith);
    document.uploadForm.uploadname.value ='<%=temp%>'+fileName;
     document.uploadForm.appname.value='<%=contextPath%>';
      document.uploadForm.submit();
 	

}

// -->
</script> 
</head>
<body  style="padding:0px;margin:0px;background-color:#cccccc">
<div id="tips" style="display:none">
  <table width=100% height=100% align=center cellpadding=0 cellspacing=0 border=0 >
    <tr>
      <td align=center valign=middle><img src="<%=contextPath%>/resource/imgnew/loading.gif"></td>
    </tr>
  </table>
</div>
<div id="frm">
<s:form name="uploadForm" enctype="multipart/form-data" action="uploadimage" method="post">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr height="50%" valign="top">
    <td  align="left">
             <s:hidden name="uploadname" />
             <s:hidden name="pass" value="pass"/>
             <s:hidden name="appname"/>
              <s:hidden name="path" value="WEB_UPLOADSPATH"/>
              <input type=file  name="file" />
         </td>
    </tr>
</table>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
