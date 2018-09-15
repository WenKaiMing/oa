<!-- DWR--需要先于jQuery加载 -->
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>
<!-- jquery-1.11.3 -->
<script src="<o:Url value='/resource/js/jquery-1.11.3.min.js'/>"></script> 
<!-- bootstrap引入 -->
<link rel="stylesheet" href="<o:Url value='/resource/css/bootstrap.min.css'/>" />
<script src="<o:Url value='/resource/js/bootstrap.min.js'/>"></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<o:Url value='/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- Platform lib -->
<script type="text/javascript" src="<s:url value='/portal/share/script/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/H5/resource/script/list.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/script/generic.js"/>'></script>
<!-- 翻页 -->
<script type="text/javascript" src="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.js'/>"></script>
<link rel="stylesheet" href="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.css'/>" />
<!-- 其他 -->
<link rel="stylesheet" href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/css/animate.css'/>" />

<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script src="<o:Url value='/resource/js/jquery.slimscroll.min.js'/>"></script>
<script src="<o:Url value='/resource/js/jquery.nicescroll.js'/>"></script>
<script src="<o:Url value='/resource/script/workflow.status.js'/>"></script> 
<script src="<o:Url value='/resource/script/common.js'/>"></script> 
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var application = '<%= request.getParameter("application")%>';
var isCloseDialog = '<%=request.getParameter("isCloseDialog")%>';
var title_uf = '{*[UserField]*}';
var title_df = '{*[DepartmentField]*}';
var title_more = '{*[More]*}';
var title_addAuditor = '{*[cn.myapps.core.workflow.add_auditor]*}';
var title_upload = '{*[Upload]*}';
var title_map = '{*[map]*}';
var title_onlinetakephoto = '{*[OnLineTakePhotoField]*}';
var loadError = "{*[page.can.not.load.document]*}";//see ntkoofficecontrol.js
var checkBrowserSettings = '{*[page.check.browser.security.settings]*}';//see ntkoofficecontrol.js
</script>
</o:MultiLanguage>