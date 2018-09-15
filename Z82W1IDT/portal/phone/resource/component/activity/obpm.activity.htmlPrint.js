/**
 * 网页打印操作
 * 
 */
function HtmlPrintBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 14;
	
	
	if(typeof HtmlPrintBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		HtmlPrintBtn.prototype.getBeforePostData = function(){
			return ajaxPage.getParams();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		HtmlPrintBtn.prototype.getActionPostData = function(){
			return ajaxPage.getParams();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		HtmlPrintBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		HtmlPrintBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		HtmlPrintBtn.prototype.doAfter = function(result){
			var withFlowHis = false;
			var id = document.getElementsByName("content.id")[0].value;
			var applicationid = document.getElementsByName("content.applicationid")[0].value;
			var formid = document.getElementsByName("_formid")[0].value;
			var flowid = document.getElementsByName("_flowid")[0].value;
			var _templateForm = document.getElementsByName("_templateForm")[0].value;
			var signatureExist = document.getElementById("signatureExist").value;
			
			var url = contextPath + '/portal/dynaform/activity/print.action?_docid=' + id;
			url += '&_formid=' + formid;
			url += '&_signatureExist=' + signatureExist;
			url += '&application=' + applicationid;
			url += '&actType='+ this.actType;
			if (withFlowHis && flowid) {
				url += '&_flowid=' + flowid;
			}
			if(_templateForm){
				url += '&_templateForm=' + _templateForm;
			}
			if (parent != top) {
				parent.open(url);
			} else {
				window.open(url);
			}
		}
		
		HtmlPrintBtn._initialized = true;
	
	}
	
	
	
	return this;
}