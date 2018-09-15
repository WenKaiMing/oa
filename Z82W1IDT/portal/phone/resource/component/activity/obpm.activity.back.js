/**
 * 保存并返回操作
 * 
 */
function BackBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 10;
	
	
	if(typeof BackBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		BackBtn.prototype.getBeforePostData = function(){
			return ajaxPage.getParams();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		BackBtn.prototype.getActionPostData = function(){
			return ajaxPage.getParams();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		BackBtn.prototype.doBefore = function(){
			var flag = false;
			
			flag = ifSubSaveForm();
			if(flag){
				flag = beforeAct(this.actType);
			}
			return flag;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		BackBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		BackBtn.prototype.doAfter = function(result){
			var openType = $("#openType").val();
			if(openType=="from_weixin_message" && ajaxPage.pageArray.length <= 1){//从微信待办消息中打开
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
						});
					}
				} catch (e) {
				}
			}else{
				ajaxPage.history.go();
			}
		}
		
		BackBtn._initialized = true;
	
	}
	
	
	
	return this;
}