<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% out.println("<!--TARGET SERVLETPATH:"+request.getServletPath()+"-->");%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var application = '<%= request.getParameter("application")%>';
var isCloseDialog = '<%=request.getParameter("isCloseDialog")%>';

</script>
</o:MultiLanguage>

<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>


<!-- jquery-obpm bridge -->
<script type="text/javascript" src="<s:url value='/script/obpm/adapter/jquery-bridge.js'/>"></script>

