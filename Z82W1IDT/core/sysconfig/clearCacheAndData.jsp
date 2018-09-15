<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='<s:url value="/dwr/engine.js"/>'></script>
<script type="text/javascript" src='<s:url value="/dwr/util.js"/>'></script>
<script type="text/javascript" src='<s:url value="/dwr/interface/DataManageUtil.js"/>'></script>

<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ap" />
</head>
<script type="text/javascript">
	function clearcache(){
		showloading();
		DataManageUtil.clearCache(function(value){
			hideloading();
			if(value == 'success'){
				alert("清除成功");
			}else{
				alert("清除失败");
			}
		});
	}
	function clearDatas(){	
		showloading();
		var application = document.getElementsByName("sm_application")[0].value;
		DataManageUtil.clearDatas(application, function(value){
			hideloading();
			if(value == 'success'){
				alert("清除数据成功!");
			}else{
				alert("清除数据失败!");
			}
		});
		
	}
	function showloading(){
		document.getElementById("loadingDiv").style.display = 'block';
		document.getElementById("bt_clearCache").disabled = 'disabled';
		document.getElementById("bt_clearData").disabled = 'disabled';
	}
	function hideloading(){
		document.getElementById("loadingDiv").style.display = 'none';
		document.getElementById('bt_clearCache').removeAttribute('disabled');
		document.getElementById('bt_clearData').removeAttribute('disabled');
	}
</script>
<body>
<fieldset >
<legend>{*[cn.myapps.core.sysconfig.cache.cache_manager]*}</legend>
<table>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.cache.clear_cache]*}</td>
		<td>&nbsp</td>
	</tr>
	<tr>
		<td><input id='bt_clearCache' type="button" value="{*[cn.myapps.core.sysconfig.cache.clear_cache_button]*}" onclick="clearcache();"/></td>
		<td>&nbsp</td>
	</tr>
</table>
</fieldset>
<fieldset >
<legend>{*[cn.myapps.core.sysconfig.cache.data_manager]*}</legend>
<table>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.cache.clear_data]*}</td>
		<td>&nbsp</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.cache.please_choose_application]*}：
			<s:select name="sm_application" list="#ap.getAppList()" headerKey="" headerValue="{*[All]*}" listKey="id" listValue="name" theme="simple" emptyOption="false" />
			<input id="bt_clearData" type="button" value="{*[cn.myapps.core.sysconfig.cache.clear_data_button]*}" onclick="clearDatas();"/></td>
		<td>&nbsp</td>
	</tr>
</table>
</fieldset>
<DIV ID="loadingDiv"
	STYLE="position:absolute; z-index:100;width:30%; height:30%;left:30%;top:30%;display:none;">
<table>
	<tr>
		<td><img
			src="<s:url value="/resource/imgnew/loading.gif"></s:url>"></td>
		<td><b><font size='3'>Loading...</font> </b></td>
	</tr>
</table>
</DIV>
</body>
</html>