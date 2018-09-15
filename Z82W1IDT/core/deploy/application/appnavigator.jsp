<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<%@include file="/common/tags.jsp"%>
<%@ page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.module.ejb.ModuleVO"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>

<%String contextPath = request.getContextPath();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	ApplicationHelper helper = new ApplicationHelper();
	//	Collection applist = helper.getAppList();
%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<html>
<o:MultiLanguage>
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />'
		type='text/css'>
	<link rel="stylesheet"
		href='<s:url value="/resource/css/dtree.css" />' type="text/css">
	<link rel="stylesheet"
		href='<s:url value="/resource/css/popupmenu.css" />' type="text/css">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="<s:url value='/script/tree.js'/>"></script>
	<script>
	var contextPath = '<%= contextPath %>';
    d = new dTree('d');
    var nowParam;
	var firstapp;
	<%


		int i=0;
//	Iterator it=applist.iterator();
//	while(it.hasNext()) {
//		ApplicationVO av=(ApplicationVO)it.next();
		ApplicationVO av = helper.getApplicationById(request.getParameter("id"));

	%>	
	<% if(i==0){%>
	  firstapp='<%=av.getId()%>';
	<%i=1;}%>

	 	nowParam='rightFunction(\'<%=av.getId()%>\',0)';  
		d.add('<%=av.getId()%>','-1','<%=av.getName()%>','<c:out value="${pageContext.request.contextPath}"/>/core/deploy/application/edit.action?id=<%=av.getId()%>&application=<%=av.getId()%>&mode=application','','applicationframe',null,null,null,nowParam);	
		
	<%	

		Collection modules=av.getModules();

		if(modules!=null){
	 		Iterator itmod=modules.iterator();

	 		while(itmod.hasNext()){
	 		ModuleVO mv=(ModuleVO)itmod.next();

	            if(mv.getSuperior()==null || mv.getSuperior().getId()==null || mv.getSuperior().getId().trim().length()<=0)
	            {
	            %>
	 				nowParam='rightFunction(\'<%=av.getId()%>\',\'<%=mv.getId()%>\')';
					d.add('<%=mv.getId()%>','<%=av.getId()%>','<%=mv.getName()%>','<c:out value="${pageContext.request.contextPath}"/>/core/deploy/module/displayFormAndView.jsp?application=<%=av.getId()%>&moduleid=<%=mv.getId()%>','','applicationframe',null,null,null,nowParam);
					
				<%}
	            else {
				%>
					nowParam='rightFunction(\'<%=av.getId()%>\',\'<%=mv.getId()%>\',\'<%=mv.getSuperior().getId()%>\')';
					d.add('<%=mv.getId()%>','<%=mv.getSuperior().getId()%>','<%=mv.getName()%>','<c:out value="${pageContext.request.contextPath}"/>/core/deploy/module/displayFormAndView.jsp?application=<%=av.getId()%>&moduleid=<%=mv.getId()%>','','applicationframe',null,null,null,nowParam);
				<%}
			}
		}
//	}
	%>
</script>
	<script>
function refreshRightFrame(){
	parent.applicationframe.location.href="<s:url value='/core/deploy/application/edit.action?mode=application&id='/>"+firstapp + "&application="+firstapp;
}
function refresh() {
	window.location.reload();
}
</script>
	</head>
	<body  class="right-border" leftmargin="0" rightmargin="0" 
		style="background-color: #F9F9FB; background-repeat: repeat-y; background-position: right; background-image: url(< ww : url value = '/resource/imgnew/index_09.gif'/ >); padding-top: 15px;">
	<div id=ie5menu class=menu
		style="text-align: left; position: absolute; visibility: hidden; width: 90px; z-index: 200; padding: 1px" >
	<!-- 	<div class=link onMouseOver=this.className='overlink' onMouseOut=this.className='link' style='padding-top:2;padding-bottom:2;text-align: left' onclick="javascript:addApplication();">&nbsp;&nbsp;{*[New_App]*}</div> -->
	<div class="link" onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:addModule();">&nbsp;&nbsp;{*[New_Module]*}</div>
	<div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:wizard();">&nbsp;&nbsp;{*[New]*}{*[Wizard]*}</div>
	<div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:deleteSel();">&nbsp;&nbsp;{*[Delete]*}&nbsp;&nbsp;</div>
	<div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:refresh();">&nbsp;&nbsp;{*[Refresh]*}&nbsp;&nbsp;</div>
	<table width=100%>
		<tr height=2>
			<td width=100% BACKGROUND="<%=contextPath%>/resource/images/line.gif"></td>
		</tr>
	</table>
	<!-- <div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:copy();">&nbsp;&nbsp;{*[Copy_Wizard]*}&nbsp;&nbsp;</div> -->
    <div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:copyall();">&nbsp;&nbsp;{*[cn.myapps.core.deploy.application.copy_all]*}&nbsp;&nbsp;</div>
	<div class=link onMouseOver="this.className='overlink'"
		onMouseOut="this.className='link'"
		style='padding-top: 2; padding-bottom: 2; text-align: left'
		onclick="javascript:doImportExport();">&nbsp;&nbsp;{*[Import]*}/{*[Export]*}&nbsp;&nbsp;</div>
	</div> 

	<SCRIPT language="javascript">
function doImportExport(){
	var appid = document.getElementById("nowappid").value;
	var moduleid = document.getElementById("nowmoduleid").value;
	var importURL = "<s:url value='/core/expimp/exporimp.jsp'/>";
	importURL += "?applicationid=<%= request.getParameter("id") %>";
	parent.applicationframe.location.href = importURL;
}

function addModule(){
	var appid=document.getElementById("nowappid").value;
	var moduleid=document.getElementById("nowmoduleid").value;
	parent.applicationframe.location.href="<s:url value='/core/deploy/module/new.action'/>?application=<%= request.getParameter("id") %>&_superiorid=" + moduleid;
	//  parent.frames[1].location.href="<s:url value='/core/deploy/application/appnavigator.jsp'/>" 
}

function copyModule(){
	var appid=document.getElementById("nowappid").value;
	var moduleid=document.getElementById("nowmoduleid").value;
	parent.applicationframe.location.href="<s:url value='/core/deploy/module/copy.action'/>?application=<%= request.getParameter("id") %>&_moduleid=" + moduleid;
}

function deleteSel(){
	var appid=document.getElementById("nowappid").value;
	var moduleid=document.getElementById("nowmoduleid").value;
	if(appid!=0){
		if(moduleid!=0){ 
			if(confirm('{*[cn.myapps.core.deploy.application.delete_this_module]*}')){	
				document.forms[0].action ='<s:url value="/core/deploy/module/moddelete.action"/>'+'?_selects='+moduleid+'&application=<%= request.getParameter("id") %>';
				document.forms[0].submit();
			}
		}else{
			alert('{*[cn.myapps.core.deploy.application.please_delete_list_application]*}');	
		}
	}	
	else {   alert("{*[page.core.deploy.delete]*}!");}
}

function wizard() {
	parent.frames['applicationframe'].location.href="<s:url value='/core/wizard/tostart.action'/>?application=<%= request.getParameter("id") %>";
}

function copy(){
   parent.frames['applicationframe'].location.href="<s:url value='/core/deploy/copymodule/tostart.action'/>?application=<%= request.getParameter("id") %>";
}
function copyall(){
	  var appid=document.getElementById("nowappid").value;
	  var moduleid=document.getElementById("nowmoduleid").value;
	  if(moduleid!=0){
	      document.forms[0].action  ="<s:url value='/core/deploy/copymodule/copyall.action'/>"+"?_selects="+moduleid+"&application=<%=request.getParameter("id")%>";
	  	  document.forms[0].action = document.forms[0].action + "&refresh=rightFrame";
		  document.forms[0].submit(); 
	  }
	  else if(moduleid==0 && appid !=null && appid!=0 ){
		  parent.applicationframe.location.href ="<s:url value='/core/deploy/application/copynew.action'/>"+"?application="+appid;
	  
	  }else{
		    confirm('{*[page.core.deploy.copy]*}');
	  }
}

function copyResource() {
	parent.frames['applicationframe'].location.href="<s:url value='/core/resource/toCopyResource.action'/>?application=<%= request.getParameter("id") %>";
}
function showmenuie5(){
	var rightedge=document.body.clientWidth-event.clientX;
	var bottomedge=document.body.clientHeight-event.clientY-25;
	if (rightedge<ie5menu.offsetWidth){
		if(50<rightedge && rightedge<100){
			ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth+25;
		}else{
			ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth;
		}
	}
	else{
		ie5menu.style.left=document.body.scrollLeft+event.clientX;
	}
	if (bottomedge<ie5menu.offsetHeight){
		ie5menu.style.top=document.body.scrollTop+event.clientY-ie5menu.offsetHeight;
	}else{
		ie5menu.style.top=document.body.scrollTop+event.clientY;
	}
	ie5menu.style.visibility="visible";
	return false;
}

function hidemenuie5(){
	ie5menu.style.visibility="hidden";
	document.getElementById("nowappid").value=0;
	document.getElementById("nowmoduleid").value=0;
}
function rightFunction(appid,moduleid){
	if(event.button==0||event.button==2){
		document.getElementById("nowappid").value=appid;
		document.getElementById("nowmoduleid").value=moduleid;
	}
}
document.body.onclick=hidemenuie5;
document.oncontextmenu = function() {
		showmenuie5();		
	    return false; 
}

window.onload = function(){
	var isError = '<s:property value="#parameters.error" />';
	var refresh = '<s:property value="#parameters.refresh" />'
	// 是否存在错误
	if (isError == '1') {
		alert('{*[page.core.deploy.have.module]*},{*[page.cannot.delete]*}');
	}
	// 刷新右窗口
	if (refresh == 'rightFrame' ){
		refreshRightFrame();
	}
}	
// --> 
</SCRIPT>
	
	<input type="hidden" id="nowappid" name="nowappid" value="0">
	<input type="hidden" id="nowmoduleid" name="nowmoduleid" value="0">

	<%
		WebUser user = null;
		user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
		String username = user.getName();
	%>
	<s:form action="" method="post">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="3"></td>
				<td>
				<table width="95%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td valign='top'>
						<table width="100%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr valign="top">
								<td id="treeTD" height='300'>
								<div class="dtree"><script>
        	    	document.write(d);
				</script></div>
								<%
									if (modules == null || modules.size() <= 0) {
										String wizardURL = contextPath
												+ "/core/wizard/tostart.action?application="
												+ request.getParameter("id");
										out.println("<br/>");
										out
												.println("<div style='color:#bbbbbb'><font>{*[Click]*} </font><font color='gray'><b><a href='"
														+ wizardURL
														+ "' target='applicationframe'>{*[cn.myapps.core.deploy.application.here]*}</a></b></font><font> {*[cn.myapps.core.deploy.application.to_getting_start]*}......</font></div>");
									}
								%>
								</td>
							</tr>
						</table>

						</td>
					</tr>
				</table>
				</td>
				<td width="4"></td>
			</tr>

		</table>

		<table>
			<tr>
				<td><s:if test="hasFieldErrors()">
					<span class="errorMessage"><br>
					<s:iterator value="fieldErrors">
						<script>
				window.setTimeout("alert('* {*[page.core.deploy.have.module]*},{*[page.cannot.delete]*}')",200);
		</script>

					</s:iterator> </span>
				</s:if></td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>
