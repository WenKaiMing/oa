<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper"	id="mh" />
<s:bean name="cn.myapps.core.user.action.UserUtil"	id="uh" />	
<html><o:MultiLanguage>
<%
	String contextPath = request.getContextPath();
	WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
%>
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<s:bean id="suh" name="cn.myapps.core.superuser.action.SuperUserHelper" />
<head>
<title>{*[cn.myapps.core.superuser.super_user_information]*}</title>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/dtree.js"/>'></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value='/script/help.js'/>"></script>
<script>
function checkForm(){
	var _password=document.getElementsByName("_password")[0];
	var name=document.getElementsByName("content.name")[0];
	var loginno=document.getElementsByName("content.loginno")[0];
	if(name.value==null || name.value==""){
		alert("{*[cn.myapps.core.superuser.please_input_name]*}");
		return false;
	}else if(loginno.value==null || loginno.value==""){
		alert("{*[cn.myapps.core.superuser.please_input_loginno]*}");
		return false;
	}else if(_password.value==null || _password.value==""){
		alert("{*[cn.myapps.core.superuser.please_input_password]*}");
		return false;
	} else return true;
}
	function dosubmit(){
		if(checkForm()){
			var superadmin=document.getElementById("superadmin").checked;
			var domainadmin=document.getElementById("domainadmin").checked;
			var developers=document.getElementById("developers").checked;
			if(!superadmin && !domainadmin && !developers){
				alert("请选择用户类型");
				return false;
			}
			var btnSave=document.getElementById("btnSave");
			btnSave.disabled=true;
			document.forms[0].submit();
		}
	}
	
	//已选择的resource;
	var checkedList = new Array(); 
	var imageSrc = '<s:url value="/resource/images/loading.gif" />';
	var text = '{*[page.loading...]*}';
	var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';

	jQuery(document).ready(function(){
		window.top.toThisHelpPage("superuser_info");
		jQuery("#btnSave").attr("disabled",true);
		jQuery("#btnSave").attr("disabled",false);
		checkUserType();
	});

	function doExit(){
		//jQuery("input[name=_currpage]").val("1");
		document.forms[0].action='<s:url action="list"/>';
		document.forms[0].submit();
	}

</script>

</head>
<body id="superuser_info" style="margin: 0px;padding: 0px;">
<div class="ui-layout-center">
	<s:form name="formItem" action="save" method="post" validate="true" theme="simple">
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.superuser.super_user_information]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="btnSave" title="{*[Save]*}" class="justForHelp button-image" onClick="javascript:dosubmit();">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" id="Eixt" title="{*[Exit]*}" class="justForHelp button-image" onClick="doExit()">
							<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/basic.jsp" %>
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<table class="id1" width="100%">
			<tr>
				<td class="commFont">{*[User_Name]*}:</td>
				<td class="commFont">{*[Account]*}:</td>
			</tr>
			<tr>
				<td id="SuperUser_Name" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_name]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple" name="content.name" /></td>
				<td id="SuperUser_Account" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_account]*}" class="justForHelp"><s:textfield
					cssClass="input-cmd" theme="simple"
					name="content.loginno" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[Password]*}:</td>
				<td class="commFont">{*[Email]*}:</td>
			</tr>
			<tr>
				<td id="SuperUser_Password" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_password]*}" class="justForHelp"><s:password cssClass="input-cmd" theme="simple" name="_password" show="true"/></td>
				<td id="SuperUser_Email" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_email]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple" name="content.email" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[Status]*}:</td>
				<% 
				
				if (user.isSuperAdmin()){ %>
				<td class="commFont">
				<script>
	
	function checkUserType() {
		var cbSuperAdmin=document.getElementById("superadmin");
		var cbDomainAdmin=document.getElementById("domainadmin");
		var cbDeveloper=document.getElementById("developers");
		//var sdomainPermission = document.getElementById("domainPermission");
		//var domain_level_text = document.getElementById("domain_level_text");
		//var domain_level = document.getElementById("domain_level");
		if (cbSuperAdmin.checked) {
			cbDomainAdmin.checked = false;
			cbDomainAdmin.disabled = true;
			cbDeveloper.checked = false;
			cbDeveloper.disabled = true;
			//sdomainPermission.options[0].selected = true;
			//domain_level_text.style.display = 'none';
			//domain_level.style.display = 'none';
		}else if (cbDomainAdmin.checked){
			//domain_level_text.style.display = 'block';
			//domain_level.style.display = 'block';
			cbDomainAdmin.disabled = false;
			cbDeveloper.disabled = false;
		}
		else {
			//sdomainPermission.options[0].selected = true;
			//domain_level_text.style.display = 'none';
			//domain_level.style.display = 'none';
			cbDomainAdmin.disabled = false;
			cbDeveloper.disabled = false;
		}
	}
	
	</script>
				{*[cn.myapps.core.domain.holdAdmin.user_type]*}: </td>
				<% }else{ %>
				 <td>&nbsp;</td>
				 <%} %>
			</tr>
			<tr>
				<td id="SuperUser_Status" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_status]*}" class="justForHelp"><s:radio
					label="%{getText('core.user.state')}" name="_strstatus"
					theme="simple"
					list="#{'false':'{*[Disable]*}','true':'{*[Enable]*}'}" /></td>
				<%if (user.isSuperAdmin()) {%>
				<td id="SuperUser_Type" pid="contentTable" title="{*[cn.myapps.core.superuser.content.title.super_user_type]*}" class="justForHelp">
				<s:checkbox id="superadmin" label="Super Administrators" onclick="checkUserType();"  name="content.superAdmin" />{*[SuperAdmin]*}
				<s:checkbox id="domainadmin" label="Domain Administrators" onclick="checkUserType();" name="content.domainAdmin"  />{*[DomainAdmin]*}
				<s:checkbox id="developers" label="Developers" onclick="checkUserType();" name="content.developer"  />{*[Developer]*}
				 </td>
				 <%}else{ %>
				 <td>&nbsp;</td>
				 <%} %>
			</tr>
			<!--	<tr>
				 <td align="right" class="commFont"><div id ="domain_level_text" style="display:none">
				{*[cn.myapps.core.superuser.content.Domain_Level]*}: </div></td>
				<td align="left" class="commFont">
				<div id ="domain_level" style="display:none">
				<s:select id ="domainPermission" 
					theme="simple" label="{*[cn.myapps.core.superuser.content.Domain_Level]*}"
					name="content.domainPermission" list="#uh.getDomainPermission()" /></div>
				</td>
			</tr>	 -->		
				
		</table>
	</div>
</s:form>
</div>
</body>

</o:MultiLanguage></html>