<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%@ page import="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper" %>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.user.action.WebUser" %>
<%@page import="cn.myapps.constans.Web"%>

<%
WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String applicationid = (String) (request.getParameter("application")==null?user.getDomainid():request.getParameter("application"));
	String domainid = (String) (request.getParameter("domain")==null?user.getDomainid():request.getParameter("domain"));
	BillDefiHelper bh = new BillDefiHelper();
	String flowid = bh.get_FirstflowId(applicationid,domainid);
	String dateRange = request.getParameter("dateRange");
	String showMode = request.getParameter("showMode");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	String select = request.getParameter("select");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<link rel="stylesheet" href="../../script/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="../../script/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" type="text/css" href="resource/bootstrap-responsive.min.css">
<link rel="stylesheet" href="../../script/bootstrap/css/myapp.css" />
<link rel="stylesheet" href="../../script/bootstrap/css/dashboard.css" />

<script src="../../script/bootstrap/script/jquery.min.js"></script> 
<script type="text/javascript" src="resource/bootstrap.min.js"></script>
<script src="../../script/bootstrap/script/bootstrap-datetimepicker.min.js"></script> 
<script src="../../script/bootstrap/script/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="resource/jquery.tmpl.js"></script>
<script type="text/javascript" src="resource/efficiency.js"></script>
<script type="text/javascript" src="resource/echarts.js"></script>
<script type="text/javascript">
var dateRange = "<%=dateRange%>";
var averageTime = "{*[average.time.consuming.process]*}";
var processInstances = "{*[number.of.process.instances]*}";
/**
 * 获取本周、本季度、本月、上月的开始日期、结束日期
 */
var now = new Date();                    //当前日期
var nowDayOfWeek = now.getDay();         //今天本周的第几天
var nowDay = now.getDate();              //当前日
var nowMonth = now.getMonth();           //当前月
var nowYear = now.getYear();             //当前年
nowYear += (nowYear < 2000) ? 1900 : 0;  //

var lastMonthDate = new Date();  //上月日期
lastMonthDate.setDate(1);
lastMonthDate.setMonth(lastMonthDate.getMonth()-1);
var lastYear = lastMonthDate.getYear();
var lastMonth = lastMonthDate.getMonth();

var nextMonthDate = new Date();  //下月日期
nextMonthDate.setDate(1);
nextMonthDate.setMonth(nextMonthDate.getMonth()+1);
var nextYear = nextMonthDate.getYear();
var nextMonth = nextMonthDate.getMonth();

//格式化日期：yyyy-MM-dd
function formatDate(date) {
    var myyear = date.getFullYear();
    var mymonth = date.getMonth()+1;
    var myweekday = date.getDate();

    if(mymonth < 10){
        mymonth = "0" + mymonth;
    }
    if(myweekday < 10){
        myweekday = "0" + myweekday;
    }
    return (myyear+"-"+mymonth + "-" + myweekday);
}

//获得某月的天数
function getMonthDays(myMonth){
    var monthStartDate = new Date(nowYear, myMonth, 1);
    var monthEndDate = new Date(nowYear, myMonth + 1, 1);
    var   days   =   (monthEndDate   -   monthStartDate)/(1000   *   60   *   60   *   24);
    return   days;
}
//今天
var getCurrentDate = new Date(nowYear, nowMonth, nowDay);
var getCurrentDate  = formatDate(getCurrentDate)

//获得本周的开始日期
var getWeekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
var getWeekStartDate =  formatDate(getWeekStartDate);
//获得本周的结束日期
var getWeekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
var getWeekEndDate =  formatDate(getWeekEndDate);

//获得本月的开始日期
var getMonthStartDate = new Date(nowYear, nowMonth, 1);
var getMonthStartDate =  formatDate(getMonthStartDate);

//获得本月的结束日期
var getMonthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
var getMonthEndDate =  formatDate(getMonthEndDate);

//获取本年的开始时间
var getYearStartDate = new Date(nowYear, 0, 1);
var getYearStartDate = formatDate(getYearStartDate);

//获得本年结束时间
var getYearEndDate = new Date(nowYear, 11, getMonthDays(11));
var getYearEndDate = formatDate(getYearEndDate);


$(function() {
	
	var bodyH = document.body.clientHeight;
	$("#efficiency-list").css("height",((bodyH-289)+"px"));
    $("#container-body").css("height",$("#efficiency-list").height()-60);
	$("#node-list").css("height",((bodyH-250)+"px"));
	$("#names-list").css("height",((bodyH-250)+"px"));
	$("#detailed-list").css("height",((bodyH-250)+"px"));
	
	EFFICIENCY.init();

});

</script>
<script id="tmplEfficiencyTableListItem" type="text/x-jquery-tmpl">
		<div class="row text-center" data-id="{%= core%}">
			<div class="col-xs-2">{%= core%}</div>
			<div class="col-xs-2"><a id="node{%= core%}" class="node">{%= flowname%}</a></div>
			<div class="col-xs-2" data-status="{%if statelabel=='{*[front.finished]*}'%}1{%else statelabel=='{*[front.unfinished]*}'%}0{%/if%}" id="statelabel">{%= statelabel%}</div>
			<div class="col-xs-2">{%= number%}</div>
			<div class="col-xs-2">{%= consuming%}</div>
			<div class="col-xs-2">{%= consumingday%}</div>
		</div>
</script>

<script id="tmplNodeTableListItem" type="text/x-jquery-tmpl">
		<div class="row text-center" data-id="{%= core%}">
			<div class="col-xs-1">{%= core%}</div>
			<div class="col-xs-2" id="flowname">{%= flowname%}</div>
			<div class="col-xs-2" data-status="{%if statelabel=='{*[front.finished]*}'%}1{%else statelabel=='{*[front.unfinished]*}'%}0{%/if%}" id="statelabel">{%= statelabel%}</div>
			<div class="col-xs-2"><a id="names{%= core%}" class="names">{%= nodename%}</a></div>
			<div class="col-xs-1">{%= nodenumber%}</div>
			<div class="col-xs-2">{%= nodeconsuming%}</div>
			<div class="col-xs-2">{%= nodeconsumingday%}</div>
		</div>
</script>

<script id="tmplNamesTableListItem" type="text/x-jquery-tmpl">
		<div class="row text-center" data-id="{%= core%}">
			<div class="col-xs-1">{%= core%}</div>
			<div class="col-xs-2" id="nodename">{%= nodename%}</div>
			<div class="col-xs-2"><a id="detailed{%= core%}" class="detailed">{%= initiator%}</a></div>
			<div class="col-xs-1">{%= nodenumber%}</div>
			<div class="col-xs-2" data-status="{%if statelabel=='{*[front.finished]*}'%}1{%else statelabel=='{*[front.unfinished]*}'%}0{%/if%}" id="statelabel">{%= statelabel%}</div>
			<div class="col-xs-2">{%= nodeconsuming%}</div>
			<div class="col-xs-2">{%= nodeconsumingday%}</div>
		</div>
</script>

<script id="tmplDetailedTableListItem" type="text/x-jquery-tmpl">
		<div class="row text-center" data-id="{%= core%}">
			<div class="col-xs-1">{%= flowname%}</div>
			<div class="col-xs-1">{%= statelabel%}</div>
			<div class="col-xs-1">{%= nodename%}</div>
			<div class="col-xs-1">{%= initiator%}</div>
			<div class="col-xs-2">{%= starttime%}</div>
			<div class="col-xs-2">{%= endtime%}</div>
			<div class="col-xs-2">{%= nodeconsuming%}</div>
			<div class="col-xs-2">{%= nodeconsumingday%}</div>
		</div>
</script>
</head>
<body style="overflow: hidden;">
	<input type="hidden" value=<%=applicationid%> id="applicationid"/>
	<input type="hidden" value=<%=showMode%> id="showMode"/>
	<input type="hidden" value=<%=dateRange%> id="dateRange"/>
	<input type="hidden" value=<%=startdate%> id="startdate"/>
	<input type="hidden" value=<%=enddate%> id="enddate"/>
	<input type="hidden" value=<%=select%> id="stateselect"/>
    <div class="dashboard" id="efficiency">
        <div class="row text-center efficiency">
            <div class="col-xs-6" id="histogram" style="height:200px;width:45%"></div>
            <div class="col-xs-6" id="bar" style="height:200px;width:45%"></div>
        </div>
        <div class="container-fluid" id="efficiency-list">
            <div class="row text-center row-title">
                <div class="col-xs-2"><strong>{*[RowNum]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.workflow.name]*}</strong></div>
                <div class="col-xs-2"><strong>{*[flow.state]*}</strong></div>
                <div class="col-xs-2"><strong>{*[number.of.instances]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Hours]*})</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Days]*})</strong></div>
            </div>
        </div>
    </div>
    <div class="dashboard" id="node">
        <div class="row text-center efficiency">
            <div class="col-xs-6" id="nodehistogram" style="height:200px;width:45%"></div>
            <div class="col-xs-6" id="nodebar" style="height:200px;width:45%"></div>
        </div>
        <div class="container-fluid" id="node-list">
            <div class="row text-center row-title">
                <div class="col-xs-1"><strong>{*[RowNum]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.workflow.name]*}</strong></div>
                <div class="col-xs-2"><strong>{*[flow.state]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.node.name]*}</strong></div>
                <div class="col-xs-1"><strong>{*[front.node.number]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Hours]*})</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Days]*})</strong></div>
            </div>
        </div>
    </div>
    <div class="dashboard" id="names">
        <div class="row text-center efficiency">
            <div class="col-xs-6" id="nameshistogram" style="height:200px;width:45%"></div>
            <div class="col-xs-6" id="namesbar" style="height:200px;width:45%"></div>
        </div>
        <div class="container-fluid" id="names-list">
            <div class="row text-center row-title">
                <div class="col-xs-1"><strong>{*[RowNum]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.node.name]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.personal.name]*}</strong></div>
                <div class="col-xs-1"><strong>{*[front.node.number]*}</strong></div>
                <div class="col-xs-2"><strong>{*[flow.state]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Hours]*})</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Days]*})</strong></div>
            </div>
        </div>
    </div>
    <div class="dashboard" id="detailed">
        <div class="container-fluid" id="detailed-list">
            <div class="row text-center row-title">
                <div class="col-xs-1"><strong>{*[front.workflow.name]*}</strong></div>
                <div class="col-xs-1"><strong>{*[front.instances.state]*}</strong></div>
                <div class="col-xs-1"><strong>{*[front.node.name]*}</strong></div>
                <div class="col-xs-1"><strong>{*[front.auditor]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.node.start_date]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.node.end_date]*}</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Hours]*})</strong></div>
                <div class="col-xs-2"><strong>{*[front.average.time]*}({*[Days]*})</strong></div>
            </div>
        </div>
    </div>
</body>
</html>
</o:MultiLanguage>