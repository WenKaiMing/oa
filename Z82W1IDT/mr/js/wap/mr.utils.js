/**
 * Utils 核心类
 */
var Utils = {
	    
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

