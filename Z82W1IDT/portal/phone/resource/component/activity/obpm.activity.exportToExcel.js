/**
 * 导出Excel操作
 * 
 */
function ExportToExcelBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 16;
	this.fileName = params.fileName;
	this.expSub = params.expSub;
	this.hasRun = false;
	
	
	if(typeof ExportToExcelBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ExportToExcelBtn.prototype.getBeforePostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ExportToExcelBtn.prototype.getActionPostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		ExportToExcelBtn.prototype.doBefore = function(){
			if(this.hasRun){
				alert("已导出，需要再次导出请刷新页面！");
				return false;
			}
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		ExportToExcelBtn.prototype.doAction = function(){
			var oldActionUrl = document.forms[0].action;
			var url = contextPath + '/portal/dynaform/activity/process.action' + '?_activityid=' + this.actId+ "&filename=" + this.fileName + "&isExpSub=" + this.expSub;;
			document.forms[0].action = url;
			document.forms[0].submit();
			this.hasRun = true;
			document.forms[0].action = oldActionUrl;
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ExportToExcelBtn.prototype.doAfter = function(result){
		}
		
		ExportToExcelBtn._initialized = true;
	
	}
	
	
	
	return this;
}