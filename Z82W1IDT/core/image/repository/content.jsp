<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" /> 
<html>
<%
String contextPath = request.getContextPath();%>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script src="<s:url value='/script/util.js'/>"></script>

<script>
var mode = '<s:property value="#parameters.mode" />';
function imagesimple(url){
    var src = "<s:url value="/" />"+url;
   
    var img = getElementById('imgid');

    img.src = src;
    img.style.display = "";
}

function returncheck()
{
  
    var mode = document.getElementById('mode').value;
     if(mode==''){document.getElementById('s_module').value='';}
     document.forms[0].action="<s:url action='list.action'/>";
     document.forms[0].submit();
 
}
function attechmentupload(imagepath){
var rtn = uploadFile(imagepath,'content','','','','','',<s:property value="#parameters.application"/>);
var	index = rtn.indexOf("_");
var rtr = rtn.substring(0, index);
 if(rtr!=null&&rtr!='')
 {
   formItem.elements['content.content'].value = rtr;
   document.getElementById('displayImage').style.display ='';
   document.getElementById('imgid').style.display = '';
 
   }
   else{
     formItem.elements['content.content'].value =rtr;
     document.getElementById('imgid').style.display = 'none';
     document.getElementById('displayImage').style.display ='none';
     
 }
}
</script>
<title>Register result</title>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<%@include file="/common/operatorlist.jsp"%>
	<s:bean name="cn.myapps.core.style.repository.action.StyleRepositoryHelper" id="sh">
		<s:param name="moduleid" value="#parameters.s_module" />
	</s:bean>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width=85% border=0 align="center">
<s:form action="save" method="post" name="formItem" theme="simple">
<%@include file="/common/page.jsp"%>
	<s:hidden name='s_module' value="%{#parameters._moduleid}" />
	<s:property value="#parameter['_moduleid']"/>
	<s:hidden name='mode' value="%{#parameters.mode}" />
   	<s:hidden name="path"></s:hidden>
   	<s:hidden name='content.version'></s:hidden>
	<tr><td width="15%" class="commFont" >{*[Name]*}:</td>
		<td width="85%"><s:textfield cssClass="input-cmd" theme="simple" name="content.name" /></td></tr>
<s:if test=" #parameters.mode[0] == 'module'">
 <s:hidden name='_moduleid' value="%{#parameters._moduleid}" />
	</s:if>
	<s:else>
   <tr id='modid' style=''>
		<td class="commFont" >{*[Module]*}:</td>
		<td>
			<s:select label="{*[Module]*}" name="_moduleid" list="#moduleHelper.getModuleSel(#parameters.application)" theme='simple'/>
		</td>
	</tr>
 </s:else>
	<tr>
		<td class="commFont" ><div>
	      {*[Attachment]*}:</div></td>
		<td colspan="3">
	      <s:textfield id="content" name="content.content" cssClass="bugLong-input" readonly="true" theme="simple"/>
      <button type="button" name='btnSelectDept' class="button-image" onClick="attechmentupload('IMAGE_PATH');imagesimple(document.getElementById('content.content').value)"><img src="<s:url value="/resource/image/search.gif"/>"></button></td>
    </tr>
    <tr>
    <td colspan=2>
    <div id="displayImage" style="overflow:auto;width:500px;height:250px">
    <img  id="imgid" <s:if test="content.content==null||content.content==''">style='display:none'</s:if>  src='<s:url value='/' /><s:property value="content.content" />'/>    </div>    </td>
    </tr>
	</s:form>
</table>
</body>
</html>
