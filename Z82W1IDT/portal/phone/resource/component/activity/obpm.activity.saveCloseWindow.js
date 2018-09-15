/**
 * 保存并关闭窗口
 * 
 */
function SaveCloseWindowBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 9;
	
	
	if(typeof SaveCloseWindowBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SaveCloseWindowBtn.prototype.getBeforePostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SaveCloseWindowBtn.prototype.getActionPostData = function(){
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
		SaveCloseWindowBtn.prototype.doBefore = function(){
			var flag = false;
			
			var oOperation = document.getElementById("operation");
			if (oOperation) {
				oOperation.value = "doSave";
			}
			setHTMLValue();//设置html控件值
			var retvalue = doWordSave();
			if(!retvalue) {
				alert('Word文档已经被其他用户更新， 请刷新页面加载最新的Word文档！');
				return false;
			}
			var isword = false;

			if (!isword || isword == 'false') {
				flag = true;
			} else {
				if (retvalue >= 0) { // 有返回值才保存
					flag = true;
				}
			}
			if(flag){
				flag = ifSubSaveForm();
			}
			if(flag){
				flag = beforeAct(this.actType);
			}
			return flag;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		SaveCloseWindowBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SaveCloseWindowBtn.prototype.doAfter = function(result){
		}
		
		SaveCloseWindowBtn._initialized = true;
	
	}
	
	
	
	return this;
}