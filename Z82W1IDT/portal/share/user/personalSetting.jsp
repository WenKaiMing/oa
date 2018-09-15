<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper" %>
<%@page import = "cn.myapps.core.deploy.application.ejb.ApplicationVO" %>
<%@page import = "cn.myapps.core.deploy.application.action.ApplicationHelper" %>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import = "cn.myapps.core.email.email.ejb.EmailUserProcessBean,cn.myapps.core.email.email.ejb.EmailUser" %>

<%@ page import="java.util.*" %>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ih" />
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#session.FRONT_USER.domainid" />
</s:bean>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);

	int usStatus=webUser.getUserSetup()==null? 1:((int)webUser.getUserSetup().getStatus());
	int useHomePage=webUser.getUserSetup()==null? 0:(int)webUser.getUserSetup().getUseHomePage();
	String uskin=webUser.getUserSetup()==null? (String) session.getAttribute("SKINTYPE"):(String)webUser.getUserSetup().getUserSkin();
	//String domainid = (String) session.getAttribute(Web.SESSION_ATTRIBUTE_DOMAIN);
	
	String applicationid = request.getParameter(Web.REQUEST_ATTRIBUTE_APPLICATION);

	 if (applicationid == null || applicationid.isEmpty()) {
		 Collection<ApplicationVO> apps = new ApplicationHelper().getListByWebUser(webUser);
		 for (Iterator<ApplicationVO> iterator = apps.iterator(); iterator.hasNext();) {
			ApplicationVO applicationVO = (ApplicationVO) iterator
					.next();
			applicationid = applicationVO.getApplicationid();
			break;
		}
	 }
	 
	String domainid = webUser.getDomainid();
	String skinset = request.getParameter("skinset");
	String userId = webUser.getId();
%>
<head>
<title>{*[User_Management]*}</title>
<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css">
<!--[if IE]>
	<link rel="stylesheet" href="<s:url value='/resource/css/main-front-ie.css'/>" type="text/css">
<![endif]-->
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/portal/share/script/dtree.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script>
	var contextPath = '<%=request.getContextPath()%>';
	
	function selectRidoSkin(){
		var uskin='<%=uskin%>';
		$(".selectSkin td").each(function(){

			//if(obj[i].value==uskin){
			//	obj[i].checked='checked';
			//}
			   if($(this).find("input[type='radio']").val()==uskin){
				   $(this).find("input[type='radio']").attr("checked",true);
				   $(this).find(".focusImg").css("display","block");
			   }
			 });
		$(".selectSkin td").click(function(){
			$(this).find("input[type='radio']").attr("checked",true);
			$(this).find(".focusImg").css("display","block");
			$(this).siblings().find(".focusImg").css("display","none");
		});
	}
	
	function adjustUserSetupPageLayout(){
		/*
		var bodyH=jQuery("body").height();
		jQuery("#container").height(bodyH-22);
		jQuery("#container").width(jQuery("body").width());
		jQuery("#contentTable").height(jQuery("#container").height()-jQuery("activityTable").height()-10);
		
		jQuery("#contentRight").width(jQuery("#contentTable").width()-jQuery("#contentLeft").width()-10);
		jQuery("#contentLeft").height(jQuery("#contentTable").height());
		jQuery("#contentRight").height(jQuery("#contentTable").height());
		*/
	

		jQuery("#contentRight").width(jQuery("#contentTable").width()-jQuery("#contentLeft").width());
		if(jQuery.browser.msie){
			jQuery("#container").height(jQuery("body").height()-15);
			jQuery("#contentTable").height(jQuery("body").height());
			jQuery("#contentLeft").height(jQuery("#contentTable").height());
			jQuery("#contentRight").height(jQuery("#contentTable").height());
		}
		else{
			jQuery("#contentTable").height(jQuery("body").height());
			jQuery("#contentLeft").height(jQuery("#contentTable").height());
			jQuery("#contentRight").height(jQuery("#contentLeft").height());
		}
		jQuery("#workflowproxyframe").height(jQuery("#contentTable").height()-jQuery("#proxyusername_box").outerHeight());
		
	}
	
	function doSave(){
		if(typeof(parent.ifSaveForm) == "function"){
			if(!parent.ifSaveForm()){
				return;
			}
		}
		
		if(!checkPassword()){
			return false;
		}
		
		var tabDiv = jQuery(".selleftmenulist").attr("id");//选中的页签
		formItem.action = "savePersonal.action?&tab=" + tabDiv;
		formItem.submit();
	}
	
	function checkNameValue(){
		var userDefName = jQuery("userDefined.name").val();
		if(userDefName == null || userDefName == ""){
			alert("name");
		}
	}
	
	function checkPassword(){
		var originalPassword = jQuery("input[name='_originalPassword']").val();
		var password = jQuery("input[name='_password']").val();
		var comfirmPassword = jQuery("input[name='_comfirmPassword']").val();
		
		if(jQuery("input[name='_originalPassword']").val() != ""){
			if(jQuery("input[name='_password']").val() != jQuery("input[name='_comfirmPassword']").val()){
				alert("{*[cn.myapps.core.personalsettings.basic.lable.ComfirmAndPasswordNotSame]*}");
				return false;
			}
			if(jQuery("input[name='_password']").val() == "" || jQuery("input[name='_comfirmPassword']").val() == ""){
				alert("{*[cn.myapps.core.personalsettings.basic.lable.input_a_password]*}");
				return false;
			}
		} else {
			if(jQuery("input[name='_password']").val() != "" || jQuery("input[name='_comfirmPassword']").val() != ""){
				alert("{*[cn.myapps.core.personalsettings.basic.lable.input_a_password]*}");
				return false;
			}
		}
		if(password == "" && comfirmPassword == ""){
			password = "888888qqqq";
			comfirmPassword = "888888qqqq";
		}
		jQuery("input[name='_password']").val(password);
		jQuery("input[name='_comfirmPassword']").val(comfirmPassword);
		return true;
	}
	
	function checkIsEmail(obj){
		var email = obj.value;
		if(email!="" && email != null){
			var emailReg =/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		    if(!emailReg.test(email)){
				alert("{*[cn.myapps.core.personalsettings.tip.email_illegal]*}")
				var em = document.getElementsByName("content.email")[0];
				em.value ="";
			}
		}
	}
	
	function checkIsPhone(obj){
		var phone = obj.value;
		if(phone!="" && phone != null){
			var phoneReg =/^1\d{10}$/;
		    if(!phoneReg.test(phone)){
				alert("{*[cn.myapps.core.personalsettings.tip.phone_illegal]*}")
				var ph = document.getElementsByName("content.telephone")[0];
				ph.value ="";
			}
		}
	}
	
	//流程代理中切换软件
	function changeApplication(appid){
		jQuery("#workflowproxyframe").attr("src",contextPath+"/portal/workflow/runtime/proxy/list.action?application="+appid);
	}

	jQuery(document).ready(function(){
		//点击选中哪个皮肤样式
		selectRidoSkin();
		initProxyUserText();
		adjustUserSetupPageLayout();
		
		jQuery(".leftmenulist").click(function(){
			jQuery(".showcontent").attr("class","hidecontent");
			jQuery(".selleftmenulist").removeClass("selleftmenulist");
			jQuery(this).addClass("selleftmenulist");
			jQuery("#"+jQuery(this).attr("id")+"_div").attr("class","showcontent");

			if(jQuery(this).attr("id")=='userManage'){
				jQuery("#userframe").attr("src",contextPath+"/portal/superfront/user/list.action?domain=<%=domainid%>");
			}
			if(jQuery(this).attr("id")=='deptManage'){
				jQuery("#deptframe").attr("src",contextPath+"/portal/superfront/department/list.action?domain=<%=domainid%>");
			}
			if(jQuery(this).attr("id")=='roleManage'){
				jQuery("#roleframe").attr("src",contextPath+"/portal/superfront/role/list.action?mode=application&s|applicationid=<%=applicationid%>");
			}
			if(jQuery(this).attr("id")=='contacts'){
				jQuery("#contactsframe").attr("src",contextPath+"/portal/usergroup/view.action?domain=<%=domainid%>");
			}
			if(jQuery(this).attr('id')=='uWorkflowProxy'){
				//jQuery("#workflowproxyframe").attr("src",contextPath+"/portal/workflow/runtime/proxy/list.action?application=<%=applicationid%>");
				jQuery("input:radio[name='id']").first().trigger("click");
				jQuery("#workflowproxyframe").height(jQuery("#contentTable").height()-jQuery("#proxyusername_box").outerHeight()-jQuery("#uWorkflowProxy_box1").height()-jQuery("#uWorkflowProxy_box2").height()-20);
			}

		});
		
		//设置默认值
		var isUserdefinedVal = jQuery("#personUserDefined1").attr("checked");
		if(!isUserdefinedVal){
			jQuery("#personUserDefined0").attr("checked","true");
		}

		//设置默认选中页签 
		var tabDiv = '<%=request.getParameter("tab")%>';
		if(jQuery("#"+tabDiv)){
			jQuery("#"+tabDiv).click();
		}
		
	});
	
	jQuery(window).resize(function(){
		adjustUserSetupPageLayout();
	});
	
	//流程代理
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
		var uskin='<%=uskin%>';
		//var url = contextPath + "/portal/share/user/selectUser4Proxy.jsp";
		var url = contextPath + "/portal/share/component/dialog/selectUser4Proxy.jsp";
		var contentId = jQuery("[name='content.id']").val();
		var icons;
		var _path;
		if(uskin == "H5"){
			icons = "icons_4";
			_path = "../H5/resource/component/artDialog"
		}else{
			icons = "";
			_path = "";
		}
		OBPM.dialog.show({
			width : 682,
			height : 500,
			url : url,
			icon:icons,
			path: _path,
			args : {
				"parentObj" : window,
				"targetid" : "_proxyUser",
				"receivername" : "proxyusername",
				"domainid" : '<%=request.getParameter("domain")%>',
				"contentId": contentId,
				"selectMode": 'selectOne'
			},
			title : '{*[cn.myapps.core.domain.userEdit.proxy_user_select]*}',
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
</head>
<body id="usersetup" class="body-front" style="margin:0px;overflow: hidden;border-top: 1px solid #f0f0f0;">
<div id="container" >
<s:form name="formItem" action="savePersonal" method="post" validate="true" theme="simple">
	<input type="hidden" name="_currpage" value='<s:property value="#parameters['_currpage']"/>' />
	<input type="hidden" name="_pagelines" value='<s:property value="#parameters['_pagelines']"/>' />
	<input type="hidden" name="_rowcount" value='<s:property value="#parameters['_rowcount']"/>' />
	<!--  <div id="activityTable">
		<table class="act_table" cellspacing="0" cellpadding="0" style="width:100%">		
			<tr>		
				<td style="width: 95%;">
					<div width="20%" style="float: left; font-weight: bold;">{*[Personal]*}{*[Setup]*}：</div>
					<div class="exitbtn">					
					<div class="button-cmd">
						<div class="btn_mid">
						<a class="applyicon" onclick="doSave()">
							{*[Apply]*}
						</a>
						</div>
					</div>	
					</div>						
				</td>
			</tr>
		</table>
	</div>-->
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentTable" style="position:relative;clear:both;overflow: hidden;height:100%;">
		<div id="contentLeft" class="contentleft" style="position:absolute;">
			<div id="uBaseInfo" class="leftmenulist selleftmenulist">{*[Basic]*}{*[Info]*}</div>
			<div id="uSkinStyle" class="leftmenulist"> {*[Skin]*}{*[Style]*}</div>
			<div id="uHomePageStyle" class="leftmenulist" style="display: none;"> {*[HomePage]*}{*[Pending]*}</div>
			<!--<div id="uEmailModify" class="leftmenulist"> {*[Email]*}</div>-->
			<div id="uWorkflowProxy" class="leftmenulist"> {*[Proxy]*}{*[Setup]*}</div>
			<div id="contacts" class="leftmenulist"> {*[cn.myapps.core.usergroup.submit.contacts]*}</div>
			<!-- 
			<div id="userManage" class="leftmenulist"> 用户列表管理</div>
			<div id="deptManage" class="leftmenulist"> 部门列表管理</div>
			<div id="roleManage" class="leftmenulist"> 角色列表管理</div>
			-->
		</div>
		<div id="contentRight" class="contentRight" style="position:absolute;margin-left:120px;overflow: hidden; overflow-x: hidden;">
		
			<div id="deptManage_div" class="hidecontent">
				 <iframe name="deptframe" id="deptframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
			<div id="userManage_div" class="hidecontent">
				 <iframe name="userframe" id="userframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
     		<div id="roleManage_div" class="hidecontent">
				 <iframe name="roleframe" id="roleframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
     		<div id="contacts_div" class="hidecontent">
				 <iframe name="contactsframe" id="contactsframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
			<div id="uBaseInfo_div" class="showcontent">
				<s:hidden name="content.id" />
				<s:hidden name="content.domainUser" />
				<s:hidden name="content.userSetup.userId" value="#session.FRONT_USER.id"/>
				<s:hidden name="content.orderByNo" />
				<s:hidden name="content.useIM" />
				<s:hidden name="content.dimission" />
				<s:hidden name="content.favoriteContacts" />
				<s:hidden name="content.avatar" />
				<s:hidden name="content.signs" />
				<s:hidden name="content.liaisonOfficer" />
				<s:hidden name="content.permissionType" />
				<s:hidden name="content.telephone2" />
				<s:hidden name="content.telephonePublic" />
				<s:hidden name="content.telephonePublic2" />
				<s:hidden name="content.emailPublic" />
				<%-- <s:hidden name="content.userInfoPublic" /> --%>
				<s:hidden name="content.calendarType" />
				<s:hidden name="content.field1" />
				<s:hidden name="content.field2" />
				<s:hidden name="content.field3" />
				<s:hidden name="content.field4" />
				<s:hidden name="content.field5" />
				<s:hidden name="content.field6" />
				<s:hidden name="content.field7" />
				<s:hidden name="content.field8" />
				<s:hidden name="content.field9" />
				<s:hidden name="content.field10" />
				<fieldset style="border:1px dashed #d8d8d8;margin: 10px 5px 10px 5px;">
					<legend style="color:#828282;border:0px;background-color:white;">{*[cn.myapps.core.personalsettings.basic.lable.basic_information]*}</legend>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:20px auto 0;">
						<tr>
							<td class="label-td">{*[cn.myapps.core.personalsettings.basic.lable.user_name]*}：</td>
							<td width="260px" height="46px"><s:textfield cssStyle="width:250px;" cssClass="input-cmd sett-form-control"
								label="%{getText('core.user.username')}" name="content.name" /></td>
							<td class="label-td">{*[Account]*}：</td>
							<td><s:textfield cssStyle="width:250px;" cssClass="input-cmd sett-form-control" readonly="true"
								label="%{getText('core.user.loginno')}" name="content.loginno" /></td>
						</tr>
						<tr>
							<td class="label-td">{*[Email]*}：</td>
							<td width="260px" height="46px"><s:textfield cssStyle="width:250px;" cssClass="input-cmd sett-form-control"
								label="%{getText('core.user.email')}" name="content.email" onblur="checkIsEmail(this)"/></td>
							<td align="right" class="commFont">{*[Mobile]*}：</td>
							<td><s:textfield cssStyle="width:250px;" cssClass="input-cmd sett-form-control"
								label="%{getText('core.user.mobile')}" name="content.telephone" onblur="checkIsPhone(this)" autocomplete="off"/></td>
						</tr>
					</table>
				</fieldset>
				<fieldset style="border:1px dashed #d8d8d8;margin: 10px 5px 10px 5px;">
					<legend style="color:#828282;border:0px;background-color:white;">{*[cn.myapps.core.personalsettings.basic.lable.modify_password]*}</legend>
					<table>
						<tr>
							<td class="label-td">{*[cn.myapps.core.personalsettings.basic.lable.original_password]*}：</td>
							<td width="260px" height="46px"><s:password cssStyle="width:250px;" cssClass="input-password sett-form-control"
								label="%{getText('core.user.loginpwd')}" name="_originalPassword" showPassword="true" autocomplete="off"/></td>
						</tr>
						<tr>
							<td class="label-td">{*[cn.myapps.core.personalsettings.basic.lable.new_password]*}：</td>
							<td width="260px" height="46px"><input type="password" style="width:250px;" class="input-password sett-form-control"
								label="%{getText('core.user.loginpwd')}" name="_password" autocomplete="off"/></td>
						</tr>
						<tr>
							<td class="label-td">{*[cn.myapps.core.personalsettings.basic.lable.comfirm_password]*}：</td>
							<td><s:password cssStyle="width:250px;" cssClass="input-password sett-form-control"
								label="%{getText('core.user.loginpwd')}" name="_comfirmPassword" showPassword="true" autocomplete="off"/></td>
						</tr>
					</table>
				</fieldset>
			</div>
			
			<div id="uSkinStyle_div" class="hidecontent" style="overflow: auto;">
					<div>
						<table class="table_noborder" width="100%" style="margin-top: 15px;">
							<!--<tr>
								<td style="padding-bottom: 10px;">{*[Choose]*}{*[Skin]*}{*[Type]*}：
									 <select name="content.userSetup.userStyle" id="userStyle">
										<option></option>
										<option id="blue">blue</option>
										<option id="green">green</option>
										<option id="pink">pink</option>
									</select>
									 
								</td>
							</tr>-->
							<tr class="selectSkin">
									
									<%
									DomainHelper domainH=new DomainHelper();
									Map skinType=(Map)domainH.querySkinTypes(webUser);
									for(Iterator iter=skinType.keySet().iterator();iter.hasNext();){
										String skin=(String)iter.next();
										//cool皮肤先屏蔽，等拿掉再删
										if("cool".equals(skin))
											continue;
									%>
									<td align="center">
										<div class="personSetSkin">
											<div style="background: url('../../portal/share/images/logo/preview-<%=skin%>.png') no-repeat 3px 3px;position: relative;">
												<div class="focusImg"><img src="<s:url value="/resource/images/iconfont-zhuangtai.gif"/>"></div>
											</div>
											<span class="skinLabel">
											<input type="radio" name="content.userSetup.userSkin" value="<%=skin %>" style="display:none;"/>{*[<%=skin %>]*}
											</span>																				
										</div>
									</td>
									<%
									}
									%>
							</tr>
						</table>
					</div>
			</div>
			
			<div id="uHomePageStyle_div" class="hidecontent" style="overflow: auto;">
				<div style="margin-bottom: 10px;">
					{*[Used]*}：
					<s:radio id="personUserDefined" name="userDefined.usedDefined"  onclick="showPending(this)"
						list="#{'0':'{*[cn.myapps.core.personalsettings.pending.used.customized_pending]*}', '1':'{*[cn.myapps.core.personalsettings.pending.used.customize_pending]*}'}" value="%{userDefined.usedDefined + ''}" theme="simple"/>
				</div>
				<s:if test='userDefined.usedDefined == 1'>
				<div id="tempDivParent" style="border: 1px solid #d3d3d3; width: 80%; text-align: center;">
				</s:if>
				<s:else>
				<div id="tempDivParent" style="border: 1px solid #d3d3d3; width: 80%; text-align: center; display: none;">
				</s:else>
					<div style="background-color: #d3d3d3;">
						<table width="100%">
							<tr>
								<td>{*[Select.Template.For.Homepage.Reminder]*}：</td>
								<td align="right">
									<button type="button" title="{*[Select.Other.Template]*}" class="button-image3" onClick="showSelectTemplate()">
										<img src="<s:url value="/resource/imgnew/act/act_20.gif"/>">{*[Select.Other.Template]*}
									</button>
								</td>
							</tr>
						</table>
					</div>
					<s:if test='userDefined == null'>
						<s:hidden name="userDefined.name" id="name" value="#session.FRONT_USER.name" />
					</s:if>
					<s:else>
						<s:hidden name="userDefined.name" id="name" />
					</s:else>
					<s:hidden name="userDefined.id" id="userDefinedId" />
					<s:hidden name="userDefined.creator" id="creator" />
					<s:hidden name="userDefined.type" id="userDefinedType" />
					<s:hidden name="userDefined.description" id="description" />
					<s:hidden name="userDefined.templateStyle" id="templateStyle" />
					<s:hidden name="userDefined.templateElement" id="templateElement" />
					<input name="application"  type="hidden" value="<%=applicationid%>" />
					<div id="templateDiv" class="templateDiv" style="padding: 10px;">
					</div>
				</div>
				
			</div>
			<div id="uEmailModify_div" class="hidecontent" style="overflow: auto;">
			
				<s:hidden name="emailUser.name" id="emailUserName" />
				<s:hidden name="emailUser.ownerid" id="emailUserOwnerid" />
				<s:hidden name="emailUser.createDate" id="emailUserCreateDate" />
				<%EmailUserProcessBean eupb =new EmailUserProcessBean(); 
				EmailUser  emailUser = eupb.getEmailUserByOwner(userId,domainid);
				if(emailUser == null){%>
					<table border="0" width="400px" style="margin:100px auto 0;">
					<tr>
						<td>{*[Account]*}：</td>
						<td>
							<s:textfield cssStyle="width:250px;" cssClass="input-cmd sett-form-control" name="emailUser.account"/>
						</td>	
						<td>{*[Password]*}:</td>
						<td>
							<s:password cssStyle="width:250px;" cssClass="input-password sett-form-control" name="emailUser.password" showPassword="true" />
						</td>
					</tr>
				</table>
				<% }else{
					String em = emailUser.getAccount();
					String em1 = emailUser.getPassword();
				%>
				
				<table border="0" width="400px" style="margin:100px auto 0;">
					</tr>
						<td>{*[Account]*}：</td>
						<input type="hidden" name="emailUser.id" id="emailUserId" value ="<%=emailUser.getId() %>" />
						<td>
							<input type="text" style="width:250px;" class="input-cmd sett-form-control" name="emailUser.account" value = "<%=emailUser.getAccount() %>"/>
						</td></tr>	
					</tr>
						<td>{*[Password]*}:</td>
						<td>
							<input type="password" style="width:250px;" class="input-password sett-form-control" name="emailUser.password" value = "<%=emailUser.getPassword() %>"/>
						</td>
					</tr>
				</table>
				<%} %>
			</div>
			
			<!-- 代理设置界面 -->
			<div id="uWorkflowProxy_div" class="hidecontent" style="overflow: auto;">
				<!-- 代理人 -->
				<%-- <div id="proxyusername_box" style="margin-left:10px;margin-right:10px;padding-top:10px;padding-bottom:10px;border-bottom: 1px;border-bottom-style: dashed;border-color:#e0e0e0;">
					<table>
						<tr>
							<td nowrap="nowrap" align="left" class="commFont">{*[cn.myapps.core.personalsettings.basic.lable.proxy_user]*}：</td>
							<td id="proxyUser_h" pid="contentTable" title="{*[cn.myapps.core.personalsettings.basic.lable.proxy_user]*}" class="justForHelp">
								<input id="proxyusername" readonly="readonly" class="input-cmd sett-form-control-inline" style="width:115px;"/>
								<s:hidden name="allUsers"/>
								<s:hidden id="_proxyUser" name="_proxyUser"/>
								<input type="button" value="添加" class="input-cmd sett-form-control-inline select-btn" style="*padding:0;" onclick="proxyUserSelect();">
							</td>
							<!-- 
								<td>{*[User]*}{*[Setup]*}{*[Status]*}：</td>
								<td>
									<SCRIPT type="text/javascript">
										jQuery(function(){
											var status=<%=usStatus%>;
											var obj =document.getElementsByName("content.userSetup.status");
											for(var i=0;i<obj.length;i++){
												if(obj[i].value==status){
													obj[i].checked='checked';
												}
											}
										});
									</SCRIPT>
									<s:radio name="content.userSetup.status" theme="simple"
									list="#{1:'{*[Enable]*}',0:'{*[Disable]*}'}" />
								</td>
							 -->
							<td nowrap="nowrap" align="left" class="commFont">{*[Proxy]*}{*[Start]*}{*[Date]*}：</td>
							<td>
								<input type='text' id='11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime' name='startProxyTime' class='selectdate sett-form-control-inline' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'})" value='<s:property value="startProxyTime" />'/>
							</td>
							<td nowrap="nowrap">{*[Proxy]*}{*[End]*}{*[Date]*}：</td>
							<td>
								<input type='text' id='11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_endProxyTime' name='endProxyTime' class='selectdate sett-form-control-inline' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:jQuery('#11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime').val(),maxDate:'2050-12-30',skin:'whyGreen'})"  limit='true' value='<s:property value="endProxyTime" />'/>
							</td>
						</tr>
					</table>
				</div> --%>
				<div style="padding:10px;">
					<table>
						<tr>
							<td valign="bottom">
								<div id="uWorkflowProxy_box1" style="font-weight:bold;font-size:15px;padding-right: 17px;">流程代理:</div>
							</td>
							<td valign="bottom">{*[Application]*}：</td>
							<td valign="bottom">
								<div id="uWorkflowProxy_box2" style="font-size:15px;">
								<%
								Collection<String> applicationIds = webUser.getApplicationIds();
								
								//String appId = request.getParameter("application");
								for (String applicationId_ : applicationIds) {
									ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
									ApplicationVO applicationVO = (ApplicationVO) process.doView(applicationId_);
									if(applicationVO == null)
										continue;
									if (!applicationVO.isActivated())
										continue;
								    String applicationId = applicationVO.getId();
								    String appName = applicationVO.getName();
								    out.println("<input type='radio' name='id' id='savePersonal_id" + applicationId + "' value='" + applicationId + "'");
								    out.println("onclick='changeApplication(this.value)'>");
								    out.println("<label for='savePersonal_id" + applicationId + "'>" + appName + "</label>");
								}
								
								%>
								</div>
							</td>
						</tr>
					</table>
					<iframe name="workflowproxyframe" id="workflowproxyframe" width="100%" frameborder="0" src=""></iframe>
				</div>
				
		</div>
		
	</div>
	<div id="activityTable" class="saveChange">
		<table class="act_table" cellspacing="0" cellpadding="0" style="width:100%">		
			<tr>		
				<td style="width: 95%;">
					<!-- <div width="20%" style="float: left; font-weight: bold;">{*[Personal]*}{*[Setup]*}：</div> -->
					<div class="exitbtn">					
					<div class="button-cmd">
						<div class="btn_mid">
						<a class="applyicon yingyong" onclick="doSave()">
							{*[Apply]*}
						</a>
						</div>
					</div>	
					</div>						
				</td>
			</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage>
</html>
