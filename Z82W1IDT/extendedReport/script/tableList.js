function tableListColumn() {
	
	//设置cookie记录
	var setPriorityCookie = function(num){
		var viewId = "orderId";
		var viewCookie = $.cookie("view-"+viewId+"-priority");
		if(viewCookie == undefined){
			viewCookie = '{"0":"true","1":"true"}';
		}
		var viewJson = JSON.parse(viewCookie);
		if($("#"+tableListID).find('.listDataThTd:eq('+num+')').is(":visible")){
			viewJson[num] = "true";
		}else{
			delete viewJson[num];
		}
		$.cookie("view-"+viewId+"-priority",JSON.stringify(viewJson),{expires:7});
	}

	$("table[data-mode='columntoggle']").each(function() { 
		var $tableBox = $(this);
		var $tableListID = $tableBox.attr("id"),
			$listDataTh = $tableBox.find("thead > tr"),
			$listDataTr = $tableBox.find("tbody > tr");
 
		$tableBox.attr("data-mode","_columntoggle");

		if($listDataTh.find("td,th").size()>2){
			
			var tableHeadMenu = $listDataTh.find("th,td").not(".listDataThFirstTd");	
			var td_length = tableHeadMenu.length;
			
			$listDataTh.append("<td class='tdMenu' onclick='tdMenu(\""+$tableListID+"\")'><span class='more-vertical'>...</span></td>");
		
			//每行增加向右的图标
			$listDataTr.each(function(){
				var $tdR = $("<td class='tdRight'><span class='icon icon-right-nav'>&nbsp;>&nbsp;</span></td>");
				$(this).append($tdR);
			});
			
			if($("#viewMenu_"+$tableListID).size()<=0){
				$("body").append('<div class="tableList-menu-container tableList-menu text-left" id="viewMenu_'+$tableListID+'" style="display:none;"></div>');
				$("body").append('<div class="tableList-screen" id="viewScreen_'+$tableListID+'" onclick="tdMenu(\''+$tableListID+'\')" style="display:none;"></div>');
				for(i=0;i<td_length;i++)
		    	{
		    		$("#viewMenu_"+$tableListID).append('<div class="ui-checkbox"><input id="checkbox_'+$tableListID+'_'+i+'" type="checkbox" onclick="tdHide(\''+ $tableListID +'\','+i+')"><label for="checkbox_'+$tableListID+'_'+i+'">'+tableHeadMenu.eq(i).clone().text()+'</label></div>');
		    	}
			}
			
			//获取cookie记录
			var viewId = "orderId";
			var viewCookie = $.cookie("view-"+viewId+"-priority");
			if(viewCookie && viewCookie != undefined){
				var viewHeadJson = JSON.parse(viewCookie);
				tableHeadMenu.attr("data-priority","6");
				$.each(viewHeadJson,function(index,value){
					if(value == "true"){
						tableHeadMenu.eq(index).attr("data-priority","1");
					}
				})
			}else{
				tableHeadMenu.each(function(num){
					if(num>1){
						$(this).attr("data-priority","6");
					}else{
						$(this).attr("data-priority","1");
					}
				});
			}

	    	tableHeadMenu.each(function(num){
	    		var isHideColu = $(this).attr("ishiddencolumn");
	    		var isVisible = $(this).attr("isVisible");
	    		
	    		if(isHideColu == "true" || isVisible == "false"){
	    			if($(this).attr("data-priority") == "1"){
	    				$(this).attr("data-priority","6");
	    				if($(this).next().attr("data-priority")=="6"){
	    					$(this).next().attr("data-priority","1");
	    				}else{
	    					if($(this).next().next().attr("data-priority")=="6"){
		    					$(this).next().next().attr("data-priority","1");
		    				}
	    				}
	    			}
	    			$(this).addClass("tableTH-hide");
		    		$(this).parents("#"+$tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').hide();
		    		$("body").find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')').hide();
		    		$("body").find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",false);
				}else{
					if($(this).attr("data-priority")=="1"){
			    		$(this).addClass("tableTH-show");
			    		$(this).parents("#"+$tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').show();
			    		$("body").find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",true);
			    	}else{
			    		$(this).addClass("tableTH-hide");
			    		$(this).parents("#"+$tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').hide();
			    		$("body").find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",false);
			    	}
				}
	    	});
	    	var menu_top = $(".tdMenu").offset().top + $(".tdMenu").outerHeight() + 5
	    	$("#viewMenu_"+$tableListID).css({"top":menu_top,"right":5});
		}
	});	

};

function tdHide(tableListID,num) {
	$("#"+tableListID).find('.listDataThTd:eq('+num+')').toggle();
	$("#"+tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').toggle();
	$("#"+tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').css("text-align","center");
	$("#"+tableListID).find('.listDataTr').each(function(){
		$(this).find("td").each(function(){
			 if ($(this).css("display") != "none")  { 
				 $(this).css("text-align","left"); 
				 return false;
			 }
		}); 
	});
	//设置cookie记录
	var viewId = "orderId";
	var viewCookie = $.cookie("view-"+viewId+"-priority");
	if(viewCookie == undefined){
		viewCookie = '{"0":"true","1":"true"}';
	}
	var viewJson = JSON.parse(viewCookie);
	if($("#"+tableListID).find('.listDataThTd:eq('+num+')').is(":visible")){
		viewJson[num] = "true";
	}else{
		delete viewJson[num];
	}
	$.cookie("view-"+viewId+"-priority",JSON.stringify(viewJson));
};

function tdMenu(tableListID) {
	$("#viewMenu_"+tableListID).toggle();
	$("#viewScreen_"+tableListID).toggle();
};
