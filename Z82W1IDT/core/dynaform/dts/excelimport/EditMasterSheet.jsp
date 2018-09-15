<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<title>{*[MasterSheet]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@include file="/common/page.jsp"%>
<SCRIPT LANGUAGE="JavaScript">

function returnAttr()
{
	var attr=new Object();
	if(document.tmp.name.value!=""){
		attr.name=document.tmp.name.value;
	}else{
		attr.name="";
	}
	if(document.tmp.formName.value!=""){
		attr.formName=document.tmp.formName.value;
	}else{
		attr.formName="";
	}
	OBPM.dialog.doReturn(attr);
}

</SCRIPT>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="tmp" method="post" action="">

  <tr>
  <td width="100%">
 <table width="100%"  cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd">
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Relative]*}{*[Sheet]*}{*[Name]*}:</td>
       <td align="left">
          <input type="text" name="name" size="51">
      </td>
    </tr>
  <tr bgcolor="#FFFFFF">
      <td width="20%" class="commFont commLabel">{*[Form]*}:</td>
       <td align="left">
          <input type="text" name="formName" size="51">
      </td>
    </tr>

  </table>
   </td>
   </tr>
    <tr>
    <td align="center">
    	<input type="button" class="bt" onclick="returnAttr()" value="{*[Confirm]*}">
    <input type="button" class="bt" onclick="OBPM.dialog.doReturn()" value="{*[Cancel]*}"></td>
  </tr>
  </form>
   </table>
</body>
<script language="JavaScript">
    var oldAttr = OBPM.dialog.getArgs()['oldAttr'];
    try{
    if (oldAttr != null) {
      tmp.name.value = oldAttr.name;
      tmp.formName.value = oldAttr.formName;
    }
    }catch(ex){}
    window.top.toThisHelpPage("application_info_advancedTools_excelConf_info_maintable");
</script>
</o:MultiLanguage></html>
