<script src="<s:url value='/dwr/engine.js'/>"></script>
<script src="<s:url value='/dwr/util.js'/>"></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>

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

<script src='<s:url value="/portal/share/script/layer/layer.js"/>'></script>
<script src="<o:Url value='/resource/component/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<%
if(isDebug){
%>
<script src="<s:url value='/portal/share/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>

<script src='<s:url value='/portal/share/script/jquery-ui/js/jquery-smartMenu.js' />'></script>
<script src="<s:url value='/portal/share/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>
<script src="<s:url value='/portal/share/script/jquery-ui/plugins/jquery.form.js'/>"></script>


<script src="<o:Url value='/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script src="<o:Url value='/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>

<!-- layout -->
<script src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>

<!-- Platform lib -->
<script src="<s:url value='/portal/H5/resource/script/util.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/script/list.js'/>"></script>
<script src='<s:url value="/portal/share/script/generic.js"/>'></script>

<script src="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.js'/>"></script>
<script src="<o:Url value='/resource/js/bootstrap.min.js'/>"></script>

<script src="<o:Url value='/resource/js/jquery.nicescroll.js'/>"></script>
<script src="<o:Url value='/resource/script/workflow.status.js'/>"></script> 
<script src="<o:Url value='/resource/script/common.js'/>"></script>


<script src="<o:Url value='/resource/component/obpm.form.util.js'/>"></script> 
<script src="<o:Url value='/resource/component/onlinetakephoto/obpm.onlineTakePhoto.js'/>"></script>

<script src='<o:Url value="/resource/component/map/obpm.baiduMap.js"/>'></script>
<script src='<o:Url value="/resource/component/checkboxField/obpm.checkboxField.js"/>'></script>
<script src='<o:Url value="/resource/component/radioField/obpm.radioField.js"/>'></script>
<script src='<o:Url value="/resource/component/inputField/obpm.inputField.js"/>'></script>
<script src='<o:Url value="/resource/component/textareaField/obpm.textareaField.js"/>'></script>
<script src='<o:Url value="/resource/component/selectField/obpm.selectField.js"/>'></script>
<script src='<o:Url value="/resource/component/departmentField/obpm.departmentField.js"/>'></script>
<script src='<o:Url value="/resource/component/viewDialogField/obpm.viewDialogField.js"/>'></script>
<script src='<o:Url value="/resource/component/treeDepartmentField/obpm.treeDepartmentField.js"/>'></script>
<script src='<o:Url value="/resource/component/userField/obpm.userField.js"/>'></script>
<script src='<o:Url value="/resource/component/includedView/obpm.includedView.js"/>'></script>
<script src='<o:Url value="/resource/component/pending/obpm.pending.js"/>'></script>
<script src='<o:Url value="/resource/component/wordField/obpm.wordField.js"/>'></script>
<script src='<o:Url value="/resource/component/genericWordField/obpm.genericWordField.js"/>'></script>
<script src='<o:Url value="/resource/component/flowHistoryField/obpm.flowHistoryField.js"/>'></script>
<script src='<o:Url value="/resource/component/flowReminderHistoryField/obpm.flowReminderHistoryField.js"/>'></script>
<script src='<o:Url value="/resource/component/weixinGpsField/obpm.weixinGpsField.js"/>'></script>
<script src='<o:Url value="/resource/component/surveyField/obpm.surveyField.js"/>'></script>
<script src='<o:Url value="/resource/component/buttonField/obpm.buttonField.js"/>'></script>
<script src='<o:Url value="/resource/component/qrcodeFiled/obpm.qrcodeField.js"/>'></script>
<script src='<o:Url value="/resource/component/qrcodeFiled/lib/jquery.qrcode-0.12.0.min.js"/>'></script>

<script src='<s:url value="/portal/share/component/htmlEditor/ueditor/ueditor.config.js"/>'></script>
<script src='<s:url value="/portal/share/component/htmlEditor/ueditor/ueditor.all.min.js"/>'></script>
<script src='<s:url value="/portal/share/component/htmlEditor/ueditor/lang/zh-cn/zh-cn.js"/>'></script>


<!-- datetimepicker -->
<script src='<o:Url value="/resource/component/dateField/obpm.dateField.js"/>'></script>
<script src='<o:Url value="/resource/component/dateField/datetimepicker/moment-with-locales.js"/>'></script>
<script src='<o:Url value="/resource/component/dateField/datetimepicker/bootstrap-datetimepicker.js"/>'></script>

<!-- image&file upload -->
<script src="<o:Url value='/resource/component/upload/obpm.fileUpload.js'/>"></script>
<script src='<o:Url value="/resource/component/filemanager/obpm.fileManager.js"/>'></script>

<!-- image&file viewer -->
<script src="<o:Url value='/resource/component/upload/viewer/viewer.min.js'/>"></script>

<!-- htmlEditor -->
<script src='<o:Url value="/resource/component/htmlEditor/obpm.htmlEditorField.js"/>'></script>
<!-- selectAbout -->
<script src='<o:Url value="/resource/component/selectAboutField/obpm.selectAboutField.js"/>'></script>
<script src='<o:Url value="/resource/component/selectAboutField/jquery.multiselect2side.js"/>'></script>

<!-- suggest -->
<script src='<o:Url value="/resource/component/suggest/obpm.suggestField.js"/>'></script>
<script src='<o:Url value="/resource/component/suggest/typeahead.min.js"/>'></script>
<!-- Tab Menu Compoment -->
<script src='<o:Url value="/resource/component/tabField/ddtabmenu.js"/>'></script>
<script src='<o:Url value="/resource/component/tabField/obpm.tabField.js"/>'></script>
<script src='<o:Url value="/resource/component/tabField/collapse/collapse.js"/>'></script>
<script src='<o:Url value="/resource/component/dialog/dialog.js"/>'></script>
<script src="<s:url value='/portal/share/script/messenger/messenger.min.js'/>"></script>
<script src="<s:url value='/portal/share/script/messenger/messenger-theme-flat.js'/>"></script>

<script src='<s:url value="/portal/share/component/weixinRecord/obpm.weixinRecord.js"/>'></script>
<script src="<o:Url value='/resource/component/showMessage/sweetalert/sweetalert.min.js'/>"></script>
<script src="<o:Url value='/resource/component/showMessage/toastr/toastr.min.js'/>"></script> 
<script src="<o:Url value='/resource/component/showMessage/obpm.showMessage.js'/>"></script>
<script  src="<s:url value='/portal/share/component/sign/obpm.sign.js'/>"></script>
<script src="<o:Url value='/resource/js/template.js'/>"></script>

<!-- 飞入购物车效果组件 -->
<script src="<o:Url value='/resource/js/jquery.fly.min.js'/>"></script>

<script src='<s:url value="/portal/share/script/unload.js"/>'></script>
<script src='<s:url value="/portal/share/component/showHistoryRecord/obpm.showHistoryRecord.js"/>'></script>
<script src='<s:url value="/portal/share/component/pending/obpm.pending.js"/>'></script>
<script src='<s:url value="/portal/share/script/document/document.js"/>'></script>
<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script src='<o:Url value="/resource/js/obpm.ui.js"/>'></script>

<!--jinge weboffice -->
<script src='<o:Url value="/resource/component/webofficeField/obpm.webofficeField.js"/>'></script>

<!-- Activities -->
<script src='<o:Url value="/resource/component/activity/obpm.activity.core.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveStartWorkflow.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.WorkflowProcess.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.save.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveBack.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveWithoutValidate.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveCloseWindow.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveNew.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.back.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.none.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.saveCopy.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.closeWindow.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.htmlPrint.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.htmlPrintWithHis.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.flexPrint.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.exportToPdf.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.fileDownload.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.signature.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.transpond.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.jumpTo.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.create.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.delete.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.clearAll.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.query.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.batchApprove.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.exportToExcel.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.printView.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.excelImport.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.batchSignature.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.archive.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.startWorkflow.js"/>'></script>
<script src='<o:Url value="/resource/component/activity/obpm.activity.sign.js"/>'></script>
<!-- flow submit -->
<script src='<s:url value="/portal/share/script/jSignature/jSignature.min.js"/>'></script>
<script src='<s:url value="/portal/share/script/jSignature/plugins/jSignature.CompressorBase30.js"/>'></script>
<script src='<s:url value="/portal/share/script/jSignature/plugins/jSignature.CompressorSVG.js"/>'></script>
<script src='<s:url value="/portal/share/script/jSignature/plugins/jSignature.UndoButton.js"/>'></script> 
<script src='<s:url value="/portal/share/script/jSignature/plugins/signhere/jSignature.SignHere.js"/>'></script> 
<script src='<s:url value="/portal/H5/dynaform/document/flowhistory.js"/>'></script>
<script src='<s:url value="/portal/H5/dynaform/document/flowProcess.free.js"/>'></script>
<script src='<s:url value='/portal/share/script/jquery.watermark.js' />'></script>
<%
}else{
%>
<%@ include file="./form_js.jsp" %>
<%
}
%>

<script type="text/javascript">
	setTimeout(function(){
		jQuery("head").append('<script charset="utf-8" src="https://apis.map.qq.com/api/js?v=2.exp&key=25CBZ-LCS3G-2NPQT-I3F7Y-J4K52-RLFKL&libraries=drawing,geometry,autocomplete,convertor"><\/script>');
	},300);
</script>