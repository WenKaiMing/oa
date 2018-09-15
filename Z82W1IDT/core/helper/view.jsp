<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.helper.action.HelperAction"%>
<%@page import="cn.myapps.core.helper.ejb.HelperVO"%>
<%
	String contextPath = request.getContextPath();
	String urlname = request.getParameter("urlname");
	int urllocation;
	int parameterlocation;
	if (urlname != null && urlname.trim().length() > 0&&urlname.indexOf("action.action?_activityid")==-1&&urlname.indexOf("displayView.action?_viewid")==-1) {
		urllocation = urlname.lastIndexOf(".");
		parameterlocation = urlname.indexOf("?");

		if (parameterlocation != -1) {
			urlname = urlname.substring(0, urllocation);

		} else {
		}

	}
	int pathLoca = 0;
	String temp  = "";
	if(contextPath != null && !contextPath.equals(""))
	{
		pathLoca = urlname.indexOf(contextPath);
		temp = urlname.substring(pathLoca+(contextPath.length()));
	}
	else
	{
		//如果为0即是没有设置contextPath,则把ip地址截取掉
		//String ipStr = request.getLocalAddr();
		String ipStr = request.getServerName();
		String portStr = request.getLocalPort()+"";
		String addr = ipStr + ":"+portStr;
		
		if(portStr != null && !portStr.equals("")&&!portStr.equals("80"))
			addr = ipStr + ":"+portStr;
		else
			addr = ipStr;

		pathLoca = urlname.indexOf(addr);
		
		if(pathLoca!=-1)
			  temp = urlname.substring(pathLoca+(addr.length()));
		else
		      temp = urlname;
	}
	HelperVO helper = null;
	HelperAction helperaction = new HelperAction();
	helper = helperaction.getHelperByname(temp, (String) (request
			.getSession().getAttribute("APPLICATION")));
	String title = "{*[Helper_Info]*}";
	String urlgh = null;
	if (helper != null) {
		title = helper.getTitle();
		urlgh = helper.getUrl();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<s:form name="formList" method="post">
	<%@include file="/common/page.jsp"%>
	<table width="98%">
		<tr>
			<td width="3"></td>
			<td width="90" class="text-label"><img
				src="<s:url value="/resource/image/help.bmp"/>">{*[Helper]*}</td>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0"
				class="line-position">
				<tr>
					<td></td>
					<td class="line-position2" width="60" valign="top"></td>
					<td class="line-position2" width="70" valign="top"></td>
					<td></td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
	<table>
		<tr>
			<td><script>
						document.title='<%=title%>';
			</script> 
			<div style="height:400px;overflow:auto">
			<%=helper!=null?helper.getContext():""%> 
			</div>
			<br>
			<s:if
				test="#session['FRONT_USER'].loginno=='admin'">
				<%
				if (urlgh == null || urlgh.trim().length() <= 0) {
				%>
				<a
					href='<s:url value="new.action"><s:param name="urlname" value="#parameters.urlname"/></s:url>'
					style="cursor:hand;color: blue"><FONT face="Arial" size=2> {*[Create_Help]*} </FONT></a>
				<%
				} else {
				%>
				<a
					href='<s:url value="edit.action"><s:param name="urlname" value="#parameters.urlname"/></s:url>&id=<%=helper.getId()%>'
					style="cursor:hand;color: blue"><FONT face="Arial" size=2> {*[Edit_Help]*} </FONT></a>
				<%
				}
				%>
			</s:if></td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
