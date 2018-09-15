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
	this.jumpActOpenType = params.jumpActOpenType;
	this.target = params.target;
	
	
	if(typeof JumpToBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		JumpToBtn.prototype.getBeforePostData = function(){
			if(jQuery("#formList").size()>0){
				return jQuery("#formList").serialize();
			}else{
				return jQuery("#document_content").serialize();
			}
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		JumpToBtn.prototype.getActionPostData = function(){
			if(jQuery("#formList").size()>0){
				return jQuery("#formList").serialize();
			}else{
				return jQuery("#document_content").serialize();
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
				var applicationid = jQuery("input[name='application']").val();// document.getElementById("application").value;
				
				var docid = jQuery("input[name='content.id']").val();//jQuery("input[name='content.id']").val();
				var view_id = jQuery("#view_id").val();
				var signatureExist = jQuery("input[name='signatureExist']").val();
				var formid = jQuery("input[name='formid']").val();
				var backUrl = jQuery("input[name='_backURL']").val();
				var docviewAction = contextPath + '/portal/dynaform/document/view.action';
				var newAction = contextPath + '/portal/dynaform/activity/process.action?_activityid=' + this.actId;
				var url = newAction + "&content.id="+docid+"&applicationid=" + applicationid + "&application=" + applicationid + "&openType="+this.jumpActOpenType+"&_jumpForm=" + formid + "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1&_backURL="
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
				
				switch(this.jumpActOpenType){
				case 0://当前页
					window.location.href = url;
					break;
				case 1://弹出层
					var w = document.body.clientWidth * 80 / 100;
					var h = document.body.clientHeight * 90 / 100;
					showfrontframe({
						title : "",
						url : url,
						w : w,
						h : h,
						windowObj : window.parent,
						callback : function(result) {
						}
					}); 
					break;
				case 2://页签
					parent.addTab(docid,"...",url);
					break;
				case 3://新窗口
					window.open(url);
					break;
				default:
					return false;
				}
				break;
			case 1 :
				var view_id ="";
				var formid ="";
				var docid = "";
				if(document.getElementById("formid")){    // 表单类型
					formid = document.getElementById("formid").value;
					docid = jQuery("input[name='content.id']").val();
				}else if(document.getElementById("viewid") || jQuery("#formList__viewid").val()){    //视图类型
					if(document.getElementById("viewid")){ //普通视图
						view_id = document.getElementById("viewid").value
					}
					if(jQuery("#formList__viewid").val()){ //网格视图
						view_id = jQuery("#formList__viewid").val();
					}
				}
				var applicationid = jQuery("input[name='application']").val();
				var url = contextPath + '/portal/dynaform/activity/process.action?_activityid=' + this.actId + "&_formid=" + formid + "&view_id=" + view_id + "&_viewid="+view_id+ "&content.id="+docid+"&applicationid=" + applicationid + "&application=" + applicationid;
				if(view_id.length>0){
					$("input[name='_selects']:checked").each(function(i,item){url+="&_selects="+$(item).val()});
				}
				switch(this.jumpActOpenType){
				case 0://当前页
					window.location.href = url;
					break;
				case 1://弹出层
					var w = document.body.clientWidth * 80 / 100;
					var h = document.body.clientHeight * 90 / 100;
					showfrontframe({
						title : "",
						url : url,
						w : w,
						h : h,
						windowObj : window.parent,
						callback : function(result) {
						}
					}); 
					break;
				case 2://页签
					parent.addTab(docid,"...",url);
					break;
				case 3://新窗口
					window.open(url);
					break;
				default:
					break;
				}
				break;
			default :
				return false;
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