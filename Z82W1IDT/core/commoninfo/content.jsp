<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%String contextPath = request.getContextPath();%>
<%@ page import="java.util.*"%>
<html><o:MultiLanguage>
<head>
<title>{*[CommonInfo]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
	

</head>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
	
<script language="javaScript">
	var contextPath = '<%=contextPath%>';
	
	function selectField(actionName,field){
	  wx = '300px' ;
	  wy = '400px' ;
	  
	  var url = contextPath + '/core/commoninfo/'+ actionName +'.action';
	  if (field != '' && field != null) {
	  	url = url + '?field=' + field;
	  }
	 //alert("url->" + url);
	  
	  var rtn = showframe('{*[Select]*}', url);
	 
	  if (rtn == null || rtn == 'undefined'){
	  }else if(rtn =='') {
	    var formfield = eval("formItem.elements['content."+field+"']");
		  formfield.value = '';
	  }else{
	    var formfield = eval("formItem.elements['content."+field+"']");
	    formfield.value = rtn;
	  }
	  
    }

</script>


<body>

<table width="98%">
	<tr>
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="70" class="text-label">{*[Common]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
			<td></td>
				<td class="line-position2"  valign="top">
				<button type="button" class="button-image"
					onClick="forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				
				<td class="line-position2"  valign="top">
				<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"><s:param name="_currpage"  value="#parameters['_currpage']"/><s:param name="_pagelines"  value="#parameters['_pagelines']"/><s:param name="_rowcount"  value="#parameters['_rowcount']"/></s:url>';forms[0].submit();">
					<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>



<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;
	</s:iterator> </span>
</s:if>
	<s:form id="formItem" action="save" method="post" validate="true" theme="ajax">
		<%@include file="/common/page.jsp"%>
     
		<tr>
			<td class="commFont">{*[Type]*}:</td>
			<td><s:textfield cssClass="input-cmd" name="content.type"
				theme="simple" />
			
			<button type="button" class="button-image"
				onClick="selectField('selectType','type');"><img
				src="<s:url value="/resource/image/search.gif"/>"></button>
			</td>
		</tr>

		<tr><td class="commFont"  >{*[Code]*}:</td><td><s:textfield size="50" theme="simple" cssClass="input-cmd" label="{*[Code]*}"
			name="content.code" /></td></tr>

		<tr><td class="commFont">{*[Value]*}:</td><td>
		<s:textfield theme="simple" size="50" cssClass="input-cmd" label="{*[Value]*}"
			name="content.value" /></td></tr>
	  <tr><td class="commFont" >{*[OrderNo]*}:</td><td> 
	    <s:textfield  theme="simple" size="50" cssClass="input-cmd" label="{*[OrderNo]*}"
			name="content.orderNo" /></td></tr>
	</s:form>
</body>

</o:MultiLanguage></html>
