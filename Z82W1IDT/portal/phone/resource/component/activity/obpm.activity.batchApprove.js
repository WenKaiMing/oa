/**
 * 批量提交操作
 * 
 */
function BatchApproveBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 20;
	this.hasRun = false;
	
	if(typeof BatchApproveBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		BatchApproveBtn.prototype.getBeforePostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		BatchApproveBtn.prototype.getActionPostData = function(){
			return jQuery(document.forms[0]).serialize();
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		BatchApproveBtn.prototype.doBefore = function(){
			var checkboxs = document.getElementsByName("_selects");
			var isSelect = false;
			for (var i = 0; i < checkboxs.length; i++) {
				if (checkboxs[i].checked == true) {
					isSelect = true;
					break;
				}
			}
			if(!isSelect){
				alert("至少选择一条记录！");
			}
			return isSelect;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		BatchApproveBtn.prototype.doAction = function(){
			if(this.hasRun) return true;
			var activityType = this;
			if(jQuery("#inputAuditRemarkDiv" + this.actId).attr("id")){
				artDialog.prompt('请输入审批意见：',function(val,win){
					jQuery('#_attitude' + activityType.actId).val(val);
					activityType.hasRun = true;
					Activity.doAction(activityType);
				},true);
				
			}
			
			return false;
			
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		BatchApproveBtn.prototype.doAfter = function(result){
			document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action";
			document.forms[0].submit();
		}
		
		BatchApproveBtn._initialized = true;
	
	}
	
	
	
	return this;
}