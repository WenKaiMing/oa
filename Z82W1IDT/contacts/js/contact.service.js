Contacts.Service = {
	
	/**
	 * 获取部门列表(含部门成员)
	 * @params {"parentId":""}
	 */
	getContactsTree : function(params,callback){
		$.ajax({
    		url: Contacts.config.tabs.dept.url,
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
	 * 获取全部联系人
	 */
	getAllUser : function(params,callback){
		$.ajax({
    		url: Contacts.config.tabs.all.url,
    		//async: false,
    		cache:false,
    		data:params,
			success: function(result){//{message: "", status: "", data: Array[]}
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
	 * 获取角色
	 * @params {"applicationId":"","roleId":""}
	 */
	getRoleTree : function(params,callback){
		$.ajax({
    		url: Contacts.config.tabs.role.url,
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
	 * 获取常用联系人
	 */
	getFavorite : function(params,callback){
		$.ajax({
    		url: Contacts.config.tabs.favorite.url,
    		//async: false,
    		cache:false,
    		data:params,
    		success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					callback("");
					//Utils.showMessage(result.message, "error");
				}
    		}
		})
	},
	/**
	 * 获取部门角色下级人员数量
	 * @params {"id":"","type":""}
	 */
	getRoleOrDeptUserCounts : function(params,callback){
		$.ajax({
    		url: "contacts/getRoleOrDeptUserCounts.action",
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
	 * 按字母获取列表
	 * @params 
	 */
	getListByLetter : function(params,callback){
		$.ajax({
    		url: "contacts/getContactsByFirstLetter.action",
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
	 * 是否常用联系人
	 */
	isFavoriteContact : function(params,callback){
		$.ajax({
    		url: "contacts/isFavoriteContact.action",
    		async: false,
    		cache:false,
			data:params,
			success: function(result){//{message: "", status: "", data: Array[]}
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
	 * 加入常用联系人
	 * @params {"userId":""}
	 */
	addFavorite : function(params,callback){
		$.ajax({
    		url: "contacts/addFavoriteContact.action",
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
	 * 移除常用联系人
	 * @params {"userId":""}
	 */
	removeFavoriteContact : function(params,callback){
		$.ajax({
    		url: "contacts/removeFavoriteContact.action",
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
	 * 查询
	 * @params {"keyWord":""}
	 */
	searchContacts : function(params,callback){
		$.ajax({
    		url: "contacts/getContactsBySearch.action",
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
	}
}