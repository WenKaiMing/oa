
/**
 * 加载菜单
 */
function loadMenu(){
	showLoadingToast();
	// +号按钮
	$(".phone-main-nav-trigger").show();

	$.get("./menu.jsp?application=" + appId, function(text){
		//$("#menu").html(text).enhanceWithin();
		var $menu = $("#menu");
		$menu.attr("isLoaded", "true").html(text);
		//单击部门名称展开|折叠下级
		$menu.find(".menulist").on("click",".menu",function(e){
//			e.preventDefault();
			e.stopPropagation();
			$(this).toggleClass("open");
			$(">ul",$(this)).toggle();
		});
		
		var $appTitle = $menu.find(".appTitle");
		var $topBox = $menu.find(".top_menu_box");
		var $secondBox = $menu.find(".second_menu_box");
		var $thirdBox = $menu.find(".third_menu_box");
		
		$menu.find(".app_Title").html("<div><i class='iconfont-h5'>&#xe038;</i>" + $appTitle.text() + "</div><div class='title_line'></div>");
		
		$menu.find("li.topMenuItem").each(function(){
			var $this = $(this);
			var $topMenuItem;
			var _iconType = $this.attr("_icontype");
			var _icon = $this.attr("_icon");
			var _color = $this.attr("_color");
			
			if(_iconType == "img"){
				$topMenuItem = $("<span id='icon_" + $this.attr("id") 
						+ "' data-placement='bottom' title='" 
						+ $this.find(">.topMenu_title").text() 
						+ "'><i class='menuLiIcon weui_bar_item_on'>" 
						+ "<img src='"+contextPath+_icon+"'></i><i class='menuLiTxt'>" 
						+ $this.find(">.topMenu_title").text() + "</i></span>").appendTo($topBox);
			}else if(_iconType == "font"){
				$topMenuItem = $("<span id='icon_" + $this.attr("id") 
						+ "' data-placement='bottom' title='" 
						+ $this.find(">.topMenu_title").text() 
						+ "'><i class='menuLiIcon weui_bar_item_on'>" 
						+ "<i class='"+_icon+"' style='color:"+_color+";font-size: 50px;line-height: 100%;'></i></i><i class='menuLiTxt'>" 
						+ $this.find(">.topMenu_title").text() + "</i></span>").appendTo($topBox);
			}
			//menu1
			$topMenuItem.click(function(){
				var topMenuId = $(this).attr("id").substring(5);
				
				var $topMenuLi = $menu.find("#"+topMenuId).find(">ul>li");
				$topBox.find("span").removeClass("active");
				$(this).addClass("active");
				//$secondBox.slideUp();
				$secondBox.empty();
				$thirdBox.empty();
				
				
				if ($topMenuLi.size()<=0) {
					urlLink(topMenuId);
				}
				else {
					
					$topMenuLi.each(function(){
						var $this = $(this);
						var $secondMenuItem;
						var _iconType = $this.attr("_icontype");
						var _icon = $this.attr("_icon");
						var _color = $this.attr("_color");
						
						if(_iconType == "img"){
							$secondMenuItem = $("<span id='icon_" + $this.attr("id") 
									+ "' data-placement='bottom' title='" 
									+ $this.find(">.second_title").text() 
									+ "'><i class='menuLiIcon weui_bar_item_on'>" 
									+ "<img src='"+contextPath+_icon+"'></i><i class='menuLiTxt'>" 
									+ $this.find(">.second_title").text() + "</i></span>").appendTo($secondBox);
						}else if(_iconType == "font"){
							$secondMenuItem = $("<span id='icon_" + $this.attr("id") 
									+ "' data-placement='bottom' title='" 
									+ $this.find(">.second_title").text() 
									+ "'><i class='menuLiIcon weui_bar_item_on'>" 
									+ "<i class='"+_icon+"' style='color:"+_color+";font-size: 50px;line-height: 100%;'></i></i><i class='menuLiTxt'>" 
									+ $this.find(">.second_title").text() + "</i></span>").appendTo($secondBox);
						}
						//menu2
						$secondMenuItem.click(function(){
							var secondMenuId = $(this).attr("id").substring(5);
							var $secondMenuLi = $menu.find("#"+secondMenuId).find(">ul>li");
							$secondBox.find("span").removeClass("active");
							$(this).addClass("active");
							//$thirdBox.slideUp();
							$thirdBox.empty();
							
							if ($secondMenuLi.size()<=0){
								urlLink(secondMenuId);
							}
							else {
								$secondMenuLi.each(function(){
									var $this = $(this);
									var $thirdMenuItem;
									var _iconType = $this.attr("_icontype");
									var _icon = $this.attr("_icon");
									var _color = $this.attr("_color");
									
									if(_iconType == "img"){
										$thirdMenuItem = $("<span id='icon_" + $this.attr("id") 
												+ "' data-placement='bottom' title='" 
												+ $this.find(">.third_title").text() 
												+ "'><i class='menuLiIcon weui_bar_item_on'>" 
												+ "<img src='"+contextPath+_icon+"'></i><i class='menuLiTxt'>" 
												+ $this.find(">.third_title").text() + "</i></span>").appendTo($thirdBox);
									}else if(_iconType == "font"){
										$thirdMenuItem = $("<span id='icon_" + $this.attr("id") 
												+ "' data-placement='bottom' title='" 
												+ $this.find(">.third_title").text() 
												+ "'><i class='menuLiIcon weui_bar_item_on'>" 
												+ "<i class='"+_icon+"' style='color:"+_color+";font-size: 50px;line-height: 100%;'></i></i><i class='menuLiTxt'>" 
												+ $this.find(">.third_title").text() + "</i></span>").appendTo($thirdBox);
									}
									//menu3
									$thirdMenuItem.click(function(){
										var thirdMenuId = $(this).attr("id").substring(5);
										urlLink(thirdMenuId);
									});
									$thirdBox.slideDown("fast");
								});
							}
						});
						
					});
					$secondBox.slideDown("fast");	
				}
			});
		});
		//隐藏无菜单的软件
		$menu.find(".menu_dl").each(function(){
			if($(this).find(".menu .topMenuItem").size()<=0){
				$(this).find(".app").css("display","none");
			}else{
				$menu.find(".noApp").css("display","none");	//隐藏无发起内容的提示
			}
		});
		hideLoadingToast();

		function urlLink(liId){
			var $a = $menu.find("#"+liId);
			var url = $a.attr("_href");
			var type = ajaxPage.judgeType(url);
			switch(type){
			case "form":
				ajaxPage.useFormAction(url);	//获取url拼接路由hash
				break;
			case "view":
				ajaxPage.getToViewHash(url);
				break;
			case "oReport":
				ajaxPage.getToOReportHash(url);
				break;
			case "flowCenter":
				ajaxPage.getToFlowCenterHash(url);
				break;
			case "externalLinks":
				window.open(url);
                break;
			}
		};
		
	});

}