/**
 * 删除操作
 * 
 */
function DeleteBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 3;
	this.target = params.target;
	
	if(typeof DeleteBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		DeleteBtn.prototype.getBeforePostData = function(){
			
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return ajaxPage.getParams();
				
			};
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		DeleteBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return ajaxPage.getParams();
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		DeleteBtn.prototype.doBefore = function(){
			var checkboxs = ajaxPage.getParamsByName("_selects");
			var isSelect = false;
			for (var i = 0; i < checkboxs.length; i++) {
				if (checkboxs[i].checked == true) {
					isSelect = true;
					break;
				}
			}
			if (isSelect) {
				var rtn = window.confirm("确定要删除您选择的记录吗？");
				if (!rtn)
					return false;
			} else {
				showMessage("info", "请选择要删除的数据！")
				return false;
			}
			
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		DeleteBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		DeleteBtn.prototype.doAfter = function(result){
			
			//获取视图类型
			var viewType = ajaxPage.getCurPage().find("[name='_openType']:eq(0)").text();
			if(viewType && viewType == "277"){
				//刷新子视图
				//var $displayView = $("div[name='display_view']");
				//$displayView.bind("refresh", function(){
				//	$displayView.load($displayView.attr("src"), function(){
				//		dy_refresh(name);					
				//	});
				//}).trigger("refresh");
				
				var url = ajaxPage.getCurPage().attr("href");
				var viewId = ajaxPage.getCurPage().find("title").attr("id");
				refreshDisplayView(url,viewId)
				
			}else{
				ajaxPage.refreshPage();
//				document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action";
//				document.forms[0].submit();
			}

			
		}
		
		DeleteBtn._initialized = true;
	
	}
	
	
	
	return this;
}