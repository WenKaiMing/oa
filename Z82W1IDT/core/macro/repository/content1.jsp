<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" /> 
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ah" />
<% 
	WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String username = user.getName();
	String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value='/script/help.js'/>"></script>
<script>
	function returncheck(){
		 var mode = document.getElementById('mode').value;
	     if(mode==''){document.getElementById('s_module').value='';}
	     document.forms[0].action="<s:url action='listAll.action'/>";
	     document.forms[0].submit();
	}
	
	jQuery(document).ready(function(){
		window.top.toThisHelpPage("repository_info");
	});
</script>
<title>{*[Macro_Library]*}{*[Info]*}</title>
</head>
<body id="repository_info" class="contentBody">
<div class="ui-layout-center">
	<s:form action="save" method="post" theme="simple">
	<!-- Navigate Table -->
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Macro_Library]*}{*[Info]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="Save" title="{*[Save]*}" class="justForHelp button-image" onClick="forms[0].action='<s:url action="saveByAdmin"></s:url>';forms[0].submit();">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" id="Exit" title="{*[Exit]*}" class="justForHelp button-image" onClick="forms[0].action='<s:url action="listAll"></s:url>';forms[0].submit();">
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
		<%@include file="/common/page.jsp"%>
		<table width="80%" class="table_noborder id1" border="0">
			<s:hidden name='content.version'></s:hidden>
		   <tr><td class="commFont">{*[Name]*}:</td> </tr>
		   <tr>
		   	<td id="Macro_Library_Name" pid="contentTable" class="justForHelp" title="{*[Macro_Library]*}{*[Name]*}"><s:textfield cssClass="input-cmd" theme="simple" name="content.name" /></td>
		   </tr>
		   	<tr>
				<td class="commFont">{*[Application]*}:</td>
		   </tr>
		   <tr>
		   		<td id="Macro_Library_Application" pid="contentTable" class="justForHelp" title="{*[Macro_Library]*}{*[Application]*}">
					<s:select label="{*[Application]*}" cssClass="input-cmd" name="content.applicationid"  list="_applications" theme='simple' emptyOption="true" />
				</td>
		   </tr>
			<tr>
				<td class="commFont">{*[Content]*}: <button type="button" class="button-image" onclick="openIscriptEditor('content.content','{*[Script]*}{*[Editor]*}','{*[Macro_Library]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td>
		   </tr>
		   <tr>
		   		<td id="Macro_Library_Content" pid="contentTable" class="justForHelp" title="{*[Macro_Library]*}{*[Content]*}" colspan="2">
		   			<s:textarea rows="15" cssClass="content-textarea" theme="simple" name="content.content"/></td>
		   </tr>
		</table>
	</div>
	</s:form>
</div>
</body>
</o:MultiLanguage></html>
