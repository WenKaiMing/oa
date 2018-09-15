/**
 * 启动流程操作
 * 
 * @author Happy
 */
function StartWorkflow(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 33;
	this.editMode = params.editMode;
	this.title = params.title;
	this.hasRun = false;
	this.flowParams = "";
	
	
	if(typeof StartWorkflow._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		StartWorkflow.prototype.getBeforePostData = function(){
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
		StartWorkflow.prototype.getActionPostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = jQuery(document.forms[0]).serialize()+"&_editMode="+this.editMode+"&"+this.flowParams;
			Activity.setFieldDisabled(fields);
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		StartWorkflow.prototype.doBefore = function(){
			if(this.hasRun) return true;
			//jQuery(document.forms[0]).append("<input type='hidden' name='_editMode' value='"+this.editMode+"' />");
			if(this.editMode ==null || this.editMode==0){
				var docid = document.getElementById("_docid").value;
				var formid = document.getElementById("_formid").value;
				// var moduleid=document.getElementById("moduleid").value;
				var url = contextPath
						+ '/portal/share/workflow/runtime/startWorkFlow.jsp?_docid=' + docid
						+ '&formid=' + formid;
				var showtitle = this.title;
				if (showtitle == null || showtitle == "") {
					showtitle = "Undefind";
				}
				tempAllDisabledField();
				makeFieldState(false);
				var activityType = this;
				OBPM.dialog.show({
					width : 600, // 默认宽度
					height : 420, // 默认高度
					url : url,
					args : {},
					title : showtitle,
					close : function(result) {
						if (result) {
							activityType.flowParams = result;
							activityType.hasRun = true;
							Activity.doBefore(activityType);
						}
					}
				});
				return false;
			}else if(this.editMode==1){
				setHTMLValue(); //设置html控件值
				return true;
			}
			return false;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		StartWorkflow.prototype.doAction = function(){
			doWordSave();
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		StartWorkflow.prototype.doAfter = function(result){
		}
		
		StartWorkflow._initialized = true;
	
	}
	
	
	
	return this;
}