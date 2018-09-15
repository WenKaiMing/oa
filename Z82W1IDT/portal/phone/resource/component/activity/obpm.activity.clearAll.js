/**
 * 清空操作
 * 
 */
function ClearAllBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 18;
	
	
	if(typeof ClearAllBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ClearAllBtn.prototype.getBeforePostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ClearAllBtn.prototype.getActionPostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		ClearAllBtn.prototype.doBefore = function(){
			return window.confirm("确定要清空表单的所有记录吗？");
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		ClearAllBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ClearAllBtn.prototype.doAfter = function(result){
			document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action";
			document.forms[0].submit();
		}
		
		ClearAllBtn._initialized = true;
	
	}
	
	
	
	return this;
}