<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.workcalendar.util.*"%>
<%@ page import="cn.myapps.core.workcalendar.standard.ejb.StandardDayVO"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@page import="cn.myapps.core.workcalendar.standard.ejb.BaseDay"%><html>
<o:MultiLanguage>
	<head>
	<title>{*[WorkCalendar]*}</title>
	<script src="<s:url value="/script/list.js"/>"></script>
	<script src="<s:url value='/script/help.js'/>"></script>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
	<%
		Year year = (Year) session.getAttribute("year");
			String toHtml = "";
			String dayInfo = "";
			String dayInfo_bak = "";
			BaseDay[][] days = new StandardDayVO[6][7];
			if (year != null) {
				String monthindex = (String) session.getAttribute("month");
				if (monthindex != null) {
					Month month = year.getMonths(Integer
							.parseInt(monthindex) - 1);
					if (month != null) {
						Integer dayI = (Integer) session.getAttribute("dayI");
						Integer dayJ = (Integer) session.getAttribute("dayJ");
						Boolean flag = (Boolean) session.getAttribute("showToday");
						boolean showToday = flag!=null?flag.booleanValue():false;
						int ii = dayI != null ? dayI.intValue() : 0;
						int jj = dayJ != null ? dayJ.intValue() : 0;
						days = month.getDays();
						if (days != null) {
							int yearvalue = year.getYearValue();
							int monthIndex = Integer.parseInt(monthindex);
							dayInfo = days[ii][jj].getDayInfo(yearvalue,
									monthIndex);
							if (showToday)
								days[ii][jj].setBorder(true);
							for (int i = 0; i < 6; i++) {
								for (int j = 0; j < 7; j++) {
									dayInfo_bak += "<div id='dayInfo_"
											+ days[i][j].getDayIndex()
											+ "'>";
									dayInfo_bak += days[i][j].getDayInfo(
											yearvalue, monthIndex);
									dayInfo_bak += "</div>";
								}
							}
						}
						toHtml = month.toHtml();
					}
				}
			}
	%>
	<SCRIPT language="javascript">
function dayInfo(day) {
	var daydiv=document.getElementById("dayInfo_"+day);
	var info=daydiv.innerHTML;
	if (info!=null && info.length>0){	
		var dayInfo=document.getElementById("daydiv");
		info = addSpaceForIE(info);
		dayInfo.innerHTML=info;
	}
}

function submit()
{ 
	document.forms[0].action = document.forms[0].action + "?refresh=true";
	document.forms[0].submit();
}

function calendardiv_onload(){
	var toHtml="<%=toHtml%>";
	var div=document.getElementById("calendardiv");
	div.innerHTML=toHtml;
	
	var dayinfo="<%=dayInfo%>";
	var daydiv=document.getElementById("daydiv");
	dayinfo = addSpaceForIE(dayinfo);
	daydiv.innerHTML=dayinfo;
	
	var dayinfo_bak="<%=dayInfo_bak%>";
	var daydiv_bak=document.getElementById("daydiv_bak");
	daydiv_bak.innerHTML=dayinfo_bak;
	sort("yearvalue");
	
	//add space on the Calendar-Info
	if (window.ActiveXObject){
		var remarkStr = document.getElementById("remark");
		remarkStr.innerHTML = addSpaceForIE(remarkStr.innerHTML);
	}	
}

function showStandardsList(){
	var domainids=document.getElementById("domain").value;
	var domainid=domainids.split(",")[0];
	var url = "<s:url value='/core/calendar/standard/list.action'></s:url>?domain="+domainid+"&_calendarid=<s:property value="content.id" />";
	OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.displayView.working-weeks_list]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("domain_workCalendar_info");
					var viewurl="<s:url action='displayView'><s:param name="domain" value="#parameters.domain" /></s:url>&_calendarid=<s:property value="content.id" />";
  					window.location.replace(viewurl);
				}
		});
}

function showSpecialsList(){
	var domainids=document.getElementById("domain").value;
	var domainid=domainids.split(",")[0];
	var url = "<s:url value='/core/calendar/special/list.action'></s:url>?domain="+domainid+"&_calendarid=<s:property value="content.id" />";
	OBPM.dialog.show({
				opener:window.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.displayView.title.special_Day_List]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("domain_workCalendar_info");
					var viewurl="<s:url action='displayView'><s:param name="domain" value="#parameters.domain" /></s:url>&_calendarid=<s:property value="content.id" />";
  					window.location.replace(viewurl);
				}
		});
}

function onMouseOver(obj,status){
	if (status==0)
		obj.className="WwdayOn";
	else
		obj.className="WdayOn";
}

function onMouseOut(obj,status){
	if (status==0)
		obj.className="Wwday";
	else if (status==3)
		obj.className="Wtoday";	
	else if (status==2)
		obj.className="Wspcday";
	else
		obj.className="Wday";
}

function sort(sId) {
 if(!document.getElementById(sId)){//如果传过来的ID没有找到，就提示一下；
  return;
 }
 var lst = document.getElementById(sId); //得到select 的ID；
 var selectValue = lst.options[lst.selectedIndex].value;
 var ops = []; //设一个空的数组
 while(lst.options.length){ 
  var b = lst.options[lst.options.length - 1];
  ops.unshift(lst.removeChild(b)); //从节点中移除并存在数组中
 }
 ops.sort(function (a,b){return a.value-b.value;}); //排列用的一个匿名函数
 while(ops.length){
  lst.appendChild(ops.shift()); //重新填加在节点上
 }
 var i = 0;
 while(i<lst.options.length){
 	if (lst.options[i].value==selectValue){
 		lst.options[i].selected=true;
 		break;
 	}
 	i++;
 }
 lst = null;
}

function doExit(){
	var url = '<s:url value="/core/calendar/calendarlist.action"/>?domain=<%=request.getParameter("domain") %>&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>';
	window.location.replace(url);
}

//add the space in ie
function addSpaceForIE(info){
	if (window.ActiveXObject){
		info = info.replace(/&nbsp;&nbsp;&nbsp;&nbsp;/,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	}
	return info;
}

jQuery(document).ready(function(){
	cssListTable();
	calendardiv_onload();
	window.top.toThisHelpPage("domain_workCalendar_info");
});
</script>
</head>
<body id="domain_workCalendar" class="listbody">
	<div class="ui-layout-center">
	<s:hidden id="year" value="#session.year"></s:hidden>
	<s:bean
		name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper"
		id="ch">
		<s:param name="domain" value="#parameters.domain" />
	</s:bean>
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[WorkCalendar]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="Working_weeks" title="{*[Working-weeks]*}" class="button-image" onClick="showStandardsList();"><img
							src="<s:url value="/resource/imgnew/act/act_21.gif"/>">{*[Working-weeks]*}</button>
						<button type="button" id="Special_Day" title="{*[cn.myapps.core.domain.displayView.special_day]*}" class="button-image" onClick="showSpecialsList();"><img
							src="<s:url value="/resource/imgnew/act/act_21.gif"/>">{*[cn.myapps.core.domain.displayView.special_day]*}</button>
						<button type="button" title="{*[Exit]*}" class="button-image" onClick="doExit()"><img
							src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
<div id="contentMainDiv" class="contentMainDiv">
	<div id="searchFormTable">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="font-size: 12px">
		<tr>
			<td align="center">
			<table width='80%' align='center'
				style="font-size: 12px" cellpadding='0' cellspacing='0'
				bordercolor='#FFFFFF' valign='top'>
				<s:form name="displayViewForm" action="displayView" method="post">
					<s:if test="#parameters.domain != null">
						<s:hidden id="domain" name="domain" value="%{#parameters.domain}" />
					</s:if>
					<s:else>
						<s:hidden id="domain" name="domain" value="%{#session.FRONT_USER.domainid}" />
					</s:else>
					<tr>
						<td><s:select id="yearvalue" name="yearValue"
							onchange="javascript:submit();" list="_yearValueList"
							theme="simple" /><font style="font-size: 14px">{*[Year]*}</font></td>
						<td><s:select id="month" name="month"
							onchange="javascript:submit();"
							list="#{1:'1',2:'2',3:'3',4:'4',5:'5',6:'6',7:'7',8:'8',9:'9',10:'10',11:'11',12:'12'}"
							theme="simple" /><font style="font-size: 14px">{*[Month]*}</font></td>
						<td></td>
						<td><font style="font-size: 14px">{*[cn.myapps.core.domain.displayView.work_calendar_name]*}：</font>
						<s:hidden theme="simple" name="content.id" />
						<input theme="simple" readonly="readonly" name="content.name" value="{*[<s:property value='content.name' />]*}" /></td>
					</tr>
				</s:form>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<table width='80%' height='200' border='0' align='center'
				style="font-size: 12px" cellpadding='0' cellspacing='0'
				bordercolor='#000000' valign='top'>
				<tr>
					<td width="10%"></td>

					<td width="25%" align="left" valign='top' cellpadding='0'
						cellspacing='0'>
					<div width="100%" align="right">
					<div id="remark" width="100%" style="font-size: 14px" align="left"><b><font
						style="font-size: 16px">{*[cn.myapps.core.domain.displayView.calendar_info]*}:</font></b><br />
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;{*[<s:property value="content.remark" />]*}</div>
					<div id="infodiv" width="100%" align="left" cellpadding='0'
						cellspacing='0'><br />
					<b><font style="font-size: 16px">{*[Legend]*}:</font></b>
					<table width="150" border="0" cellspacing="0" cellpadding="0"
						style="font-size: 14px" align="left">
						<tr align="left">
							<td width="36" height="31" class='Wday'>&nbsp;</td>
							<td bordercolor="#FFFFFF">&nbsp;{*[Working-day]*}</td>
							<td bordercolor="#FFFFFF">&nbsp;</td>
						</tr>
						<tr align="left">
							<td width="36" height="31" align='center' class='Wwday'>&nbsp;</td>
							<td bordercolor="#FFFFFF">&nbsp;{*[Day-off]*}</td>
							<td bordercolor="#FFFFFF">&nbsp;</td>
						</tr>
						<tr align="left">
							<td width="36" height="31" align='center' class="Wspcday">
							&nbsp;</td>
							<td bordercolor="#FFFFFF">&nbsp;{*[cn.myapps.core.domain.displayView.special_day]*}</td>
							<td bordercolor="#FFFFFF">&nbsp;</td>
						</tr>
						<tr align="left">
							<td width="36" height="31" align='center' class="Wtoday">
							&nbsp;</td>
							<td bordercolor="#FFFFFF">&nbsp;{*[Today]*}</td>
							<td bordercolor="#FFFFFF">&nbsp;</td>
						</tr>
					</table>
					</div>
					</div>
					</td>

					<td width="30%" align="center" cellpadding='0' cellspacing='0'>
					<div id="calendardiv" cellpadding='0' cellspacing='0'></div>
					</td>

					<td width="25%" align="left" cellpadding='0' cellspacing='0'>
					<div id="daydiv" cellpadding='0' cellspacing='0' valign='top'
						style="font-size: 12px"></div>
					<div id="daydiv_bak"
						style="font-size: 12px; width: 1px; height: 1px; overflow: hidden"></div>
					</td>

					<td width="10%"></td>
				</tr>

			</table>
			</td>
		</tr>

	</table>
	</div>
</div>
</div>
</body>
</o:MultiLanguage>
</html>
