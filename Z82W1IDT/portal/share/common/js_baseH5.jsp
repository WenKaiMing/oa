<!-- DWR--需要先于jQuery加载 -->
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>

<script src="<s:url value='/portal/share/script/bootstrap/script/jquery.min.js'/>"></script> 
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<!-- 右键插件smartMenu样式 -->
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smartMenu.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet" />
<script type="text/javascript" src='<s:url value='/portal/share/script/jquery-ui/js/jquery-smartMenu.js' />'></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/jquery.form.js'/>"></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<!-- layout -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>

<!-- Platform lib -->
<script type="text/javascript" src="<s:url value='/portal/share/script/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/list.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/script/generic.js"/>'></script>

<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/lib/jquery.qrcode-0.12.0.min.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/obpm.qrcodeField.js"/>'></script>

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