/**
 * 流程处理
 * @author Happy
 */
function WorkflowProcess(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 5;
	
	
	if(typeof WorkflowProcess._initialized == "undefined"){
		
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		WorkflowProcess.prototype.getBeforePostData = function(){
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		WorkflowProcess.prototype.getActionPostData = function(){
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		WorkflowProcess.prototype.doBefore = function(){
			showLoadingToast();
			setHTMLValue();
			var flag = true;
			return flag;
		}
		/**
		 * 按钮动作时执行的其他业务操作
		 */
		WorkflowProcess.prototype.doAction = function(){
			//doWordSave();
			return true;
		}
		
		/**
		 * 按钮动作执行后的其他业务操作
		 */
		WorkflowProcess.prototype.doAfter = function(result){
			hideLoadingToast();
			var openType = $("#openType").val();
			if($("#openType").val()=="from_weixin_message"){//从微信待办消息中打开
				if (typeof WeixinJSBridge == "undefined"){
				    if( document.addEventListener ){
				        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
				    }else if (document.attachEvent){
				        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
				        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
				    }
				}
				try {
					if(WeixinJSBridge){
						WeixinJSBridge.invoke('closeWindow',{},function(res){
							//alert('关闭微信页面');
						});
					}
				} catch (e) {
				}
			}else if(GetReferrer()==""){//判断来路为空
				setTimeout(function(){
					ajaxPage.history.go(-1);
					//刷新待办和经办
					$("#pendingApp ul, #processingApp ul").trigger("refresh");	//流程中心
					Jh.Portal._eventRefresh();	//主页
				}, 700);
			}else if($("#myModalexample",parent.document).hasClass("active")){
				parent.MyPopup._modal.trigger("close");
				return;
			}else{
				setTimeout(function(){
					ajaxPage.history.go(-1);
					//刷新待办和经办
					$("#pendingApp ul, #processingApp ul").trigger("refresh");	//流程中心
					Jh.Portal._eventRefresh();	//主页
				}, 700);
			}
		}
	}
		
	WorkflowProcess._initialized = true;
	return this;
}

function GetReferrer() {//获取来路URL
	var ref = '';  
		if (document.referrer.length > 0) {  
			ref = document.referrer;  
		}  
	try {  
		if (ref.length == 0 && opener.location.href.length > 0) {  
			ref = opener.location.href;  
		}  
	} catch (e) {} 
	return ref;
}

