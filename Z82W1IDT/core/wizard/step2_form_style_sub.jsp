<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">   
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="-1">
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {color: #000000}
-->
</style>
</head>

<script>
  function styleChange(type) { //style type
     	switch (type) {
		case '0':
		    document.all("content.f_style_sub")[0].checked = true;
		 	break;
		case '1':
		    document.all("content.f_style_sub")[1].checked = true;
		 	break;
		case '2':
		    document.all("content.f_style_sub")[2].checked = true;
		 	break;
		default:
			document.all("content.f_style_sub")[0].checked = true;
		 	break;
		}
	}

 function ev_init(){
    styleChange('<s:property value="content.f_style_sub"/>');
 }
 function ev_next() {
	 var str = "";
	 if(document.getElementById('content.f_fieldsdescription_sub')!=null){
		 str = document.getElementById('content.f_fieldsdescription_sub').value;
	 }else{
		 str = document.getElementById('save_content_f_fieldsdescription_sub').value;
	 }
	 if(document.getElementById('content.f_templatecontext_sub')!=null){
		 document.getElementById('content.f_templatecontext_sub').value = str;
	 }else{
		 document.getElementById('save_content_f_templatecontext_sub').value = str;
	 }
	document.forms[0].action='<s:url action="toSubFormView"></s:url>';
	document.forms[0].submit();
}

</script>
<body onload="ev_init()" >
<s:form action="save" method="post">
	 <s:hidden name="content.f_formid_sub" />

<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%> 
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="27"/></s:include></td>
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table class="marAuto">
        		<tr>
					<td><img src="<s:url value="/resource/image/style1.gif"/>"></td>
					<td><img src="<s:url value="/resource/image/style2.gif"/>"></td>
					<td><img src="<s:url value="/resource/image/style3.gif"/>"></td>		
				</tr>
				<tr>
					<td align="center" class="commFont">{*[Type]*}-1<input type="radio" name="content.f_style_sub" value='0'></td>
					<td align="center" class="commFont">{*[Type]*}-2<input type="radio" name="content.f_style_sub" value='1'></td>
					<td align="center" class="commFont">{*[Type]*}-3<input type="radio" name="content.f_style_sub" value='2'></td>
				</tr>									
        		<tr>
        			<td valign="top" colspan="3" align="center">
        				<button type="button" onClick="forms[0].action='<s:url action="backToFieldSub"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
       					<button type="button" onClick="ev_next();">{*[Next]*}</button> 
       					<s:textarea name="content.f_fieldsdescription_sub" cssStyle="display:none"/>
  						<s:textarea name="content.f_templatecontext_sub" cssStyle="display:none"/>
       				</td>
       			</tr>
			</table><br/>
						<table style="width:80%">
				<tr>
					<td>
						*{*[page.wizard.step2.style.description1]*} <br/>
						*{*[page.wizard.step2.style.description2]*}
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
