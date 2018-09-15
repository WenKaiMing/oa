/**
 * PM 核心类
 * <p>封装PM应用层界面渲染与交互行为</p>
 * @author Happy
 */
var PM = {
	cache : {
		uploader : null
	},
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
		this.project.init();
		this.task.init();
		this.follow.init();
		$(".nav-item.pm-task").trigger("click");//for test;
		
		$("#pm-task-tool-bar-search-current-date").val(moment().format("YYYY-MM-DD"));
		$("#pm-task-tool-bar-search-current-date").datepicker();
		
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
        $(".nav-item").click(function() {//左侧导航点击事件
            $(".nav-item a").removeClass("selected");
            $(this).find("a").addClass("selected"),
            $(".pm-page").hide();
            var target = $(this).attr("data-target");
            $("." + target).show();
            if(target.indexOf("project")!=-1){
            	PM.project.renderProjectPage();
            }else if(target.indexOf("tag")!=-1){
            	PM.tag.renderTagPage();
            }else if(target.indexOf("follow")!=-1){
            	PM.follow.renderFollowPage();
            }else if(target.indexOf("activity")!=-1){
            	PM.activity.renderActivityPage();
            }
        }),

        $(".close-popup").click(function() {//关闭弹出层的钮点击事件
            if($(this).parents('#W_EditProject').length){
            	PM.project.renderProjectPage();
            }
            if($(this).parents('#W_ProImportTask').length){
        		$("#W_ProImportTask .import-error-info").html("");
            }
            return Utils.hidePop();
        });
        $(".btn-cancel").click(function() {//关闭弹出层的钮点击事件
            if($(this).parents('#W_ProImportTask').length){
        		$("#W_ProImportTask .import-error-info").html("");
            }
            return Utils.hidePop();
        });
        $(window).resize(function(){
        	  Utils.resizeFourPart();
        });
	},
	
	/**
	 * 项目模块
	 */
	project : {
		
		/**
		 * 初始化
		 */
		init : function() {
			this.bindEvent();
		},
		
		/**
		 * 绑定事件
		 */
		bindEvent : function() {
			var isScroll = true;
	        $(".J_AddProject").click(function() {//新建项目按钮点击事件
	            Utils.showMask();
	            var target = $(this).attr("data-target");
	            return $(target).show().find("input").val("").focus();
	        }),
	        $("#W_AddProject input[type='text']").bind('input oninput', function() {
				if($(this).val().length == 100){
					$("#W_AddProject .overstep").show();
				}else{
					$("#W_AddProject .overstep").hide();
				} 
			});
	        $("#B_AddProject").click(function() {//创建项目按钮点击事件
	        	$(this).attr("disabled","disabled");
	            var projectName = $(this).parents(".popup-co").find("input").val();
	            if("" != $.trim(projectName)){ 
	            	PM.service.project.createProject({
	            		projectName : projectName, 
	            		success : function(project){
			            	PM.project.renderProjectPage();
							Utils.hidePop();
							$("#B_AddProject").removeAttr("disabled");
		            	},
		            	error : function(ex){
		            		$("#B_AddProject").removeAttr("disabled");
		            	}
	            	});
	            }else{
	            	Utils.showMessage("项目名称不能为空", "error");
	            	$("#B_AddProject").removeAttr("disabled");
	            }
	        }),
	        
	        $("#W_AddProject").find("input").keydown(function(){	//创建项目回车事件
	        	if (event.keyCode == 13) {
	        		$("#B_AddProject").removeAttr("disabled");
	    			var projectName = $(this).parents(".popup-co").find("input").val();
		            if("" != $.trim(projectName)){ 
		            	PM.service.project.createProject({
		            		projectName : projectName, 
		            		success : function(project){
				            	PM.project.renderProjectPage();
								Utils.hidePop();
								$("#B_AddProject").removeAttr("disabled");
			            	},
			            	error : function(ex){
			            		$("#B_AddProject").removeAttr("disabled");
			            	}
		            	});
		            }else{
		            	Utils.showMessage("项目名称不能为空", "error");
		            	$("#B_AddProject").removeAttr("disabled");
		            }
	    		}
	    	}),
	        $(".cell-box-list-project").on("click", ".icon-dp-menu",function(event){//项目操作图标点击事件
	        	$(this).next(".task-menu").toggle();
	        	event.stopPropagation();
	        }),
	        $(".cell-box-list-project").on("click",".A_DeleteProject",function(e){//删除项目
	        	var id = $(this).parents("li").data("id");
	        	var name = $(this).parents("li").data("name");
	        	Utils.showMask();
	        	$(this).parent(".task-menu").hide();
	        	$("#W_DeleteProject").show().data("id",id).find("#ProjectName").text(name);
	        	e.stopPropagation();
	        }),
	        $("#B_DeleteProjectAll").click(function(e){//删除项目
	        	var id = $("#W_DeleteProject").data("id");
	        	if("" != $.trim(id)){
	        		PM.service.project.deleteProject(id,function(){
	        			PM.project.renderProjectPage();
	        			Utils.hidePop();
	        		});
	        	}
	        	e.stopPropagation();
	        }),
	        $(".cell-box-list-project").on("click",".A_CloseProject",function(e){//关闭或打开项目
	        	var id = $(this).parents("li").data("id");
	        	var name = $(this).parents("li").data("name");
	        	var closed = $(this).parents("li").data("closed");
	        	Utils.showMask();
	        	$(this).parent(".task-menu").hide();
	        	if(closed){//若当前项目已经关闭，刚直接打开
		        	if("" != $.trim(id)){
		        		PM.service.project.openProject(id, function(){
		        			PM.project.renderProjectPage();
		        			Utils.hidePop();
		        		});
		        	}
	        	} else {//若当前项目未关闭，弹出确认关闭项目的对话框
	        		$("#W_CloseProject").show().data("id",id).data("closed",closed).find("#ProjectName").text(name);
	        	}
	        	e.stopPropagation();
	        }),
	        $("#B_CloseProjectAll").click(function(e){//关闭或打开项目
	        	var id = $("#W_CloseProject").data("id");
	        	var closed = $("#W_CloseProject").data("closed");
	        	if("" != $.trim(id)){
	        		PM.service.project.closeProject(id, function(){
	        			PM.project.renderProjectPage();
	        			Utils.hidePop();
	        		});
	        	}
	        	e.stopPropagation();
	        }),
	        $(".cell-box-list-project").on("click",".A_EditProject",function(e){//编辑项目
	        	var id = $(this).parents("li").data("id");
	        	var name = $(this).parents("li").data("name");
	        	Utils.showMask();
	        	$(this).parent(".task-menu").hide();
	        	PM.service.project.editProject(id,function(project){
	        		$(".cell-box-list-members").html($("#tmplMemberItem").tmpl(project));
	        		$(".cell-box-list-attention").html($("#tmplAttentionItem").tmpl(project));
		        	if(project.notification == true){
		        		$("#setProjectMsg").prop("checked",true);
		        	}
	        		Utils.setPopUpCenter();
	        	});
	        	var params = {};
	        	params["projectId"] = id;
	        	PM.service.tag.getTagList(params,function(tags){
	        		var tagObj={
	        			"tags":tags	
	        		};
	        		$(".cell-box-list-project-tag").html($("#tmplProjectTagItem").tmpl(tagObj));
	        	})
	        	$("#W_EditProject").find("#_currname").val(name);
	        	$("#W_EditProject").height(450).show().data("id",id).find("input[name='name']").val(name);
	        	e.stopPropagation();
	        }),
	       
	       $("#W_EditProject .contentLeft>div").click(function(){//编辑项目弹窗左侧点击切换
	    	    isScroll = false;
	        	$(this).addClass("selectDiv").siblings().removeClass("selectDiv");
	        	var contentClass = $(this).attr("_class");
	        	var container = $("#W_EditProject .contentRight");
	        	$("."+contentClass).addClass("active").siblings().removeClass("active");
	        	var scrollTo = $("."+contentClass); 
	        	container.animate({ 
	        		scrollTop: scrollTo.offset().top - container.offset().top + container.scrollTop() 
	        		});
				setTimeout(function(){
					if(!isScroll){
						isScroll = true;
					}
				},8000);
	        }),
			$("#W_EditProject .contentRight").on("scroll",function(){//编辑项目弹窗右侧滚动条滚动定位相应的左侧导航
				
				if(isScroll){
					var scrollHeight = $(this).scrollTop();
					var divHeight = 0;
					$("#W_EditProject .contentRight>div").each(function(i){
						divHeight +=  $("#W_EditProject .contentRight>div").eq(i).height();
						
						if(scrollHeight > divHeight){
							$("#W_EditProject .contentLeft").find("div").removeClass("selectDiv");
							$("#W_EditProject .contentLeft>div").eq(i+1).addClass("selectDiv");
							var rightClass = $("#W_EditProject .contentLeft>div").eq(i+1).attr("_class");
							$("."+rightClass).addClass("active").siblings().removeClass("active");
						}
						if(scrollHeight==0){
							$("#W_EditProject .contentLeft").find("div").removeClass("selectDiv");
							$("#W_EditProject .contentLeft>div").eq(0).addClass("selectDiv");
							$(".content-base").addClass("active").siblings().removeClass("active");
						}
					})
				}
	        }),
	        
	        $(".content-members").on("click","#B_addMembers",function(){	//添加项目成员
	        	var memberType = $(this).attr("memberType");
	        	$("#memberType").attr("value",memberType);
	        	Utils.selectUser({"container":"_selectMembers","memberType":memberType,callback:function(result){
	        		var id = $("#W_EditProject").data("id");
	    			var members = [];
	    			
	    			for(var i = 0; i<result.length;i++){ //循环将其中每个对象的属性取出
	        			if($(".cell-box-list-members>li").size()>0){
	        				var flag = true;
	        				$(".cell-box-list-members>li").each(function(){
	        					 var useId = $(this).attr("data-user-id");//已选的关注人的useId
	        					 if(result[i].userId == useId){
	        						 flag = false;
	        						 return false;
	        					 }
	        				});
	        				if(flag == true){
	        					members[members.length] = result[i];
	        				}
	        			}else{
	        				members[members.length] = result[i];
	        			}
	        		}
	    			var members2 = JSON.stringify(members);
	    			if(""!=$.trim(id) && ""!=$.trim(members2)){
	    				PM.service.project.addMembers(id,members2,function(data){
	    					$(".cell-box-list-members").html($("#tmplMemberItem").tmpl(data));
	    				});
	    			}
	        	}});
	        }),
	        $(".content-attention").on("click","#B_addAttention",function(){	//添加关注人
	        	var memberType = $(this).attr("memberType");
	        	$("#memberType").attr("value",memberType);
	        	Utils.selectUser({"container":"_selectAttention","memberType":memberType,callback:function(result){
	        		var id = $("#W_EditProject").data("id");
	        		var attention = [];
	        		for(var i = 0; i<result.length;i++){ //循环将其中每个对象的属性取出
	        			if($(".cell-box-list-attention>li").size()>0){
	        				var flag = true;
	        				$(".cell-box-list-attention>li").each(function(){
	        					 var useId = $(this).attr("data-user-id");//已选的关注人的useId
	        					 if(result[i].userId == useId){
	        						 flag = false;
	        						 return false;
	        					 }
	        				});
	        				if(flag == true){
	        					attention[attention.length] = result[i];
	        				}
	        			}else{
	        				attention[attention.length] = result[i];
	        			}
	        		}
	        		var attention2 = JSON.stringify(attention); 
	    			if(""!=$.trim(id) && ""!=$.trim(attention2)){
	    				PM.service.project.addMembers(id,attention2,function(data){
	    					$(".cell-box-list-attention").html($("#tmplAttentionItem").tmpl(data));
	    				});
	    			}
	        	}});
	        }),
	        //添加标签
	        $(".content-tag").on("click","#B_addtags", function(e) {
	        	$(".content-tag .nav-search").show();
				$(".content-tag .add-input").focus();
				$(".content-tag #B_addtags").hide();
	        });
	        //关闭添加标签
	        $(".content-tag").on("click","#closeTags", function(e) {
	        	$(".content-tag .add-input").val("");
	        	$(".content-tag .nav-search").hide();
				$(".content-tag #B_addtags").show();
	        });
	      //确定添加标签
	        $(".content-tag").on("click","#sureToAddTag", function(e) {
	        	var name = $(".content-tag .add-input").val();
	        	var projectId = $("#W_EditProject").data("id");
	            if("" != $.trim(name)){
	            	PM.service.tag.createTag(name,projectId,function(result){
	            		PM.project.renderProjectTagPage(projectId);
    				});
	            }else {
	            	Utils.showMessage("标签名称不能为空", "error");
	            }
	        });
	        //删除项目标签
	        $(".content-tag").on("click",".remove-tag-handler", function(e) {
	        	var id = $(this).attr("tag-id");
	        	if("" != $.trim(id)){
	        		PM.service.tag.deleteTag(id,function(){
	        			$("a[tag-id = '"+id+"']").parents(".tag-wrap").remove();
	        		});
	        	}
	        	e.stopPropagation();
	        });
	        $("#contentRight input[name='name']").blur(function(){//更新项目名称
	        //$("#B_EditProject").click(function(){//更新项目
	        	var preName = $("#_currname").val();
	        	var id = $("#W_EditProject").data("id");
	        	var name = $("#W_EditProject").find("input[name='name']").val();
	        	if(preName == $.trim(name)){
	        		return;
	        	}else if("" != $.trim(name)){
	        		PM.service.project.updateProject(id,name,function(){
	        			PM.project.renderProjectPage();
						//Utils.hidePop();
	        		});
	        	}else{
	        		Utils.showMessage("项目名称不能为空", "error");
	        	}
	        }),
	        $(".cell-box-list-members").on("mouseenter mouseleave","li",function(event){	//鼠标指针穿过或穿出项目人员时显示或隐藏设置项目经理和删除
	        	
	   		 if(event.type == "mouseenter"){
	   		  //鼠标悬浮
	   		  $(this).find(".Setmembers").slideDown("fast");
	   		 }else if(event.type == "mouseleave"){
	   		  //鼠标离开
	   		  $(this).find(".Setmembers").slideUp("fast");
	   		 }
	   		}),
	   		$(".cell-box-list-attention").on("mouseenter mouseleave","li",function(event){	//鼠标指针穿过或穿出关注人员时显示或隐藏删除
		   		 if(event.type == "mouseenter"){
		   		  //鼠标悬浮
		   		  $(this).find(".Setmembers").slideDown("fast");
		   		 }else if(event.type == "mouseleave"){
		   		  //鼠标离开
		   		  $(this).find(".Setmembers").slideUp("fast");
		   		 }
		   	}),
	        $(".cell-box-list-members").on("click","._SetManager",function(){	//设置项目经理
	        	var projectId = $("#W_EditProject").data("id");
	        	var userId = $(this).parents("li").data("userId");
	        	PM.service.project.setProjectManager(projectId,userId,function(data){
	        		$(".cell-box-list-members").html($("#tmplMemberItem").tmpl(data));
	        	});
	        }),
	        $(".cell-box-list-members").on("click",".A_DeleteMember",function(){	//删除项目成员
	        	var projectId = $("#W_EditProject").data("id");
	        	var userId = $(this).parents("li").data("userId");
	        	var memberType = $(this).parents("li").attr("data-memberType");
	        	PM.service.project.deleteMember(projectId,userId,memberType,function(data){
	        		$(".cell-box-list-members").html($("#tmplMemberItem").tmpl(data));
	        	});
	        }),
	        $(".cell-box-list-attention").on("click",".A_DeleteMember",function(){//删除关注人
	        	var projectId = $("#W_EditProject").data("id");
	        	var userId = $(this).parents("li").data("userId");
	        	var memberType = $(this).parents("li").attr("data-memberType");
	        	PM.service.project.deleteMember(projectId,userId,memberType,function(data){
	        		$(".cell-box-list-attention").html($("#tmplAttentionItem").tmpl(data));
	        	});
	        }),
	        $(".cell-box-list-project").on("click", ".task-item",function(e) {//单击项目
	        	var item = $(this).closest(".task-item");
                var id = item.data("id");
                var name = item.find(".task-title").text();
                $(".pm-page").hide();
                PM.service.task.queryMemberByWebUser4Project({"projectId":id},function(result){
                	if(result.memberType == PM.MemberType.follower){
                		$(".pm-page-taskTable").find(".newTaskInPro").hide();
                	}
                });
                $(".pm-page-taskTable").show().find("h3").html("<span>项目</span> >");
                $(".pm-page-taskTable").find("h3>span").on("click",function(){
                	window.location.reload();
                });
                //任务列表中渲染选择项目的功能start
                $(".task-pro").show();
                $(".pm-page-taskTable").find(".pro-name").find("span").attr("title",name);
                $(".pm-page-taskTable").find(".pro-name").find("span").text(name);
                $(".pm-page-taskTable").find(".pro-name").attr("data-id",$(this).data("id"));
                var proLi = $(this);
            	var proId = $(this).data("id");
            	var proName = $(this).find(".task-title").text();
            	var $proList = "";
            	$(".cell-box-list-project li").not(".project-close-bg").each( function (){
                	proLi = $(this);
                	proId = $(this).data("id");
                	proName = $(this).find(".task-title").text();
                	$proList += "<li data-id="+proId+"><a>"+proName+"</a></li>";
                })
                $(".task-pro>.project-list>ul").html($proList);
                if($(".cell-box-list-project li").length >15){
                	$(".task-pro>.project-list>ul").slimscroll({
            			height:'384px'
            		});
                }
                $(".task-pro>.project-list ul>li").on("click",function(){
            		$(".pm-page-taskTable").find(".pro-name").find("span").text($(this).text());
            		$(".pm-page-taskTable").find(".pro-name").attr("data-id",$(this).data("id"));
            		PM.cache.currentProjectId = $(this).data("id");
            		//切换项目时重置查询条件
            		PM.project.taskList.resetSearchH5();
            		PM.project.taskList.resetSearchDwz();
            		
            		PM.project.taskList.init(PM.cache.currentProjectId);
            	})
            	//任务列表中渲染选择项目的功能end
                PM.project.taskList.init(id);
            }),
            //设置消息提醒
	        $("#setProjectMsg").on("click", function(e) {
                var projectId = $("#W_EditProject").data("id");
	        	var setValue;
	        	if($(this).prop("checked")){
	        		setValue = "1";
	        	}else{
	        		setValue = "0";
	        	}
                PM.service.project.setProjectMsg(projectId,setValue,function(result){
					//TODO 返回结果
				});
            });
	        
	        //项目查询关闭按钮
			$(".pm-page-project").on("click",".closePro_checkbox",function(){
				$(this).toggleClass("open");
				if($(this).hasClass("open")){
					$.cookie("project-close","true")
					$(".cell-box-list-project").find(".task-item[data-closed='true']").show();
				}else{
					$.cookie("project-close","false")
					$(".cell-box-list-project").find(".task-item[data-closed='true']").hide();
				}
			});
	        
	        /*,
        	$("#pm-task-table-body2").on("click","#pm-task-unfollow-btn",function(e){//取消关注
        		var $this = $(this);
				taskId = $this.data("id");
				PM.service.follow.unfollow(taskId,function(){
					$this.hide().next().show();
				});
			}),
			$("#pm-task-table-body2").on("click","#pm-task-follow-btn",function(e){//关注
				var $this = $(this);
				taskId = $this.data("id");
				PM.service.follow.follow(taskId,function(){
					$this.hide().prev().show();
				});
			});*/
		},
		/**
		 * 初始化项目页面搜索
		 */
		initSearchProject : function(){
			var search =  new holmes({
			    input: '#search-projectName',
			    find: '.cell-box-list-project .task-item .task-title',
			    class: {
			      visible: 'visible',
			      hidden: 'hidden'
			    },
			    onVisible: function(el) {
			    	if($(el).parent().data("closed")==true){
			    		if($(".search-project-boot-switch").find(".ios-switch").is(':checked')){
			    			$(el).parent().show()
			    		}
			    	}else{
			    		$(el).parent().show()
			    	}
			    },
			    onHidden: function(el) {
			    	$(el).parent().hide()
			    }
			});
			search.start();
		},
		/**
		 * 渲染项目的标签
		 * **/
		renderProjectTagPage: function(projectId){
			var params = {};
        	params["projectId"] = projectId;
        	PM.service.tag.getTagList(params,function(tags){
        		var tagObj={
        			"tags":tags	
        		};
        		$(".cell-box-list-project-tag").html($("#tmplProjectTagItem").tmpl(tagObj));
        		//$("#W_EditProject").find("#_currname").val(name);
        		//$("#W_EditProject").height(450).show().data("id",id).find("input[name='name']").val(name);
        	})
		},
		/**
		 * 渲染项目页面
		 */
		renderProjectPage : function(){
			PM.service.project.getProjectList({},function(projects){
				if(projects == ""){
					$(".cell-box-list-project").html('<div id="content-space">'
					+'<table height="100%" width="100%" border="0"><tbody>'
					+'<tr><td align="center" valign="middle">'
					+'<div class="content-space-pic iconfont-h5">&#xe050;</div>'
					+'<div class="content-space-txt text-center">暂无数据</div>'
					+'</td></tr></tbody></table></div>');
				}else{
					$(".cell-box-list-project").html($("#tmplProjectItem").tmpl(projects,{
						getTaskFinishedPercent : function(){//获取完成百分比
							if(this.data.tasksTotal==0) return 0;
							return Math.round((this.data.finishedTasksNum/this.data.tasksTotal)*100);
						}
					}));
					//根据cookie控制显示隐藏已关闭项目
					var isProjectClose = $.cookie("project-close");
					if(isProjectClose && isProjectClose != "" && isProjectClose == "true"){
						$(".closePro_checkbox").addClass("open");
						$(".cell-box-list-project").find(".task-item[data-closed='true']").show();
					} else {
						$(".closePro_checkbox").removeClass("open");
						$(".cell-box-list-project").find(".task-item[data-closed='true']").hide();
					}
					PM.project.initSearchProject()
				}
			});
		},
		
		/**
		 * 项目下的任务列表
		 */
		taskList : {
			
			/**
			 * 初始化
			 */
			init : function(id){
				this.bindEvent();
				this.randerTaskList(id,{status:"-100"});
				this.randerCreaterList(id,"noFollower");
				this.randerMemberList(id,"noFollower");
				this.randerTagsList(id);
				this.getMemberType(id);
				PM.cache.currentProjectId = id;
			},
			
			/**
			 * 绑定事件
			*/
			bindEvent : function() {
				$(".newTaskInPro").unbind().click(function() {//新建任务按钮点击事件
						PM.cache.openType = PM.TaskOpenType._new;
						PM.service.task.createTaskId(function(data){
							PM.cache.currentEditTaskId = data;
							var task = {
								name : "",
								id : data
							};
							task.projectId = PM.cache.currentProjectId;
							task.projectName = $(".pro-task").find(".pro-name").text();
							task.status = 0;
							task.level = 0;
							task.startDate = Utils.getNowFormatDate(new Date());
							task.endDate = "";
							task.executor = USER.name;
							task.remarks = [];
							task.subTask = [];
							task.tags = [];
							task.followers = [];
							task.logs = [];
							task.attachment = "";
							$("#pm-task-info").html($("#tmplTaskDetail").tmpl(task,{
								getRemindText : function(){//获取完成百分比
									if(this.data.remindMode==0){
										return "不提醒";
									}else if(this.data.remindMode==1){
										return "每天提醒";
									}else if(this.data.remindMode==2){
										return "每周提醒";
									}else if(this.data.remindMode==3){
										return "每两周提醒";
									}else if(this.data.remindMode==4){
										return "每月提醒";
									}
									return "";
								}}));
							Utils.openTaskDetailPanel();
							PM.project.taskList.randerPanelMemberList(PM.cache.currentProjectId,"noFollower");
							PM.project.taskList.randerPanelFollowerList(PM.cache.currentProjectId,"");
							$("#pm-task-info").find(".pm-task-detail").find(".pm-task-name").focus();	//光标定位在标题处
		            	});
		        }),
				$(".importTaskPro").unbind().click(function() {//任务导入按钮点击事件
					if(PM.cache.memberIdentity == 2){
						return false;
					}else{
						Utils.showMask();
			            if(!PM.cache.uploader){
			            	// 初始化Web Uploader
				    		PM.cache.uploader = WebUploader.create({

				    		    // 选完文件后，是否自动上传。
				    		    auto: true,
				    		    fileNumLimit: 1,

				    		    // swf文件路径
				    		    swf: contextPath + '/pm/js/plugin/webuploader/Uploader.swf',

				    		    // 文件接收服务端。
				    		    server: contextPath + '/upload?path=pm&uuid=',

				    		    // 选择文件的按钮。可选。
				    		    pick: '#filePicker',

				    		    // 只允许选择excel文件。
				    		    accept: {
				    		        title: 'Excel',
				    		        extensions: 'xls,xlsx',
				    		        mimeTypes: 'application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
				    		    }
				    		});
				    		
				    		// 文件上传成功
				    		PM.cache.uploader.on('uploadSuccess', function(file, response) {
				    			if(response.path != ""){
				    				$("#W_ProImportTask .excel-path").val(response.path);
				    				$("#W_ProImportTask .import-info").html("文件已上传,请导入。");
				    				$("#uploader-demo").hide();
				    			}
				    		});
			            }
			    		
			            var target = $(this).attr("data-target");
			            return $(target).show();
					}
		        }),
		        $("#B_ProImportTask").unbind().click(function() {//导入任务按钮点击事件
					$("#tabsLoading", window.parent.document).css("z-index","3");
		        	var excelPath = $("#W_ProImportTask .excel-path").val();
		        	var projectId = PM.cache.currentProjectId;
		        	if(excelPath == ""){
		        		Utils.showMessage("文件未上传，请先上传文件！","error");
						$("#tabsLoading", window.parent.document).css("z-index","1");
		        	} else {
		        		var params = {
		        			projectId:projectId,
		        			excelPath:excelPath	
		        		}
		        		PM.service.task.excelImportTask({
		        			params:params,
		        			success : function(result){
		        				PM.project.taskList.searchAction();
			    				$("#W_ProImportTask .import-info").html("");
			        			Utils.hidePop();
								$("#tabsLoading", window.parent.document).css("z-index","1");
			            	},
			            	error : function(message){
			            		$("#W_ProImportTask .import-error-info").slimscroll({
					         		height:"110px"
					         	}); 
			            		$("#W_ProImportTask .import-info").html("");
			            		$("#W_ProImportTask .import-error-info").html(message.replace(new RegExp("\n","gm"),"<br/>"));
			    				$("#W_ProImportTask .excel-path").val("");
								$("#tabsLoading", window.parent.document).css("z-index","1");
			            	}
		        		});
		        		$("#uploader-demo").show();
		        		PM.cache.uploader.reset();
		        	}
		        });

				$(".pm-list-order").unbind().on("click",function(){
					$(".pm-list-order").removeClass("pm-list-desc pm-list-asc");
					
					var params = params || {};
					params["orderName"] = $(this).attr("_orderName");
					if($(this).attr("_orderBy") == "" || $(this).attr("_orderBy") == "desc"){
						$(".pm-list-order").attr("_orderBy","");
						$(this).attr("_orderBy","asc");
						$(this).addClass("pm-list-asc");
					}else{
						$(".pm-list-order").attr("_orderBy","");
						$(this).attr("_orderBy","desc");
						$(this).addClass("pm-list-desc");
					}
					params["orderBy"] = $(this).attr("_orderBy");
					PM.project.taskList.searchAction(params);
				});

				$(".search-submit").unbind().on("click",function(){
					PM.project.taskList.searchAction();
					
					
					var nowDate = new Date();	
					params["nowDate"] = nowDate.getFullYear()+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate();
					
					params["level"] = $searchAdvance.find("select[name='search-task-level']").val();
					params["executorId"] = $searchAdvance.find("select[name='search-task-executor']").val();
					params["endDate"] = $searchAdvance.find("select[name='search-task-endDate']").val();
					params["status"] = $searchAdvance.find("select[name='search-task-status']").val();
					params["tag"] = $searchAdvance.find("select[name='search-task-tags']").val();
					
					params["taskName"] = $(".search-input").find("input[name='search-task-projectName']").val();
					params["linesPerPage"] = $(".custompage").val();
					
					PM.service.task.queryTasksByProject(params,function(result){
						PM.project.taskList.randerTaskList(PM.cache.currentProjectId,params);
					});
				});
				
				//重置高级搜索
				$(".search-reset").unbind().on("click",function(){
					PM.project.taskList.resetSearchDwz();
					PM.project.taskList.searchAction();
				});
				
				//h5下拉事件
				$(".search-advance .dropdown-menu").unbind().on("click","li",function(e){
					$(this).toggleClass("selectedLi");
					var searchName = $(this).parents(".btn-group").attr("_name");
					var searchValue = $(this).find("a").attr("_value");
					var $searchButton = $(this).parents(".btn-group").find("button");
					
					if(searchName == "endDate"){
						if(searchValue == ""){
							$searchButton.html("时间范围  <span class='caret'></span>");
						}else{
							$searchButton.html($(this).find("a").html() + " <span class='caret'></span>");
						}
						$(".search-advance").find("select[name='search-task-"+ searchName +"']").val(searchValue);
					}else{
						if($(this).hasClass("selectedLi")){
							$(".search-advance").find("select[name='search-task-"+ searchName +"'] option[value='"+searchValue+"']").prop("selected",true);
						}else{
							$(".search-advance").find("select[name='search-task-"+ searchName +"'] option[value='"+searchValue+"']").prop("selected",false);
						}
						var levelName = "";
						var currConditions = $(this).parent().find(".selectedLi");
					    if(currConditions.length == 0){
					    	switch (searchName){
								case "level":
									$searchButton.html("优先级  <span class='caret'></span>");
									break;
								case "creater":
									$searchButton.html("创建人  <span class='caret'></span>");
									break;
								case "executor":
									$searchButton.html("执行人  <span class='caret'></span>");
									break;
								case "tags":
									$searchButton.html("标签  <span class='caret'></span>");
									break;
								case "status":
									$searchButton.html("状态  <span class='caret'></span>");
									break;
							}
					    }else{
					    	currConditions.each(function(i){
							       if(0==i){
							    	   levelName = $(this).find(".checkbox_title").html();
							       }else{
							    	   levelName += (","+$(this).find(".checkbox_title").html());
							       }
							       $searchButton.html("<span class='selectName'>"+levelName + "</span> <span class='caret'></span>");
					    	});
					    }
					}
					PM.project.taskList.searchAction();
					e.stopPropagation();
					
				});
				//h5新增过期复选框
				$(".search-boot-switch").unbind().on("change",".ios-switch",function(){
					if($(this).is(':checked')){
						$(".search-advance").find("select[name='search-task-overdue']").val("OVERDUE");
						PM.project.taskList.searchAction();
					}else{
						$(".search-advance").find("select[name='search-task-overdue']").val("");
						PM.project.taskList.searchAction();
					}
				});

				//h5按钮事件
				$(".search-dropdown-submit").unbind().on("click",function(){
					PM.project.taskList.searchAction();
				});
				
				$(".search-dropdown-reset").unbind().on("click",function(){
					PM.project.taskList.resetSearchH5();
					$(".search-reset").trigger("click");
				});
				
				$(".search-dropdown-export").unbind().on("click",function(){
					if(PM.cache.memberIdentity == 2){
						return false;
					}else{
						PM.project.taskList.exportAction();
					}
				});
				
				//搜索框回车事件
		    	$(".nav-search-input").unbind().keydown(function(){	
		    		if (event.keyCode == 13) {
		    			PM.project.taskList.searchAction();
		    		}
		    	});
			},
			/**
			 * 重置skin-h5的查询条件
			 * **/
			resetSearchH5 : function(){
				var $searchAdvance = $(".search-advance");
				$searchAdvance.find(".search-dropdown-level>.btn").html("优先级  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-creater>.btn").html("创建人  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-executor>.btn").html("执行人  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-endDate>.btn").html("结束时间  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-tags>.btn").html("标签  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-status>.btn").html("状态  <span class='caret'></span>");
				$searchAdvance.find(".search-dropdown-level>ul>li").removeClass("selectedLi");
				$searchAdvance.find(".search-dropdown-creater>ul>li").removeClass("selectedLi");
				$searchAdvance.find(".search-dropdown-executor>ul>li").removeClass("selectedLi");
				$searchAdvance.find(".search-dropdown-tags>ul>li").removeClass("selectedLi");
				$searchAdvance.find(".search-dropdown-status>ul>li").removeClass("selectedLi");
				$(".ios-switch").attr("checked",false);
			},
			/**
			 * 重置skin-dwz的查询条件
			 * **/
			resetSearchDwz : function(){
				var $searchAdvance = $(".search-advance");
				$searchAdvance.find("select[name='search-task-level']").val("");
				$searchAdvance.find("select[name='search-task-creater']").val("");
				$searchAdvance.find("select[name='search-task-executor']").val("");
				$searchAdvance.find("select[name='search-task-endDate']").val("");
				$searchAdvance.find("select[name='search-task-tags']").val("");
				$searchAdvance.find("select[name='search-task-status']").val("-100");
				$searchAdvance.find("select[name='search-task-overdue']").val("");
				$(".search-input").find("input[name='search-task-projectName']").val("");
			},
			/**
			 * 项目下的成员（管理员、执行人、创建人、关注人）关注人权限控制
			 * @projectId
			 */
			getMemberType : function(projectId,params){
				var params = params || {};
				params["projectId"] = projectId;
				PM.service.task.queryMemberByWebUser4Project(params,function(result){
					switch(result.memberType){
					case 0:
						PM.cache.memberIdentity = PM.MemberType.regular;
						break;
					case 1:
						PM.cache.memberIdentity = PM.MemberType.manager;
						break;
					case 2:
						PM.cache.memberIdentity = PM.MemberType.follower;
						break;
					}
				})
			},
			/**
			 * 渲染任务列表
			 * @projectId
			 */
			randerTaskList : function(projectId,params){
				$("#tabsLoading", window.parent.document).css("z-index","3");
				var params = params || {};
				params["projectId"] = projectId;
				PM.service.task.queryTasksByProject4Multiselect(params,function(result){
		    		var tasks = result.datas;//任务集合
		    		var rowCount = result.rowCount;//总行数
		    		var pageNo = result.pageNo;//当前页码
		    		var linesPerPage = result.linesPerPage;//每页显示的行数
		    		//var linesPerPage = 5;//每页显示的行数
		        	//任务列表
		        	$("#pm-task-table-body2").html($("#tmplTaskTableListItem2").tmpl(tasks,{
		    			getLevelText : function(){//获取优先级文本
		    				switch (this.data.level) {
    						case 0:
    							return "<span class='LevelText level0'>不重要-不紧急</span>";
    							break;
    						case 1:
    							return "<span class='LevelText level1'>不重要-很紧急</span>";
    							break;
    						case 2:
    							return "<span class='LevelText level2'>很重要-不紧急</span>";
    							break;
    						case 3:
    							return "<span class='LevelText level3'>很重要-很紧急</span>";
    							break;
    						default:
    							return "<span class='LevelText'>无</span>"
    							break;
    						}
		    			}
		        		,
		        		ifOverdue : function(){
		        			if(this.data.status == '0' || this.data.status == '2' || this.data.status == '3'){
			        			var curDate = new Date();
			        			var endDate = this.data.endDate;
			        			if(endDate =="" || endDate == undefined){
			        				return false;
			        			}else{
			        				return PM.daysCalc(curDate,endDate);
			        			}
			        		}
		        		}
		    		}));
		        	
		        	
		        	
		        	//分页
		        	$(".pm-task-list-all").find("#pagination-panel").remove();
		        	$(".pm-task-list-all").append(Utils.paginationBuilder(rowCount,pageNo,linesPerPage,function(thisNo,thisLinesPerPage){
		        		var params = {};
		        		params["pageNo"] = thisNo;
		        		params["linesPerPage"] = thisLinesPerPage;

		        		var $searchAdvance = $(".search-advance");
						var nowDate = new Date();	
						params["nowDate"] = nowDate.getFullYear()+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate();
						
						params["level"] = $searchAdvance.find("select[name='search-task-level']").val();
						params["creatorId"] = $searchAdvance.find("select[name='search-task-creater']").val();
						params["executorId"] = $searchAdvance.find("select[name='search-task-executor']").val();
						params["endDate"] = $searchAdvance.find("select[name='search-task-endDate']").val();
						params["status"] = $searchAdvance.find("select[name='search-task-status']").val();
						params["tag"] = $searchAdvance.find("select[name='search-task-tags']").val();
						params["taskName"] = $(".search-input").find("input[name='search-task-projectName']").val();
						params["overdue"] = $searchAdvance.find("select[name='search-task-overdue']").val();

		        		PM.project.taskList.randerTaskList(projectId,params);
		        	}));
		        	$("#tabsLoading", window.parent.document).css("z-index","1");
		    	});
			},
			/**
			 * 渲染项目下创建人下拉列表
			 * @projectId
			 */
			randerCreaterList : function(projectId,memberGroup,params){
				var params = {};
        		params["projectId"] = projectId;
        		params["memberGroup"] = memberGroup;
	        	PM.service.task.queryMemberByProject(params,function(result){
	        		$("select[name='search-task-creater']").html("").append("<option></option>");
	        		$(".search-dropdown-creater").find(".dropdown-menu").html("");
	        		$.each(result,function(){
	        			var userName = this.userName;
	        			var userNameId = this.userId;
	        			var createrPanelOp = "<option value='"+ userNameId +"'>" + userName + "</option>";
	        			var createrPanelLi = "<li><a _value='"+ userNameId +"'>"
											+"<div class='checkbox_new'><i class='iconfont-h5 checkbox_i'>&#xe055;</i></div>"
											+"<div class='checkbox_title'>" + userName + "</div>"
											+"</a></li>";
	        			if($("select[name='search-task-creater']").find("[value='"+userNameId+"']").size()<=0){
	        				$("select[name='search-task-creater']").append(createrPanelOp);
		        			$(".search-dropdown-creater").find(".dropdown-menu").append(createrPanelLi);
	        			}	
	        		})
	        	});
			},
			/**
			 * 渲染项目成员下拉列表
			 * @projectId
			 */
			randerMemberList : function(projectId,memberGroup,params){
				var params = {};
        		params["projectId"] = projectId;
        		params["memberGroup"] = memberGroup;
	        	PM.service.task.queryMemberByProject(params,function(result){
	        		$("select[name='search-task-executor']").html("").append("<option></option>");
	        		$(".search-dropdown-executor").find(".dropdown-menu").html("");
	        		$.each(result,function(){
	        			var userName = this.userName;
	        			var userNameId = this.userId;
	        			var memberPanelOp = "<option value='"+ userNameId +"'>" + userName + "</option>";
	        			var memberPanelLi = "<li><a _value='"+ userNameId +"'>"
											+"<div class='checkbox_new'><i class='iconfont-h5 checkbox_i'>&#xe055;</i></div>"
											+"<div class='checkbox_title'>" + userName + "</div>"
											+"</a></li>";
	        			if($("select[name='search-task-executor']").find("[value='"+userNameId+"']").size()<=0){
	        				$("select[name='search-task-executor']").append(memberPanelOp);
		        			$(".search-dropdown-executor").find(".dropdown-menu").append(memberPanelLi);
	        			}	
	        		})
	        	});
			},
			/**
			 * 渲染任务面板项目成员下拉列表
			 * @projectId
			 */
			randerPanelMemberList : function(projectId,memberGroup,params){
				params = params ? params : {};
				if(projectId){
		    		params["projectId"] = projectId;
				}
	    		if(memberGroup){
	    			params["memberGroup"] = memberGroup;
	    		}
	        	PM.service.task.queryMemberByProject(params,function(result){
	        		var memberPanelLis = "";
	        		$.each(result,function(){
	        			var userName = this.userName;
	        			var userNameId = this.userId;
	        			memberPanelLis += "<li class='select-executor-li'><a _value='"+ userNameId +"'>" + userName + "</a></li>";
	        		});
	        		$(".pm-task-select-executor>ul").html(memberPanelLis);
	        	});
			},
			/**
			 * 渲染任务面板项目关注人下拉列表
			 * @projectId
			 */
			randerPanelFollowerList : function(projectId,memberGroup,params){
				var params = {};
	    		params["projectId"] = projectId;
	    		if(memberGroup != ""){
	    			params["memberGroup"] = memberGroup;
	    		}
	        	PM.service.task.queryMemberByProject(params,function(result){
	        		var followerPanelLis = "";
	        		var userIds ="#";
	        		$.each(result,function(){
	        			var userName = this.userName;
	        			var userNameId = this.userId;
	        			var memberType = this.memberType;
	        			if(memberType == 2){
	        				if(userIds.indexOf(userNameId) < 0){
	        					userIds += userNameId;
	        					followerPanelLis += "<li class='select-follower-li'><a title='"+userName+"' _value='"+ userNameId +"' _memberType='"+ memberType +"'>" + userName + "</a></li>";
	        				}
	        			}
	        		});
	        		$(".pm-task-select-follower ul").html(followerPanelLis);
	        	});
			},
			/**
			 * 渲染项目标签下拉列表
			 * @projectId
			 */
			randerTagsList : function(projectId,params){
				var params = {};
        		params["projectId"] = projectId;
	        	PM.service.task.queryTasksByTag(params,function(result){
	        		$("select[name='search-task-tags']").html("").append("<option></option>");
	        		$(".search-dropdown-tags").find(".dropdown-menu").html("");
	        		$.each(result,function(){
	        			var tagName = this.name;
	        			var tagId = this.id;
	        			var tagPanelOp = "<option value='"+ tagName +"'>" + tagName + "</option>";
	        			var tagPanelLi = "<li><a _value='"+ tagName +"'>"
										+"<div class='checkbox_new'><i class='iconfont-h5 checkbox_i'>&#xe055;</i></div>"
										+"<div class='checkbox_title'>" + tagName + "</div>"
										+"</a></li>";
	        			if($("select[name='search-task-tags']").find("[value='"+tagName+"']").size()<=0){
	        				$("select[name='search-task-tags']").append(tagPanelOp);
		        			$(".search-dropdown-tags").find(".dropdown-menu").append(tagPanelLi);
	        			}	
	        		})
	        	});
			},
			
			searchAction : function(params){
				
				var params = params || {};
				var $searchAdvance = $(".search-advance");
				
				params["projectId"] = PM.cache.currentProjectId;
				
				var nowDate = new Date();	
				params["nowDate"] = nowDate.getFullYear()+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate();
				params["level"] = $searchAdvance.find("select[name='search-task-level']").val();
				params["creatorId"] = $searchAdvance.find("select[name='search-task-creater']").val();
				params["executorId"] = $searchAdvance.find("select[name='search-task-executor']").val();
				params["endDate"] = $searchAdvance.find("select[name='search-task-endDate']").val();
				params["tag"] = $searchAdvance.find("select[name='search-task-tags']").val();
				params["status"] = $searchAdvance.find("select[name='search-task-status']").val();
				params["overdue"] = $searchAdvance.find("select[name='search-task-overdue']").val();
				
				params["taskName"] = $(".search-input").find("input[name='search-task-projectName']").val();
				params["linesPerPage"] = $(".custompage").val();
				
				PM.project.taskList.randerTaskList(PM.cache.currentProjectId,params);
				
			},
			
			exportAction : function(params){
				var params = params || {};
				var $searchAdvance = $(".search-advance");
				
				params["projectId"] = PM.cache.currentProjectId;
				
				var nowDate = new Date();	
				params["nowDate"] = nowDate.getFullYear()+"-"+(nowDate.getMonth()+1)+"-"+nowDate.getDate();
				
				params["level"] = $searchAdvance.find("select[name='search-task-level']").val();
				params["creatorId"] = $searchAdvance.find("select[name='search-task-creater']").val();
				params["executorId"] = $searchAdvance.find("select[name='search-task-executor']").val();
				params["endDate"] = $searchAdvance.find("select[name='search-task-endDate']").val();
				params["tag"] = $searchAdvance.find("select[name='search-task-tags']").val();
				params["status"] = $searchAdvance.find("select[name='search-task-status']").val();
				params["overdue"] = $searchAdvance.find("select[name='search-task-overdue']").val();
				
				params["taskName"] = $(".search-input").find("input[name='search-task-projectName']").val();
				params["linesPerPage"] = $(".custompage").val();
				
				PM.service.task.excelExportTask(params);
				
			}
		}
	},
	//############ 任务模块 开始###################
	/**
	 * 任务模块
	 */
	task:{
		
		status : {
			STATUS_DEFAULT : "",//默认
			STATUS_NEW : 0,//新建
			STATUS_DOING : 2,//处理中
			STATUS_COMPLETE : 1,//已完成
			STATUS_RESOLVE : 3,//已解决 
			STATUS_UNCOMPLETE : -1,//作废
			STATUS_ALL : -100//全部			
		},
		dateRangeType : {
			TODAY : "TODAY",//今日
			THISWEEK : "THISWEEK",//本周
			THISMONTH : "THISMONTH"//本月
		},
		project : {
			ALL : "-100",//全部
			USER : "0"//个人
		},
		/**
		 * 初始化
		 */
		init : function() {
			
			this.bindEvent();
			this.initProjectList();//渲染项目列表
			this.initMyTaskList();//默认加载任务视图
			//拖拽任务
			$( ".pm-proj-list" ).sortable({
					connectWith: ".pm-proj-list",
					update : function(event,ui){
						if(ui.sender){
							var item = ui.item;
							var id = item.data("id");
							var fLevel = item.data("level");
							var pLevel = item.parent().data("level");
							if(fLevel != pLevel){
								PM.service.task.simpleUpdateTask(id,"level",pLevel);
							}
						}
					}
				})
			.disableSelection();
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			
			$container = $("#container");
			//更新任务名称
			$container.on("blur", ".pm-task-name",function(e) {
				if(PM.cache.openType == PM.TaskOpenType._edit){		//打开面板，openType状态1,编辑;
					var taskId = PM.cache.currentEditTaskId;
		        	var name = $(".pm-task-name").text();
		        	var taskCon = $(this).parents("#pm-task-name").data("name");
		        	if(name == $.trim(taskCon)){
		        		return;
		        	}else if("" != $.trim(name) && $.trim(name).length <=200 ){ 
		        		PM.service.task.simpleUpdateTask(taskId,"name",name,function(task){
		        			PM.cache.currentEditTask.name = $(".pm-task-name").text();//更新缓存
		        			//更新任务列表页面的任务名称
		        			$("#pm-proj-list"+PM.cache.currentEditTask.level).find(".pm-proj-item[data-id='"+PM.cache.currentEditTaskId+"']").find(".pm-proj-name").text(PM.cache.currentEditTask.name);
		        			
		        			//更新任务列表页面的任务名称
		        			PM.task.refreshTaskList(task);
		        			
		        			
		        			//更新日历视图的任务名称
		        			PM.task.updateCalendarEvent(task);
		        			
		        			$("#pm-task-edit-name-cancle").click();
		        		});
		        	}else{
		        		Utils.showMessage("任务名称不能为空或字数不能超过200","error");
		        	}
				}
			}),

			$(".pm-four-part").on("click",".pm-new-proj",function(e){//点击新建任务
				$(this).hide().next().show();
				$(this).next().css({"z-index":"10","position":"absolute","width":$(".pm-new-proj-btn").width()})
				$(this).next().focus();
				$(this).next().next().show();
			}),
			
			$(".pm-four-part").on("click",".pm-new-proj-div",function(e){//点击隐藏新建任务文本框
				$(this).hide().prev().hide();
				$(this).prev().prev().show();
				
				//var $this = $(this).prev();
				//if($this.val()==""){
				//	alert("任务名称不能为空!");
				//	return;
				//}else{
				//	PM.service.task.quickCreateTask({"content.name":$this.val(),"content.level":$this.data("level")},function(data){
				//		$("#tmplFourPartLi2").tmpl(data).appendTo("#pm-proj-list" + $this.data("level"));
				//		$this.val("").hide().prev().show();
				//	});
				//}
				
			}),
			
			
			
			$(".pm-four-part").on("keydown",".pm-new-proj-ipt",function(e){//任务名称输入框回车事件
				if(e.keyCode == 13){//回车
					var $this = $(this);
					if($this.val()=="" && $this.val().length <=200 ){ 
						alert("任务名称不能为空或字数不能超过200!");
						return;
					}else{
						PM.service.task.quickCreateTask({"content.name":Utils.htmlEncode($this.val()),"content.level":$this.data("level")},function(data){
							$("#tmplFourPartLi2").tmpl(data).prependTo("#pm-proj-list" + $this.data("level"));
							$this.val("").hide().prev().show();
							Utils.resizeFourPart();
						});
					}
				}
			}),
			$(".pm-four-part").on("click",".pm-checkbox",function(e){//完成|重做任务
				var $p = $(this).parent();
				var id = $p.data("id");
				var $this =$(this);
				if($p.hasClass("incomplete")){//完成
					PM.service.task.complateTask(id,function(){
						$this.parent().removeClass("incomplete").addClass("complete"),
						$this.addClass("pm-checkbox-select"),
						$this.next().find(".pm-proj-name").addClass("pm-proj-over");
					});
				}else {//重做
					PM.service.task.redoTask(id,function(){
						$this.parent().removeClass("complete").addClass("incomplete"),
						$this.removeClass("pm-checkbox-select"),
						$this.next().find(".pm-proj-name").removeClass("pm-proj-over");
					});
				}
			}),
			
			//显示任务状态列表
			$("#pm-task-info").on("click","#pm-task-status-selector .task-detail-stage",function(e){
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(this).next().show();
				}
			}),
			//修改任务状态
			$("#pm-task-info").on("click",".pm-task-status-item",function(e){
				var id = PM.cache.currentEditTaskId;
				var $this = $(this);
				if($this.hasClass("select")){
				}else {//修改

					if(PM.cache.openType == PM.TaskOpenType._new){
						$this.parents(".pm-task-status-list").find(".pm-task-status-item").removeClass("select");
						$this.addClass("select");
						$("#pm-task-status-selector").find(".task-detail-stage span").text($this.text());
					}else{	//打开面板，openType状态1,编辑;
						var params = {};
						params["id"] = id;
						params["status"] = $this.attr("_value");
						PM.service.task.editTaskStatus(params,function(task){
							$this.parents(".pm-task-status-list").find(".pm-task-status-item").removeClass("select");
							$this.addClass("select");
							$("#pm-task-status-selector").find(".task-detail-stage span").text($this.text());
							PM.task.refreshTaskList(task);
							var compares_status = $(".search-advance").find("select[name='search-task-status']").val();//类型
							if(compares_status == null) compares_status = "-100";
							if(compares_status != "-100"){
								var show = false;	//默认是不隐藏
								if(compares_status.length){
									for(var i in compares_status){
										if(compares_status[i] == task.status){
											show = true;
											break;
										}
									}
								}
								if(!show){
									var removeTaskEl = $(".row[data-id='"+task.id+"']");
									PM.cache.removeTaskEl = removeTaskEl;
								}
							}
						});
					}
					//PM.project.taskList.searchAction();
				}
			}),
			
			$("#pm-task-info").on("click",".pm-task-done-selector",function(e){//编辑界面 完成|重做任务
				var id = PM.cache.currentEditTaskId;
				var $this =$(this);
				if($this.hasClass("select")){//重做
					PM.service.task.redoTask(id,function(){
						$this.removeClass("select");
						$this.next().removeClass("pm-task-finished");
						
						var $taskLi = $(".pm-page-task").find(".pm-proj-item[data-id='"+id+"']");
						$taskLi.removeClass("complete").addClass("incomplete");
						$taskLi.find(".pm-checkbox").removeClass("pm-checkbox-select"),
						$taskLi.find(".pm-proj-name").removeClass("pm-proj-over");
					});
				}else {//完成
					PM.service.task.complateTask(id,function(){
						$this.addClass("select"),
						$this.next().addClass("pm-task-finished");
						
						var $taskLi = $(".pm-page-task").find(".pm-proj-item[data-id='"+id+"']");
						$taskLi.removeClass("incomplete").addClass("complete");
						$taskLi.find(".pm-checkbox").addClass("pm-checkbox-select"),
						$taskLi.find(".pm-proj-name").addClass("pm-proj-over");
					});
				}
			}),
			
			$container.on("click",".pm-proj-nt",function(e){//任务名称单击事件(打开任务详细面板)
				//Utils.closeTaskDetailPanel();
				var $this = $(this);
				var id = $this.parent().data("id");
				
				PM.task.edit(id,function(){
					if($("#pm-task-proj-set").find(".pm-new-proj-tag").text() != ""){
						var $thisCurrentProjectId = $("#pm-task-proj-set").find(".pm-new-proj-tag").find(".pm-close-proj-tag").attr("data-project-id");
						$this.parent().addClass("select");
						PM.project.taskList.randerPanelMemberList($thisCurrentProjectId);
						PM.project.taskList.randerPanelMemberList($thisCurrentProjectId,"noFollower");
						PM.project.taskList.randerPanelFollowerList($thisCurrentProjectId,"");
					}
				});
				e.stopPropagation();
			}),
			$(".pm-page").delegate($(".dx-task-close-btn"),"click",function(e){//当任务面板显示时点击以外的地方隐藏任务面板
				  var target = $(e.target);
				  $("#pm-task-table-body2").find("tr").removeClass("rowBg");//当前的任务列表失去焦点
				  if(target.closest(".pm-proj-list").length == 0 && target.closest(".fc-content").length == 0 && target.closest(".newTaskInPro").length == 0 && target.closest("#W_ProAddTask").length == 0){//点击class类为pm-proj-list之外的地方触发
					  if(PM.cache.openType == PM.TaskOpenType._new){
							if("" !== $.trim($("#pm-task-info").find(".pm-task-detail").find(".pm-task-name").text()) && $(".pm-task-detail-box").css("display")=='block'){ 
								Utils.showMask();
								$("#W_ProAddTask").show();
							}else{
								Utils.closeTaskDetailPanel();
							}
						}else{
							Utils.closeTaskDetailPanel();
							$(".pm-proj-item").removeClass("select");
						}
				  }
				})
			$container.on("click","#levela,#levelb,#levelc,#leveld",function(e){//修改任务优先级
				var id = PM.cache.currentEditTaskId;
				var level = $(this).data("level");
				if(PM.cache.openType == PM.TaskOpenType._edit){
					if(!$(this).hasClass("select")){
						PM.cache.target = this;
						PM.service.task.simpleUpdateTask(id,"level",level,function(task){
							$(".pm-modify-task-level").removeClass("select");
							var $target = $(PM.cache.target);
							$target.addClass("select");
							$("#pm-task-level-btn>i").attr("class","fa fa-circle-o level"+$target.data("level"));
							$("#pm-task-level-btn>span").text($target.text());
							
							//更新任务列表页面
							PM.task.refreshTaskList(task);
							var compares_level = $(".search-advance").find("select[name='search-task-level']").val();//优先级
							if(compares_level != null){
								var show = false;	//默认是不隐藏
								if(compares_level.length){
									for(var i in compares_level){
										if(compares_level[i] == task.level){
											show = true;
											break;
										}
									}
								}
								if(!show){
									var removeTaskEl = $(".row[data-id='"+task.id+"']");
									PM.cache.removeTaskEl = removeTaskEl;
								}
							}
							//移动任务位置
							var oLevel = PM.cache.currentEditTask.level;//从缓存获取原任务优先级
							var item = $("#pm-proj-list"+oLevel).find(".pm-proj-item[data-id='"+PM.cache.currentEditTaskId+"']");
							item.appendTo($("#pm-proj-list"+$target.data("level")));
							PM.cache.currentEditTask.level = $target.data("level");//更新缓存
							PM.task.updateCalendarEvent(task);
						});
					}
				}else if(PM.cache.openType == PM.TaskOpenType._new){
					$("#pm-task-level-btn>i").attr("class","fa fa-circle-o level"+$(this).data("level"));
					$("#pm-task-level-btn>span").text($(this).text());
				}
			}),
			$container.on("click", ".pm-delete-task",function() {//删除任务
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					Utils.showMask();
		        	var target = $(this).attr("data-target");
		        	return $(target).show();
				}
	        	/*Utils.showMask();
	        	var target = $(this).attr("data-target");
	        	return $(target).show();*/
	        
	        });
			$container.on("click", ".pm-create-task-cancel",function() {//取消创建任务按钮点击事件
				Utils.closeTaskDetailPanel();	//关闭新建任务面板
			});
			$container.on("click", ".pm-create-task",function() {//创建任务按钮点击事件
				    $("#tabsLoading", window.parent.document).css("z-index","3");
		        	var $pmCreateTaskInfo = $("#pm-task-info").find(".pm-task-detail");
		        	var params = params || {};
		        	params["content.name"] = Utils.htmlEncode($pmCreateTaskInfo.find(".pm-task-name").text());
		        	params["content.projectId"] = $pmCreateTaskInfo.find(".pm-close-proj-tag").attr("data-project-id");
		        	params["content.projectName"] = $pmCreateTaskInfo.find(".pm-proj-tag").text();
		        	params["content.status"] = $pmCreateTaskInfo.find(".pm-task-status-item.select").attr("_value");
		        	var level="";
		        	var createLevel = $pmCreateTaskInfo.find(".priority-title").text();
		        	switch($.trim(createLevel)){
		        		case "很重要-很紧急":
		        			level = 3;
		        			break;
		        		case "很重要-不紧急":
		        			level = 2;
		        			break;
		        		case "不重要-很紧急":
		        			level = 1;
		        			break;
		        		case "不重要-不紧急":
		        			level = 0;
		        			break;
	        			default:
	        				break;
		        			
		        	}
		        	params["content.level"] = level;
		        	params["content.startDate"] = $pmCreateTaskInfo.find(".start-date").val();
		        	params["content.endDate"] = $pmCreateTaskInfo.find(".end-date").val();
		        	var remarks = [];
		        	var $executor = $("#pm-task-executor-btn>span");
		        	//执行人id
		        	var executorId = $executor.attr("_value");
		        	if(!executorId){
		        		executorId = USER.id;
		        	}
		        	params["content.executorId"] = executorId;
		        	
		        	//执行人姓名
		        	var executor = $executor.text();
		        	
		        	params["content.executor"] = executor;

		        	$(".pm-task-remark-list>.pm-task-remark-item").each(function(){
		        		var remarkEach = new Object();
		        		remarkEach.id = $(this).find(".pm-edit-remark-task").attr("data-id");
		        		remarkEach.content = Utils.htmlEncode($(this).find(".pm-task-remark-content").html()); 
		        		remarkEach.createDate = $(this).find(".pm-task-remark-data").html();
		        		remarkEach.createRemarkUser = USER.name; 
		        		remarkEach.userId = executorId;
		        		remarks.push(remarkEach);
		        	});
		        	params["content.remark"] = JSON.stringify(remarks);
		        	var tagsStr = "";
		        	if($(".pm-new-tag-tag").size()>0){
		        		$(".pm-new-tag-tag").each(function(){
		        			var tagsStrOne = $(this).attr("data-tag-name");
		        			tagsStr = tagsStr + tagsStrOne+",";
		        		})
		        		tagsStr = tagsStr.substring(0,tagsStr.lastIndexOf(','));
		        	}
		        	params["content.tags"] = tagsStr;
		        	var follower = [];
		        	$(".pm-task-follower-tag").each(function(){
		        		var followerEach = new Object();
		        		followerEach.userId = $(this).find(".pm-close-follower-tag").attr("data-follower-id");
		        		followerEach.userName = $(this).find(".pm-close-follower-tag").attr("data-follower-name"); 
		        		follower.push(followerEach);
		        	});
		        	params["followers"] = JSON.stringify(follower);
		        	params["content.attachment"] = $(".tag-add-wrap").attr("_value");
		            if("" != $.trim(params["content.name"]) && $.trim(params["content.name"]).length <=200 ){ 
		            	PM.service.task.quickCreateTask(params,function(task){
		            		PM.project.taskList.searchAction();
		            		Utils.closeTaskDetailPanel();	//关闭新建任务面板
		            		$("#tabsLoading", window.parent.document).css("z-index","1");
		            	});
		            }else{
		            	$("#tabsLoading", window.parent.document).css("z-index","1");
		            	Utils.showMessage("任务名称不能为空或字数不能超过200", "error");
		            }
		        }),
		        $container.on("click", ".createMore",function() {//创建任务按钮点击事件
		        	$container.find(".task-detail-infos-wrap").show();
		        	$(this).hide();
		        	}),
		        $container.on("click","#B_ProAddTask_delete",function(){	//新建任务弹窗放弃按钮点击事件
		        	Utils.hidePop();
		        	Utils.closeTaskDetailPanel();
		        }),
		        $container.on("click","#B_ProAddTask_save",function(){	//新建任务弹窗保存按钮点击事件
		        	Utils.hidePop();
		        	$container.find(".pm-create-task").trigger("click");
		        }),
			$("#pm-task-info").delegate($(".close-popup"),"click",function(e){//当任务面板显示时点击以外的地方隐藏任务面板
				  var target = $(e.target);
				  if(target.closest("#W_deleteTask").length == 0 && target.closest("#attach_block").length == 0){//点击#W_deleteTask之外的地方触发
					  return Utils.hidePop();
				  }
			});

			$container.on("click", "#B_deleteTask",function() {//删除任务弹出层删除点击
	        	var taskId = PM.cache.currentEditTaskId;
	        	PM.service.task.removeTask(taskId,function(){
	        		//删除“任务”里的任务
	        		$("#pm-proj-list"+PM.cache.currentEditTask.level).find(".pm-proj-item[data-id='"+PM.cache.currentEditTaskId+"']").remove();
	        		//删除“项目”下的任务列表
	        		$("#pm-task-table-body2>tr[data-id='"+PM.cache.currentEditTaskId+"']").remove();
	        		PM.task.removeCalendarEvent(taskId);
	        		//修改总条数
	        		var $totalNum = $(".totalRowPanel").text().substr(5)-1;
	        		$(".totalRowPanel").text("总条数: " + $totalNum);
	        		$(".dx-task-close-btn").click();
	        	});
	        });
			$("#container").on("click", ".pm-edit-task",function() {//编辑任务名称
	            $("#pm-task-edit-name-cancle").click();
	            var name = PM.cache.currentEditTask.name;
	            $("#pm-task-name").html($("#tmplTaskNameEdit").tmpl({"name": name}));
	            $(".pm-task-edit-ipt").focus();
	        }),
			$("#container").on("click", "#pm-task-edit-name-cancle",function() {//取消编辑任务名称
				var name = PM.cache.currentEditTask.name;
	            $("#pm-task-name").html($("#tmplTaskNameBox").tmpl({"name": name}));
	        }),
	        $("#container").on("click", "#pm-task-edit-name-ok",function() {//保存任务名称
	        	var taskId = PM.cache.currentEditTaskId;
	        	PM.service.task.removeTask(taskId,function(){
	        		//删除“任务”里的任务
	        		$("#pm-proj-list"+PM.cache.currentEditTask.level).find(".pm-proj-item[data-id='"+PM.cache.currentEditTaskId+"']").remove();
	        		//删除“项目”下的任务列表
	        		$("#pm-task-table-body2>tr[data-id='"+PM.cache.currentEditTaskId+"']").remove();
	        		PM.task.removeCalendarEvent(taskId);
	        		$(".dx-task-close-btn").click();
	        	});
	        }).on("click", "#pm-task-executor-btn",function() {//显示修改执行者
	        	if(PM.cache.memberIdentity == 2){
					return false;
				}else{
		        	if($("#pm-task-proj-set").find(".pm-new-proj-tag").text() == ""){
		        		var url = contextPath + "/pm/selectUser.jsp";
		        		art.dialog.data("args",{
			        		parentObj: window,
							title: "选择用户",
							selectMode : 'selectOne',
							callback : function(result){
								
								if(result){
									var taskId = PM.cache.currentEditTaskId;
						        	var executorId = result[0].userId;
					        		var executorName = result[0].userName;
					        		$("#pm-task-executor-btn>span").text(executorName);
					        		PM.service.task.updateTaskExecutor(taskId, executorId, executorName, PM.task.updateTaskExecutorCall);
								}
							}
			        	});
			        	art.dialog.open(url,{
							width: 800,
							height: 500,
							title : "选择执行者"
			        	});
					}else{
						$(".pm-task-select-executor").show();
				        //执行者搜索功能
						$("#container input[name=search-task-executor]").bind("keydown",function(e) {
							var $cur = $(this);
							setTimeout(function(){
								var filter = $cur.val();
					    		var list = $(".pm-task-select-executor");
					    		if (filter) {
					    			$matches = $(list).find('a:Contains(' + filter + ')').parents('li');
					    			$('li', list).not($matches).hide();
					    			$matches.show();
					    		}else {
					    			$(list).find("li").show();
					    		}
							},1);
				    		//return false;
				    	});
					}
				}
	        }).on("click", ".select-executor-li",function() {//修改执行者
		        	var taskId = PM.cache.currentEditTaskId;
		        	var executorId = $(this).find("a").attr("_value");
	        		var executorName = $(this).text();
	        		$("#pm-task-executor-btn>span").text(executorName);
	        		$("#pm-task-executor-btn>span").attr("_value",executorId);
	        		if(PM.cache.openType == PM.TaskOpenType._edit){
		        		PM.service.task.updateTaskExecutor(taskId, executorId, executorName, PM.task.updateTaskExecutorCall);
		        	}
	        	}).on("change",".pm-task-date-input",function(e){//修改日期
	        		var $this = $(this);
	        		var type = $this.data("type");
	        		var value = $this.val();
	        		if(PM.cache.openType == PM.TaskOpenType._edit){	//打开面板，openType状态1,编辑;
			        	var taskId = PM.cache.currentEditTaskId;
			        	PM.service.task.simpleUpdateTask(taskId,type,value,function(task){
			        		PM.task.updateCalendarEvent(task);
			        		PM.task.refreshTaskList(task);
			        		Utils.dateInit(task.startDate,task.endDate);
			        		var nowDate = new Date();	
			        		var compares_overdue = $(".search-advance").find("select[name='search-task-overdue']").val();//过期
			        		if(compares_overdue == "OVERDUE"){
			    				if(!PM.daysCalc(nowDate,task.endDate)){
			    					var removeTaskEl = $(".row[data-id='"+task.id+"']");
									PM.cache.removeTaskEl = removeTaskEl;
			    				}
			    			}
			        	});
	        		}else{
	        			var startDate = $(".pm-task-date-input[data-type='startDate']").val();
	        			var endDate = $(".pm-task-date-input[data-type='endDate']").val();
	        			Utils.dateInit(startDate,endDate);
	        		}
	        }).on("mouseover",".pm-task-modify-time-item",function(e){	//显示日期清除按钮
	        	if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(this).find(".clear").css("display","");
				}
	        }).on("mouseleave",".pm-task-modify-time-item",function(e){	//隐藏日期清除按钮
	        	if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(this).find(".clear").css("display","none");
				}
	        }).on("click",".clear",function(e){	//清除日期
	        	if(PM.cache.openType == PM.TaskOpenType._edit){	//打开面板，openType状态1,编辑;
		        	var $this = $(this);
		        	$this.prev(".pm-task-date-input").val("");
		        	type = $this.prev(".pm-task-date-input").data("type"),
		        	value = $this.prev(".pm-task-date-input").val(),
		        	taskId = PM.cache.currentEditTaskId;
		        	PM.service.task.simpleUpdateTask(taskId,type,value,function(task){
		        		PM.task.updateCalendarEvent(task);
		        	});
	        	}else{	//打开面板，openType状态0,新建;
	        		var $this = $(this);
		        	$this.prev(".pm-task-date-input").val("");
	        	}
	        }).on("click","#pm-task-level-btn",function(e){	//打开提醒方式选择面板
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-select-box").hide();
					var $selectPanel = $(".pm-task-level-box");
					$selectPanel.html($("#tmplTaskLevelSelectPanel").tmpl({}));
					$selectPanel.show();
				}
			}).on("click",function(e){	//隐藏优先级 和 项目 下拉列表 和执行人下拉列表
				//优先级
				var $levelPanel = $(".pm-task-level-box");
				if($(e.target).closest("#pm-task-level-btn").size() == 0){
					$levelPanel.hide();
				}
				//项目
				var $projectPanel = $(".pm-proj-item-select");
				if($(e.target).closest("#pm-task-proj-set").size() == 0){
					$projectPanel.hide();
				}
				//执行人
				var $taskExecutor = $(".pm-task-select-executor");
				if($(e.target).closest("#pm-task-executor-btn").size() == 0 && $(e.target).closest(".pm-task-sousuo").size() == 0){
					$taskExecutor.hide();
				}
				//状态
				var $statusPanel = $(".pm-task-status-list");
				if($(e.target).closest("#pm-task-status-selector").size() == 0){
					$statusPanel.hide();
				};
				//关注人
				var $followerPanel = $(".pm-task-select-follower");
				if($(e.target).closest("#pm-task-add-follower-btn").size() == 0){
					$followerPanel.hide();
				};
			}).on("click","#pm-task-remind-btn",function(e){	//打开提醒方式选择面板
				$(".pm-task-select-box").hide();
				var $selectPanel = $(".pm-task-remind-box");
				$selectPanel.html($("#tmplTaskRemindSelectPanel").tmpl({}));
				$selectPanel.show();
			}).on("click",".pm-item-remind-item",function(e){	//提醒方式选项选中事件
				var taskId = PM.cache.currentEditTaskId;
				var value = $(this).data("value");
				PM.cache.target = this;
				PM.service.task.simpleUpdateTask(taskId,"remindMode",value,function(){
					$("#pm-task-remind-btn").html($(PM.cache.target).text());
					$(".pm-task-select-box").hide();
				});
			}).on("click",".pm-time-category-item",function(e){	//日期范围筛选
				$(".pm-time-category-item").removeClass("select");
				var $this = $(this),params = {};
				$this.addClass("select");
				params.dateRangeType = $this.data("type");
				params.status = $("#pm-task-status-text").data("status");
				params.currDate = $("#pm-task-tool-bar-search-current-date").val();
				params.name = "";//for test
				//向服务器查询数据&渲染任务列表
				PM.service.task.queryMyTasks(params,function(tasks){
					PM.task.render(tasks);
				});
			}).on("click",".pm-status-item",function(e){	//完成状态筛选
				var $this = $(this),params = {};
				var displayMode = $("#pm-task-display-mode").text();
				params.dateRangeType = $(".pm-time-category-item.select").data("type");
				params.status = $this.data("type");
				params.currDate = $("#pm-task-tool-bar-search-current-date").val();
				params.name = "";//for test
				//向服务器查询数据&渲染任务列表
				PM.service.task.queryMyTasks(params,function(tasks){
					PM.task.render(tasks);
				});
				$("#pm-task-status-text").text($this.text()).data("status",params.status);
				if(displayMode=="日历"){
					$("#pm-task-calendar-view").css("display","block");
					$(".pm-four-part").css("display","none");
					$("#header-datetime").hide();
					PM.task.renderCalendarView();
				}
			}).on("click",".pm-pro-item",function(e){	//项目切换
				var $this = $(this);
				var proid = $(this).data("type");
				var proname = $(this).text();
				
				$this.parents(".pm-project").find("#pm-task-project-text").text(proname)
				
				if(proid == "0"){
					$(".pm-proj-item").hide();
					$(".pm-proj-item[data-proid='']").show();
				}else if(proid == "-100"){
					$(".pm-proj-item").show();
				}else{
					$(".pm-proj-item").each(function(){
						if($(this).data("proid")!=proid){
							$(this).hide();
						}else{
							$(this).show();
						}
					})
				}
			}).on("click",".pm-task-display-mode-item",function(e){	//切换列表|日历视图
				var $this = $(this),
				displayMode = $this.data("type");
				switch(displayMode){
				case "list":
					$("#pm-task-calendar-view").css("display", "none");
		            $(".pm-four-part").css("display", "block");
		            $("#header-datetime").show();
					break;
				case "calendar":
					$("#pm-task-calendar-view").css("display","block");
					$(".pm-four-part").css("display","none");
					$("#header-datetime").hide();
					PM.task.renderCalendarView();
					break;
				}
		        $("#pm-task-display-mode").text($this.text());
			}).on("change","#pm-task-tool-bar-search-current-date",function(e){
				var $this = $(this),params = {};
				params.dateRangeType = $(".pm-time-category-item.select").data("type");
				params.status = $("#pm-task-status-text").data("status");
				params.currDate = $this.val();
				params.name = "";//for test
				//向服务器查询数据&渲染任务列表
				PM.service.task.queryMyTasks(params,function(tasks){
					PM.task.render(tasks);
				});
			}),
			
			

//##############################################任务-所属项目 开始###########################################################
			
			$container.on("click",".pm-close-proj-tag",function(e){//删除所属项目
				var id = PM.cache.currentEditTaskId;
				var projectId = $(this).data("projectId");
				PM.service.task.removeTaskProject(id,function(){
					$(".pm-proj-item-select").next().remove();
					$("#pm-task-proj-set-btn").show();
				});
				//删除项目是随之改变执行人队列，提示要先选择项目
				$(".pm-task-select-executor>ul>li").remove();
				$("#pm-task-executor").find(".pm-task-select-executor").find(".zhanwei").show();
			}),
			$container.on("click","#pm-task-proj-set-btn,.pm-proj-tag",function(e){//打开项目选择面板
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-select-box").hide();
					PM.service.task.getTaskProjectList(function(data){
						
						var $selectPanel = $(".pm-proj-item-select");
						$selectPanel.html($("#tmplProjectSelectPanel").tmpl({"projects":data}));
						$selectPanel.show();
					});
				}
			}),
			$container.on("click",".project-item",function(e){//所属项目选择面板->选中项目
				var taskId = PM.cache.currentEditTaskId;
				var projectId = $(this).data("id");
				var projectName = $(this).data("name");
				
				$(".pm-proj-item-select").next().remove();
				//删除项目是随之改变执行人队列，提示要先选择项目
				$(".pm-task-select-executor>ul>li").remove();
				if(PM.cache.openType == PM.TaskOpenType._edit){
					if(""!=$.trim(projectId)){
						PM.service.task.setTaskProject(taskId,projectId,projectName,function(task){
							$(".pm-proj-item-select").after($("#tmplTaskProjectItem").tmpl(task));
							$("#pm-task-proj-set-btn").hide();
							$(".pm-task-select-box").hide();
						});
					}
				}else if(PM.cache.openType == PM.TaskOpenType._new){
					var task = task || {};
					task["projectName"] = projectName;
					task["projectId"] = projectId;
					$(".pm-proj-item-select").after($("#tmplTaskProjectItem").tmpl(task));
					$("#pm-task-proj-set-btn").hide();
					$(".pm-task-select-box").hide();
				}
				//当改变所属项目后，执行人也随之改变
				$("#pm-task-executor").find(".pm-task-select-executor").find(".zhanwei").hide();//在任务那些会出现占位，需隐藏
				PM.project.taskList.randerPanelMemberList(projectId);
				e.stopPropagation();
			}),
//#################################################任务-所属项目 结束########################################################			
			
			
//##############################################任务-标签 开始###########################################################
			
			$("#container").on("click",".pm-close-tag-tag",function(e){//删除标签
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					var id = PM.cache.currentEditTaskId;
					var tagName = $(this).data("tagName");
					PM.cache.target = this;
					if(PM.cache.openType == PM.TaskOpenType._new){
						var $target = $(PM.cache.target);
						$target.parent().remove();
						if($("#pm-task-tag-set-btn").find(".pm-new-tag-tag").size()>0){
							$(".tagTips").hide();
						}else{
							$(".tagTips").show();
						}
					}else{
						PM.service.task.removeTaskTag(id,tagName,function(task){
							var $target = $(PM.cache.target);
							$target.parent().remove();
							if($("#pm-task-tag-set-btn").find(".pm-new-tag-tag").size()>0){
								$(".tagTips").hide();
							}else{
								$(".tagTips").show();
							}
							PM.task.refreshTaskList(task);
							var task_tags = task.tags;
							var compares_tag = $(".search-advance").find("select[name='search-task-tags']").val();//优先级
							if(compares_tag != null){
								var show = false;	//默认是不隐藏
								if(compares_tag.length){
									for(var i in compares_tag){
										for(var j in task_tags){
											if(compares_tag[i] == task_tags[j].name){
												show = true;
												break;
											}
										}
									}
								}
								if(!show){
									var removeTaskEl = $(".row[data-id='"+task.id+"']");
									PM.cache.removeTaskEl = removeTaskEl;
								}
							}
						});
					}
				}
				
			}),
			$("#container").on("click",".pm-task-tag-set-btn",function(e){//打开标签选择面板
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-select-box").hide();
					var changeProject = $("#pm-task-proj-set").find(".pm-close-proj-tag").attr("data-project-id");	//用户在修改面板改变项目的情况
					var params = {};
					params["projectId"] = PM.cache.currentProjectId;
					if(changeProject != PM.cache.currentProjectId){
						params["projectId"] = changeProject;
					}
					PM.service.task.getTagList(params,function(data){
						
						var tags = [],selectTagName = [];
						
						//过滤已选中的Tag
						$(".pm-close-tag-tag").each(function(){
							var tagName = $(this).data("tagName");
							selectTagName.push(tagName);
						});
						for(var i=0;i<data.length;i++){
							var f = true;
							for(var j=0;j<selectTagName.length;j++){
								if(data[i].name==selectTagName[j]){
									f = false;
									break;
								}
							}
							if(f){
								tags.push(data[i]);
							}
						}
						var $selectPanel = $(".pm-tag-item-select");
						$selectPanel.html($("#tmplTagSelectPanel").tmpl({"tags":tags}));
						$selectPanel.show();
					});
				}
			}),
			$("#container").on("click",function(e){//隐藏标签选择面板
				var $tagItem = $("#pm-tag-item-select");
				if($(e.target).closest(".pm-task-tag-set-btn").size() == 0){
					$tagItem.hide();
				}
			}),
			/*$("#container").on("click",".pm-task-new-tag",function(e){//标签选择面板->新建标签
				var tagName = $(this).prev().val();
				var tagHas = false;
				$("#pm-task-select-tag-list").find(".tag-name").each(function(){
					if($(this).text() == tagName){
						tagHas = true;
					}
				})
				if(""!=$.trim(tagName) && tagHas!=true){
					PM.service.task.createTag(tagName,function(tags){
						var $selectItem = $("#tmplTagSelectItem").tmpl(tags);
						$selectItem.appendTo($(".pm-task-tag-set-btn"));
						$selectItem.trigger("click");
					});
				}else{
					alert("标签名称错误或已存在!")
				}
			}),*/
			$("#container").on("click",".tag-item",function(e){//标签选择面板->选中标签
				var taskId = PM.cache.currentEditTaskId;
				var tagName = $(this).data("name");
				if(""!=$.trim(tagName)){
					if(PM.cache.openType == PM.TaskOpenType._new){
						var tag = {};
						tag["name"] = tagName;
						$(".pm-task-tag-set-btn").before($("#tmplTaskTagItem").tmpl(tag));
						$(".pm-task-select-box").hide();
						if($("#pm-task-tag-set-btn").find(".pm-new-tag-tag").size()>0){
							$(".tagTips").hide();
						}else{
							$(".tagTips").show();
						}
					}else{	//打开面板，openType状态1,编辑;
						PM.service.task.addTaskTag(taskId,tagName,function(task){
							$(".pm-new-tag-tag").remove();
							$(".pm-task-tag-set-btn").before($("#tmplTaskTagItem").tmpl(task.tags));
							$(".pm-task-select-box").hide();
							if($("#pm-task-tag-set-btn").find(".pm-new-tag-tag").size()>0){
								$(".tagTips").hide();
							}else{
								$(".tagTips").show();
							}
							PM.task.refreshTaskList(task);
											
						});
					}
				}
				e.stopPropagation();
			}),
//#################################################任务-标签 结束########################################################
			
			
			//##############子任务模块 开始###############
			$("#container").on("click", ".pm-new-task-son-btn",function(e){//添加子任务输入面板
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-edit-cancle").click();
					var div = $(".pm-new-task-son .pm-task-son-box");
					div.html($("#tmplAddSubTask").tmpl({
					    name: ""
					})),
					$(".pm-task-son-edit-ipt").focus();
				}
			 }),
			$("#container").on("blur", ".pm-task-son-edit-ipt",function(e){//备注失去焦点保存事件
				var $ta = $(".pm-task-son-edit-ipt");
				var taskId = PM.cache.currentEditTaskId;
				var subTaskId = $ta.data("id");
				var subTaskName = $ta.val();
				if(subTaskName.trim() != ""){
					if(typeof(subTaskId)=="undefined"){		//新建子任务后保存
						PM.service.task.createSubTask(taskId,subTaskName,function(subTask){
							$("#tmplSubTaskItem").tmpl(subTask).appendTo($(".pm-task-son-list"));
						});
					}else{	//更新子任务后保存
						PM.service.task.updateSubTask(taskId,subTaskId,subTaskName,function(subTask){
							PM.cache.currentEditSubTaskItem.find(".pm-task-son-name").html(subTask.name);
						});
					}
				}
				
				//子任务取消事件
				var div = $(".pm-new-task-son .pm-task-son-box");
				div.html('<div class="pm-new-task-son-btn">点击添加子任务</div>');
			}),
			
			$("#container").on("click",".pm-task-son-selector",function(e){//完成|重做子任务
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					var $this = $(this);
					var taskId = PM.cache.currentEditTaskId;
					var subTaskId = $this.data("id");
					if(!$this.hasClass("pm-task-son-hasselect")){//完成
						PM.service.task.complateSubTask(taskId,subTaskId,function(target){
							$this.addClass("pm-task-son-hasselect");
						});
					}else {//重做
						PM.service.task.redoSubTask(taskId,subTaskId,this,function(target){
							$(target).removeClass("pm-task-son-hasselect");
						});
					}
				}
			}),
			$("#container").on("click",".pm-edit-son-task",function(e){//编辑子任务
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					var $this = $(this);
					var taskId = PM.cache.currentEditTaskId;
					var subTaskId = $this.data("id");
					var subTaskName = $this.closest(".pm-task-son-box").find(".pm-task-son-name").html();
					$(".pm-task-edit-cancle").click();
					var div = $(".pm-new-task-son .pm-task-son-box");
					div.html($("#tmplAddSubTask").tmpl({
					    id: subTaskId,
					    name:subTaskName,
					    status :0
					})),
					PM.cache.currentEditSubTaskItem = $this.closest(".pm-task-son-box");
					$(".pm-task-son-edit-ipt").focus();
				}
			}),
			$("#container").on("click", ".pm-delet-son-task",function() {//删除子任务
	        	if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					Utils.showMask();
		        	var target = $(this).attr("data-target");
		        	PM.cache.currentEditSubTaskItem = $(this).closest(".pm-task-son-item");
		        	$("#B_deletesubTask").attr("idcard",$(this).data("id"));
		        	return $(target).show();
				}
	        }),
	        $("#container").on("click", "#B_deletesubTask",function() {//删除子任务弹出层删除点击
				var taskId = PM.cache.currentEditTaskId;
				var subTaskId = $(this).attr("idcard");
				PM.service.task.removeSubTask(taskId,subTaskId,function(){
					$(PM.cache.currentEditSubTaskItem).remove();
					return Utils.hidePop();
				});
	        }),
			$("#pm-task-info").delegate($(".close-popup"),"click",function(e){//当任务面板显示时点击以外的地方隐藏任务面板
				  var target = $(e.target);
				  if(target.closest("#W_deletesubTask").length == 0 && target.closest("#attach_block").length == 0){//点击#W_deleteTask之外的地方触发
					  return Utils.hidePop();
				  }
			});
			//##############子任务模块 结束###############
			
			//##############备注模块 开始###############
			$("#container").on("click", ".pm-new-task-remark-btn",function(e){//添加备注输入面板
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-edit-cancle").click();
					var div = $(".pm-task-new-remark .pm-task-remark-box");
					div.html($("#tmplAddRemark").tmpl({
					    content: ""
					})),
					$(".pm-task-remark-edit-ipt").focus();
				}
				
			 });
			 $("#container").on("blur", ".pm-task-remark-edit-ipt",function(e){//备注失去焦点保存事件
				 if(PM.cache.openType == PM.TaskOpenType._new){
					 var $ta = $(".pm-task-remark-edit-ipt");
					 var content = $ta.val();
					 if(content.trim() != ""){
						 if($ta.attr("data-id")){
							 PM.cache.currentEditRemarkItem.find(".pm-task-remark-content").html(content);
						 }else{
							 PM.service.task.createTaskId(function(data){
									var remarkId = data;
									var remark = new Object();
									remark.id = remarkId;
									remark.content = content ; 
									remark.createDate = Utils.getNowFormatDate(new Date(),"yyyy-MM-dd HH:mm"); 
									remark.createRemarkUser = USER.name; 
									remark.userId = USER.id;
									$("#tmplRemarkListItem").tmpl(remark).appendTo($(".pm-task-remark-list"));
								});
						 }
						 
					 }
				 }else{	//打开面板，openType状态1,编辑;
				 	var $ta = $(".pm-task-remark-edit-ipt");
					var taskId = PM.cache.currentEditTaskId;
					var remarkId = $ta.data("id");
					var content = $ta.val();
					if(content.trim() != ""){
						if(typeof(remarkId)=="undefined"){	//新建备注后保存
							PM.service.task.createRemark(taskId,content,function(remark){
								$("#tmplRemarkListItem").tmpl(remark).appendTo($(".pm-task-remark-list"));
							});
						}else{	//更新备注后保存
							PM.service.task.updateRemark(taskId,remarkId,content,function(remark){
								PM.cache.currentEditRemarkItem.find(".pm-task-remark-content").html(remark.content);
							});
						}
					}
					
				 }
				//备注取消事件
					var div = $(".pm-task-new-remark .pm-task-remark-box");
					div.html('<div class="pm-new-task-remark-btn">点击添加备注</div>');
				}),
			
			$("#container").on("click",".pm-edit-remark-task",function(e){//编辑备注
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					var $this = $(this);
					var taskId = PM.cache.currentEditTaskId;
					var remarkId = $this.data("id");
					var content = $this.closest(".pm-task-remark-box").find(".pm-task-remark-content").html();
					$(".pm-task-edit-cancle").click();
					var div = $(".pm-task-new-remark .pm-task-remark-box");
					div.html($("#tmplAddRemark").tmpl({
					    id: remarkId,
					    content:content
					})),
					PM.cache.currentEditRemarkItem = $this.closest(".pm-task-remark-box");
					$(".pm-task-remark-edit-ipt").focus();
				}
			}),
			$("#container").on("click",".pm-delet-remark-task",function(e){//删除备注
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					PM.cache.currentEditRemarkItem = $(this).closest(".pm-task-remark-item");
					var taskId = PM.cache.currentEditTaskId;
					var remarkId = $(this).data("id");
					if(PM.cache.openType == PM.TaskOpenType._new){
						PM.cache.currentEditRemarkItem.remove();
					}else{
						PM.service.task.removeRemark(taskId,remarkId,function(){
							PM.cache.currentEditRemarkItem.remove();
						});
					}
				}
			}),
			//##############备注模块 结束###############
			
//##############################################任务-关注者 开始###########################################################
			
			$("#container").on("click",".pm-close-follower-tag",function(e){//删除关注者
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					var id = PM.cache.currentEditTaskId;
					var followerId = $(this).data("followerId");
					var followerName = $(this).data("followerName");
					PM.cache.target = this;
					if(PM.cache.openType == PM.TaskOpenType._new){
						$(PM.cache.target).parent().remove();
						if($(".pm-task-followers").find(".pm-task-follower-tag").size()>0){
							$(".followerTips").hide();
						}else{
							$(".followerTips").show();
						}
					}else{
						PM.service.task.removeFollower(id,followerId,followerName,function(){
							$(PM.cache.target).parent().remove();
							if($(".pm-task-followers").find(".pm-task-follower-tag").size()>0){
								$(".followerTips").hide();
							}else{
								$(".followerTips").show();
							}
						});
					}
				}
			}),
			$("#container").on("click",".select-follower-li",function(e){//添加任务面板关注者
				var addFollowerId = jQuery(this).find("a").attr("_value");
				var flag = true;
				if($(".pm-task-followers .pm-task-follower-tag").size()>0){
					$(".pm-task-followers .pm-task-follower-tag").each(function(){
						 var useId = $(this).attr("data-follow-id");//已选的关注人的useId
						 if(addFollowerId == useId){
							 flag = false;
							 Utils.showMessage("该用户已是此任务的关注人！", "warning");
						 }
					});
				}
				if(flag){
					if(PM.cache.openType == PM.TaskOpenType._new){
						var follower = {};
						follower["userId"] = jQuery(this).find("a").attr("_value");
						follower["userName"] = jQuery(this).find("a").html();
						$("#pm-task-add-follower-btn").before($("#tmplTaskFollowerItem").tmpl(follower));
						if($(".pm-task-followers").find(".pm-task-follower-tag").size()>0){
							$(".followerTips").hide();
						}else{
							$(".followerTips").show();
						}
					}else{
						var follower = "[";
						follower+="{'memberType':'"+jQuery(this).find("a").attr("_memberType")+"',";
						follower+="'userId':'"+jQuery(this).find("a").attr("_value")+"',";
						follower+="'userName':'"+jQuery(this).find("a").html()+"'}";
						follower+="]";
						var id = PM.cache.currentEditTaskId;
						PM.service.task.addFollowers(id,follower,function(follower){
							//$("#followers-list >li>.pm-task-modify-item").prepend($("#tmplTaskFollowerItem").tmpl(follower));
							$("#pm-task-add-follower-btn").before($("#tmplTaskFollowerItem").tmpl(follower));
							if($(".pm-task-followers").find(".pm-task-follower-tag").size()>0){
								$(".followerTips").hide();
							}else{
								$(".followerTips").show();
							}
						});
					}
				}
				
			}),
			$("#container").on("click","#pm-task-add-follower-btn",function(e){//添加任务面板关注者
				if(PM.cache.memberIdentity == 2){
					return false;
				}else{
					$(".pm-task-select-follower").show();
				}
			}),
//#################################################任务-关注者 结束########################################################			
//#################################################任务-动态 开始########################################################			
			$("#container").on("click",".pm-task-logs-title",function(e){//打开动态详情
				var $downup = $(this).find(".down-up");
				if($downup.hasClass("fa-chevron-down")){
					$downup.removeClass("fa-chevron-down").addClass("fa-chevron-up");
				}else{
					$downup.removeClass("fa-chevron-up").addClass("fa-chevron-down");
				}
				
				$(this).parent().find(".logs-wrapper").toggle();
			}),
//#################################################任务-动态 结束########################################################			
			$("#container").on("click",".dx-task-close-btn",function(e){//关闭任务详细面板
				if(PM.cache.openType == PM.TaskOpenType._new){
					if("" !== $.trim($("#pm-task-info").find(".pm-task-detail").find(".pm-task-name").text())){ 
						Utils.showMask();
						$("#W_ProAddTask").show();
					}else{
						Utils.closeTaskDetailPanel();
					}
				}else{
					Utils.closeTaskDetailPanel();
					$(".pm-proj-item").removeClass("select");
					$("#pm-task-table-body2").find("tr").removeClass("rowBg");//当前的任务列表失去焦点
				}
			}),
            
            $("#B_AddTask").click(function(e){//日历视图下新建任务
				var name = $(this).parents(".popup-co").find("input").val(),
				startDate = $("#W_AddTask").data("date"),
				level = 0;//just for test
	            if("" != $.trim(name)){
	            	PM.service.task.quickCreateTask(
	            			{
			            		"content.name":Utils.htmlEncode(name),
			            		"content.level":level,
			            		"content.startDate":startDate,
			            		"content.endDate":startDate
	            			},
	            			function(task){
	            				PM.task.renderCalendarEvent(task);
	            				Utils.hidePop();
	            	});
	            }else{
	            	Utils.showMessage("任务名称不能为空或字数不能超过200", "error");
	            }
			})
			
		},
		/**
		 * 请求服务器修改执行人后的回调方法，更新页面相关内容
		 */
		updateTaskExecutorCall : function(task){
			$("#pm-task-executor-btn").html(task.executor);
			var $taskListRow = $("#pm-follow-task-table").find(".row[data-id='"+PM.cache.currentEditTaskId+"']");
			var searchExecutor = $(".skin-dwz").find("select[name='search-task-executor']").val();
			PM.task.refreshTaskList(task);
			
			if(searchExecutor != null){
				var show = false;
				if(searchExecutor.length){
					for(var i in searchExecutor){
						if(searchExecutor[i] == task.executorId){
							show = true;
							break;
						}
					}
				}
				if(!show){
					var removeTaskEl = $(".row[data-id='"+task.id+"']");
					PM.cache.removeTaskEl = removeTaskEl;
				}
			}else{
				$taskListRow.find(".project-title .executor").text("负责人 "+task.executor);
			}
			
			if(task.executorId != USER.id){
				$(".pm-four-part").find(".pm-proj-item[data-id='"+task.id+"']").remove();
			}
		},
		/**
		 * 修改任务面板的内容，实时更新
		 */
		refreshTaskList : function(task){
			var refreshTr = $("#tmplTaskTableListItem2").tmpl(task,{
    			getLevelText : function(){//获取优先级文本
    				switch (this.data.level) {
					case 0:
						return "<span class='LevelText level0'>不重要-不紧急</span>";
						break;
					case 1:
						return "<span class='LevelText level1'>不重要-很紧急</span>";
						break;
					case 2:
						return "<span class='LevelText level2'>很重要-不紧急</span>";
						break;
					case 3:
						return "<span class='LevelText level3'>很重要-很紧急</span>";
						break;
					default:
						return "<span class='LevelText'>无</span>"
						break;
					}
    			}
        		,
        		ifOverdue : function(){
        			if(this.data.status == '0' || this.data.status == '2' || this.data.status == '3'){
	        			var curDate = new Date();
	        			var endDate = this.data.endDate;
	        			if(endDate =="" || endDate == undefined){
	        				return false;
	        			}else{
	        				return PM.daysCalc(curDate,endDate);
	        			}
	        		}
        		}
    		})
    		var rowId = task.id;
    		var replaceTr = $(".row[data-id='"+rowId+"']");
			refreshTr.replaceAll(replaceTr);
		}, 
		/**
		 * 载入项目列表
		 */
		initProjectList : function(){
			var $taskProjectList = $(".pm-page-task .pm-tool-bar .pm-project").find("ul");
			PM.service.project.getProjectList({"status":"open"},function(projects){
				$.each(projects,function(){
					var projectId = this.id;
					var projectName = this.name;
					var taskProjectItem = "<li class='pm-droplist-item pm-pro-item' data-type='"+projectId+"' title='"+projectName+"'>"+projectName+"</li>"
					$taskProjectList.append(taskProjectItem);
				})
				var slimscrollHei = parseInt($(window).height()/2);
				if($taskProjectList.parents(".pm-droplist-option").height() > slimscrollHei){
					$taskProjectList.slimscroll({
						height:slimscrollHei
					});
				}
			});
		},
		/**
		 * 载入我的任务视图
		 */
		initMyTaskList : function(){
			//获取查询参数
			var params = {};
			params.dateRangeType = $(".pm-time-category-item.select").data("type");
			params.projectId = this.project.STATUS_DEFAULT;
			params.status = this.status.STATUS_DEFAULT;
			params.currDate = null;//for test
			params.name = "";//for test
			//向服务器查询数据&渲染任务列表
			PM.service.task.queryMyTasks(params,function(data){
				PM.task.render(data);
			});
		},
		/**
		 * 编辑任务（打开任务明细面板）
		 */
		edit : function(taskId,callback){
			PM.service.task.editTask(taskId,function(task){
				PM.cache.currentProjectId = task.projectId;
				$.each(task.logs.reverse(),function(){
					var logTxt = PM.operationType[this.operationType] + ": " 
						+ ((this.operationType == 104) ? PM.levelText(this.summary) : this.summary);
					this.logTxt = logTxt;
				});
				
				$("#pm-task-info").html($("#tmplTaskDetail").tmpl(task,{
					getRemindText : function(){//获取完成百分比
						if(this.data.remindMode==0){
							return "不提醒";
						}else if(this.data.remindMode==1){
							return "每天提醒";
						}else if(this.data.remindMode==2){
							return "每周提醒";
						}else if(this.data.remindMode==3){
							return "每两周提醒";
						}else if(this.data.remindMode==4){
							return "每月提醒";
						}
						return "";
					}}));
				Utils.openTaskDetailPanel();
				if(callback && typeof callback == "function"){
					callback();
				}
			});
		},
		
		/**
		 * 渲染任务视图
		 */
		render: function(tasks) {
	        tasks = tasks || PM.cache.tasks,
	        PM.task.renderFourPartView(tasks);
	    },
	    /**
	     * 渲染四方块任务视图
	     */
	    renderFourPartView : function(tasks){
	    	$(".pm-proj-list").empty(),
	        $.each(tasks,function() {
	            $("#tmplFourPartLi2").tmpl(this).appendTo("#pm-proj-list" + this.level);
	        });
	        Utils.resizeFourPart();
	    },
	    /**
	     * 渲染日历视图
	     */
	    renderCalendarView : function(){
	    	var height =  $(window).height() -54-10;
	    	$("#pm-task-calendar-view").fullCalendar("destroy");
	    	$("#pm-task-calendar-view").fullCalendar({
	    		header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month'//,agendaWeek'
				},
				height: height,
				lang: "zh-cn",
				buttonIcons: true,
				weekNumbers: false,
				allDaySlot: false,
				allDayDefault:true,
				editable: true,
				eventLimit: 6,
				nextDayThreshold: "09:00:00",
				/**
				eventLimit: {
			        'agenda': 5, // adjust to 6 only for agendaWeek/agendaDay
			        'default': true // give the default value to other views
			    },
			    **/
				eventClick: function(event){
					PM.cache.currentEditEvent = event;
					PM.task.edit(event.id);
				},
				dayClick : function(date,jsEvent,view) {
		            Utils.showMask();
		            $("#W_AddTask").data("date",date.format()).show().find("input").val("");
				},
				eventDrop :function( event, delta, revertFunc, jsEvent, ui, view ){
					PM.service.task.updateDate(event.id,delta._days);
				},
				eventResize: function( event, delta, revertFunc, jsEvent, ui, view )  {
					PM.service.task.updateEndDate(event.id,delta._days);
				},
				events: function(start, end, timezone, callback) {
					var params = {};
					params.dateRangeType = PM.task.dateRangeType.THISMONTH;
					params.status = $("#pm-task-status-text").data("status");
					params.startDate = start.format();
					params.endDate = end.format();
					params.name = "";//for test
					PM.service.task.queryMyTasks4CalendarView(params,function(tasks){
						var events =[];
				    	//把任务集合转换为Calendar的Event对象
				    	$.each(tasks,function(i,task){
				    		var event = PM.task.convertTask2Event(task);
				    		events.push(event);
				    	});
				    	callback(events);
					});
				}
	    	});
	    },
	    /**
	     * 任务对象转换成日历的事件对象
	     */
	    convertTask2Event : function(task){
	    	var event = null;
	    	if(PM.cache.currentEditEvent && PM.cache.currentEditEvent.id==task.id){
	    		event = PM.cache.currentEditEvent;
	    		event.title = task.name;
	    		event.start = task.startDate;
	    		event.end = task.endDate;
	    	}else{
	    		event =  {title:task.name,start:task.startDate,end:(task.endDate)};
	    	}
	    	
	    	//结束时间加一天以便日历视图结束时间与设置的结束时间相符
	    	var fixEnd = new Date(event.end);
	    	fixEnd = new Date(fixEnd.setDate(fixEnd.getDate()+1)); 
	    	
	    	if (fixEnd.getMonth()+1 >= 10){ 
	    		event.end = fixEnd.getFullYear()+"-"+(fixEnd.getMonth()+1);
			}else{ 
				event.end = fixEnd.getFullYear()+"-0"+(fixEnd.getMonth()+1);
			} 
	    	
	    	if (fixEnd.getDate() >= 10){ 
	    		event.end += "-"+fixEnd.getDate();
			}else{ 
				event.end += "-0"+fixEnd.getDate();
			} 
	    	
    		switch(task.level){
    		case 0:
    			event.color = "#8fc842";
    			break;
    		case 1:
    			event.color = "#56a8e7";
    			break;
    		case 2:
    			event.color = "#fdaa29";
    			break;
    		case 3:
    			event.color = "#e25f36";
    			break;
    		}
    		$.extend(event,task);
    		return event;
	    },
	    /**
	     * 渲染(新增)日历视图的任务
	     */
	    renderCalendarEvent: function(task){
	    	var event = PM.task.convertTask2Event(task);
			$("#pm-task-calendar-view").fullCalendar("renderEvent",event,true);
	    },
	    /**
	     * 更新日历视图的任务
	     */
	    updateCalendarEvent: function(task){
	    	var event = PM.task.convertTask2Event(task);
			$("#pm-task-calendar-view").fullCalendar("updateEvent",event);
	    },
	    /**
	     * 删除日历视图的任务
	     */
	    removeCalendarEvent: function(id){
	    	$("#pm-task-calendar-view").fullCalendar("removeEvents",id);
	    }
	    
	},
	//############ 任务模块结束###################
	
	//############ 关注模块开始###################
	/**
	 * 关注模块
	 */
	follow : {
		
		/**
		 * 初始化
		 */
		init : function() {
			this.bindEvent();
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			$("#pm-task-table-body").on("click","#pm-task-unfollow-btn",function(e){//取消关注
				var taskId = $(this).data("id");
				PM.cache.target = this;
				PM.service.follow.unfollow(taskId,function(){
					$(PM.cache.target).closest("tr").remove();
				});
			}),
			$("#pm-task-table-body").on("click",".row",function(e){
				//Utils.closeTaskDetailPanel();
				var $this = $(this);
				var id = $this.data("id");
				//PM.service.task.editTask(id,Utils.openTaskDetailPanel);
				
				
				//var id = $this.parent().data("id");
				
				PM.task.edit(id,function(){
					//$this.parent().addClass("select");
				});
				e.stopPropagation();
				
			});
			$("#pm-task-table-body2").on("click",".row",function(e){
				PM.cache.openType = PM.TaskOpenType._edit;
				var $this = $(this);
				var id = $this.data("id");
				$this.addClass("rowBg").siblings().removeClass("rowBg");//点击当前的任务列表获得焦点
				PM.task.edit(id,function(){
					//$this.parent().addClass("select");
					PM.project.taskList.randerPanelMemberList(PM.cache.currentProjectId,"noFollower");
					PM.project.taskList.randerPanelFollowerList(PM.cache.currentProjectId,"");
				});
				$('.skin-h5 .open .dropdown-toggle').dropdown('toggle') //隐藏打开的筛选条件下来菜单
				e.stopPropagation();
			});
			
		},
		/**
		 * 渲染关注页面
		 */
		renderFollowPage : function() {
			PM.service.follow.queryMyFollowTasks({},function(tasks){
				$("#pm-task-table-body").html($("#tmplTaskTableListItem").tmpl(tasks,{
					getLevelText : function(){//获取优先级文本
						switch (this.data.level) {
						case 0:
							return "不重要不紧急";
							break;
						case 1:
							return "不重要紧急";
							break;
						case 2:
							return "重要不紧急";
							break;
						case 3:
							return "重要紧急";
							break;
						default:
							return "无"
							break;
						}
						
					}
				}));
			});
		},
		/**
	     * 取消关注
	     */
	    unfollow : function(taskId){
	    	var result = PM.service.follow.unfollow(taskId);
	    	alert(result);
	    	return result;
	    }
	},
	
	/**
	 * 动态模块
	 */
	activity : {
		/**
		 * 初始化
		 */
		init : function() {
			this.bindEvent();
		},
		/**
		 * 绑定事件
		*/
		bindEvent : function() {
			
		},
		/**
		 * 渲染动态界面
		 */
		renderActivityPage : function(){
			var params = {};
			params.range = "all";//for test
			PM.service.activity.queryActivities(params,function(activities){
				if(activities == ""){
					$(".pm-activity-content").html('<div id="content-space">'
					+'<table height="100%" width="100%" border="0"><tbody>'
					+'<tr><td align="center" valign="middle">'
					+'<div class="content-space-pic iconfont-h5">&#xe050;</div>'
					+'<div class="content-space-txt text-center">暂无数据</div>'
					+'</td></tr></tbody></table></div>');
				}else{
					$(".pm-activity-content").empty();
					var currentDate = "";
					$.each(activities,function(i,activity){
						var d = activity.operationDate.split(" ");
						if(d[0] != currentDate){
							$("#tmplActivityPart").tmpl({"operationDate":d[0]}).appendTo($(".pm-activity-content"));
						}
						var item ={};
						item.userName = activity.userName;
						item.operationDate = activity.operationDate;
						item.operationTime = d[1];
						if(activity.operationType==100){
							item.operationType = "创建了任务";
						}else if(activity.operationType==102){
							item.operationType = "完成了任务";
						}else if(activity.operationType==103){
							item.operationType = "重做了任务";
						}
						item.summary = activity.taskName;
						
						$("#tmplActivityItem").tmpl(item).appendTo($("#data-part-"+d[0]));
						
						currentDate = d[0];
						
					});
				}
			});
		}
		
	},
	
	//############ 关注模块结束###################
	
	//############ 任务日志 #####################
	operationType : {
		//任务
		100:'创建任务',
		101:'完成任务',
		102:'重做任务',
		103:'更新任务名称',
		104:'更新任务优先级',
		105:'更新任务提醒方式',
		106:'更新任务描述',
		109:'更新任务开始日期',
		110:'更新任务截止日期',
		111:'更新任务执行人',
		112:'更新状态',
		//子任务
		200:'创建子任务',
		201:'完成子任务',
		202:'重做子任务',
		203:'删除子任务',
		204:'更新子任务',
		//备注
		300:'创建备注',
		301:'删除备注',
		302:'更新备注',
		//关注人
		400:'添加关注人',
		401:'删除关注人',
		402:'关注任务',
		403:'取消关注任务',
		//项目
		500:'创建项目',
		501:'删除项目',
		//标签
		600:'创建标签',
		601:'删除标签'
	},
	/**
	 * 任务打开类型
	 */
	TaskOpenType : {
		_new : 0,	//新建0
		_edit :1	//编辑(详情)1
	},
	/**
	 * 缓存对象
	 */
	cache : {
		
		target : null,//事件发起对象
		currentEditTask : null,//当前编辑的任务
		currentEditTaskId : "",//当前编辑的任务主键
		currentEditSubTaskItem : null,//当前编辑的子任务
		currentEditRemarkItem : null,//当前编辑的任务备注
		currentEditEvent : null,//当前编辑的日历视图事件（任务）
		currentProjectId : "",//当前项目ID
		removeTaskEl:null,	//
		memberIdentity: "",	// 当前用户的项目成员类型
		openType: 1 	//打开面板，openType状态1,编辑;
	},
	/**
	 * 项目成员类型
	 */
	MemberType :{
		regular : 0,//参与者
		manager : 1,//管理员
		follower : 2//关注人,无法进行新建任务、编辑任务操作
	},
	/**
	 * 计算时间差
	 * @param date,date2
	 */
	daysCalc : function(curDate,endDate){
		/*curDate
		 * 当前时间国际时间
		 * endDate
		 * 任务结束时间YYY-MM-DD
		 * */
	    var curtime = new Date (curDate.getFullYear(),curDate.getMonth(),curDate.getDate());
		var _curtime = curtime.getTime();
	    var arrs = endDate.split("-");
	    var endtime = new Date(arrs[0], arrs[1]-1, arrs[2]);
	    var _endtime = endtime.getTime();
	    if (_curtime > _endtime) {
	        return true;
	    }
	    else{
	    	return false;
	    }

	},
	levelText : function(levelNum){
		
		if(typeof levelNum === "string"){
			levelNum = parseInt(levelNum);
		}
		switch (levelNum) {
		case 0:
			return "不重要不紧急";
			break;
		case 1:
			return "不重要紧急";
			break;
		case 2:
			return "重要不紧急";
			break;
		case 3:
			return "重要紧急";
			break;
		default:
			return "无"
			break;
		}
	}
};

