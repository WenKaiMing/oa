<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!-- DWR -->
<script src="<s:url value='/dwr/engine.js'/>"></script>
<script src="<s:url value='/dwr/util.js'/>"></script>
<!-- form-js -->
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/StateMachineUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
<script charset="utf-8" src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script charset="utf-8" src="https://api.map.baidu.com/api?v=2.0&ak=4b13e87bef9c0298377377db89487985&s=1"></script>
<%
if(debug){
%>
<!-- main-js -->
<script src="<s:url value='/portal/phone/resource/js/jquery-1.11.3.min.js'/>" id="script"></script>
<script src='<s:url value="/portal/phone/resource/js/ajaxPageProcess.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/ratchet.min.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/jquery.swiper-3.3.1.min.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/homepage.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/menu.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/flowCenter.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/common.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/jquery.cookie.js" />'></script>
<script src='<s:url value='/portal/phone/resource/js/tableList.js' />'></script>
<script src='<s:url value='/portal/phone/resource/js/jquery.lazyload.js' />'></script>

<!-- router-js -->
<script src='<s:url value="/portal/phone/resource/js/backbone.route.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/js/phone.router.js"/>'></script>

<!-- Platform lib -->
<script src='<s:url value="/portal/phone/resource/js/swiper.min.js"/>'></script>
<script src='<s:url value='/portal/phone/resource/js/iscroll.js' />'></script>
<script src='<s:url value="/portal/phone/resource/component/dateField/mobiscroll/js/mobiscroll.custom-2.14.4.min.js"/>'></script>
<script src="<s:url value='/portal/phone/resource/component/obpm.form.util.js'/>"></script>
<script src='<s:url value="/portal/phone/resource/component/inputField/obpm.inputField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/buttonField/obpm.buttonField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/textareaField/obpm.textareaField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/checkboxField/obpm.checkboxField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/radioField/obpm.radioField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/selectField/obpm.selectField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/dateField/obpm.dateField.js"/>'></script>
<script src="<s:url value='/portal/phone/resource/component/upload/obpm.fileUpload.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/component/onlinetakephoto/obpm.onlineTakePhoto.js?v=20150827'/>"></script>
<script src='<s:url value="/portal/phone/resource/component/map/obpm.baiduMap.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/departmentField/obpm.departmentField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/viewDialogField/obpm.viewDialogField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/treeDepartmentField/obpm.treeDepartmentField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/userField/obpm.userField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/userbox/jquery.userbox.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/includedView/obpm.includedView.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/includedView/obpm.plugin.includedView.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/wordField/obpm.wordField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/flowHistoryField/obpm.flowHistoryField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/flowReminderHistoryField/obpm.flowReminderHistoryField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/weixinGpsField/obpm.weixinGpsField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/surveyField/obpm.surveyField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/weixinImageUpload/obpm.weixinImagePinchzoom.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/weixinImageUpload/obpm.weixinImageUpload.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/weixinRecord/obpm.weixinRecord.js?v=23"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/qrcodeFiled/obpm.qrcodeField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/qrcodeFiled/lib/jquery.qrcode-0.12.0.min.js"/>'></script>
<!-- image&file upload -->
<script src="<s:url value='/portal/phone/resource/component/upload/obpm.fileUpload.js'/>"></script>
<!-- htmlEditor -->
<script src='<s:url value="/portal/phone/resource/component/htmlEditor/obpm.htmlEditorField.js"/>'></script>
<!-- selectAbout -->
<script src='<s:url value="/portal/phone/resource/component/selectAboutField/obpm.selectAboutField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/selectAboutField/jquery.multiselect2side.js"/>'></script>
<!-- suggest -->
<script src='<s:url value="/portal/phone/resource/component/suggest/obpm.suggestField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/suggest/typeahead.min.js"/>'></script>
<!-- Tab Menu Compoment -->
<script src='<s:url value="/portal/phone/resource/component/tabField/obpm.tabField.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/pending/obpm.pending.js"/>'></script>

<!-- 弹出层 -->
<script src='<s:url value="/portal/phone/resource/component/dialog/dialog.js"/>'></script>
<script src="<s:url value='/portal/phone/resource/js/jquery-obpm-extend.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script  src='<s:url value="/portal/phone/resource/component/obpm.popup.js"/>'></script>
<!-- button -->
<script src='<s:url value="/portal/phone/resource/document/obpm.ui.js"/>'></script>
<!-- form-js -->
<script src='<s:url value="/portal/phone/resource/document/document.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/workflow/runtime/flowhistory.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/workflow/flowProcess.free.js"/>'></script>
<script src='<s:url value="/portal/share/script/jSignature/jSignature.min.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/weixin/weixin.jsApi.js"/>'></script>
<!-- view-js -->
<script src='<s:url value="/portal/phone/resource/component/view/common.js" />'></script>
<script src='<s:url value="/portal/phone/resource/component/view/view.js" />'></script>
<script src='<s:url value='/portal/phone/resource/component/view/obpm.listView.js' />'></script>
<script src='<s:url value="/portal/phone/resource/component/view/obpm.displayView.js" />'></script>

<!-- Activities -->
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.core.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveStartWorkflow.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.WorkflowProcess.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.save.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveBack.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveWithoutValidate.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveCloseWindow.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveNew.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.back.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.none.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.saveCopy.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.closeWindow.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.htmlPrint.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.htmlPrintWithHis.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.flexPrint.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.exportToPdf.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.fileDownload.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.signature.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.transpond.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.jumpTo.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.create.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.delete.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.clearAll.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.query.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.batchApprove.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.exportToExcel.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.printView.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.excelImport.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.batchSignature.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.archive.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/activity/obpm.activity.startWorkflow.js"/>'></script>
<script src='<s:url value="/portal/phone/resource/component/confirm/obpm.confirm.js"/>'></script>

<script src="<s:url value='/portal/phone/resource/js/util.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/js/list.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/js/template.js'/>"></script>

<!-- echarts -->
<script src="<s:url value='/portal/phone/resource/js/echarts.js'/>"></script>
<script src='<s:url value="/portal/phone/resource/js/report/oReport.js"/>'></script>

<!-- 水印 -->
<script src='<s:url value='/portal/share/script/jquery.watermark.js' />'></script>
<%
}else{
%>
<%@include file="./main_form_view_js.jsp"%>
<%} %>