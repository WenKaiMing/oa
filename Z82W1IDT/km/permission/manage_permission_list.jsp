<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script type="text/javascript">
function authorizeW() {
	var resource = '<s:property value="resource" />';
	var resourceType = 'directory';
	var url = '<s:url value="/km/permission/manage_permission_new.action"></s:url>';
	url+="?resource="+resource+"&resourceType="+resourceType;
	window.location.href = url;
}

function ev_edit(id){
	var _fileId = '<s:property value="resource" />';
	var _fileType = '<s:property value="resourceType" />';
	var url = '<s:url value="/km/permission/manage_permission_edit.action"></s:url>';
	url+="?id="+id;
	window.location.href = url;
}


function ev_remove(){
	var checkBlo = false;
	var checkboxs = document.getElementsByName("_selects");
	for(var i=0;i<checkboxs.length;i++){
		if(checkboxs[i].checked == true){
			checkBlo = true;
			break;
		}
	}
	if(checkBlo == false) {
		alert("{*[select_one_at_least]*}");
	}else{
		document.forms[0].action = '<s:url value="/km/permission/manage_permission_delete.action"/>';
		document.forms[0].submit();
	}
}

jQuery(document).ready(function(){
/* 	jQuery("#authorizeAdd").click(function(){
		authorizeW();
	}); */
});
</script>
</head>
<body>
<div class="authorizeList" align="center">
		<div>
			<a>{*[cn.myapps.km.permission.authorization_list]*}</a>
			<button class="aLD" onclick="ev_remove();">{*[Delete]*}</button>
			<button id="authorizeAdd" onclick="authorizeW()">{*[cn.myapps.km.permission.add]*}</button>
		</div>
</div>
<s:form theme="simple" action="list">
	<s:hidden id="resource" name="resource" />
	<s:hidden id="resourceType" name="resourceType" />
	<div class="authorizeList" align="center">
		<table>
			<tr>
				<td><input type="checkbox"/></td>
				<td class="authorizeLName"><a>{*[cn.myapps.km.permission.authorization_type]*}</a></td>
				<td class="authorizeLName"><a>{*[cn.myapps.km.permission.authorization_object]*}</a></td>
			</tr>
			<s:iterator value="datas.datas" id="p">
			<tr>
				<td><input type="checkbox" name="_selects" value='<s:property value="id"/>' /></td>
				<td><a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')">
				<s:if test="scope == 'user'">{*[User]*}</s:if>
				<s:elseif test="scope == 'role'">{*[Role]*}</s:elseif>
				</a></td>
				<td><a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')"><s:property value="ownerNames" /></a></td>
			</tr>
			</s:iterator>
		</table>
	</div>
	</s:form>
</body>
</o:MultiLanguage></html>