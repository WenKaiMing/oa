var ajaxPage = {
		debug : false,
		//控制页面刷新，弹出层打开时，refresh为false
		refresh : true,
		//存储主页几个title值
		title : {
			homePage : document.title,
			flowCenter : document.title,
			menu : document.title
		},
		//浏览器历史记录管理
		history : {
			//初始历史长度
			initLength : history.length,
			//根据历史长度计算返回页面数量
			getGoBackNum : function(){
				return -(history.length - this.initLength + 1);
			},
			/**
			 * 返回页面
			 * num:特殊操作需要返回两个页面时传值-1，如表单提交
			 */
			go : function(num){
				var gonum = -1;	//this.getGoBackNum();
				if(num){
					gonum += num;
				}
				history.go(gonum);
			}
		},
		flowHistorys : {},	//流程历史数据，根据stateid存储data
		pageArray : [],	//存储已打开的page_?页面id，不包括homePage/flowCenter/menu/iconMore
		//隐藏当前页
		hideCurPage : function(){
			this.getCurPage().removeClass("cur");
		},
		//显示新页
		showCurPage : function(id){
			$("form#"+id).addClass("cur");
		},
		//获取当前页
		getCurPage : function(){
			return $("body > form.cur");
		},
		/**
		 * 
		 * @param target : 页面id值
		 * @param isShow : 是否立即显示
		 * @returns
		 */
		addPage : function(target, isShow){
			target = target ? target : ("page_" + (this.pageArray.length + 1));
			this.pageArray.push(target);	//存储已打开的page_?页面id
			var $page = $("<form id='"+ target +"'></form>").addClass("bd cur");
			if(isShow === false){
				$page.css("display", "none");
			}else{
				this.hideCurPage();
			}
			$("body").append($page);
			return $page;
		},
		showPage : function($div, title){
			var $page = this.addPage();
			
			$page.append($div);
			ajaxPage.setTitle($page.attr("id"));
		},
		/**
		 * 关闭后打开的页面,显示已存在的
		 * 在返回上一页面或跳转到主页时，以当前页面为基准，关闭后打开的页面
		 * 除#homePage、#flowCenter、#menu外其他hash返回值true(已存在),false(不存在，当页面刷新时)
		 * @param hash
		 */
		closeOrHidePage : function(hash,url){
			if(hash == "homePage" || hash == "flowCenter" || hash == "menu"){
				$("body > form[id^=page_]").remove();
				this.pageArray.length = 0;
			}else{
				var isReload = true;	//当前hash页面没有打开(避免再次加载)
				var $page = $("body > form[id^=page_]");
				$page.each(function(){
					var _href = $(this).attr("href");
					if(url == _href){
						$(this).addClass("cur").siblings(".bd").removeClass("cur");
						var numb = $(this).attr("id").replace("page_","");
						if(parseInt(numb) < ajaxPage.pageArray.length){
							numb++;
							$("body > form#page_" + numb).remove();
							ajaxPage.pageArray.pop();
						}
						isReload = false;
						//this.getCurPage().find(">div[id^=page_]").hide();
						return;
					}
				});
				return isReload;	
			}
			
		},
		/**
		 * 隐藏所有弹出层
		 */
		hidePopUpLayer : function(){
			//hideLoadingToast();
			$("body > .mbsc-ios .dwo").trigger("click");	//移除日期控件选择界面
			OBPM.dialog.doExit();		//退出弹出层
			$("#flowReminderDiv, #page_flowPro, #viewHistory").hide();	//隐藏历史记录面板、提交回退面板、催办面板
			
			$("#confirmPanel").find(".btn-cancel").trigger("click");	//隐藏对话框
		},
		/**
		 * 添加title
		 * @param hash
		 */
		addTitle : function(hash){
			var $titles = this.getCurPage().find("title");
			if($titles.size() > 0){
				this.title[hash] = $titles.eq(0).text();	//存储title
				if($titles.attr("title") != "listView" && $titles.attr("title") != "displayView"){	//不移除列表视图，保证从表单返回后可以刷新列表视图
					$titles.remove();	//移除页面内的title
				}
			}
		},
		/**
		 * 设置title
		 */
		setTitle : function(hash){
			if(hash){
				document.title = this.title[hash];
				//修复iso下微信title需要加载新内容时才会变化的bug--start
				var $body = $('body');
				var $iframe = $('<iframe style="display:none"><img src="../../weixin/trial/images/favicon.ico"></iframe>');
				$iframe.on('load',function() {
				  setTimeout(function() {
				      $iframe.off('load').remove();
				  }, 0);
				}).appendTo($body);
				//--end
			}
		},
		/**
		 * 刷新页面--用于刷新视图
		 */
		refreshPage : function(){
			var $curPage = this.getCurPage();
			var title = $curPage.find("title").attr("title");
			if(title == "listView" || title == "displayView"){	//列表视图
				if(!ajaxPage.getCurPage().find("#_searchPanel").hasClass("active")){
					this.reloadPage();
				}else{
					ajaxPage.getCurPage().find("#_searchPanel").removeClass("active");
				}
			}
			/*//刷新表单子表视图
			var $subView = this.getCurPage().find("div[name=display_view]");
			//判断是否子表查询界面
			if(!$subView.find(".searchPanel_sub").hasClass("active")){
				//非查询直接刷新子表视图
				$subView.trigger("refresh");
			}else{
				//关闭查询界面执行子表查询方法 ,依赖obpm.displayView.js
				$subView.find(".searchPanel_sub").removeClass("active");
				DisplayView.search($subView.find(".searchPanel_sub"));
			}*/
		},
		/**
		 * 表单提交时无法获取到属性disabled为true的控件的属性值
		 * 把disabled改为false
		 * @param elements
		 * @returns {Array}
		 */
		makeAllFieldAble: function(elements) {
			var fields = [];
			if (!elements) {
				elements = this.getCurPage()[0].elements;
			}
			for (var i = 0; i < elements.length; i++) {
				var element = elements[i];
				if (element.disabled == true) {
					element.disabled = false;
					fields.push(element);
				}
			}
			
			return fields;
		},
		/**
		 * 执行与makeAllFieldAble方法相反操作
		 * 表单提交时获取好控件的属性值后恢复控件的disabled属性
		 * 把disabled改为true
		 * @param fields
		 */
		setFieldDisabled: function(fields){
			for (var i = 0; i < fields.length; i++) {
				var element = fields[i];
				if (element.disabled == false) {
					element.disabled = true;
				}
			}
		},
		//获取参数
		getParams : function(){
			var params = {};
			var $cur = this.getCurPage();	//find("div[name='params']").
			
			var fields = this.makeAllFieldAble();
			params = $cur.serialize();
			this.setFieldDisabled(fields);
			return params;
		},
		//获取参数
		getParamsArray : function(){
			var params = {};
			var $cur = this.getCurPage();	//find("div[name='params']").
			params = $cur.serializeArray();
			return params;
		},
		//根据参数名获取参数jQuery对象
		getParamsByName : function(name){//div[name='params'] 
			return this.getCurPage().find("input[name='"+name+"']");
		},
		//管理页面的加载切换和关闭
		pageCurShow : function(id){
			if(id == undefined){
				id = "page_main";
			}
			$("#" + id).addClass("cur");
		},
		//移除当前页面
		pageRemove : function(){
			$("body").children(".cur").remove();
		},
		/**
		 * 根据hash判断是否显示导航切换按钮，只在首页、流程中心、菜单中显示
		 * @param hash
		 */
		setNavPanel : function(hash){
			if(hash == "homePage" || hash == "flowCenter" || hash == "menu"){
				$("body > .phone-main-nav-panel").show();
			}else{
				$("body > .phone-main-nav-panel").hide();
			}
		},
		/**
		 * annie
		 * 
		 * */
		/*
		 * 增加hash后缀
		 * 弹出层、流程提交面板、查询、时间控件（选择时间）
		 * 在当前hash后面加/popUpLayer,/flowPro,/_searchForm,/dateControls
		 * */
		addHashPostfix : function(postfix){
			location.hash = location.hash + "/" + postfix;
			ajaxPage.controlRefresh(false);	//在原来hash背后加变量不刷新内容
		},
		/*
		 * 清楚hash额外增加的变量
		 * 弹出层、流程提交面板、查询、时间控件（选择时间）
		 * 去掉在当前hash后面加/popUpLayer,/flowPro,/_searchForm,/dateControls
		 * */
		clearHashPostfix : function(postfix){
			postfix = "/" + postfix;
			if(window.location.hash.indexOf(postfix) >= 0){
				ajaxPage.controlRefresh(false);
				$curPage = ajaxPage.getCurPage();
				if($curPage.find("title").attr("title")=="displayView"){	//区别表单查询和子表页面加载，表单查询时为true，在提交后端的ajax请求中增加这个参数以作区别
					$curPage.find("title").attr("isQueryButton", "true");
				}
        		history.back();
        	}
			
		},
		/*
		 * 弹出层、流程提交面板、查询、时间控件（选择时间）改变hash后，不刷新当前页的内容
		 * 关闭或者浏览回退也不重新加载当前页内容
		 * */
		controlRefresh : function(value){
			ajaxPage.refresh = value;	//为“true”时，页面刷新，否则，不刷新
		},
		/*
		 * 判断用哪个action进表单
		 * 带其他参数
		 * */
		useFormAction : function(_href){
			if(_href.indexOf("newWithPermission.action") > 0){	//进表单有两个action，要区别
				ajaxPage.getFormNewWithPermissionHash(_href);
			}else if(_href.indexOf("view.action") > 0){
				ajaxPage.getFormViewHash(_href);
			}
		},
		/*
		 * 判断用哪个action进表单
		 * 不带其他参数(流程进表单时不带)
		 * */
		useFormActionNoOtherParams : function(_href){
			if(_href.indexOf("newWithPermission.action") > 0){	//进表单有两个action，要区别
				ajaxPage.getFormNewWithPermissionHash(_href);
				
			}else if(_href.indexOf("view.action") > 0){
				ajaxPage.getFlowFormViewHash(_href);
			}
		},
		/**
		 * 流程进表单的路由的方法(不带当前页面参数view.action)
		 * 
		 */
		getFlowFormViewHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#form_view/"+params;
		},
		/**
		 * 进表单的路由的方法(首页widget、代办、经办,菜单进表单,带当前页面参数view.action)
		 * 
		 */
		getFormViewHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			var otherParams = ajaxPage.getParams();	//必须在$page前
			params += "&";
			params += otherParams;
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#form_view/"+params;
		},
		/**
		 * 从菜单进表单的路由的方法(视图进表单,newWithPermission.action)
		 * 
		 */
		getFormNewWithPermissionHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#form_newWithPermission/"+params;
		},
		/*
		 * 进视图，配置按钮跳转到视图(可能跳主视图，可以能跳子视图)
		 * 判断用哪个action进视图
		 * */
		useViewAction : function(_href,otherParams){
			if(_href.indexOf("displayViewWithPermission.action") > 0){	//进表单有两个action，要区别
				ajaxPage.getToViewHash(_href,otherParams);
			}else if(_href.indexOf("displayView.action") > 0){
				ajaxPage.getToDisplayViewHash(_href);
			}
		},
		/**
		 * 从菜单进视图的路由的方法
		 */
		getToViewHash : function(_href,otherParams){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			if(typeof(otherParams) != "undefined" && otherParams != ""){
				params = otherParams;
			}
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#view_displayViewWithPermission/"+params;
		},
		/**
		 * 脚本按钮进视图的路由的方法
		 */
		getToDisplayViewHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#view_displayView/"+params;
		},
		/**
		 * 内部链接进入流程中心的路由方法
		 */
		getToFlowCenterHash : function(_href){
			window.location.hash = "#flowCenter";
		},
		
		/**
		 * 子视图hash构建
		 * params={
		 * 		_href : action链接带参数,
		 * 		id : 标识	
		 * }
		 */
		getDisplayViewHash : function(_href,id){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#subView_displayView/"+id+"/"+params;
		},
		/**
		 * 子视图进表单hash构建
		 * 
		 */
		getSubViewFormHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#subView_view/"+params;
		},
		/**
		 * 新建按钮hash构建
		 * 
		 */
		getCreateHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#activity_create/"+params;
		},
		//视图刷新列表（主表、子表）
		refreshView : function(){
			$curPage = ajaxPage.getCurPage();
			var curPage_title = ajaxPage.title[$curPage.attr("id")];
			document.title = curPage_title;
			if($curPage.attr("url")){	//当前页有url时刷新页面
				if($curPage.find("title").attr("title")=="displayView"){//包含元素打开的视图刷新
					var url = $curPage.attr("href");
					var id = $curPage.find("title").attr("id");
					//区别表单查询和子表页面加载，表单查询时为true，在提交后端的ajax请求中增加这个参数以作区别
					var isQueryButton = $curPage.find("title").attr("isQueryButton");
					refreshDisplayView(url, id, isQueryButton);
				}else{
					this.refreshPage();
				}
			}
		},
		/**
 		* 获取自定义报表的hash并改变浏览器hash
 		* @param {string} _href 自定义报表的链接
 		*/
		getToOReportHash : function(_href){
			var params = ajaxPage.returnParams(_href);	//获取“？”后面得参数
			params = params.replace(/\&/g,"\/");	//把“&”替换成“/”
			location.hash = "#report_oReport/"+params;
		},

		/**
		 * 判断是进入的是表单、视图、报表、流程中心
		 * @param {string} url 跳转的链接
		 * @return {string} 返回类型
		 */
		judgeType : function(url){
			var type = "";
			if(url.indexOf("displayViewWithPermission.action") > 0 || url.indexOf("displayView.action") > 0){
				type = "view";
			}else if(url.indexOf("view.action") > 0 || url.indexOf("newWithPermission.action") > 0){
				type = "form";
			}else if(url.indexOf("oReport.jsp") > 0){
				type = "oReport";
			}else if(url.indexOf("flowCenter.jsp") > 0){
				type = "flowCenter";
			}else if(url.indexOf("http") >= 0){
				type = "externalLinks";
			}
			return type;
		},
		/**
		 * 去掉form[id^=page_]
		 * 
		 */
		removePage : function(){	//返回到主页时移除所有id值以page_开头的div page
			$("body > form[id^=page_]").remove();
			this.pageArray.length = 0;
		},
		/**
		 * 获取链接“？”后面得参数
		 * 
		 */
		returnParams : function(_href){	//
			var params = "";
			if(_href && _href.indexOf("?") != -1){
				var ind = _href.indexOf("?");
				params = _href.substring(ind+1);
			}
			return params;
		},
		/**
		 * 提交当前页面(查询列表)
		 */
		submitPage : function(url){
			var params = this.getParams();	//必须在$page前
			var $page = this.getCurPage();
			showLoadingToast();
			$.ajax({
				url : url,
				data : params,
				dataType : "html",
				cache : false,
				type : "POST",
				success : function(html){
					$page.html(html);
					ajaxPage.addTitle($page.attr("id"));
					
					hideLoadingToast();
				},
				error : function(ex){
					
				}
			});
		},
		//重加载页面
		/*
		 * 主表调用不传参数；获取当前页的url、获取当前页的所有参数
		 * 子表调用传三个参数
		 * */
		reloadPage : function(url, params,callback){
			var params = params ? params : this.getParams();
			var $page = this.getCurPage();
			var $displayView = $page.find("div[name='display_view']");
			/*//判断是否子表视图			
			if($displayView.size() > 0){
				url = $page.attr("href");
			}else{
				url = $page.attr("url");
			}*/
			var url = url ? url : $page.attr("url");
			showLoadingToast();
			$.ajax({
				url : url,
				data : params,
				dataType : "html",
				cache : false,
				type : "POST",
				success : function(html){
					$page.html(html);
					
					if($displayView.size() > 0){
						DisplayView.input2Span();
					}
					
					if(typeof(callback) == "function"){	//有回调函数时执行回调函数
						callback();
					}
					ajaxPage.history.initLength = history.length;

					setTimeout(function(){
						hideLoadingToast();
					},1000)
				},
				error : function(ex){
					
				}
			});
		},
		//加载页面
		routerLoadPage : function(url, params, callback){
			var urlParams = url+"?"+params;
			var $page = this.addPage();
			$page.attr("url", url).attr("href", urlParams);
			showLoadingToast();
			$.ajax({
				url : url,
				data : params,
				dataType : "html",
				cache : false,
				type : "POST",
				success : function(html){
					$page.html(html);
					ajaxPage.addTitle($page.attr("id"));
					ajaxPage.setTitle($page.attr("id"));
					if(typeof(callback) == "function"){	//有回调函数时执行回调函数
						callback();
					}
					ajaxPage.history.initLength = history.length;
					setTimeout(function(){
						hideLoadingToast();
					},1000)
				},
				error : function(ex){
					console.error("ajax页面加载报错：" + ex);
				}
			});
			
		}
};