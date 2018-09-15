/**
 * 文件下载操作
 * 
 */
function FileDownloadBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 26;
	
	
	if(typeof FileDownloadBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		FileDownloadBtn.prototype.getBeforePostData = function(){
			return ajaxPage.getParams();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		FileDownloadBtn.prototype.getActionPostData = function(){
			return ajaxPage.getParams();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		FileDownloadBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		FileDownloadBtn.prototype.doAction = function(){
			var url = contextPath + '/portal/dynaform/activity/process.action' + '?_activityid=' + this.actId;
			document.forms[0].action = url;
			document.forms[0].submit();
			
			
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		FileDownloadBtn.prototype.doAfter = function(result){
		}
		
		FileDownloadBtn._initialized = true;
	
	}
	
	
	
	return this;
}