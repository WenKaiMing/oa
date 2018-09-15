(function($){
	$.fn.obpmTabNormalField =function(){
		return this.each(function(){

			var $curPage = ajaxPage.getCurPage();
			var pageId = $curPage.attr("id");
			if($curPage.find("#form_tab > a[name=baseInfo]").size() == 0){
				$curPage.find("#form_tab").append('<a name="baseInfo" class="control-item swiper-slide active" href="#tabInfo_'+pageId+'" style="width:auto;" title="基本信息">基本信息</a>')
				.show();
				//$curPage.find(".contact-form").css("padding-top","52px");
				$curPage.find("#form_continer>span[data-id='item1mobile']").attr("id","tabInfo_"+pageId);
			}

			var $field = jQuery(this);
			$field.removeAttr("moduleType");
			
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabNormal']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabNormal']").size() == 0);
			}).obpmTabNormalField();  		//页签选项卡
			//选项卡嵌套时递归重构
			$field.find("[moduleType='TabCollapse']").filter(function(){
				return (jQuery(this).parents("[moduleType='TabCollapse']").size() == 0);
			}).obpmTabCollapseField();  		//折叠选项卡
			
			var html = "";
			// title
			var $fieldTitle = $field.find("[id='title']");

			var tabId=$field.attr("tabId");
			var fieldId=$fieldTitle.attr("fieldId");

			$fieldTitle.find("div").each(function(){
				var formId=$(this).attr("formId");
				var isHidden=$(this).attr("isHidden");
				var isRefresh=$(this).attr("isRefreshOnChanged");
				var name=$(this).attr("name");
				isRefresh = (isRefresh == "true");
				isHidden = (isHidden == "true");
								
				// 判断选项卡内是否含有非包含元素的控件
				var style = "";
				if(isHidden){
					style = "display:none;";
				}
			
				var $tab = $curPage.find("#content_"+formId);
				if($tab.length==0){
					var $tab = $field.find(".tabcontainer").find(">div[formId='"+formId+"']");
					$newTab = $('<span id="content_'+formId+'" class="control-content"></span>').append($tab.addClass("contact-form"));
                    var $newTabNav = $('<a _tid='+formId+' class="control-item swiper-slide" href="#content_'+formId+'" style="'+style+'" title="'+name+'">'+name+'</a>').on('touchend',function(){
                        window.scroll(0,0);
					});
                    $curPage.find("#form_tab").append($newTabNav);
                    $curPage.find("#form_continer").append($newTab);
                    $curPage.find("#form_continer").find("[moduleType='IncludedView']").obpmIncludedView();


                }

			});
			
			
			

			

			//页签切换选项--start
			var tabBox_width = 0;
			var tab_num = $curPage.find("#form_tab").find(".control-item").size();
			for(var i=0;i < tab_num;i++){
				$curPage.find(".segmented-control").removeAttr("style");
				var $tabItem = $curPage.find("#form_tab").find(".control-item:eq("+i+")");
				$tabItem.width("auto");
				var tabItemWidth = $tabItem.outerWidth();
				if($tabItem.is(":visible")){
					$tabItem.css("display","block");
				}else{
					$tabItem.attr("data-isHide","true").css("display","block");
					
					tabItemWidth = $tabItem.outerWidth()
					
					$tabItem.css("display","none");
				}
				tabBox_width = tabItemWidth + tabBox_width;
			}
			
			$curPage.find(".tab-box").width($(window).width());
			$curPage.find(".segmented-control").removeAttr("style");
			

			if(tab_num <= 1){
				$curPage.find("#form_tab").find("[_tid]").hide();
				$curPage.find("#form_tab").find("a[name='baseInfo']").hide();
				$curPage.find(".control-content").css("padding-top","0px")
			}else{
				var fixTopHeight = $curPage.find(".fix_top_panel").outerHeight();
				$curPage.find("#form_continer").css("padding-top",fixTopHeight);
			}

			var btnNum = $curPage.find("#div_button_box input[moduletype='activityButton']").size();
			if(btnNum > 0){
				$curPage.find(".control-content .contact-form").css("padding-bottom","57px");
			}
			
			$field.parent().attr("data-type","tab");
			var spanSize = $curPage.find("#_formHtml").find(">span").not("span[data-type='tab']").size();
			
			if(spanSize <= 0){
				$curPage.find("#form_tab").find("[name='baseInfo']").removeClass("active").hide();
				var $firstTabNav;
				$curPage.find("#form_tab a:visible").each(function(i){
					if(i == 0){
						$firstTabNav = $(this);
					}
				})
				var contentId = $firstTabNav.attr("href");
				$firstTabNav.addClass("active");
				
				$curPage.find(contentId).parent().find(">span").removeClass("active");
				$curPage.find(contentId).addClass("active");
			}
			
			if(tabBox_width <= $(window).width()){
				$curPage.find(".segmented-control").css("display","table");
				$curPage.find("#form_tab .control-item:visible").css("display","table-cell");
			}else{				
				$curPage.find(".segmented-control").width(tabBox_width);
				$curPage.find("#form_tab .control-item:visible").css("display","block");
				$curPage.find("#form_tab .control-item[data-isHide='true']").css("display","block");
				if(isiOS){
					var swiper = new Swiper('#'+pageId+' .swiper-container', {
				        slidesPerView: 'auto',
				        spaceBetween: 0,
				        freeMode: true
				    });
				}else{
					$curPage.find("#form_tab").parent().css("overflow","auto");
				}
				
				$curPage.find("#form_tab .control-item[data-isHide='true']").css("display","none");
			}
		});
	};

	$.fn.obpmTabCollapseField =function(){
		return this.each(function(){

			var $field = jQuery(this);
			var $fieldTitle = $field.find("[id='title']");
			var $fieldContent = $field.find("[id='content']");
			var fieldId = $fieldTitle.attr("fieldId");

			var data = {
				fieldId : fieldId,
				list_title : [],
				list_content : []
			}
			
			$fieldTitle.each(function(){
				var formId=$(this).attr("formId");
				var isHidden=$(this).attr("isHidden");
				var isRefresh=$(this).attr("isRefreshOnChanged");
				var name=$(this).attr("tabname");
				
				var list_title = {
					"formid" : formId,
					"ishidden" : isHidden,
					"isrefreshonchanged" : isRefresh,
					"name" : name
				}
				data.list_title.push(list_title);
			});

			$fieldContent.each(function(){
				var formId=$(this).attr("formId");
				var isHidden=$(this).attr("isHidden");
				var content = $(this).html();	
				
				var list_content = {
					"formid" : formId,
					"ishidden" : isHidden,
					"content" : content
				}
				data.list_content.push(list_content);
			});
			var $html = $(template("tabCollapse-tmpl", data));
			
			$field.after($html);
			$field.remove();
			
			jQuery("div[moduleType='TabNormal']").filter(function(){
				return (jQuery(this).parents("div[moduleType='TabNormal']").size() == 0);
			}).obpmTabNormalField(); 
		});
	};
})(jQuery);

//兼容刷新重计算时选项卡的刷新方法--膏药
var ddtabmenu = ddtabmenu || {};
ddtabmenu.showMenus = function(tabid, menuids){
	var noTabShow = true;//记录是否有tab被选中
	for (var i = 0; i < menuids.length; i++) {
		var $menu = $("a[_tid='"+menuids[i]+"']");
		var $content = $("#content_" + menuids[i]);
		$menu.show();
		if($menu.hasClass("active")){
			$content.show();
			noTabShow = false;
		}
	}
};
ddtabmenu.definemenu = function(){};
ddtabmenu.hideMenus = function(tabid, menuids){
	for (var i = 0; i < menuids.length; i++) {
		var $menu = $("a[_tid='"+menuids[i]+"']");
		var $content = $("#content_" + menuids[0]);
		$menu.hide();
		$content.removeClass("active");
	}
};
ddtabmenu.showsubmenuById = function(tabid, targetId){
	var menuitems=this[tabid+"-menuitems"];
 	if (!menuitems) {
 		return;
 	}
 	//当所有选项都隐藏时，没有默认选中项
 	if(targetId != ""){
 		ddtabmenu.showsubmenu(tabid, document.getElementById(targetId));
 	}
};


/**
 * 选中某一个页签
 * @param {} tabid
 * @param {} targetitem 目标页签
 */
ddtabmenu.showsubmenu = function(tabid, targetitem){
	if(document.getElementById("tabid")){
		var tempTabid = document.getElementById("tabid").value;
		if(tempTabid == ""){ 
			document.getElementById("tabid").value = tabid + "#" + targetitem.getAttribute("id");
		}else{
			var ids = document.getElementById("tabid").value.split(";");
			var flag = true;
			for(var i=0; i<ids.length; i++){
				var _ids = ids[i].split("#");
				if(tabid == _ids[0]){
					_ids[1] = targetitem.getAttribute("id");
					ids[i] = _ids.join("#");
					flag = false;
					break;
				}
			}
			
			if(flag){
				document.getElementById("tabid").value = tempTabid + ";" + tabid + "#" + targetitem.getAttribute("id");
			}else{
				document.getElementById("tabid").value = ids.join(";");
			}
		}
	}
	var menuitems=this[tabid+"-menuitems"];
 	if (!menuitems) {
 		return;
 	}
	// 运行计算时使用同步,使用了DWR库
	DWREngine.setAsync(false);
	if(targetitem != null)
		eval(targetitem.callback);
	DWREngine.setAsync(true);
	
	for (i=0; i<menuitems.length; i++){
		
		if (menuitems[i].getAttribute("rel")){
			if(document.getElementById(menuitems[i].getAttribute("rel")).style.display=='block'){
				menuitems[i].className="";
				document.getElementById(menuitems[i].getAttribute("rel")).style.display="none";
			}
		}
	}
	if (targetitem) {
		if (targetitem.getAttribute("rel")){
			var id =targetitem.getAttribute("rel");
		}
		var oContent = document.getElementById(targetitem.getAttribute("rel"));

		if(oContent != null || oContent != undefined){
			if(oContent.style.display !='block'){
				targetitem.className="current";
				oContent.style.display="block";
				
				//jack for iframe lazy load
				jQuery(oContent).find("[moduleType='IncludedView']").obpmIncludedView();
			}
		}
		var isloaded = oContent!=null?oContent.isloaded:false;
	}
	//选项卡iframe中引用（前台管理界面）时重新加载一次iframe页面，以解决宽高问题。
	var iframeObj = document.getElementsByTagName("iframe")[0];
	if(iframeObj){
		if(typeof iframeObj.contentWindow.adjustUserSetupPageLayout=="function"){
			iframeObj.contentWindow.document.location.reload(); 
		};
	}
}