/**
 * 载入视图操作
 * 
 */
function QueryBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 1;
	this.viewId = params.viewId;
	this.target = params.target;
	
	
	if(typeof QueryBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		QueryBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		QueryBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		QueryBtn.prototype.doBefore = function(){
			dy_lock();
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		QueryBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		QueryBtn.prototype.doAfter = function(result){
			var obj = this.target;
			if(typeof DisplayView == 'object' && DisplayView.getTheView(obj)){//嵌入视图
				var _action = contextPath+"/portal/dynaform/view/displayView.action?_viewid=" + this.viewId;
				var json = DisplayView.span2Json(obj);
				DisplayView.postForm(obj,_action,json);
			}else {
				document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action?_viewid=" + this.viewId;
				document.forms[0].submit();
			}
		}
		
		QueryBtn._initialized = true;
	
	}
	
	
	
	return this;
}