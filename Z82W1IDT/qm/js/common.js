var Common = {};
Common.Util = {
	//打开遮罩
	showMask : function(){
		$(".mask").fadeIn();
	},
	//隐藏遮罩
	hideMask : function(){
		$(".mask").fadeOut();
	},
	//关闭弹出层
	hidePop: function() {
        $(".popup").hide(),
        $(".mask").fadeOut();
    },
    
	/**
	 * 弹出窗口居中
	 */
	setPopUpCenter:function(){
		$(".popup").each(function(){
			var h = $(this).height();
			var w = $(this).width();
			$(this).css("margin-left","-"+w/2+"px").css("margin-top","-"+h/2+"px");
		});
		
	},
	 /**
	 * 显示消息提示
	 * @param msg
	 * 		消息内容
	 * @param type
	 * 		消息类型（成功"success" 信息"info" 警告"warning" 错误"error"）
	 * @param hideAfter
	 * 		延时几秒后关闭消息窗体
	 */
	showMessage : function(msg, type,hideAfter) {
    	if(!msg) return;
	    var type = "undefined" == typeof type ? "info": type,
	    	hideAfter = "undefined" == typeof hideAfter ? "3000" : hideAfter;//默认3秒停留时间
	    toastr.options.closeButton = "true";
	    toastr.options.timeOut = hideAfter;
	    toastr[type](msg);
	},
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
		
		return this.cache[userId];;
	},
	/**
	 * 计算时间差
	 * @param date,date2
	 */
	daysCalc : function(date,date2){
		var startDateArr = date.split(/[- :]/); 
		var startDate = new Date(startDateArr[0], startDateArr[1]-1, startDateArr[2], startDateArr[3], startDateArr[4]);
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
	 * 渲染分页
	 */
	renderPagination : function(callback){
		var $paginationPanel = $("#pagination-panel");
		var _options = eval("("+$paginationPanel.data("options")+")");
		var _datasPageCurrent = parseInt($("[name='_currpage']").val())-1;
		var _datasPageCount = parseInt($("[name='_rowcount']").val());
		var _datasPageItem = parseInt($("[name='_pagelines']").val());
		
		_options._datasPageCount =_datasPageCount;
		_options._datasPageNo = _datasPageCurrent;
		_options._totalRowText = _datasPageCount;
		if(_options._isPagination && _options._isPagination == "true"){
			
			if(!callback || typeof callback != "function"){
				callback = function(){
					//回调方法
			    }
			}

			if(!_datasPageItem || _datasPageItem == undefined){
				_datasPageItem = 10;
			}
			
			var $paginationPanel = $("#pagination-panel");

			$paginationPanel.append("<div class='pagination-body'></div><div class='pagination-other'></div>")
			if(_options._totalRowText != 0){
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
		    		var $form = $("form:eq(0)");
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
		    		var page = $form.find("[name='_currpage']").val(_pageNum);
		    		if(isNaN(page)){
			    			var params = {
				    				"type": $("[name='type']").val(),
				    				"status": $("[name='status']").val()?$("[name='status']").val() :1,
				    				"_currpage": _pageNum,
				    				"_pagelines": _lineNo,
				    			}
			    			initList(params);
		    			}else{
		    				var params = {
				    				"type": $("[name='type']").val(),
				    				"status": $("[name='status']").val(),
				    				"_currpage": "1",
				    				"_pagelines": _lineNo,
				    			}
			    			initList(params);
		    			}
		    	})
				
				if(_options._isShowItem && _options._isShowItem == "true"){
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
						$("[name='_currpage']").val(1);
						setCookie("fileList_pageLine",pageLine);
						var params = {
			    				"type": $("[name='type']").val(),
			    				"status": $("[name='status']").val()?$("[name='status']").val() :1,
			    				"_currpage": $("[name='_currpage']").val(),
			    				"_pagelines": pageLine,
			    			}
		    			initList(params);
					})
					
					$(document).on("click",function(e){
						if($(e.target).closest(".showItemPanel").size()<=0 && $paginationPanel.find(".showItemPanel").find("ul").is(":visible")){
							$paginationPanel.find(".showItemPanel").find("ul").slideToggle("fast");
						}
					})
				}
			
				if(_options._isShowTotalRow && _options._isShowTotalRow == "true"){
					var totalRow = "<div class='totalRowPanel'>总条数: "+_options._totalRowText+"</div>";
					$paginationPanel.find(".pagination-other").append(totalRow);
				}
			}else{
		    		var $space = '<div class="toCreate" role="tabpanel"><div id="content-space">'
						+'<table height="100%" width="100%" border="0"><tbody><tr><td align="center" valign="middle">'
						+'<div class="content-space-pic iconfont-qm">&#xe002;</div><div class="content-space-txt text-center">没有问卷</div>'
						+'</td></tr></tbody></table></div></div>'
					$paginationPanel.append($space);
				}
			
		}
	}
}