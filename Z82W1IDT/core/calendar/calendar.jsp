<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.workcalendar.util.*"%>
<%@ page import="cn.myapps.core.workcalendar.standard.ejb.StandardDayVO"%>
<html><o:MultiLanguage>
<head>
<title>My97DatePicker</title>
<link rel="stylesheet" href="calendar.css" type="text/css">
<script type="text/javascript" src="calendar.js"></script>

<%
Year year=(Year)session.getAttribute("year");
String toHtml="";
String dayInfo="";
String dayInfo_bak="";
StandardDayVO[][] days= new StandardDayVO[6][7];
if (year!=null){
	String monthindex=(String)session.getAttribute("month");
	if (monthindex!=null){
		Month month=year.getMonths(Integer.parseInt(monthindex));
		if (month!=null){
			
			int ii=Integer.parseInt((String)session.getAttribute("dayI"));
			int jj=Integer.parseInt((String)session.getAttribute("dayJ"));
			days= ((StandardDayVO[][])month.getDays());
		    if (days!=null){
		    	int yearvalue=year.getYearValue();
		    	int monthIndex=Integer.parseInt(monthindex)+1;
		    	dayInfo=days[ii][jj].getDayInfo(yearvalue,monthIndex);
		    	days[ii][jj].setBorder(true);
		    	
		    }
		    toHtml=month.toHtml();
		}
	}
}
%>

<SCRIPT language="javascript">

function dayInfo(day) {

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
	else
		obj.className="Wday";
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
}

</script>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0
	onload="calendardiv_onload()">
	<s:form action="view" method="post">
	<table width="200" height='110' border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center">
			<table width='180' border='0' valign='top'>
											
					<tr>
						<td><s:select id="yearvalue" name="yearValue"
							onchange="javascript:submit();" list="_yearValueList"
							theme="simple" /></td>
						<td><s:select id="month" name="month"
							onchange="javascript:submit();"
							list="#{0:'{*[1]*}',1:'{*[2]*}',2:'{*[3]*}',3:'{*[4]*}',4:'{*[5]*}',5:'{*[6]*}',6:'{*[7]*}',7:'{*[8]*}',8:'{*[9]*}',9:'{*[10]*}',10:'{*[11]*}',11:'{*[12]*}'}"
							theme="simple" /></td><td></td>
						<td><s:select name="content.id"
							onchange="javascript:submit();" listKey="id" listValue="name"
							list="_calendarList" theme="simple" /></td>
					</tr>
								
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<table width='200' height='100' border='0' align='center' valign='top'>
				<tr>
					<td width="100%"  height='100%' align="center">
					<div id="calendardiv"></div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</s:form>
	
</body>
</o:MultiLanguage></html>
