/**
 * 关闭窗口操作
 * 
 */
function CloseWindowBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 8;
	
	
	if(typeof CloseWindowBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		CloseWindowBtn.prototype.getBeforePostData = function(){
			return ajaxPage.getParams();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		CloseWindowBtn.prototype.getActionPostData = function(){
			return ajaxPage.getParams();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		CloseWindowBtn.prototype.doBefore = function(){
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
		CloseWindowBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		CloseWindowBtn.prototype.doAfter = function(result){
			if(result.resultType && (result.resultType=="message" || result.resultType=="validate" || result.resultType=="exception")){
				return;
			}
			var opentype = $("input[name='openType']").val();
			if("277"==opentype || "16"==opentype){//弹出层打开
				top.OBPM.dialog.doExit();
			}else{
				//weixin or closeTab
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
					
				}
				else if(GetReferrer()==""){//判断来路为空
					ajaxPage.history.go();
				}
				else{
				    history.go(-2);
				}
			}
		}
		
		CloseWindowBtn._initialized = true;
	
	}
	
	
	
	return this;
}