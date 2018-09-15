/**
 * PM 业务操作类
 * <p>封装与PM页面与后台进行数据交互的方法</p>
 * @author Happy
 */
PM.service = {
		
		
	/**
	 * 项目模块
	 */
	project : {
		/**
		 * 获取项目集合
		 */
		getProjectList : function(params,callback) {
			$.ajax({
				url:"project/queryMyProject.action",
				cache:false,
				data:params,
				success:function (result){
					if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
				}
			});
		},
		/**
		 * 新建项目
		 * @param projectName
		 * 		项目名称
		 */
		createProject : function(opts) {
			$.post("project/create.action",{"content.name" : opts.projectName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(opts.success && typeof opts.success == "function"){
						opts.success(result.data);
					}
				}else{
					if(opts.error && typeof opts.error == "function"){
						opts.error(result.data);
					}
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 编辑项目
		 * @param id
		 * 		项目主键
		 */
		editProject : function(id,callback) {
			$.getJSON("project/view.action",{"id":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 删除项目
		 * @param id
		 * 		项目主键
		 */
		deleteProject : function(id,callback) {
			$.getJSON("project/delete.action",{"_selects":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 关闭项目
		 * @param id
		 * 		项目主键
		 */
		closeProject : function(id, callback) {
			$.getJSON("project/closeProject.action",{"projectId":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 打开项目
		 * @param id
		 * 		项目主键
		 */
		openProject : function(id, callback) {
			$.getJSON("project/openProject.action",{"projectId":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 更新项目
		 * @param id
		 * 		项目主键
		 * @param name
		 * 		项目名称
		 */
		updateProject : function(id,name,callback) {
			$.post("project/save.action",{"content.id":id,"content.name":name},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 添加项目成员
		 * @param id
		 * 		项目主键
		 * @param members
		 * 		成员集合(JSON)
		 */
		addMembers : function(id,members,callback) {
			$.post("project/addMembers.action",{"id":id,"members":members},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 设置项目经理
		 * @param id
		 * 		项目主键
		 * @param userId
		 * 		用户主键
		 */
		setProjectManager : function(id,userId,callback) {
			$.post("project/setProjectManager.action",{"id":id,"userId":userId},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 删除项目成员
		 * @param id
		 * 		项目主键
		 * @param userId
		 * 		用户主键
		 */
		deleteMember : function(id,userId,memberType,callback) {
			$.post("project/removeMember.action",{"id":id,"userId":userId,"memberType":memberType},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 设置项目提醒
		 * @param id
		 * 		项目主键
		 */
		setProjectMsg : function(projectId,setValue,callback) {
			$.post("project/doUpdateNotification.action",{"projectId":projectId,"notification":setValue},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		}
	},
	
	/**
	 * 任务模块
	 */
	task : {
		/**
		 * 新建任务获取任务Id
		 * @param params
		 * 
		 */
		createTaskId : function(callback){
			$.ajax({
				url:"task/createTaskId.action",
				type:"POST",
				success:function(result){
					if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
				},
				error:function(){
					Utils.showMessage("请求服务端发生异常，请稍后尝试！", "error");
				}
			})
		},
		/**
		 * 查询我的任务集合
		 * @param params
		 * 		查询参数
		 */
		queryMyTasks : function(params,callback){
			params = params || {};
			$.getJSON("task/queryMyTasks.action",params,function(result){
				if(1==result.status){
					PM.cache.tasks = result.data;
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 查询我的任务集合
		 * @param params
		 * 		查询参数
		 */
		queryMyTasks4CalendarView : function(params,callback){
			params = params || {};
			$.getJSON("task/queryMyTasks4CalendarView.action",params,function(result){
				if(1==result.status){
					PM.cache.tasks = result.data;
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 项目下的成员（管理员、执行人、创建人、关注人）关注人权限控制
		 */
		queryMemberByWebUser4Project : function(params,callback){
			$.ajax({
				url:"project/queryMemberByWebUser4Project.action",
				type:"POST",
				data:params,
				success:function(result){
					if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
				},
				error:function(){
					Utils.showMessage("请求服务端发生异常，请稍后尝试！", "error");
				}
			})
		},
		/**
		 * 根据项目查询任务集合
		 */
		queryTasksByProject : function(params,callback){
			params = params || {};
			if(typeof params.status == "undefined"){
				params.status = "";
			}
			$.ajax({
				url:"task/queryTasksByProject.action",
				type:"POST",
				data:params,
				success:function(result){
					if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
				},
				error:function(){
					Utils.showMessage("请求服务端发生异常，请稍后尝试！", "error");
					$("#tabsLoading", window.parent.document).css("z-index","1");
				}
			})
		},
		/**
		 * 根据项目查询任务集合(多子条件)
		 */
		queryTasksByProject4Multiselect : function(params,callback){
			params = params || {};
			if(typeof params.status == "undefined"){
				params.status = "";
			}
			$.ajax({
				url:"task/queryTasksByProject4Multiselect.action",
				type:"POST",
				data:params,
				traditional:true,
				success:function(result){
					if(1==result.status){
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
					}else{
						Utils.showMessage(result.message, "error");
					}
				},
				error:function(){
					Utils.showMessage("请求服务端发生异常，请稍后尝试！", "error");
					$("#tabsLoading", window.parent.document).css("z-index","1");
				}
			})
		},
		/**
		 * 以excel形式导出任务
		 */
		excelExportTask : function(params){
			params = params || {};
			if(typeof params.status == "undefined"){
				params.status = "";
			}
			var url = contextPath + "/pm/task/excelExportTask.action" + "?" + $.param(params, true);
		    window.open(url);
		},
		/**
		 * 以excel形式导入任务
		 */
		excelImportTask : function(opts){
			params = opts.params || {};
			$.ajax({
				url:"task/excelImportTask.action",
				type:"POST",
				data:params,
				success:function(result){
					if(1==result.status){
						if(opts.success && typeof opts.success == "function"){
							Utils.showMessage(result.message,"success");
							opts.success(result.data);
						}
					}else{
						if(opts.error && typeof opts.error == "function"){
							opts.error(result.message);
						}
					}
				},
				error:function(){
					Utils.showMessage("请求服务端发生异常，请稍后尝试！", "error");
					$("#tabsLoading", window.parent.document).css("z-index","1");
				}
			});
		},
		/**
		 * 查询项目成员集合
		 */
		queryMemberByProject : function(params,callback){
			params = params || {};
			$.post("project/getMembersByProjectId.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 查询标签集合
		 */
		queryTasksByTag : function(params,callback){
			params = params || {};
			$.getJSON("tag/query.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 快速新建任务
		 * @param target
		 * 		
		 * @param callback
		 */
		quickCreateTask : function(params,callback){
			params = params || {};
			$.post("task/create.action",params,function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 更新任务基础属性
		 */
		simpleUpdateTask : function(id,updateField,updateValue,callback){
			$.post("task/simpleUpdate.action",{"id":id,"updateField":updateField,"updateValue": Utils.htmlEncode(Utils.htmlEncode(updateValue))},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
			
		},
		/**
		 * 更新任务的结束时间
		 */
		updateEndDate: function(id,delta,callback){
			$.post("task/updateEndDate.action",{"id":id,"delta":delta},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 更新任务的开始时间和结束时间
		 */
		updateDate: function(id,delta,callback){
			$.post("task/updateDate.action",{"id":id,"delta":delta},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 删除任务
		 */
		removeTask : function(id,callback){
			$.getJSON("task/remove.action",{"id":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 完成任务
		 */
		complateTask : function(id,callback){
			$.getJSON("task/complateTask.action",{"id":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 重做任务
		 */
		redoTask : function(id,callback){
			$.getJSON("task/redoTask.action",{"id":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 编辑任务状态
		 */
		editTaskStatus : function(params,callback){
			$.getJSON("task/doUpdateTaskStatus.action",params,function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 编辑任务
		 */
		editTask : function(id,callback){
			$.getJSON("task/view.action",{"id":id},function(result){
				if(1==result.status){
					PM.cache.currentEditTaskId = id;
					PM.cache.currentEditTask = result.data;
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 删除任务标签
		 */
		removeTaskTag : function(id,tagName,callback){
			$.post("task/removeTaskTag.action",{"id":id,"tagName":tagName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 添加任务标签
		 */
		addTaskTag : function(id,tagName,callback){
			$.post("task/addTaskTag.action",{"id":id,"tagName":tagName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 移除任务的所属项目
		 */
		removeTaskProject : function(id,callback){
			$.post("task/removeProject.action",{"id":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 设置所属项目
		 */
		setTaskProject : function(id,projectId,projectName,callback){
			//$.post("task/removeProject.action",{"id":id},function(result){},"json");//先移除所属原来的项目
			$.post("task/setProject.action",{"id":id,"projectId":projectId,"projectName":projectName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 获取任务所属项目选择列表
		 * 若只是关注人的项目将不显示
		 */
		getTaskProjectList : function(callback){
			/*$.getJSON("project/queryMyProject.action",{},function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});*/
			$.getJSON("project/queryMyProject4Task.action",{},function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		
		
		/**
		 * 新增子任务
		 */
		createSubTask : function(id,name,callback){
			$.post("task/createSubTask.action",{"id":id,"name": Utils.htmlEncode(Utils.htmlEncode(name))},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 更新子任务
		 */
		updateSubTask : function(id,subTaskId,name,callback){
			$.post("task/updateSubTask.action",{"id":id,"subTaskId":subTaskId,"name": Utils.htmlEncode(Utils.htmlEncode(name))},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 完成子任务
		 */
		complateSubTask : function(taskId,subTaskId,callback){
			$.get("task/complateSubTask.action",{"id":taskId,"subTaskId":subTaskId},function(result){
				if(1==result.status){
					//Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 重做子任务
		 */
		redoSubTask : function(taskId,subTaskId,callback){
			$.get("task/redoSubTask.action",{"id":taskId,"subTaskId":subTaskId},function(result){
				if(1==result.status){
					//Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 删除子任务
		 */
		removeSubTask : function(taskId,subTaskId,callback){
			$.get("task/removeSubTask.action",{"id":taskId,"subTaskId":subTaskId},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 创建备注
		 */
		createRemark : function(id,content,callback){
			$.post("task/createRemark.action",{"id":id,"content": Utils.htmlEncode(Utils.htmlEncode(content))},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 更新备注
		 */
		updateRemark : function(id,remarkId,content,callback){
			$.post("task/updateRemark.action",{"id":id,"remarkId":remarkId,"content":Utils.htmlEncode(Utils.htmlEncode(content))},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 删除备注
		 */
		removeRemark : function(taskId,remarkId,callback){
			$.get("task/removeRemark.action",{"id":taskId,"remarkId":remarkId},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 获取任务的标签集合
		 */
		getTagList : function(params,callback){
			params = params || {};
			$.getJSON("tag/query.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 新建标签
		 */
		createTag : function(tagName,callback){
			$.post("tag/create.action",{"content.name":tagName},function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 移除任务关注人
		 */
		removeFollower : function(taskId,followerId,followerName,callback){
			$.get("task/removeFollower.action",{"id":taskId,"followerId":followerId,"followerName":followerName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 添加任务关注人
		 * @param id
		 * 		项目主键
		 * @param members
		 * 		成员集合(JSON)
		 */
		addFollowers : function(id,followers,callback) {
			$.post("task/addFollowers.action",{"id":id,"followers":followers},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		},
		/**
		 * 更新任务执行人
		 */
		updateTaskExecutor : function(id,executorId,executorName,callback){
			$.post("task/updateTaskExecutor.action",{"id":id,"executorId":executorId,"executorName":executorName},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		}
		
	},
	
	follow : {
		/**
		 * 取消关注
		 */
		unfollow : function(taskId,callback){
			$.get("task/unfollow.action",{"id":taskId},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
					return true;
				}else{
					Utils.showMessage(result.message, "error");
					return false;
				}
			});
		},
		/**
		 * 关注任务
		 */
		follow : function(taskId,callback){
			$.get("task/follow.action",{"id":taskId},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
					return true;
				}else{
					Utils.showMessage(result.message, "error");
					return false;
				}
			});
		},
		/**
		 * 查询我关注的任务集合
		 */
		queryMyFollowTasks : function(params,callback){
			params = params || {};
			if(typeof params.status == "undefined"){
				params.status = 3;
			}
			$.getJSON("task/queryMyFollowTasks.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		}
	},
	/**
	 * 标签模块
	 */
	tag : {
		/**
		 * 获取标签列表
		 */
		getTagList : function(params,callback){
			params = params || {};
			$.getJSON("tag/query.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		},
		/**
		 * 创建标签
		 */
		createTag : function(name,id,callback){
			$.post("tag/create.action",{"content.name":name,"content.projectId":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			},"json");
		
		},
		/**
		 * 删除标签
		 */
		deleteTag : function(id,callback){
			$.getJSON("tag/delete.action",{"_selects":id},function(result){
				if(1==result.status){
					Utils.showMessage(result.message, "info");
					if(callback && typeof callback == "function"){
						callback();
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		}
	},
	/**
	 * 动态模块
	 */
	activity : {
		/**
		 * 查询动态
		 */
		queryActivities:function(params,callback){
			params = params || {};
			$.getJSON("activity/query.action",params,function(result){
				if(1==result.status){
					if(callback && typeof callback == "function"){
						callback(result.data);
					}
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
		}
		
	}
	
};