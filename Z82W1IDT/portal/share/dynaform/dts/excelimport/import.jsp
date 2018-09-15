<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head><title>{*[Import]*} {*[Excel]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css"></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page
	import="cn.myapps.core.dynaform.dts.excelimport.config.action.ImpHelper"%>
<%@ page
	import="cn.myapps.core.dynaform.dts.excelimport.config.ejb.IMPMappingConfigVO"%>
<link rel="stylesheet" href="<s:url id="url" value='/resourse/main.css'/>"/>
<script src="<s:url value='/portal/share/script/util.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
<script src="<s:url value='/portal/share/script/check.js'/>"></script>
<script src="<s:url value='/portal/share/script/util.js'/>"></script>
<script>
var contextPath = '<%=contextPath%>';
function attechmentupload(excelpath){

 var rtr = uploadFile(excelpath,'_pathid','','','','','',<s:property value="#parameters.APPLICATION"/>);
 if(rtr!=null&&rtr!='')
 {
   formItem.elements['_path'].value = rtr;
   }

}

function importDocument(){
  if(formItem.elements['_impmappingconfigid'].value=='')
     alert('{*[请先选择一个导入配置]*}');
  else if(formItem.elements['_path'].value=='')
    alert('{*[请先上传Excel文件]*}');
  else
  {
  	formItem.action='<s:url value="/portal/share/dynaform/dts/excelimport/ImprotExcel.action"/>';
  	formItem.submit();
  }     
}
</script>
<body>

<s:bean name="cn.myapps.core.dynaform.dts.excelimport.config.action.ImpHelper" id="hepler" />
<s:form name="formItem" action="save" method="post">
		
	   <table>
	   <tr><td class="commFont">{*[Import]*}{*[MappingConfig]*}:</td><td><s:select  name="_impmappingconfigid" list="#hepler.get_allMappingConfig(#parameters.APPLICATION)" listKey="id" listValue="name" theme="simple" emptyOption="true" /></td></tr>
	  	<tr>
		<td class="commFont" >
	      {*[Attachment]*}:</td>
		<td colspan="3">
	      <s:textfield id="_pathid" name="_path" cssClass="bugLong-input" readonly="true" theme="simple"/>
      <button type="button" name='btnSelectDept' class="button-image" onClick="attechmentupload('IMPORTEXCEL_PATH')"><img src="<s:url value="/resource/image/search.gif"/>"></button></td>
    </tr>
   <tr>
 
   <td>  <br><br>  <button type="button" class="button-image" onClick="importDocument()"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Import]*}</button></td></tr>     
</table>
</s:form>	  	
</body>
</o:MultiLanguage></html>
