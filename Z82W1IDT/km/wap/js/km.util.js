KM.Util = {
	cache : {
		nDirId : "",
		nDiskId : "",
		uploadFiles : [],
		uploader : null,
		previewFile : null
	},
	/**
	 * 内容国际化
	 * 配合jquery.i18n.properties.min.js使用
	 */	
	setLanguage : function (data) {
		var str;
		if(typeof(data)=="object"){
			for(var i = 0;i < data.length;i++){
    			var _name = $.i18n.prop(data[i].name);
				if(_name != "["+data[i].name+"]"){
					data[i].name = _name;
				}
    		}
			str = data;
		}else{
			var _name = $.i18n.prop(data);
			if(_name != "["+data+"]"){
				str = $.i18n.prop(data);
			}else{
				str = data;
			}
		}
		return str;
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
						QM.Util.cache[userId] = result.data;
					}
				}
			});
		}
		
		return this.cache[userId];
	},
	/**
	 * 隐藏search结果 显示km列表
	 */
	hideSearchResult : function(){
		$('#searchResult').siblings(".km-list").show();
        $('#searchResult').hide();
        $('#searchResult').empty();
        $('#searchInput').val('');
    },
    /**
	 * 取消search
	 */
    cancelSearch : function(){
        this.hideSearchResult();
        $('#searchBar').removeClass('weui-search-bar_focusing');
        $('#searchText').show();
    },
	/**
	 * 隐藏底部菜单search
	 */
    hideActionSheet : function() {
        $('#upload-actionsheet').removeClass('weui-actionsheet_toggle');
        $('#iosMask').fadeOut(200);
    },
	/**
	 * 检查文件类型是否已知
	 */
	checkExtendName : function(ext) {
		var status = "unknown";
		switch(ext.toLowerCase()){
			case "apng":
			case "bmp":
			case "doc":
	        case "docx":
	        case "doc":
	        case "gif":
	        case "htm":
	        case "html":
	        case "jpg":
	        case "jpeg":
	        case "mov":
	        case "png":
	        case "ppt":
	        case "pptx":
	        case "pdf":
	        case "rar":
	        case "txt":
	        case "xls":
	        case "xlsx":
	        case "zip":
	        	status = ext.toLowerCase();
	        	break;
        } 
		return status;
	},
	/**
	 * 控制loading层
	 */
	controlLoading : function(active) {
		$("#toast").hide();
		if(active == "show"){
			$("#loadingToast").show();
		}else{
			setTimeout(function(){
				$("#loadingToast").hide();
        	},1000)
		}
	},
	/**
	 * 显示toast层
	 */
	showToast : function(type,content) {
		var toastClass = "";
		switch(type){
		case "info":
			toastClass = "fa fa-info weui-icon_toast";
			break;
		case "warning":
			toastClass = "fa fa-exclamation weui-icon_toast";
			break;
		case "error":
			toastClass = "fa fa-close weui-icon_toast";
			break;
		case "success":
			toastClass = "fa fa-check weui-icon_toast";
			break;
		}
		$("#toast").find("i").addClass(toastClass);
		$("#toast").find(".weui-toast__content").text(content);
		$("#toast").show();
		setTimeout(function(){
			$("#toast").find("i").removeClass();
			$("#toast").find(".weui-toast__content").text("");
			$("#toast").hide();
        },2000)
	},
	/**
	 * 控制空数据占位符
	 */
	controlPlaceholder : function(active,type) {
		if(active == "show"){
			$("#container").addClass("placeholder__"+type);
		}else{
			$("#container").removeClass("placeholder__search placeholder__content");
		}
	},
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
    renderSize : function(value){
    	if(null==value||value==''){
    		return"0 Bytes";
    	}
		var unitArr = new Array("Bytes","KB","MB","GB","TB","PB","EB","ZB","YB");
		var index=0;
		var srcsize = parseFloat(value);
		var quotient = srcsize;
    	while(quotient>1024){
    		index +=1;
    		quotient=quotient/1024;
    	}
    	var size;
    	if(quotient>=0) { 
    		var tempNumber = parseInt((quotient * Math.pow(10,2)+0.5))/Math.pow(10,2); 
    		size = tempNumber; 
    	}else{
    		numberRound1=-quotient
    		var tempNumber = parseInt((numberRound1 * Math.pow(10,2)+0.5))/Math.pow(10,2); 
    		size = -tempNumber; 
    	}
    	return size+" "+unitArr[index];
    },
    formatDate : function(fmt,date) {
    	var o = {
	        "M+": date.getMonth() + 1, //月份 
	        "d+": date.getDate(), //日 
	        "h+": date.getHours(), //小时 
	        "m+": date.getMinutes(), //分 
	        "s+": date.getSeconds(), //秒 
	        "q+": Math.floor((date.getMonth() + 3) / 3), //季度 
	        "S": date.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)){
	    	fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
	    }
	    for (var k in o){
	    	if (new RegExp("(" + k + ")").test(fmt)){
	    		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    	}
	    }
	    return fmt;
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
	 * 参考 http://stackoverflow.com/questions/23757345/android-does-not-correctly-scroll-on-input-focus-if-not-body-element
     * Android 手机下, input 或 textarea 元素聚焦时, 主动滚一把
	 */
	androidInputBugFix : function(){
        if (/Android/gi.test(navigator.userAgent)) {
            window.addEventListener('resize', function () {
                if (document.activeElement.tagName == 'INPUT' || document.activeElement.tagName == 'TEXTAREA') {
                    window.setTimeout(function () {
                        document.activeElement.scrollIntoViewIfNeeded();
                    }, 0);
                }
            })
        }
    }
}