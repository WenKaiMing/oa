<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page
	import="cn.myapps.core.dynaform.dts.excelimport.config.action.ImpHelper"%>
<%@ page
	import="cn.myapps.core.dynaform.dts.excelimport.config.ejb.IMPMappingConfigVO"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String contextPath = request.getContextPath();
	//Parentid
	String parentid=(String)request.getParameter("parentid");//当导入为子表单数据时会使用
	String sessionId = request.getSession().getId();
	String applicationid = request.getParameter("application");
	String isRelate = request.getParameter("isRelate");
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>{*[Import Excel]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	</head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<s:url value='/portal/share/script/util.js'/>"></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ModuleHelper.js"/>'></script>
	<script src="<s:url value='/portal/share/script/check.js'/>"></script>
	<script src="<s:url value='/portal/share/script/util.js'/>"></script>
<script>
var contextPath = '<%=contextPath%>';
var applicationid = '<%=applicationid%>';
function attechmentupload(excelpath){
	uploadFrontSimple(excelpath,"_pathid",applicationid);
}

function download(file) {
	window.location = file;
}
function importDocument(){
    var _path = document.getElementsByName('_path');
    if(_path[0].value==''){
      alert("*{*[core.dts.excelimport.config.empty]*}");
      return;
    }
  	formItem.action="<s:url value='/portal/share/dynaform/dts/excelimport/ImprotExcel.action'/>";
  	formItem.submit();
}

function uploadFrontSimple(pathname, pathFieldId, applicationid) {
	var url = contextPath
			+ '/portal/share/component/upload/upload.jsp?path=' + pathname
			+ '&applicationid=' + applicationid;
	var oField = jQuery("#" + pathFieldId);
	OBPM.dialog.show( {
		opener : window.parent.parent,
		width : 700,
		height : 450,
		url : url,
		args : {},
		title : '{*[Upload]*}',
		close : function(result) {
			if (result == null || result == undefined
					|| result == "undefined" || result == "clear") {
				oField.val('');
			} else {
				if(result.indexOf(',') != -1){
					result = result.substring(result.indexOf(',')+1);
				}
				oField.val(result);
			}

		}
	});
}
</script>
	<body>

	<s:bean name="cn.myapps.core.dynaform.dts.excelimport.config.action.ImpHelper" id="hepler" />
	<s:form name="formItem" action="save" method="post">
		<input type="hidden" name="_impmappingconfigid"
			value='<s:property value="#parameters.id"/>' />
		<input type="hidden" name="sessionid"
			value='<%=sessionId %>' />
		<input type="hidden" name="application"
			value='<s:property value="#parameters.applicationid"/>' />
		<input type="hidden" name="parentid"
			value='<%=parentid %>' />
		<input type="hidden" name="isRelate"
			value='<%=isRelate %>' />
		<s:hidden id="_activityid" name="_activityid" value="%{#parameters._activityid}" />
		<s:hidden id="_viewid" name="_viewid" value="%{#parameters._viewid}"/>
		<table border="0">
			<tr>
				<td class="commFont">{*[Attachment]*}:&nbsp;&nbsp;</td>
				<td class="commFont" colspan="2">
				<%
    		String id = request.getParameter("id");
    		IMPMappingConfigVO map = (IMPMappingConfigVO)ImpHelper.get_MappingExcel(id);
    		String path = map.getPath();
    		if(path == null || path.trim().length() <= 0){%> <font
					color="#FF0000">{*[No_Template]*}</font> <%}else{%> <a
					href="javascript:download('<%= contextPath %><%= path %>');"><font color="#0000FF">{*[cn.myapps.core.dynaform.dts.excelimport.click_download_template]*}</font></a>
				<%} %>
				</td>
			</tr>
			<tr>
				<td class="commFont">&nbsp;</td>
				<td colspan="2"><br>
				<s:textfield id="_pathid" name="_path" cssClass="bugLong-input" readonly="true"
					theme="simple" />
				<button type="button" name='btnSelectDept' class="button-image"
					onClick="attechmentupload('IMPORTEXCEL_PATH')"><img
					src="<s:url value="/resource/image/search.gif"/>">{*[Upload_File]*}</button>
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