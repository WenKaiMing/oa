<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<%String contextPath = request.getContextPath();%>
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
    	window.returnValue = actorAttr;
   	 	window.close();
    }
  }
  function ev_close() {
    //window.close();
	window.top.close();
  }
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body>
<table width="98%">
	<tr>
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="100" class="text-label">{*[EndNodeInfo]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
				<td></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="button-image"
					onClick="ev_ok();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="button-image"
					onClick="ev_close();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>

<table border=0 width=97%>
	<s:form method="post" id="formItem" theme="simple">
	<tr>
		<td>{*[Name]*}:</td>
	</tr>
	<tr>
		<td><s:textfield cssClass="input-cmd" cssStyle="width:350px;" name="name" /></td>
	</tr>
	<tr>
		<td>{*[State_Label]*}:</td>
	</tr>
	<tr>	
		<td>
			<s:textfield cssClass="input-cmd" cssStyle="width:350px;"  name="statelabel" />
		</td>
	</tr>
	</s:form>
</table>
</body>

<script language="JavaScript">
    var obj = window.dialogArguments; 
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