(function($){
	function getDatas(docId,applicationid,objname,showname,lastmodier,modifyTime,value,node){
		if(document.getElementsByName(objname) < 1){
			return;
	 	}
		var html="";
	        FormHelper.getFieldModifiedLog(docId,applicationid,objname,function(defvar){
	        	var obj=getRelStr(defvar);
	        	html="<table width='100%' border='0' cellspacing='10'>";
	        	html+="<tr><td nowrap='nowrap'>"+lastmodier+"</td><td nowrap='nowrap'>"+modifyTime+"</td><td>"+value+"</td><td>"+node+"</td></tr>";
	        	if(obj!=null){
	        		if(obj.length>0){
	                for(var j=0;j<obj.length;j++){
	                   html+="<tr><td  nowrap='nowrap'>"+obj[j].modifier+"</td>";
	                   html+="<td  nowrap='nowrap'>"+obj[j].time+"</td>";
	                   if(obj[j].fieldValue!=null){
	                   		html+="<td>"+obj[j].fieldValue+"</td>";
	                   }else{
	                   		html+="<td></td>";
	                   }
	                   //当为自由流程时statelabel为undefined;
	                   if(typeof(obj[j].statelabel) == "undefined")	obj[j].statelabel="";
	                   html+="<td>"+obj[j].statelabel+"</td>";
	                   html+="</tr>";
	                 }
	               }
	           }
	           html+="</tabel>";
	           jQuery("#tipsMsgDivContent").html(html);
	        });
	}
	function getRelStr(str){
		var obj = eval(str);
		if (obj instanceof Array) {
			return obj;
		} else {
			return new Array();	
		}
	}
	$.fn.showHistoryRecord = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var getName = $field.attr("getName");
			var id = $field.attr("id");
			var applicationId = $field.attr("applicationId");
			var showName = $field.attr("showName");
			var modifier = $field.attr("modifier");
			var modifiedTime = $field.attr("modifiedTime");
			var value = $field.attr("value");
			var node = $field.attr("node");
			var time1 = '';
			var time2 = '';
			var time3 = '';
			var historyMsg = jQuery("<div id='historyMsg' style='position:absolute;background-color:#D7E4F3;display: none;width:400px; z-index:1;'><div id='tipsMsgDivTitle' style='height:24px;line-height:24px;text-align:right;'><span style='float: left;margin-left: 10px;margin-top:2px;'>" + HistoryRecord + "</span><a id='closeHistory' style='padding:0 5px;cursor:pointer;'>" + closeStr + "</a></div><div id='tipsMsgDivContent' style='margin: 3px;background-color: white;width:394px;height:200px;overflow: auto;'></div></div>");
			jQuery("#"+ getName + '_showHisDiv').children().css("border","1px solid red");
			jQuery("body").append(historyMsg);
			jQuery("#"+ getName + '_showHisDiv').bind('mouseover',function(e){
				clearTimeout(time2);
				time3 = setTimeout(function(){
					if(jQuery("#tooltipParent").size()>0){
						jQuery("#tooltipParent").remove();
					}
					var tooltipParent =jQuery("<span id='tooltipParent' style='font-size:0px;width:0px;height:0px;line-height:0px;position:relative;'></span>");
					var tooltip = jQuery("<span id='tipsMsgDiv' style='display:none;position:absolute;z-index:100;width:70px;height:22px;line-height:22px;'><span id='showHistory' style='font-size:12px;color:#00f;cursor:pointer;background:#fff;'><img title="+HistoryRecord+" style='vertical-align:middle;' src=" + contextPath + "/resource/imgnew/extract_target.gif />"+HistoryRecord+"</span></span>");
					jQuery("#"+ getName + '_showHisDiv').parent().append(tooltipParent);
					tooltipParent.append(tooltip);
					getDatas(id,applicationId,getName,showName,modifier,modifiedTime,value,node);
					tooltip.stop().fadeTo(200,1);
					
					//点击显示详细历史记录的文字按钮
					jQuery("#showHistory").click(function(){
						var winWidth="";
						var winHeight="";
						if (window.innerWidth){
							winWidth = window.innerWidth;
							winHeight = window.innerHeight;
						}else if ((document.body) && (document.body.clientWidth)){
							winWidth = document.body.clientWidth;
							winHeight = document.body.clientHeight;
						}
						jQuery("#historyMsg").show();
						jQuery("#historyMsg").css({top:winHeight/2-115,left:winWidth/2-200});
						var time1='';
						var time2 = '';
						
						//显示详细历史记录的文字按钮的鼠标悬停和离开事件
						jQuery("#showHistory").bind('mouseover',function(){
							clearTimeout(time2);
						}).bind('mouseout',function(){
							time2 = setTimeout(function(){
								jQuery("#historyMsg").stop().fadeOut(200,0, function(){
									jQuery("#historyMsg").hide();
								});
							},500);
							
						});
						//详细历史记录窗口的DIV
						jQuery("#historyMsg").bind('mouseover',function(){
							clearTimeout(time1);
							clearTimeout(time2);
						}).bind('mouseout',function(){
							time1 = setTimeout(function(){
								jQuery("#historyMsg").stop().fadeOut(200, 0, function() {
									jQuery("#historyMsg").hide();
								});
							},500);
						});
						//关闭历史记录窗口
						jQuery("#closeHistory").click(function(){
							jQuery("#historyMsg").stop().fadeOut(200, 0, function() {
								jQuery("#historyMsg").hide();
							});
						});
					});
					
					jQuery('#tipsMsgDiv').bind('mouseover',function(){
						clearTimeout(time2);
						clearTimeout(time1);
					}).bind('mouseout',function(){
						time1 = setTimeout(function(){
							jQuery("#tooltipParent").remove();
						},300);
					});
				},300);
			}).bind('mouseout',function(){
				clearTimeout(time3);
				time2 = setTimeout(function(){
					jQuery("#tooltipParent").remove();
				},300);
			});
			$field.remove();
		});
	};

})(jQuery);