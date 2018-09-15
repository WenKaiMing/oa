/**
 * PM工具类
 * <p>封装公共组件的调用方法</p>
 * @author Happy
 */
var Utils = {
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

	    toastr.options.timeOut = hideAfter;
	    toastr[type](msg);
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
	 * 打开用户选择框
	 */
	selectUser : function(settings){
		art.dialog.data("args",{
			// p1:当前窗口对象
			"parentObj" : window,
			// p2:存放userid的容器id
			memberType : settings.memberType,
			container : settings.container,
			callback : settings.callback,
			selectMode : settings.selectMode
		});
		art.dialog.open(contextPath + "/pm/selectUser.jsp",{title:'选择用户',width: '682px',height: '500px'});
	},
    /**
	 * resize任务四方格页面
	 */
    resizeFourPart: function() {
    	//宽度
   	 var leftWidth = 0,
        wMarggin = 50,
        pWidth = $(window).width() - leftWidth - wMarggin,
        taskItemWidth = (pWidth - 22) / 2,
        taskNameWidth = taskItemWidth - 200;
        $(".pm-proj-list-wrap").width(taskItemWidth).find(".pm-proj-name").width(taskNameWidth);
        //高度
        var topHeight = 53,
        pHeigth = $(window).height() - topHeight,
        hMarggin = 10,
        fourPartHeight = pHeigth - 2,
        //onePartHeight = (pHeigth - 3 * hMarggin - 2) / 2 - 54;
        onePartHeight = (pHeigth - 3 ) / 2 - 95;
        "none" == $(".pm-new-task").css("display") && (onePartHeight += 40),
        $(".pm-four-part").height(fourPartHeight);
        $(".pm-proj-list-wrap").height(onePartHeight);
    },
    /**
     * 打开任务详细面板
     */
    openTaskDetailPanel : function(){
    	file_upload_init();
    	
    	var h = $(window).height() - 60 -54;
        $(".pm-task-detail-box").css({
            display: "block"
        }).show();
		//$(".pm-task-detail-outer").animate({
		$("#pm-task-info").animate({
            width: "600px"
        },"fast",function(){
        	var _height = $(window).height() - $("#pm-task-info .pm-task-detail>.pm-task-close").height() - $("#pm-task-info .pm-task-detail>.pm-task-basic").height();
        	$("#pm-task-info .pm-task-detail .pm-task-detail-scroll").slimscroll({
    			height:_height
    		});
        	$("#pm-task-info .pm-task-detail .pm-task-select-follower>ul").slimscroll({
    			height:'108px'
    		});
        });
		
		var startDate = $(".pm-task-date-input[data-type='startDate']").val();
		var endDate = $(".pm-task-date-input[data-type='endDate']").val();
		
		if(PM.cache.memberIdentity == 2){
			return false;
		}else{
			this.dateInit(startDate,endDate);
		}
    },
    /**
	 *初始化时间控件
	 */
    dateInit : function(startDate,endDate){    	
		$(".pm-task-date-input[data-type='startDate']").removeClass("hasDatepicker");
    	$(".pm-task-date-input[data-type='startDate']").attr("id","");
    	$(".pm-task-date-input[data-type='startDate']").datepicker({
    		maxDate:endDate
        });
		$(".pm-task-date-input[data-type='endDate']").removeClass("hasDatepicker");
    	$(".pm-task-date-input[data-type='endDate']").attr("id","");
    	$(".pm-task-date-input[data-type='endDate']").datepicker({
            minDate:startDate
        });
    },
    
    /**
	 *关闭任务详细面板
	 */
    closeTaskDetailPanel : function(){
    	if(PM.cache.removeTaskEl) {
    		//修改总条数
    		var $totalNum = $(".totalRowPanel").text().substr(5)-1;
    		$(".totalRowPanel").text("总条数: " + $totalNum);
    		PM.cache.removeTaskEl.remove();
    		PM.cache.removeTaskEl = null;
    	}
    	$("#pm-task-info").animate({
    	//$(".pm-task-detail-outer").animate({
            width: "0"
        },
        "fast",
        function() {
            $(".pm-task-detail-box").css({
                display: "none"
            });
        });
    },
    /**
	 *分页组件创建器
	 */
    paginationBuilder : function(rowCount,pageNo,linesPerPage,paginationFunc){//function(id,listPlace,pagePlace){
    	var totalPage = parseInt((rowCount + linesPerPage - 1)/linesPerPage);//总页数
    	var linesPerPage = linesPerPage;//每页显示的列数
    	
    	var $pagination = $("<div id='pagination-panel'></div>");
    	$pagination.append("<div class='pagination-body'></div><div class='pagination-other'></div>")
    	if(rowCount != 0){
	    	$pagination.find(".pagination-body").pagination(rowCount, {
	    		current_page: (pageNo - 1),
	    		items_per_page: linesPerPage,
	    		prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
	    		next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
	    	    num_edge_entries: 1,
	    	    num_display_entries: 5,
	    	});
	    	
	    	$pagination.find(".pagination-other").append("<div class='totalRowPanel'>总条数: "+ rowCount +"</div>");
	    	//监听事件
	    	$pagination.find("a").on("click",function(){
	    		var $this = $(this);
	    		var _pageNo = pageNo;
	    		var _rowNo = rowCount;
	    		var _lineNo = linesPerPage;
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
	    		if(paginationFunc && typeof paginationFunc == "function"){
	    			paginationFunc(_pageNum,linesPerPage);
	    		}
	    	});
    	}else{
    		var $space = '<div class="toCreate" role="tabpanel"><div id="content-space">'
    					+'<table height="100%" width="100%" border="0"><tbody><tr><td align="center" valign="middle">'
    					+'<div class="content-space-pic iconfont-h5">&#xe050;</div><div class="content-space-txt text-center">没有任务</div>'
    					+'</td></tr></tbody></table></div></div>'
    		$pagination.append($space);
    	}
    	
    	return $pagination;
    },
    
    /**
	 * 翻页渲染任务列表
	 */
    taskListRender:function(listPlace,tasks){
		$(listPlace).html($("#tmplTaskTableListItem2").tmpl(tasks,{
			getLevelText : function(){//获取优先级文本
				switch (this.data.level) {
				case 0:
					return "不重要不紧急";
					break;
				case 1:
					return "不重要紧急";
					break;
				case 2:
					return "重要不紧急";
					break;
				case 3:
					return "重要紧急";
					break;
				default:
					return "无"
					break;
				}
				
			}
		}));
	},

	cache : {
		
	},
    /**
	 * 获取用户头像图片url地址
	 * @param userId
	 */
	getAvatar:function(userId){
		if(!this.cache[userId]){
			$.ajax({
				type: "GET",
				url: "../../contacts/getAvatar.action",
				data: {"id":userId},
				async: false,
				dataType: "json",
				success:function(result){
					if(1==result.status){
						Utils.cache[userId] = result.data;
					}
				}
			});
		}
		
		return this.cache[userId];;
	},
	/**
	 * 按格式要求获取当前日期 
	 */
	getNowFormatDate:function (date, format) {
		if(!format)format = "yyyy-MM-dd";	//默认yyyy-MM-dd，另有yyyy-MM-dd HH:mm,yyyy-MM-dd HH:mm:ss
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	    if(format == "yyyy-MM-dd HH:mm"){
	    	currentdate += " " + date.getHours() + seperator2 + date.getMinutes();
	    }
	    if(format == "yyyy-MM-dd HH:mm:ss"){
	    	currentdate += " " + date.getHours() + seperator2 + date.getMinutes() + seperator2 + date.getSeconds;
	    }
	           
	    return currentdate;
	},
	
	htmlEncode :function(value){
	    if (value) {
	        return jQuery('<div />').text(value).html();
	    } else {
	        return value;
	    }
	},
	 
	htmlDecode :function (value) {
	    if (value) {
	        return $('<div />').html(value).text();
	    } else {
	        return value;
	    }
	}
	
	
		
};