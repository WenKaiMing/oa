<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
request.setCharacterEncoding("UTF-8");
String userid = request.getParameter("id");
String _selects = request.getParameter("_selects");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.domain.networkList.list.network_disk]*}</title>
<script type="text/javascript">
var userid = '<%=userid%>';
function doSave(){
	var totalSize = document.getElementById("content.totalSize").value;
	var uploadSize = document.getElementById("content.uploadSize").value;
	var pemission = document.getElementById("content.pemission");
	if(checkTotalSize(totalSize)){
		if(checkUploadSize(uploadSize)){
			var networkdiskform = document.getElementById("networkdiskform");
			if(userid=="" || userid ==null || userid == "null"){
				networkdiskform.action='<s:url action="saveAll"></s:url>';
				networkdiskform.submit();
			}else{
				networkdiskform.action='<s:url action="save"></s:url>';
				networkdiskform.submit();
			}
		}
	}
}

function checkTotalSize(s){
	if(s==""){
		alert("{*[cn.myapps.core.domain.networkList.edit.grant_total_capacity]*}不是能为空");
		return false;
	}else{
		if(checkNumber(s)){
			return true;
		}else{
			 alert("{*[cn.myapps.core.domain.networkList.edit.grant_total_capacity]*}不是正整数");
			 return false;
		}
	}
}

function checkUploadSize(s){
	if(s==""){
		alert("{*[cn.myapps.core.domain.networkList.edit.limit_upload_capacity]*}不是能为空");
		return false;
	}else{
		if(checkNumber(s)){
			return true;
		}else{
			 alert("{*[cn.myapps.core.domain.networkList.edit.limit_upload_capacity]*}不是正整数");
			 return false;
		}
	}
}

//检查是否为数字
function checkNumber(s){
	var reg = /^[0-9]*[1-9][0-9]*$/;
	if(reg.test(s)){
		return true;
	}
	return false;
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_networkdisk_config");
});

</script>
</head>
<body>
<s:form action="save" method="post" theme="simple" id="networkdiskform">
<table width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top" align="right">
			<button type="button" class="button-image"
				onClick="doSave()"><img
				src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save]*}</button>
		</td>
	</tr>
</table>

<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div id="contentMainDiv" class="contentMainDiv">
<%@include file="/common/page.jsp"%>
<input type="hidden" name="_selects" value="<%=_selects%>"/> 
<table class="table_noborder id1">
	<tr>
		<td class="commFont" align="left">{*[cn.myapps.core.domain.networkList.edit.grant_total_capacity]*}:</td>
	</tr>
	<tr>
		<td><s:textfield cssClass="input-cmd" id="content.totalSize" name="content.totalSize" onblur="checkTotalSize(this.value)"/>M
		</td>
	</tr>
	<tr>
		<td class="commFont" align="left">{*[cn.myapps.core.domain.networkList.edit.limit_upload_capacity]*}:</td>
	</tr>
	<tr>
		<td><s:textfield cssClass="input-cmd" id="content.uploadSize" name="content.uploadSize" onblur="checkUploadSize(this.value)"/>KB
		</td>
	</tr>
	<tr>
		<td class="commFont" align="left">{*[Status]*}:</td>
	</tr>
	<tr>
		<td><s:radio list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" id="content.pemission" value="content.pemission" name="content.pemission"/>
		</td>
	</tr>
</table>
</div>
</s:form>
</body>
</o:MultiLanguage>
</html>