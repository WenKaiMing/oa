<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
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
    actorAttr.index=formItem.index.value;
    window.returnValue = actorAttr;
    window.close();
  }
  function ev_close() {
    var actorAttr = new Object();
    actorAttr.index=-1;
    window.returnValue = actorAttr;
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
		<td width="100" class="text-label">{*[NodeActivityInfo]*}</td>
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
<table border=1 width=97%>
	<s:form  method="post" id="formItem">
		   <s:textfield label="{*[name]*}" cssClass="input-cmd" name="name" />
		  <s:hidden name="index"></s:hidden>
	</s:form>
</table>
</body>

<script language="JavaScript">
    var obj = window.dialogArguments; 
    try{
      if(obj!= null&&obj.name!=null){
      formItem.name.value=obj.name;
      formItem.index.value=obj.index;
      }
    }catch(ex){}
    
</script>
</o:MultiLanguage></html>