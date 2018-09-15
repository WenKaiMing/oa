<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%>
<%@ page import="cn.myapps.core.role.action.RoleHelper"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>

<%
	String contextPath = request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_USER);
	//request.setAttribute("fieldExtendses", fieldExtendses);
	DomainHelper dh = new DomainHelper();
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%><html>
<o:MultiLanguage>
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<s:bean id="RoleHelper" name="cn.myapps.core.role.action.RoleHelper" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper"	id="mh" /> 
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#parameters.domain" />
</s:bean>
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />
<head>
<title>{*[cn.myapps.core.domain.userEdit.user_information]*}</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main_core.css'/>" type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
	<link rel="stylesheet" href="<s:url value='/script/jstree/themes/default/style.min.css'/>" type="text/css" />
	<script type="">
		var contextPath='<%=contextPath%>';
	</script>
	<script src="<s:url value='/script/help.js'/>"></script>
	<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="dtree-user.js"/>'></script>
	<script src='<s:url value="/script/dtree/contextmenu.js"/>'></script>
	<script src='<s:url value="/script/datePicker/WdatePicker.js"/>' ></script>
	<script src='<s:url value="/script/jstree/jstree.min.js"/>' ></script>
	<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
<script>
var departmentRemindedInformation = '{*[cn.myapps.core.domain.userEdit.tips.please_select_department]*}';
var def = "({*[Default]*})";
	
function dosubmit(url){
	if(checkStringAsDefault() && checkIsNumber()){
		var deps = document.getElementsByName("content.defaultDepartment")[0];
		if(deps.value==null || deps.value==""){
			alert("{*[cn.myapps.core.user.tip.defaultdepartment]*}");
            return;
			}

		var tel = document.getElementsByName("content.telephone")[0];
		if(tel.value!=null && tel.value!=""){
			var re = /^[1]\d{10}$|^([6|9])\d{7}$|^[6]([8|6])\d{5}$/;
			if(re.test(tel.value)){    
		    }else{
		    	alert("{*[cn.myapps.core.user.tip.phone1]*}");
	            return;
		    }
		}
		
		var tel2 = document.getElementsByName("content.telephone2")[0];
		if(tel2.value!=null && tel2.value!=""){
			var re = /^[1]\d{10}$|^([6|9])\d{7}$|^[6]([8|6])\d{5}$/;
			if(re.test(tel2.value)){    
		    }else{
		    	alert("{*[cn.myapps.core.user.tip.phone2]*}");
	            return;
		    }
		}
		 
		var email = document.getElementsByName("content.email")[0];
		if(email.value!=null && email.value!=""){
			var re = /^(\w-*\.*)+@(\w-?)+([\.\-\w{2,}])+$/;
			if(re.test(email.value)){    
		    }else{
		    	alert("{*[cn.myapps.core.user.tip.email]*}");
	            return;
		    }
		}
		 
		    
		
		var calendarType = document.getElementsByName("content.calendarType")[0];
		if(calendarType.value==null || calendarType.value==""){
			alert("{*[cn.myapps.core.user.tip.calendartype]*}");
            return;
			}
		
		var btnSave=document.getElementById("btnSave");
		var btnSaveNew=document.getElementById("btnSaveNew");
		var pw=document.getElementById("_password");
		if (url == "saveAndNew") {
			document.forms[0].action="saveAndNew.action";
		}
		if(pw.value.length >= 0){
			if(pw.value.length == 0){
				document.getElementById("_password").value = "88888888qqqq";
			}
			btnSave.disabled=true;
			btnSaveNew.disabled=true;
			document.forms[0].submit();
		}else{
			alert("{*[cn.myapps.core.domain.userEdit.tips.page_login_password]*}");
		}
	}
}

function doexit(){
	var page = contextPath + "/core/user/treelist.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>&_orderby=orderByNo&_orderby=id";
	//window.parent.document.getElementById("userFrame").src=page;
	//===========firefox兼容性修改--start=================
	var parentIframe = window.parent.document.getElementById("userFrame");
	var divParent = jQuery(parentIframe).parent();
	var strIframe = '<iframe width="100%" height="100%" frameborder="0"'; 
		strIframe += ' name="userFrame" id="userFrame" src="' + page  + '"></iframe>';
	jQuery(divParent).html(strIframe);
	//===========firefox兼容性修改--end=================
}

//去两端空格   
String.prototype.trim = function(){   
	return this.replace(/^\s+|\s+$/g,"");   
};  

//检查用户中名称中是否包含()字符
function checkStringAsDefault(){
	var s =document.getElementById("content.name").value;
	document.getElementById("content.name").value=s.trim();
	s = document.getElementById("content.name").value;
	/*因外企需要用到用户名如：ZhangSan(张三),此校验去掉
	if(s.indexOf("(")!=-1){
		alert("{*[cn.myapps.core.domain.department.can_not_have_keyword]*} (  ");
		return false;
	}else if(s.indexOf(")")!=-1){
		alert("{*[cn.myapps.core.domain.department.can_not_have_keyword]*} )  ");
		return false;
	}
	*/
	return true;
}
//检查排序号是否为数字类型
function checkIsNumber(){
	var obj = document.getElementsByName('content.orderByNo');
	var regex = /^[0-9]*$/;
	if(regex.test(obj[0].value)){
		return true;
	}else{
		alert("{*[cn.myapps.core.domain.userEdit.tips.orderbyno_legal]*}!");
		return false;
	}
}

function initLockFlag(){
	//var sa = "<s:property value = 'content.lockFlag'/>";
	var sa = '<s:property value="#userUtil.findUserLockFlag(content.id)" />';
	var name = document.getElementsByName("content.name")[0].value;
	if(sa=="1"||name==""){
		document.getElementsByName("content.lockFlag")[0].checked = true;
	}else{
		document.getElementsByName("content.lockFlag")[1].checked = true;
	}	
}

</script>
<script>
//已选择的resource;
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';

jQuery(document).ready(function(){
	initLockFlag();
	jQuery("#btnSave").attr("disabled",true);
	//showDepartmentDlg();
	//selectRole();//初始化角色
	jQuery("#btnSave").attr("disabled",false);
	window.top.toThisHelpPage("domain_user_info");
	//dtreeMenu();
	initSuperiorText();
	initProxyUserText();
	//setHideRole();//隐藏禁用软件的角色
	//treeload();
	
	//selectKmRole();
	
	//角色
	var userRoleApp = jQuery("#_appJson").val();
	var userRole = jQuery("#_roleJson").val();
	var kmRoleJson = jQuery("#_kmRoleJson").val();
	var kmRole = jQuery("#_kmRole").val();
	
	if (userRole.trim()==""){
		Role.initAppList([]);
		Role.initRole([]);
	}
	else {
		Role.initAppList(eval(userRoleApp));
		Role.initRole(eval(userRole));
	}
	
	<% 
	if(dh.getModuleConfigByDomain(domain,SystemModuleConfig.KM)){
	%>
	    KmConfig = true;
		//初始化KM
		Role.initKmRoleApp();
		if(kmRole.trim() != "[]"){
			Role.initKmRole(eval(kmRoleJson),eval(kmRole));
		}
	<%}%>
	
	//部门
	var userDepartment = jQuery("#_departmentJson").val();
	if (userDepartment.trim()==""){
		Department.initDepartment([]);
	}
	else {
		Department.initDepartment(eval(userDepartment));
	}
});

var depttree;



function doUsbKeyCfg(){
	
  	var url =  contextPath + "/core/user/ntko_usbkey_tool.jsp?_userId=" + "<s:property value='content.id' />"+"&_userName=" + "<s:property value='content.name' />";
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '{*[core.usbkey.cfg]*}',
			close: function(dataSource) {
			}
	});
}

</script>
</head>
<body id="domain_user_info" class="contentBody" style="width:99%;margin-bottom:5px;overflow:auto;">
<div class="contextMenu" id="jqueryDtreeMenu" style="display:none">
    <ul>
      <li id="defaultDepartment"><img src="<s:url value="/resource/images/dtree/default.png"/>"/>{*[cn.myapps.core.domain.userEdit.make_default]*}</li>
    </ul>
</div>
<s:form name="formItem" action="save" method="post" validate="true" theme="simple">
	<input type="hidden" name="content.domainid" value="<s:property value='#parameters.domain' />" />
	<s:hidden name="content.defaultApplication" theme="simple" />
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.userEdit.user_information]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
					 <s:if test="#usbKeyUtil.isNtkoUsbKeyEnable()">
						<button type="button" id="btnUsbkeyCfg" title="{*[core.usbkey.cfg]*}" class="justForHelp button-image" onClick="javascript:doUsbKeyCfg()"><img src="<s:url value='/resource/imgnew/act/act_0.gif'/> ">{*[core.usbkey.cfg]*}</button>
					</s:if>
						<button type="button" id="btnSaveNew" title="{*[Save&New]*}" class="justForHelp button-image" onClick="javascript:dosubmit('saveAndNew')"><img src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
						<button type="button" id="btnSave" title="{*[Save]*}" class="justForHelp button-image" onClick="javascript:dosubmit();"><img	src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" id="exitbtn" title="{*[Exit]*}" class="justForHelp button-image" onClick="doexit();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/basic.jsp"%> 
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<s:hidden name="content.favoriteContacts" />
		<s:hidden name="content.avatar" />
		<s:hidden name="content.signs" />
		<table class="table_noborder id1">
			<tr>
				<td class="commFont"><span style="color:red;"> * </span>{*[User_Name]*}:</td>
				<td class="commFont"><span style="color:red;"> * </span>{*[Account]*}:</td>
			</tr>
			<tr>
				<td id="name_h" pid="contentTable" title="{*[User_Name]*}" class="justForHelp">
					<s:textfield cssClass="input-cmd" theme="simple" name="content.name" id="content.name" onblur="checkStringAsDefault()" autocomplete = "off" />
<%-- 					<s:checkbox id="userInfoPublic" label="userInfoPublic" name="content.userInfoPublic"  />{*[允许查看非公开信息]*} --%>				</td>
				<td id="loginno_h" pid="contentTable" title="{*[Account]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.loginno" autocomplete = "off"/></td>
			</tr>
			<tr>
				<td class="commFont"><span style="color:red;"> * </span>{*[Password]*}:</td>
				<td class="commFont">{*[Email]*}:</td>
			</tr>
			<tr>
				<td id="password_h" title="{*[Password]*}" class="justForHelp">
				<input type="password" value="password" disabled id="autocompletePass" /><!-- 为解决360浏览器自动填充问题,提交时不用 -->
				<s:password cssClass="input-cmd" theme="simple"
					name="_password" id="_password" showPassword="true"/>
					</td>
				<td id="email_h" pid="contentTable" title="{*[Email]*}" class="justForHelp">
					<s:textfield cssClass="input-cmd" theme="simple" name="content.email" autocomplete = "off"/>
					<s:checkbox id="emailPublic" label="emailPublic" name="content.emailPublic"  />{*[公开]*}
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[Mobile]*}:</td>
				<td class="commFont"><span style="color:red;"> * </span>{*[Calendar]*}:</td>
			</tr>
			<tr>
				<td id="telephone_h" pid="contentTable" title="{*[Mobile]*}" class="justForHelp">
					<s:textfield cssClass="input-cmd" theme="simple" name="content.telephone" autocomplete = "off"/>
				 	<s:checkbox id="telephonePublic" label="telephonePublic" name="content.telephonePublic"  />{*[公开]*}
					</td>
				<td id="calendarType_h" pid="contentTable" title="{*[Calendar]*}" class="justForHelp">
					<s:hidden cssClass="input-cmd" theme="simple" 
					name="content.calendarType" id="content.calendarType"/>
					<input id="calendarTypeName" name="calendarTypeName" readonly="readonly" class="input-cmd" style="width:250px;" value='{*[<s:property value="#ch.getCalendarById(content.calendarType)" />]*}' />
					<input type="button" value="..." onclick="calendarTypeSelect();">	
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[Mobile]*}2:</td>
				<td class="commFont">{*[Superior]*}:</td>
			</tr>
			<tr>
				<td id="telephone_h2" pid="contentTable" title="{*[Mobile]*}2" class="justForHelp">
					<s:textfield cssClass="input-cmd" theme="simple" name="content.telephone2" />
					<s:checkbox id="telephonePublic2" label="telephonePublic2" name="content.telephonePublic2"  />{*[公开]*}
				</td>
				<td id="superiorid_h" pid="contentTable" title="{*[Superior]*}" class="justForHelp">
					<s:hidden name="reportTree"/>
					<input id="superiorname" readonly="readonly" class="input-cmd" style="width:250px;"/>
					<s:hidden id="superiorid" name="superiorid"/>
					<input type="button" value="..." onclick="superiorSelect();">
				<script type="text/javascript">

				function initSuperiorText(){
					var superiorid = jQuery("[name='superiorid']").val();
					var superiorname = '<s:property value="#userUtil.findUserName(superiorid)" />';
					if(superiorid==""){
						jQuery("#superiorname").val("{*[none]*}");
					}else{
						jQuery("#superiorname").val(superiorname);
					}
				}
				
				function superiorSelect(){
					var url = contextPath + "/core/user/selectUser4Superior.jsp";
					var contentId = jQuery("[name='content.id']").val();
					OBPM.dialog.show({
						width : 610,
						height : 450,
						url : url,
						args : {
							"parentObj" : window,
							"targetid" : "superiorid",
							"receivername" : "superiorname",
							"domainid" : '<%=domain%>',
							"contentId": contentId
						},
						title : '{*[cn.myapps.core.domain.userEdit.superior_select]*}',
						close : function(result) {
							//alert(result);
						}
					});
				}

				function agentStart(){
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'});
				}

				function agentEnd(){
					var time = jQuery("#11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime").val();
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'time',maxDate:'2050-12-30',skin:'whyGreen'});
				}
				</script>
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.proxy_user]*}:</td>
				<td class="commFont">{*[Remarks]*}：</td>
			</tr>
			<tr>
				<td id="proxyUser_h" pid="contentTable" title="{*[cn.myapps.core.domain.userEdit.proxy_user]*}" class="justForHelp">
					<input id="proxyusername" readonly="readonly" class="input-cmd" style="width:250px;"/>
					<s:hidden name="allUsers"/>
					<s:hidden id="_proxyUser" name="_proxyUser"/>
					<input type="button" value="..." onclick="proxyUserSelect();">
				<script type="text/javascript">

				function initProxyUserText(){
					var _proxyUser = jQuery("[name='_proxyUser']").val();
					var proxyusername = '<s:property value="#userUtil.findUserName(_proxyUser)" />';			
					if(_proxyUser==""){
						jQuery("#proxyusername").val("{*[none]*}");
					}else{					
						jQuery("#proxyusername").val(proxyusername);
					}
				}
				
				function proxyUserSelect(){
					var url = contextPath + "/core/user/selectUser4Proxy.jsp";
					var contentId = jQuery("[name='content.id']").val();
					OBPM.dialog.show({
						width : 690,
						height : 500,
						url : url,
						args : {
							"parentObj" : window,
							"targetid" : "_proxyUser",
							"receivername" : "proxyusername",
							"domainid" : '<%=domain%>',
							"contentId": contentId
						},
						title : '{*[cn.myapps.core.domain.userEdit.proxy_user_select]*}',
						close : function(result) {
							//alert(result);
						}
					});
				}

				function calendarTypeSelect(){
					var domainId = document.getElementsByName("content.domainid")[0].value;
					var calendarTypeId = document.getElementsByName("content.calendarType")[0].value;
					var url = contextPath + "/core/calendar/calendarlistSelect.action?domain="+domainId;
					if(calendarTypeId!=null&&calendarTypeId!=""){
							url=url+"&calendarTypeId="+calendarTypeId;
						}
					var contentId = jQuery("[name='content.id']").val();
					OBPM.dialog.show({
						width : 610,
						height : 450,
						url : url,
						args : {
							"parentObj" : window,
							"targetid" : "content.calendarType",
							"receivername" : "calendarTypeName",
							"domainid" : '<%=domain%>',
							"contentId": contentId
						},
						title : '{*[cn.myapps.core.domain.userEdit.workCalendar_list_select]*}',
						close : function(result) {
							//alert(result);
						}
					});
				}

				function agentStart(){
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'});
				}

				function agentEnd(){
					var time = jQuery("#11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime").val();
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'time',maxDate:'2050-12-30',skin:'whyGreen'});
				}
				</script></td>
				<td id="Remarks_h" pid="contentTable" title="{*[Remarks]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.remarks" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.proxy_start_date]*}：</td>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.proxy_end_date]*}：</td>
			</tr>
			<tr>
				<td>
					<input style="width: 280px;" type='text' id='11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime' name='startProxyTime' class='Wdate' onfocus="agentStart();" value='<s:property value="startProxyTime" />'/>
				</td>
				<td>
					<input style="width: 280px;" type='text' id='11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_endProxyTime' name='endProxyTime' class='Wdate' onfocus="agentEnd();"  limit='true' value='<s:property value="endProxyTime" />'/>
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.setup_domain_admin_authority]*}：</td>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.IM_setting]*}：</td>
			</tr>
			<tr>
				<td>
					<s:checkbox id="domainUser" label="domainUser" name="content.domainUser"  />{*[DomainAdmin]*}
				 </td>
				 <td>
				 	<s:checkbox id="useIM" label="useIM" name="content.useIM"  />{*[cn.myapps.core.domain.userEdit.use_IM]*}
				 </td>
			</tr>
			<tr>
				<td class="commFont">{*[设置部门接口人权限]*}:</td>
				<td class="commFont">{*[受保护信息设置]*}：</td>
			</tr>
			<tr>
				<td>
					<s:checkbox id="liaisonOfficer" label="liaisonOfficer" name="content.liaisonOfficer"  />{*[部门接口人]*}
				 </td>
				 <td><div id="permission_type_option"><s:radio
							name="content.permissionType" theme="simple"
							list="#{'public':'{*[在通讯录中公开个人信息]*}','private':'{*[在通讯录中屏蔽个人信息]*}'}"  /></div></td>
			</tr>
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.userEdit.setup_order_number]*}:</td>
				<TD class="commFont">{*[cn.myapps.core.domain.userEdit.account_locked]*}：</TD>
			</tr>
			<tr>
				<td>
					<s:textfield cssClass="input-cmd" theme="simple"
					name="content.orderByNo" />
				 </td><TD><s:radio name="content.lockFlag"  theme="simple" 
					list="#{'1':'{*[cn.myapps.core.domain.userEdit.unlocked]*}','0':'{*[cn.myapps.core.domain.userEdit.locked]*}'}" />
					</TD>
			</tr>
			<tr>
				<td>{*[cn.myapps.core.user.isdimission]*}：</td>
				<td class="commFont">{*[Status]*}:</td>
			</tr>
			<tr>
				<td>
					<s:if test="content.loginno == null ">
						<s:radio theme="simple" name="content.dimission" list="#{'1':'{*[cn.myapps.core.user.isdimission.on_job]*}','0':'{*[cn.myapps.core.user.isdimission.dimission]*}'}" value="1" />
					</s:if>
					<s:else>
						<s:radio theme="simple" name="content.dimission" list="#{'1':'{*[cn.myapps.core.user.isdimission.on_job]*}','0':'{*[cn.myapps.core.user.isdimission.dimission]*}'}" />
					</s:else>
				</td>
				<td id="strstatus_h" pid="contentTable" title="{*[Status]*}" class="justForHelp"><s:radio name="_strstatus" theme="simple"
					list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" /></td>
			</tr>
			<!-- 扩展字段开始 -->
			<%
			UserVO user = (UserVO) request.getAttribute("content");
			FieldExtendsHelper helper = new FieldExtendsHelper();
			List<FieldExtendsVO> fes = new ArrayList<FieldExtendsVO>();
			for(int i=0;i<fieldExtendses.size();i++){
				FieldExtendsVO fevo = fieldExtendses.get(i);
				if(fevo != null && fevo.getEnabel()){
					fes.add(fevo);
				}
			}
			out.append(helper.getFieldHtml(fes, user));
			%>
			<!-- 扩展字段结束 -->
			<tr>
				<td class="commFont" style="padding-top: 10px;"><span style="color:red;"> * </span>{*[Department]*}:<font color="green">(绿色为默认部门)</font>
					<input type="button" value="选择部门" onclick="Department.showDepartmentDlg()" /><!--<span class="tipsStyle"> {*[page.user.defaultdepartment.required]*}</span>-->
				</td>
				<td class="commFont" style="padding-top: 10px;">{*[Roles]*}:
					<input type="button" value="选择角色" onclick="Role.showRoleDlg()" />
				</td>
			</tr>
			<tr style="vertical-align: top;">
				<td id="Department_h" pid="contentTable" class="justForHelp">
				<input type="hidden" value="" name="_departmentids" id="_departmentids" /> 
				<s:hidden cssClass="input-cmd" theme="simple" name="content.defaultDepartment" id="content.defaultDepartment"/>
				<textarea id="_departmentJson" name="_departmentJson" style="display:none">
				[<s:iterator value="content.departments" id='dept' status='status'>{"id":"<s:property value='#dept.id'/>","name":"<s:property value='#dept.name'/>"}<s:if test="!#status.last">,</s:if></s:iterator>]</textarea>
				<table style="width:300px;vertical-align:top;">
					<tr>
						<td style="padding:0px">
							
							<div id="department-select">
							</div>
						</td>
						
					</tr>
				</table>
				<style>
				#department-select .departmentLi{
					margin: 8px 8px 0px 0px;
					padding:5px 8px;
					background:#fff;
					border:1px solid #999;
					border-radius:2px;
					display:inline-block; 
					*zoom:1;
					*display:inline;
					position: relative;
					cursor: pointer;
				}
				#department-select .departmentLi.defaultDepartment{
					background:#008000;
					color:#fff;
					border:1px solid #006900;
				}
				
				#department-select span.department-clear{
				    cursor: pointer;
				    margin-left: 10px;
				}
				
				#department-select .defaultdepartment-txt {
					position: absolute;
				    left: 0px;
				    top: 30px;
				    background-color: rgb(0, 0, 0);
				    white-space: nowrap;
				    color: #fff;
				    padding: 3px;
				    border-radius: 2px;
				    z-index:10;
				}
				#autocompletePass{
					width:0px;
					border-color:transparent;
					background:#fff;
				}
				#_password {
					margin-left:-6px;
				}
				</style>
				<script type="text/javascript">
				
				var Department = function(me){
					return me = {
						showDepartmentDlg : function(){
							//treeload();
							var url = contextPath + "/core/department/department-iframe.jsp?domain=<%=domain%>";
							var departmentJson = jQuery("[name='_departmentJson']").val();
							OBPM.dialog.show({
								width : 360,
								height : 430,
								url : url,
								args : {
									"parentObj" : window,
									"targetid" : "_proxyUser",
									"receivername" : "proxyusername",
									"domainid" : '<%=domain%>',
									"contentId": departmentJson
								},
								title : '选择部门',
								close : function(result) {
									me.addDepartments(result);
								}
							});
						},
						
						addDepartmentOne : function(dept, isDefaultDept) {
							var departmentLi = "<div class='departmentLi' title='点击设为默认部门' type='button' _id='"+dept.id+"'>"
							+dept.name
							//+"<span class='defaultdepartment-txt' style='display:none'>↑ 点击设为默认部门</span>"
							+"<span title='删除' class='department-clear'>X</span></div>";
							var $li = jQuery(departmentLi);
							if (isDefaultDept){
								$li.addClass("defaultDepartment");						
							}
							$li.click(function(){me.defaultDepartmentSelect(this)})
								.mouseover(function(){me.defaultDepartmentOver(this)})
								.mouseout(function(){me.defaultDepartmentOut(this)});
							$li.find(".department-clear").click(function(){me.removeDepartment(this)});
							jQuery("#Department_h").find("#department-select").append($li)
						},
						
						initDepartment : function(result) {
							var $departmentBox = jQuery("#Department_h").find("#department-select");					
							for(var i=0; i < result.length; i++){
								//判断部门为空
								var isDefaultDept = false;	
								isDefaultDept = jQuery(".input-cmd[name='content.defaultDepartment']").val()==result[i].id;
								me.addDepartmentOne(result[i], isDefaultDept);
							}	
							me.syncDepartmentField();
						},
						
						syncDepartmentField : function() {
							var $deptBox = jQuery("#Department_h").find("#department-select");
							var $deptidsField = jQuery("#_departmentids");
							var $defaultDeptField = jQuery(".input-cmd[name='content.defaultDepartment']");
			
							var deptids = [];
							$deptBox.find(".departmentLi").each(function(){
								deptids.push(jQuery(this).attr("_id"));
							});	
							$deptidsField.val(deptids.join(";"));
							$defaultDeptField.val($deptBox.find(".defaultDepartment").attr("_id"));
						},
						
						addDepartments : function(result){
							var $departmentBox = jQuery("#Department_h").find("#department-select");					
							for(var i=0; i < result.length; i++){
								//判断部门为空	
								if($departmentBox.find(".departmentLi[_id='"+result[i].id+"']").size()==0){
									var isDefaultDept = false;
									isDefaultDept = jQuery(".departmentLi").size()==0;
									me.addDepartmentOne(result[i], isDefaultDept);
								}
							};
							me.syncDepartmentField();
						},
						
						defaultDepartmentSelect : function(obj){
							jQuery(obj).siblings().removeClass("defaultDepartment");
							jQuery(obj).addClass("defaultDepartment");
							me.syncDepartmentField();
						},
						defaultDepartmentOver : function(obj){
							jQuery(obj).find(".defaultdepartment-txt").show();
						},
						defaultDepartmentOut : function (obj){
							jQuery(obj).find(".defaultdepartment-txt").hide();
						},
						removeDepartment :function (obj){
							jQuery(obj).parent().remove();
							if(jQuery("#department-select").find(".defaultDepartment").size()==0){
								jQuery("#department-select").find(".departmentLi:eq(0)").addClass("defaultDepartment");
							}
							me.syncDepartmentField();
						}
					}
				}();
				
				</script>
				
				
				
				<table cellpadding="0" cellspacing="0" style="vertical-align: top;">
					<tr>
						<td>
						<div id="deplist" class="commFont"></div>
						</td>
					</tr>
				</table>
				</td>
				<td style="vertical-align: top;" id="Roles_h" pid="contentTable" class="justForHelp">
					<div id="_roleidsBox"></div>
					<textarea id="_appJson" name="_appJson" style="display:none">
				[<s:iterator value="_applicationlist" id='applicationlist' status='status'>{
					"id":"<s:property value='#applicationlist.id'/>",
					"name":"<s:property value='#applicationlist.name'/>"
				}<s:if test="!#status.last">,</s:if></s:iterator>]
				</textarea>
				<textarea id="_roleJson" name="_roleJson" style="display:none">[<s:iterator value="content.roles" id='role' status='status'>{"id":"<s:property value='#role.id'/>","name":"<s:property value='#role.name'/>","applicationid":"<s:property value='#role.applicationid'/>"}<s:if test="!#status.last">,</s:if></s:iterator>]</textarea>
				<textarea id="_kmRoleJson" name="_kmRoleJson" style="display:none">[<s:iterator value="_kmRoles" id='role' status='status'>{"id":"<s:property value='#role.id'/>","name":"{*['<s:property value='#role.name'/>']*}","level":"<s:property value='#role.level'/>"}<s:if test="!#status.last">,</s:if></s:iterator>]</textarea>	
				<textarea id="_kmRole" name="_kmRole" style="display:none">[<s:iterator value="#userUtil.getKmRolesids(content.id,content.domainid)" id='role' var="roleId" status='status'>{"id":"<s:property value='roleId'/>"}<s:if test="!#status.last">,</s:if></s:iterator>]</textarea>	
					<table style="width:300px;vertical-align:top;">
						<tr>
							<td style="padding:0px">
								<div id="roles-select"></div>
							</td>
						</tr>
					</table>
					<style>
					#roles-select .apptitle{
						margin-top: 8px;
					    border-bottom: 1px solid #999;
					    padding-bottom: 8px;
					    color:green;
					}
					#roles-select .roleLi{
						margin: 8px 8px 0px 0px;
						padding:5px 8px;
						background:#fff;
						border:1px solid #999;
						border-radius:2px;
						display:inline-block; 
						*zoom:1;
						*display:inline;
						position: relative;
						cursor: pointer;
					}
					#roles-select span.role-clear{
					    cursor: pointer;
				    	margin-left: 10px;
					}
					
					
					</style>
					<script type="text/javascript">
									
				
				
					
					var Role = function(me){
						return me = {
							showRoleDlg : function(){
								//treeload();
								
								var arr = new Array();
								jQuery(".roleLi").each(function(){
									var str = "{'id':'"+ this.getAttribute("_id") +"','appId':'"+this.getAttribute("_appid")+"'}";
									arr.push(str);
								});
								var datas = "["+arr.toString()+"]";
								
								var kmJSON = jQuery("#_kmRoleJson").val();
								
								var url = contextPath + "/core/role/role-iframe.jsp?domain=<%=domain%>";
								OBPM.dialog.show({
									width : 360,
									height : 430,
									url : url,
									args:{
										data:datas,
										kmJSON:kmJSON
									},
									title : '选择角色',
									close : function(result) {
										if(result == null || result === undefined){ //取消按钮
											
										}else{//确认按钮
											me.clearRole();
											me.addRoles(result);
										}
									},
								});
							},
							
							
							
							addRoleOne : function(role) {
								var roleLi = "<div class='roleLi' type='button' _text='"+role.name+"' _appid='"+role.applicationid+"' _id='"+role.id+"'>"
								+role.name
								+"<span title='删除' class='role-clear'>X</span></div>";
								var $li = jQuery(roleLi);
								$li.find(".role-clear").click(function(){me.removeRole(this)});
								jQuery("#Roles_h").find("#roles-select").find(".apptitle[_id='"+role.applicationid+"']").after($li)
							},
							
							addAppOne : function(app) {
								var appLi = "<div class='apptitle' _id='"+app.id+"'>【"+app.name+"】</div>";
								var $li = jQuery(appLi);
								jQuery("#Roles_h").find("#roles-select").append($li);
							},
							
							initRole : function(result) {
								for(var i=0; i < result.length; i++){
									me.addRoleOne(result[i]);
								}	
								me.syncRoleField();
							},
							
							initAppList : function(result) {
								for(var i=0; i < result.length; i++){
									me.addAppOne(result[i]);
								}	
								me.syncRoleField();
							},
							
							syncRoleField : function() {
								var $roleBox = jQuery("#Roles_h").find("#roles-select");
								//var roleArr = [];
								jQuery("#Roles_h").find("#_roleidsBox").html("");
								$roleBox.find(".roleLi").each(function(){
									if(jQuery(this).attr('_appid') == "km_id"){   //KM角色
										var _kmRoleSelectItem = "<input type='hidden' name='_kmRoleSelectItem' id='"+jQuery(this).attr("_id")+"' value='"+jQuery(this).attr("_id")+"' />";
										jQuery("#Roles_h").find("#_roleidsBox").append(_kmRoleSelectItem);
									}else{   //用户角色
										var roleSelectItem = "<input type='hidden' name='_roleSelectItem' id='"+jQuery(this).attr("_id")+"' value='"+jQuery(this).attr("_id")+"' />";
										jQuery("#Roles_h").find("#_roleidsBox").append(roleSelectItem);
									}
								});	
							},
							
							addRoles : function(result){
								var $roleBox = jQuery("#Roles_h").find("#roles-select");
								for(var i=0; i < result.length; i++){
									//判断部门为空	
									if($roleBox.find(".roleLi[_id='"+result[i].id+"']").size()==0){
										me.addRoleOne(result[i]);
									}
								};
								me.syncRoleField();
							},
							
							removeRole :function (obj){
								jQuery(obj).parent().remove();
								me.syncRoleField();
							},
							clearRole:function(){
								jQuery('.roleLi').remove();
							},
							initKmRoleApp:function(){
								
								var appLi = "<div class='apptitle' _id='km_id'>【"+'{*[km.name]*}'+"】</div>";
								var $li = jQuery(appLi);
								jQuery("#Roles_h").find("#roles-select").append($li);
							},
							
							initKmRole: function(roleJson,result){
								for(var i=0; i < result.length; i++){
									for(var j = 0 ; j < roleJson.length ; j++){
										if(result[i].id == roleJson[j].id){
											var roleLi = "<div class='roleLi' type='button' _text='"+roleJson[j].name+"' _appid='km_id' _id='"+roleJson[j].id+"'>"
											+roleJson[j].name
											+"<span class='role-clear'>X</span></div>";
											var $li = jQuery(roleLi);
											$li.find(".role-clear").click(function(){me.removeRole(this)});
											jQuery("#Roles_h").find("#roles-select").find(".apptitle[_id='km_id']").after($li)
										}
									}
								}	
								me.syncRoleField();
							}
						}
					}();
					
					</script>
					
					
					
					<table cellpadding="0" cellspacing="0" style="vertical-align: top;">
						<tr>
							<td>
							<div id="deplist" class="commFont"></div>
							</td>
						</tr>
					</table>
					
					
					
					
					
					
					
					
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>