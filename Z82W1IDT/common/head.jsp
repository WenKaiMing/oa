<%@ taglib uri="myapps" prefix="o"%>
<% out.println("<!--TARGET SERVLETPATH:"+request.getServletPath()+"-->");%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var title_uf = '{*[UserField]*}';
var title_df = '{*[DepartmentField]*}';
var title_more = '{*[More]*}';
</script>
</o:MultiLanguage>
<link type="text/css" href="<s:url value='/script/jquery-ui/external/ui.dialog.maximize.css'/>" rel="stylesheet"/>


<link type="text/css" href="<s:url value='/script/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>

<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>

<script src="<s:url value='/script/jquery-ui/plugins/jquery.form.js'/>"></script>

<!-- jquery-ui window plugin -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/external/jquery.bgiframe-2.1.1.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/external/ui.dialog.maximize.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/external/jquery-framedialog.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<!-- layout -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>


<!-- jquery-obpm bridge -->
<script type="text/javascript" src="<s:url value='/script/obpm/adapter/jquery-bridge.js'/>"></script>

<!-- Platform lib -->
<script src="<s:url value='/script/util.js'/>"></script>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/script/generic.js"/>'></script>

<!-- DWR -->
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<!-- Calendar Compoment -->