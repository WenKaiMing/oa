<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>Column</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/css.jsp" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>

<body>
<SCRIPT LANGUAGE="JavaScript">

function returnAttr()
{
	var attr=new Object()
	attr.name=document.tmp.name.value
	attr.fieldName=document.tmp.fieldName.value;
	attr.valueScript=document.tmp.valueScript.value;
	attr.validateRule=document.tmp.validateRule.value;
	attr.primaryKey = document.tmp.primaryKey.checked;
	
	window.returnValue=attr
	window.close()
}

</SCRIPT>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="tmp" method="post" action="">
<%@include file="/common/page.jsp"%>
  <tr>
  <td width="100%">
 <table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd">
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Column]*}:</td>
       <td align="left">
          <input type="text" name="name" style="width:350px;" size="51">
      </td>
    </tr>
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Field]*}:</td>
       <td align="left">
          <input type="text" style="width:350px;" name="fieldName" size="51">
      </td>
    </tr>
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[IsPrimaryKey]*}:</td>
       <td align="left">
         <input type="checkbox" name="primaryKey" value="true"/>
      </td>
  </tr>  
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Value_Script]*}:</td>
       <td align="left">
          <textarea name="valueScript" style="width:350px;height=150"></textarea>
      </td>
    </tr>
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Validate_Script]*}:</td>
       <td align="left">
          <textarea name="validateRule" style="width:350px;height=150"></textarea>
      </td>
    </tr>

  </table>
   </td>
   </tr>
     <tr>
    <td align="center">
    	<input type="button" class="bt" onclick="returnAttr()" value="{*[Confirm]*}">
    <input type="button" class="bt" onclick="window.close()" value="{*[Cancel]*}"></td>
  </tr>
  </form>
   </table>
</body>
<script language="JavaScript">
    var oldAttr = window.dialogArguments;
    try{
    if (oldAttr != null) {
      tmp.name.value = oldAttr.name;
      tmp.fieldName.value = oldAttr.fieldName;
	  tmp.valueScript.value = oldAttr.valueScript;
	  tmp.validateRule.value = oldAttr.validateRule;
	  tmp.primaryKey.checked = oldAttr.primaryKey;
    }
    }catch(ex){}
</script>
</o:MultiLanguage></html>