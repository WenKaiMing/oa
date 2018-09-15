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

//昨天
var getYesterdayDate = new Date(nowYear, nowMonth, nowDay - 1);
var getYesterdayDate =  formatDate(getYesterdayDate);

//获得本周的开始日期
var getWeekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek);
var getWeekStartDate =  formatDate(getWeekStartDate);
//获得本周的结束日期
var getWeekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek));
var getWeekEndDate =  formatDate(getWeekEndDate);


//获得上周的开始日期
var getUpWeekStartDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek -7);
var getUpWeekStartDate =  formatDate(getUpWeekStartDate);

//获得上周的结束日期
var getUpWeekEndDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek - 7));
var getUpWeekEndDate =  formatDate(getUpWeekEndDate);

//获得本月的开始日期
var getMonthStartDate = new Date(nowYear, nowMonth, 1);
var getMonthStartDate =  formatDate(getMonthStartDate);

//获得本月的结束日期
var getMonthEndDate = new Date(nowYear, nowMonth, getMonthDays(nowMonth));
var getMonthEndDate =  formatDate(getMonthEndDate);

//获得上月开始时间
var getLastMonthStartDate = new Date(nowYear, lastMonth, 1);
var getLastMonthStartDate = formatDate(getLastMonthStartDate);

//获得上月结束时间
var getLastMonthEndDate = new Date(nowYear, lastMonth, getMonthDays(lastMonth));
var getLastMonthEndDate = formatDate(getLastMonthEndDate);

//获取本年的开始时间
var getYearStartDate = new Date(nowYear, 0, 1);
var getYearStartDate = formatDate(getYearStartDate);

//获得本年结束时间
var getYearEndDate = new Date(nowYear, 11, getMonthDays(11));
var getYearEndDate = formatDate(getYearEndDate);

//获取上年的开始时间
var getUpYearStartDate = new Date((nowYear-1), 0, 1);
var getUpYearStartDate = formatDate(getUpYearStartDate);

//获得上年结束时间
var getUpYearEndDate = new Date((nowYear-1), 11, getMonthDays(11));
var getUpYearEndDate = formatDate(getUpYearEndDate);

function dateRange(obj){
	$(obj).change(function(){
		var _val = $(this).find("option:selected").attr("_val");
		var $startTime = $(this).parents(".erpSearch").find(".start-time");
		var $endTime = $(this).parents(".erpSearch").find(".end-time");
		switch(_val){
			case "100":	//自定义
				$('.form_datetime').datetimepicker('setStartDate', '2000-01-01');
				$('.form_datetime').datetimepicker('setEndDate', '2080-01-01');
				$startTime.val("");
				$endTime.val("");
			  break;
			case "1":	//本年
				$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getYearEndDate);
				$startTime.val(getYearStartDate);
				$endTime.val(getYearEndDate);
			  break;
			case "2":	//本月
				$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getMonthEndDate);
				$startTime.val(getMonthStartDate);
				$endTime.val(getMonthEndDate);
				 break;
			case "3":	//今周
				$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getWeekEndDate);
				$startTime.val(getWeekStartDate);
				$endTime.val(getWeekEndDate);
				break;
			case "4":	//今天
				$('.form_datetime').datetimepicker('setStartDate', getCurrentDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getCurrentDate);
				$endTime.val(getCurrentDate);
				break;
			case "5":	//昨天
				$('.form_datetime').datetimepicker('setStartDate', getYesterdayDate);
				$('.form_datetime').datetimepicker('setEndDate', getYesterdayDate);
				$startTime.val(getYesterdayDate);
				$endTime.val(getYesterdayDate);
				break;
			case "6":	//上周
				$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getUpWeekEndDate);
				$startTime.val(getUpWeekStartDate);
				$endTime.val(getUpWeekEndDate);
				break;
			case "7":	//上月
				$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getLastMonthEndDate);
				$startTime.val(getLastMonthStartDate);
				$endTime.val(getLastMonthEndDate);
				break;
			case "8":	//上年
				$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getUpYearEndDate);
				$startTime.val(getUpYearStartDate);
				$endTime.val(getUpYearEndDate);
				break;
			case "9":	//上周至今天
				$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getUpWeekStartDate);
				$endTime.val(getCurrentDate);
				break;
			case "10":	//上月至今天
				$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getLastMonthStartDate);
				$endTime.val(getCurrentDate);
				break;
			case "11":	//上年至今
				$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getUpYearStartDate);
				$endTime.val(getCurrentDate);
				break;
			case "12":	//本年至今
				$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getYearStartDate);
				$endTime.val(getCurrentDate);
				break;
			case "13":	//本月至今
				$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getMonthStartDate);
				$endTime.val(getCurrentDate);
				break;
			case "14":	//今周至今
				$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
				$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
				$startTime.val(getWeekStartDate);
				$endTime.val(getCurrentDate);
				break;
			default:
				break;
		}
	});
}
