/**
 * 自定义打印操作
 * 
 */
function FlexPrintBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 30;
	this.printerid = params.printerid;
	this.withFlowHis = params.withFlowHis;
	
	
	if(typeof FlexPrintBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		FlexPrintBtn.prototype.getBeforePostData = function(){
			return jQuery("#document_content").serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		FlexPrintBtn.prototype.getActionPostData = function(){
			return jQuery("#document_content").serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		FlexPrintBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		FlexPrintBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		FlexPrintBtn.prototype.doAfter = function(result){
			var id = document.getElementsByName("content.id")[0].value;
			var formid = document.getElementsByName("_formid")[0].value;
			var flowid = document.getElementsByName("_flowid")[0].value;
			var url = contextPath + '/portal/share/dynaform/printer/flexprint.jsp?_activityid='+this.actId+'&id='
			+ this.printerid + '&_docid=' + id+'&_formid='+formid+'&_flowid='+flowid+'&actType='+ this.actType;
			if (parent != top) {
				parent.open(url);
			} else {
				window.open(url);
			}
		}
		
		FlexPrintBtn._initialized = true;
	
	}
	
	
	
	return this;
}