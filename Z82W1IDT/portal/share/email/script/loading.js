function showLoading(){
	lockScreen();
	appendDivHtml();
	setPosition();
	jQuery("#divWindow").fadeIn("slow");
}

function hideLoading() {
	clearDivWindow();
	clearLockScreen();
}

//var loading = '<ww:url value='/portal/share/email/images/loading2.gif'/>';

// 返回弹出的DIV的坐标
function appendDivHtml(){
	if(jQuery("#divWindow").length == 0){
		//jQuery("body").append("<div id='divWindow'><img src='" + loading + "' /></div>");	// 增加DIV
		//jQuery("body").append("<div id='divWindow'><img src='/portal/share/email/images/loading2.gif' /></div>");	// 增加DIV
		jQuery("body").append("<div id='divWindow'><img src='images/loading2.gif' /></div>");
		jQuery("#divWindow").hide();
		// divWindow的样式
		jQuery("#divWindow").css("position","absolute");
		jQuery("#divWindow").css("overflow","hidden");
		//jQuery("#divWindow").css("z-index","200");
		jQuery("#divWindow").css("width","32px");
		jQuery("#divWindow").css("height","32px");
		//jQuery("#divWindow").css("opacity","0.9");
		jQuery("#divWindow").css("background-color","#FFFFFF");
	}
}

function setPosition() {
	var clientH = jQuery(window).height();	// 浏览器高度
	var clientW = jQuery(window).width();	// 浏览器宽度
	var divW = jQuery("#divWindow").width();
	var divH = jQuery("#divWindow").height();
	
	var div_X = (clientW - divW) / 2;	// DIV横坐标
	var div_Y = (clientH - divH) / 2;	// DIV纵坐标
	jQuery("#divWindow").css("left",(div_X + "px"));	// 定位DIV的横坐标
	jQuery("#divWindow").css("top",(div_Y + "px"));	// 定位DIV的纵坐标
}

// 清除DIV窗口
function clearDivWindow(){
	jQuery("#divWindow").fadeOut("fast", function(){//slow
		jQuery("#divWindow").remove();
	});
}

// 窗口大小改变时
jQuery(window).resize(
	function(){
		if(jQuery("#divWindow").length != 0){
			setPosition();
			lockScreen();
		}
	}
);
//锁定背景屏幕
function lockScreen() {
	var clientH = jQuery(window).height();	// 浏览器高度
	var clientW = jQuery(window).width();	// 浏览器宽度
	if($("#divLock").length == 0){	// 判断DIV是否存在 202 242 249 caf2f9
		$("body").append("<div id='divLock' style='display: block; background-color: #000000; position: fixed; z-index: 100;'></div>");	// 增加DIV
		$("#divLock").height(clientH);
		$("#divLock").width(clientW);
		$("#divLock").css("top","0px");
		$("#divLock").css("left","0px");
		$("#divLock").css("opacity","0.2");
		$("#divLock").hide();
		$("#divLock").fadeIn("slow");
	} else {
		$("#divLock").height(clientH);
		$("#divLock").width(clientW);
	}
}

// 清除背景锁定
function clearLockScreen(){
	$("#divLock").fadeOut("fast", function(){//slow
		$("#divLock").remove();
	});
}
jQuery(window).scroll( function() { 
	if(jQuery("#divWindow").length != 0){
		setPosition();
	}
}); 