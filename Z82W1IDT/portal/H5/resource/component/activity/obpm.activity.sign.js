/**
 * 在线签章操作
 * 
 */
function SignBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 46;
	
	
	if(typeof SignBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SignBtn.prototype.getBeforePostData = function(){
			return jQuery("#document_content").serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SignBtn.prototype.getActionPostData = function(){
			return jQuery("#document_content").serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		SignBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		SignBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SignBtn.prototype.doAfter = function(result){
			return true;
		}
		
		SignBtn._initialized = true;
	
	}
	
	
	
	return this;
}