
<link rel="stylesheet" href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>">
<link rel="stylesheet" href='<o:Url value="/resource/component/dateField/datetimepicker/bootstrap-datetimepicker.css"/>' type="text/css">
<%
boolean isDebug = false;
if(isDebug){
%>

<!-- bootstrap -->
<link rel="stylesheet" href="<o:Url value='/resource/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/script/jquery.pagination/jquery.pagination.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/css/animate.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/component/upload/viewer/viewer.min.css'/>" type="text/css">
<link rel="stylesheet" href="<o:Url value='/resource/component/selectAboutField/css/jquery.multiselect2side.css'/>" type="text/css">
<link type="text/css" href="<o:Url value='/resource/component/dialog/css/dialog.css'/>" rel="stylesheet"/>
<link href="<s:url value='/portal/share/script/messenger/messenger.css'/>" type="text/css" rel="stylesheet" />
<link href="<s:url value='/portal/share/script/messenger/messenger-theme-flat.css'/>" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="<s:url value='/portal/share/component/weixinRecord/obpm.weixinRecord.css?v=1'/>" />
<!-- component showMessage -->
<link rel="stylesheet" href="<o:Url value='/resource/component/showMessage/sweetalert/sweetalert.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/component/showMessage/toastr/toastr.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/share/component/sign/obpm.sign.css'/>" />
<link rel="stylesheet" href="<o:Url value='/resource/css/base.css'/>" type="text/css" />
<link rel="stylesheet" href="<o:Url value='/resource/css/documentModule.css'/>" type="text/css" />
<link rel="stylesheet" href="<o:Url value='/resource/css/main.css'/>" />
<%
}else{
%>
<%@ include file="./view_css.jsp" %>
<%
}
%>