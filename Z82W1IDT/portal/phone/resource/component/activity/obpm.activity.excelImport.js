/**
 * 导入Excel操作
 * 
 */
function ExcelImportBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 27;
	this.impmappingconfigid = params.impmappingconfigid;
	
	
	if(typeof ExcelImportBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		ExcelImportBtn.prototype.getBeforePostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		ExcelImportBtn.prototype.getActionPostData = function(){
			return jQuery(document.forms[0]).serialize();
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
			var impcfgid = this.impmappingconfigid
			var parentid = "";
			if (document.getElementsByName("parentid")) {
				parentid = document.getElementsByName("parentid")[0].value;
			}
			
			var application = "";
			if (document.getElementsByName("application")) {
				application = document.getElementsByName("application")[0].value;
			}

			var isRelate = "";
			if(document.getElementsByName("isRelate")){
				var relateObj = document.getElementsByName("isRelate");
				if(relateObj.length != 0)
					isRelate = relateObj[0].value;
			}
			var _viewid = document.getElementsByName("_viewid")[0].value;
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
						document.forms[0].submit();
					}
				});
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