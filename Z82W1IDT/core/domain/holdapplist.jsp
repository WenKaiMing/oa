<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@ page import="cn.myapps.core.domain.ejb.DomainVO"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%
String domainId = request.getParameter("domain");
String systemModuleConfigJson = null;
if (domainId != null && domainId.trim().length() > 0 && !domainId.equals("null")) {
	DomainHelper domainHelper = new DomainHelper();
	DomainVO domainVO = domainHelper.getDomainById(domainId);
	if(domainVO != null){
		systemModuleConfigJson = domainVO.getSystemModuleConfigJson();
	}
}
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.holdApp.application_list]*}</title>
</head>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
	var domainId = '<s:property value="#parameters.domain"/>';
</script>
<script>

function ev_submit() {
	var url='<s:url value="/core/domain/addApp.action"></s:url>?domain=' + domainId;
	OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.holdApp.title.add_application]*}',
				close: function(rtn) {
					if(rtn=="success"){
						document.forms[0].submit();
					}
					window.top.toThisHelpPage("domain_application_list");
				}				
		});
}

function doDelete(){
	var listform = document.forms["formList"];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="removeApp"></s:url>';
    	listform.submit();
    }
}

jQuery(document).ready(function(){
	initSystemApplication();
	cssListTable();
	window.top.toThisHelpPage("domain_application_list");
});

function initSystemApplication(){
	var systemApplication =eval(<%=systemModuleConfigJson%>);
	if(systemApplication.pmEnable != undefined && systemApplication.pmEnable == true){
		jQuery("input[name='systemApplication'][value='pm']").attr("checked",true);
	} else {
		jQuery("input[name='systemApplication'][value='pm']").attr("checked",false);
	}
	if(systemApplication.qmEnable != undefined && systemApplication.qmEnable == true){
		jQuery("input[name='systemApplication'][value='qm']").attr("checked",true);
	} else {
		jQuery("input[name='systemApplication'][value='qm']").attr("checked",false);
	}
	if(systemApplication.amEnable != undefined && systemApplication.amEnable == true){
		jQuery("input[name='systemApplication'][value='am']").attr("checked",true);
	} else {
		jQuery("input[name='systemApplication'][value='am']").attr("checked",false);
	}
	if(systemApplication.cmEnable != undefined && systemApplication.cmEnable == true){
		jQuery("input[name='systemApplication'][value='cm']").attr("checked",true);
	} else {
		jQuery("input[name='systemApplication'][value='cm']").attr("checked",false);
	}
	if(systemApplication.kmEnable != undefined && systemApplication.kmEnable == true){
		jQuery("input[name='systemApplication'][value='km']").attr("checked",true);
		jQuery("#btn_configureKmRoles").show();
	} else {
		jQuery("input[name='systemApplication'][value='km']").attr("checked",false);
		jQuery("#btn_configureKmRoles").hide();
	}
	
	//事件绑定
	jQuery("input[name='systemApplication']").click(function(){
		var module = jQuery(this).val();
		if(jQuery(this).is(":checked")){
			saveSystemApplication(module,true);
			if(module=="km"){
				jQuery("#btn_configureKmRoles").show();
			}
		} else {
			saveSystemApplication(module,false);
			if(module=="km"){
				jQuery("#btn_configureKmRoles").hide();
			}
		}
	});
}

function saveSystemApplication(module,enable){
	var url = '<s:url value="/core/domain/updateSystemApplication.action"/>';
	var params = {};
	params["module"] = module;
	params["enable"] = enable;
	params["domainId"] = domainId;
	jQuery.ajax({
		url: url,
		type: 'post',
		data: params,
		success: function(result){
			if("保存成功" == result){
				showMessage("success", result);
			} else {
				showMessage("error", "服务器发生异常");
			}
		}
	});
}

var target = null;
function configureKmRoles(){
	var url = contextPath + '/core/sysconfig/configure.action?domainId=' + domainId;
	OBPM.dialog.show({
			opener:window.parent,
			width: 1000,
			height: 520,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.sysconfig.km.role_manage]*}',
			close: function(rtn) {
			}
	});
}

</script>

<body id="domain_application_list" class="listbody">
<div>
<s:form name="formList" theme="simple" action="holdApp" method="post">
	<%@include file="/common/basic.jsp" %>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.holdApp.application_list]*}</div>
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
					<button type="button" id="Add_Application" title="{*[cn.myapps.core.domain.holdApp.title.add_application]*}" class="justForHelp button-image" onClick="ev_submit()">	<img src="<s:url value='/resource/imgnew/add.gif'/>" />{*[Add]*}</button>
					<button type="button" id="Remove_Application" title="{*[cn.myapps.core.domain.holdApp.title.remove_application]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value='/resource/imgnew/remove.gif'/>">{*[Remove]*}</button>
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
	<div id="systemApplicationSetting">
		<div class="navigation_title">
			<span>{*[cn.myapps.core.domain.holdApp.base_application]*}</span>
		</div>
		<table>
			<tr>
				<td>
					<s:checkboxlist name="systemApplication" theme="simple"
						list="#{'pm':'{*[cn.myapps.core.domain.holdApp.enable_pm]*}',
						'qm':'{*[cn.myapps.core.domain.holdApp.enable_qm]*}',
						'am':'{*[cn.myapps.core.domain.holdApp.enable_am]*}',
						'cm':'{*[cn.myapps.core.domain.holdApp.enable_cm]*}',
						'km':'{*[cn.myapps.core.domain.holdApp.enable_km]*}'}" />
						<button type="button" id="btn_configureKmRoles" onclick="configureKmRoles()">{*[cn.myapps.core.sysconfig.km.role_manage]*}</button>
				</td>
			</tr>
		</table>
	</div>
		
	<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.holdApp.title.search_application]*}">
			<div class="navigation_title">
			<span>{*[cn.myapps.core.domain.holdApp.custom_application]*}</span>
			<table class="table_noborder" >
				<tr><td class="head-text">
					{*[cn.myapps.core.domain.holdApp.application_name]*}:	<input pid="searchFormTable" title="{*[cn.myapps.core.domain.holdApp.title.by_application_name]*}" class="justForHelp input-cmd" type="text" name="sm_name" id="sm_name" 
						value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Description]*}:	<input pid="searchFormTable" title="{*[cn.myapps.core.domain.holdApp.title.by_application_description]*}" class="justForHelp input-cmd" type="text" name="sm_description" id="sm_description"
						value='<s:property value="#parameters['sm_description']" />' size="10" />
					<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.holdApp.title.search_application]*}" class="justForHelp button-cmd" type="submit" value="{*[Query]*}" />
					<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				<tr><td>
			</table>
			</div>
		</div>
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[cn.myapps.core.domain.holdApp.application_name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[Description]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
							field="activated" css="ordertag">{*[State]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td><s:property value="name" /></td>
					<td><s:property value="description.length()>40?description.substring(0,40)+'...':description" /></td>
					<td>
						<s:if test="activated">
							{*[cn.myapps.core.domain.holdApp.activation]*}
						</s:if>
						<s:elseif test="!activated">
							{*[cn.myapps.core.domain.holdApp.disable]*}
						</s:elseif>
					</td>
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
</s:form>
</div>
</body>
</o:MultiLanguage></html>
