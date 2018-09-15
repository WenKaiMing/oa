<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% out.println("<!--TARGET SERVLETPATH:"+request.getServletPath()+"-->");%>
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

//personalmessage.js
var personalmessage_title_sended = '{*[cn.myapps.core.workflow.notification.sended]*}';
var personalmessage_title_pending = '{*[cn.myapps.core.workflow.notification.pending]*}';
var personalmessage_title_pending_overdue = '{*[cn.myapps.core.workflow.notification.pending.overdue]*}';
var personalmessage_title_rollback = '{*[cn.myapps.core.workflow.notification.rollback]*}';
</script>
</o:MultiLanguage>
<!-- DWR--需要先于jQuery加载 -->
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>

<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<!-- 右键插件smartMenu样式 -->
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smartMenu.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet" />
<script type="text/javascript" src='<s:url value='/portal/share/script/jquery-ui/js/jquery-smartMenu.js' />'></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/jquery.form.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<!-- layout -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<!-- jquery-ui 解决ie6中div层不能遮挡住下拉框的问题 -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/external/jquery.bgiframe-2.1.1.js'/>"></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<!-- Platform lib -->
<script type="text/javascript" src="<s:url value='/portal/share/script/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/list.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/script/generic.js"/>'></script>
<link type="text/css" href="<s:url value='/portal/share/component/dialog/css/dialog.css'/>" rel="stylesheet"/>
<script type="text/javascript" src='<s:url value="/portal/share/component/dialog/dialog.js"/>'></script>

<script type="text/javascript" src="<s:url value='/portal/share/component/obpm.form.util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/onlinetakephoto/obpm.onlineTakePhoto.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/map/obpm.baiduMap.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/checkboxField/obpm.checkboxField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/radioField/obpm.radioField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/inputField/obpm.inputField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/textareaField/obpm.textareaField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/selectField/obpm.selectField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/dateField/obpm.dateField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/departmentField/obpm.departmentField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/viewDialogField/obpm.viewDialogField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/treeDepartmentField/obpm.treeDepartmentField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/userField/obpm.userField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/obpm.attachmentUpload2DataBase.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/obpm.imageUpload2DataBaseField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/includedView/obpm.includedView.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/pending/obpm.pending.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/wordField/obpm.wordField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/genericWordField/obpm.genericWordField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/flowHistoryField/obpm.flowHistoryField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/obpm.qrcodeField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/lib/jquery.qrcode-0.12.0.min.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/weixinGpsField/obpm.weixinGpsField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/surveyField/obpm.surveyField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/flowReminderHistoryField/obpm.flowReminderHistoryField.js"/>'></script>
<link rel="stylesheet" href="<s:url value='/portal/share/component/sign/obpm.sign.css'/>" />
<script  src="<s:url value='/portal/share/component/sign/obpm.sign.js'/>"></script>


<!-- image&file upload -->
<script type="text/javascript" src="<s:url value='/portal/share/component/upload/upload.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/upload/obpm.fileUpload.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/filemanager/obpm.fileManager.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/upload2DataBase.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/uploadAttachment2DataBase.js"/>'></script>

<!-- htmlEditor -->
<script type="text/javascript" src='<s:url value="/portal/share/component/htmlEditor/obpm.htmlEditorField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/htmlEditor/xheditor/xheditor-1.1.12-zh-cn.min.js"/>'></script>

<!-- informationfeedback -->
<script type="text/javascript" src='<s:url value="/portal/share/component/informationfeedbackField/obpm.informationfeedbackField.js"/>'></script>

<!-- selectAbout -->
<link rel="stylesheet" href="<s:url value='/portal/share/component/selectAboutField/css/jquery.multiselect2side.css'/>" type="text/css">
<script type="text/javascript" src='<s:url value="/portal/share/component/selectAboutField/obpm.selectAboutField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/selectAboutField/jquery.multiselect2side.js"/>'></script>

<!-- suggest -->
<script type="text/javascript" src='<s:url value="/portal/share/component/suggest/obpm.suggestField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/suggest/typeahead.min.js"/>'></script>

<!-- Tab Menu Compoment -->
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/ddtabmenu.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/obpm.tabField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/collapse/collapse.js"/>'></script>
