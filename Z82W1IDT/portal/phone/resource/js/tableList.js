function tableListColumn() {
	var showColumn;
	var $body = $("body");
	if(ajaxPage.getCurPage().size() > 0){
		$body = ajaxPage.getCurPage();
	}
	

	$("table[data-mode='columntoggle']").each(function() { 
		
		
		var $tableBox = $(this);
		var $tableListID = $tableBox.attr("id"),
			$listDataTh = $tableBox.find(".listDataTh"),
			$listDataTr = $tableBox.find(".listDataTr");
		
		
		//获取用户配置视图列
		$.ajax({
			url: contextPath + "/portal/usersetup/getConfigOnWxViewColumn.action",
			async: false,
			cache:false,
			type:"POST",
			data: {
				"userId": USER.id,
				"viewId": $tableListID
			},
			success: function(result){
				if(result && result != ""){
					showColumn = JSON.parse(result);
				}
			}
		})
		
 
		$tableBox.attr("data-mode","_columntoggle");
		
		if($listDataTh.find(".listDataThTd").size()>2){
			
			var tableHeadMenu = $listDataTh.find("th").not(".listDataThFirstTd");	
			var td_length = tableHeadMenu.length;
			
			$listDataTh.append("<td class='tdMenu' onclick='tdMenu(\""+$tableListID+"\")'><img src='"+contextPath+"/portal/phone/resource/images/view/more.png'/></td>");
			$listDataTr.each(function(){
				var $tdR = $("<td class='tdRight'><span class='icon icon-right-nav'></span></td>");
				$(this).append($tdR);
				
			})
			if($("#viewMenu_"+$tableListID).size()<=0){
				
				$body.append('<div class="tableList-menu-container tableList-menu text-left" id="viewMenu_'+$tableListID+'" style="display:none;"></div>');
				$body.append('<div class="tableList-screen" id="viewScreen_'+$tableListID+'" onclick="tdMenu(\''+$tableListID+'\')" style="display:none;"></div>');
				for(i=0;i<td_length;i++)
		    	{
		    		$("#viewMenu_"+$tableListID).append('<div class="ui-checkbox"><input id="checkbox_'+$tableListID+'_'+i+'" type="checkbox" onclick="tdHide(\''+ $tableListID +'\','+i+')"><label for="checkbox_'+$tableListID+'_'+i+'">'+tableHeadMenu.eq(i).clone().text()+'</label></div>');
		    	}
			}

			if(showColumn && showColumn.length >= 1){
				tableHeadMenu.attr("data-priority","6");
				$.each(showColumn,function(key,value){
					tableHeadMenu.each(function(i){
						var text_content=$.trim($(this).text());
						if(text_content){
							$(this).attr("data-priority","1");
						}
					})
				})
			}else{
				tableHeadMenu.each(function(num){
					if(num>1){
						$(this).attr("data-priority","6");
					}else{
						$(this).attr("data-priority","1");
					}
				})
			}

	    	tableHeadMenu.each(function(num){
	    		var $tableHiddenColumn = $(this).attr("isHiddenColumn");
	    		var $tableIsVisible = $(this).attr("isVisible");
	    		
	    		if($tableHiddenColumn == "true" || $tableIsVisible == "false"){
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
		    		$body.find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')').hide();
		    		$body.find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",false);
				}else{
					if($(this).attr("data-priority")=="1"){
			    		$(this).addClass("tableTH-show");
			    		$(this).parents("#"+$tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').show();
			    		$body.find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",true);
			    	}else{
			    		$(this).addClass("tableTH-hide");
			    		$(this).parents("#"+$tableListID).find('.listDataTr').find('.listDataTrTd:eq('+num+')').hide();
			    		$body.find('#viewMenu_'+$tableListID+'>.ui-checkbox:eq('+num+')>input').attr("checked",false);
			    	}
				}
	    	});
	    	var menu_top = $(".tdMenu").offset().top + $(".tdMenu").outerHeight() + 5
	    	$("#viewMenu_"+$tableListID).css({"top":menu_top,"right":5});
		}
	});	
};

function tdHide(tableListID,num) {
	var $curPage = $("body");
	if(ajaxPage.getCurPage().size() > 0){
		$curPage = ajaxPage.getCurPage();
	}
	var listViewTable = tableListID
	$curPage.find("#"+listViewTable).find('.listDataThTd:eq('+num+')').toggle();
	$curPage.find("#"+listViewTable).find('.listDataTr').find('.listDataTrTd:eq('+num+')').toggle();
	$curPage.find("#"+listViewTable).find('.listDataTr').find('.listDataTrTd:eq('+num+')').css("text-align","center");
	$curPage.find("#"+listViewTable).find('.listDataTr').each(function(){
		$(this).find("td").each(function(){
			 if ($(this).css("display") != "none")  { 
				 return false;
			 } 
		}); 
	});
	
	//设置用户配置视图显示列
	var colums = [];
	
	$("#viewMenu_"+tableListID).find(".ui-checkbox").each(function(){
		var $this = $(this);
		if($this.find("input").is(":checked")){
			colums.push($this.find("label").text());
		}
	})
	
	$.ajax({
		url: contextPath + "/portal/usersetup/ConfigOnWxViewCoulum.action",
		cache:false,
		type:"POST",
		data:{
			"userId": USER.id,
			"viewId": tableListID,
			"colums": JSON.stringify(colums)
		}
	})
};

function tdMenu(tableListID) {
	$("#viewMenu_"+tableListID).toggle();
	$("#viewScreen_"+tableListID).toggle();
};
