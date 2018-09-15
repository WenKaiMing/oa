Message.Service = {
	/**
	 * 发布动态
	 */
	saveMessage : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/publicMessage.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 发布公告
	 */
	saveAnnouncement : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/publicAnnouncement.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取列表
	 */
	getMessageList : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/query4Message.action",
    		type:"POST",
    		async: false,
    		cache:false,
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取公告列表
	 */
	getAnnouncementList : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/query4Announcement.action",
    		type:"POST",
    		async: false,
    		cache:false,
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取单条消息内容
	 * messageId
	 */
	getMessage : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/getMessage.action",
    		type:"POST",
    		async: false,
    		cache:false,
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取附件地址
	 */
	getAttachementUrl : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/doView4Attachement.action",
    		type:"POST",
    		async: false,
    		cache:false,
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取评论列表
	 */
	getCommentList : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/comment/query.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},	
	/**
	 * 发布评论
	 */
	saveComment : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/comment/comment.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 删除消息
	 */
	delectMessage : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/messages/delete.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 删除评论
	 */
	delectComment : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/comment/delete.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取事项列表
	 */
	getRemindList : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/notice/query.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取事项未读数量
	 */
	getNotificationCount : function(callback){
		$.ajax({
    		url: contextPath + "/message/notification/getNotificationCount.action",
    		cache:false,
    		type:"POST",
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	
	
	/**
	 * 获取我回复的列表
	 */
	getIReplyList : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/comment/queryIReply.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 获取回复我的列表
	 */
	getIReceiveList : function(params,callback){
		$.ajax({
			url: contextPath + "/message/comment/queryIReceive.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 设置已读
	 * id
	 */
	setRead : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/notice/set2Read.action",
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
    				if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	},
	/**
	 * 删除事项列表
	 */
	deleteRemindItem : function(params,callback){
		$.ajax({
    		url: contextPath + "/message/notice/delete.action",
    		async: false,
    		cache:false,
    		type:"POST",
			data:params,
			success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					OBPM.message.showError(result.message);
				}
    		}
    	})
	}
}