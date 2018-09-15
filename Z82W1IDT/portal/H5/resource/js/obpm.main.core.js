var Main = {
	Config : {
		tabStack : ["tabs_homepage"],//tab顺序 默认首页
		userId : "",
		contextPath : "",
		menuJson : {}
	},
	Util : {
		//更新tab顺序
		tabOrder : function(tabStr,tabArray,active){
			var tabStackIndex = $.inArray(tabStr,tabArray);
			if(tabStackIndex >= 0){
				tabArray.splice(tabStackIndex,1);
			}
			if(active == "add"){
				tabArray.push(tabStr);
			}
		},
		//根据字符串宽度截取长度(英文占1 中文占2)
		getLength : function(str,limit) {
			var len = 0,fixStr = "";
			for (var i = 0; i < str.length; i++) {
				if (str.charCodeAt(i) > 127 || str.charCodeAt(i) == 94) {
					len += 2;
				} else {
					len++;
				}
				if(len > limit){
					fixStr = str.substr(0,i) + "...";
					break;
				}
			}
			if(fixStr == ""){
				fixStr = str;
			}
			return fixStr;
		},
		// 调整main各元素尺寸
		setMainElement : function(){
			var $sidebar = $("#wrapper>.sidebar");
			var $sideMenu = $("#tabs_menu");
			var $pageWrapper = $("#wrapper>.page-wrapper");			
			var $tabsPreview = $("#tabsPreview");
			var _winHeight = $(window).height();
			var _winWidth = $(window).width();
			var _scrollHeight = _winHeight - 60;
			var _navColNum = parseInt(_winWidth / 330);
			
			//初始化sidebar菜单滚动条
			$sidebar.find(".menu").slimscroll({
				  height: _scrollHeight,
				  position: 'left',
				  distance: '0px'
			});

			//调整右侧内容高度
			$pageWrapper.height(_scrollHeight);

			//初始化预览窗口滚动条并调整样式
			$tabsPreview.find("ul.tabs-preview-panel").slimscroll({
				  height: _winHeight,
				  width: _winWidth
			});
			$tabsPreview.find("ul.tabs-preview-panel").css({
				"padding-left":(_winWidth-330*_navColNum)/2,
				"padding-right":(_winWidth-330*_navColNum)/2,
				"padding-top":"65px",
				"padding-bottom":"65px"
			})		
			$tabsPreview.find(".slimScrollDiv").css({
				"overflow":"",
				"position": "fixed",
				"display": "none",
				"top": "0px",
				"left": "0px",
				"z-index": "1100"
			});
			$('#backBlur').removeClass().hide();
		},
		
		//调整 侧边 顶部 内容 激活窗口class
		activePanel : function(id){
			var $tabs = $("#tabs");
			var $tabsPreview = $("#tabsPreview");
			var $tabsNavBar = $("ul.navbar-tabs-ul");
			var $active = $tabsPreview.find("[href*='#" + id + "']");

			$(".sidebar").find("li").removeClass("active");
			
			var _src = $("#"+id).find("iframe").attr("src");
			var $actSideBar = $(".sidebar").find("a[data-url='"+_src+"']").parent("[tabid='"+id+"']");
			var $actSCollapse = $actSideBar.parent().parent();
				
			$actSideBar.addClass("active");
			$actSCollapse.addClass("active");

			if($actSCollapse.attr("menu")=="show"){
				$actSCollapse.find(">ul").collapse('show');
				if($actSCollapse.find(">ul").hasClass("menu-third")){
					
				}else{
					$(".sidebar").find("li[menu='show']").not($actSCollapse).find("ul").collapse('hide');
				}
			}else{
				$(".sidebar").find("li[menu='show']").find("ul").collapse('hide');
			}
			if($actSCollapse.attr("menu")=="pop"){
				$actSCollapse.addClass("active");
			}

			$tabs.find(".tabs-item-wrapper").removeClass("active");
			$tabs.find("#"+id).addClass("active");
			
			$tabsPreview.find("li").removeClass("active");
			$tabsPreview.find("li>a[href*='#" + id + "']").parent().addClass("active");
			
			$tabsNavBar.find(".navbar-tabs-item").removeClass("selected");
			$tabsNavBar.find(".navbar-tabs-item[data-id='"+id+"']").addClass("selected");

			$("#navbar-tabs-preview>a").find("span.badge").text($tabsNavBar.find(".navbar-tabs-item").size());
		},
		
		//计算顶部tabs宽度
		navTabRefresh : function(){
			var $navTabs = $(".navbar-tabs");
			var $navTabPanel = $navTabs.find(".navbar-tabs-panel");
			var $navTabUl = $navTabPanel.find(".navbar-tabs-ul");
			var $navTabPreview = $("#navbar-tabs-preview");
			var navUlWidth = 0;
			var navPanelWidth = $navTabs.width()-46;
			$navTabUl.find("li").each(function(){
				var _width = $(this).outerWidth();
				navUlWidth += _width;
			})
			if(navPanelWidth < navUlWidth){
				$navTabPanel.width(navPanelWidth);
				$navTabUl.width(navUlWidth);
				var $navTabS = $navTabUl.find(".navbar-tabs-item.selected");
				var _width = $navTabS.outerWidth();
				var _left = $navTabS.position().left;
				var _right = navUlWidth - _left - _width;
				if(_left > 0){
					if(_left + _width <= navPanelWidth){
						$navTabUl.css({
							"position":"absolute",
							"left":"0px"
						})
					}else{
						if(_right + _width <= navPanelWidth){
							$navTabUl.css({
								"position":"absolute",
								"left":"-"+(navUlWidth-navPanelWidth)+"px"
							})
						}else{
							$navTabUl.css({
								"position":"absolute",
								"left":"-"+ parseInt(_left-navPanelWidth/2) +"px"
							})
						}
					}
				}else{
					$navTabUl.css({
						"position":"absolute",
						"left":"0px"
					})
				}
			}else{
				$navTabPanel.width("auto");
				$navTabUl.width("auto");
				$navTabUl.css({
					"position":"static",
					"left":"0px"
				})
			}
		},
		sendMessageLogin: function(){
			Main.Service.getMessageLogin(function(result){
				var popUpNumMessage = result[0];//消息数量
				var popUpNumAnnouncement = result[1];//公告数量
				var popUpNumComment = result[2];//回复数量
				var popUpNumNotice = result[3];//事项数量
				var totalNum = result["size"];//总数量

				var $navbarMenu = $(".navbar-menu");

				if(popUpNumMessage && popUpNumMessage > 0){
					$navbarMenu.find("li[data-id='0'] .message-popup-num").text(popUpNumMessage);
					$navbarMenu.find("li[data-id='0']").show();
					$navbarMenu.find(".message-popup").fadeIn("fast");
				}
				if(popUpNumAnnouncement && popUpNumAnnouncement > 0){
					$navbarMenu.find("li[data-id='1'] .message-popup-num").text(popUpNumAnnouncement);
					$navbarMenu.find("li[data-id='1']").show();
					$navbarMenu.find(".message-popup").fadeIn("fast");
				}
				if(popUpNumComment && popUpNumComment > 0){
					$navbarMenu.find("li[data-id='2'] .message-popup-num").text(popUpNumComment);
					$navbarMenu.find("li[data-id='2']").show();
					$navbarMenu.find(".message-popup").fadeIn("fast");
				}
				if(popUpNumNotice && popUpNumNotice > 0){
					$navbarMenu.find("li[data-id='3'] .message-popup-num").text(popUpNumNotice);
					$navbarMenu.find("li[data-id='3']").show();
					$navbarMenu.find(".message-popup").fadeIn("fast");
				}
				
				var totalNumMessage = Main.setMessageNum(totalNum);//总数量
				if(totalNum > 0){
					$navbarMenu.find(".badge").text(totalNumMessage);
					$navbarMenu.find(".badge").show();
				}
			})
		},
		sendMessageLogin2User: function(){
			Main.Service.getMessageLogin2User(function(result){
				if (window.Notification && Notification.permission === "granted") {
					//浏览器桌面通知
					for(var i = 0; i < result.data.length; i++){
						var id = result.data[i].id;
    					var messageType = result.data[i].messageType;
    					var summary = result.data[i].summary;
    					var sender = result.data[i].sender;
    					var linkParams = result.data[i].linkParams;
    					if (linkParams.indexOf("http") >= 0) {//兼容旧数据
    						var _docid = Common.Util.getQueryString(linkParams,"_docid");
    						var _formid = Common.Util.getQueryString(linkParams,"_formid");
    						var application = Common.Util.getQueryString(linkParams,"application");
    						var mode = Common.Util.getQueryString(linkParams,"mode");
    						linkParams = {
    							"_docid" : _docid,
    							"_formid" : _formid,
    							"application" : application,
    							"mode" : mode
    						}
    					}else{
    						if(linkParams != ""){
    							linkParams = JSON.parse(linkParams);
    						}
    					}
    					var linkUrl = ""
    					var messageId = result.data[i].messageId;
    					var content = "";
    					var title = "消息中心";
    					var iconUrl = "";
    					var msgType = "";
    					switch(messageType){	
    						case 0:
    							iconUrl = Main.Config.contextPath + '/portal/H5/resource/images/icon_notification_01.png';
    							content = sender + " 发布了消息";
    							linkUrl = Main.Config.contextPath + '/message/message.jsp';
    							msgType = "message";
    							break;
    						case 1:
    							iconUrl = Main.Config.contextPath + '/portal/H5/resource/images/icon_notification_02.png';
    							content = sender + " 发布了公告";
    							linkUrl = Main.Config.contextPath + '/message/message.jsp?active=announcement';
    							msgType = "announcement";
    							break;
    						case 2:
    							iconUrl = Main.Config.contextPath + '/portal/H5/resource/images/icon_notification_03.png';
    							content = sender + " 回复了你的消息：" + summary;
    							linkUrl = Main.Config.contextPath + '/message/message.jsp?active=comment';
    							msgType = "comment";
    							break
    						case 3:
    							title = "流程通知";
    							iconUrl = Main.Config.contextPath + '/portal/H5/resource/images/icon_notification_04.png';
    							var $summary = $(summary);
    							$summary.each(function(){
    								var _class = $(this).attr("class")
    								console.log($(this).text())
    								if(_class == "notice_actor" || _class == "notice_flowType" || _class == "notice_flow" || _class == "notice_summary"){
    									content += $(this).text() + " ";
    								}
    							})
    							if(linkParams != ""){
    	    						linkUrl = "../dynaform/document/view.action?_docid=" + linkParams._docid + "&" +
    									"_formid=" + linkParams._formid + "&" +
    									"application=" + linkParams.application + "&" +
    									"mode=" + linkParams.mode + "&" +
    									"backurl=../../../portal/H5/closeTab.jsp";
    	    					}
    							msgType = "workflow";
    							break
    					}
    					
    					var notification = new Notification(title,{
					    	body : Main.Util.getLength(content,37),
					    	icon : iconUrl,
					    	tag : id,
					    	data : {
					    		"id" : messageId,
					    		"url" : linkUrl,
					    		"title": content
					    	}
						}); 
						notification.onclick = function(){
							var id = this.data.id;
							var url = this.data.url;
							var title = this.data.title;
							var msgType = this.data.msgType;
							if(msgType == "workflow"){
								if(url == ""){
									id = "message";
									url = Main.Config.contextPath + '/message/message.jsp';
									title = '消息中心';
								}
							}else{
								id = "message";
								title = '消息中心';
							}
							Main.renderTabs.addTab(id,title,url);
					    }
    				}
				}else{
					//普通插件通知
					var options = {
	    					"timeOut": "300000",
	    					"extendedTimeOut": "5000",
	    					"onShown": function(){
	    						$(this).css("top","70px");
	    					}
	    				}
    				
    				for(var i = 0; i < result.data.length; i++){
    					var messageType = result.data[i].messageType;
    					var summary = result.data[i].summary;
    					var sender = result.data[i].sender;
    					var linkParams = result.data[i].linkParams;
    					var messageId = result.data[i].messageId;
    					var content = "";
    					switch(messageType){	    					
    						case 0:
    							//消息linkUrl
    							var linkUrl = "../../message/message.jsp"; 
    							content = '<a class="message-active" data-id="message" data-url="'+linkUrl+'"><i class="fa fa-pencil bg1abdff"></i><span class="notice_actor">' 
    								+ sender + '</span>' + " 发布了消息</a>";
    							OBPM.message.showDefault(options,content)
    						break;
    						case 1:
    							//公告linkUrl
    							var linkUrl = "../../message/message.jsp?active=announcement"; 
    							content = '<a class="message-active notice_summary" data-id="message" data-url="'+linkUrl+'" title="公告'+summary+'" ><i class="fa fa-volume-up bg92cf2c"></i><span class="notice_actor">'
    								+ sender + '</span>' + " 发布了公告</a>";
    							OBPM.message.showDefault(options,content)
    						break;
    						case 2:
    							//回复linkUrl
    							var linkUrl = "../../message/message.jsp?active=comment"; 
    							content = '<a class="message-active" data-id="message" data-url="'+linkUrl+'"><i class="fa fa-comments bg1edc84"></i><span class="notice_actor">'
    								+ sender + '</span>' + " 回复了你的消息：" + '<span class="notice_summary">' + summary + '</span></a>';
    							OBPM.message.showDefault(options,content)
    						break
    						case 3:
    							var type = $("<div>"+summary+"</div>").find(".notice_type").attr("type");
    							var icon = "";
    							switch(type){	    					
        							case "1"://已送出
        								icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_01.png";
        								break
            						case "2"://回退
            							icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_02.png";
            							break
            						case "3"://待办
            							icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_03.png";
                						break
            						case "4"://催办
            							icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_04.png";
                						break
            						case "5"://超时
            							icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_05.png";
                						break
            						case "6"://抄送
            							icon = "/portal/H5/resource/images/icon_menu/icon_main_msg_06.png";
                						break            						
    							}
    							//事项提醒linkUrl
    							if (linkParams.indexOf("http") >= 0) {//兼容旧数据
    	    						var _docid = Common.Util.getQueryString(linkParams,"_docid");
    	    						var _formid = Common.Util.getQueryString(linkParams,"_formid");
    	    						var application = Common.Util.getQueryString(linkParams,"application");
    	    						var mode = Common.Util.getQueryString(linkParams,"mode");
    	    						linkParams = {
    	    							"_docid" : _docid,
    	    							"_formid" : _formid,
    	    							"application" : application,
    	    							"mode" : mode
    	    						}
    	    					}else{
    	    						if(linkParams != ""){
    	    							linkParams = JSON.parse(linkParams);
    	    						}
    	    					}    							
    	    				    linkUrl = "../dynaform/document/view.action?_docid=" + linkParams._docid + "&" +
    										"_formid=" + linkParams._formid + "&" +
    										"application=" + linkParams.application + "&" +
    										"mode=" + linkParams.mode + "&" +
    										"backurl=../../../portal/H5/closeTab.jsp";
    							content = '<a class="message-active" data-id="'+ messageId +'" data-url="'+linkUrl+'">'+
    										'<img style="position: absolute;left: 15px;" src="' + Main.Config.contextPath + icon + '">'
    										+ summary + '</a>';
    							OBPM.message.showDefault(options,content)    							
    						break;
    						case -1:
    							//公告linkUrl
    							var content = $("<div>"+result.data[i].summary+"</div>").find(".notice_actor").text();
    							OBPM.message.showWarning(content);
    						break;
    					}
    				}
				}
				var totalNumMessage = Main.setMessageNum(result.amount.sum);//总数量
				var $navbarMenu = $(".navbar-menu");
				if(result.amount.sum > 0){
					$navbarMenu.find(".badge").text(totalNumMessage);
					$navbarMenu.find(".badge").show();
				}
			})
		}
	},
	
	/**
	 * 修改返回数字角标内容
	 * @param num
	 */
	setMessageNum: function(num){
		var num = parseInt(num) > 99 ? "99+" : num;
		return num;
	},
	
	init: function(){
		Main.Config.userId = $("#userId").val();
		Main.Config.contextPath = $("#contextPath").val();
		
		this.bindEven();
		this.renderTabs.init();
		this.renderHeader.init();
		this.renderSidebar.init();
		
		this.renderMenu.init();
		
		Main.Util.setMainElement();		
		Main.Util.sendMessageLogin();

		if (window.Notification && Notification.permission !== "granted") {
			Notification.requestPermission(function (status) {
		    	if (Notification.permission !== status) {
		    		Notification.permission = status;
		    	}
		    });
		}

		setInterval(function(){
			Main.Util.sendMessageLogin2User();
		},30000)
	},
	bindEven : function(){
		//窗口改变调整尺寸
		$(window).resize(function() {
			Main.Util.setMainElement();
		});
	},
	
	renderTabs: {
		init : function(){
			this.bindEven();	
		},
		bindEven : function(){
			var $tabsPreview = $("#tabsPreview");
			var $navTabs = $(".navbar-tabs");
			var $tabs = $("#tabs");
			$tabsPreview.click(function(event){
				if (!$(event.target).hasClass("ui-icon-close")){
					$('#backBlur').removeClass().addClass('animated fadeOut');
					$('#backBlur').hide();
					$tabsPreview.hide();
				}
			})
			
			//激活窗口
			$tabsPreview.on("click","a[data-url]",function(){
				var tabActHref = $(this).attr("href");
				var tabActID = tabActHref.substring(1);
				Main.Util.tabOrder(tabActHref.substring(1),Main.Config.tabStack,"add");
				Main.Util.activePanel(tabActID);
			}),
			
			
			//关闭全部窗口
			$tabsPreview.on("click","a.nav-closeAll-btn",function(){
				$tabsPreview.find(".tabs-preview-panel").find("span.glyphicon-remove").each(function(){
					var id = $(this).parent("li").data("id");
					Main.renderTabs.closeTab(id);
				})
			}),
			//关闭窗口
			$tabsPreview.on("click","span.glyphicon-remove",function() {
				var id = $(this).parent("li").data("id");
				Main.renderTabs.closeTab(id);
			});
			//顶部nav关闭窗口
			$navTabs.on("click","a.tab-btn-close",function() {
				var id = $(this).parent("li").data("id");
				Main.renderTabs.closeTab(id);
			});
			//顶部nav激活窗口
			$navTabs.on("click","a.tab-btn-title",function() {
				var $this = $(this);
				var panelId = $this.data("id");
				Main.Util.tabOrder(panelId,Main.Config.tabStack,"add");
				Main.Util.activePanel(panelId);
			});
		},
		//新增或激活tab
		addTab : function(id, label, url){
			var template = {
					tab : "<li data-id='#"+"{id}'><a href='#"+"{href}' data-url='#"+"{url}'><div class='status-box'><span class='status'>" + current_page + "</span></div>" +
							"<div class='nav-title'>#" + "{label}</div></a>" +
							"<iframe data-render='false' frameborder='no' border='0' marginwidth='0' marginheight='0'></iframe>" +
							"<span class='glyphicon glyphicon-remove'></span></li>",
					tabPic : "<li data-id='#"+"{id}'><a href='#"+"{href}' data-url='#"+"{url}'><div class='status-box'>"
							+"<span class='status'>" + current_page + "</span></div><div class='nav-title'>#" + "{label}</div></a>"
							+"<img src='#" + "{pic}' style='width: 100%;height: 100%;'>"
							+"<span class='glyphicon glyphicon-remove'></span></li>",
					nav : "<li class='navbar-tabs-item' data-id='#"+"{id}'>"
							+"<a class='tab-btn-title' data-id='#"+"{id}' data-url='#"+"{url}'><div class='nav-title'>#"+"{label}</div></a>"
							+"<a class='tab-btn-close'><i class='fa fa-times'></i></a></li>",	
				}
			var $tabs = $("#tabs");
			var $tabsPreview = $("#tabsPreview");
			var $tabsNavBar = $("ul.navbar-tabs-ul");
			var $active = $tabsPreview.find("[href*='#" + id + "']");
			//如果id已经添加，则选中
			if ($active.size() > 0) {
				$tabs.find("#"+ id + ">iframe").attr("src",url);
			} else {
				var $previewItem = "";
				var $navItem = "";
				if(id == "tabs_pm_task" || id == "tabs_pm_project" || id == "tabs_pm_label"){
					var pic = "../share/images/logo/tab-pm.jpg";
					$previewItem = $(template.tabPic.replace(/#\{href\}/g,"#" + id)
							.replace(/#\{label\}/g, label)
							.replace(/#\{url\}/g, url)
							.replace(/#\{id\}/g, id)
							.replace(/#\{pic\}/g, pic));
					$navItem = $(template.nav.replace(/#\{id\}/g, id).replace(/#\{label\}/g, label).replace(/#\{url\}/g, url));
				}else if(id == "tabs_qm_homepage" || id == "tabs_qm_center"){
					var pic = "../share/images/logo/tab-qm.jpg";
					$previewItem = $(template.tabPic.replace(/#\{href\}/g,"#" + id)
							.replace(/#\{label\}/g, label)
							.replace(/#\{url\}/g, url)
							.replace(/#\{id\}/g, id)
							.replace(/#\{pic\}/g, pic));
					$navItem = $(template.nav.replace(/#\{id\}/g, id).replace(/#\{label\}/g, label).replace(/#\{url\}/g, url));
				}else{
					if(url.indexOf("/share/report/oReport/oReport.jsp") > 0){
						var pic = "../share/images/logo/tab-report.jpg";
						$previewItem = $(template.tabPic.replace(/#\{href\}/g,"#" + id)
								.replace(/#\{label\}/g, label)
								.replace(/#\{url\}/g, url)
								.replace(/#\{id\}/g, id)
								.replace(/#\{pic\}/g, pic));
						$navItem = $(template.nav.replace(/#\{id\}/g, id).replace(/#\{label\}/g, label).replace(/#\{url\}/g, url));
					}else{
						$previewItem = $(template.tab.replace(/#\{href\}/g,"#" + id)
								.replace(/#\{label\}/g, label)
								.replace(/#\{id\}/g, id)
								.replace(/#\{url\}/g, url));
						$navItem = $(template.nav.replace(/#\{id\}/g, id).replace(/#\{label\}/g, label).replace(/#\{url\}/g, url));
					}
					
				}
				var $contentIframe = $("<div class='tabs-item-wrapper fadeInRightMain animated tab-pane' "
									 +"style='z-index:2;position: relative;background: #f6f7fb;' id='" + id + "' >"
									 +"<iframe src='" + url + "' _tags='window' frameborder='no' "
									 +"border='0' marginwidth='0' marginheight='0' height='100%' width='100%'>" +
									 +"</iframe></div>");
				
				$tabsNavBar.append($navItem);
				$tabs.append($contentIframe);
				$tabsPreview.find(".tabs-preview-panel").append($previewItem);
			}
			Main.Util.activePanel(id);
			Main.Util.tabOrder(id,Main.Config.tabStack,"add");
			Main.Util.navTabRefresh();
		},
		//关闭tab
		closeTab : function(id, refreshId) {
			var $tabs = $("#tabs");
			var $tabsPreview = $("#tabsPreview");
			var $tabsNavBar = $("ul.navbar-tabs-ul");

			if(!id || id == ""){
				id = $tabsNavBar.find(".selected").data("id");	
			}

			if(id != "tabs_homepage"){
				$tabs.find("#" + id).remove();
				$tabsPreview.find("li>a[href*='#" + id + "']").parent().remove();
				$tabsNavBar.find(".navbar-tabs-item[data-id='" + id + "']").remove();
				
				Main.Util.tabOrder(id,Main.Config.tabStack);
				var tabActiveID = Main.Config.tabStack[Main.Config.tabStack.length-1];
				Main.Util.activePanel(tabActiveID);
				Main.Util.navTabRefresh ();
			}
		},
		//刷新widget
		refreshWidget:function(refreshId){
			var obj = document.getElementById("iframe-homepage").contentWindow;
			obj.$("[refreshId='"+refreshId+"']").trigger("refresh");
			obj.$("[refreshId='system_workflow']").trigger("refresh");
		}
	},
	
	renderHeader : {
		init : function(){
			this.bindEven();
			this.renderUserPic();
		},
		bindEven : function(){
			//用户
			$(".navbar-menu").find(".dropdown-toggle").mouseenter(function(){   
		    	$(this).parents(".top-user").find(".dropdown").addClass('open');    
		    });
			$(".navbar-menu").mouseleave(function(){
		    	$(this).find(".dropdown").removeClass('open');
		    });
			//管理
			$(".user-manageDomain").on("click",function(){
				var id = "manageDomain";
				var title = $(this).find("a#manageDomain").attr("title");
				var url = $(this).find("a#manageDomain").attr("_url");
				Main.renderTabs.addTab("manageDomainTab",title,url);
			});
			//个人设置
			$(".user-person-setting").on("click",function(){
				var _userId = $("#userId").val();				
				var _url = "../user/editPersonal.action?editPersonalId=" + _userId;
				var _path = "../H5/resource/component/artDialog";
				OBPM.dialog.show({
					opener: window,
					width: 920,
					height: 550,
					url: _url,
					icon:"icons_3",
					path: _path,
					title: "个人设置",
					close: function(rtn) {
						debugger;
					}
				});
			});	
			
			//消息
			$(".user-message").on("click",function(){   
				var id = "message";
				var title = $(this).find("a").attr("title");
				var url = $(this).find("a").data("url");
				Main.renderTabs.addTab(id,title,url);
				$(".message-popup").fadeOut("fast");
				//$(this).find(".badge").hide();
				//$(".user-box>.badge").hide();
				Main.Service.removeMessageLogin();
		    });
			
			//消息弹窗跳转
			$(".navbar-menu").find(".message-popup .message-popup-active").on("click",function(){
				var id = "message";
				var title = "消息中心";
				var url = $(this).data("url");
				Main.renderTabs.addTab(id,title,url);
				$(".message-popup").fadeOut("fast");
				Main.Service.setMessageRead({"ids":$(this).data("id")});
				Main.Util.removeMessageLogin();
				return false;
		    });
			
			//消息弹窗关闭按钮
			$(".navbar-menu").find(".message-popup .message-popup-close").on("click",function(){   
				$(this).parent(".message-popup").fadeOut("fast");
				return false;
		    });
			
			//实时消息跳转
			$("body").on("click",".toast-default .message-active",function(){
				var id = $(this).data("id");
				var url = $(this).data("url");
				var title = $(this).find(".notice_summary").text();
				if(title == "" || title == undefined){ //兼容公告、回复
					title = '消息中心';
				}
				if(url == ""){
					id = "message";
					url = Main.Config.contextPath + '/message/message.jsp';
					title = '消息中心';
				}
				Main.renderTabs.addTab(id,title,url);
			})
			//预览
			$("#navbar-tabs-preview").on("click",function(){
				var $tabsPreview = $("#tabsPreview");
				var $backBlur = $("#backBlur");

				$backBlur.show();
				$tabsPreview.find(".slimScrollDiv").show();
				$tabsPreview.show();
				$tabsPreview.find('li').addClass('animatedFast zoomIn');
				$backBlur.removeClass().addClass('animated fadeIn');
				
				$tabsPreview.find("iframe[data-render='false']").each(function(){
					var $this = $(this);
					var $thisIframeCon = $this.contents();
					var _href = $this.prev().attr("href");
					var _id = _href.substring(1);
					var $_document = $("#"+_id).find("iframe").contents();
					var $_noJsDoc = $_document.find("html").clone()
					$_noJsDoc.find("script").remove();
					$_docIframe = $_noJsDoc.find("iframe");
					if($_docIframe.size() > 0){
						$_noJsDoc.find("iframe").each(function(){
							var src = $(this).attr("src");
							if(src.indexOf("../") == 0){
								$(this).attr("src","../dynaform" + src.substr(2));
							}
						})
					}
					$thisIframeCon.find("html").html($_noJsDoc.html());
					$this.attr("data-render","true");
				})
			})
			//顶部按钮点击addTab
			$(".top-tool-bar li").click(function() {
				var $this = $(this);
				if($this.attr("menu")=="open"){
					$this.siblings("[menu='pop']").find("ul.menu-second-pop").removeClass("in");
					var url = $this.children("a").attr("_url");
					var tabid = $this.attr("tabid");
					var title = $this.find("h5").text();
					if(tabid==""||tabid==undefined||!tabid){
						tabid = "iframe_" + $this.attr("id");
						title = $this.text();
					}								
					Main.renderTabs.addTab(tabid, title, url);
				}
				$this.siblings("[menu='pop']").find("ul.menu-second-pop").removeClass("in");
			});
		},
		renderUserPic : function(){
			var userPic = Common.Util.getAvatar(Main.Config.userId,Main.Config.contextPath)
			if(userPic!="" && userPic!=undefined){
				$(".user-box>img").attr("src",userPic);
			}
		}
	},
	renderSidebar : {
		init : function(){
			this.changeSidebarStatus();
			this.bindEven();
		},
		changeSidebarStatus : function(){
			var winWidth = $(window).width();
			if(winWidth < 800){
				var $sidebarSmall = $(".sidebar-small");
				var $sidebar = $(".sidebar");
				$sidebar.find(".arrow-zoom").hide();
				$sidebar.addClass("sidebar-zoom sidebar-hidden");
				$sidebarSmall.addClass("sidebar-zoom").removeClass("sidebar-small-hidden");
				$("#tabs").css("margin-left","25px");
			}
		},
		bindEven : function(){
			//左侧菜单点击addTab
			$(".tabs_menu").on("hover","li",function() {
				var $this = $(this);

				if (!$this.hasClass("active")) {
					$this.addClass("hover");
				}
			}, function() {
				var $this = $(this);
				if($this.parents(".menu-second").size()<=0){
					$this.parents(".menu").css("overflow","hidden");//临时解决缩小后菜单不能弹出
				}
				$this.removeClass("hover");
				if (!$this.hasClass("active")) {
					
				}
			});
			
			$(".tabs_menu").on("click","li",function(e) {
				var $this = $(this);
				//利用menu判断是展开菜单还是打开页面
				if($this.attr("menu")=="open"){
//					if($this.parents("li[menu='show']").size()<=0){
//						if($this.parents("li[menu='pop']").size()<=0){
//							$("#tabs_menu li").find("ul").collapse('hide');
//						}
//					}
					var url = $this.children("a").data("url");
					var tabid = $this.attr("tabid");
					
					var title = $this.find(".main-menu_title").text();
					
					if(tabid==""||tabid==undefined||!tabid){
						tabid = "iframe_" + $this.attr("id");
						title = $this.text();
					}
					
					if(tabid == "iframe_tabs_pm"){
						if($("#iframe_tabs_pm").size()>0){
							$("#iframe_tabs_pm").find("iframe").attr("src",url);
						}
					}
					if(tabid == "iframe_tabs_qm"){
						if($("#iframe_tabs_qm").size()>0){
							$("#iframe_tabs_qm").find("iframe").attr("src",url);
						}
					}
					
					if(url){	//一级菜单未配置链接时不打开页面
						if($this.attr("target") == "blank"){
							window.open(url);
						}else{
							Main.renderTabs.addTab(tabid, title, url);
						}
						if($this.find("ul").length > 0){
							var $a = $this.find("a");
							if($a.hasClass("menu-second-pop")){
								$this.parent().find("[menu='show']").not($this).find("ul").collapse('hide');
							}else{
								$this.parents(".menu").find("[menu='show']").not($this).find("ul").collapse('hide');
								$("#tabs_flowcenter>li.active,#tabs_menu>li.active").removeClass("active");
							}
							$this.addClass("active");
						}else{
							return false;
						}
					}
				}else if($this.attr("menu")=="show"){
					var $a = $this.find("a");
					if($a.hasClass("menu-second-pop")){
						$this.parent().find("[menu='show']").not($this).find("ul").collapse('hide');
					}else{
						$this.parents(".menu").find("[menu='show']").not($this).find("ul").collapse('hide');
						$("#tabs_flowcenter>li.active,#tabs_menu>li.active").removeClass("active");
					}
					$this.addClass("active");
				}
				$this.siblings("[menu='pop']").find("ul").collapse('hide');
			});
			
			$(window).on("resize",function(){
				Main.renderSidebar.changeSidebarStatus();
			});
			
			//菜单缩放按钮
			$(".arrow-zoom").on("click",function(){
				var $this = $(this);
				var zoom = $this.data("zoom");
				var $sidebarSmall = $(".sidebar-small");
				var $sidebar = $(".sidebar");
				if(zoom == "in"){
					$sidebar.find(".arrow-zoom").show();
					$sidebar.removeClass("sidebar-zoom sidebar-hidden");
					$sidebarSmall.removeClass("sidebar-zoom").addClass("sidebar-small-hidden");
					$("#tabs").css("margin-left","190px");
				}else if(zoom == "out"){
					$sidebar.find(".arrow-zoom").hide();
					$sidebar.addClass("sidebar-zoom sidebar-hidden");
					$sidebarSmall.addClass("sidebar-zoom").removeClass("sidebar-small-hidden");
					$("#tabs").css("margin-left","25px");
				}
			});

			//菜单自动显示
			$("#wrapper").on("mouseenter",".sidebar-small.sidebar-zoom .menu-small-mask",function(a){
				var $sidebarSmall = $(".sidebar-small");
				var $sidebar = $(".sidebar");
				$sidebar.removeClass("sidebar-hidden");
			}).on("mouseleave",".sidebar.sidebar-zoom",function(a){
				var $sidebarSmall = $(".sidebar-small");
				var $sidebar = $(".sidebar");
				$sidebar.addClass("sidebar-hidden");
			});
		}
	},
	renderMenu : {
		init : function(){
			var menuStr = $("#main-menu-data").text();
			if(menuStr != ""){
				Main.Config.menuJson = JSON.parse(menuStr);
			}
			var html = template('atp-main-menu-item', Main.Config.menuJson);
			$("#menu-list-box").html(html);
			
			var menuBoxH = $("#menu-list-box").height();
			
			$("#tabs_menu").css("padding-bottom",menuBoxH);
			
			this.bindEven();
			
			$("#menu-list-box").find(".menu-item a:eq(0)").trigger("click");
		},
		bindEven : function(){
			$("#menu-list-box").find(".menu-item a").on("click",function(){
				var $this = $(this);
				var title = $this.attr("title");
				var id = $this.data("id");
				var type = $this.data("type");
				var num = $this.data("num");
				var appMenuJson;
				
				$this.parent().siblings().removeClass("active");
				$this.parent().addClass("active");
				
				if(type == "other"){
					appMenuJson = Main.Config.menuJson.menuList[num];
					appMenuJson.contextPath = Main.Config.contextPath;
					Main.renderMenu.renderMenuList(appMenuJson);
				}else{
					$.ajax({
						url: "./data.menu.jsp?application=" + id,
						type : "POST",
						success: function(text){
							text = $.trim(text);
							if(text){
								appMenuJson = JSON.parse(text);
								Main.renderMenu.renderMenuList(appMenuJson);
							}
						},
						error: function(text){
						}
					});
				}
			});
		},
		renderMenuList : function(json){
			var menuHtml = template('atp-main-menu-list', json);
			var menuSmallHtml = template('atp-main-menu-small-list', json);
			
			
			$("#tabs_menu").html(menuHtml);
			$(".sidebar-small .tabs_menu_other").html(menuSmallHtml);
			$("#flowMeun").collapse('hide');
		},
		// 刷新相应的菜单统计
		refreshTotalRow : function(resourceid) {
			$.ajax({
				url: contextPath + "/portal/resource/getTotalRowByResourceid.action",
				type : "POST",
				data : { "_viewid" : resourceid },
				success: function(text){
					text = $.trim(text);
					if(text){
						var result = JSON.parse(text);
						var arr = $(".menu").find("ul#tabs_menu").find("li[tabid='" + resourceid + "']").find(".main-menu_count");
						arr.each(function(i) {
							jQuery(this).html("(" + result.datas + ")");
						});
					}
				},
				error: function(text){
				}
			});
		}
	}
}

