
//loading show
function dy_lock() {
	jQuery("body").css("overflow","hidden");
	jQuery("#loadingMask").fadeTo(300,0.4);
}

//loading hide
function dy_unlock() {
	jQuery("body").css("overflow","visible");
	jQuery("#loadingMask").fadeOut(200);
}

/**
 * 流程中心方法
 */
var FC = {};
FC.init = function(){
	dy_lock();
	this.setApps();			//设置软件数据，并构建软件label和content
	this.loadApps();		//根据软件数据获取列表数据
};

/**
 * 配置信息
 */
FC.config = {
	pending : "../dynaform/work/pendingList.action",
	processing : "../dynaform/work/processedList.action",
	finished : "../dynaform/work/historyListNew.action",
	type : "",	//页面类型（待办-pending、经办-processing、历史查询-finished）
	url : "",	//使用的url
	params : {
		_currpage : 1,
		_pagelines : 100,
		_rowcount : 0,
		showRowcount : 0
	},	//初始参数
	startFlowData : {
		appList : []
	} //发起页面数据
};

/**
 * 存储列表数据
 * datas = { 	
		appid : {
			appId : "",			//软件id
			appName : "",		//软件名
			_rowcount : "", 	//总数
			showRowcount : "", 	//显示总数
			_pagelines : "", 	//分页数
			_currpage : "",		//当前页
			flowObjs : {"aa" : 0},
			flowLists : [{}],	//仅供artTemplate渲染使用
			lis : [{
	        	'tabID' : _flowname,
	        	'tabCon' : _text,
	        	'tabUrl' : _url,
	        	'tabName' : _flowname,
	        	'tabTime' : _timeAgo,
	        	'tabDocID' : _tabDocID,
	        	'tabInitiator' : _initiator,
	        	'tabInitiatorID' : _initiatorID,
	        	'tabAvatar' : _avatar,
	        	'tabDept' : _initiatorDept,
	        	'tabState' : _stateLabel,
	        	'isImg' : isImg
		   	}]
		}
	}
 */
FC.datas = {};

FC.fk ={hit:0,loaded:false};

/**
 * 把请求返回的数据设置到js变量中
 * result: 请求返回的dom
 */
FC.setData = function(appId, result){
	var $resu = $("<div></div>").append(result);

	var $pageParams = $resu.find("#pageParams");
	var _appNum = $pageParams.find("input[name=_rowcount]").val();
	var showRowcount = 0;		//显示在软件label旁的总数

	if(_appNum > 99){
		showRowcount = "99+";
	}else{
		showRowcount = _appNum;
	}
	
	//设置翻页数据
	var datas = this.datas[appId];
		datas._rowcount = _appNum, 		//软件总数
		datas.showRowcount = showRowcount,
		datas._pagelines = parseInt($pageParams.find("input[name=_pagelines]").val()), 		//分页数
		datas._currpage = parseInt($pageParams.find("input[name=_currpage]").val()),		//当前页
		
		datas.flowObjs = {},		//统计各流程数据总数
		datas.flowLists = [],		//仅供artTemplate渲染使用
		datas.lis = [];				//li列表数据

	
	//设置列表数据--start
	var $lis = $resu.find("#lists > li");
	$lis.each(function(){
		var $li = $(this);
		var _flowname = $.trim($li.attr("_flowname"));
		var _url = $li.attr("_url");
		var _tabDocID = $li.attr("_docid");
		var _text = $li.text();
		var _stateLabel = $li.attr("_statelabel");
		var _name = $li.attr("_auditornames");
		var _initiator = $li.attr("_initiator");
		var _initiatorID = $li.attr("_initiatorId");
		var _initiatorDept = $li.attr("_initiatorDept");
		var _time = $li.attr("_lastprocesstime");
		var _isRead = $li.attr("_isRead");
		var _timeAgo,_avatar;
		var avatar = Common.Util.getAvatar(_initiatorID);	//获取微信头像
		var isImg = false;
		if(avatar!="" && avatar!=undefined){
			isImg = true;
			_avatar = "<img src ="+avatar+">";
		}else{
			_avatar = "<div class='noAvatar'>" + _initiator.substr(_initiator.length-2, 2) + "</div>";
		}
		
		_timeAgo = Common.Util.calculateTime(_time);
		
		var readCls = "isread";
		if(_isRead == "false"){
			readCls = "noread";
		}
		
		var list =	{
			        	'tabID' : _flowname,
			        	'tabCon' : _text,
			        	'tabUrl' : _url,
			        	'tabName' : _flowname,
			        	'tabTime' : _timeAgo,
			        	'tabDocID' : _tabDocID,
			        	'tabInitiator' : _initiator,
			        	'tabInitiatorID' : _initiatorID,
			        	'tabAvatar' : _avatar,
			        	'tabDept' : _initiatorDept,
			        	'tabState' : _stateLabel,
			        	'isImg' : isImg,
			        	'readCls' : readCls
				   	};

		datas.lis.push(list);
		
		//统计各流程总数
		if(datas.flowObjs[_flowname]){
			datas.flowObjs[_flowname]++;
		}else {
			datas.flowObjs[_flowname] = 1;
		}
	});
	//设置列表数据--end
	
	//对象数据转成数组数据，artTemplate渲染使用
	for(var name in datas.flowObjs){
		datas.flowLists.push({
        	'flowName' : name,
        	'flowcount' : datas.flowObjs[name]
		});
	}
	
	$resu.remove();
};

/**
 * 设置选中流程label
 */
FC.triggerFlow = function(_appId){
	$("#content-box #" + _appId).find("ul[name=flowLabel]").find("li:eq(0) a").tab('show');		//初始化选中流程
};

/**
 * 绑定列表打开事件
 */
FC.bindEvent = function(){
	
	//数据行点击事件（待办、经办、历史查询都使用）
	$("#content-box .list-con").unbind("click").bind("click",function(){
		var $this = $(this);
		$this.find("span.noread").removeClass("noread").addClass("isread");		//仅待办
		
		var id = $this.attr("id");
		var title = $(this).find("span.tabLiCon-text").text();
		var url = $this.attr("_url");
		if(typeof(top.addTab) == "function"){
			top.addTab(id,title,url);
		}else{
			window.open(url);
		}
	});
	
	//选择创办还是经办（历史查询都使用）
	$("#myStartBtn").unbind("click").bind("click", function(){
		
		dy_lock();
		var $input = $(this).find("input");
		if($input.prop("checked")){
			$input.removeProp("checked");
		}else{
			$input.prop({checked : "checked"});
		}
		FC.finishAjax();
		return false;
	});
	$("#myStartBtn input").unbind("click").bind("click", function(event) {
		event.stopPropagation();
		dy_lock();
		FC.finishAjax();
	});
	
	//文本录入后回车事件
	$('#_subject').unbind("keydown").bind('keydown', function(event) {
        if (event.keyCode == "13") {
    		dy_lock();
    		FC.finishAjax();
        }
    });
	
	//查询按钮点击事件
	$("#searchBtn").unbind("click").bind("click", function() {
		dy_lock();
		$("#appLabel > li a").each(function(){
			var appId = $(this).attr("aria-controls");
			FC.finishAjax(appId);
		});
		
	});
	
	//发起页面顶部tab切换后初始化
	$(".startflow-tabs").find("a[data-toggle='tab']").on("shown.bs.tab", function() {
		FC.initStartFlowBox();
	});
	
	//发起页面顶部显示方式切换事件
	$(".startflow-top-group").find(".btn-startflow").on("click", function() {
		var $this = $(this);
		var view = $this.data("view");
		$this.siblings().removeClass("active");
		$this.addClass("active");
		if(view == "list"){
			$(".startflow-content-box").find(".startflow-icon").hide();
			$(".startflow-content-box").find(".startflow-list").show();
		}else{
			$(".startflow-content-box").find(".startflow-list").hide();
			$(".startflow-content-box").find(".startflow-icon").show();
		}
		FC.initStartFlowBox();
		$.cookie("startflow-view",view);
	});
	
	//发起页面菜单点击事件
	$("#startflow").find("a.menu-link").on("click", function() {
		var $this = $(this);	
		var url = $this.data("url");
		if (url.indexOf("_backURL=")<=0) {//添加returnURL，实现返回时关闭当前TAB
			url += url.indexOf("?")>0 ? "&_backURL=../../../portal/H5/closeTab.jsp" : "?_backURL=../../../portal/H5/closeTab.jsp";
		}
		if (top && top.addTab) {
			top.addTab($this.data("id"),$this.text(),url);
		}else{
			window.open(url, $this.text());
		}
	});
};

/**
 * 设置软件数据，并构建软件label和content
 * 
 */
FC.setApps = function(){
	var $appList = $("#appList");
	
	//判断是待办、经办、历史查询页面
	var _type = $appList.attr("_type");
	this.config.type = _type;
	this.config.url = this.config[_type];
	
	//获取软件列表
	var $apps = $appList.find("> div");
	if($apps.size() == 0){
		FC.setSpace();
	}
	
	$apps.each(function(){
		var $this = $(this);
		var obj  = {};
		//获取初始参数
		for(var name in FC.config.params){
			obj[name] = FC.config.params[name];
		}
		
		obj.appId = $this.attr("_appId");
		obj.appName = $this.attr("_appName");
		
		FC.datas[obj.appId] = obj;			//软件数据设置到变量中
		
		FC.setAppContent(obj.appId);		//根据软件数据构建软件label和content
	});
};

/**
 * 获取软件参数
 */
FC.getParams = function(appId){
	var data = {};
	if(this.datas[appId]){
		var params = this.datas[appId];
		data._currpage = params._currpage;
		data._pagelines = params._pagelines;
	}
	
	return data;
};

/**
 * 根据软件数据构建软件label和content
 */
FC.setAppContent = function(_appId){
	
	//构建软件label
	var datas = this.datas[_appId];
	
	var tmpl = template("appLabelTmpl", datas);	//渲染模板
	var $con = $("#appLabel > li.active a[aria-controls="+_appId+"]");
	
	if($con.size() != 0){	//已存在则替换
		$con.replaceWith(tmpl);
	}else{	//不存在则插入
		$("#appLabel").append(tmpl);
	}
	//构建软件content
	var $appC = $("#appContent #" + _appId);
	if($appC.size() == 0){
		$("#appContent").append('<div role="tabpanel" class="tab-pane" id="' + _appId + '">');
	}
};

/**
 * 加载并渲染所有软件数据
 */
FC.loadApps = function(){
	var size = 0;
	for(var name in this.datas){
		FC.ajax(name);
		size++;
	}
	var it = setInterval(function(){
		if(FC.fk.hit==size){
			FC.fk.hit=0;
			if(!FC.fk.loaded){
				$("#content-space").first().parent().show();
			}
			clearInterval(it);
		}
	}, 1000);
};

/**
 * 获取当前软件id
 */
FC.getCurApp = function(){
	return $("#appLabel > li.active a").attr("aria-controls");
};

/**
 * 设置点位符
 */
FC.setSpace = function(_appId){

	var space = '<div id="content-space">'
		+ '<table height="100%" width="100%" border="0">'
			+ '<tr>'
				+ '<td align="center" valign="middle">'
					+ '<div class="content-space-pic iconfont-h5">&#xe050;</div>'
					+ '<div class="content-space-txt text-center">' + front_nocontent + '</div>'
				+ '</td>'
			+ '</tr>'
		+ '</table>'
		+ '</div>';
		if(_appId){
			$("#appContent > #" + _appId).html(space);
		}
	
};

/**
 * 判断是否显示点位符
 */
FC.showSpace = function(_appId){
	if(this.datas[_appId]._rowcount == 0){
		FC.setSpace(_appId);
	}
};

/**
 * 判断是否显示点位符
 */
FC.finishShowSpace = function(_appId){
	for(var _appId in this.datas){
		if(this.datas[_appId]._rowcount == 0){
			FC.setSpace(_appId);
		}
	}
};

/**
 * 设置软件总数
 */
FC.setAppCount = function(_appId){
	$("#appLabel > li a[aria-controls="+_appId+"]").next("span").text(this.datas[_appId].showRowcount);
};


/**
 * 使用artTemplate渲染并构建html
 */
FC.buildHtml = function(_appId){
	this.setAppCount(_appId);		//按软件设置软件总数
	this.initTemplate(_appId);		//按软件使用artTemplate渲染数据
	this.setPage(_appId);			//按软件渲染分页
	this.triggerFlow(_appId);		//按软件触发流程名称label中的全部
	this.bindEvent();				//绑定列表打开事件
};


/**
 * 使用artTemplate渲染并构建html
 */
FC.finishBuildHtml = function(_appId){
	this.setAppCount(_appId);		//按软件设置软件总数
	this.initTemplate(_appId);		//按软件使用artTemplate渲染数据
	this.setPage(_appId);			//按软件渲染分页
	this.triggerFlow(_appId);		//按软件触发流程名称label中的全部
	this.bindEvent();				//绑定列表打开事件
};

/**
 * 根据软件id获取列表数据
 * 使用artTemplate渲染插入dom
 */
FC.ajax = function(appId){
	if(!appId){	//翻页时未传递软件id
		appId = FC.getCurApp();	//获取当前选中软件
	}
	
	var data = this.getParams(appId);
	data.application = appId;
	
	$.ajax({
		url : this.config.url,
		data : data,
		async :true,
		success : function(result){
			FC.fk.hit+=1;
			FC.setData(appId, result);		//把请求返回的数据设置到js变量中
			if(FC.datas[appId]._rowcount>0){
				FC.fk.loaded = true;
				FC.buildHtml(appId);		//使用artTemplate渲染并构建html
				$("#appLabel > li a[aria-controls="+appId+"]").parent().show();
				//选中软件
				setTimeout(function(){
					$("#appLabel > li:visible:eq(0) a").tab('show');
				}, 100);
			}else{
				$("#appLabel > li a[aria-controls="+appId+"]").parent().hide();
				FC.showSpace(appId);			//判断是否显示点位符
			}
			$("#appLabel").show();
			dy_unlock();
		},
		error : function(err){
			FC.fk.hit+=1;
			console.error("err-->" + err);
		}
	});
};

/**
 * 根据软件id获取列表数据--历史查询使用
 * 使用artTemplate渲染插入dom
 */
FC.finishAjax = function(_appId){

	var appId = _appId || FC.getCurApp();	//获取当前选中软件

	this.datas[appId]._currpage = 1;
	var data = this.getParams(appId);

	var _subject = $("#_subject").val();	//搜索的主题文本
	var _isMyWorkFlow;		//是否我发起的
	var $input = $("#myStartBtn").find("input");
	
	if($input.prop("checked")){
		_isMyWorkFlow = $input.val();
	}else{
		_isMyWorkFlow = "";
	}

	data.application = appId;
	data._subject = _subject;
	data._isMyWorkFlow = _isMyWorkFlow;
	
	$.ajax({
		url : this.config.url,
		data : data,
		success : function(result){
			FC.fk.hit+=1;
			FC.setData(appId, result);		//把请求返回的数据设置到js变量中
			if(FC.datas[appId]._rowcount>0){
				FC.fk.loaded = true;
				FC.finishBuildHtml(appId);			//使用artTemplate渲染并构建html
				$("#appLabel > li a[aria-controls="+appId+"]").parent().show();
				//选中软件
				$("#appLabel > li:visible:eq(0) a").tab('show');
			}else{
				$("#appLabel > li a[aria-controls="+appId+"]").parent().hide();
				FC.finishShowSpace(appId);			//判断是否显示点位符
			}
			$("#appLabel").show();
			dy_unlock();
		},
		error : function(err){
			FC.fk.hit+=1;
			console.error("err-->" + err);
		}
	});
};

/**
 * 使用artTemplate渲染数据
 */
FC.initTemplate = function(_appId){
	this.datas[_appId].appId = _appId;	//把软件id设置到模板数据

	var tmpl = template("appContentTmpl", this.datas[_appId]);
	$("#appContent #" + _appId).html(tmpl);
};

/**
 * 按软件渲染分页
 */
FC.setPage = function(_appId){

	var $panel = $("#" + _appId);

	//获取各软件参数
	var appParam = FC.datas[_appId];
	if(!appParam._pagelines || appParam._pagelines == undefined){
		appParam._pagelines = 100;
	}

	var $paginationPanel = $panel.find("#pagination-panel");
	$paginationPanel.append("<div class='pagination-body'></div><div class='pagination-other'></div>")
	
	$paginationPanel.find(".pagination-body").pagination(appParam._rowcount, {
		current_page: (appParam._currpage - 1),
		items_per_page: appParam._pagelines,
		prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
		next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
	    num_edge_entries: 1,
	    num_display_entries: 5
	});
	$paginationPanel.find(".pagination-other").append("<div class='totalRowPanel'>" 
			+ flowCenter.multilingual["total"] + ": "+ appParam._rowcount +"</div>");
	
	//监听事件
	$paginationPanel.find("a").on("click",function(){
		var $this = $(this);
		var appId = FC.getCurApp();
		
		//获取各软件参数
		var appParam = FC.datas[appId];
		
		var _pageCount = Math.ceil(appParam._rowcount/appParam._pagelines);
		var _pageNum;
		if (isNaN(appParam._currpage)||isNaN(appParam._rowcount)|| isNaN(appParam._pagelines)) {
			return;
		}		    		
		if($this.hasClass("prev")){
			if (appParam._currpage > 1) {
				_pageNum = appParam._currpage - 1;
    		}else{
    			return;
    		}
		}else if($this.hasClass("next")){
			if (_pageCount > 1 && _pageCount > appParam._currpage) {
				_pageNum = parseInt(appParam._currpage) + 1;
			}else{
    			return;
    		}
		}else{
			_pageNum = parseInt($(this).text());
		}
		
		appParam._currpage = _pageNum;	//设置软件当前页
		var curId = FC.getCurApp();
		
		FC.ajax(curId);			//重新加载数据
	});
};

/**
 * 初始化发起页面
 */
FC.initStartFlow = function(){
	FC.setStartFlowData();	

	holmes({
		input: '#startflow-search',
		find: '.startflow-content .search-item .menu-li,.startflow-content .search-item .menu-li-icon,.startflow-content .search-item .menu-title',
		placeholder: '',
	    class: {
	    	visible: 'visible',
	    	hidden: 'hidden'
	    },
	    onVisible: function(el) {
	    	$(el).parents(".search-item").show();
	    	FC.initStartFlowBox();
	    },
	    onHidden: function(el) {
	    	if($(el).parents(".search-item").find(".menu-li:visible").size()<=0){
	    		$(el).parents(".search-item").hide();
	    	}
	    		    	
	    	FC.initStartFlowBox();
	    }
		
	});


	//利用arttemplate渲染发起页面顶部tab
	var $startflowTabs = $(".startflow-tabs");
	var tabs = template('atp-startflow-tabs', FC.config.startFlowData);
	$startflowTabs.prepend(tabs);
	
	//利用arttemplate渲染发起页面tab内容
	var $startflowContent = $(".startflow-content");
	var tabContent = template('atp-startflow', FC.config.startFlowData);
	$startflowContent.html(tabContent);
	
	//判断内容是否为空
	if( $.trim(tabs) == null || $.trim(tabs) == ""){
		var contentIsNum = "<div class='content-load-panel'><div class='contentIsNull'></div></div>";
		$startflowContent.append($(contentIsNum));
	}
	
	//绑定事件
	this.bindEvent();

	//默认显示第一个tab
	$(".startflow-tabs a:first").tab('show');
	
	if($.cookie("startflow-view") && $.cookie("startflow-view") != ""){
		if($.cookie("startflow-view")=="list"){
			$(".startflow-top-group").find(".btn-startflow[data-view='list']").trigger("click");
		}else{
			$(".startflow-top-group").find(".btn-startflow[data-view='icon']").trigger("click");
		}
	}
};

FC.initStartFlowBox = function(){
	//初始化布局
	var container = document.querySelector('.startflow-content');
	var msnry = new Masonry( container, {
		columnWidth: 200,
		gutter: 50,
		itemSelector: '.menu-item'
	});
	//初始化滚动条
	Common.Util.renderScroll($(".startflow-content-box"),{});
};


/**
 * 按照发起页面原数据生成json
 */
FC.setStartFlowData = function(){
	var $startHtml = $("#startflow_html_box");
	var $appList = $startHtml.find("dl.menu_dl");
	//遍历软件
	$appList.each(function(i){
		var $app = $(this);
		var $appTitle = $app.find(".appTitle");
		var $topBox = $app.find(".topMenu");
		
		if($topBox.find("li.topMenuItem").size()<=0){
			FC.config.startFlowData.appList[i] = {
				appId: $app.data("appid"),
				appTitle: $appTitle.text(),
				topMenuList: ""
			}
		}else{
			//一级菜单
			var topMenuArr = [];
			
			$topBox.find("li.topMenuItem").each(function(i){
				var $topMenu = $(this);
				var topMenuId = $topMenu.attr("id");
				var topMenuTitle = $topMenu.find(".topMenu_title").text();
				var topMenuUrl = $topMenu.attr("_href");
				var topMenuType = $topMenu.attr("_type");

				//二级菜单
				var secondMenuArr = [];
				$topMenu.find(">ul>li.secondMenuItem").each(function(i){
					var $secondMenu = $(this);
					var secondMenuId = $secondMenu.attr("id");
					var secondMenuTitle = $secondMenu.find(".second_title").text();
					var secondMenuUrl = $secondMenu.attr("_href");
					var secondMenuType = $secondMenu.attr("_type");

					//三级菜单
					var thirdMenuArr = [];
					$secondMenu.find(">ul>li.thirdMenuItem").each(function(i){
						var $thirdMenu = $(this);
						var thirdMenuId = $thirdMenu.attr("id");
						var thirdMenuTitle = $thirdMenu.find(".third_title").text();
						var thirdMenuUrl = $thirdMenu.attr("_href");
						var thirdMenuType = $thirdMenu.attr("_type");
						var _iconType = $thirdMenu.attr("_iconType");
						var _icon = $thirdMenu.attr("_icon");
						var _color = $thirdMenu.attr("_color");
						var thirdMenuIcon;
						if(_iconType == "font"){
							thirdMenuIcon = '<i class="' + _icon + '" style="color: ' + _color + ';"></i>';
						} else {
							thirdMenuIcon = '<img class="menu-icon-img" src="' + contextPath + _icon + '" />';
						}
						thirdMenuArr[i] = {
							thirdMenuId: thirdMenuId,
							thirdMenuTitle: thirdMenuTitle,
							thirdMenuUrl: thirdMenuUrl,
							thirdMenuIcon: thirdMenuIcon,
						}
					})
					var _iconType = $secondMenu.attr("_iconType");
					var _icon = $secondMenu.attr("_icon");
					var _color = $secondMenu.attr("_color");
					var secondMenuIcon;
					if(_iconType == "font"){
						secondMenuIcon = '<i class="' + _icon + '" style="color: ' + _color + ';"></i>';
					} else {
						secondMenuIcon = '<img class="menu-icon-img" src="' + contextPath + _icon + '" />';
					}
					secondMenuArr[i] = {
						secondMenuId: secondMenuId,
						secondMenuTitle: secondMenuTitle,
						secondMenuUrl: secondMenuUrl,
						secondMenuIcon: secondMenuIcon,
						thirdMenuList: thirdMenuArr
					}	
				})
				var _iconType = $topMenu.attr("_iconType");
				var _icon = $topMenu.attr("_icon");
				var _color = $topMenu.attr("_color");
				var topMenuIcon;
				if(_iconType == "font"){
					topMenuIcon = '<i class="' + _icon + '" style="color: ' + _color + ';"></i>';
				} else {
					topMenuIcon = '<img class="menu-icon-img" src="' + contextPath + _icon + '" />';
				}
				topMenuArr[i] = {
					topMenuId: topMenuId,
					topMenuTitle: topMenuTitle,
					topMenuUrl: topMenuUrl,
					topMenuIcon: topMenuIcon,
					secondMenuList: secondMenuArr
				}					
			})
			FC.config.startFlowData.appList[i] = {
				appId: $app.data("appid"),
				appTitle: $appTitle.text(),
				topMenuList: topMenuArr
			}
		}
	})
};
