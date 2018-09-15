<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.util.sequence.Sequence,cn.myapps.util.sequence.SequenceException" %>
<%
String contextPath = request.getContextPath();
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
 	document.uploadForm.appname.value='<%=contextPath%>';
 	document.uploadForm.submit();
}
function ev_init() {
   if(parent.sAction=='MODI')
   {
        document.getElementById('updatefilename').style.display='';
        document.getElementById('updatefilename').value = (parent.sFromUrl).substring(21);
        document.getElementById('updatefilename').disabled =true;
  		document.getElementById('upload').style.display='none';
  	}
  	else{
        document.getElementById('updatefilename').style.display='none';
        document.getElementById('upload').style.display='';
  	 //  
  	}
}

// -->
</script> 
</head>
<body  onload="ev_init()" style="padding:0px;margin:0px;background-color:#cccccc">
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
        <s:hidden name="pass"/>
        <s:hidden name="appname"/>
        <s:hidden name="path" value="%{#parameters.path}"/>
        <input name="updatefilename" style='display:none' size=60 />
        <input type="file" style="width:100%" name="upload" />
         </td>
    </tr>
</table>
<input type="button" value="sub" onClick="ev_add()">
</s:form>
</div>
</body>
</o:MultiLanguage></html>
