var Common = {};
Common.Util = {
	cache : {
		
	},
	/**
	 * 获取用户头像图片url地址
	 * @param userId
	 */	
	getAvatar : function(userId){
		if(!this.cache[userId]){
			$.ajax({
				type: "GET",
				url: contextPath + "/contacts/getAvatar.action",
				data: {"id":userId},
				async: false,
				dataType: "json",
				success:function(result){
					if(1==result.status){
						Common.Util.cache[userId] = result.data;
					}
				}
			});
		}
		return this.cache[userId];
	},
	/**
	 * 计算时间差
	 * @param date,date2
	 */
	daysCalc : function(date,date2){
		var startDateArr = date.split(/[- :]/); 
		var startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2], startDateArr[3], startDateArr[4], (startDateArr[5] != undefined && startDateArr[5] != "" ? startDateArr[5] : 0));
		if(!date2 || date2 == ""){
			var nowDate = new Date();
		}else{
			var nowDate = new Date(date2);
		}
		var msDate = nowDate.getTime() - startDate.getTime();
		//计算出相差天数
		var days=Math.floor(msDate/(24*3600*1000));
		//计算出小时数
		var leave1 = msDate%(24*3600*1000);//计算天数后剩余的毫秒数
		var hours = Math.floor(leave1/(3600*1000));
		//计算相差分钟数
		var leave2 = leave1%(3600*1000);//计算小时数后剩余的毫秒数
		var minutes = Math.floor(leave2/(60*1000));
		//计算相差秒数
		var leave3=leave2%(60*1000);//计算分钟数后剩余的毫秒数
		var seconds=Math.round(leave3/1000);
		//alert(" 相差 "+days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒");	
		var timeCalc = {
			    "days": days,
			    "hours": hours,
			    "minutes": minutes,
			    "seconds": seconds
			};
		return timeCalc;
	},
	/**
	 * 计算日期差
	 * @param date,date2
	 */
	numOfDayCalc : function(date,date2){
		var startDateArr = date.split(/[- :]/); 
		var startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2]);
		if(!date2 || date2 == ""){
			var years = new Date().getFullYear();
			var month = new Date().getMonth();
			var date = new Date().getDate();
			var nowDate = new Date(years,month,date);
		}else{
			var nowDate = new Date(date2);
		}
		var msDate = nowDate.getTime() - startDate.getTime();
		//计算出相差天数
		var numOfDay=Math.floor(msDate/(24*3600*1000));
		
		return numOfDay;
	},
	calculateTime : function(_time){
		var _timeAgo;
		var flowTime = new Date(_time);
		var timeFixArr = _time.split(/[- :]/); 
		var timeFixDate = new Date(timeFixArr[0], timeFixArr[1]-1, timeFixArr[2], timeFixArr[3], timeFixArr[4]);
		var Month = timeFixDate.getMonth() + 1; 
		var Day = timeFixDate.getDate(); 
		var Hour = timeFixDate.getHours(); 
		var Minute = timeFixDate.getMinutes(); 
		var _date = _time.substr(0,_time.indexOf(" "));		
		
		if(Common.Util.numOfDayCalc(_date) > 2){
			if (Month >= 10){ 
				_timeAgo = Month + "-"; 
			}else{ 
				_timeAgo = "0" + Month + "-"; 
			} 
			if (Day >= 10) 
			{ 
				_timeAgo += Day + " "; 
			}else{ 
				_timeAgo += "0" + Day; 
			} 
		}else if(Common.Util.numOfDayCalc(_date) == 2){ 
			_timeAgo = "前天 ";
			if (Hour >= 10) 
			{ 
				_timeAgo += Hour + ":" ; 
			}else{ 
				_timeAgo += "0" + Hour + ":" ; 
			} 
			if (Minute >= 10) 
			{ 
				_timeAgo += Minute ; 
			}else{ 
				_timeAgo += "0" + Minute ; 
			} 
		}else if(Common.Util.numOfDayCalc(_date) == 1){
			_timeAgo = "昨天 ";
			if (Hour >= 10) 
			{ 
				_timeAgo += Hour + ":" ; 
			}else{ 
				_timeAgo += "0" + Hour + ":" ; 
			} 
			if (Minute >= 10) 
			{ 
				_timeAgo += Minute ; 
			}else{ 
				_timeAgo += "0" + Minute ; 
			} 
		}else if(Common.Util.numOfDayCalc(_date) == 0 && Common.Util.daysCalc(_time).hours > 0){
			_timeAgo = Common.Util.daysCalc(_time).hours + " 小时前 ";
		}else if(Common.Util.numOfDayCalc(_date) == 0 && Common.Util.daysCalc(_time).hours <= 0  && Common.Util.daysCalc(_time).minutes > 5){
			_timeAgo = Common.Util.daysCalc(_time).minutes + " 分钟前 ";
		}else{
			_timeAgo = "刚刚";
		}
		
		return _timeAgo;
	},
	/**
	 * 格式化模板
	 * @param str, model
	 */
	format : function(str, model) {//格式化指定键值的模板
		for (var k in model) {
			var re = new RegExp("{" + k + "}", "g");
			str = str.replace(re, model[k]);
		}
		return str;
	},
	/**
	 * 初始化滚动条
	 * 使用nicescroll插件渲染滚动条
	 * @param obj, option
	 */
	renderScroll : function(obj,option){
		var _option = {
			cursorcolor: "#ccc",
		    cursoropacitymax: 1,  
		    touchbehavior: false,
		    cursorwidth: "7px",
		    cursorborder: "0",
		    cursorborderradius: "7px",
		    autohidemode: "leave"
		};
		var options = $.extend({},_option,option);
		obj.niceScroll(options);
	},
	/**
	 * 获取url参数
	 */
	getQueryString : function(url,name) { 
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 		
		var r = url.substr(url.indexOf("?")).substr(1).match(reg); 
		if (r != null) return unescape(r[2]); return null; 
	},
	/**
	 * 渲染分页
	 */
	renderPagination : function(id,callback){
		var $panel = $("#" + id);
		var $paginationPanel;
		var _options;
		var _datasPageCurrent = 1;
		var _datasPageCount;
		var _datasPageItem;
		var $form = $("form:eq(0)");
		if($panel && $panel.size()>0){
			$paginationPanel = $panel.find("#pagination-panel");
			_options = eval("("+$paginationPanel.attr("data-options")+")");
			_datasPageCurrent = _options._currpage - 1;
			_datasPageCount = _options._totalRowText;
			_datasPageItem = _options._pagelines;
			if($panel.find("[name='_currpage']").size()>0){
				_datasPageCurrent = parseInt($panel.find("[name='_currpage']").val())-1;
				_datasPageCount = parseInt($panel.find("[name='_rowcount']").val());
				_datasPageItem = parseInt($panel.find("[name='_pagelines']").val());
			}
		}else{	//listView.jsp
			$paginationPanel = $("#pagination-panel");
			_options = eval("("+$paginationPanel.data("options")+")");
			_datasPageCurrent = parseInt($("[name='_currpage']").val())-1;
			_datasPageCount = parseInt($("[name='_rowcount']").val());
			_datasPageItem = parseInt($("[name='_pagelines']").val());
		}
		$paginationPanel.append("<div class='pagination-body'></div><div class='pagination-other'></div>")
		
		if(_options._isPagination && _options._isPagination == "true"){
			
			if(!callback || typeof callback != "function"){
				callback = function(){
					//回调方法
			    }
			}

			if(!_datasPageItem || _datasPageItem == undefined){
				_datasPageItem = 10;
			}
//			if($panel){
//				$paginationPanel = $panel.find("#pagination-panel");
//			}else{
//				$paginationPanel = $("#pagination-panel");
//			}
			
			
			$paginationPanel.find(".pagination-body").pagination(_datasPageCount, {
				current_page: _datasPageCurrent,
				items_per_page: _datasPageItem,
				prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
				next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
			    num_edge_entries: 1,
			    num_display_entries: 5,
			    callback: callback
			});
			
			
	    	$paginationPanel.find("a").on("click",function(){
	    		var $this = $(this);
	    		var _pageNo = parseInt($("[name='_currpage']").val());
	    		var _rowNo = parseInt($("[name='_rowcount']").val());
	    		var _lineNo = parseInt($("[name='_pagelines']").val());
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
	    		$form.find("[name='_currpage']").val(_pageNum);
	    		if (listAction) {
	    			//待办经办使用
	    			var $actA = $("#ulHead li[class=active] a");
	    			if($actA && $actA.size() > 0){
	    				var ind = listAction.indexOf("?");
	    				if(ind != -1){
	    					listAction = listAction.substring(0,ind);
	    				}
	    				listAction += "?appId=" + $actA.attr("aria-controls");
	    			}
	    			
	    			$form.attr("action",listAction);
	    			$form.submit();
				}
	    	});
			
			if(_options._isShowItem && _options._isShowItem == "true"){	//true为待办经办中使用，指显示总条数
				var showItem = "<div class='showItemPanel'>" +
						"<ul style='display: none;'><li>100条</li>" +
						"<li>50条</li>" +
						"<li>25条</li>" +
						"<li>10条</li></ul>" +
						"<div class='showItemBtn'>"+_datasPageItem+"条 "+
						"<span class='glyphicon glyphicon-chevron-up'></span></div>" +
						"</div>";
				$paginationPanel.find(".pagination-other").append(showItem);
				$paginationPanel.find(".showItemBtn").on("click",function(){
					$(this).prev("ul").slideToggle("fast");
				})

				$paginationPanel.find("li").on("click",function(){
					var pageLine = parseInt($(this).text());
					$("[name='_currpage']").val(pageLine);
	    			$form.submit();
				})
				
				$(document).on("click",function(e){
					if($(e.target).closest(".showItemPanel").size()<=0 && $paginationPanel.find(".showItemPanel").find("ul").is(":visible")){
						$paginationPanel.find(".showItemPanel").find("ul").slideToggle("fast");
					}
				})
			}
		}
		if(_options._isShowTotalRow && _options._isShowTotalRow == "true"){
			var totalRow = "<div class='totalRowPanel'>总条数: "+_options._totalRowText+"</div>";
			$paginationPanel.find(".pagination-other").append(totalRow);
		}
	}
}