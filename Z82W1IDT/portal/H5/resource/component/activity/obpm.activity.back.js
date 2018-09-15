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
			return jQuery("#document_content").serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		BackBtn.prototype.getActionPostData = function(){
			return jQuery("#document_content").serialize();
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
		}
		
		BackBtn._initialized = true;
	
	}
	
	
	
	return this;
}