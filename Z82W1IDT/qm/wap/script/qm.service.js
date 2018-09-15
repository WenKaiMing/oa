QM.service = {
	/**
	 * 获取待填列表
	 * @params {}
	 */
	getPendList : function(params,callback){
		$.ajax({
    		url: contextPath + "/qm/questionnaireservice/list.action",
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
	 * 获取问卷中心列表
	 * @params {"type":""}
	 */
	getCenterList : function(params,callback){
		$.ajax({
    		url: contextPath + "/qm/questionnaireservice/center.action",
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
	 * 获取问卷数据
	 * @params {"listId":""}
	 */
	getWrite : function(params,callback){
		$.ajax({
    		url: contextPath + "/qm/questionnaireservice/edit.action?id="+params.listId,
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
	 * 获取问卷答案
	 * @params {"listId":""}
	 */
	getAnswer : function(params,callback){
		$.ajax({
			url: contextPath + "/qm/answerservice/view.action",
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
	 * 获取问卷统计数据
	 * @params {"id":""}
	 */
	getShowResult : function(params,callback){
		$.ajax({
			url: contextPath + "/qm/questionnaireservice/reportform.action",
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
	 * 获取投票题数据
	 * @params {"id":"","holder_id" :""}
	 */
	getVoteNumber : function(params,callback){
		$.ajax({
    		url : contextPath + "/qm/questionnaireservice/voteNumber.action",
    		async: false,
    		cache:false,
    		data:params,
    		success : function(result) {
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					//Utils.showMessage(result.message, "error");
				}
    		}
    	});
	},
	/**
	 * 获取填空题数据
	 * @params {}
	 */
	getInputValue : function(params,callback){
		$.ajax({
    		url : contextPath + "/qm/answerservice/inputreportform.action",
    		async: false,
    		cache:false,
    		data:params,
    		success : function(result) {
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					//Utils.showMessage(result.message, "error");
				}
    		}
    	});
	},
	/**
	 * 提交问卷
	 * @params {"questionnaire_id":"","content" : "","answer" : ""}
	 */
	saveAnswer : function(params,callback){
		$.ajax({
    		url : contextPath + "/qm/answerservice/save.action",
    		type : "POST",
    		data : params,
    		success : function(result){
    			if(callback && typeof callback == "function"){
					callback(result.status);
				}
    		}
    	})
	}
}