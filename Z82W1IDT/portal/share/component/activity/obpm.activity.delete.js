/**
 * 删除操作
 * 
 */
function DeleteBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 3;
	this.target = params.target;
	
	
	if(typeof DeleteBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		DeleteBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return jQuery(document.forms[0]).serialize();
			};
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		DeleteBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		DeleteBtn.prototype.doBefore = function(){
			var checkboxs = {};
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				checkboxs = $(view).find("[name=_selects]");
			}else{
				checkboxs = document.getElementsByName("_selects");
			}
			var isSelect = false;
			for (var i = 0; i < checkboxs.length; i++) {
				if (checkboxs[i].checked == true) {
					isSelect = true;
					break;
				}
			}
			if (isSelect) {
				var rtn = window.confirm("确定要删除您选择的记录吗？");
				if (!rtn)
					return false;
			} else {
				alert("请选择要删除的数据！");
				return false;
			}
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		DeleteBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		DeleteBtn.prototype.doAfter = function(result){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var url = contextPath+"/portal/dynaform/view/displayView.action";
				var json = DisplayView.span2Json(this.target);
				DisplayView.postForm(this.target,url,json);
			}else{
				document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action";
				document.forms[0].submit();
			}
		}
		
		DeleteBtn._initialized = true;
	
	}
	
	
	
	return this;
}