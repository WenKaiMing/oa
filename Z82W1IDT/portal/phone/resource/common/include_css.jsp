<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href='<o:Url value="/resource/fonts/custom/widget_icon_lib.css"/>' />
<link rel="stylesheet" href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>">
<%
boolean debug = false;
if(debug){
%>
<!-- main-css -->
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/ratchet.min.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/weui.min.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/swiper.min.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/font-awesome.min.css"/>'/>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/global.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/animate.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/documentModule.css"/>'/>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/css.css"/>'>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/launch.css"/>'/>
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/other.css"/>'/>
<!-- form-css -->
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/selectAboutField/css/jquery.multiselect2side.css'/>"/>
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/dateField/mobiscroll/css/mobiscroll.custom-2.14.4.min.css'/>"/>
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/weixinImageUpload/obpm.weixinImageUpload.css'/>"/>
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/weixinRecord/obpm.weixinRecord.css?v=1'/>"/>
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/flowProcess.css'/>"/>
<!-- listView-css -->
<link rel="stylesheet" href="<o:Url value='/resource/document/main-front.css'/>"/>
<!-- newCss -->
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/css/new.css'/>"/>
<!-- report -->
<link rel="stylesheet" href='<s:url value="/portal/phone/resource/css/report.css"/>'>
<%
}else{
%>
<%@include file="./main_form_view_css.jsp"%>
<%} %>