<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="java.io.BufferedReader"%> 
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>  
<%@ page import="java.io.OutputStreamWriter"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection "%>
<%@ page import="cn.myapps.core.widget.ejb.PageWidget"%>

<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<div class="widgetContent" _type="workflow_analyzer" 
_applicationId="<s:property value='#request.widget.applicationid'/>" 
_height="<s:property value='#request.widget.height'/>">
<%
	PageWidget widget = (PageWidget)request.getAttribute("widget");
	String height = widget!=null&&widget.getHeight().length()>0? widget.getHeight(): "300px";
%>
<iframe id="showFrame" style="border: 0; width: 100%;height: <%=height %>;" src='
	<s:url action="showWorkflowAnalyzer" namespace="/portal/widget"><s:param name="type" value="#request.widget.actionContent"/><s:param name="applicationId" value="#request.widget.applicationid"/><s:param name="dateRange" value="TODAY"/></s:url>
  ' scrolling="no" frameborder="no"></iframe>
</div>