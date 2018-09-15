<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<%
String contextPath = request.getContextPath();
%>
<head>


<script language="javaScript">
var contextPath = '<%=contextPath%>';
function ev_ok() {
    var actorAttr = new Object();
    actorAttr.id = formItem.id.value;
    actorAttr.name = formItem.name.value;
    actorAttr.statelabel = formItem.statelabel.value;
    var validators = [{fieldName: "name", type: "required", msg: "{*[page.name.notexist]*}"}];
    if (doValidate(validators)) {
    	OBPM.dialog.doReturn(actorAttr);
    }
  }
  function ev_close() {
   OBPM.dialog.doReturn();
  }
  window.onload = function (){
  		window.top.toThisHelpPage("application_module_workflows_stopnode");
  }
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body>
<table width="100%" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[TerminateNodeInfo]*}</td>
		<td align="right">
		<table border=0 cellpadding="0" cellspacing="0">
			<tr>
				
				<td  valign="top">
				<button type="button" class="button-image"
					onClick="ev_ok();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td valign="top">
				<button type="button" class="button-image"
					onClick="ev_close();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">&nbsp;
		
		</td>
	</tr>
</table>


<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table border="0" width="97%" class="id1">
	<s:form method="post" id="formItem" theme="simple">
	<tr>
		<td>{*[Name]*}:</td>
	</tr>
	<tr>
		<td><s:textfield cssClass="input-cmd" name="name" /></td>
	</tr>
	<tr>
		<td>{*[State_Label]*}:</td>
	</tr>
	<tr>	
		<td>
			<s:textfield cssClass="input-cmd" name="statelabel" />
		</td>
	</tr>
	</s:form>
</table>
</body>

<script language="JavaScript">
    var obj=OBPM.dialog.getArgs()['oldAttr'];
    try{
      if(obj!= null){
      	if(obj.name!=null){
      		formItem.name.value=obj.name;
      	}
      	if(obj.statelabel!=null) {
      	    formItem.statelabel.value=obj.statelabel;
      	}
      }
    }catch(ex){}
    
</script>
</o:MultiLanguage></html>
