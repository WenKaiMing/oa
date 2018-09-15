/**
 * 分享操作
 * 
 */
function TranspondBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 37;
	this.summaryCfg = params.summaryCfg;//分享摘要模板
	
	
	if(typeof TranspondBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		TranspondBtn.prototype.getBeforePostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			jQuery("iframe[name='display_view']").trigger("save");
			var data = jQuery("#document_content").serialize();
			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		TranspondBtn.prototype.getActionPostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = jQuery("#document_content").serialize();
			Activity.setFieldDisabled(fields);
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		TranspondBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		TranspondBtn.prototype.doAction = function(){
			var applicationid = document.getElementsByName("content.applicationid")[0].value;
			var docid = document.getElementsByName("content.id")[0].value;
			var formid = document.getElementsByName("_formid")[0].value;
			var signatureExist = document.getElementById("signatureExist").value;
			var handleUrl = window.location.toString();
			var url = "../share/dynaform/view/activity/emailTranspond.jsp?application=" + applicationid;
			OBPM.dialog.show({
	    		opener:window.parent.parent,
	    		width: 700,
	    		height: 300,
	    		args: {"_activityid":this.actId,"application":applicationid, "docid":docid, "formid":formid, "transpond":this.summaryCfg, "handleUrl":handleUrl, "signatureExist":signatureExist},
	    		url: url,
	    		title: '转发',
	    		close: function() {
	    			
	    		}
	    	});
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		TranspondBtn.prototype.doAfter = function(result){
		}
		
		TranspondBtn._initialized = true;
	
	}
	
	
	
	return this;
}