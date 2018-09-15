/**
 * 载入视图操作
 * 
 */
function QueryBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 1;
	this.viewId = params.viewId;
	this.target = params.target;
	this.HAS_SUBFORM = false;
	
	
	if(typeof QueryBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		QueryBtn.prototype.getBeforePostData = function(){
			this.HAS_SUBFORM = DisplayView.isSubPage(this.target);
			if(typeof this.HAS_SUBFORM !="undefined" && this.HAS_SUBFORM){
				return DisplayView.span2Params(this.target);
			}else{
//				return jQuery(document.forms[0]).serialize();
				return ajaxPage.getParams();
			}
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		QueryBtn.prototype.getActionPostData = function(){
			if(typeof this.HAS_SUBFORM !="undefined" && this.HAS_SUBFORM){
				var application = $(".control-content.active").find("span[name='application']").text();
				//return $(".control-content.active").find("input,textarea,select").serialize()+"&application="+application+"&formId="+this.formId;
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				json['formId'] = this.formId;
				var elems = $(view).find("[name=_selects]:checked");
				json['_backURL'] = '';
				return DisplayView.addVal2Params(json,elems);
			}else{
				return ajaxPage.getParams()+"&formId="+this.formId;
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		QueryBtn.prototype.doBefore = function(){
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		QueryBtn.prototype.doAction = function(){
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		QueryBtn.prototype.doAfter = function(result){
			var viewType = $("[name='_openType']:eq(0)").text();
			if(viewType && viewType == "277"){
				//刷新子视图
				//var $displayView = $("div[name='display_view']");
				//$displayView.bind("refresh", function(){
				//	$displayView.load($displayView.attr("src"), function(){
				//		dy_refresh(name);					
				//	});
				//}).trigger("refresh");
				
				var $thisTab = $(this.target).parents("div[name='display_view']");
				var $url = $thisTab.attr("src");

				$thisTab.load($url, function(){
					var $tabParameter = $(".tab_parameter_Display");
					var viewid = this.id + "_params";
					var $viewDiv = $("<div></div>").attr("id",viewid).attr("_action",$(this).attr("src")).css("display","none");
					//表单元素转成span标签存入dom中
					$.each($(this).find(".tab_parameter_Display").find("input[type!=button],select,textarea").serializeArray(),function(){
						$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
					});
					$(this).append($viewDiv);
					//去掉表单元素
					$tabParameter.find("input[type!=button],select,textarea").each(function(){
						if(!$(this).attr("moduleType")) $(this).remove();
					});
					jqRefactor();					
				});
				
			}else{
//				document.forms[0].action = contextPath+"/portal/dynaform/view/displayView.action?_viewid=" + this.viewId;
//				document.forms[0].submit();
				var url = contextPath+"/portal/dynaform/view/displayView.action?_viewid=" + this.viewId;
				ajaxPage.submitPage(url);
			}
			
		}
		
		QueryBtn._initialized = true;
	
	}
	
	
	
	return this;
}