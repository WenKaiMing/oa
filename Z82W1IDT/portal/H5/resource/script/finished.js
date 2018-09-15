var flowCenter = {};

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

//根据返回数据显示页面，无数据时显示点位符页面
flowCenter.isShowNullPage = function($liS){
	if($liS && $liS.size()>0){
		$("#content-space").css("display","none");
		$("#pagingDiv").show();
	}else{	//无数据时显示点位符
		$("#content-space").html('<table height="100%" width="100%" border="0"><tr><td align="center" valign="middle"><div class="content-space-pic iconfont-h5">&#xe050;</div><div class="content-space-txt text-center">没有查询到数据</div></td></tr></table>');
		$("#content-space").css("display","block");
		$("#pagingDiv").hide();
	}
};

flowCenter.processResult = function(result){
	var $result = $("#searchResult");

	//创建临时装载元素
	var $div = $("<div></div>").append(result);
	var $ul = $div.find("#resultData");
	var $liS = $ul.find(">li");
	
	var $pageParams = $div.find("#pageParams");
	flowCenter.setParams($pageParams);	//存储各软件的参数

	flowCenter.isShowNullPage($liS);	//根据返回数据显示页面
	
	$result.empty().append(flowCenter.render($liS));	//渲染数据
	
	$ul.remove();	//移除渲染前的数据
	
	flowCenter.renderPagination($div.find("#isPagination"));
	dy_unlock();
};

flowCenter.loadResult = function() {
	var url = "../dynaform/work/historyListNew.action";
	var data = flowCenter.getParams();
	
	$.ajax({
		url : url,
		data : data,
		dataType : "html",
		success : function(result){
			flowCenter.processResult(result);
		},
		error : function(err){
			console.error("flowCenter.loadResult error:" + err);
		}
	});
};

flowCenter.render = function($lis){
	var datas = {
			title : '',
			lists : []
	};
	
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
		var avatar = Common.Util.getAvatar(_initiatorID);
		var isImg = false;
		if(avatar!="" && avatar!=undefined){
			isImg = true;
			_avatar = "<img src ="+avatar+">";
		}else{
			_avatar = "<div class='noAvatar'>" + _initiator.substr(_initiator.length-2, 2) + "</div>";
		}
		
		_timeAgo = Common.Util.calculateTime(_time);
		
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
				   	};

		datas.lists.push(list);
	});
	
	var html = template("resultTmpl",datas);
	return $(html).find("li").bind("click",function(){
		var $this = $(this);
		var id = $this.attr("id");
		var title = $this.text();
		title = !title || title.trim().length == 0 ? "..." : title.trim();
		title = title.length > 5 ? title.substring(0, 5) + ".." : title;
		var url = $this.attr("_url");
		if(typeof(top.addTab) == "function"){
			top.addTab(id,title,url);
		}else{
			window.open(url);
		}
	});
};

flowCenter.initFinished = function(){

	//选择创办还是经办
	$("#myStartBtn").click(function() {
		dy_lock();
		var $input = $(this).find("input");
		if($input.prop("checked")){
			$input.removeProp("checked");
		}else{
			$input.prop({checked : "checked"});
		}
		if($input.prop("checked")){
			flowCenter.setParam("_isMyWorkFlow", $input.val());
		}else{
			flowCenter.setParam("_isMyWorkFlow", "");
		}
		flowCenter.setParam("_currpage", 1);
		flowCenter.loadResult();
		return false;
	});
	$("#myStartBtn input").bind("click", function(event) {
		event.stopPropagation();
		dy_lock();
		var $input = $(this);
		if($input.prop("checked")){
			flowCenter.setParam("_isMyWorkFlow", $input.val());
		}else{
			flowCenter.setParam("_isMyWorkFlow", "");
		}
		flowCenter.setParam("_currpage", 1);
		flowCenter.loadResult();
	});
	$('#_subject').bind('keydown', function(event) {
        if (event.keyCode == "13") {
    		dy_lock();
    		flowCenter.setParam("_subject", $(this).val());
    		flowCenter.setParam("_currpage", 1);
            //回车执行查询
        	flowCenter.loadResult();
            return false;
        }
    });
	//绑定查询按钮
	$("#searchBtn").click(function() {
		dy_lock();
		flowCenter.setParam("_subject", $("#_subject").val());
		flowCenter.setParam("_currpage", 1);
		flowCenter.loadResult();
		return false;
	});
	$("#_flowId").bind("change",function(){
		dy_lock();
		flowCenter.setParam("_flowId", $(this).val());
		flowCenter.setParam("_currpage", 1);
		flowCenter.loadResult();
	});
	//绑定流程查询
	$("#app").bind("change", function(){
		dy_lock();
		flowCenter.setParam("application", $(this).val());
		flowCenter.setParam("_currpage", 1);
		var url = "../dynaform/work/getFlowListByApplication.action";
		var data = flowCenter.getParams();
		
		$.ajax({url : url,
			data : data,
			dataType : "json",
			success : function(data){
				if(data != null && data.length > 0){
					var $flowId = $("#_flowId");
					$flowId.html("").append("<option value='' >选择流程</option>");
					for(var i=0; i<data.length; i++){
						var jsonF = data[i];
						$flowId.append("<option value='" + jsonF.id + "' >" + jsonF.name + "</option>");
					}
				}
			}
		});
		flowCenter.loadResult();
	}).trigger("change");
	
	if($("#app").find("option").size()<=1){
		$("#app").hide();
		$("#_flowId").css({"border-top-left-radius":"4px","border-bottom-left-radius":"4px"});
	}
};

//存储当前页不同软件中分页参数
flowCenter.params = {
		_rowcount : 0,
		_pagelines : 100,
		_currpage : 1,
		_isMyWorkFlow : "",
		application : "",
		_flowId : "",
		_subject : ""
};

flowCenter.getParams = function(){
	return flowCenter.params;
};

flowCenter.setParams = function($pageParams){
	var $form = $("<form></form>");
	var params = $form.append($pageParams).serializeArray();
	for(var pp in params){
		flowCenter.setParam(params[pp].name, params[pp].value);
	}
	$form.remove();
};

flowCenter.setParam = function(name,val){
	flowCenter.params[name] = val;
};

/**
 * 渲染分页
 */
flowCenter.renderPagination = function($panel,callback){
	//获取各软件参数
	var paramArr = flowCenter.getParams("finished");
	if(!paramArr._pagelines || paramArr._pagelines == undefined){
		paramArr._pagelines = 5;
	}
	
	var $paginationPanel = $panel.find("#pagination-panel");
	
		
	if(!callback || typeof callback != "function"){
		callback = function(){
			//回调方法
	    }
	}


	$paginationPanel.append("<div class='pagination-body'></div><div class='pagination-other'></div>")
	
	$paginationPanel.find(".pagination-body").pagination(paramArr._rowcount, {
		current_page: (paramArr._currpage - 1),
		items_per_page: paramArr._pagelines,
		prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
		next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
	    num_edge_entries: 1,
	    num_display_entries: 5,
	    callback: callback
	});
	
	
	$paginationPanel.find("a").on("click",function(){

		//获取各软件参数
		var paramArr = flowCenter.getParams("finished");
		var _pageNo = parseInt(paramArr._currpage);
		var _rowNo = parseInt(paramArr._rowcount);
		var _lineNo = parseInt(paramArr._pagelines);
		
		var $this = $(this);
		var _pageCount = Math.ceil(_rowNo/_lineNo);
		var _pageNum;
		if (isNaN(_pageNo)||isNaN(_rowNo)|| isNaN(_lineNo)) {
			return;
		}		    		
		if($this.hasClass("prev")){
			if (_pageNo > 1) {
				_pageNum = _pageNo - 1;
    		}else{
    			return;
    		}
		}else if($this.hasClass("next")){
			if (_pageCount > 1 && _pageCount > _pageNo) {
				_pageNum = _pageNo + 1;
			}else{
    			return;
    		}
		}else{
			_pageNum = parseInt($(this).text());
		}

		flowCenter.setParam("_currpage",_pageNum);
		flowCenter.loadResult();
	});
	
	var totalRow = "<div class='totalRowPanel'>" + flowCenter.multilingual["total"] + ": "+paramArr._rowcount+"</div>";
	$paginationPanel.find(".pagination-other").append(totalRow);

	$("#pagingDiv").empty().append($paginationPanel);
}