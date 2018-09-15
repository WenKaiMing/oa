/**
 * Utils 核心类
 */
var Utils = {
		/**
	     * 打开预定面板
	     */
		openReservationPanel: function(){
			var con_wid = $("#mr-reservation-container").width();
			$("#mr-reservation-box").css({ height:document.documentElement.clientHeight-45-45}); 	
	        $("#mr-reservation-box").css({
	            display: "block"
	        }).show();

//			if(parseInt(document.body.offsetWidth) > parseInt(window.screen.availWidth))
//				wid = wid+17;
			$("#mr-reservation-div").width(con_wid-334);
			$("#mr-reservation-div").height(
					document.documentElement.clientHeight-45-53-25
		    );
			$("#mr-reservation-box").width(300);
			$("#mr-reservation-container").width(con_wid);
	    },
	    /**
		 *关闭预定面板
		 */
	    closeReservationPanel : function(){
	    	
	    	$("#mr-reservation-box").width(0);
	        $("#mr-reservation-box").css({
	            display: "none"
	        });
	    	
	    	$("#mr-reservation-container").width("100%");
	    	$("#mr-reservation-div").css("width","100%");
	    },
	    
	    //会议室管理
	    openManagementPanel : function(){
	    	var con_wid = $("#mr-management-container").width();
	    	$("#mr-management-box").css({ height:document.documentElement.clientHeight-45-45});
	        $("#mr-management-box").css({
	            display: "block"
	        }).show();
	        
			$("#mr-management-div").width(con_wid-334);
			$("#mr-management-div").height(
				document.documentElement.clientHeight-45-53-25
			);
			$("#mr-management-box").width(300);
			$("#mr-management-container").width(con_wid);
	    },
	    
	    closeManagementPanel :function(){
	    	$("#mr-management-box").width(0);
	        $("#mr-management-box").css({
	            display: "none"
	        });
	    	
	    	$("#mr-management-container").width("100%");
	    	$("#mr-management-div").css("width","100%");
	    },
	    
	    openMyReservationPanel: function(){
	    	var con_wid = $("#mr-myreservation-container").width();
	    	$("#mr-myreservation-box").css({ height:document.documentElement.clientHeight-45-45});
	        $("#mr-myreservation-box").css({
	            display: "block"
	        }).show();
			
//			var wid = $("#mr-myreservation-container").width()-301;
//			$("#mr-myreservation-div").animate({
//	            width: wid
//	        });
			$("#mr-myreservation-div").width(con_wid-334);
			$("#mr-myreservation-div").height(
				document.documentElement.clientHeight-45-53-25
			);
			$("#mr-myreservation-box").width(300);
			$("#mr-myreservation-container").width(con_wid);
	    },
	    closeMyReservationPanel: function(){
	       
			$("#mr-myreservation-box").width(0);
	        $("#mr-myreservation-box").css({
	            display: "none"
	        });
	    	
	    	$("#mr-myreservation-container").width("100%");
	    	$("#mr-myreservation-div").css("width","100%");
	    },
	    nextPage: function(){
	    	if(MR.cache.pages>=MR.cache.countpages)
	    		return;
	    	MR.cache.pages=MR.cache.pages+1;
	    	MR.myreservation();
	    },
	    lastPage: function(){
	    	if(MR.cache.pages<=1)
	    		return;
	    	MR.cache.pages=MR.cache.pages-1;
	    	MR.myreservation();
	    },
	    goPage: function(){
	    	var num =null;
	    	num = $('#gopages')[0].value;
	    	if(isNaN(num)||num<1||num>MR.cache.countpages)
	    		return;
	    	MR.cache.pages = parseInt(num);
	    	MR.myreservation();
	    },
	    
	    CurentTime: function(){ 
	        var now = new Date();
	       
	        var year = now.getFullYear();       //年
	        var month = now.getMonth() + 1;     //月
	        var day = now.getDate();            //日
	       
	        var hh = now.getHours();            //时
	        var mm = now.getMinutes();          //分
	        var clock = year + "-";
	        if(month < 10)
	            clock += "0";
	        clock += month + "-";
	        if(day < 10)
	            clock += "0";
	        clock += day + " ";
//	        if(hh < 10)
//	            clock += "0";
//	           
//	        clock += hh + ":";
//	        if (mm < 10) clock += '0'; 
//	        clock += mm; 
	        return(clock); 
	    } ,
	    
	    daysBetween: function(DateOne,DateTwo)  
	    {   
	        var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));  
	        var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);  
	        var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));  
	      
	        var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));  
	        var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);  
	        var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));  
	      
	        var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
	        return cha;  
	    },
	    dateFormat_end: function(date){
	    	var d = date.split(":");
	    	if(parseInt(d[1])<=30&&parseInt(d[1])>0)
	    		d[1] = "30";
	    	else if(parseInt(d[1])>30){//"2015-05-11 09"
	    		var dd = d[0].split(" ");
	    		d[1] = "00";
	    		dd[1] = parseInt(dd[1])+1;
	    		d[0] = dd[0]+" "+dd[1];
	    	}
	    	return d[0]+":"+d[1];
	    },
	    dateFormat_start: function(date){
	    	var d = date.split(":");
	    	if(parseInt(d[1])<30)
	    		d[1] = "00";
	    	else{
	    		d[1] = "30";
	    	}
	    	return d[0]+":"+d[1];
	    },
	    getToday:function(){
	    	var today = new Date();   
	    	var day = today.getDate();   
      	   	var month = today.getMonth() + 1;   
      	   	var year = today.getFullYear();    
      	   	var date = year + "-" + month + "-" + day;   
      	   	return date;
	    }
};

