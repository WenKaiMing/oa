<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="resource/css/myapp.css" />
<link rel="stylesheet" href="resource/css/dashboard.css" />
<script src="resource/js/jquery-1.11.3.min.js"></script> 
<script src="resource/script/bootstrap.min.js"></script> 


<link rel="stylesheet" href="../share/script/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="resource/component/dateField/datetimepicker/moment-with-locales.js"></script>  
<script src="../share/script/bootstrap/script/bootstrap-datetimepicker.min.js"></script> 
<script src="../share/script/bootstrap/script/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">

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
		$('.form_date').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
		
		var startDate = "";
		var endDate = "";
		var dateRange = $("button[name='searchDate'].active").val()
		switch(dateRange){
			case "today":
				startDate = getCurrentDate;
				endDate = getCurrentDate;
				break;
			case "thisweek":
				startDate = getWeekStartDate;
				endDate = getWeekEndDate;
				break
			case "thismonth":
				startDate = getMonthStartDate;
				endDate = getMonthEndDate;
				break
			case "thisyear":
				startDate = getYearStartDate;
				endDate = getYearEndDate;
				break
		}
		
		$("#startdate").val(startDate);
		$("#enddate").val(endDate);
		
		var frameHeight = parent.document.body.clientHeight - $("#searchDiv").height() - 30;
		var frameWidth = parent.document.body.clientWidth - 145;
		
		$("#searchDiv").find("input:checkbox,button").click(function(){
			search();
		});
		$("#searchDiv").find("input:text,select").change(function(){
			search();
		});
		
		function search(){
			var isButton=$(this).attr("type");
			if(isButton == "button"){
				$(this).addClass("active");
				$(this).siblings().removeClass("active");
			}
			var dateRange = "";//$("button[name='searchDate'].active").val();
			var showMode = $("input[name='showMode']").filter(":checked").size()>0?"all":"mine";
			var $app = $("select[name='searchApp']");
			var searchAppId = $app.val();
			var startdate = $("#startdate").val();
			var enddate = $("#enddate").val();
			var status = $("#stateselect").val();
			var url='../share/workflow/analyzer/borderFrame.jsp?application='+ searchAppId+'&dateRange='+dateRange+'&showMode='+showMode+"&startdate="+startdate+"&enddate="+enddate+"&select="+status;
			$("#showFrame").attr("src",url);
		}
		
		$("#showFrame").height(frameHeight);
		//.width(frameWidth);
		search();
			
	});
</script>
</head>
<body style="overflow: hidden;">
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="applicationHelper" />
<div id="right" style="background:none">
    <div class="con_right">
        <div class="searchDiv" id="searchDiv">
        	<input type="hidden" name="searchDate" value="today"/>
            <div class="btn-group" role="group" style="display:none;">
                <button type="button" class="btn btn-green" value="today" name="searchDate">{*[Today]*}</button>
                <button type="button" class="btn btn-green" value="thisweek" name="searchDate">{*[instrument.week]*}</button>
                <button type="button" class="btn btn-green active" value="thismonth" name="searchDate">{*[instrument.month]*}</button>
                <button type="button" class="btn btn-green" value="thisyear" name="searchDate">{*[instrument.year]*}</button>
            </div>
						
			<div class="form-group" id="item">
				<div class="time fl">
					<label class="fl">{*[Application]*}</label>
					<s:select cssClass="btn btn-default btn-lg fl" name="searchApp" 
							list="%{#applicationHelper.getListByWebUser(#session.FRONT_USER)}"
							listKey="id" listValue="name" placeholder="{*[please.choose.application]*}" />
				</div>
            <div class="time fl">
                <label class="fl">{*[front.start_date]*}</label>
                <div class="input-group date form_date fl" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input id="startdate" class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> </div>
                <input type="hidden" id="dtp_input2" value="" />
                <div class=" clearfix"></div>
            </div>
            <div class="time fl">
                <label class="fl">{*[front.end_date]*}</label>
                <div class="input-group date form_date fl" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input id="enddate" class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span> </div>
                <input type="hidden" id="dtp_input2" value="" />
                <div class=" clearfix"></div>
            </div>
            
             <%
			WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
			if(user.getDomainUser()!=null && user.getDomainUser().equals(WebUser.IS_DOMAIN_USER)){
				%>
				<div class="time fl">
			    <label>
			      <input type="checkbox" style="margin-left:10px" name="showMode" value="all">{*[show.all]*}
			    </label>
			    </div>
			<% 
			}
			/* out.println("<label class='radio-inline' style='margin-left:20px'>"
			+"<input type='checkbox' name='showMode' value='all'/>"
			+ "</label>"); */
			%>
            
            <div class="btn-group fr" role="group" aria-label="...">
                <select class="btn btn-default btn-lg active " name="stateselect" id="stateselect">
                    <option value="1">{*[front.finished]*}</option>
                    <option value="0">{*[front.unfinished]*}</option>
                </select>
                <button id="search" type="button" class="btn btn-info btn-lg active">{*[Query]*}</button>
            </div>
            <div class=" clearfix"></div>
        </div>
        </div>
        <div class="dashboard">
			<iframe id='showFrame' frameborder="no" scrolling="no" width="100%" height="100%" style="margin-top: 15px;margin-right: 50px;"/>
        </div>
    </div>
    <div class="clearfix"></div>
</div>
</body>
</html>
</o:MultiLanguage>