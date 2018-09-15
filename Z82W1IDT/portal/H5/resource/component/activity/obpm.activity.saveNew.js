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
		SaveNewBtn.prototype.getActionPostData = function(){
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
		SaveNewBtn.prototype.doBefore = function(){
			var flag = false;
			
			var oOperation = document.getElementById("operation");
			if (oOperation) {
				oOperation.value = "doSave";
			}
			setHTMLValue();//设置html控件值
			var retvalue = doWordSave();
			if(!retvalue) {
				alert('Word文档已经被其他用户更新， 请刷新页面加载最新的Word文档！');
				return false;
			}
			var isword = false;

			if (!isword || isword == 'false') {
				flag = true;
			} else {
				if (retvalue >= 0) { // 有返回值才保存
					flag = true;
				}
			}
			if(flag){
				flag = ifSubSaveForm();
			}
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
				data: jQuery("#document_content").serialize(),
				success:function(result) {
					if(result.status==1){
						var datas = result.data;
						var activityHtml = datas["activityHtml"];
						if(activityHtml){
							$(".formActBtn").html(activityHtml);
						}
						var formHtml = datas["formHtml"];
						if(formHtml){
							$("#_formHtml").html(formHtml)
						}
						//---
						showLoading();//显示loading层
						try {
							//填充系统字段
							if(datas["systemFields"]){
								for(var n in datas["systemFields"]){
									$("input[name='"+n+"']").val(datas["systemFields"][n]);
								}
							}
							$("input[name='content.sign']").val("");
							$(".isignature .sign").remove();
							
							//渲染流程处理人列表、流程状态标签、流程历史按钮
							if(datas["processorHtml"]){
								$("#flow-json").html(datas["processorHtml"]);
							}else{
								$("#flow-json").html("[]");
							}
							if(datas["flowStateHtml"]){
								$("#flowStateHtml").html('<div class="flowstate" onmouseover="showFlowState(\'flowstate\');"><b>'+datas["flowStateHtml"]+'</b></div>');
							}
							if(jQuery("input[name='content.stateid']").val().length>0){
								jQuery(".flowbtn").show();
							}
							initFormCommon();//表单公用的初始化方法
							//渲染流程提交按钮
							if($("input[activityType='5']")){
								FlowPanel.refreshFlowPanel("init");
							}
							adjustDocumentLayout4form();//调整相关文档布局
						} catch (e) {
							console.log(e.message);
						}
						
						hideLoading();//隐藏loading层
					}else{
						OBPM.message.showError(result.message);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					OBPM.message.showError(errorThrown.message);
				}
			});
			
		}
		
		SaveNewBtn._initialized = true;
	
	}
	
	
	
	return this;
}