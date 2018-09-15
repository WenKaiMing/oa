KM.Service = {
	/**
	 * 获取我的网盘列表
	 * @params {}
	 */
	getMyList : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/disk/diskOfMine.action",
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
	 * 获取公共网盘列表
	 * @params {}
	 */
	getPublicList : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/disk/diskOfPublic.action",
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
	 * 获取归档网盘列表
	 * @params {}
	 */
	getArchiveList : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/disk/diskOfArchive.action",
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
	 * 获取热门分享列表
	 * @params {}
	 */
	getHostList : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/disk/diskOfHost.action",
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
	 * 保存目录
	 * @params {"name":"","nDiskId":"","nDirId":""}
	 * name--目录名称
			nDiskId--目录所属网盘Id
			nDirId--目录所属目录Id，即父目录Id
	 */
	saveFolder : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/dir/save.action",
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
	 * 打开目录
	 * @params {nDirId--该目录的Id}
	 */
	openFolder : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/dir/view.action",
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
	 * 重命名目录
	 * @params name--重命名后的目录名称
			renameNDirId--需要重命名的目录Id
	 */
	renameFolder : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/dir/rename.action",
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
	 * 保存文件
	 * @params file--文件信息，json格式
			nDiskId--目录所属网盘Id
	 */
	saveFile : function(params,callback){
		$.ajax({
			url: contextPath + "/km/file/save.action",
			type:"POST",
    		cache:false,
    		data:params,
    		success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					//Utils.showMessage(result.message, "error");
				}
    		}
		})
	},
	/**
	 * 打开文件（获取预览信息）
	 * @params nFileId--文件Id
	 */
	openFile : function(params,callback){
		$.ajax({
			url: contextPath + "/km/file/view.action",
    		async: false,
    		cache:false,
    		data:params,
    		success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					//
					
					
					KM.Util.showToast("warning","文件不存在");
				}
    		}
		})
	},
	/**
	 * 重命名文件
	 * @params name--重命名后的文件名称
			renameNDirId--需要重命名的文件Id
	 */
	renameFile : function(params,callback){
		$.ajax({
			url: contextPath + "/km/file/rename.action",
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
	 * 批量删除文件夹和文件
	 * @params 
	 * nDiskId--文件所属的网盘Id
			dirSelects--所选目录的数组，可选
			fileSelects--所选文件的数组，可选
	 */
	deleteFolderAndFile : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/dir/deleteFolderAndFile.action",
    		async: false,
    		cache:false,
    		data:params,
    		success: function(result){
    			if(1==result.status){
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					//Utils.showMessage(result.message, "error");
				}
    		}
		})
	},
	/**
	 * 搜索
	 * @params 
	 * queryString--查询的关键词
			nDiskId--需要查询的网盘Id
	 */
	search : function(params,callback){
		$.ajax({
    		url: contextPath + "/km/file/search.action",
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