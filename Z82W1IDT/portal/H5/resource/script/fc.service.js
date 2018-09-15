FC.Service = {
		/**
		 * 获取所有软件以及软件下的流程分组
		 * **/
		getAllPendingFlowList : function(opts){
			$.ajax({
	    		url: contextPath + FC.Config[FC.Config.actionType].url.allFlowList,
	    		async: false,
	    		cache:false,
	    		success: function(result){
	    			if(1==result.status){
						if(opts.success && typeof opts.success == "function"){
							opts.success(result.data);
						}
					}else{
						if(opts.error && typeof opts.error == "function"){
							opts.error();
						}
					}
	    		}
			})
		},
		handle : {
			/**
			 * 获取指定分组代办流程下数据
			 * **/
			getHandleList : function(params,callback){
				$.ajax({
		    		url: contextPath + FC.Config[FC.Config.actionType].url.list,
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
                            FC.Util.dy_unlock();
						}
		    		}
				})
			}
		}
}