/**
 * 打印视图操作
 * 
 */
function PrintViewBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 14;
	
	
	if(typeof PrintViewBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		PrintViewBtn.prototype.getBeforePostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		PrintViewBtn.prototype.getActionPostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		PrintViewBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		PrintViewBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		PrintViewBtn.prototype.doAfter = function(result){
			var viewid = document.getElementsByName("_viewid")[0].value;
			var signatureExist = document.getElementById("signatureExist").value;
			var url = contextPath+'/portal/dynaform/view/printView.action';
			url += '?_signatureExist=' + signatureExist;
			url += '&_activityid=' + this.actId;  
			url += '&isprint=true';
			url += '&actType='+ this.actType;
			var fmmy = document.forms[0]; 
			fmmy.action=url;
			fmwin = window.open("about:blank", "_my_submit_win");   
			fmmy.target="_my_submit_win"; 
			fmmy.submit();
			fmmy.target="";
		}
		
		PrintViewBtn._initialized = true;
	
	}
	
	
	
	return this;
}