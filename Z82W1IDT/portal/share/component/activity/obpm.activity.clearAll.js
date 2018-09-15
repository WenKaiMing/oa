/**
 * 清空操作
 * 
 */
function ClearAllBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 18;
	this.target = params.target;
	
	
	if(typeof ClearAllBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ClearAllBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		},
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ClearAllBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		},
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		ClearAllBtn.prototype.doBefore = function(){
			return window.confirm("确定要清空表单的所有记录吗？");
		},
		/**
		 * 按钮动作时执行的业务操作
		 */
		ClearAllBtn.prototype.doAction = function(){
			return true;
		},
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ClearAllBtn.prototype.doAfter = function(result){
			var obj = this.target;
			if(typeof DisplayView == 'object' && DisplayView.getTheView(obj)){//嵌入视图
				var _action = contextPath+"/portal/dynaform/view/displayView.action";
				var json = DisplayView.span2Json(obj);
				DisplayView.postForm(obj,_action,json);
			}else {
				document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action";
				document.forms[0].submit();
			}
		},
		
		ClearAllBtn._initialized = true;
	
	}
	
	
	
	return this;
}