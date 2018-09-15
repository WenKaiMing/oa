/**
 * 新建操作
 * 
 */
function CreateBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 2;
	this.viewType = params.viewType;
	this.openType = params.openType;
	this.formId = params.formId;
	this.target = params.target;
	
	
	if(typeof CreateBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		CreateBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return DisplayView.span2Params(this.target);
			}else{
				var params = "";
				if(typeof(isSubGridView) != "undefined"){
					params = subGridView.getGridViewParams();
				}else{
					params = jQuery(document.forms[0]).serialize();
				}
				return params
			};
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		CreateBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				json['formId'] = this.formId;
				var elems = $(view).find("[name=_selects]:checked");
				json['_backURL'] = '';
				return DisplayView.addVal2Params(json,elems);
			}else{
				var params = "";
				if(typeof(isSubGridView) != "undefined"){
					params = subGridView.getGridViewParams();
				}else{
					params = jQuery(document.forms[0]).serialize()+"&formId="+this.formId;
				}
				return params
			}
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		CreateBtn.prototype.doBefore = function(){
			//createDoc(this.actId);
			//if(this.openType==288 && toggleButton("button_act")) return false;
			/**
			if(this.viewType!=1){
				doNew(this.actId);
			}
			**/
			//doNew(this.actId);
			return true;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		CreateBtn.prototype.doAction = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				return true;
			}
			if(this.openType==288){//网格显示
				jQuery("#VIEW_OPEN_TYPE_GRID_BTN").css("display","");
	        	DocumentUtil.doNew(this.actId, subGridView.getGridViewParams(), function(rtn) {
	        		var oTR = eval(rtn);
	        		subGridView.createTr(oTR);
	        	});
	        	return false;
			}
			return true;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		CreateBtn.prototype.doAfter = function(result){
			var obj = this.target;
			if(typeof DisplayView == 'object' && DisplayView.getTheView(obj)){//嵌入视图
				var openType = OPEN_TYPE_DIV;	//全部使用弹出层方式打开
				var _action = DisplayView.getAction(obj);
				var view = DisplayView.getTheView(obj);
				var url = contextPath + "/portal/dynaform/activity/process.action?_activityid="+this.actId+"&_formid="+this.formId;
				var json = DisplayView.span2Json(obj);
//				DisplayView.postForm(obj,url,json);
				if(this.params.parameter){
					url += "&content.id="+this.params.parameter;
				}
				this.openType = OPEN_TYPE_DIV;
				var parameters = DisplayView.getValuesMap(obj,json);
				var _backURL = DisplayView.resetBackURL(obj,json['_backURL']);	//添加查询表单中的参数
				delete json['_backURL'];
				//待重构--把查询表单中的参数设置进去
//				resetBackURL(); // view.js
			
				if (this.openType == OPEN_TYPE_POP || this.openType == OPEN_TYPE_DIV) {
					var _selects = DisplayView.getSelects(view);
					url += "&" + parameters + "&openType=" + this.openType+_selects;
//					url = appendApplicationidByView(url);
					var w = $(window).width() - 25;
					var h = $(window).height() - 100;
					showfrontframe({
								title : "",
								url : url,
								w : w,
								h : h,
								windowObj : window.parent,
								callback : function(result) {
									setTimeout(function(){//通过右上角的关闭图标关闭弹出层后会显示加载进度条，加延迟后没有这个问题
										json['_backURL'] = _backURL;
						        		DisplayView.postForm(obj,_action,json);
									},1);
								}
							});
				}
			}else{	//非嵌入视图
				// View的openType(打开类型)
				var url = contextPath + "/portal/dynaform/activity/process.action?_activityid="+this.actId+"&_formid="+this.formId;
				if(this.params.parameter){
					url += "&content.id="+this.params.parameter;
				}
				if (this.openType == 17) {
					var isRelate = document.getElementsByName("isRelate");
					url += "&isSubDoc=true";
					if (isRelate){
			            if (isRelate.length>0){
			            	var relate = isRelate[0].value;
			            	url += "&isRelate="+relate;
			            }
					}
				}
			
				if (document.getElementsByName("_openType")[0]) {
					this.openType = document.getElementsByName("_openType")[0].value;
				}
			
				var parameters = getQueryString();
			
				resetBackURL(); // view.js
			
				if (this.openType == 1) {
					if (isHomePage()) { // 首页单独处理
						url += "&_backURL="
								+ encodeURIComponent(contextPath
										+ "/portal/dispatch/homepage.jsp");
						url += "&" + parameters;
						parent.location = appendApplicationidByView(url);
					} else {
						document.forms[0].action = url;
						document.forms[0].submit();
					}
				} else if (this.openType == OPEN_TYPE_POP || this.openType == OPEN_TYPE_DIV) {
					var oSelects = document.getElementsByName("_selects");
					var _selects="";
					if(oSelects){
						for(var i=0;i<oSelects.length;i++){
							if(oSelects[i].checked){
								_selects+="&_selects="+oSelects[i].value;
							}
						}
					}
					url += "&" + parameters + "&openType=" + this.openType+_selects;
					url = appendApplicationidByView(url);
					var w = document.body.clientWidth - 25;
					var h = document.body.clientHeight - 100;
					showfrontframe({
								title : "",
								url : url,
								w : w,
								h : h,
								windowObj : window.parent,
								callback : function(result) {
									setTimeout(function(){//通过右上角的关闭图标关闭弹出层后会显示加载进度条，加延迟后没有这个问题
										document.forms[0].submit();
									},1);
								}
							});
				} else if (this.openType == OPEN_TYPE_OWN) {
					var id = document.getElementsByName("_viewid")[0].value;
					if (this.openType == VIEW_TYPE_SUB) {
						var sub_divid = parent.document.getElementById('sub_divid');
						var doc_obj = parent.document.getElementById(id);
						if (sub_divid) {
							sub_divid.value = doc_obj.src;
						}
			//			if (doc_obj) {
							//url += "&" + parameters;
							//doc_obj.src = url;
							document.forms[0].action = url;
							document.forms[0].submit();
			//			}
					} else {
						document.forms[0].action = url;
						document.forms[0].submit();
					}
			
				} else {
					if(toggleButton("button_act")) return false;
				}
			}
		}
		
		CreateBtn._initialized = true;
	
	}
	
	
	
	return this;
}