Message.Util = {
	cache : {
		mapping : {
			"face_[去旅行]" : "qlx_thumb.gif",
			"face_[广告]" : "ad_new0902_thumb.gif",
			"face_[doge]" : "doge_thumb.gif",
			"face_[喵喵]" : "mm_thumb.gif",
			"face_[二哈]" : "moren_hashiqi_thumb.png",
			"face_[哆啦A梦吃惊]" : "dorachijing_thumb.gif",
			"face_[哆啦A梦花心]" : "dorahaose_thumb.gif",
			"face_[哆啦A梦微笑]" : "jqmweixiao_thumb.gif",
			"face_[笑cry]" : "xiaoku_thumb.gif",
			"face_[摊手]" : "pcmoren_tanshou_thumb.png",
			"face_[抱抱]" : "pcmoren_baobao_thumb.png",
			"face_[群体围观]" : "lxhweiguan_thumb.gif",
			"face_[坏笑]" : "pcmoren_huaixiao_thumb.png",
			"face_[舔屏]" : "pcmoren_tian_thumb.png",
			"face_[污]" : "pcmoren_wu_thumb.png",
			"face_[微笑]" : "huanglianwx_thumb.gif",
			"face_[嘻嘻]" : "tootha_thumb.gif",
			"face_[哈哈]" : "laugh.gif",
			"face_[挖鼻]" : "wabi_thumb.gif",
			"face_[可爱]" : "tza_thumb.gif",
			"face_[可怜]" : "kl_thumb.gif",
			"face_[吃惊]" : "cj_thumb.gif",
			"face_[害羞]" : "shamea_thumb.gif",
			"face_[挤眼]" : "zy_thumb.gif",
			"face_[闭嘴]" : "bz_thumb.gif",
			"face_[鄙视]" : "bs2_thumb.gif",
			"face_[爱你]" : "lovea_thumb.gif",
			"face_[泪]" : "sada_thumb.gif",
			"face_[偷笑]" : "heia_thumb.gif",
			"face_[亲亲]" : "qq_thumb.gif",
			"face_[生病]" : "sb_thumb.gif",
			"face_[太开心]" : "mb_thumb.gif",
			"face_[白眼]" : "landeln_thumb.gif",
			"face_[右哼哼]" : "yhh_thumb.gif",
			"face_[左哼哼]" : "zhh_thumb.gif",
			"face_[嘘]" : "x_thumb.gif",
			"face_[哀]" : "cry.gif",
			"face_[委屈]" : "wq_thumb.gif",
			"face_[吐]" : "t_thumb.gif",
			"face_[哈欠]" : "haqianv2_thumb.gif",
			"face_[抱抱_旧]" : "bba_thumb.gif",
			"face_[怒]" : "angrya_thumb.gif",
			"face_[疑问]" : "yw_thumb.gif",
			"face_[馋嘴]" : "cza_thumb.gif",
			"face_[拜拜]" : "88_thumb.gif",
			"face_[思考]" : "sk_thumb.gif",
			"face_[汗]" : "sweata_thumb.gif",
			"face_[困]" : "kunv2_thumb.gif",
			"face_[睡]" : "huangliansj_thumb.gif",
			"face_[钱]" : "money_thumb.gif",
			"face_[失望]" : "sw_thumb.gif",
			"face_[酷]" : "cool_thumb.gif",
			"face_[色]" : "huanglianse_thumb.gif",
			"face_[哼]" : "hatea_thumb.gif",
			"face_[鼓掌]" : "gza_thumb.gif",
			"face_[晕]" : "dizzya_thumb.gif",
			"face_[悲伤]" : "bs_thumb.gif",
			"face_[抓狂]" : "crazya_thumb.gif",
			"face_[黑线]" : "h_thumb.gif",
			"face_[阴险]" : "yx_thumb.gif",
			"face_[怒骂]" : "numav2_thumb.gif",
			"face_[互粉]" : "hufen_thumb.gif",
			"face_[心]" : "hearta_thumb.gif",
			"face_[伤心]" : "unheart.gif",
			"face_[猪头]" : "pig.gif",
			"face_[熊猫]" : "panda_thumb.gif",
			"face_[兔子]" : "rabbit_thumb.gif",
			"face_[ok]" : "ok_thumb.gif",
			"face_[耶]" : "ye_thumb.gif",
			"face_[good]" : "good_thumb.gif",
			"face_[NO]" : "buyao_org.gif",
			"face_[赞]" : "z2_thumb.gif",
			"face_[来]" : "come_thumb.gif",
			"face_[弱]" : "sad_thumb.gif",
			"face_[草泥马]" : "shenshou_thumb.gif",
			"face_[神马]" : "horse2_thumb.gif",
			"face_[囧]" : "j_thumb.gif",
			"face_[浮云]" : "fuyun_thumb.gif",
			"face_[给力]" : "geiliv2_thumb.gif",
			"face_[围观]" : "wg_thumb.gif",
			"face_[威武]" : "vw_thumb.gif",
			"face_[话筒]" : "huatongv2_thumb.gif",
			"face_[蜡烛]" : "lazhuv2_thumb.gif",
			"face_[蛋糕]" : "cakev2_thumb.gif"
			
		}
	},
	/**
	 * 控制loading层
	 */
	controlLoading : function(active) {
		if(active == "show"){
			$("#loadingToast").show();
		}else{
			setTimeout(function(){
				$("#loadingToast").hide();
        	},300)
		}
	},
	/**
	 * 控制空数据占位符
	 */
	controlPlaceholder : function(active) {
		if(active == "show"){
			$("#contacts").addClass("placeholder");
		}else{
			
			$("#contacts").removeClass("placeholder");
		}
	},
	/**
	 * 文件预览
	 */
	previewFile : function(fileName, id, extName, url) {
		var url = encodeURI(encodeURI(contextPath + "/portal/share/common/preview/preview.jsp?fileName="
				+id+extName+"&path="+url+"&showName="+fileName+"&fileType="+extName));
		
		window.open(url, fileName);
		
		
		/*var _tmpwin = window.open(url, "_blank");
		_tmpwin.location.href = url;*/
	},
	/**
	 * 检查文件类型是否已知
	 */
	checkExtendName : function(ext) {
		var status = "unknown";
		switch(ext.toLowerCase()){
			case ".apng":
			case ".bmp":
			case ".doc":
	        case ".docx":
	        case ".doc":
	        case ".gif":
	        case ".htm":
	        case ".html":
	        case ".jpg":
	        case ".jpeg":
	        case ".mov":
	        case ".png":
	        case ".ppt":
	        case ".pptx":
	        case ".pdf":
	        case ".rar":
	        case ".txt":
	        case ".xls":
	        case ".xlsx":
	        case ".zip":
	        	status = ext.toLowerCase();
	        	break;
        } 
		return status;
	},
	replaceFace : function(str){
		if(str && str != undefined){
			var re = /\[.[^[]*\]/g; 
			var faceArr = str.match(re);
			if(faceArr != null && faceArr.length > 0){
				for(var i = 0; i < faceArr.length; i++){
					var fileName = Message.Util.cache.mapping["face_"+faceArr[i]];
					str = str.replace(faceArr[i],'<img src="img/face/'+fileName+'" border="0" />');
				}
			}
			return str;
		}
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
    }
}