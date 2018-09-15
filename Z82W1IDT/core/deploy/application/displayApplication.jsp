<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<o:MultiLanguage>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">

	<script type="text/javascript">
	var openTab;
function change(obj){
	document.getElementsByName("btnBasicInfo")[0].className = "btcaption";
	document.getElementsByName("btnUsual")[0].className = "btcaption";
	document.getElementsByName("btnLibs")[0].className = "btcaption";
	document.getElementsByName("btnTools")[0].className = "btcaption";
	
	window.location.href="<s:url value='/core/deploy/application/edit.action'/>?id=<%=request.getParameter("id") %>&application=<%=request.getParameter("id") %>&mode=application";
	document.getElementById("sec_tab0").style.display="none";
	document.getElementById("sec_tab1").style.display="none";
	document.getElementById("sec_tab2").style.display="none";
	document.getElementById("sec_tab3").style.display="none";
	obj.className = "btcaption-selected";
	//document.getElementById("sec_menu").style.display="none";
}
function clickTab(obj) {

	document.getElementsByName("btnStyleLibs")[0].className = "btcaption";
	document.getElementsByName("btnValidateLibs")[0].className = "btcaption";
	document.getElementsByName("btnExcelConf")[0].className = "btcaption";
	document.getElementsByName("btnMacroLibs")[0].className = "btcaption";
	document.getElementsByName("btnReminder")[0].className = "btcaption";
	document.getElementsByName("btnPage")[0].className = "btcaption";
	document.getElementsByName("btnComponent")[0].className = "btcaption";
	document.getElementsByName("btnResource")[0].className = "btcaption";
	document.getElementsByName("btnRole")[0].className = "btcaption";
	document.getElementsByName("btnHomepage")[0].className = "btcaption";
	document.getElementsByName("btnDataSource")[0].className = "btcaption";
	document.getElementsByName("btnStateLabel")[0].className = "btcaption";
	document.getElementsByName("btnDeveloper")[0].className = "btcaption";
	
	switch (obj.name){ 
		case "btnStyleLibs": frames["frame"].location.href="<s:url value='/core/style/repository/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
		case "btnValidateLibs": frames["frame"].location.href="<s:url value='/core/validate/repository/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
		case "btnExcelConf": frames["frame"].location.href="<s:url value='/core/dynaform/dts/excelimport/list.action'/>?s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
		case "btnMacroLibs": frames["frame"].location.href="<s:url value='/core/macro/repository/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnReminder": frames["frame"].location.href="<s:url value='/core/homepage/reminder/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnPage": frames["frame"].location.href="<s:url value='/core/page/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnComponent": frames["frame"].location.href="<s:url value='/core/dynaform/component/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnResource": frames["frame"].location.href="<s:url value='/core/resource/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnRole": frames["frame"].location.href="<s:url value='/core/role/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnHomepage": frames["frame"].location.href="<s:url value='/core/homepage/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnDataSource": frames["frame"].location.href="<s:url value='/core/dynaform/dts/datasource/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
	    case "btnStateLabel": frames["frame"].location.href="<s:url value='/core/workflow/statelabel/list.action'/>?mode=application&s_applicationid=<%=request.getParameter("id")%>&application=<%=request.getParameter("id")%>";break;
		case "btnDeveloper": frames["frame"].location.href="<s:url value='/core/deploy/application/listJoinedDeveloper.action'/>?id=<%=request.getParameter("id")%>&mode=application";break;
	} 
	obj.className = "btcaption-s-selected";
}

function changeTab(tid, obj) {
	//document.getElementById("sec_menu").style.display="";
	document.getElementsByName("btnBasicInfo")[0].className = "btcaption";
	document.getElementsByName("btnUsual")[0].className = "btcaption";
	document.getElementsByName("btnLibs")[0].className = "btcaption";
	document.getElementsByName("btnTools")[0].className = "btcaption";
	
	var tab = document.getElementById(tid);
	if (openTab) {
		var oriTab = document.getElementById(openTab);
		oriTab.style.display = "none";
	} 
	openTab = tid;
	if (tab) {
		tab.style.display = "";
	}
	obj.className = "btcaption-selected";
}
</script>
<style>
#container {
	width: 100%;
	height: 25px;
	overflow: hidden;
}

.rollbox {
	width: 10000px;
	overflow: hidden;
	display: inline;
	height: 25px;
	float: left;
}

.listContent {
	float: left;
}

table {border:1px solid red}
td {border:1px solid yellow}
div {border:1px solid blue}
</style>
</head>
<script>
function calculateWidth() {
	checkNeededMove();
	var frameWidth = document.body.clientWidth;
	document.getElementById("container").style.width = frameWidth-38;
	resetScrollLeft();
}

function checkNeededMove() {
	var content = document.getElementById("content");
	var clientWidth = document.body.clientWidth;
	
	if (content.offsetWidth < clientWidth) {
		document.getElementById("btnLeft").style.display = "none";
		document.getElementById("btnRight").style.display = "none";
	}
	else {
		document.getElementById("btnLeft").style.display = "";
		document.getElementById("btnRight").style.display = "";
	}
}

function resetScrollLeft() {
	document.getElementById("container").scrollLeft = 0;
}

window.onresize = function() {
	calculateWidth();
}
</script>
	<body onload="calculateWidth()" style="margin:0;">
	<table id="tab_table" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr style="height:27px;">
			<td align="left" valign="bottom" class="nav-td" style="width:10px;">
			&nbsp;
			</td>
			<td align="left" valign="bottom" class="nav-td">
				<img id="btnLeft" style="display:none;cursor:pointer;" src="<s:url value='/resource/imgnew/goleft.gif' />" border="0" />
			</td>
			<td align="left" valign="bottom" class="nav-td">

			<div id="container">
			<div id="rollbox" class="rollbox">
			<div id="content">

			<div class="listContent"> 
				<input type="button" name="btnBasicInfo" class="btcaption-selected" onclick="change(this)" value="{*[cn.myapps.core.deploy.application.basic_info]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnUsual" class="btcaption" onClick="changeTab('sec_tab1', this)" value="{*[Common]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnLibs" class="btcaption" onClick="changeTab('sec_tab2', this)" value="{*[Libraries]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnTools" class="btcaption" onClick="changeTab('sec_tab3', this)" value="{*[Tools]*}" />
			</div>
			</div>
			</div>
			</div>
			</td>
			<td align="left" valign="bottom" class="nav-td">
				<img id="btnRight" style="display:none;cursor:pointer;" src="<s:url value='/resource/imgnew/goright.gif' />" border="0" />
			</td>
		</tr>
		<tr id="sec_menu" style="height:27px;">
		<td colspan="3" style="padding-left:10px;" class="nav-s-td">
			<div id="sec_tab0">
				<div class="listContent">
						<input type="button" name="btn" class="btcaption" onClick="" value="{*[Information]*}" />
					</div>
				</div>
			<div id="sec_tab1">
				<div class="listContent">
					<input type="button" name="btnRole" class="btcaption" onClick="clickTab(this)" value="{*[Role]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnResource" class="btcaption" onClick="clickTab(this)" value="{*[menu]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnHomepage" class="btcaption" onClick="clickTab(this)" value="{*[HomePage]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnReminder" class="btcaption" onclick="clickTab(this)" value="{*[Reminder]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnStateLabel" class="btcaption" onClick="clickTab(this)" value="{*[StateLabel]*}" />
				</div>
			</div>
			<div id="sec_tab2">
				<div class="listContent">
					<input type="button" name="btnMacroLibs" class="btcaption" onclick="clickTab(this)" value="{*[MacroLibs]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnStyleLibs" class="btcaption" onclick="clickTab(this)" value="{*[StyleLibs]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnValidateLibs" class="btcaption" onclick="clickTab(this)" value="{*[ValidateLibs]*}" />
				</div>
			</div>
			<div id="sec_tab3">
				<div class="listContent">
					<input type="button" name="btnDeveloper" class="btcaption" onClick="clickTab(this)" value="{*[Developer]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnExcelConf" class="btcaption" onclick="clickTab(this)" value="{*[cn.myapps.core.validate.repository.excelconf]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnComponent" class="btcaption" onClick="clickTab(this)" value="{*[Component]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnDataSource" class="btcaption" onClick="clickTab(this)" value="{*[DataSource]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnPage" class="btcaption" onclick="clickTab(this)" value="{*[Page]*}" />
				</div>
			</div>
		</td>
		<td>
			
		</td>
		</tr>
		<tr>
			<td colspan="4" valign="top">
			<iframe scrolling="auto" style="overflow: auto; height: 100%; width: 100%;" id="frame" name="frame"
				src="<s:url value='/core/deploy/application/edit.action'/>?id=<%=request.getParameter("id") %>&mode=application"
				width="820" height="500" frameborder="0" /></iframe></td>
		</tr>
	</table>

	<script type="text/javascript">
var content = document.getElementById("content");
var container = document.getElementById("container");
var btnLeft = document.getElementById("btnLeft");
var btnRight = document.getElementById("btnRight");

btnLeft.onmousedown = function() {
	obj = setInterval("moveLeft()",speed);
}

btnLeft.onmouseout = function() {
	clearInterval(obj);	
}

btnLeft.onmouseup = function() {
	clearInterval(obj);	
}

btnRight.onmousedown = function() {
	obj=setInterval("moveRight()",speed);
}

btnRight.onmouseout = function() {
	clearInterval(obj);	
}

btnRight.onmouseup = function() {
	clearInterval(obj);	
}

var speed=25; //数值越大滚动速度越慢
var space = 5; //每次移动的像素
var obj;
function moveLeft() {
	if (container.scrollLeft > 0) {
		container.scrollLeft -= space;
	}
	else {
		clearInterval(obj);	
	}
}

function moveRight() {
	if(content.offsetWidth-container.scrollLeft<=0)
		container.scrollLeft-=content.offsetWidth;
	else {
		if (content.offsetWidth - container.scrollLeft <= container.offsetWidth)
		{
			clearInterval(obj);
		}else {
			container.scrollLeft += space;	
		}
	}
}

  </script>
	</body>
</o:MultiLanguage>
</html>