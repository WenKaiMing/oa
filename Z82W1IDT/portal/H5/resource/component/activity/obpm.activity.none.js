/**
 * 无类型操作
 * 
 */
function NoneBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 13;
	this.actionType = params.actionType;
	this.actionDispatcherUrlScript = params.actionDispatcherUrlScript;
	this.actionSelection = params.actionSelection;
	this.relatedFormId = params.relatedFormId;
	this.actionPostData = null;
	
	
	if(typeof NoneBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		NoneBtn.prototype.getBeforePostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = jQuery("#document_content").serialize();
			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		NoneBtn.prototype.getActionPostData = function(){
			if( this.actionPostData != null && this.actionPostData != ""){
				return this.actionPostData;
			}else{
				var fields = Activity.makeAllFieldAble();
				jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
				var data = jQuery("#document_content").serialize();
				Activity.setFieldDisabled(fields);
				return data;
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		NoneBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		NoneBtn.prototype.doAction = function(){
			var act = this ;
			var actId = this.actId;
			var actionType = this.actionType;
			this.actionPostData = this.getActionPostData();
			var cancel = false;
			if(this.actionSelection == 0){//自定义动作
				return true;
			}else if(this.actionSelection == 1){//关联表单
				var  width = document.body.clientWidth - 25;
				var  height = $(window).height() - 200;
				url = contextPath+"/portal/dynaform/document/new4tmpForm.action?_formid="+this.relatedFormId;
				OBPM.dialog.show({
					url : url,
					width:width,
					height : height,
					args : {},
					title : "填写表单",
					ok:function(result) {
						var tmpForm = result.document.getElementById("_formHtml");
						var $div= jQuery('<form></form>');
						$div.append(tmpForm);
						var datas = $div.serialize();
						actionPostData = jQuery("#document_content").serialize();
						//拼接参数
						actionPostData = actionPostData + "&" + datas;
					},
					cancel:function(){
						cancel = true;
						this.close();
					},
					button:"",
					close : function() {
						//执行doAction业务
						if(!cancel){
							act.actionSelection = "";
							act.actionPostData = actionPostData
							Activity._LOCK = true ;
							Activity.doAction(act);
						}
					}
				});
			}else{
				return true;
			}
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		NoneBtn.prototype.doAfter = function(result){
			switch (this.actionType) {
			case 0:  //无
				Activity.refreshForm(this.actionType); //刷新表单
				break;
			case 1:  //返回
				setTimeout(function(){
					Activity.back(this);
				},700);
				break;
			case 2:   //关闭
				setTimeout(function(){
					var opentype = $("input[name='openType']").val();
					if("277"==opentype || "16"==opentype){//弹出层打开
						Activity.closeWindow();
					}else{
						Activity.back(this);
					}
				},700);
				break;
			case 3:   //跳转
				var url = this.actionDispatcherUrlScript;
				var jumpTo = function(url){
					window.location.href = url;
				};
				setTimeout(function(){
					jumpTo(url);
				},700);
				break;
			default:
				break;
			}
		}
		NoneBtn._initialized = true;
	}
	return this;
}