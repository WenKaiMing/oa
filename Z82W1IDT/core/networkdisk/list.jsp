<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.networkList.list.network_disk]*}</title>
</head>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script>



jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("domain_networkdisk");
});


//网盘
function doNetworkDisk(){
	if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		var _selects = "";
		var c = document.getElementsByName("_selects");
		if (c && c.length > 0) {
			for (var i = 0; i < c.length; i++) {
				if (c[i].checked) {
					_selects +=(c[i].value+";");
				}
			}
		}
		var url = contextPath + '/core/networkdisk/content.jsp?_selects='+_selects.substring(0,_selects.length-1);
		dialogShow(url);
	}
}

function NetworkUser(){
	document.all("main").style.display = "";
	document.all("main1").style.display = "";
	document.all("networkdisklist").style.display = "none";
	document.all("networkdisklist1").style.display = "none";
	window.top.toThisHelpPage("domain_networkdisk_list");
}

// 公共部分
function dialogShow(url){
	OBPM.dialog.show({
			opener:window.parent,
			width: 400,
			height: 300,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.domain.networkList.list.configurations_network_disk]*}',
			close: function(rtn) {
				document.forms[0].submit();
				//window.location.href=contextPath + '/core/networkdisk/networkdisk.action？';
			}
	});
}

//当个编辑
function singleEdit(id){
	var url = contextPath + '/core/networkdisk/edit.action?id='+id;
	dialogShow(url);
}


//网盘公共共享
function doNetworkDiskShare(){
	//var url = contextPath + "/core/networkdisk/networkdisk.jsp?domainid=<s:property value='#parameters.domain' />";
	//OBPM.dialog.show({
	//		opener:window.parent,
	//		width: 1000,
	//		height: 500,
	//		url: url,
	//		args: {},
	//		title: '{*[cn.myapps.core.domain.networkList.network_disk_public_sharing]*}',
	//		close: function(rtn) {
				//window.top.toThisHelpPage("application_info_generalTools_role_info");
	//		}
//	});
	document.all("main").style.display="none";
	document.all("main1").style.display="none";
	document.all("networkdisklist").style.display=""; 
	document.all("networkdisklist1").style.display = "";
	window.top.toThisHelpPage("domain_networkdisk_share");
}

function resetInfo(){
	document.getElementById("sm_name").value = '';
	document.getElementById("sm_description").value = '';
}
</script>

<body id="domain_networkdisk_list" class="listbody" style="overflow-y:auto;overflow-x:hidden;">
<div>
<s:form name="formList" theme="simple" action="networkList" method="post">
<s:hidden name="s_domainid" value="%{#parameters.s_domainid}"/>
	<s:bean name="cn.myapps.core.networkdisk.action.NetworkDiskHelper" id="nh"/>
	<%@include file="/common/basic.jsp" %>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv" id="main1"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.networkList.network_disk_user_list]*}</div>
				<div class="domaintitlediv" id="networkdisklist1" style="display:none"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.networkList.network_disk_public_sharing]*}</div>
			</td>
			<td>
			<% 
				WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_USER);
				boolean isSuperAdmin = user.isSuperAdmin();
				boolean isDomainAdmin = user.isDomainAdmin();
				int domainPermission = user.getDomainPermission();
					if (isSuperAdmin || (isDomainAdmin && domainPermission>=WebUser.NORMAL_DOMAIN)){
			%>
				<div class="actbtndiv">
					<span style="padding-right:10px; cursor:pointer;" id="Add_Application" title="{*[cn.myapps.core.domain.networkList.network_disk_public_sharing]*}" onClick="doNetworkDiskShare()">	
						<img src="<s:url value='/resource/imgnew/add.gif'/>" />
						<span>{*[cn.myapps.core.domain.networkList.network_disk_public_sharing]*}</span>
					</span>
					<span style="padding-right:10px; cursor:pointer;" id="Remove_Application" title="{*[cn.myapps.core.domain.networkList.network_disk_user_list]*}" onClick="NetworkUser()">
						<img src="<s:url value='/resource/imgnew/add.gif'/>">
						<span>{*[cn.myapps.core.domain.networkList.network_disk_user_list]*}</span>
					</span>
				</div>
			<%}else{ %>
				&nbsp;
			<%} %>
			</td></tr>
	</table>
<div id="main">
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}">
			<table class="table_noborder" >
				<tr><td class="head-text">
					{*[User_Name]*}:	<input pid="searchFormTable" title="{*[User_Name]*}" class="justForHelp input-cmd" type="text" name="sm_name" id="sm_name" 
						value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[cn.myapps.core.domain.networkList.list.user_account]*}:	<input pid="searchFormTable" title="{*[cn.myapps.core.domain.networkList.list.user_account]*}" class="justForHelp input-cmd" type="text" name="sm_loginno" id="sm_description"
						value='<s:property value="#parameters['sm_loginno']" />' size="10" />
					<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}" class="justForHelp button-cmd" type="submit" value="{*[Query]*}" />
					<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetInfo();" />
				<td style="width:200px;">
				<span type="button" style="float:right; cursor:pointer;" id="Remove_Application" title="{*[cn.myapps.core.domain.networkList.list.configurations_network_disk]*}" class="justForHelp button-image" onClick="doNetworkDisk()">
					<img src="<s:url value='/resource/imgnew/remove.gif'/>">
					<span>{*[cn.myapps.core.domain.networkList.list.configurations_network_disk]*}</span>
				</span>
			</table>
		</div>
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[User_Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[cn.myapps.core.domain.networkList.list.user_account]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[cn.myapps.core.domain.networkList.list.network_disk_grant_total_capacity]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[cn.myapps.core.domain.networkList.list.network_disk_limit_upload_capacity]*}</o:OrderTag></td>
						<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[cn.myapps.core.domain.networkList.list.network_disk_has_use_capacity]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[cn.myapps.core.domain.networkList.network_disk_status]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><s:property value="name" /></a></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><s:property value="loginno" /></a></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><s:property value="#nh.getNetDiskTotalSize(id)" /></a></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><s:property value="#nh.getNetDiskUploadSize(id)" /></a></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><FONT color="red"><s:property value="#nh.getNetDiskHaveUseSize(id)" /></FONT></a></td>
					<td><a href="#" onclick="singleEdit('<s:property value="id" />')"><s:property value="#nh.getNetDiskPemission(id)" /></a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
	<div id="networkdisklist" style="display:none">
	<iframe width="100%" height="100%" src="../networkdisk/networkdisk.jsp?domainid=<s:property value='#parameters.domain' />" id="networkdisk" frameborder="0" name="helpFrame" /></iframe>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
