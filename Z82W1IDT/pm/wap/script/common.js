function go(id){
	backUrl = location.hash;
    var $tpl = $($('#tpl_' + id).html()).addClass('slideIn').addClass(id);
    $container.append($tpl);
    stack.push($tpl);
    location.hash = '#' + id;

    $($tpl).on('webkitAnimationEnd', function (){
        $(this).removeClass('slideIn');
    }).on('animationend', function (){
        $(this).removeClass('slideIn');
    });
    // tooltips
    if (id == 'cell') {
        $('.js_tooltips').show();
        setTimeout(function (){
            $('.js_tooltips').hide();
        }, 3000);
    }
}

function clickRemoveSelect(obj) {
	$(obj).remove();
	$("#addExecutor").show();
}


/**
 * 获取录音计时器
 */
function _getTimer(){
	var timer = parseInt($(".time-total").text());
	if(timer==0){
		timer = setInterval(function(){
					var tl = $(".time-total");
					tl.text(parseInt(tl.text())+1);
					if(parseInt(tl.text()) == 60){
						clearInterval(timer);
					}
			},1000);
	}
	return timer;
} 

function mobiScrollInit(){
	$(".task-date").find(".weui_input").mobiscroll().datetime({
		dateFormat : 'yyyy-mm-dd',
		timeFormat : '',
		theme : 'ios',
		mode : 'mixed', 
		minDate: mobiscrollMin?mobiscrollMin:null,
		onBeforeShow : function (inst) { 
			location.hash = "#/popUpLayer";
			inst.settings.wheels[0].length=3;
			inst.settings.wheels[1].length=0;
        },
		display : 'bottom', 
		lang : 'zh', 
		stepMinute : 5,
		onClose : function(){
         	if(window.location.hash == "#/popUpLayer"){
         		history.go(-1);
         	}
         }
	});
}

function filterList(header, list) {
	$(".search").keydown(function(e) {
		if(e.keyCode==13){
			$(".task-tab-list-box").find(".nullbox").css("display","none");
			var filter = $(this).val();
			if (filter) {
				$matches = $(list).find('.task-my-con:Contains(' + filter + ')').parents('li');
				if($matches.size() == 0){
					$(".task-tab-list-box").find(".nullbox").css("display","block");
				}else{
					$(".task-tab-list-box").find(".nullbox").css("display","none");
				}
				$('li', list).not($matches).slideUp();
				$matches.slideDown();
				
			} else {
				$(list).find("li").slideDown();
			}
			return false;
		}
	})
}

function loadShow(){
	setTimeout(function(){
		$(".page-load-mark").fadeIn();
	},500)
}

function loadHide(){
	setTimeout(function(){
		$(".page-load-mark").fadeOut();
	},500)
}

function isWeiXin(){ 
  var ua = window.navigator.userAgent.toLowerCase(); 
  if(ua.match(/MicroMessenger/i) == 'micromessenger'){ 
    return true; 
  }else{ 
    return false; 
  } 
} 

function daysBetween(DateOne,DateTwo)  
{   
	if( DateTwo == null){
	    return false;
	}else{
		var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));  
	    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);  
	    var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));  
	  
	    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));  
	    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);  
	    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));  
	  
	    var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
	    return Math.abs(cha);
	}
}  
/**
 * 计算时间差
 * @param date,date2
 */
function daysCalc(date,date2){
	var startDateArr = date.split(/[- :]/); 
	var startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2], startDateArr[3], startDateArr[4]);
	if(!date2 || date2 == ""){
		var nowDate = new Date();
	}else{
		var nowDate = new Date(date2);
	}
	var msDate = nowDate.getTime() - startDate.getTime();
	//计算出相差天数
	var days=Math.floor(msDate/(24*3600*1000));
	//计算出小时数
	var leave1 = msDate%(24*3600*1000);//计算天数后剩余的毫秒数
	var hours = Math.floor(leave1/(3600*1000));
	//计算相差分钟数
	var leave2 = leave1%(3600*1000);//计算小时数后剩余的毫秒数
	var minutes = Math.floor(leave2/(60*1000));
	//计算相差秒数
	var leave3=leave2%(60*1000);//计算分钟数后剩余的毫秒数
	var seconds=Math.round(leave3/1000);
	//alert(" 相差 "+days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒");	
	var timeCalc = {
		    "days": days,
		    "hours": hours,
		    "minutes": minutes,
		    "seconds": seconds
		};
	return timeCalc;
}

/**
 * 隐藏所有弹出层
 */
function hidePopUpLayer(){
	var hash = window.location.hash;
	if(hash){
		if(hash.indexOf("#/tpl_task-create") != -1 || hash.indexOf("#/tpl_task-edit") != -1){
			$("body > .mbsc-ios .dwo").trigger("click");	//移除日期控件选择界面
			if($("body > .dialog").size()>0){
				OBPM.dialog.doExit();		//移除执行人用户选择框弹出层
			}
			$("body #record_id").hide();	//移除录音弹出层
			clearInterval(_getTimer);
			wx.stopRecord({});				//停止录音
			$("body #record_id").find(".time-total").text(0);		//移除录音的计算器的时间值
			$('#actionsheet_cancel').trigger("click");	//移除文件上传弹出层
		}
	}
}