Main.Service = {
	/**
	 * 获取菜单列表
	 * @params {"parentId":""}
	 */
	getMenuItem : function(params,callback){
		$.ajax({
    		url: "getContactsTree.action",
    		//async: false,
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
	 * 获取登陆后消息
	 */
	getMessageLogin : function(callback){
		$.ajax({
    		url: Main.Config.contextPath + "/message/notification/sendMessageNotificationWhenLogin.action",
    		type:"POST",
    		cache:false,
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
	 * 获取登陆后用户消息
	 */
	getMessageLogin2User : function(callback){
		$.ajax({
    		url: Main.Config.contextPath + "/message/notification/sendMessageNotification2User.action",
    		type:"POST",
    		cache:false,
			success: function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					if (window.Notification && Notification.permission === "granted") {
						
					}else{
						OBPM.message.showError(result.message);
					}
				}
    		}
    	})
	},
	/**
	 * 移除登陆后消息
	 */
	removeMessageLogin : function(){
		$.ajax({
    		url: Main.Config.contextPath + "/message/notification/clearNotification.action"
    	})
	},
	/**
	 * 设置消息已读
	 */
	setMessageRead: function(params){
    	$.ajax({
    		url: Main.Config.contextPath + "/message/notice/set2Read.action",
    		type:"POST",
			data:params
    	})
	}
}