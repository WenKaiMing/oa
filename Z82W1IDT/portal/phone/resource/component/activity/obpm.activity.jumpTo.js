/**
 * 跳转操作
 * 
 */
function JumpToBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 43;
	this.jumpType = params.jumpType;
	this.targetList = params.targetList;
	this.jumpMode = params.jumpMode;
	
	
	if(typeof JumpToBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		JumpToBtn.prototype.getBeforePostData = function(){
			if(jQuery("#formList").size()>0){
				return jQuery("#formList").serialize();
			}else{
				return ajaxPage.getParams();
			}
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		JumpToBtn.prototype.getActionPostData = function(){
			if(jQuery("#formList").size()>0){
				return jQuery("#formList").serialize();
			}else{
				return ajaxPage.getParams();
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		JumpToBtn.prototype.doBefore = function(){
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		JumpToBtn.prototype.doAction = function(){
			switch (this.jumpMode) {
			case 0 :
				var olist = this.targetList.split(";");
				var formId;
				for (var i = 0; i < olist.length; i++) {
					formId = olist[0].split("|")[0];
				}
				if(this.jumpType==0){
					var applicationid = document.getElementById("application").value;
					var docid = document.getElementsByName("content.id")[0].value;
					var view_id = document.getElementById("view_id").value;
					var signatureExist = document.getElementsByName("signatureExist")[0].value;
					var formid = document.getElementsByName("formid")[0].value;
					var backUrl = document.getElementsByName("_backURL")[0].value;
					var docviewAction = contextPath + '/portal/dynaform/document/view.action';
					var newAction = contextPath + '/portal/dynaform/activity/process.action?_activityid=' + this.actId;
					var url = newAction + "&applicationid=" + applicationid + "&application=" + applicationid + "&openType="+this.jumpActOpenType+"&_jumpForm=" + formid + "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1&_backURL="
							+ encodeURIComponent(docviewAction + "?_docid="+docid+"&application="+applicationid+"&_formid="+formid+"&view_id="+
									view_id+"&signatureExist="+signatureExist+"&_backURL="+encodeURIComponent(backUrl));
					
					var inputElem =$("input[iscommonfilter]");//可获取所有查询表单的input
					if(inputElem.size() > 0){
						inputElem.each(function(){
							var val = $(this).val();//获取控件值
							if(val != null){
								var _id = $(this).attr("id");
								var id = _id.substring(_id.indexOf("_")+1);//获取控件名称
								url+="&"+id+"="+val;
							}
						  });
					}
					
					
					window.location.href = url;
				}else{
					
				}
				
				break;
			case 1 :
				var datas = ajaxPage.getParams();
				var url = contextPath + '/portal/dynaform/activity/process.action?_activityid=' + this.actId;
				var html = '<input type="hidden" name="formData" value="'+datas+'" />';
				jQuery("body >div.cur #formParams").append(html);
				document.forms[0].action = url;
//				makeAllFieldAble();
				document.forms[0].submit();
				break;
			default :
				break;
		}
			
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		JumpToBtn.prototype.doAfter = function(result){
			
		}
		
		JumpToBtn._initialized = true;
	
	}
	
	
	
	return this;
}