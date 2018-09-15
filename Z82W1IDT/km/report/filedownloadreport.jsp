<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String domainid = "";
String applicationid = "";
String startDate = (String) request.getParameter("startDate");
String endDate = (String) request.getParameter("endDate");
String columns = (String) request.getParameter("columns");
if(startDate == null)startDate = "";
if(endDate == null) endDate = "";
if(columns == null) columns = "10";
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>{*[cn.myapps.km.report.file_download_list]*}</title>
<style>
html,body{ margin:0; height:100%; }
.search{ width:100%;height: 25px; float: left;}
.report{ height:90%;}
</style>
</head>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script language="JavaScript">
function init(){
	var columns=<%=columns%>;
	if(columns != null || columns != ""){
		document.getElementById('columns').value = columns;
	}
}

function query(){
	var startDate = document.getElementById('startDate').value;
	var endDate = document.getElementById('endDate').value;
	var column = document.getElementById('columns');
	var columnValue =column.options[column.selectedIndex].value;
	url ='filedownloadreport.jsp?startDate='+startDate + '&endDate='+endDate+'&columns='+columnValue;
    window.location = url;
}
</script>
<body onload="init()">
<div class="search">
{*[cn.myapps.km.report.start_time]*}:<input type='text' name='startDate' id='startDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',skin:'whyGreen'})"  value='<s:property value="%{#parameters.startDate}"/>'/>
{*[cn.myapps.km.report.end_time]*}:<input type='text' name='endDate' id='endDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',skin:'whyGreen'})" value='<s:property value="%{#parameters.endDate}"/>'/>
{*[cn.myapps.km.report.records]*}:<s:select id="columns" name="columns" list="#{'10':'10','20':'20','30':'30','50':'50','100':'100'}"></s:select>
<input type="button" id="submit" name="submit" value="{*[Query]*}" onclick="query()" />
</div>
<div class="report">
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="100%" height="100%" codebase="HTTP/1.1://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" id="ie_chart" align="middle">
	<param name="allowScriptAccess" value="sameDomain">
	<param name="movie" value="../open-flash-chart.swf?data-file=filedowanload.action?startDate=<%=startDate%>%26endDate=<%=endDate%>%26columns=<%=columns%>">
	<param name="quality" value="high">
	<param name="bgcolor" value="#eeeeee">
	<param name="wmode" value="window">
	<embed src="../open-flash-chart.swf?data-file=filedowanload.action?startDate=<%=startDate%>%26endDate=<%=endDate%>%26columns=<%=columns%>" quality="high" width="400" height="400" bgcolor="#eeeeee" style="width:100%;height:100%;" name="chart" align="middle" allowscriptaccess="sameDomain" type="application/x-shockwave-flash" pluginspage="HTTP/1.1://www.macromedia.com/go/getflashplayer" id="chart3" wmode="window">
</object>
</div>
</body>
</o:MultiLanguage></html>