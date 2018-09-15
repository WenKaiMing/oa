var uploader;
PM.Router = {
	task: function(){
		var router = new Router({
				container: '#container',
				enterTimeout: 250,
				leaveTimeout: 250
			});
		//首页
		var home = {
			url: '/',
			className: 'home',
			render: function () {
				return $('#tpl_home').html();
			},
			bind: function () {
				loadHide();
			}
		};
		//新建任务
		var tpl_task_create = {
			url: '/tpl_task-create',
			className: 'tpl_task-create',
			render: function () {
			
				return $('#tpl_task-create').html();
			},
			bind: function () {
				PM.task.createTask();
				//实时监测新建任务textarea中值的变化
				//$container.bind('input oninput', '.tpl_task-list #form-create-task-name', function () {
				//	$('#textarea_counter').html($("#form-create-task-name").val().length); 
				//});
				//初始化webuploader
				webUploader(PM.cache.currentEditTaskId);
				$(".tpl_task-create #form-create-task-name").bind('input oninput', function() {
					$('#textarea_counter').html($("#form-create-task-name").val().length); 
				});
				}
		};
		//任务列表
		var tpl_task_list = {
			url: '/tpl_task-list',
			className: 'tpl_task-list',
			render: function () {
				return $('#tpl_task-list').html();
			},
			after: function(){
				//PM.task.randerTaskListPage();
				PM.project.taskList.randerTaskList("",{"status":"",executorId:USER.id});
				//任务列表一进来显示全部
				PM.service.task.getTaskProjectList({},function(data){	//渲染面板的项目
					var $selectProject = $(".task-create").find(".panel-project");
					$selectProject.html("");
					$.each(data,function(){
						var spanProject = '<span class="panel-right-project panel-right-status"></span>';
						var $spanProject = $(spanProject);
						$spanProject.attr("data-id",this.id);
						$spanProject.attr("data-name",this.name);
						$spanProject.text(this.name);
						$selectProject.append($spanProject);
					});
				});
		    	PM.service.tag.getTagMyProject(function(data){	//渲染面板的标签
					var $selectLabel = $(".task-create").find(".panel-tag");
					$selectLabel.html("");
					$.each(data,function(){
						var spanLabel = '<span class="panel-right-tag panel-right-label"></span>';
						var $spanLabel = $(spanLabel);
						$spanLabel.attr("data-id",this.id);
						$spanLabel.attr("data-name",this.name);
						$spanLabel.text(this.name);
						$selectLabel.append($spanLabel);
					});
				});
		    	$(".tpl_task-list").find("input[name='executorId']").val(USER.id);
			},
			bind: function () {
				loadHide();
				
			}
		};
		//单个任务详细信息
		var tpl_task_info = {
			url: '/tpl_task-info/:listId',
			className: 'tpl_task-info',
			render: function () {
				var _listId = this.params.listId
	        	var listId = _listId.substring(1);
				PM.cache.currentEditTaskId = listId;
				return $('#tpl_task-info').html();
			},
			after: function(){
				PM.task.randerTaskInfoPage();
			},
			bind: function () {
				loadHide();
			}
		};
		//单个任务编辑页面
		var tpl_task_edit = {
			url: '/tpl_task-edit/:listId',
			className: 'tpl_task-edit',
			render: function () {
				var _listId = this.params.listId
	        	var listId = _listId.substring(1);
				PM.cache.currentEditTaskId = listId;
				return  $('#tpl_task-edit').html();
			},
			after: function(){
				PM.task.randerTaskEditPage();
				$('.tpl_task-edit #textarea_counter_edit').html($(".tpl_task-edit #form-create-task-name").val().length); 
			},
			bind: function () {
				loadHide();
				//初始化webuploader
				webUploader(PM.cache.currentEditTaskId);
				$(".tpl_task-edit #form-create-task-name").bind('input oninput', function() {
					$('#textarea_counter_edit').html($("#form-create-task-name").val().length); 
				});
			
			}
		};
		//项目列表
		var tpl_project_list = {
			url: '/tpl_project-list',
			className: 'tpl_project-list',
			render: function () {
				return $('#tpl_project-list').html();
			},
			after: function(){
				$(".tpl_project-list").find(".pm_projects_lists").css("margin-top","0px");
				PM.project.renderProjectPage();
			},
			bind: function () {
				loadHide();
			}
		};
		//单个项目下的任务列表
		var tpl_project_task_list = {
			url: '/tpl_task-list/:_proId',
			className: 'tpl_task-list',
			render: function () {
				var _proId = this.params._proId
	        	var proId = _proId.substring(1);
				PM.cache.currentProjectId = proId;
				
				return $('#tpl_task-list').html();
			},
			after: function(){
				PM.project.taskList.randerTaskList(PM.cache.currentProjectId,{status:"",executorId:""});
				PM.project.taskList.getMemberType(PM.cache.currentProjectId);
				$(".tpl_task-list").find("input[name='projectId']").val(PM.cache.currentProjectId);
				var params = {};
				params["projectId"] = PM.cache.currentProjectId;
				PM.service.tag.getTagList(params,function(data){	//渲染面板的标签
					var $selectLabel = $(".task-create").find(".panel-tag");
					$selectLabel.html("");
					$.each(data,function(){
						var spanLabel = '<span class="panel-right-tag panel-right-label"></span>';
						var $spanLabel = $(spanLabel);
						$spanLabel.attr("data-id",this.id);
						$spanLabel.attr("data-name",this.name);
						$spanLabel.text(this.name);
						$selectLabel.append($spanLabel);
					});
				});
			},
			bind: function () {
				loadHide();
			}
		};
		
		//消息页面
		var tpl_task_msg = {
		    url: '/tpl_task-msg:id',
		    className: 'tpl_task-msg',
		    render: function () {
		    	return $('#tpl_task-msg').html();
		    },
		    after: function(){
		    	var _id = this.params.id
	        	var id = _id.substring(1);//0:新建;1:修改
		    	if(id == 0){
		    		$(".tpl_task-msg").find(".weui_msg_title").text("创建成功");
		    	}else if(id == 1){
		    		$(".tpl_task-msg").find(".weui_msg_title").text("修改成功");
		    	}else{
		    		$(".tpl_task-msg").find(".weui_msg_title").text("任务完成");
		    	}
		    	
		    }
		};
		
		//添加标签
		var tpl_task_tag = {
			url: '/tpl_task-tag',
			className: 'tpl_task-tag',
			removeParent:false,
			render: function () {
					return $('#tpl_task-tag').html();
			},
			after: function(){
				PM.task.createTaskTag();
			}
		};
		//添加项目
		var tpl_task_project = {
			url: '/tpl_task-project',
			className: 'tpl_task-project',
			removeParent:false,
			render: function () {
					return $('#tpl_task-project').html()
			},
			after: function(){
				PM.task.createTaskProject();
			}
		};
		
		//文件预览
		
		var tpl_task_pic = {
		    url: '/tpl_task-pic',
		    className: 'tpl_task-pic',
		    removeParent:false,
		    render: function () {
		    	return $('#template_task-pic').html();
		    },
		    after: function(){
		    	var _hash =  $(".tpl_task-pic").find(".backhash").val();
		    	var _id = $(".tpl_task-pic").find(".backhash").attr("_id");
		    	var $viewDiv = $(".tpl_task-pic").find(".task-attachment-view");
				if(_hash.indexOf("/tpl_task-info") == -1){
					$viewDiv.find(".task-attachment-view-delect").attr("_id",_id);
					$viewDiv.find(".task-attachment-view-delect").attr("_hash",_hash);
				}else{
					$viewDiv.find(".task-attachment-view-delect").hide();
				}
				var $viewImg = $viewDiv.find("img");
				$viewDiv.find("div.lookImg").each(function () {
					var divImgHeight = $(this).parent().height();
					if(divImgHeight>($(window).height()-41)){
						divImgHeight = $(window).height()-41;
					}
					divImgleft = ($(this).width())/2;
					$(this).css({"height":divImgHeight+"px","line-height":divImgHeight+"px","background-color":"#000000","left":"50%","margin-left":"-"+divImgleft+"px"});
	  				new RTP.PinchZoom($(this), {});
	  			});
				loadHide();
		    }
		};
		
		//有弹出的情况改变hash，为了防止用户点击手机的返回键而跳到了微信入口页
		var popUpLayer = {
			url: '/popUpLayer',
			removeParent:false
		};
		
		router.push(home)
		.push(tpl_task_create)
        .push(tpl_task_list)
		.push(tpl_task_info)
		.push(tpl_task_edit)
		.push(tpl_project_list)
		.push(tpl_project_task_list)
		.push(tpl_task_msg)
		.push(tpl_task_tag)
		.push(tpl_task_project)
		.push(tpl_task_pic)
		.push(tpl_task_msg)
		.push(popUpLayer)
        .setDefault('/')
        .init();


		// .container 设置了 overflow 属性, 导致 Android 手机下输入框获取焦点时, 输入法挡住输入框的 bug
		// 相关 issue: https://github.com/weui/weui/issues/15
		// 解决方法:
		// 0. .container 去掉 overflow 属性, 但此 demo 下会引发别的问题
		// 1. 参考 http://stackoverflow.com/questions/23757345/android-does-not-correctly-scroll-on-input-focus-if-not-body-element
		//    Android 手机下, input 或 textarea 元素聚焦时, 主动滚一把
		if (/Android/gi.test(navigator.userAgent)) {
			window.addEventListener('resize', function () {
				if (document.activeElement.tagName == 'INPUT' || document.activeElement.tagName == 'TEXTAREA') {
					window.setTimeout(function () {
						document.activeElement.scrollIntoViewIfNeeded();
					}, 0);
				}
			})
		}
	}
}
