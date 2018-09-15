<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.homepage.action.HomePageHelper"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.homepage.ejb.HomePage" %>
<%@ page import="cn.myapps.core.domain.action.DomainHelper" %>
<%@ page import="java.util.*" %>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#session.FRONT_USER.domainid" />
</s:bean>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String applicationid = request.getParameter("application");
	
	int usStatus=webUser.getUserSetup()==null? 0:((int)webUser.getUserSetup().getStatus());
	int useHomePage=webUser.getUserSetup()==null? 0:(int)webUser.getUserSetup().getUseHomePage();
	String uskin=webUser.getUserSetup()==null? (String) session.getAttribute("SKINTYPE"):(String)webUser.getUserSetup().getUserSkin();
	String domainid = webUser.getDomainid();
	String contextPath = request.getContextPath();
%>
<head>
<title>{*[User_Management]*}</title>
<link rel="stylesheet" href="<o:Url value='/resource/document/main-front.css'/>"	type="text/css">
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/portal/share/script/dtree.js"/>'></script>
<script>
var contextPath = "<%=contextPath%>";

	function adjustUserSetupPageLayout(){
		var bodyH=jQuery("body").height();
		jQuery("#container").height(bodyH-22);
		jQuery("#container").width(jQuery("body").width());
		jQuery("#contentTable").height(jQuery("#container").height()-jQuery("activityTable").height()-10);
		
		jQuery("#contentRight").width(jQuery("#contentTable").width()-jQuery("#contentLeft").width()-10);
		jQuery("#contentLeft").height(jQuery("#contentTable").height());
		jQuery("#contentRight").height(jQuery("#contentTable").height());
		
		jQuery("#RemindListConent").width(jQuery("#contentRight").width());		
	}
	
	function doExcelImport(){
		var domainId = '<%=domainid %>';
		var url = contextPath + '/portal/share/importbyid.jsp';
		OBPM.dialog.show({
			opener:window.top,
			width: 580,
			height: 560,
			url: url,
			title: "EXCEL用户导入",
			args : {domain:domainId},
			close: function(result){
			}
		});  
	}
	
	function doExcelExport(){
		var domainId = '<%=domainid %>';
		window.open("<s:url value='/portal/domain/excelExportUserAndDept.action'></s:url>"+"?domainid="+domainId);
		}
	
	jQuery(window).load(function(){
		adjustUserSetupPageLayout();
		jQuery(".leftmenulist").click(function(){
			jQuery(".showcontent").attr("class","hidecontent");
			jQuery(".selleftmenulist").removeClass("selleftmenulist");
			jQuery(this).addClass("selleftmenulist");
			jQuery("#"+jQuery(this).attr("id")+"_div").attr("class","showcontent");

			if(jQuery(this).attr("id")=='userManage'){
				jQuery("#userframe").attr("src",contextPath+"/portal/user/list.action?domain=<%=domainid%>");
			}
			if(jQuery(this).attr("id")=='deptManage'){
				jQuery("#deptframe").attr("src",contextPath+"/portal/department/list.action?domain=<%=domainid%>");
			}
			if(jQuery(this).attr("id")=='roleManage'){
				jQuery("#roleframe").attr("src",contextPath+"/portal/role/list.action?mode=application&s_applicationid=<%=applicationid%>");
			}
			if(jQuery(this).attr("id")=='attendanceManage'){
				jQuery("#attendanceframe").attr("src",contextPath+"/attendance/index.jsp");
			}
		});
	});
	
</script>
</head>
<body id="usersetup" class="body-front" style="overflow: hidden;">
<div id="container">
<s:form name="formItem" action="/portal/domain/save.action" method="post" validate="true" theme="simple">
		<input type="hidden" name="_currpage"
			value='<s:property value="#parameters['_currpage']"/>' />
		<input type="hidden" name="_pagelines"
			value='<s:property value="#parameters['_pagelines']"/>' />
		<input type="hidden" name="_rowcount"
			value='<s:property value="#parameters['_rowcount']"/>' />
	<div id="activityTable">
	<table class="table_noboder" width="98%">
		<tr>
			<td width="110px" height="25px;" class="label-td" style="font-weight: bold;padding-left: 10px;">{*[cn.myapps.core.manage.title.domain_info_manage]*}：</td>
			<td align="right">
				<!-- <span class="button-document"><a href="#" onclick="javescript:formItem.submit();"><span><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Apply]*}</span></a></span> -->
			<a  id="btnPort"  href="javascript:void(0)" onclick="doExcelImport();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[User]*}{*[Import]*}</a> 
		    <a  id="btnPort"  href="javascript:void(0)" onclick="doExcelExport();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[User]*}{*[Export]*}</a> 
			</td>
		</tr>
	</table>
	</div>
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentTable" style="overflow: hidden;background-color: #FBFBF9;">
		<div id="contentLeft" class="contentleft">
			<!-- <div id="dBaseInfo" class="leftmenulist selleftmenulist">{*[Basic]*}{*[Info]*}{*[Manage]*}</div>-->
			<div id="deptManage" class="leftmenulist selleftmenulist">{*[cn.myapps.core.manage.tab.title.department_list_manage]*}</div>
			<div id="userManage" class="leftmenulist">{*[cn.myapps.core.manage.tab.title.user_list_manage]*}</div>
			<!-- <div id="roleManage" class="leftmenulist">{*[Role]*}{*[List]*}{*[Manage]*}</div> -->
			<div id="attendanceManage" class="leftmenulist">微信考勤管理</div>
		</div>
		<div id="contentRight" class="contentRight" style="padding: 0px;margin: 0px;">
			<div id="dBaseInfo_div" class="hidecontent" style="padding-top: 10px;">
				<s:hidden name="content.id" />
				<s:hidden name="content.sortId" />
				<table width="100%" border="0">
					<tr>
						<td class="commFont">{*[Domain]*}{*[Name]*}：</td>
						<td class="commFont">{*[Status]*}：</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" name="content.name" /></td>
						<td><s:radio label="{*[Status]*}" name="_strstatus" theme="simple"	list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" /></td>
					</tr>
			
					<tr>
						<td class="commFont" >{*[cn.myapps.core.domain.SMS_member_code]*}：</td>
						<td class="commFont" >{*[cn.myapps.core.domain.SMS_member_pwd]*}：</td>
					</tr>
					<tr>
						<td id="smsMemberCode" class="justForHelp" title="{*[cn.myapps.core.domain.SMS_member_code]*}" pid="main" >
							<s:textfield cssClass="input-cmd" name="content.smsMemberCode" /></td>
						<td id="_password" class="justForHelp" title="{*[cn.myapps.core.domain.SMS_member_pwd]*}" pid="main" ><s:password cssClass="input-cmd" name="_password" show="true" /></td>
					</tr>
					<tr>
						<td class="commFont">{*[Description]*}：</td>
						<td></td>
					</tr>
					<tr>
						<td id="description" class="justForHelp" title="{*[Description]*}" pid="main" ><s:textarea cssClass="input-cmd" cols="43" rows="2"
							label="{*[Description]*}" name="content.description" /></td>
						<td></td>
					</tr>
				</table>
			</div>
			<div id="deptManage_div" class="showcontent">
				 <iframe name="deptframe" id="deptframe" width="100%" height="100%" frameborder="0" src='<%=contextPath%>/portal/department/list.action?domain=<%=domainid%>'></iframe>
     		</div>
			<div id="userManage_div" class="hidecontent">
				 <iframe name="userframe" id="userframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
     		<div id="roleManage_div" class="hidecontent">
				 <iframe name="roleframe" id="roleframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
     		<div id="attendanceManage_div" class="hidecontent">
				 <iframe name="attendanceframe" id="attendanceframe" width="100%" height="100%" frameborder="0" src=""></iframe>
     		</div>
		</div>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage>
</html>
