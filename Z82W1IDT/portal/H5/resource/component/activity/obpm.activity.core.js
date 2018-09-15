/**
 * 操作按钮执行框架
 * <p>框架主要封装操作按钮的执行流程，和一些通用操作接口，在执行过程中，具体的行为实现由具体的按钮类型实例完成</p>
 * @author Happy
 */
var Activity ={
		
		_LOCK:false,//操作按钮触发锁，用于避免多次触发执行
		/**
		 * 触发按钮点击动作
		 * @param actId
		 * 		操作id
		 * @param actType
		 * 		操作类型代码
		 * @param params
		 * 		额外参数设置
		 */
		doExecute:function(actId,actType,params){
			var activityType = null;//操作类型实例
			switch (actType) {
			case 1://载入视图
				activityType = new QueryBtn(actId,params);
				break;
			case 2://新建
				activityType = new CreateBtn(actId,params);
				break;
			case 3://删除
				activityType = new DeleteBtn(actId,params);
				break;
			case 4://保存并启动流程
				activityType = new SaveStartWorkflow(actId,params);
				break;
			case 5://流程处理
				activityType = new WorkflowProcess(actId,params);
				break;
			case 8://关闭窗口
				activityType = new CloseWindowBtn(actId,params);
				break;
			case 9://保存并关闭窗口
				activityType = new SaveCloseWindowBtn(actId,params);
				break;
			case 10://返回
				activityType = new BackBtn(actId,params);
				break;
			case 11://保存并返回
				activityType = new SaveBackBtn(actId,params);
				break;
			case 13://无类型
				activityType = new NoneBtn(actId,params);
				break;
			case 14://html打印
				activityType = new HtmlPrintBtn(actId,params);
				break;
			case 16://导出excel
				activityType = new ExportToExcelBtn(actId,params);
				break;
			case 15://html打印(带流程历史)
				activityType = new HtmlPrintWithHisBtn(actId,params);
				break;
			case 18://清空数据
				activityType = new ClearAllBtn(actId,params);
				break;
			case 19://保存草稿（不校验）
				activityType = new SaveWithoutValidateBtn(actId,params);
				break;
			case 20://批量提交
				activityType = new BatchApproveBtn(actId,params);
				break;
			case 21://保存并复制
				activityType = new SaveCopyBtn(actId,params);
				break;
			case 25://导出pdf
				activityType = new ExportToPdfBtn(actId,params);
				break;
			case 26://文件下载
				activityType = new FileDownloadBtn(actId,params);
				break;
			case 27://文件下载
				activityType = new ExcelImportBtn(actId,params);
				break;
			case 28://电子签章
				activityType = new SignatureBtn(actId,params);
				break;
			case 29://批量电子签章
				activityType = new BatchSignatureBtn(actId,params);
				break;
			case 30://自定义打印（套打）
				activityType = new FlexPrintBtn(actId,params);
				break;
			case 33://启动流程
				activityType = new StartWorkflow(actId,params);
				break;
			case 34://保存
				activityType = new SaveBtn(actId,params);
				break;
			case 36://打印视图
				activityType = new PrintViewBtn(actId,params);
				break;
			case 37://通过手机邮件转发
				activityType = new TranspondBtn(actId,params);
				break;	
			case 42://保存并新建
				activityType = new SaveNewBtn(actId,params);
				break;
			case 43://跳转
				activityType = new JumpToBtn(actId,params);
				break;
			case 45://归档
				activityType = new ArchiveBtn(actId,params);
				break;
			case 46://在线签章
				activityType = new SignBtn(actId,params);
				break;
			default:
				break;
			}
			if(!activityType) return;
			Activity.doBefore(activityType);
			
		},
		
		/**
		 * 执行前操作
		 * @param activityType
		 * 		操作类型实例
		 * @returns {Boolean}
		 */
		doBefore : function(activityType){
			showLoading()
			if(Activity._LOCK){
				if($(".sign").find(".btn").length>0){
					OBPM.message.showError("您的印章还没签好,请确认签章!");
				}
				hideLoading()
				return;
			}
			//refreshTickets为局部刷新时暂存刷新控件id的数组
			//初始化于util.js文件
			if(refreshTickets.length > 0){
				OBPM.message.showError("页面准备中");
				hideLoading()
				return;
			}
			
			Activity._LOCK = true;
			setTimeout(function(){
				//一分钟后自动释放锁
				Activity._LOCK = false;
				hideLoading()
			}, 60*1000);
			if(activityType.doBefore){//按钮动作执行前的准备与校验操作
				if(!activityType.doBefore()) {
					Activity._LOCK = false;
					hideLoading()
					return;
				}
			}
			
			jQuery.ajax({
				type: 'POST',
				async:false, 
				traditional : true,
				url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + activityType.actId,
				dataType : 'text',
				data: activityType.getBeforePostData(),
				success:function(result) {
					//若result为空，说明执行前脚本为空，直接执行doAction后返回。
					if(result == null || result == "" || result == "{}"){
						Activity.doAction(activityType);
					}
					if(result != null && result != "" &&  result != "{}"){
						result = result.replace(/\n/g,"<br/>");
						result = result.replace(/\r/g,"<br/>");
			        	var jsmessage = eval("(" + result + ")");
			        	var type = jsmessage.type;
			        	var content = jsmessage.content;
			        	var changedField = jsmessage.changedField;
			        	
			        	var changeFieldFunction = function(){
				        	if(changedField != undefined && changedField != null && changedField.length > 0){
				        		for(var i = 0; i < changedField.length; ++i){
				        			var field = changedField[i];
				        			for(var key in field){
				        				if(document.getElementsByName(key).length > 0){
				        					document.getElementsByName(key)[0].value = field[key];
				        				}
				        			}
				        		}
				        	}
			        	}
			        	
			        	//执行前脚本更改了字段值
			        	if(type == undefined){
			        		changeFieldFunction();
			        		Activity.doAction(activityType);
			        		hideLoading()
			        		return;
			        	}
			        	
			        	//执行前脚本返回成功通知框
			        	if(type && type == '1'){  
		        			OBPM.message.showSuccess(content);
			        		Activity._LOCK = false;
			        		hideLoading();
			        		hideLoading()
			        		return;
			        	}
			        	
			        	//执行前脚本返回一般信息通知框
			        	if(type && type == '2'){  
		        			OBPM.message.showInfo(content);
			        		Activity._LOCK = false;
			        		hideLoading();
			        		hideLoading()
			        		return;
			        	}
			        	
			        	//执行前脚本返回警告通知框
			        	if(type && type == '3'){  
		        			OBPM.message.showWarning(content);
			        		Activity._LOCK = false;
			        		hideLoading();
			        		hideLoading()
			        		return;
			        	}
			        	//执行前脚本返回危险通知框
			        	if(type && type == '4'){  
		        			OBPM.message.showError(content);
			        		Activity._LOCK = false;
			        		hideLoading();
			        		Activity.recoveryButSta();
			        		hideLoading()
			        		return;
			        	}
			        	
			        	//执行前脚本返回弹出框类型
			        	if(type && type == '16'){  
		        			OBPM.message.showError(content);
			        		Activity._LOCK = false;
			        		hideLoading();
			        		Activity.recoveryButSta();
			        		hideLoading()
			        		return;
			        	}
			        	
			        	//执行前脚本返回确认框类型
			        	if(type && type == '32'){
			        		//确认框通用组件
			        		OBPM.message.showConfirm("",content,function(result){
			        			if(result){//确认框--确认执行
			        				changeFieldFunction();
			        				Activity.doAction(activityType);
			        			} else {//确认框--取消执行
					        		Activity._LOCK = false;
					        		hideLoading()
					        		hideLoading();
			        			}
			        		});
			        		return;
			        	}
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					if(errorThrown.name == "NetworkError"){
						OBPM.message.showError("网络异常");
					}else{
						OBPM.message.showError(errorThrown.message);
					}
					Activity._LOCK = false;
					hideLoading()
				}
			});
			
		},
		/**
		 * 执行按钮操作
		 * @param activityType
		 * 		操作类型实例
		 */
		doAction:function(activityType){
			showLoading()
			if(activityType.doAction){
				//按钮动作时执行的其他业务操作
				if(!activityType.doAction()) {
					Activity._LOCK = false;
					hideLoading()
					return;
				}
			}
			
			//refreshTickets为局部刷新时暂存刷新控件id的数组
			//初始化于util.js文件
			if(refreshTickets.length > 0){
				OBPM.message.showError("页面准备中");
				hideLoading()
				return;
			}
			
			jQuery.ajax({
				type: 'POST',
				async:true, 
				url: contextPath + '/portal/dynaform/activity/execute.action?_activityid=' + activityType.actId,
				dataType : 'json',
				traditional : true,
				data: activityType.getActionPostData(),
				success:function(result) {
					if(result.status==1){
						if(result.message && result.message.length>3){
							if(result.data.resultType != "message"){
								if(parent === window){
									OBPM.message.showSuccess(result.message);
								}else{
									top.OBPM.message.showSuccess(result.message);
								}
							}
						}
						switch (result.data.resultType) {//结果处理类型
						case "form":
							if(activityType.actType!=13){//非自定义按钮可刷新表单
								Activity.refreshForm(activityType);
							}
							break;
						case "view":
							Activity.refreshView(activityType);
							break;
						case "back":
							if(parent === window){
								Activity.back(activityType);
							}else{
								Activity.closeWindow();
							}
							break;
						case "close":
							Activity.closeWindow();
							break;
						case "message":
							if(result.data.resultData.type==16){//Error
								parent.OBPM.message.showError(result.data.resultData.content);
							}else if(result.data.resultData.type==32){//confirm
								
							}else if(result.data.resultData.type==1){//success
								parent.OBPM.message.showSuccess(result.data.resultData.content);
							}else if(result.data.resultData.type==2){//info
								parent.OBPM.message.showInfo(result.data.resultData.content);
							}else if(result.data.resultData.type==3){//warning
								parent.OBPM.message.showWarning(result.data.resultData.content);
							}else if(result.data.resultData.type==4){//Error
								parent.OBPM.message.showError(result.data.resultData.content);
							}
							Activity._LOCK = false;
							hideLoading()
							break;
						case "setParameter"://给activityType传参
							activityType.params.parameter = result.data.resultData;
							break;
						case "validate":
							var fieldErrors = result.data.resultData;
							var content = "";
							for(var name in fieldErrors){
								var fr = fieldErrors[name];
								for(var i in fr){
									var m = fr[i];
									content+=m+";";
								}
							}
							OBPM.message.showError(content);
							Activity._LOCK = false;
							hideLoading()
			        		hideLoading();
			        		Activity.recoveryButSta();
							return;
							break;
						case "exception":
							OBPM.message.showError(result.data.resultData);
							Activity._LOCK = false;
							hideLoading()
			        		hideLoading();
			        		Activity.recoveryButSta();
							return;
							break;
						case "updateItems": //更新主表控件值
							Activity.updateFieldFunction(activityType,result.data.resultData);
							break;
						default:
							break;
						}
						//按钮动作执行后的其他业务操作
						if(activityType.doAfter && typeof activityType.doAfter == "function"){
							activityType.doAfter(result.data);
						}
					}else{
						OBPM.message.showError(result.message);
					}
					setTimeout(function(){
						Activity._LOCK = false;
						hideLoading()
					},3000);
					
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					OBPM.message.showError(errorThrown.message);
					Activity._LOCK = false;
					hideLoading()
				}
			});
			
		},
		/**
		 * 刷新表单
		 * @param activityType
		 * 		操作类型实例
		 */
		refreshForm:function(activityType){
			showLoading();//显示loading层
			fieldValChanged = false;	//保存表单后重置表单修改的状态为未修改
			jQuery.ajax({
				type: 'POST',
				async:true, 
				url: contextPath + '/portal/dynaform/activity/refreshForm.action',
				dataType : 'json',
				data: jQuery("#document_content").serialize(),
				success:function(result) {
					if(result.status==1){
						var datas = result.data;
						var activityHtml = datas["activityHtml"];
						if(activityHtml){
							$("#btn_flow_reminder").remove();
							$(".flow-reminder-panel-node-list").empty();
							$(".formActBtn").html(activityHtml);
						}
						var formHtml = datas["formHtml"];
						if(formHtml){
							$("#_formHtml").html(formHtml)
						}
						//---
						
						try {
							//填充系统字段
							if(datas["systemFields"]){
								for(var n in datas["systemFields"]){
									$("input[name='"+n+"']").val(datas["systemFields"][n]);
								}
							}
							
							//渲染流程处理人列表、流程状态标签、流程历史按钮
							if(datas["processorHtml"]){
								$("#flow-json").html(datas["processorHtml"]);
							}else{
								$("#flow-json").html("[]");
							}
							if(datas["flowStateHtml"]){
								$("#flowStateHtml").html('<div class="flowstate" onmouseover="showFlowState(\'flowstate\');"><b>'+datas["flowStateHtml"]+'</b></div>');
							}
							if(jQuery("input[name='content.stateid']").val().length>0){
								jQuery(".flowbtn").show();
							}
							initFormCommon();//表单公用的初始化方法
							//渲染流程提交按钮
							if($("input[activityType='5']").size()>0){
								FlowPanel.refreshFlowPanel("init");
							}
							adjustDocumentLayout4form();//调整相关文档布局
							
							//收起流程提交界面
							$("#flowprocessDiv").slideUp("fast");
						} catch (e) {
							console.log(e.message);
						}
						
						hideLoading();//隐藏loading层
						
						//---
						/**
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
						**/
					}else{
						OBPM.message.showError(result.message);
						Activity._LOCK = false;
						hideLoading()
					}
					Activity._LOCK = false;
					hideLoading()
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					OBPM.message.showError(errorThrown.message);
					Activity._LOCK = false;
					hideLoading()
				}
			});
		},
		
		/**
		 * 刷新视图
		 * @param activityType
		 * 		操作类型实例
		 */
		refreshView:function(activityType){
			jQuery.ajax({
				type: 'POST',
				async:true, 
				url: contextPath + '/portal/dynaform/activity/refreshView.action',
				dataType : 'json',
				data: jQuery(document.forms[0]).serialize(),
				success:function(result) {
					if(result.status==1){
						var datas = result.data;
						var activityHtml = datas["activityHtml"];
						if(activityHtml){
							//$(".formActBtn").html(activityHtml);
						}
						var viewHtml = datas["viewHtml"];
						if(viewHtml){
							$("#viewHtml").html(viewHtml)
						}
						showLoading();//显示loading层
						try {
							initListComm();	//列表视图公用初始化方法
							//adjustDataIteratorSize();
							setTimeout(function(){
								listViewAdjustLayout();
							},10);	//调整当前窗口布局
						} catch (e) {
							console.log(e.message);
						}
						hideLoading();//隐藏loading层
						
						//---
						/**
						if(callback && typeof callback == "function"){
							callback(result.data);
						}
						**/
					}else{
						OBPM.message.showError(result.message);
						Activity._LOCK = false;
						hideLoading()
					}
					Activity._LOCK = false;
					hideLoading()
					
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					OBPM.message.showError(errorThrown.message);
					Activity._LOCK = false;
					hideLoading()
				}
			});
		},
		/**
		 * 返回
		 * @param activityType
		 * 		操作类型实例
		 */
		back:function(activityType){
			var _time = 0;
			if(activityType.actType == 11){
				_time = 1000;
			}		
			setTimeout(function(){
				var backUrl = $("#_backURL").val();
				if(backUrl && backUrl.indexOf("isSubDoc=true")>0){
					backUrl = undefined;
				}
				if(backUrl && backUrl.length>0){
					window.location.href = backUrl;
				}else{
					var opentype = $("input[name='openType']").val();
					if("277"==opentype || "16"==opentype){//弹出层打开
						Activity.closeWindow();
					}else{
						if(top === window){	//菜单为新窗口打开
							window.close();
						}else{
							parent.Main.renderTabs.closeTab();
						}
					}
				}
			},_time);
		},
		/**
		 * 关闭窗口
		 */
		closeWindow:function() {
			var backUrl = $("#_backURL").val();
			var opentype = $("input[name='openType']").val();
			if(!opentype || ""==opentype){
				if(backUrl && backUrl.length>0){
					window.location.href = backUrl;
				}else{	//无backUrl时，关闭该窗口
					if(top === window){	//菜单为新窗口打开
						window.close();
					}else{
						parent.Main.renderTabs.closeTab();
					}
				}
			}
			var  view_id = $("input[name='view_id']").val();
			if(parent){
			    var sub_divid  =parent.document.getElementById('sub_divid');
				var doc_obj = parent.document.getElementById(view_id);
				if (doc_obj) { // 本区域返回
					doc_obj.src= sub_divid.value;
					parent.ev_reloadParent();
					return;
				}
				
				if(parent.frames['main_iframe']){
					var viewiFrame = parent.frames['main_iframe'].frames['detail'].frames[view_id];
					if(viewiFrame){
						try{
						 	viewiFrame.ev_reload()
						 	hidden();
						}catch(ex){}
					}else{
					  parent.close();
					  parent.parentWindow.ev_reload();
					}
				}else{
				  OBPM.dialog.doExit();
				}
			} else {
				OBPM.dialog.doExit();
			}
		},
		/**
		 * 恢复按钮状态
		 */
		recoveryButSta:function(){
    		recoveryButSta("button_act");
    		recoveryButSta("btn_act_returnto");
		},
	    /**
		 * 显示消息提示
		 * @param msg
		 * 		消息内容
		 * @param type
		 * 		消息类型（'info','error'）
		 * @param hideAfter
		 * 		延时几秒后关闭消息窗体
		 */
		showMessage : function(msg, type,hideAfter) {
			
	    	if(!msg) return;
	    	//数据兼容 后面修改消息样式要改  	
	    	if(type =="success" || type=="Confirm"){
	    		type="success";
	    	}else if(type =="Danger" || type=="Alert"){
	    		type="danger";
	    	}
	    	window.showMessage(type,msg);
	    	
	    	/**
		    var type = "undefined" == typeof type ? "info": type,
		    		hideAfter = "undefined" == typeof hideAfter ? 3 : hideAfter;//默认3秒停留时间
		    $._messengerDefaults = {
		        extraClasses: "messenger-fixed messenger-on-top",
		        theme: 'flat',
		        messageDefaults: {
		            showCloseButton: true,
		            hideAfter: hideAfter
		        }
		    },
		    $.globalMessenger().post({
		        message: msg,
		        type: type
		    });
		    **/
		},
		
		makeAllFieldAble :function(elements) {
			var fields = [];
			if (!elements) {
				if(document.forms[0] != null){
					elements = document.forms[0].elements;
				}else{
					elements = new Array();
				}
			}
			for (var i = 0; i < elements.length; i++) {
				var element = elements[i];
				if (element.disabled == true) {
					element.disabled = false;
					fields.push(element);
				}
			}
			
			return fields;
		},
		
		/**
		 * 更新表单的控件值
		 * @param activityType
		 * 		操作类型实例
		 */
		 updateFieldFunction:function(activityType,datas){
			 var data = eval("(" + datas + ")");
	        	if(data != undefined && data != null && data.changedField.length > 0){
	        		for(var i = 0; i < data.changedField.length; ++i){
	        			var field = data.changedField[i];
	        			for(var key in field){
	        				if(document.getElementsByName(key).length > 0){
	        					document.getElementsByName(key)[0].value = field[key];
	        				}
	        			}
	        		}
	        		//字段更新后，刷新表单
	        		Activity.refreshForm(activityType);
	        	}
		 },
		
		setFieldDisabled : function(fields){
			for (var i = 0; i < fields.length; i++) {
				var element = fields[i];
				if (element.disabled == false) {
					element.disabled = true;
				}
			}
			
		},
		
		cache:{
			
		}
		
		
}