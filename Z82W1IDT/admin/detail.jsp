<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	boolean isSuperAdmin = user.isSuperAdmin();
	boolean isDomainAdmin = user.isDomainAdmin();
	boolean isDeveloper = user.isDeveloper();
	String username = user.getName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<o:MultiLanguage>
	<html>

	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>{*[Home]*}</title>
	<style type="text/css">
img {
	border-width: 0;
}

#container {
	width: 100%;
	margin: 0 auto;
}

/*CSS分组*/
#superadmin,#domainuser,#developer {
	width: 100%;
	height: 200px;
	padding-top: 10px;
	align: center;
}

/*CSS分组*/
#domainuser table td,
#superadmin table td,
#developer table td {
	text-align: center;
}

#footer {
	
}

.list li {
	float: left;
	list-style-type: none;
	margin-right: 30px;
	padding: 5px;
	display: block;
	text-align: center;
}

</style>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
	<!-- Platform lib -->
	<script language="javascript">

var contextPath = '<%=request.getContextPath()%>';

function newApp(){
	window.location.href='<s:url value="/core/wizard/application/step2_create.action"/>';
}

function newDomain(){
	window.location.href = '<s:url value="/core/wizard/domain/step2_create.action" />';
}

function listDomains(){
	window.location.href = "<s:url value='/core/domain/list.action'><s:param name='t_users.id' value='#session.USER.id' /></s:url>";
}

function listApps(){
	window.location.href = "<s:url value='/core/deploy/application/list-apps.action'><s:param name = '_currpage' value = '1'/></s:url>";
}	
function initCurrentPosition(){
	var obj=window.parent.document;
	obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition2").innerHTML;
	jQuery(".forInitCurrentPosition").click(function(){
		obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition2").innerHTML+">><a target='detail' href='"+jQuery(this).attr("href")+"' title='"+jQuery(this).attr("topage")+"' class='currentPosition'>"+jQuery(this).attr("topage")+"</a>";
		obj.getElementById("currentPosition3").innerHTML=obj.getElementById("currentPosition").innerHTML;
	});
}

jQuery(document).ready(function(){
	initCurrentPosition();
	window.top.toThisHelpPage("homepage");
});
</script>
	</head>
	<body id="home_detal" helpid="homepage" align="center" style="background-color: #F9F9FB; margin: 0px; background-repeat: repeat-x; background-image: url(< ww : url value = '/resource/imgnew/index_back.gif'/ >)">
	<table width="100%"
		style="background-color: #777777; background: url('<s:url value = "/resource/imgnew/index_07.gif" />'); height: 8px;">
		<tr>
			<td></td>
		</tr>
	</table>

	<%
		if (isSuperAdmin) {
	%>

	<div id="superadmin" align="center">
	<h3 class="text-label" style="text-align: center;">{*[cn.myapps.core.main.super_admin_management_List]*}</h3>
	<table border="0"
		style=" width:684px;height: 169px;  background-repeat: no-repeat; background-image:url('<s:url value="/resource/imgnew/index_background.gif" />')">
		<tr>
			<td><a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.domain_list]*}" title="{*[cn.myapps.core.main.domain_management]*}"
				href="<s:url value='/core/domain/list.action'><s:param name = '_currpage' value = '1'/><s:param name = '_pagelines' value = '10'/></s:url>"><img
				src="<s:url value='/resource/imgnew/index_domain.gif' />"
				onmouseover="src='<s:url value="/resource/imgnew/index_domain_c.gif" />'"
				onmouseout="src='<s:url value="/resource/imgnew/index_domain.gif" />'" /><br />
			{*[cn.myapps.core.main.domain_management]*}</a></td>
			<td><a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.application_list]*}" title="{*[cn.myapps.core.main.application_management]*}"
				href="<s:url value='/core/deploy/application/list-apps.action'><s:param name = '_currpage' value = '1'/><s:param name = '_pagelines' value = '10'/></s:url>"><img
				src="<s:url value='/resource/imgnew/index_application.gif' />"
				onmouseover="src='<s:url value="/resource/imgnew/index_application_c.gif" />'"
				onmouseout="src='<s:url value="/resource/imgnew/index_application.gif" />'" /><br />
			{*[cn.myapps.core.main.application_management]*}</a></td>
			<td><a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.super_user_list]*}" title="{*[cn.myapps.core.main.super_user_management]*}"
				href="<s:url value='/core/superuser/list.action'><s:param name = '_currpage' value = '1'/><s:param name = '_pagelines' value = '10'/></s:url>"><img
				src="<s:url value='/resource/imgnew/index_superuser.gif' />"
				onmouseover="src='<s:url value="/resource/imgnew/index_superuser_c.gif" />'"
				onmouseout="src='<s:url value="/resource/imgnew/index_superuser.gif" />'" /><br />
			{*[cn.myapps.core.main.super_user_management]*}</a></td>
			<td><a class="forInitCurrentPosition" topage="{*[System.Management]*}" title="{*[System.Management]*}"
				href="<s:url value='/core/sysconfig/config.action'><s:param name = '_currpage' value = '1'/><s:param name = '_pagelines' value = '10'/></s:url>"><img
				src="<s:url value='/resource/imgnew/index_systemconfiguration.gif' />"
				onmouseover="src='<s:url value="/resource/imgnew/index_systemconfiguration_c.gif" />'"
				onmouseout="src='<s:url value="/resource/imgnew/index_systemconfiguration.gif" />'" /><br />
			{*[System.Management]*}</a></td>
		</tr>
	</table>
	</div>
	<%
		} else {
				if (isDomainAdmin) {
	%>
	<div id="domainuser" align="center">
	<h3 class="text-label" style="text-align: center;">{*[cn.myapps.core.main.my_domain_list]*}</h3>
	<table style="width: 684px; height: 169px; background-repeat: no-repeat; background-image:url('<s:url value="/resource/imgnew/index_background.gif" />')">
		<tr>
			<td colspan="2">
			<ul class="list">
				<li><a href="javascript:newDomain()">{*[New]*}</a></li>
				<li><a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.domain_list]*}" href="<s:url value='/core/domain/list.action'><s:param name='t_users.id' value='#session.USER.id' /></s:url>">{*[More]*}>></a></li>
			</ul>
			</td>
		</tr>
		<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh">
			<s:param name="user" value="#session.USER" />
			<s:param name="_page" value="1" />
			<s:param name="_line" value="10" />
		</s:bean>
		<tr>
			<s:iterator value="#dh.queryDomains()" id="domain">
				<td style="white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;width:20%">
				<a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.domain_info]*}(<s:property value="#domain.name" />)" href="<s:url value='/core/domain/displayView.action'><s:param name='id' value='#domain.id' /><s:param name='domain' value='#domain.id' /></s:url>">
				<img src="<s:url value='/resource/imgnew/index_domain.gif'/>"
					onmouseover="src='<s:url value="/resource/imgnew/index_domain_c.gif" />'"
					onmouseout="src='<s:url value="/resource/imgnew/index_domain.gif" />'"
					alt="<s:property value="#domain.name" />" /><br />
				<s:property value="#domain.name" />
				</a></td>
			</s:iterator>
			
			<!-- td>
				<ul class="list">
					<s:iterator value="#dh.queryDomains()" id="domain">
						<li style="width:86px;white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;"><a
							href="<s:url value='/core/domain/displayView.action'><s:param name='id' value='#domain.id' /><s:param name='domain' value='#domain.id' /></s:url>">
						<img src="<s:url value='/resource/imgnew/index_domain.gif'/>"
							onmouseover="src='<s:url value="/resource/imgnew/index_domain_c.gif" />'"
							onmouseout="src='<s:url value="/resource/imgnew/index_domain.gif" />'"
							alt="<s:property value="#domain.name" />" /><br />
						<s:property value="#domain.name" />
						</a></li>
					</s:iterator>
				</ul>
			</td-->
		</tr>
	</table>
	</div>

	<%
		}
				if (isDeveloper) {
	%>

	<div id="developer" align="center">
	<h3 class="text-label" style="text-align: center;">{*[cn.myapps.core.main.my_application_list]*}</h3>
	<table style="width: 684px; height: 169px; background-repeat: no-repeat; background-image:url('<s:url value="/resource/imgnew/index_background.gif" />')">
		<tr>
			<td colspan="2">
			<ul class="list">
				<li><a href="javascript:newApp()">{*[New]*}</a></li>
				<li><a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.application_list]*}" href="<s:url value='/core/deploy/application/list-apps.action'><s:param name = '_currpage' value = '1'/></s:url>">{*[More]*}>></a></li>
			</ul>
			</td>
		</tr>
		<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ah" />
		<tr>
			<s:iterator value="#ah.queryApplications(#session.USER, 1, 5)"	id="application">
				<td style="white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;width:20%;">
				<a class="forInitCurrentPosition" topage="{*[cn.myapps.core.main.application_information]*}(<s:property value="#application.name"/>)" href="<s:url value='/core/deploy/application/frames.jsp'><s:param name='id' value='#application.id' /></s:url>">
				<img src="<s:url value='/resource/imgnew/index_application.gif'/>"
					onmouseover="src='<s:url value="/resource/imgnew/index_application_c.gif"/>'"
					onmouseout="src='<s:url value="/resource/imgnew/index_application.gif"/>'"
					alt="<s:property value='#application.name' />" /><br />
				<s:property value="#application.name"/>
				</a></td>
			</s:iterator>
			<!-- td>
			<ul class="list" name="applist">
				<s:iterator value="#ah.queryApplications(#session.USER, 1, 5)"
					id="application">
					<li style="width:86px;white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow:ellipsis;"><a
						href="<s:url value='/core/deploy/application/frames.jsp'><s:param name='id' value='#application.id' /></s:url>">
					<img
						src="<s:url value='/resource/imgnew/index_application.gif'/>"
						onmouseover="src='<s:url value="/resource/imgnew/index_application_c.gif"/>'"
						onmouseout="src='<s:url value="/resource/imgnew/index_application.gif"/>'"
						alt="<s:property value='#application.name' />" /><br />
					<s:property value="#application.name" />
					</a></li>
				</s:iterator>
			</ul>
			</td> -->
		</tr>
	</table>
	</div>

	<%
		}
			}
	%>

	</body>
	</html>
</o:MultiLanguage>
