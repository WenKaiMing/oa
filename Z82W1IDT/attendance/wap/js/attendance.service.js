AM.Service = {
		/**
		 * 获取选中的月份的考勤记录
		 * @params {}
		 */
		getRecord4CalView : function(params,callback){
			$.ajax({
	    		url: contextPath + "/attendance/attendance/getRecord4CalView.action",
	    		async: false,
	    		cache:false,
	    		data:params,
	    		success: function(result){
	    			if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						//Utils.showMessage(result.message, "error");
					}
	    		}
			})
		},
		/**
		 * 获取选中的日的考勤记录
		 * @params {}
		 */
		getAttendanceDetailByDate : function(params,callback){
			$.ajax({
	    		url: contextPath + "/attendance/attendance/getAttendanceDetailByDate.action",
	    		async: false,
	    		cache:false,
	    		data:params,
	    		success: function(result){
	    			if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						//Utils.showMessage(result.message, "error");
					}
	    		}
			})
		}
}