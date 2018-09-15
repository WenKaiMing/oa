/**
 * message 核心类
 * 封装message界面渲染与交互行为
 */
;
var Message = Message || {
	cache : {
		messageType : "message-all",
		commentUser : "",
		noticeRead : "no",
		iReplyType : "mycomment",
		Uedit : null,
		visibleId : "",
		uploader: null
	},
	/**
	 * 首页
	 */
	main : {
		init : function(active) {
			Message.remind.renderNum();
			this.bindEven();
			if(messageId && messageId != "null"){
				Message.showMessage.init();
			}else{
				$("#message-center-panel").show();
				if(active && active == "null"){
					$("#msg-content-panel").find('.nav a:first').tab('show');
				}else if(active && active == "announcement"){
					$("#msg-content-panel").find('.nav a:eq(1)').tab('show');
				}else if(active && active == "notice"){
					$(".message-menu").find("a[data-type='remind']").trigger("click");
				}else if(active && active == "comment"){
					$(".message-menu").find("a[data-type='comment']").trigger("click");
					$("#comment-panel").find('.nav a:eq(1)').trigger("click");
				}
			}
			Message.uploadInit("write");
			Message.cache.Uedit = UE.getEditor('notice-container', {
				toolbars: [[
				            'source', '|', 'undo', 'redo', '|',
				            'bold', 'italic', 'underline', '|', 'forecolor', 'backcolor', '|',
				            'fontfamily', 'fontsize', '|',
				            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
				            'link', 'unlink', '|', 
				            'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols',
				        ]],
			    autoHeight: false,
			    initialFrameHeight: 250,
			    initialFrameWidth: "100%"
			});
			
		},
		renderFace : function($obj,top,left){
			var data = {
				top : top+"px",
				left : left+"px",
				face : []
			}
			$.each(Message.Util.cache.mapping,function(key,val){
				var title = key.substr(key.indexOf("[")+1,key.length-7);
				data.face.push({
					"file":val,
					"title":title
				})
			})
			
			var html = template('facelist-panel-tpl', data);
			$obj.after(html);
		},
		bindEven : function(){
			var $message = $("#message-content");
			var $messagePanel = $("#message-center-panel");
			var $noticePanel = $('#new-notice');
			var $messageContent = $("#msg-content-panel");
			var $remindPanel = $("#remind-panel");

			//发布消息面板
			var $writePanel = $("#msg-write-panel");
			
			//左侧菜单
			$(".message-menu").on("click",".msg-menu-item",function(){
				var $this = $(this);
				var type = $this.find("a").data("type");
				$this.siblings().removeClass("active");
				$("#notice-show-panel").hide();
				$this.addClass("active");
				$message.find("div[data-contype]").hide();
				$message.find("div[data-contype='"+type+"']").show();
				if(type == "list"){
					$("#msg-content-panel").find(".nav-tabs a[href='#"+Message.cache.messageType+"']").tab("show");
					var params = {}
					if(Message.cache.messageType == "message-all"){
						Message.Service.getMessageList(params,function(data){
							Message.list.init(Message.cache.messageType, data);
						})
					}else if(Message.cache.messageType == "message-notice"){
						Message.Service.getAnnouncementList(params,function(data){
							Message.list.init(Message.cache.messageType, data);
						})
					}
				}else if(type == "remind"){
					params = {
						"readStatus":"0",
						"type" : "0"
					}
					Message.remind.init(params);
					if(Message.cache.noticeRead == "no"){
						$(".remind-tabs").find("li:eq(0)").trigger("click");
					}else if(Message.cache.noticeRead == "all"){
						$(".remind-tabs").find("li:eq(1)").trigger("click");
					}
				}else if(type == "comment"){
					Message.iReply.init(Message.cache.iReplyType);
				}else if(type == "at"){
					//Message.iReceive.init();
				}
			})
			
			//左侧菜单
			$(".message-menu").on("click",".input-group-addon",function(){
				var $this = $(this);
				alert(1);
			})

			//普通消息文本框字数限制
			$("#msg-write-content").on("keyup keydown",function(){
				var $this = $(this);
				var $num = $writePanel.find(".num").find("span");
				var maxlimit = 140;
				if ($this.val().length > maxlimit){
					$this.val($this.val().substring(0, maxlimit)); 
				}
				$num.text(maxlimit - $this.val().length);
			})
			
			//发布消息按钮事件
			$writePanel.on("click","#write-submit",function(){
				var _content = $writePanel.find("#msg-write-content").val();
				if($.trim(_content) == ""){
					OBPM.message.showError("内容不能为空!");
					return false;
				}
				var _deptId = $("#deptHidden").val(); 
				var _deptName = $("#deptInput").val();
				if(_deptId == "" || _deptName == ""){
					OBPM.message.showError("发送范围不能为空!");
					return false;
				}
				var _dept = [];
				var _deptIdArr = _deptId.split(";"); 
				var _deptNameArr = _deptName.split(";");
				for(var i = 0; i < _deptIdArr.length; i++){
					_dept[i] = {"deptId":_deptIdArr[i],"deptName":_deptNameArr[i]};
				}
				var _receiverInfoStr = JSON.stringify({"user":[],"dept":_dept});
				var _scopeValue;
				_dept.length > 0 ? _scopeValue = "2" : _scopeValue = ""
				var params = {
					"content.content" : _content,
					"content.attachment" : "["+$("#msg-write-upload").val()+"]",
					"content.scope" : _scopeValue,
					"receiverInfo" : _receiverInfoStr,
					"content.type" : 0
				}
				Message.Service.saveMessage(params,function(){
					OBPM.message.showSuccess("发布成功!");
					Message.Service.getMessageList({},function(data){
						Message.list.init(Message.cache.messageType,data);
						$writePanel.find("#msg-write-content").val("");
						$writePanel.find(".pic-item").remove();
						$writePanel.find(".file-item").remove();
						$("#deptHidden").val(""); 
						$("#deptInput").val("");
						$("#msg-write-upload").val("");
						$writePanel.find(".num").find("span").text("140");	
						Message.cache.uploader.reset();
					});
				})
			});
			
			//表情按钮
			$writePanel.on("click","#msg-write-face",function(){
				$("#facebox").remove();
				var $this = $(this);
				var top = $this.position().top + 30;
				var left = $this.position().left;
				Message.main.renderFace($this,top,left);
			});
			
			//文本框中插入表情
			$("body").on("click","#facebox .faces_list_box li", function(){
				var $this = $(this);
				var $assign = $("#msg-write-content");
				var title = $this.attr("title");
				var $num = $writePanel.find(".num").find("span");
				var maxlimit = 140;
				if (($assign.val()+"["+title+"]").length <= maxlimit){
					$assign.val($assign.val()+"["+title+"]");
				}
				$num.text(maxlimit - $assign.val().length);
			});

			//关闭表情面板
			$("body").on("click","#facebox .facelist-ficon_close", function(){
				$(this).parents("#facebox").remove();
			});

			//显示公告填写
			$writePanel.on("click","#new-notice-btn",function(){
				$noticePanel.modal('show');
			});
			
			//显示图片附件删除按钮
			$writePanel.on("mouseenter",".pic-item",function(){
				$(this).find(".icon-delete").fadeIn("fast");
			});
			
			//隐藏图片附件删除按钮
			$writePanel.on("mouseleave",".pic-item",function(){
				$(this).find(".icon-delete").fadeOut("slow");
			});
			
			//附件删除
			$writePanel.on("click",".icon-delete",function(){
				var $this = $(this);
				var name = $this.parents("[data-name]").data("name");
				var inputStr = $("#msg-write-upload").val();
				var inputJson = JSON.parse("["+inputStr+"]");
				var uploaderFiles = Message.cache.uploader.getFiles();
				
				OBPM.message.showConfirm("确认删除吗？","删除后将无法恢复",function(){
					for(var i = 0; i < inputJson.length; i++){
						if(inputJson[i].name == name){
							inputJson.splice(i, 1);
						}
					}
					
					for(var r = 0; r < uploaderFiles.length; r++){
						if(uploaderFiles[r].name == name){
							Message.cache.uploader.removeFile( uploaderFiles[r] )
						}
					}

					var responseStr = JSON.stringify(inputJson);
					var newInputStr = responseStr.substr(responseStr.indexOf("[")+1, responseStr.lastIndexOf("]")-1);
					$("#msg-write-upload").val(newInputStr);	
					$this.parents("[data-name]").remove();
					OBPM.message.showSuccess("删除成功!");
				})	
			});

			//发布公告按钮事件
			$noticePanel.on("click","#notice-submit",function(){
				var _title = $noticePanel.find("#notice-title").val();
				if(_title == ""){
					OBPM.message.showError("标题不能为空!");
					return false;
				}
				if(_title.length > 200){
					OBPM.message.showError("标题不允许超过200个字符!");
					return false;
				}
				var _content = Message.cache.Uedit.getContent();
				if(_content == ""){
					OBPM.message.showError("内容不能为空!");
					return false;
				}
				var _deptId = $("#deptHidden2").val(); 
				var _deptName = $("#deptInput2").val();
				if(_deptId == "" || _deptName == ""){
					OBPM.message.showError("发送范围不能为空!");
					return false;
				}
				var _dept = [];
				var _deptIdArr = _deptId.split(";"); 
				var _deptNameArr = _deptName.split(";");
				for(var i = 0; i < _deptIdArr.length; i++){
					_dept[i] = {"deptId":_deptIdArr[i],"deptName":_deptNameArr[i]};
				}
				var _receiverInfoStr = JSON.stringify({"user":[],"dept":_dept});
				var _scopeValue;
				_dept.length > 0 ? _scopeValue = "2" : _scopeValue = "";
				var _comment = $noticePanel.find("#notice-comment").prop("checked");
				var _sticky = $noticePanel.find("#notice-sticky").prop("checked");
				var params = {
					"content.title" : _title,
					"content.content" : _content,
					"content.attachment" : "",
					"content.scope" : _scopeValue,
					"receiverInfo" : _receiverInfoStr,
					"content.type" : 1,
					"content.comment" : _comment,
					"content.sticky" : _sticky
				}
				Message.Service.saveAnnouncement(params,function(){
					$noticePanel.modal('hide');
					OBPM.message.showSuccess("发布成功!");
					Message.Service.getAnnouncementList({},function(data){
						Message.list.init(Message.cache.messageType, data);
					});
				})

				$noticePanel.find("#notice-title").val("");
				Message.cache.Uedit.setContent("");
				$("#deptHidden2").val(""); 
				$("#deptInput2").val("");
				$noticePanel.find("#notice-comment").prop("checked",false);
				$noticePanel.find("#notice-sticky").prop("checked",false);
				
			});
			
			//消息tab显示前处理
			$messageContent.find('.nav a[data-toggle="tab"]').on('show.bs.tab', function (e) {
				var $this = $(this);
				Message.cache.messageType = $this.attr("href").substr(1);
				var params = {}
				if(Message.cache.messageType == "message-all"){
					Message.Service.getMessageList(params,function(data){
						Message.list.init(Message.cache.messageType, data);
					})
				}else if(Message.cache.messageType == "message-notice"){
					Message.Service.getAnnouncementList(params,function(data){
						Message.list.init(Message.cache.messageType, data);
					})
				}
			})

			//预览
			$messageContent.on('click',".msg-attachment-file-item,.msg-attachment-pic-item", function(){	
				var $this = $(this);
				var id = $this.data("id")
				var extName = $this.data("extname");
				var url = $this.data("url");
				var fileName = $this.text();
				if(fileName==""){
					fileName = id;
				}
				var params = {
					"id": id,
					"extName": extName,
					"url": url
				}
				Message.Service.getAttachementUrl(params,function(data){
					Message.Util.previewFile(fileName, id, extName, url);
				})
			})
			
			//消息评论栏点击事件
			$messageContent.on('click',".msg-handle", function(){
				var $this = $(this);
				var $commentPanel = $(this).next();
				$commentPanel.toggle();
				if($commentPanel.is(":visible")){
					var messageId = $commentPanel.data("id");
					var params = {"messageId":messageId};
					Message.Service.getCommentList(params,function(data){
						Message.comment.init($commentPanel,data);
					});
				}
				$("#message-center-panel").getNiceScroll().resize();
			})
			
			//消息评论栏文本框字数限制
			$messageContent.on("keyup keydown",".msg-comment-textarea textarea",function(){
				var $this = $(this);
				var $num = $this.parents(".msg-comment-write").find(".num").find("span");
				var maxlimit = 140;
				//由回复某评论改为回复消息时
				if (Message.cache.commentUser != "" && $this.val().indexOf(Message.cache.commentUser) < 0){
					$this.siblings("[name='toCommentUser']").val("");
					$this.siblings("[name='commentId']").val("");
					$this.siblings("[name='tocontent']").val($this.parents(".msg-content-item").find(".msg-txt").text());
				}
				if ($this.val().length > maxlimit){
					$this.val($this.val().substring(0, maxlimit)); 
				}else{
					$num.text(maxlimit - $this.val().length);
				}
			})
			
			//消息删除
			$messageContent.on("click",".msg-btn-delete",function(){
				var $this = $(this);
				var _messageId = $this.parent().data("id");
				var params = {
					"messageId" : _messageId
				}
				OBPM.message.showConfirm("确认删除吗？","删除后将无法恢复",function(){
					Message.Service.delectMessage(params,function(){
						OBPM.message.showSuccess("删除成功!");
						Message.Service.getMessageList({},function(data){
							Message.list.init(Message.cache.messageType, data);
						});
					})
				})				
			})
			
			//查看公告详情
			$messageContent.on("click",".notice-show",function(){

				var $contentItem = $(this).parents(".msg-content-item");
				var params = {
					"messageId" : $contentItem.data("id")
				}
				
				Message.Service.getMessage(params,function(data){
					var _title = data.message.title;
					var _sender = data.message.sender;
					var _createTime = new Date(data.message.createTime.time)
					var _time = _createTime.getFullYear()+"-"+(_createTime.getMonth()+1)+"-"+_createTime.getDate()+" "+_createTime.getHours()+":"+_createTime.getMinutes()+":"+_createTime.getSeconds();
					var _dept = data.message.senderDept;
					var _content = data.message.content;
					var _data = {
						"title": _title,
						"sender": _sender,
						"time": _time,
						"dept": _dept,
						"content": _content
					};
										
					var html = template('notice-show', _data);
					Message.cache.visibleId = $("#notice-show-panel").siblings(":visible").not(".message-menu").attr("id");
					$("#notice-show-panel").siblings().not(".message-menu").hide();
					$("#notice-show-panel").html(html).show();
				})
			});
			
			//公告详情返回按钮
			$message.on("click",".notice-show-close",function(){
				$("#notice-show-panel").hide();
				$("#"+Message.cache.visibleId).show();
			});
			
			//消息评论按钮事件
			$messageContent.on("click",".msg-comment-submit",function(){
				var $this = $(this);
				var $commentPanel = $this.parents(".msg-comment-panel");
				var _touser = $commentPanel.find("input[name='touser']").val();
				var _touserId = $commentPanel.find("input[name='touserid']").val();
				var _commentId = $commentPanel.find("input[name='commentId']").val();
				var _messageId = $commentPanel.data("id");
				var _content = $commentPanel.find(".msg-comment-textarea textarea").val();
				var _tocontent = $commentPanel.find("input[name='tocontent']").val();

				if(_content == ""){
					OBPM.message.showError("内容不能为空!");
					return false;
				}

				var params = {
					"content.toUser" : _touser,
					"content.toUserId" : _touserId,
					"content.messageId" : _messageId,
					"content.commentId" : _commentId,
					"toContent" : _tocontent,
					"content.content" : _content,
					"content.attachment" : ""
				}
				Message.Service.saveComment(params,function(){
					OBPM.message.showSuccess("评论成功!");
					$commentPanel.find(".msg-comment-textarea textarea").val("");
					Message.Service.getCommentList({"messageId":_messageId},function(data){
						Message.comment.init($commentPanel,data);
					});
				})
			});
			
			//显示评论操作栏
			$messageContent.on("mouseenter",".comment-item",function(){
				var $this = $(this);
				$this.find(".comment-edit").show();
			})
			
			//隐藏评论操作栏
			$messageContent.on("mouseleave",".comment-item",function(){
				var $this = $(this);
				$this.find(".comment-edit").hide();
			})
			
			//评论栏回复
			$messageContent.on("click",".comment-reply",function(){
				var $this = $(this);
				var $commentPanel = $this.parents(".msg-comment-panel");
				var $commentItem = $this.parents(".comment-item");
				
				var _sender = $commentItem.data("sender");
				var _senderId = $commentItem.data("senderid");
				var _commentId = $commentItem.data("id");
				var _commentText = $commentItem.find(".comment-text").text();
				
				$commentPanel.find("input[name='touser']").val(_sender);
				$commentPanel.find("input[name='tocontent']").val(_commentText);
				$commentPanel.find("input[name='toCommentUser']").val("回复 @"+_sender+" ");
				$commentPanel.find("input[name='touserid']").val(_senderId);
				$commentPanel.find("input[name='commentId']").val(_commentId);
				$commentPanel.find(".msg-comment-textarea textarea").val("回复 @"+_sender+" ");
				Message.cache.commentUser = "回复 @"+_sender+" ";
			})
			
			//评论栏删除
			$messageContent.on("click",".comment-delete",function(){
				var $this = $(this);
				var $commentPanel = $this.parents(".msg-comment-panel");
				var $commentItem = $this.parents(".comment-item");
				var _commentId = $commentItem.data("id");
				var _messageId = $commentPanel.data("id");
				var params = {
					"commentId" : _commentId,
					"messageId" : _messageId
				};
				OBPM.message.showConfirm("确认删除吗？","删除后将无法恢复",function(){
					Message.Service.delectComment(params,function(){
						OBPM.message.showSuccess("删除成功!");
						$commentPanel.find(".msg-comment-textarea textarea").val("");
						Message.Service.getCommentList({"messageId":_messageId},function(data){
							Message.comment.init($commentPanel,data);
						});
					})
				});
			});
			
			//“我回复的”tab切换
			$("#comment-panel").on("click",".ireply-tabs a",function(){
				var $this = $(this);
				var type = $this.attr("type");
				Message.cache.iReplyType = type;
				Message.iReply.init(Message.cache.iReplyType);
			});
			
			//“我回复的”删除
			$("#comment-panel").on("click",".comment-delete",function(){
				var $this = $(this);
				var _id = $this.parent().data("id");
				var _commentId = $this.parent().data("commentid");
				var _messageId = $this.parent().data("messageid");
				var params = {
					"commentId" : _id,
					"messageId" : _messageId
				};
				OBPM.message.showConfirm("确认删除吗？","删除后将无法恢复",function(){
					Message.Service.delectComment(params,function(){
						OBPM.message.showSuccess("删除成功!");
						Message.iReply.init(Message.cache.iReplyType);
					})
				});
			});
			
			//查看事项详情
			$remindPanel.on("click",".remind-list-content",function(){
				var $this = $(this);
				
				var url = $this.find("a").data("url");
				var id = $this.parent().data("id");

				Message.Service.setRead({"ids":id},function(){
					$(".remind-tabs").find("li.active").trigger("click");
				});
				if(url){
					if (parent && parent.addTab) {
						parent.addTab(id,$this.text(),url);
					}else{
						window.open(url, $this.text());
					}
				}
				
			});
			
			//事项已读未读切换
			$remindPanel.on("click",".remind-tabs li",function(){
				var $this = $(this);
				var read = $this.data("read");
				var type = $(".notice-select-type").find("a.dropdown-toggle span").attr("type") == undefined ? 0 : $(".notice-select-type").find("a.dropdown-toggle span").attr("type");
				var params;
				$this.siblings("li").removeClass("active");
				$this.addClass("active");
				
				Message.cache.noticeRead = read;
				if(read == "all"){
					params = {
						"readStatus":""	,
						"type" : type
					}
				}else if(read == "no"){
					params = {
						"readStatus":"0",
						"type" : type
					}
				}
				Message.remind.init(params);
			});
			
			//事项类型选择
			$remindPanel.on("click",".notice-select-type ul a",function(){
				
				var $this = $(this);
				var type = $this.attr("_value");
				var text = $this.text();
				if(type != "0"){
					$this.parents(".notice-select-type").find("a.dropdown-toggle").html(text + " <span class='caret' type='"+ type +"'></span>");
				}else{
					$this.parents(".notice-select-type").find("a.dropdown-toggle").html("类型 <span class='caret' type='"+ type +"' ></span>");
				}
				var params = {
					"readStatus": Message.cache.noticeRead == "all" ? "" : "0",
					"type": type
				}
				Message.remind.init(params);
			});
			
			//事项当页已读
			$remindPanel.on("click",".btn-read",function(){
				var $remindList = $(".remind-list-panel");
				var ids = "";
				$remindList.find(".remind-list-item[data-read='false']").each(function(){
					var id = $(this).data("id");
					ids += id + ",";
				})
				var params = {"ids":ids.substr(0,ids.length-1)};
				Message.Service.setRead(params,function(){
					$(".remind-tabs").find("li.active").trigger("click");
				});
			});

			//删除事项
			$remindPanel.on("click",".remind-item-delete",function(){
				var $this = $(this);
				var $remindItem = $this.parents(".remind-list-item");
				var _noticeId = $remindItem.data("id");
				var readStatus = $(".remind-tabs li.active").attr("data-read") == "no" ? "0" : "";
				var type = $(".notice-select-type").find("a.dropdown-toggle span").attr("type");
				var params = {
					"noticeId" : _noticeId
				};		
				OBPM.message.showConfirm("确认删除吗？","删除后将无法恢复",function(){
					Message.Service.deleteRemindItem(params,function(){
						OBPM.message.showSuccess("删除成功!");
						var params = {
							"readStatus": readStatus,
							"type":type
						}
						Message.remind.init(params);
					})
				});
			});
			
			$(document).on("click",function(e){
				var $this = $(e.target);
				if($this.closest("#facebox").size()<=0){
					if(!$this.hasClass("func-face")){
						if($this.parent(".func-face").size() <= 0){
							$("#facebox").remove();
						}
					}
				}
			})
		}
	},
	/**
	 * 公司动态
	 */
	list : {
		init : function(messageType,data) {
			this.renderPage(messageType,data);
			//this.renderList(messageType,data);
			
		},
		/**
		 * 渲染动态列表
		 */
		renderList : function(messageType,data){
			
			if(data && data.datas){
				data.contextPath = contextPath;
				data.user = USER.name;
				data.userid = USER.id;

				for(var i = 0;i < data.datas.length;i++){
					var senderId = data.datas[i].senderId;
					var createTime = data.datas[i].createTime;
					var attachment = data.datas[i].attachment;
					var content = data.datas[i].content;
					if(data.datas[i].type == 1){
						content = data.datas[i].content = $(content).text().length > 200 ? $(content).text().substr(0,200) + "..." : $(content).text();
					}

					data.datas[i].avatar = Common.Util.getAvatar(senderId);
					data.datas[i].contentReplace = Message.Util.replaceFace(content);
					data.datas[i].createTimeChange = Common.Util.calculateTime(createTime.replace("T"," "),"Y-m-d H:i");
					if(attachment && attachment != ""){
						var attachmentObj = JSON.parse(attachment)
						for(var j = 0;j < attachmentObj.length;j++){
							var extName = attachmentObj[j].extName;
							attachmentObj[j].extName = Message.Util.checkExtendName(extName);
						}
						data.datas[i].attachmentObj = attachmentObj;
					}
				}
				var html = template('message-item', data);
				if(messageType == "message-all"){
					$("#message-all .message-list-box").html(html);
				}else if(messageType == "message-notice"){
					$("#message-notice .message-list-box").html(html);
				}
				
				if(data.rowCount <= 0){
					$("#"+messageType).find("#pagination-panel").hide();
				}else{
					$("#"+messageType).find("#pagination-panel .totalRowPanel").text("总条数："+data.rowCount);
				}
			}
		},
		renderPage : function(messageType,data){
			var $message = $("#"+messageType);			
			Message.paginationInit($message,data,function(no){
				var params = {
    	    		"_currpage":no + 1,
    	    		"_rowcount":30	
    	    	}
				
				if(data.rowCount <= 0){
					$message.find("#pagination-panel").hide();
				}else{
					$message.find("#pagination-panel .totalRowPanel").text("总条数："+data.rowCount);
				}
				
	    		if(Message.cache.messageType == "message-all"){
					Message.Service.getMessageList(params,function(data){
						Message.list.renderList(Message.cache.messageType, data);
					})
				}else if(Message.cache.messageType == "message-notice"){
					Message.Service.getAnnouncementList(params,function(data){
						Message.list.renderList(Message.cache.messageType, data);
					})
				}
	    		$("#message-center-panel").getNiceScroll().resize();
			})
		}
	},
	/**
	 * 消息详情
	 */
	showMessage : {
		init : function() {
			this.renderMessage();			
		},
		/**
		 * 渲染详细页面
		 */
		renderMessage: function(){
			var params = {
				"messageId" : messageId	
			}
			Message.Service.getMessage(params,function(data){
				var _title = data.message.title;
				var _sender = data.message.sender;
				var _createTime = new Date(data.message.createTime.time)
				var _time = Common.Util.calculateTime(_createTime.getFullYear()+"-"+(_createTime.getMonth()+1)+"-"+_createTime.getDate()+" "+_createTime.getHours()+":"+_createTime.getMinutes()+":"+_createTime.getSeconds());
				var _dept = data.message.senderDept;
				var _content = data.message.content;
				var _data = {
					"title": _title,
					"sender": _sender,
					"time": _time,
					"dept": _dept,
					"content": _content
				};
				
				var html = template('notice-show', _data);
				Message.cache.visibleId = "message-center-panel";
				$("#msg-content-panel").find('.nav a:first').tab('show')
				$("#notice-show-panel").siblings().not(".message-menu").hide();
				$("#notice-show-panel").html(html).show();
			})
		}
	},
	/**
	 * 事项提醒
	 */
	remind : {
		
		init : function(params) {
			Message.Service.getRemindList(params,function(data){
				Message.remind.renderPage(params,data);
			})
			this.renderNum();
		},
		renderNum: function(){
			Message.Service.getNotificationCount(function(data){
				var num = parseInt(data.notice) > 99 ? "99+" : data.notice;
				var $topBadge = top.$(".user-box .badge");
				if(data.notice > 0){
					$(".message-menu").find("a[data-type='remind']>.badge").text(num).show();
					if($topBadge.size()>0){
						$topBadge.text(num).show();
					}
				}else{
					$(".message-menu").find("a[data-type='remind']>.badge").hide();
					if($topBadge.size()>0){
						$topBadge.hide();
					}
				}	
			})
		},
		/**
		 * 渲染详细页面
		 */
		renderList: function(params){
			Message.Service.getRemindList(params,function(data){
				data.contextPath = contextPath;
				for(var i = 0;i < data.datas.length;i++){
					var createTime = data.datas[i].createTime;
					data.datas[i].createTimeChange = Common.Util.calculateTime(createTime.replace("T"," "));
					var linkParams = data.datas[i].linkParams;
					if (linkParams.indexOf("http") >= 0) {//兼容旧数据
						var _docid = Common.Util.getQueryString(linkParams,"_docid");
						var _formid = Common.Util.getQueryString(linkParams,"_formid");
						var application = Common.Util.getQueryString(linkParams,"application");
						var mode = Common.Util.getQueryString(linkParams,"mode");
						
						data.datas[i].linkParams = {
							"_docid" : _docid,
							"_formid" : _formid,
							"application" : application,
							"mode" : mode
						}
					}else{
						data.datas[i].linkParams = JSON.parse(linkParams);
						data.datas[i].linkParams.backurl = "../../../portal/H5/closeTab.jsp";
					}
				}
				var html = template('remind-list-item', data);
				$(".remind-list-panel").find("ul").html(html);
				Message.remind.renderNum();
			});
		},
		renderPage : function(params,data){
			var $remind = $(".remind-list-panel");
			$remind.find("#pagination-panel").remove();
			Message.paginationInit($remind,data,function(no){
				params._currpage = no + 1;
				params._rowcount = 30;
				if(data.rowCount <= 0){
					$remind.find("#pagination-panel").hide();
				}else{
					$remind.find("#pagination-panel .totalRowPanel").text("总条数："+data.rowCount);
				}
				Message.Service.getRemindList(params,function(data){
					Message.remind.renderList(params);
				})
	    		$("#remind-panel").getNiceScroll().resize();
			})
		}
	},
	/**
	 * 我回复的
	 */
	iReply : {
		
		init : function() {
			if(Message.cache.iReplyType == "mycomment"){
				Message.Service.getIReplyList({},function(data){
					Message.iReply.renderPage(data);
				})
			}else{
				Message.Service.getIReceiveList({},function(data){
					Message.iReply.renderPage(data);
				})
			}
		},
		/**
		 * 渲染详细页面
		 */
		renderMyList: function(data){
			data.contextPath = contextPath;
			for(var i = 0;i < data.datas.length;i++){
				var sender = data.datas[i].sender;
				var senderId = data.datas[i].senderId;
				var createTime = data.datas[i].createTime;
				var toContent = data.datas[i].toContent;
				var toUser = data.datas[i].toUser;
				var toUserId = data.datas[i].toUserId;
				if(toUserId == USER.id && toUser == USER.name){
					data.datas[i].toUser = "我";
				}
				data.datas[i].toContentReplace = Message.Util.replaceFace(toContent);
				data.datas[i].avatar = Common.Util.getAvatar(senderId);
				data.datas[i].createTimeChange = createTime.replace("T"," ");
			}
			var html = template('ireply-panel-tpl', data);
			$(".ireply-content .ireply-content-list").html(html);
		},
		renderToMeList: function(data){
			data.contextPath = contextPath;
			for(var i = 0;i < data.datas.length;i++){
				var sender = data.datas[i].sender;
				var senderId = data.datas[i].senderId;
				var createTime = data.datas[i].createTime;
				var toContent = data.datas[i].toContent;
				var toUser = data.datas[i].toUser;
				var toUserId = data.datas[i].toUserId;
				if(toUserId == USER.id && toUser == USER.name){
					data.datas[i].toUser = "我";
				}
				data.datas[i].toContentReplace = Message.Util.replaceFace(toContent);
				data.datas[i].avatar = Common.Util.getAvatar(senderId);
				data.datas[i].createTimeChange = createTime.replace("T"," ");
			}
			var html = template('ireply-panel-tpl', data);
			$(".ireply-me-content .ireply-me-content-list").html(html);
		},
		renderPage : function(data){
			
			var $reply;
			if(Message.cache.iReplyType == "mycomment"){
				$reply = $(".ireply-content");	
			}else{
				$reply = $(".ireply-me-content");
			}			
			Message.paginationInit($reply,data,function(no){
				var params = {
					"_currpage" : no + 1,
					"_rowcount" : 30
				}
				
				if(data.rowCount <= 0){
					$reply.find("#pagination-panel").hide();
				}else{
					$reply.find("#pagination-panel .totalRowPanel").text("总条数："+data.rowCount);
				}
				
				if(Message.cache.iReplyType == "mycomment"){
					Message.Service.getIReplyList(params,function(data){
						Message.iReply.renderMyList(data);
					})
				}else{
					Message.Service.getIReceiveList(params,function(data){
						Message.iReply.renderToMeList(data);
					})
				}
	    		$("#comment-panel").getNiceScroll().resize();
			})
		}
	},
	/**
	 * 提到我的
	 */
	iReceive : {
		init : function() {
			this.renderList();	
		},
		/**
		 * 渲染详细页面
		 */
		renderList: function(){
			var params = {};
			Message.Service.getIReceiveList(params,function(data){
				/*data.contextPath = contextPath;
				for(var i = 0;i < data.datas.length;i++){
					var sender = data.datas[i].sender;
					var senderId = data.datas[i].senderId;
					var createTime = data.datas[i].createTime;
					var toContent = data.datas[i].toContent;
					var toUser = data.datas[i].toUser;
					var toUserId = data.datas[i].toUserId;
					if(toUserId == USER.id && toUser == USER.name){
						data.datas[i].toUser = "我";
					}
					data.datas[i].toContentReplace = Message.Util.replaceFace(toContent);
					data.datas[i].avatar = Common.Util.getAvatar(senderId);
					data.datas[i].createTimeChange = createTime.replace("T"," ");
				}*/

				var html = template('ireply-panel-tpl', data);
				$(".ireply-content").html(html);
			})
		},
		/**
		 * 渲染详细页面
		 */
		renderAtCommentList: function(){
			var params = {};
			Message.Service.getIReplyList(params,function(data){
				data.contextPath = contextPath;
				for(var i = 0;i < data.datas.length;i++){
					var sender = data.datas[i].sender;
					var senderId = data.datas[i].senderId;
					var createTime = data.datas[i].createTime;
					var toContent = data.datas[i].toContent;
					var toUser = data.datas[i].toUser;
					var toUserId = data.datas[i].toUserId;
					if(toUserId == USER.id && toUser == USER.name){
						data.datas[i].toUser = "我";
					}
					data.datas[i].toContentReplace = Message.Util.replaceFace(toContent);
					data.datas[i].avatar = Common.Util.getAvatar(senderId);
					data.datas[i].createTimeChange = createTime.replace("T"," ");
				}

				var html = template('ireply-panel-tpl', data);
				$(".ireply-content").html(html);
			})
		}
	},
	/**
	 * 评论
	 */
	comment : {

		init : function($obj,data) {
			this.renderList($obj,data)
		},
		/**
		 * 渲染评论列表
		 */
		renderList : function($obj,data){
			data.contextPath = contextPath;
			if($obj.parent().data("admin")){
				data.owner = true;
			}else{
				data.owner = false;
			}
			for(var i = 0;i < data.datas.length;i++){
				var sender = data.datas[i].sender;
				var senderId = data.datas[i].senderId;
				var createTime = data.datas[i].createTime;
				if(senderId == USER.id && sender == USER.name){
					data.datas[i].owner = true;
				}else{
					data.datas[i].owner = false;
				}
				//var attachment = data.datas[i].attachment;
				data.datas[i].avatar = Common.Util.getAvatar(senderId);
				data.datas[i].createTimeChange = Common.Util.calculateTime(createTime.replace("T"," "));
				/*if(attachment && attachment != ""){
					var attachmentObj = JSON.parse(attachment)
					data.datas[i].attachmentObj = attachmentObj;
				}*/
			}

			if(data.datas.length > 0){
				$obj.siblings(".msg-handle").html('<i class="fa fa-comment"></i> 评论 '+data.datas.length);
			}

			var html = template('message-comment-item', data);
			$obj.find(".msg-comment-list ul").html(html);
		}
	},
	//初始化上传控件
	uploadInit : function(key,option) {  
		Message.cache.uploader = WebUploader.create({
		    auto: true,
		    swf: '../js/webuploader/Uploader.swf',
		    server: contextPath+'/message/servlet/upload',
		    pick: '#filePicker-'+key
		    /*accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }*/
		});

		Message.cache.uploader.onUploadSuccess = function(file,response){
			var inputStr = $("#msg-write-upload").val();
			delete response._raw;
			var responseStr = JSON.stringify(response);
			var newInputStr = inputStr == "" ? responseStr : inputStr + "," + responseStr;
			$("#msg-write-upload").val(newInputStr);
			if(key == "write"){
				Message.uploadListInit(key,"["+responseStr+"]");
			}else{
				Message.uploadListInit(key,"["+newInputStr+"]");
			}
		};
		
		Message.cache.uploader.onStartUpload = function(file){
			$("#loadingDivBack").show();
		};
		
		Message.cache.uploader.onUploadFinished = function(file){
			$("#loadingDivBack").hide();
		};
		
		Message.cache.uploader.onUploadError = function(file){
			OBPM.message.showError("上传失败!");
		};
	},
	//初始化图片
	uploadListInit : function(key,str){
		var uplistJson = JSON.parse(str);
		
		for(var i = 0;i < uplistJson.length;i++){
			var extName = uplistJson[i].extName.substr(1);
			uplistJson[i].extName = Message.Util.checkExtendName(extName);
		}
		
		
		var data = {
			contextPath : contextPath,
			datas : uplistJson
		}
		
		debugger
		
		if(key == "write"){
			var uploadHtml = template('message-up-item', data);
			for(var i = 0; i < uplistJson.length; i++){
				var upType = uplistJson[i].type;
				if(upType == "image"){
					$("#"+key+"-uploader-list .uploadlist-pic ul").append(uploadHtml);
				}else if(upType == "file"){
					$("#"+key+"-uploader-list .uploadlist-file").append(uploadHtml);
				}
			}
		}else{
			var picHtml = template('message-up-item', data);
			$("#"+key+"-uploader-list").html(picHtml);
		}
	},
	//初始化翻页组件
	paginationInit : function($obj,data,callback){
		if(data && data.datas){
			var rowCount = data.rowCount;
			var pageNo = data.pageNo;
			var linesPerPage = data.linesPerPage;
			var pageCount = data.pageCount;
		}else{
			var rowCount = 0;
			var pageNo = 1;
			var linesPerPage = 30;
			var pageCount = 1;
		}
		var page = template('pagination-panel-tpl', data);
		$obj.find("#pagination-panel").remove();
		$obj.append(page);
		$obj.find("#pagination-panel .pagination-body").pagination(rowCount, {
    		current_page: (pageNo - 1),
    		items_per_page: linesPerPage,
    		prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
    		next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
    	    num_edge_entries: 1,
    	    num_display_entries: 5,
    	    callback:function(data){
    	    	if(callback && typeof callback == "function"){
					callback(data);
				}
    	    }
    	});
	}
}