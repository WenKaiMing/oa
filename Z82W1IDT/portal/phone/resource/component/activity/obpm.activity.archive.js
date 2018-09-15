/**
 * 保存操作
 * 
 */
function ArchiveBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 45;
	
	
	if(typeof ArchiveBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ArchiveBtn.prototype.getBeforePostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ArchiveBtn.prototype.getActionPostData = function(){
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
		ArchiveBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		ArchiveBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ArchiveBtn.prototype.doAfter = function(result){
		}
		
		ArchiveBtn._initialized = true;
	
	}
	
	
	
	return this;
}