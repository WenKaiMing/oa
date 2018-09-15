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

<!-- 
<div class="widgetContent" _type="extlink" 
_applicationId="<s:property value='#request.widget.applicationid'/>" 
_url="<s:property value='#request.widget.actionContent' escape='false'/>" _height="<s:property value='#request.widget.height'/>">
<%
String urlStr = ((PageWidget)request.getAttribute("widget")).getActionContent();
%>
<iframe style="border: 0; width: 100%;" src=" <%=urlStr%>"  scrolling="no" frameborder="no"></iframe>

</div>
 -->