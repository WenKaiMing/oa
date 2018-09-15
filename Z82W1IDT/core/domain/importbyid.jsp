<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/core/domain/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String contextPath = request.getContextPath();
	String applicationId = request.getParameter("applicationid");
%>
<html>


<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>{*[Import Excel]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	</head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<s:url value='/script/util.js'/>"></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
	<script src="<s:url value='/script/check.js'/>"></script>
	<script src="<s:url value='/script/util.js'/>"></script>
<script>
var contextPath = '<%=contextPath%>';
var path = "/uploads/resource/import_user_sample.xlsx";
var applicationid = '<%=applicationId%>';
var domainId = parent.OBPM.dialog.getArgs()['domain'];

function attechmentupload(excelpath){
	uploadFrontSimple(excelpath,"_pathid",applicationid);
}

function download() {
	window.location = contextPath + path;
}
function importDocument(){
    var _path = document.getElementsByName('_path');
    if(_path[0].value==''){
      alert("*{*[core.dts.excelimport.config.empty]*}");
      return;
    }
    document.getElementsByName("domainid")[0].value = domainId;
    formItem.action = "<s:url value='/core/domain/excelImportUserAndDept.action'/>";
    formItem.submit();
}
function uploadFrontSimple(pathname, pathFieldId, applicationid) {
	var url = contextPath+ '/core/upload/upload.jsp?path=' + pathname + '&applicationid=' + applicationid;
	var oField = jQuery("#" + pathFieldId);
	OBPM.dialog.show( {
		opener : window.parent,
		width : 700,
		height : 450,
		url : url,
		args : {},
		title : '{*[Upload]*}',
		close : function(result) {
			if (result == null || result == undefined
					|| result == "undefined" || result == "clear") {
				oField.val('');
			}else if(result.indexOf(';') > -1){
			    alert("请上传单一文件");
			    oField.val('');
			}else{
				oField.val(result);
			}
		}
	});
}
</script>
	<body>
	<s:form name="formItem" action="save" method="post">
	<s:hidden name="domainid"></s:hidden>
		<table border="0">
			<tr>
				<td class="commFont">{*[Attachment]*}:&nbsp;&nbsp;</td>
				
				<td class="commFont" colspan="2">
    				<a href="javascript:download('‪/import_user_sample.xlsx');"><font color="#0000FF">{*[cn.myapps.core.dynaform.dts.excelimport.click_download_template]*}</font></a>
				</td> 
				
			</tr>
			<tr>
				<td class="commFont">&nbsp;</td>
				<td colspan="2"><br>
				<s:textfield id="_pathid" name="_path" cssClass="bugLong-input" readonly="true"
					theme="simple" />
				<button type="button" name='btnSelectDept' class="button-image" onClick="attechmentupload('IMPORTEXCEL_PATH')">
				<img src="<s:url value="/resource/image/search.gif"/>">{*[Upload_File]*}</button>
				</td>
			</tr>
			<tr>
				<td class="commFont">&nbsp;</td>
				<td colspan="2"><br>
				<button type="button" class="button-image" onClick="importDocument()"><img
					src="<s:url value="/resource/imgv2/front/act/act_26.gif"/>">{*[Import]*}</button>
				</td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>