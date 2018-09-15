/**
 * AM 核心类
 * 封装KM界面渲染与交互行为
 */
;
var AM = AM || {};

AM.Config = {
		currDate : new Date().getDate(),
		type : {
			 normal : 1,	//出勤
			 absent : 2,	//缺勤
			 unnormal : 3	//异常
		},
		status : {
			/**正常上班**/
			STATUS_SIGNIN_NORMAL : 1,
			/**迟到**/
			STATUS_LATE : 2,
			/**早退**/
			STATUS_LEAVE_EARLY : 4,
			/**正常下班**/
			STATUS_SIGNOUT_NORMAL : 8,
			/**缺勤(未打卡)**/
			STATUS_ABSENT : 16,
			/**地点异常**/
			STATUS_WRONG_LOCATION : 32
		}
};

AM.Core = {
    init : function(nowDate){
		AM.Core.renderCalendar(nowDate);
	},
	//获取选中的月份的考勤记录data
	getRecord4CalView : function(params){
		var record4CalViewData = [];
		AM.Service.getRecord4CalView(params,function(data){
			record4CalViewData = data;
		})
		return record4CalViewData;
	},
	//初始化工作日历
	renderCalendar : function (selectDate){
		var calendarWd = $("#container").width()-30;
		var params = {selectTime:new Date(selectDate).format("yyyy/mm")};
		var data = JSON.parse(AM.Core.getRecord4CalView(params));
		$('#attendance__calendar').calendar({
			width: calendarWd,
			height: 300,
			startWeek: 0,
			date: new Date(selectDate),
			selectedRang: [null,new Date()],
			label: false,
			data:data,
			viewChange: function(view,y,m,obj){
                var _selectTime = y+"/"+m;
                var params = {selectTime:_selectTime};
                var data = JSON.parse(AM.Core.getRecord4CalView(params));
            	var $day = obj.$element.find(".date-items>li:eq(1) .days");
            	$day.find("li").each(function(){
            		var $this = $(this);
            		if($this.find("span").hasClass("old") || $this.find("span").hasClass("new")){
            			if($this.find(".dot").size()>0){
            				$this.find(".dot").remove();
            			}
            		}else{
            			var text = $this.text();
            			for(var i = 0;i < data.length; i++){
            				var _date = new Date(data[i].date);
            				var _value = data[i].value;
            				var _m = _date.getMonth()+1;
            				var _d = _date.getDate();
            				var __class = "";
            				if(_d == text && _m == m){
            					if($this.find(".dot").size()<=0){
            						$this.append('<i class="dot"></i>');
            						switch(_value){
                					case AM.Config.type.normal:
                						_class = "chu";
                						break;
                					case AM.Config.type.absent:
                						_class = "que";
                						break;
                					case AM.Config.type.unnormal:
                						_class = "yi";
                						break;
                					}
                					$this.find(".dot").addClass(_class);
            					}
            				}
            			}
            		}
            	}) ;
            	AM.Core.getCalendarStatistics(data);
            },
			onSelected: function (view, date, data){
				var dateParams =  {selectTime:AM.Util.getNowFormatDate(date)};
				$(this).siblings().find("span").removeClass("active");
				$(this).find("span").addClass("active");
				AM.Service.getAttendanceDetailByDate(dateParams,function(data){
					var typeCol = "status-1";
					var arrayData = JSON.parse(data);
						if(arrayData.length>0){
							$.each(arrayData,function(i,val){
								if(val.status != "1" || val.status != "4"){
									typeCol = "status-3";
								}else if(val.status == "16"){
									typeCol = "status-2";
								}
								var statusType = ""; 
								switch (parseInt(val.status)){
								case AM.Config.status.STATUS_SIGNIN_NORMAL :
									statusType = "正常上班";
									break;
								case AM.Config.status.STATUS_LATE :
									statusType = "迟到";
									break;
								case AM.Config.status.STATUS_LEAVE_EARLY :
									statusType = "早退";
									break;
								case AM.Config.status.STATUS_SIGNOUT_NORMAL :
									statusType = "正常下班";
									break;
								case AM.Config.status.STATUS_ABSENT :
									statusType = "缺勤";
									break;
								case AM.Config.status.STATUS_WRONG_LOCATION :
									statusType = "异常";
									break;
								default : 
									break; 
								}
								val.statusType = statusType;
								val.typeCol = typeCol;
							});
							var obj = {};
							obj.list = [];
							obj.list = arrayData;
							var html = template('AmList', obj);
							$("#AM-detail").html(html);
							var date1 = $(".weui-cell:first-child").find(".workTime").text();
							var date2 = $(".weui-cell:last-child").find(".workTime").text();
							var workDuration = $("#WorkDuration").html();
							$("#other").html(workDuration);
							var time = "";
							if(date1 != "" && date2!=""){
								time = AM.Core.setWorkDuration(date1,date2);
							}
							$("#other").find(".longtime").text(time);
						}else{
							var noRecord = $("#noRecord").html();
							$("#other").html(noRecord);
							$("#AM-detail").html("");
						}
				})
			}
		});
		AM.Core.getCalendarStatistics(data);
	},
	//统计出勤数、出勤数、异常数
	getCalendarStatistics : function (data){
		var normalNum = 0;	//出勤数
		var absentNum = 0;  //出勤数
	    var unnormalNum = 0;	//异常数
		$.each(data,function(i,obj){
		    var type = obj.value ;
		    if(type == AM.Config.type.normal){
		    	normalNum += 1
		    }else if(type == AM.Config.type.absent){
		    	absentNum += 1
		    }else if(type == AM.Config.type.unnormal){
		    	unnormalNum += 1
		    }
		});
		$(".chuqin").find(".num").text(normalNum);
		$(".queqin").find(".num").text(absentNum);
		$(".yichang").find(".num").text(unnormalNum);
		if(data.length>0){
			$(".days").eq(1).find("span[_value="+AM.Config.currDate+"]").parent("li").trigger("click");
		}else{
			var noRecord = $("#noRecord").html();
			$("#other").html(noRecord);
			$("#AM-detail").html("");
		}
	},
	//计算工作时长
	setWorkDuration : function (date1,date2){
		var daysCalc = AM.Util.daysCalc(date1,date2);
		var time = "";
		if(daysCalc.hours != 0){
			time += daysCalc.hours+"小时";
		}
		if(daysCalc.minutes != 0){
			time += daysCalc.minutes+"分钟";
		}
		if(daysCalc.seconds != 0){
			time += daysCalc.seconds+"秒";
		}
	}
}