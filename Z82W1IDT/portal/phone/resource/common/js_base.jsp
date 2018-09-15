<script id="script" src="<s:url value='/portal/phone/resource/js/jquery-1.11.3.min.js'/>"></script>

<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/ratchet.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/global.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/animate.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/css.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/selectAboutField/css/jquery.multiselect2side.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/dateField/mobiscroll/css/mobiscroll.custom-2.14.4.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/swiper.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/weui.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/weixinImageUpload/obpm.weixinImageUpload.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/weixinRecord/obpm.weixinRecord.css?v=1'/>" />

<!-- DWR -->
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>


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