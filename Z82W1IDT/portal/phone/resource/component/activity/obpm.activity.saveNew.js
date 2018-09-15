/**
 * 保存并返回操作
 * 
 */
function SaveNewBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 10;
	this.withOld = params.withOld;//是否带旧数据
	
	
	if(typeof SaveNewBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SaveNewBtn.prototype.getBeforePostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SaveNewBtn.prototype.getActionPostData = function(){
//			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = ajaxPage.getParams();
//			Activity.setFieldDisabled(fields);
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		SaveNewBtn.prototype.doBefore = function(){
			var flag = true;
			
			var oOperation = ajaxPage.getCurPage().find("#operation");
			if (oOperation && oOperation.size() > 0) {
				oOperation.val("doSave");
			}
			setHTMLValue();//设置html控件值
			//flag = ifSubSaveForm();
			return flag;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		SaveNewBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SaveNewBtn.prototype.doAfter = function(result){
			
			jQuery.ajax({
				type: 'POST',
				async:true, 
				url: contextPath + '/portal/dynaform/activity/newDocument.action?_withOld='+this.withOld,
				dataType : 'json',
				timeout: 3000,
				data: ajaxPage.getParams(),
				success:function(result) {
					if(result.status==1){
						var datas = result.data;
						var activityHtml = datas["activityHtml"];
						var $curPage = ajaxPage.getCurPage();
						if(activityHtml){
							$curPage.find(".formActBtn").html(activityHtml);
						}
						var formHtml = datas["formHtml"];
						if(formHtml){
							$curPage.find("#_formHtml").html(formHtml)
						}
						showLoadingToast();//显示loading层
						//渲染流程提交按钮
						if($("input[activityType='5']")){
							FlowPanel.refreshFlowPanel("init");
						}
						//填充系统字段
						if(datas["systemFields"]){
							for(var n in datas["systemFields"]){
								$curPage.find("input[name='"+n+"']").val(datas["systemFields"][n]);
							}
						}
						$curPage.find("input[name='content.sign']").val("");
						$curPage.find(".isignature .sign").remove();
						//渲染流程处理人列表、流程状态标签、流程历史按钮
						$curPage.find("#processorHtml").html('');
						$curPage.find("#flowStateHtml").html('');
						$curPage.find(".flowbtn").hide();
						initFormCommon();//表单公用的初始化方法
//						adjustDocumentLayout4form();//调整相关文档布局
						hideLoadingToast();//隐藏loading层
					}else{
						Activity.showMessage(result.message,"error");
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					if(XMLHttpRequest.readyState == 0){
						Activity.showMessage("网络已断开！","error");
					}else{
						Activity.showMessage(errorThrown.message,"error");
					}
				}
			});
			
		}
		
		SaveNewBtn._initialized = true;
	
	}
	
	
	
	return this;
}