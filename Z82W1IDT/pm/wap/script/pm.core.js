/**
 * PM 核心类
 * <p>
 * 封装PM应用层界面渲染与交互行为
 * </p>
 * 
 * @author Happy
 */
var PM = {
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
		this.task.init();
		this.project.init();
	},
	/**
	 * 绑定事件
	 */
	bindEvent : function() {
		// 导航栏单击事件绑定
	    PM.task.randerBigTaskPage();

        var $newtask = $('.divfooter.divfooter-newTask');
        var $TaskList = $('.divfooter.divfooter-TaskList');
        var $Project = $('.divfooter.divfooter-Project');
        var $animate = $('.container.js_container.pm_animated');

		$("#newTask").on('click',function(){
            $newtask.siblings(".active").removeClass("active");
            $TaskList.siblings(".active").removeClass("active");
            $Project.siblings(".active").removeClass("active");
            if(!$newtask.hasClass("active")){
                $newtask.addClass("active");
                $animate.addClass("pm_fadeInUp");
                setTimeout(function(){
                    $animate.removeClass("pm_fadeInUp");
                },1000)
            }
            window.location.hash="#/tpl_task-create";

		});
        $("#TaskList").on('click',function(){
            $newtask.siblings(".active").removeClass("active");
            $TaskList.siblings(".active").removeClass("active");
            $Project.siblings(".active").removeClass("active");
            if(!$TaskList.hasClass("active")){
                $TaskList.addClass("active");
                $animate.addClass("pm_fadeInUp");
                setTimeout(function(){
                    $animate.removeClass("pm_fadeInUp");
                },1000)
            }
            window.location.hash="#/tpl_task-list";
        });
        $("#Project").on('click',function() {
            $newtask.siblings(".active").removeClass("active");
            $TaskList.siblings(".active").removeClass("active");
            $Project.siblings(".active").removeClass("active");
            if (!$Project.hasClass("active")) {
                $Project.addClass("active");
                $animate.addClass("pm_fadeInUp");
                setTimeout(function(){
                    $animate.removeClass("pm_fadeInUp");
				},1000)
            }
            window.location.hash = "#/tpl_project-list";
        });
	},

	/**
	 * 任务模块
	 */
	task : {
		
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
			var $container = $("#container");
			
			//新建任务时项目查询
			$container.on('keydown', '.tpl_task-create #search_input', function (e) {
				if (e.keyCode == 13) {
					//alert(2);
					//PM.project.searchProjectAction();
					PM.task.searchTaskProject();
					return false;
				}
			})
			//任务列表查询
			$container.on('focus', '#search_input', function () {
				var $weuiSearchBar = $('#search_bar');
				$weuiSearchBar.addClass('weui_search_focusing');
			}).on('blur', '#search_input', function () {
				var $weuiSearchBar = $('#search_bar');
				$weuiSearchBar.removeClass('weui_search_focusing');
				if ($(this).val()) {
					$('#search_text').hide();
				} else {
					$('#search_text').show();
				}
			}).on('input', '#search_input', function () {
				var $searchShow = $("#search_show");
				if ($(this).val()) {
					$searchShow.show();
				} else {
					$searchShow.hide();
				}
			}).on('touchend', '#search_cancel', function () {
				$("#search_show").hide();
				$('#search_input').val('');
			}).on('touchend', '#search_clear', function () {
				$("#search_show").hide();
				$('#search_input').val('');
			});
			
			//任务列表搜索
			$container.on('keydown', '.tpl_task-list #search_input', function (e) {
				if (e.keyCode == 13) {
					PM.project.taskList.searchAction();
					return false;
				}
			});
		
			$container.on('click', '.search-box-filter-item', function (){
				Utils.controlPlaceholder("hide");
	    		var $masks = $container.find(".task-list-box-masks");
			    var $this = $(this);
			    var filter = $this.data("filter");
			    if(filter == "all"){
			    	$this.addClass("active").siblings().removeClass("active");
			    	$this.find(".fa-right").removeClass("fa-caret-up").addClass("fa-caret-down");
			    	$this.siblings().find(".fa-right").removeClass("fa-caret-down").addClass("fa-caret-up");
			    	$(".tpl_task-list .panel-right-reset").click();
			    	PM.project.taskList.searchAction();
			    }else if(filter == "filter"){
			    	$this.addClass("active").siblings().removeClass("active");
			    	$this.find(".fa-right").removeClass("fa-caret-up").addClass("fa-caret-down");
			    	$this.siblings().find(".fa-right").removeClass("fa-caret-down").addClass("fa-caret-up");
			    	var $filterBox = $container.find(".search-box-filter");
			    	var $filterPanel = $container.find(".search-panel-filter");
			    	$filterBox.addClass("active");
			    	
		    		$filterPanel.addClass("active");
	    			$this.attr("_show","true");
	    			$masks.css("z-index","10");
	    			$masks.fadeIn("fast");
			    }
			    
			});
			//右侧面板筛选
			/*筛选项目*/
			$container.on('click', '.tpl_task-list .panel-project>span', function (){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
					$(".tpl_task-list").find("input[name='projectId']").val("");
				}else{
					$(this).addClass("active").siblings().removeClass("active");
					$(".tpl_task-list").find("input[name='projectId']").val($(this).attr("data-id"));
				}
				
			});
			/*筛选状态*/
			$container.on('click', '.tpl_task-list .panel-status>span', function (){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
					$(".tpl_task-list").find("input[name='status']").val("");
				}else{
					$(this).addClass("active").siblings().removeClass("active");
					$(".tpl_task-list").find("input[name='status']").val($(this).attr("data-status"));
				}
			});
			/*筛选时间范围*/
			$container.on('click', '.tpl_task-list .panel-date>span', function (){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
					$(".tpl_task-list").find("input[name='dateRange']").val("");
				}else{
					$(this).addClass("active").siblings().removeClass("active");
					$(".tpl_task-list").find("input[name='dateRange']").val($(this).attr("data-date"));
				}
			});
			/*筛选标签*/
			$container.on('click', '.tpl_task-list .panel-tag>span', function (){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
					$(".tpl_task-list").find("input[name='tag']").val("");
				}else{
					$(this).addClass("active").siblings().removeClass("active");
					$(".tpl_task-list").find("input[name='tag']").val($(this).attr("data-name"));
				}
			});
			/*筛选优先级*/
			$container.on('change', '.tpl_task-list input[name="content.level"]', function (){
				$(".tpl_task-list").find(this).addClass("active").parents(".task-rank-label").siblings().find("input[name='content.level']").removeClass("active");
			});
			/*筛选面板取消筛选*/
			$container.on('click', '.tpl_task-list .panel-right-reset', function (){
				$(".tpl_task-list .panel-project>span").removeClass("active");
				$(".tpl_task-list").find("input[name='projectId']").val("");
				$(".tpl_task-list .panel-status>span").removeClass("active");
				$(".tpl_task-list").find("input[name='status']").val("");
				$(".tpl_task-list .panel-date>span").removeClass("active");
				$(".tpl_task-list").find("input[name='dateRange']").val("");
				$(".tpl_task-list .panel-tag>span").removeClass("active");
				$(".tpl_task-list").find("input[name='tag']").val("");
				$(".tpl_task-list input[name='content.level']").removeClass("active").attr("checked",false);
				$(".tpl_task-list .executor").click();
			});
			/*筛选面板确定筛选*/
			$container.on('click', '.tpl_task-list .panel-right-submit', function (){
				PM.project.taskList.searchAction();
				$(".tpl_task-list .task-list-box-masks").click();
			});
			$container.on('click', '.tpl_task-list .task-list-box-masks', function (){
        		var $masks = $container.find(".task-list-box-masks");
	    		$container.find(".search-panel-filter").removeClass("active");
        		$container.find(".search-box-filter-item[_show='true']").attr("_show","false");
        		$masks.css("z-index","1");
        		$masks.fadeOut("fast");
        	});
			//详情页面完最新动态点击事件
			$(".container").on('click', '.task-info .trigger-task-news', function () {
				$(this).toggleClass("task-news-bottom");
			});
			//详情页面完成任务点击事件
			$(".container").on('click', '.task-info #task-edit-btn-complate', function () {
				$.confirm("确认完成此任务？", function() {
					PM.service.task.complateTask(PM.cache.currentEditTaskId,function(){
						window.location.href='#/tpl_task-msg:2';
						var time = 4;
						var jishu = setInterval(function(){  
							$(".tpl_task-msg").find(".jump-homepage").text(time);
							time = --time;
							if(time==-1){
								clearInterval(jishu);
								if(isWeiXin()){ 
									WeixinJSBridge.invoke('closeWindow',{},function(res){
										//alert('关闭微信页面');
									});
								}else{
									window.location.href='index.jsp#/'
								}
							}
						},1000);
					});
				}, function() {
				//点击取消后的回调函数
				});
		    });
			
			//上传附件按钮			
			$(".container").on('click',"#showActionSheet",function () {
				if(isAndroid){
					location.hash = "#/popUpLayer";
					var mask = $('#mask');
			        var weuiActionsheet = $('#weui_actionsheet');
			        weuiActionsheet.addClass('weui_actionsheet_toggle');
			        mask.show().addClass('weui_fade_toggle').click(function () {
			        	PM.task.hideActionSheet(weuiActionsheet, mask);
			        });
			        $('#actionsheet_cancel').click(function () {
			        	PM.task.hideActionSheet(weuiActionsheet, mask);
			        });
			        weuiActionsheet.unbind('transitionend').unbind('webkitTransitionEnd');
				}else{
					//$("#fileupload_input").trigger("click");
					$("#filePicker").find("input").trigger("click");
				}
		    });

			//图片附件预览图
			$(".container").on('click',".task-attachment-pic",function () {
				var _hash = location.hash.slice(1);
				var datas = {};
				var $viewImgUrl = $(this).attr("_url");
				var $imgId = $(this).attr("_id");
				datas = {
						'imgUrl':$viewImgUrl,
						'id':$imgId,
						'backhash':_hash	//有两种状态下去预览图片：1、新建，2编辑
				}
				var tmpl = template("tpl_task-pic", datas);
				$("#template_task-pic").html(tmpl);//临时存放有图片的模板
				window.location.hash="#/tpl_task-pic";				
			});
			
			//图片附件预览退出
			$(".container").on('click',".task-attachment-view-close",function () {
				$("#template_task-pic").html("");//临时存放的内容删除
				window.history.back();
			});
			
			//图片附件预览删除
			$(".container").on('click',".task-attachment-view-delect",function (obj) {
				$.confirm("确认删除？", function() {
					var delectHash = $(obj.target).attr("_hash");
					var delectID = $(obj.target).attr("_id");
					
					//$(this).parents(".task-attachment-view").hide();
					$(".page").find(".task-attachment").find("li[_id='"+delectID+"']").remove();
					
					if($(".page").find(".task-attachment").find(".task-attachment-li").size()<=0){
						$(".page").find(".task-attachment").css("padding","0px");
					}

					if(delectHash=="/tpl_task-create"){
		  	 			attachmentVal = $("#form-create-task-attachment").val();
		  	 		}else{
		  	 			attachmentVal = $("#form-edit-task-attachment").val();
		  	 		}
		  	 		if(attachmentVal!=""){
		  	 			var attachmentJson = JSON.parse(attachmentVal);
		  	 		}else{
		  	 			var attachmentJson = {};
		  	 		}
					$.each(attachmentJson,function(i){
						if(this.id == delectID){
							delete attachmentJson[i];
							if(delectHash=="/tpl_task-create"){
								$("#form-create-task-attachment").val(JSON.stringify(attachmentJson));
				  	 		}else{
				  	 			$("#form-edit-task-attachment").val(JSON.stringify(attachmentJson));
				  	 		}
						}
					})
					
					//history.go(-1);
					$(".page.task-pic").remove();
				}, function() {
				//点击取消后的回调函数
				});
			});

			//微信录音开始
			$(".container").on('click',"#startRecord",function () {
				location.hash = "#/popUpLayer";
				var $recordID = $(this).attr("_href");
				var soundNum = 0;
				$("#sound-button").show();
				$("#" + $recordID).show();
				
				var _wx = top.wx ? top.wx : wx;
				timer = _getTimer();
				setTimeout(function(){// 延时触发微信jsapi的startRecord接口，直接执行会导致执行失败。
					$("#" + $recordID).addClass("active");
					$("#" + $recordID).find(".record-play-ico").addClass("animate-play");
					_wx.startRecord();
					_wx.onVoiceRecordEnd({
						// 录音时间超过一分钟没有停止的时候会执行 complete 回调
						complete: function (res) {
							//把遮罩层去掉
							if(window.location.hash == "#/popUpLayer"){
								history.go(-1);
							}
							$("#" + $recordID).removeClass("active");
							var localId = res.localId;
							PM.task.uploadVoice(res.localId);
						}
					});
				},1);
			})
						
			//停止录音
			$(".container").on('click',"#stopRecord",function (e) {
				var recordTime = parseInt($(".time-total").text());
				var $recordID = $(this).attr("_href");
				$("#" + $recordID).removeClass("active");
				setTimeout(function(){
					if(window.location.hash == "#/popUpLayer"){
		         		history.go(-1);
		         	}
					$("#" + $recordID).hide();
				},250);
				var _wx = top.wx ? top.wx : wx;
				_wx.stopRecord({
					success: function (res) {
						clearInterval(timer);
						PM.task.uploadVoice(res.localId);
				    }
				});
				
			})
			//播放录音
			$(".container").on("click","#playVoice",function(){
				var $playVoice = $(".container").find("#playVoice");
				var localId = $(".container").find("#localId").val();
				var serverId = $(".container").find("#serverId").val();
				var _wx = top.wx ? top.wx : wx;
			    _wx.playVoice({
			    	localId: localId, // 需要播放的音频的本地ID，由stopRecord接口获得
			    	success : function(){
			    		$playVoice.find(".sound-play-ico").css({"visibility":"hidden","-webkit-animation":"sound-play-ico 1000ms steps(1) infinite","background-postion-x":"0px 0px"})
			    	}
			    });
			    _wx.onVoicePlayEnd({
			    	serverId: serverId, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
			    	success: function (res) {
			    	var localIds = res.localId; // 返回音频的本地ID
			    	$playVoice.find(".sound-play-ico").css({"visibility":"visible","-webkit-animation":"initial","background-postion-x":"-48px 0px"});
			    	}
			    });
			});
			//删除录音
			$(".container").on("click","#sound-play-box .btn-sound-delete",function(){
				$.confirm("确认删除？", function() {
					if(location.hash=="#/tpl_task-create"){
		  	 			attachmentVal = $("#form-create-task-attachment").val();
		  	 		}else{
		  	 			attachmentVal = $("#form-edit-task-attachment").val();
		  	 		}
		  	 		if(attachmentVal!=""){
		  	 			var attachmentJson = JSON.parse(attachmentVal);
		  	 		}else{
		  	 			var attachmentJson = {};
		  	 		}
					$.each(attachmentJson,function(i){
						if(this.time){
							delete attachmentJson[i];
							if(location.hash=="#/tpl_task-create"){
								$("#form-create-task-attachment").val(JSON.stringify(attachmentJson));
				  	 		}else{
				  	 			$("#form-edit-task-attachment").val(JSON.stringify(attachmentJson));
				  	 		}
						}
					})
					if(location.hash=="#/tpl_task-create"){
						$(".tpl_task-create").find('#sound-play-box').hide();
						$(".tpl_task-create").find(".btn-record").show();
		  	 		}else{
		  	 			$(".tpl_task-edit").find('#sound-play-box').hide();
		  	 			$(".tpl_task-edit").find('#sound-play-box').find("audio").remove();
		  	 			$(".tpl_task-edit").find(".btn-record").show();
		  	 		}
					
					$(".time-total").text("0");
					
				}, function() {
				//点击取消后的回调函数
				});
			});
			
			//拍照按钮
			$(".container").on('click',"#takephoto",function () {
				
				var oField = jQuery("#onlinePhoto")
				var _wx = top.wx ? top.wx : wx;
					_wx.chooseImage({
						count: 1, // 默认9
						sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
						sourceType: ALBUM? ['album','camera']:['camera'],
				    	success: function (res) {
				    		var localIds = res.localIds;
				    		setTimeout(function(){
				    			_wx.uploadImage({
						        localId: localIds[0],
						        success: function (res) {
						        	PM.task.hideActionSheet($('#weui_actionsheet'), $('#mask'));
						        	var serverId = res.serverId;
									// 本地上传方法
						        	$.get(contextPath+"/portal/weixin/jsapi/PMupload.action",{"serverId":serverId,"taskid":PM.cache.currentEditTaskId},function(result){
							        	if(result.status==1){
							        		var takePhotoLiTmp = '<li class="task-attachment-li task-attachment-li-status weui_uploader_status task-attachment-pic"><img width="64px"/><div class="task-attachment-li-content"></div></li>';
											var uploadError = '<i class="weui_icon_warn"></i>';
											var loadding = '<div class="weui_uploader_status_content"><i class="fa fa-spinner"></i></div>'
											var $takePhotoLi;
											$takePhotoLi = $(takePhotoLiTmp);
											$takePhotoLi.append($(loadding));
									    	$(".task-attachment").css("padding","10px");
									    	$(".task-attachment").find(".task-attachment-ul").append($takePhotoLi);
									    	$takePhotoLi.find("img").attr("id",result.data.id);
									    	$takePhotoLi.find("img").attr("src","../../"+result.data.url.replace(new RegExp("\\\\","g"),"/"));
									    	//$takePhotoLi.css("background-image","url(../../"+result.data.url.replace(new RegExp("\\\\","g"),"/")+")");
									    	$takePhotoLi.attr("_id",result.data.id);
									    	$takePhotoLi.attr("_url","../../"+result.data.url.replace(new RegExp("\\\\","g"),"/"));
									 		if(location.hash=="#/tpl_task-create"){
									 			attachmentVal = $("#form-create-task-attachment").val();
									 		}else{
									 			attachmentVal = $("#form-edit-task-attachment").val();
									 		}
									 		if(attachmentVal!=""){
									 			var attachmentJson = JSON.parse(attachmentVal);
									 		}else{
									 			var attachmentJson = {};
									 		}
									 		attachmentJson[result.data.id] = {"id":result.data.id,"name":result.data.name,"url":result.data.url};
									 		if(location.hash=="#/tpl_task-create"){
									 			$("#form-create-task-attachment").val(JSON.stringify(attachmentJson));
									 		}else{
									 			$("#form-edit-task-attachment").val(JSON.stringify(attachmentJson));
									 		}
											//upload_exist_init(taskId);
											$takePhotoLi.find(".task-attachment-li-content").remove();
											$takePhotoLi.removeClass("task-attachment-li-status");
											var timer = setInterval(function() {
								                if (document.getElementById(result.data.id).complete) {
								                	$takePhotoLi.removeClass("weui_uploader_status");//删除loadding遮罩
								                	$takePhotoLi.find(".weui_uploader_status_content").remove();//删除loadding
								                	$takePhotoLi.addClass("upload-state-done");//增加完成标志
								                    clearInterval(timer);
								                }
								            }, 50)
											
							        	}
							    	});
						       	},
						        fail: function (res) {
						          alert("网络异常，请再次尝试！");
						        }
						      });
				        }, 100)
				      }
				});
			});
			
			//新建任务按钮
			$(".container").on('click',".task-create #form-create-task-btn-submit",function(e) {
				if($("#form-create-task-name").val()==""){
					alert("任务内容不能为空，请先填写任务内容。");
				}else{
					$(this).attr("disabled","disabled");
					var nowDate = new Date();
			    	var startDate = "" + nowDate.getFullYear() + "-";
			    		startDate += (nowDate.getMonth()+1) + "-";
			    		startDate += nowDate.getDate();
					var level = $(".task-rank").find(".weui_check:checked").data("level");
					var formDataArr = $("#form-create-task").serializeArray();
					var taskId = PM.cache.currentEditTaskId;
					var params = {"content.id":taskId,"content.startDate":startDate};
					for(i in formDataArr){
						params[formDataArr[i].name] = formDataArr[i].value;
					}
					
					PM.service.task.quickCreateTask(params,function(task){
						
						window.location.href='#/tpl_task-msg:0';
				    	var time = 4;
						var jishu = setInterval(function(){  
							$(".tpl_task-msg").find(".jump-homepage").text(time);
							time = --time;
							if(time==-1){
								clearInterval(jishu);
								if(isWeiXin()){ 
									//window.location.href='index.jsp#/tpl_task-list'
									WeixinJSBridge.invoke('closeWindow',{},function(res){
										//alert('关闭微信页面');
									});
								}else{
									window.location.href='index.jsp#/'
								}
							}
						},1000);
					});
				}
			});
			//新建任务下关闭选择项目或者标签
			$(".container").on('click',".close",function(e) {
				$(this).parents(".task-select").removeClass("active");
				//window.location.hash="#/tpl_task-create";
				//alert(window.location.hash);
				window.history.back();
			});
			//新建任务下点击选择项目面板
			$(".container").on('click',".selectproject",function(e) {
				//alert(1);
				//PM.task.createTaskProject();
				//$(".task-project").addClass("active");
			});
			//新建任务下点击选择执行人
			$(".container").on('click',"#addExecutor",function(){
				if($("input[name='content.projectId']").val() == "" || typeof($("input[name='content.projectId']").val()) == "undefined"){
					showUserSelectExecutor('actionName',{tabs:{all : {name:'全部',url: 'getAllUser.action'}},limitSum:'10',selectMode:'selectOne',callback:'',readonly:false},'');
				}else{
					var toChooseUsers = [];
					var params = {};
					params.projectId = $("input[name='content.projectId']").val();
					params.memberGroup = "noFollower"
					PM.service.task.queryMemberByProject(params,function(result){
						$.each(result,function(){
							var eachUsers = {
									avatar : "",	
									dept : "",
									email : "",	
									id : this.userId,
									mobile : "",
									mobile2 : "",
									name : this.userName,
									type : 1	//通讯录用于判断是否是文件夹，0是文件夹，1是用户
							};
							toChooseUsers.push(eachUsers);
						});
						showUserSelectExecutor('actionName',{tabs:{all : {name:'全部',url: 'getAllUser.action'}},toChooseUsers:toChooseUsers,textField:'11e5-92aa-2e55f903-9406-8191a720b259_aaaaaa_text',valueField:'11e5-92aa-2e55f903-9406-8191a720b259_aaaaaa',limitSum:'10',selectMode:'selectOne',callback:'',readonly:false},'')
					});
				}
			});
			//新建任务下点击选择某个项目
			$(".container").on('click',".tpl_task-project .pm_projects_ul>li",function(e) {
				$(this).css("background","#f0f0f0");
				$(".selectproject").find("p").text($(this).attr("pro-name"));
				$("input[name='content.projectId']").val($(this).attr("pro-id"));
				$("input[name='content.projectName']").val($(this).attr("pro-name"));
				//$(".close").click();
				window.history.back();
			});
			//新建任务下点击选择某个标签
			$(".container").on('click',".tpl_task-tag .pm_tags_ul>li",function(e) {
				var tagSpan = '<div class="tag_div"><span class="eachTag"></span><i class="icon icon-close" style="font-size: 18px;color: red;"></i></div>';
				$tagSpan = $(tagSpan);
				$tagSpan.attr("tagName",$(this).attr("tag-name"));
				$tagSpan.find(".eachTag").text($(this).attr("tag-name"));
				if($(".selecttag").find(".tagCont>div").size()== 0){
					$(".selecttag").find(".tagCont").html($tagSpan);
					var tagsValue = $(this).attr("tag-name");
				}else{
					$(".selecttag").find(".tagCont").append($tagSpan);
					var tagsValue = $("input[name='content.tags']").val() + "," + $(this).attr("tag-name");
					
				}
				$("input[name='content.tags']").val(tagsValue);
				window.history.back();
			});
			//已选择的标签添加删除
			$(".container").on('click',".selecttag .tag_div",function(e) {
				$(this).remove();
				var tagNum = $(".tagCont").find(".tag_div").size();
				var tagsValue="";
				switch(tagNum){
				case 0:
					tagsValue="";
					break;
				case 1:
					 tagsValue = $(".tagCont").find(".tag_div").text();
					 break;
				default:
					for(var i=0;i<tagNum;i++){
						tagsValue +=  $(".tagCont").find(".tag_div").eq(i).text()+",";	
					}
				tagsValue = tagsValue.substr(0,tagsValue.length-1);
				}
				$("input[name='content.tags']").val(tagsValue);
				event.stopPropagation();
			});
			$(".container").on('click',".task-edit #form-edit-task-btn-submit",function(e) {
				if($("#form-edit-task-name").val()==""){
					alert("任务内容不能为空，请先填写任务内容。");
				}else{
					var formDataArr = $("#form-edit-task").serializeArray();
					var params = {};
					for(i in formDataArr){
						params[formDataArr[i].name] = formDataArr[i].value;
					}
					PM.service.task.updateTask(params,function(task){
						window.location.href='#/tpl_task-msg:1';
						var time = 4;
						var jishu = setInterval(function(){
							$(".tpl_task-msg").find(".jump-homepage").text(time);
							time = --time;
							if(time==-1){
								clearInterval(jishu);
								if(isWeiXin()){ 
									//window.location.href='index.jsp#/tpl_task-list';
									WeixinJSBridge.invoke('closeWindow',{},function(res){
										//alert('关闭微信页面');
									});
								}else{
									window.location.href='index.jsp#/';
								}
							}
						},1000);
						
					})
				}
			});	
			$(".container").on('click',".close-msg",function(){
				if(isWeiXin()){ 
					WeixinJSBridge.invoke('closeWindow',{},function(res){
						//alert('关闭微信页面');
					});
				}else{
					window.location.href='index.jsp'
				}
			});
			
			$(".container").on('click',".task-tab>a",function() {
				$(this).siblings().removeClass("active");
				$(this).addClass("active");
				$(".task-tab-content").removeClass("active").hide();
				$(".task-tab-content").find("ul").html("");
				$("#"+$(this).attr("url")).addClass("active").show();
				filterList($(".search"), $("#task-list-ul.task-list-ul-"+$(this).attr("url")));
				PM.task.randerTaskListPage();
			});
			
			//备注按钮单击事件
			$(".container").on("click","#task-edit-popup-remark-btn-ok",function(e){
				$(this).attr("disabled","disabled");
				var content = $("#task-edit-popup-remark-content").val();
				if(content && content.length>0){

					PM.service.task.createRemark(PM.cache.currentEditTaskId,content,function(remark){
						var taskRemarkTmp = '<div class="weui_cell">'
										   +'<div class="task-news-pic weui_cell_hd">' 
										   +'<div class="noAvatar"></div></div>'
										   +'<div class="task-news-text weui_cell_bd weui_cell_primary">'
										   +'<div class="task-news-top"><div class="task-news-text1"></div>'
										   +'<div class="task-news-text2"></div></div>'
										   +'<div class="task-news-bottom"></div></div>'
										   +'</div>';

						$taskRemarkTmp = $(taskRemarkTmp);
						var remarkTxt = PM.operationType[300] + ": " + remark.content;
						$taskRemarkTmp.find(".task-news-text1").text(remark.createRemarkUser);
						$taskRemarkTmp.find(".task-news-text2").text(remark.createDate);
						$taskRemarkTmp.find(".task-news-bottom").text(remarkTxt);
						
						var taskRemarkPic = Utils.getAvatar(remark.userId);
						var _noAvatar = "";
						if(taskRemarkPic != "" && taskRemarkPic != undefined){
							_noAvatar = '<img style="width:46px;height:46px;border-radius:4px;" src="'+taskRemarkPic+'"/>';
							
						}else{
							_noAvatar = remark.createRemarkUser.substr(remark.createRemarkUser.length-2, 2);
						}
						$taskRemarkTmp.find(".noAvatar").html(_noAvatar);
						$(".task-info").find(".task-news").prepend($taskRemarkTmp);
						
						$("#task-edit-popup-remark-content").val("");
						$("#task-edit-popup-remark-btn-ok").removeAttr("disabled");
					});
				}
				
				
			});
			
		},
		
		//上传录音
		uploadVoice:function(localId){
			var recordTime = parseInt($("#record_id .time-total").text());
			setTimeout(function(){
				var _wx = top.wx ? top.wx : wx;
	        	_wx.uploadVoice({
			    	localId: localId,
			        success: function (res) {
			        	var serverId = res.serverId;
				        $.get(contextPath+"/portal/weixin/jsapi/PMupload.action",{"time":recordTime,"folder":"voice","fileType":"amr","serverId":serverId,"taskid":PM.cache.currentEditTaskId},function(result){
				        	if(result.status==1){
				        		$(".container").find("#localId").val(localId);
				        		$(".container").find("#serverId").val(serverId);
					        	if(location.hash=="#/tpl_task-create"){
					  	 			attachmentVal = $("#form-create-task-attachment").val();
					  	 		}else{
					  	 			attachmentVal = $("#form-edit-task-attachment").val();
					  	 		}
					  	 		if(attachmentVal!=""){
					  	 			var attachmentJson = JSON.parse(attachmentVal);
					  	 		}else{
					  	 			var attachmentJson = {};
					  	 		}
					  	 		
					        	attachmentJson[result.data.id] = {"id":result.data.id,"time":recordTime,"name":result.data.name};
					        	if(location.hash=="#/tpl_task-create"){
					        		$(".tpl_task-create").find("#form-create-task-Record").val(result.data.id);
					        		$(".tpl_task-create").find("#form-create-task-attachment").val(JSON.stringify(attachmentJson));
					        		$(".tpl_task-create").find("#startRecord").hide();
					        		$(".tpl_task-create").find("#sound-play-box").show();
					        		$(".tpl_task-create").find("#sound-play-box").find(".btn-sound-times").text(recordTime+"s");
						  	 	}else if(location.hash.indexOf("#/tpl_task-edit") == 0){
						  	 		if($(".tpl_task-edit").find("#playVoice").children().length == 0){
						  	 			var playVoiceChild = '<div style="width:53px;"><div class="sound-play-ico" style="visibility:visible;-webkit-animation:initial;background-postion-x:-48px 0px;"></div></div>'
						  	 								+ '<span class="btn-sound-times" style="position:absolute;right:5px;top:8px;"></span>';
						  	 			$(".tpl_task-edit").find("#playVoice").append(playVoiceChild);
						  	 		}
						  	 		$(".tpl_task-edit").find("#form-edit-task-Record").val(result.data.id);
						  	 		$(".tpl_task-edit").find("#form-edit-task-attachment").val(JSON.stringify(attachmentJson));
						  	 		$(".tpl_task-edit").find("#startRecord").hide();
						  	 		$(".tpl_task-edit").find("#sound-play-box").show();
						  	 		$(".tpl_task-edit").find("#sound-play-box").find(".btn-sound-times").text(recordTime+"s");
						  	 	}
					        	// todo 构建json
					  			//clearInterval(timer);
								$(".time-total").text(0);
					    	}
						})
			        },
			        fail: function (res) {
			        	alert("网络异常，请再次尝试！");
			        }
			      });
	        }, 100)
		},

		//隐藏附件底部菜单
		hideActionSheet : function(weuiActionsheet, mask) {
			if(window.location.hash == "#/popUpLayer"){
         		history.go(-1);
         	}
	        weuiActionsheet.removeClass('weui_actionsheet_toggle');
	        mask.removeClass('weui_fade_toggle');
	        weuiActionsheet.on('transitionend', function () {
	            mask.hide();
	        }).on('webkitTransitionEnd', function () {
	            mask.hide();
	        })
	    },
	    
	    createTask: function(){
	    	$.getJSON("../task/createTaskId.action",{},function(result){
				if(1==result.status){
						$("#form-create-task-id").val(result.data);
						PM.cache.currentEditTaskId = result.data;
						mobiscrollMin = new Date();
						mobiScrollInit();
				}else{
					Utils.showMessage(result.message, "error");
				}
			});
			$("title").text("新建任务");
			loadHide();
	    },
	    createTaskProject :function(){
	    	PM.service.task.getTaskProjectList(function(projects){
	    		var projectPanel = $("#tpl_task-project");
				var projectBox = $($("#tpl_task-project").html());
				projectBox.find(".pm_projects_ul").html("");
				$.each(projects.data,function(key,data){
					var prolistTmp = '<li><a href="javascript:void(0);">'
									+ '<div  class="pm_projects_item_box weui_cell">'
									+ '<div class="weui_cell_hd"><div class="noAvatar"></div></div>'
									+ '<div class="weui_cell_bd">'
									+ '<h4 class="pm_projects_item_title"></h4>'
									+ '<p class="pm_projects_item_desc"></p></div></div></a></li>';
					var $prolist = $(prolistTmp);
					var proExecutorPic = Utils.getAvatar(data.creatorId);
					if(proExecutorPic!="" && proExecutorPic!=undefined){
						$prolist.find(".noAvatar").html('<img src="'+proExecutorPic+'">');
					}else{
						$prolist.find(".noAvatar").html(data.creator.substr(data.creator.length-2, 2));
					}
					$prolist.attr("pro-id",data.id);
					$prolist.attr("pro-name",data.name)
					$prolist.find(".pm_projects_item_title").text(data.name);
					var schedule;
					if(data.tasksTotal==0) {
						schedule = 0;
					}else{
						schedule = Math.round((data.finishedTasksNum/data.tasksTotal)*100)
					}
					$prolist.find(".pm_projects_item_desc").html("<span>总任务："+data.tasksTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span><span>已完成："+data.finishedTasksNum+"&nbsp;&nbsp;&nbsp;&nbsp;</span><span>进度："+schedule+"%</span>")
					projectBox.find(".pm_projects_ul").append($prolist);
				});
				projectPanel.html(projectBox);
				$(".tpl_task-project").html($($("#tpl_task-project").html()));
			});
		},
		searchTaskProject :function(){
			var params = params || {};
			params["name"] = $("#search_input").val();
			PM.service.project.queryMyProject(params,function(projects){
				
				//隐藏nullbox
				$(".pm_projects_box").find(".nullbox").css("display","none");
				var projectBox = $(".tpl_task-create").find(".pm_projects_box");
				var projectUl = projectBox.find(".pm_projects_ul").html("")
				$.each(projects,function(){
					var prolistTmp = '<li><a href="javascript:void(0);">'
									+ '<div  class="pm_projects_item_box weui_cell">'
									+ '<div class="weui_cell_hd"><div class="noAvatar"></div></div>'
									+ '<div class="weui_cell_bd">'
									+ '<h4 class="pm_projects_item_title"></h4>'
									+ '<p class="pm_projects_item_desc"></p></div></div></a></li>';
					var $prolist = $(prolistTmp);
					var proExecutorPic = Utils.getAvatar(this.creatorId);
					if(proExecutorPic!="" && proExecutorPic!=undefined){
						$prolist.find(".noAvatar").html('<img src="'+proExecutorPic+'">');
					}else{
						$prolist.find(".noAvatar").html(this.creator.substr(this.creator.length-2, 2));
					}
					$prolist.attr("pro-id",this.id);
					$prolist.attr("pro-name",this.name)
					$prolist.find(".pm_projects_item_title").text(this.name);
					var schedule;
					if(this.tasksTotal==0) {
						schedule = 0;
					}else{
						schedule = Math.round((this.finishedTasksNum/this.tasksTotal)*100)
					}
					$prolist.find(".pm_projects_item_desc").html("<span>总任务："+this.tasksTotal+"&nbsp;&nbsp;&nbsp;&nbsp;</span><span>已完成："+this.finishedTasksNum+"&nbsp;&nbsp;&nbsp;&nbsp;</span><span>进度："+schedule+"%</span>")
					projectUl.append($prolist);
				});
				//项目列表为空时出现占位符
				if(projectBox.find(".pm_projects_ul>li").length==0){
					projectBox.find(".nullbox").css("display","block");
				}else{
					projectBox.find(".nullbox").css("display","none");
				}
			})
		},
		createTaskTag :function(){
			var params = {};
			var tagsPanel = $("#tpl_task-tag");
			var tagsBox = $($("#tpl_task-tag").html());
			tagsBox.find(".pm_tags_ul").html("");
			params["projectId"] = $("input[name='content.projectId']").val();
			if( params["projectId"] != ""){
			PM.service.tag.getTagList(params,function(data){
				if(data.length>0){
					var tags = [],selectTagName = [];
					//过滤已选中的Tag
					$(".container .tag_div").each(function(){
						var tagName = $(this).attr("tagname");
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
					
					$.each(tags,function(){
						var taglistTmp = '<li><a href="javascript:void(0);"></a></li>';
						var $taglist = $(taglistTmp);
						$taglist.attr("tag-name",this.name)
						$taglist.find("a").text(this.name);
						$taglist.attr("data-id",this.id);
						tagsBox.find(".pm_tags_ul").append($taglist);
					});
					tagsPanel.html(tagsBox);
					$(".tpl_task-tag").html($($("#tpl_task-tag").html()));
				}else{
					tagsBox.find(".pm_tags_box").html("<p style='line-height:45px;margin-top:30px;color: #888;font-size: 14px;text-align: center;'>该项目没有设置标签</p>");
					//$(".tpl_task-tag").html("<p style='position:absolute;left:0;right:0;top:0;bottom:0;'>请先设置项目</p>");
					$(".tpl_task-tag").html(tagsBox);
				}
			});
			}else{
				tagsBox.find(".pm_tags_box").html("<p style='line-height:45px;margin-top:30px;color: #888;font-size: 14px;text-align: center;'>请先设置项目</p>");
				$(".tpl_task-tag").html(tagsBox);
			}
		},
	    randerTaskEditPage : function(weuiActionsheet, mask) {
	    	var attachmentArray = [];
			var attachmentEditStr;
			var attachmentEditJson;
			var taskID;
			
			var task_edit_panel = $("#tpl_task-edit")
			var $taskEdit = $(".tpl_task-edit");
			PM.service.task.editTask(PM.cache.currentEditTaskId,function(task){
				var datas = PM.task.getTaskInfoEditData(task);
				var tmpl = template("task-edit", datas);
				$(".tpl_task-edit").html(tmpl);
				mobiscrollMin = new Date(task.startDate);
				mobiScrollInit();
				
				setTimeout(function(){
					var myAudio = $(".tpl_task-edit").find("#sound-play-box").find("audio")[0];
					if(typeof(myAudio) == undefined){
						if(isNaN(myAudio.duration)){
							setTimeout(function(){
								if(!isNaN(myAudio.duration)){
									$(".tpl_task-edit").find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
								}
							},2000);
						}else{
							$(".tpl_task-edit").find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
						}
					}
					
					$(".tpl_task-edit").find("#sound-play-box").find("#playVoice").click(function(e){
						 myAudio.play();
						 $(".tpl_task-edit").find(".sound-play-ico").css({"visibility":"hidden","-webkit-animation":"sound-play-ico 1000ms steps(1) infinite","background-postion-x":"0px 0px"})
						 $(myAudio).on("ended",function(){
							 $(".tpl_task-edit").find(".sound-play-ico").css({"visibility":"visible","-webkit-animation":"initial","background-postion-x":"-48px 0px"});
						 });
					});
				},500);
				
				loadHide();
			});
	    },
	    
	    
		
		//渲染任务详情页面
		randerTaskInfoPage :function(){
			PM.service.task.editTask(PM.cache.currentEditTaskId,function(task){
				var datas = PM.task.getTaskInfoEditData(task);
				var tmpl = template("task-info", datas);
				$(".tpl_task-info").html(tmpl);
				var new_activityLength = $(".tpl_task-info").find(".new_activity").length;
				if(new_activityLength >5){
					for(var i = 5;i<new_activityLength;i++){	//从第6条开始隐藏
						$(".tpl_task-info").find(".new_activity").eq(i).css("display","none");
					}
					$expend = $('<div class="new_activity_expend"><i class="fa fa-chevron-down" aria-hidden="true"></i></div>');
					$expend.bind("click", function(){	//删除粘贴截图的方框
						$(this).toggleClass("hide");
						for(var i = 5;i<new_activityLength;i++){	//从第6条开始隐藏
							$(".tpl_task-info").find(".new_activity").eq(i).toggle();
						}
						if($(this).hasClass("hide")){
							$(this).html('<i class="fa fa-chevron-up" aria-hidden="true"></i>');
						}else{
							$(this).html('<i class="fa fa-chevron-down" aria-hidden="true"></i>');
						}
					}).appendTo($(".tpl_task-info").find(".task-news"));
				}
				setTimeout(function(){
					var myAudio = $(".tpl_task-info").find("#sound-play-box").find("audio")[0];
					if(typeof(myAudio) == undefined){
						if(isNaN(myAudio.duration)){
							setTimeout(function(){
								if(!isNaN(myAudio.duration)){
									$(".tpl_task-info").find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
								}
							},2000);
						}else{
							$(".tpl_task-info").find("#sound-play-box").find(".pm-edit-Record-time").text(parseInt(myAudio.duration));
						}
					}
					
					$(".tpl_task-info").find("#sound-play-box").find("#playVoice").click(function(e){
						 myAudio.play();
						 $(".tpl_task-info").find(".sound-play-ico").css({"visibility":"hidden","-webkit-animation":"sound-play-ico 1000ms steps(1) infinite","background-postion-x":"0px 0px"})
						 $(myAudio).on("ended",function(){
							 $(".tpl_task-info").find(".sound-play-ico").css({"visibility":"visible","-webkit-animation":"initial","background-postion-x":"-48px 0px"});
						 });
					});
				},500);
				loadHide();
			});
		},
		//渲染首页任务今日任务
		randerBigTaskPage :function(){
			var mydate = new Date();
	    	var str = "" + mydate.getFullYear() + "-";
	    	 	str += (mydate.getMonth()+1) + "-";
	    	 	str += mydate.getDate();
			var $this = $(this),params = {};
			params.dateRangeType = "TODAY";
			params.status = "3";
			params.currDate = str;
			params.name = "";//for test
			PM.service.task.queryMyTasks(params,function(tasks){
				var $currtaskPanel = $("#tpl_home");
				var $currtaskList = $($currtaskPanel.html());
				if(tasks==""){
					//alert("今天没有任务");
				}else{
					$currtaskList.find("#task-biglist-ul").find(".task-list-li").remove();
					var taskLiTmp = '<li class="task-list-li task-big-info" class="js_cell" data-id="" title="task-info">'
								+ '<a class="task-home-box">'
								+ '<div class="task-list-content"></div>'
								+ '<div class="task-list-data"></div>'
								+ '<div class="task-list-more">'
								+ '<div class="task-list-more-text">查看详情</div>'
								+ '<div class="task-list-more-arrow"></div>'
								+ '</div></a></li>';
					$.each(tasks,function() {
						var $taskLi = $(taskLiTmp);
						$taskLi.attr("data-id",this.id);
						$taskLi.find(".task-list-content").text(this.name);
						$taskLi.find(".task-list-data").text(this.createDate);
						$taskLi.find(".task-home-box").attr("href","#/tpl_task-info/:"+this.id);
						$currtaskList.find("#task-biglist-ul").append($taskLi);
						
					
					});
					$currtaskPanel.html($currtaskList);
				}
				loadHide();
			});
		},
		// 渲染关注人
		renderFollowPage : function() {
			PM.service.follow.queryMyFollowTasks({},function(tasks){
				$("#task-list-ul").find(".line-wrapper").remove();
				$.each(tasks,function() {
					$("#tmpl-task-listview-item").tmpl(this).appendTo("#task-list-ul");
						switch(this.level){
						case 3:
							$(".pm-modify-task-level-box.3").addClass("pm-modify-task-levela");
							break;
						case 2:
							$(".pm-modify-task-level-box.2").addClass("pm-modify-task-levelb");
							break;
						case 1:
							$(".pm-modify-task-level-box.1").addClass("pm-modify-task-levelc");
							break;
						case 0:
							$(".pm-modify-task-level-box.0").addClass("pm-modify-task-leveld");
							break;
					}
				});
				Utils.deletebtn();
			});
		},
		/**
		 *任务列表的数据
		 */
		getTaskListData : function(result){
			var datas = {};	
			datas.lis = []
			datas.lis.tags = [];
			$.each(result,function() {
				var _createDate = this.createDate;
				var _creator = this.creator;
				var _creatorId = this.creatorId;
				var _domainid = this.domainid;
				var _executor = this.executor;
				var _executorId = this.executorId;
				var _hasFollow = this.hasFollow;
				var _id = this.id;
				var _level = this.level;
				var _name = this.name;
				var _projectId = this.projectId;
				var _projectName = this.projectName;
				var _remindMode = this.remindMode;
				var _startDate = this.startDate;
				var _status = this.status;
				var _type = this.type;
				var _startDate = this.startDate;
				var _tag =[];
				$.each(this.tags,function(){
					var tagname = this.name;
					var sstag = {
							'name': tagname
					};
					_tag.push(sstag);
				})
				var _avatar,_timeAgo;
				var avatar = Utils.getAvatar(_executorId);	//获取微信头像
				var isImg = false;
				if(avatar!="" && avatar!=undefined){
					isImg = true;
					_avatar = "<img src ="+avatar+">";
				}else{
					_avatar = "<div class='noAvatar'>" + _executor.substr(_executor.length-2, 2) + "</div>";
				}
				var timePmArr = _createDate.split(/[- :]/); 
				var timePmDate = new Date(timePmArr[0], timePmArr[1]-1, timePmArr[2], timePmArr[3], timePmArr[4]);
				var Month = timePmDate.getMonth() + 1; 
				var Day = timePmDate.getDate(); 
				var Hour = timePmDate.getHours(); 
				var Minute = timePmDate.getMinutes(); 
				var comTime = daysCalc(_createDate);
				if(comTime.days > 2){
					if (Month >= 10){ 
						_timeAgo = Month + "-"; 
					}else{ 
						_timeAgo = "0" + Month + "-"; 
					} 
					if (Day >= 10) 
					{ 
						_timeAgo += Day + " "; 
					}else{ 
						_timeAgo += "0" + Day; 
					} 
				}else if(comTime.days == 2){ 
					_timeAgo = "前天 ";
					if (Hour >= 10) 
					{ 
						_timeAgo += Hour + ":" ; 
					}else{ 
						_timeAgo += "0" + Hour + ":" ; 
					} 
					if (Minute >= 10) 
					{ 
						_timeAgo += Minute ; 
					}else{ 
						_timeAgo += "0" + Minute ; 
					} 
				}else if(comTime.days == 1){
					_timeAgo = "昨天 ";
					if (Hour >= 10) 
					{ 
						_timeAgo += Hour + ":" ; 
					}else{ 
						_timeAgo += "0" + Hour + ":" ; 
					} 
					if (Minute >= 10) 
					{ 
						_timeAgo += Minute ; 
					}else{ 
						_timeAgo += "0" + Minute ; 
					} 
				}else if(comTime.days <= 0 && comTime.hours > 0){
					_timeAgo = comTime.hours + " 小时前 ";
				}else if(comTime.days <= 0 && comTime.hours <= 0){
					if(comTime.minutes < 5){
						_timeAgo = " 刚刚";
					}else{
						_timeAgo = comTime.minutes + " 分钟前 ";
					}
				}
				var list =	{
						'createDate' : _createDate,			
						'creator' : _creator,		
						'creatorId' : _creatorId, 	
						'domainid' : _domainid, 	
						'executor' : _executor,	
						'executorId' : _executorId,
						'hasFollow' : _hasFollow,	//仅供artTemplate渲染使用
						'id':_id,
						'level':_level,
						'name':_name,
						'projectId':_projectId,
						'projectName':_projectName,
						'remindMode':_remindMode,
						'startDate':_timeAgo,
						'status':_status,
						'type':_type,
						'tags' : _tag,
					   	'isImg':isImg,
					   	'avatar':_avatar
				   	};

				datas.lis.push(list);
			})
			return datas;
		},
		/**
		 *单个任务详细信息的数据
		 */
		getTaskInfoEditData : function(task){
			/**
			 * datas结构
			 * datas = {
					attachment:;
					createDate:;
					creator:;
					creatorId:;
					description:;
					domainid:;
					endDate:;
					executor:;
					executorId:;
					finishedDate:;
					followers: [{}];
					hasFollow: false
					id: ;
					level: ;
					logs: [{}];
					name: ;
					projectId: ;
					projectName: ;
					remarks: [{}]
					remindMode: ;
					startDate: ;
					status: 0
					subTask: [{}];
					tags: [{}]
			 
			  }
			 */
			var datas = task;
			var isdifferDays = daysBetween(task.startDate,task.endDate);
			if(isdifferDays){
				isdifferDays = true
				var differDays = daysBetween(task.startDate,task.endDate)+1;
			}
			datas.isdifferDays = isdifferDays;
			datas.differDays = differDays;
			var isLogs = false;
			if(task.logs || task.logs.length > 0){
				isLogs = true;
			}
			datas.isLogs = isLogs;
			
			$.each(datas.logs.reverse(),function(){
				var logTxt = PM.operationType[this.operationType] + ": " + this.summary;
				var _userId = this.userId;
				var _userName = this.userName;
				var _avatar;
				var avatar = Utils.getAvatar(_userId);	//获取微信头像
				var isImg = false;
				if(avatar!="" && avatar!=undefined){
					isImg = true;
					_avatar = "<div class='noAvatar'><img style='width:46px;height:46px;border-radius:4px;' src ="+avatar+"></div>";
				}else{
					_avatar = "<div class='noAvatar'>" + _userName.substr(_userName.length-2, 2) + "</div>";
				}
				this.isImg = isImg;
				this._avatar = _avatar;
				this.logTxt = logTxt;
			});
			
			var isEdit = false;
			if(task.executorId==USER.id || task.creatorId==USER.id){
				isEdit = true;
			}
			datas.isEdit = isEdit;
			var ifFujian = false;//指的是文件、图片
			var ifVoice = false;//指的是微信端录音
			if(task.attachment && task.attachment!=null && task.attachment!=""){
				ifFujian = true;
			}
			datas.ifFujian = ifFujian;
			datas.ifVoice = ifVoice;
			datas.fujian = [];//装文件、图片
			datas.voice = [];//装录音
			var objfujian = datas.attachment;//获取出来的数据包含文件、图片、录音
			if(objfujian == "" || objfujian == undefined) objfujian = null;
			var dataAtts = eval("("+objfujian+")");
			for(var name in dataAtts){
			//$.each(datas.attachment,function(){
				var att = dataAtts[name];
				var _time = att.time;
				if(_time || _time != undefined){
					datas.ifVoice = true;
					var _voiceUrl="";
					var _soundWith="50";
					_voiceUrl = contextPath+'/uploads/voice/'+att.name;
					if(_time>150){
						_soundWith = "120"
					}else{
						_soundWith = 50+parseInt(_time);
					}
					var _voice = {
						'time': _time + "s",
						'voiceUrl':_voiceUrl,
						'soundWith':_soundWith+"px"	
					}
					datas.voice.push(_voice);
				}else{
					var _fileType = att.name.substring(att.name.lastIndexOf("."),att.name.length);
					var _isCompress = att.isCompress;
					var _id = att.id;
					var _fileUrl="";
					if(att.url && att.url != undefined){
						if(_isCompress == true){
							_fileUrl = "../../"+att.url.replace(new RegExp("\\\\","g"),"/") +"/" +"Compress_"+_id + _fileType;
						}else if(_isCompress == false){
							_fileUrl = "../../"+att.url.replace(new RegExp("\\\\","g"),"/") +"/" + _id + _fileType;
						}else{ //兼容旧数据
							_fileUrl = "../../"+att.url.replace(new RegExp("\\\\","g"),"/");
						}
					}
					var eachfujian = {
							'fileId':_id,
							'fileType':_fileType,
							'fileUrl':_fileUrl,
					}
					datas.fujian.push(eachfujian);
				}
			//});
			}
			//把标签做成数组
			var tagsAll = "";
			for(var i=0;i<datas.tags.length;i++){
				tagsAll += datas.tags[i].name+",";
			}
			tagsAll = tagsAll.substr(0,tagsAll.length-1)
			datas.tagsStri = tagsAll;
			//获取任务执行人的头像
			var _avatar;
			var avatar = Utils.getAvatar(datas.executorId);	//获取微信头像
			var isImg = false;
			if(avatar!="" && avatar!=undefined){
				isImg = true;
				_avatar = "<img style='width:46px;height:46px;border-radius:4px;' src ="+avatar+">";
			}else{
				_avatar = "<div class='noAvatar'>" + datas.executor.substr(datas.executor.length-2, 2) + "</div>";
			}
			datas._avatar = _avatar;
			var isExecutor = false;
			if(datas.executor!="" && datas.executor!=undefined) isExecutor = true;
			datas.isExecutor = isExecutor;
			return datas;
		}
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
		bindEvent : function(){
			$container.on('keydown', '.tpl_project-list #search_input', function (e) {
				if (e.keyCode == 13) {
					PM.project.searchProjectAction();
					return false;
				}
			});
			//项目查询关闭按钮
			$container.on("change",".project_switch",function(){
				if($(this).is(':checked')){
					$.cookie("project-close","true")
					$(".pm_projects_ul").find(".project-item[data-closed='true']").show();
				}else{
					$.cookie("project-close","false")
					$(".pm_projects_ul").find(".project-item[data-closed='true']").hide();
				}
			});
		},
		renderProjectPage : function(){
			$("title").text("项目");
			PM.service.project.getProjectList({},function(projects){
				//隐藏nullbox
				$(".pm_projects_box").find(".nullbox").css("display","none");
				var projectBox = $(".tpl_project-list");
				var datas = PM.project.getProjectDatas(projects);	
				var tmpl = template("project-list-li", datas);
				projectBox.find(".pm_projects_ul").html(tmpl);
				//根据cookie控制显示隐藏已关闭项目
				if($.cookie("project-close") && $.cookie("project-close") != ""){
					if($.cookie("project-close")=="true"){
						$(".project_switch").attr("checked",true);
						$(".pm_projects_ul").find(".project-item[data-closed='true']").show();
					}else{
						$(".project_switch").attr("checked",false);
						$(".pm_projects_ul").find(".project-item[data-closed='true']").hide();
					}
				}
				//项目列表为空时出现占位符
				if(projectBox.find(".pm_projects_ul>li").length==0){
					projectBox.find(".pm_projects_box").find(".nullbox").css("display","block");
				}else{
					projectBox.find(".pm_projects_box").find(".nullbox").css("display","none");
				}
			})
		},
		searchProjectAction : function(){
			var params = params || {};
			params["name"] = $("#search_input").val();
			PM.service.project.queryMyProject(params,function(projects){
				//隐藏nullbox
				$(".pm_projects_box").find(".nullbox").css("display","none");
				var projectBox = $(".tpl_project-list");
				var datas = PM.project.getProjectDatas(projects);
				var tmpl = template("project-list-li", datas);
				$(".pm_projects_box").find(".pm_projects_ul").html(tmpl);
				//项目列表为空时出现占位符
				if(projectBox.find(".pm_projects_ul>li").length==0){
					projectBox.find(".pm_projects_box").find(".nullbox").css("display","block");
				}else{
					projectBox.find(".pm_projects_box").find(".nullbox").css("display","none");
				}
			})
		},
		
		getProjectDatas : function(projects){
			var datas = {};	
			datas.lis = []
			datas.lis.tags = [];
			$.each(projects,function() {
				var _closed = this.closed;
				var _createDate = this.createDate;
				var _creator = this.creator;
				var _creatorId = this.creatorId;
				var _domainid = this.domainid;
				var _finishedTasksNum = this.finishedTasksNum;
				var _id = this.id;
				var _manager = this.manager;
				var _managerId = this.managerId;
				var _name = this.name;
				var _notification = this.notification;
				var _tasksTotal = this.tasksTotal;
				
				var _avatar,_schedule;
				var avatar = Utils.getAvatar(_creatorId);	//获取项目创建人的微信头像
				var isImg = false;
				if(avatar!="" && avatar!=undefined){
					isImg = true;
					_avatar = "<img src ="+avatar+">";
				}else{
					_avatar = "<div class='noAvatar'>" + _creator.substr(_creator.length-2, 2) + "</div>";
				}
				if(this.tasksTotal==0) {
					_schedule = 0;
				}else{
					_schedule = Math.round((this.finishedTasksNum/this.tasksTotal)*100)
				}
				var list =	{
						'closed' : _closed,
						'createDate': _createDate,
						'creator': _creator,
						'creatorId': _creatorId,
						'domainid': _domainid,
						'finishedTasksNum': _finishedTasksNum,
						'id': _id,
						'manager': _manager,
						'managerId': _managerId,
						'name': _name,
						'notification': _notification,
						'tasksTotal': _tasksTotal,
					   	'isImg':isImg,
					   	'avatar':_avatar,
					   	'schedule':_schedule
				   	};

				datas.lis.push(list);
			})
			return datas;
		},
		taskList : {
			searchAction : function(){
				
				PM.Config.moreScroll.scroller.innerHTML = "";    //清空内容
				PM.Config.moreScroll.scrollTo(0, 0);	//滚回顶部
				PM.Config.moreScroll.options.page = PM.Config.filter.pageNo= 1;	//重置第1页
				PM.Config.filter.projectId = $(".tpl_task-list").find("input[name='projectId']").val();
				_level= $(".tpl_task-list input[name='content.level']:checked").val();
				if(typeof(_level) == "undefined") _level = "";
				PM.Config.filter.level = _level;
				PM.Config.filter.executorId = $(".tpl_task-list input[name='executorId']").val();
				PM.Config.filter.endDate = $(".tpl_task-list").find("input[name='dateRange']").val();
				PM.Config.filter.tag = $(".tpl_task-list").find("input[name='tag']").val();
				PM.Config.filter.status = $(".tpl_task-list").find("input[name='status']").val()?$(".tpl_task-list").find("input[name='status']").val():"";
				PM.Config.filter.taskName =$(".tpl_task-list").find("#search_input").val();
				PM.service.task.querySelectTasks(PM.Config.filter,function(result){
					if(result.rowCount > 0 && PM.Config.moreScroll != null ){
						var datas = PM.task.getTaskListData(result.datas);
						
						PM.Config.moreScroll.options.total = result.pageCount;
						PM.Config.moreScroll.infinite_callback(datas.lis);
						
						PM.Config.moreScroll.refresh();
						if(result.pageCount <= 1){
							$('.container').find(".task-tab-list-box .weui-loadmore").eq(0).hide();
						}
					}else{
						Utils.controlPlaceholder("show");
					}
				});
			},
			/**
			 * 渲染任务列表
			 * @projectId
			 */
			randerTaskList : function(projectId,params){
				/**
				 * params = {
				 * 		projectId = "",
				 * 		status = "",
				 *      executorId = "",
				 *      endDate = "",
				 *      level = "",
				 *      tag = "",
				 *      taskName = "",
				 *      linesPerPage = "",
				 *      pageNo = ""
				 * }
				 * **/
				
				
				var params = params || {};
				params.projectId = projectId;
				params.endDate = "";
				params.level = "";
				params.tag = "";
				params.taskName = "";
				params.linesPerPage = 15;
				params.pageNo = 1;
				
				PM.Config.filter = params;
				//隐藏nullbox
				$(".task-tab-list-box").find(".nullbox").css("display","none");
				//jroll实例
				PM.Config.moreScroll = new JRoll("#my1");
	        	var listData = PM.project.taskList.getQueryTasksByProject(params)
	        	var pageCount = listData.pageCount;
	        	var rowCount = listData.rowCount;
	        	if(rowCount > 0){
					PM.Config.moreScroll.infinite({
	            		total : pageCount,
	            		loadingTip : '<div class="weui-loadmore jroll-infinite-tip"><i class="weui-loading"></i>'
	            			+'<span class="weui-loadmore__tips">正在加载</span></div>',
	        			completeTip : '<div class="jroll-infinite-tip"></div>', 
	                	getData: function(page, callback) {
	                		PM.Config.filter.pageNo = page;
	                		var datas;
	                		PM.service.task.querySelectTasks(params,function(result){
	        					var $taskList = $(".tpl_task-list");
	        					datas = PM.task.getTaskListData(result.datas);
	        				})
	                		callback(datas.lis);
	                	},
	                	compile: function(atp) {
	                        return template.compile(atp);
	                    },
	                    template: $("#task-list-li").html()
	            	});
					PM.Config.moreScroll.refresh();
					$('.container').find("#my1 .weui-loadmore").eq(0).remove();
	        	}else{
	        		Utils.controlPlaceholder("show");
	        	}
				
			},
			/**
			 * 项目下的成员（管理员、执行人、创建人、关注人）关注人权限控制
			 * @projectId
			 */
			getMemberType : function(projectId){
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
			 * 项目下的任务列表数据（datas,linesPerPage,pageCount,pageNo,rowCount）
			 * @projectId
			 */
			getQueryTasksByProject : function(params){
				var lsitData = {};
				//PM.service.task.queryTasksByProject(params,function(result){
				PM.service.task.querySelectTasks(params,function(result){
					if(result.datas.length > 0){
                		lsitData = result;
                	}
			    })
			    return lsitData;
			},
			/**
			 * 项目下的任务列表查询数据（datas,linesPerPage,pageCount,pageNo,rowCount）
			 * @projectId
			 */
			getSearchTasksByProject : function(params){
				var searchlsitData = {};
				PM.service.task.querySelectTasks(params,function(result){
					if(result.datas.length > 0){
						searchlsitData = result;
                	}
				});
			    return searchlsitData;
			}
			
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
			params.range = "all";// for test
			PM.service.activity.queryActivities(params,function(activities){
				$("#main-content").empty();
				var currentDate = "";
				$.each(activities,function(i,activity){
					var d = activity.operationDate.split(" ");
					if(d[0] != currentDate){
						$("#tmplActivityPart").tmpl({"operationDate":d[0]}).appendTo($("#main-content"));
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
			});
		}
	},
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
	 * 项目成员类型
	 */
	MemberType :{
		regular : 0,//参与者
		manager : 1,//管理员
		follower : 2//关注人,无法进行新建任务、编辑任务操作
	},
	/**
	 * 缓存对象
	 */
	cache : {
		useId : null,//当前处理人
		target : null,// 事件发起对象
		currentEditTask : null,// 当前编辑的任务
		currentEditTaskId : "",// 当前编辑的任务主键
		currentEditSubTaskItem : null,// 当前编辑的子任务
		currentEditRemarkItem : null,// 当前编辑的任务备注
	},
	
	Config : {
		 moreScroll : null,//需实例的jroll
		 filter : null//刷选条件
	}
};

