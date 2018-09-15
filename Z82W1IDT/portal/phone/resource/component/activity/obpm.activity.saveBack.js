/**
 * 保存并返回操作
 * 
 */
function SaveBackBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 11;
	
	
	if(typeof SaveBackBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SaveBackBtn.prototype.getBeforePostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SaveBackBtn.prototype.getActionPostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		SaveBackBtn.prototype.doBefore = function(){
			var flag = false;
			
			var oOperation = document.getElementById("operation");
			if (oOperation) {
				oOperation.value = "doSave";
			}
			setHTMLValue();//设置html控件值
			//var retvalue = doWordSave();
			// if(!retvalue) {
			// 	alert('Word文档已经被其他用户更新， 请刷新页面加载最新的Word文档！');
			// 	return false;
			// }
			var isword = false;

			if (!isword || isword == 'false') {
				flag = true;
			} else {
				if (retvalue >= 0) { // 有返回值才保存
					flag = true;
				}
			}
			// if(flag){
			// 	flag = ifSubSaveForm();
			// }
			// if(flag){
			// 	flag = beforeAct(this.actType);
			// }
			return flag;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		SaveBackBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SaveBackBtn.prototype.doAfter = function(result){
			var backUrl = $("#_backURL").val();
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
					WeixinJSBridge.invoke('closeWindow',{},function(res){
						//alert('关闭微信页面');
					});
				} catch (e) {
				}
			}else if(GetReferrer()==""){//判断来路为空
				setTimeout(function(){
					ajaxPage.history.go();
				}, 1000);
			}else if($("#myModalexample",parent.document).hasClass("active")){
				parent.MyPopup._modal.trigger("close");
				return;
			}
			else{
				setTimeout(function(){
					ajaxPage.history.go();
				}, 1000);
			}
		}
		
		SaveBackBtn._initialized = true;
	
	}
	
	
	
	return this;
}