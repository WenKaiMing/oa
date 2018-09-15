/**
 * 保存并提交流程操作
 * @author Happy
 */
function SaveStartWorkflow(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 4;
	
	
	if(typeof SaveStartWorkflow._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SaveStartWorkflow.prototype.getBeforePostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SaveStartWorkflow.prototype.getActionPostData = function(){
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
		SaveStartWorkflow.prototype.doBefore = function(){
			var flag = true;
			
			var oOperation = document.getElementById("operation");
			if (oOperation) {
				oOperation.value = "doSave";
			}
			
			setHTMLValue();//设置html控件值
			
			return flag;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		SaveStartWorkflow.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SaveStartWorkflow.prototype.doAfter = function(result){
		}
		
		SaveStartWorkflow._initialized = true;
	
	}
	
	
	
	return this;
}