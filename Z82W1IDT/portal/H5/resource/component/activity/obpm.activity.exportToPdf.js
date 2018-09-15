/**
 * 导出pdf操作
 * 
 */
function ExportToPdfBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 25;
	
	
	if(typeof ExportToPdfBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ExportToPdfBtn.prototype.getBeforePostData = function(){
			return jQuery("#document_content").serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ExportToPdfBtn.prototype.getActionPostData = function(){
			return jQuery("#document_content").serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		ExportToPdfBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		ExportToPdfBtn.prototype.doAction = function(){
			var id = document.getElementsByName("content.id")[0].value;
			var url = contextPath + '/portal/dynaform/activity/process.action' + '?_activityid=' + this.actId;
			document.forms[0].action = url;
			document.forms[0].submit();
			
			
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ExportToPdfBtn.prototype.doAfter = function(result){
		}
		
		ExportToPdfBtn._initialized = true;
	
	}
	
	
	
	return this;
}