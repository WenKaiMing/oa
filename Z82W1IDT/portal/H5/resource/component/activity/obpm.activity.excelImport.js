/**
 * 导入Excel操作
 * 
 */
function ExcelImportBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 27;
	this.impmappingconfigid = params.impmappingconfigid;
	this.target = params.target;
	
	
	if(typeof ExcelImportBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ExcelImportBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				return jQuery(document.forms[0]).serialize();
			}
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ExcelImportBtn.prototype.getActionPostData = function(){
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
		ExcelImportBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		ExcelImportBtn.prototype.doAction = function(){
			var impcfgid = this.impmappingconfigid;
			var parentid = "";
			var application = "";
			var isRelate = "";
			var _viewid = "";
			
			var obj = this.target;
			if(typeof DisplayView == 'object' && DisplayView.getTheView(obj)){	//
				var json = DisplayView.span2Json(obj);
				var action = DisplayView.getAction(obj);
				parentid = json["parentid"];
				application = json["application"];
				isRelate = json["isRelate"];
				_viewid = json["_viewid"];
				if (impcfgid) {
					var url = importURL; // importURL在各页面中定义
					url += "?parentid=" + parentid;
					url += "&id=" + impcfgid;
					url += "&application=" + application;
					url += "&isRelate=" + isRelate;
					url += "&_activityid=" + this.actId;
					url += "&_viewid=" + _viewid;
					OBPM.dialog.show({
						width : 530,
						height : 420,
						url : url,
						args : {},
						title : 'Excel导入',
						close : function(result) {
							DisplayView.postForm(obj,action,json);
						}
					});
				}
			}else{
				if (document.getElementsByName("parentid")) {
					parentid = document.getElementsByName("parentid")[0].value;
				}
				if (document.getElementsByName("application")) {
					application = document.getElementsByName("application")[0].value;
				}
				if(document.getElementsByName("isRelate")){
					var relateObj = document.getElementsByName("isRelate");
					if(relateObj.length != 0)
						isRelate = relateObj[0].value;
				}
				_viewid = document.getElementsByName("_viewid")[0].value;
				if (impcfgid) {
					var url = importURL; // importURL在各页面中定义
					url += "?parentid=" + parentid;
					url += "&id=" + impcfgid;
					url += "&application=" + application;
					url += "&isRelate=" + isRelate;
					url += "&_activityid=" + this.actId;
					url += "&_viewid=" + _viewid;
					OBPM.dialog.show({
						width : 530,
						height : 420,
						url : url,
						args : {},
						title : 'Excel导入',
						close : function(result) {
							if(typeof(isSubGridView) != "undefined"){
								subGridView.renderGridView();
							}else{
								document.forms[0].submit();
							}
						}
					});
				}
			}
			
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		ExcelImportBtn.prototype.doAfter = function(result){
		}
		
		ExcelImportBtn._initialized = true;
	
	}
	
	
	
	return this;
}