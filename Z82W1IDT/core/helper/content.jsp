<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.helper.action.HelperAction" %>
<%@page import="cn.myapps.core.helper.ejb.HelperVO" %>
<html><o:MultiLanguage>
<head>
<title>{*[Helper]*}{*[Info]*}</title>
<script src='<s:url value="/dwr/util.js"/>'></script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<%
   String contextPath = request.getContextPath(); 
   String urlname = request.getParameter("urlname");
 int urllocation;
 int parameterlocation;
  if(urlname!=null&&urlname.trim().length()>0&&urlname.indexOf("action.action?_activityid")==-1&&urlname.indexOf("displayView.action?_viewid")==-1)
{
    urllocation = urlname.lastIndexOf(".");
   parameterlocation = urlname.indexOf("?");
  
  if(parameterlocation!=-1)
  {
	  urlname = urlname.substring(0,urllocation);
		  
  }else{}
  
  }
    int pathLoca = 0;
	String temp  = "";
	if(contextPath != null && !contextPath.equals(""))
	{
		pathLoca = urlname.indexOf(contextPath);
		
		if(pathLoca!=-1)
		 temp = urlname.substring(pathLoca+(contextPath.length()));
		else
		 temp = urlname;
	}
	else
	{
		//如果为0即是没有设置contextPath,则把ip地址截取掉
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
 // int pathLoca = urlname.indexOf(contextPath);
  //String temp = urlname.substring(pathLoca);
  HelperVO helper = null;
  HelperAction helperaction = new HelperAction();
  helper = helperaction.getHelperByname(temp,(String)(request.getSession().getAttribute("APPLICATION")));
  String title="";
  String context="";
  String id="";
 if(helper!=null){
	 title=helper.getTitle();
	 id = helper.getId();
	 context=helper.getContext();
   }

 %>

</head>
<script>
function on_submit(){
document.forms[0].action='<s:url action="save"></s:url>';
document.forms[0].submit();

}

</script>
<body>
<table width="98%">
	<tr>
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="90" class="text-label">{*[Helper Info]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
				<td></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="button-image"
					onClick="on_submit();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table border=0 width="100%" height="100%">
<s:form action="save" method="post" theme="simple">
	<%@include file="/common/page.jsp"%>
		<s:hidden name="urlname"/>
		<s:hidden name="content.url"/>
		<s:hidden name="content.context" value="<%=context%>" />
		<tr><td width="10%" align="right" height="10%">{*[Title]*}:</td><td align="left">
		<s:textfield  cssClass="input-cmd" label="{*[Title]*}" name="content.title" theme="simple" size="50" /></td></tr>
		<tr><td></td></tr>
		<tr ><td colspan="2" height="90%">
		</td>
		</tr>
	</s:form>
</table>
</body>
<script>
document.getElementById('content.url').value='<%=temp%>';
document.getElementById('urlname').value='<%=temp%>';
document.getElementById('content.id').value='<%=id%>';
document.getElementById('content.title').value='<%=title%>';

</script>
</o:MultiLanguage></html>
