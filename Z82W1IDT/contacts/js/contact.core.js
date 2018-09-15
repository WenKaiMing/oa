/**
 * Contacts 核心类
 * 封装Contacts界面渲染与交互行为
 */
;
var Contacts = Contacts || {
	
	config : {
		//判断是否启用用户选择模式
		select : false,
		//判断是否多选模式
		multiple : true,
		//用户在通讯录已选择的用户
		selecteds : {},
		toChooseUsers : [],	//可选的静态用户数据
		//historyLength
		historyLength : history.length,		
		//tab显示配置
		showTab : {
			all : true,
			dept : true, 
			role : true, 
			favorite : true
		},
		tabs : {
			// [] 配置显示的tab，全部、部门、职务、常用
			all : {name:'全部',url: 'contacts/getAllUser.action'},
			dept : {name:'部门',url: 'contacts/getContactsTree.action'},
		    role : {name:'角色',url: 'contacts/getApplicationAndRoleContactsTree.action'},
		    favorite : {name:'常用',url: 'contacts/getFavoriteContacts.action'}
		}
	},
	
	/**
	 * 首页
	 */
	main : {
		init : function(showtype) {
			Contacts.Util.controlLoading("show");
			template.config("cache",false);
			document.title='通讯录';
			Contacts.main.renderMain(showtype);
			Contacts.Util.controlLoading("hide");
		},
		/**
		 * 渲染静态用户数据
		 */
		renderStaticData : function(showtype,searchShowPanel){
			var toChooseUsers = {
				datas : Contacts.config.toChooseUsers
			}

			Contacts.config.showSearchbar = false;
			
			Contacts.main.renderListItem(showtype, searchShowPanel, toChooseUsers);
		},
		
		//根据屏幕调整界面样式
		renderMain : function(showtype){
			var data = Contacts.config.showTab;
			
			var $mainPanel = $('#tpl_contacts_main');
        	var $mainHtml = $(template('tpl_contacts_main', data));
        	var $mainSearchShow = $mainHtml.find(".contacts-search-show");
        	if($mainHtml.find(".weui_bar_item_on").size()<=0){
        		if(showtype == "favorite"){
            		$mainHtml.find(".weui_navbar_item").removeClass("weui_bar_item_on");
            		$mainHtml.find(".weui_navbar_item[data-showtype='favorite']").addClass("weui_bar_item_on");
            	}else{
            		$mainHtml.find(".weui_navbar_item[data-showtype='all']").addClass("weui_bar_item_on");
            		showtype = "all";
            	}
        	}else{
        		showtype = $mainHtml.find(".weui_bar_item_on").data("showtype");
        	}
        	
        	var breadcrumb = {
					"name": "返回" + $mainHtml.find(".weui_bar_item_on").find("div").text(),
					"type": $mainHtml.find(".weui_bar_item_on").data("showtype")
				}
        	Contacts.Util.cache.currentId = "";//首页时清空缓存id
        	Contacts.Util.cache.breadcrumbItem = [];
        	Contacts.Util.cache.breadcrumbMain = [];
			Contacts.Util.cache.breadcrumbMain.push(breadcrumb);
			
			Contacts.main.renderList(showtype, $mainSearchShow.find(".weui_cells"), {});
			
			//隐藏搜索栏
        	if(Contacts.config.showSearchbar == false){
        		$mainHtml.find("#search_bar").hide();
        	}
        	
        	//隐藏tab栏
        	Contacts.config.showNavbar = false;
        	$.each(data,function(key,value){
        		if(value == true){
        			Contacts.config.showNavbar = true;
        		}
        	})
        	if(Contacts.config.showNavbar == false){
        		$mainHtml.find(".weui_navbar").hide();
        		$mainHtml.find(".weui_tab_bd").css("padding-top","0px");
        	}
        	

        	var winHeight = $(window).height();
        	var searchHeight = Contacts.config.showSearchbar == false ? 0 : 44;
        	var navBarHeight = $mainHtml.find(".weui_navbar").css("display") == "none" ? 0 : 70;
        	
        	//调整列表面板高度
        	$("#contacts").height("auto"); 
        	if($("#contacts-select-panel").is(":visible")){
        		var selectHeight = $("#contacts-select-panel").outerHeight();
        		$mainSearchShow.height(winHeight-searchHeight-navBarHeight-selectHeight); 
        	}else{
        		$mainSearchShow.height(winHeight-searchHeight-navBarHeight);
        	}
        	

        	$mainPanel.html($mainHtml);
		},
		
		//渲染首页列表
		renderList : function(showtype,searchShowPanel,params){
			switch (showtype){
				//全部
				case "all" :
					if(Contacts.config.toChooseUsers && Contacts.config.toChooseUsers.length > 0){
						Contacts.main.renderStaticData(showtype,searchShowPanel);
					}else{
						
						if(!params.pageNo){
							params.pageNo = 1;
						}
						Contacts.Service.getAllUser(params,function(result){
							Contacts.main.renderListItem(showtype,searchShowPanel,result);
							if(result == ""){
								Contacts.Util.controlPlaceholder("show");
							}else{
								Contacts.Util.controlPlaceholder("hide");
							}
						});
					}
					break;
				//部门
				case "dept" :
					Contacts.Service.getContactsTree(params,function(result){
						Contacts.main.renderListItem(showtype,searchShowPanel,result);
						if(result == ""){
							Contacts.Util.controlPlaceholder("show");
						}else{
							Contacts.Util.controlPlaceholder("hide");
						}
					});
					break;
				//角色
				case "role" :
					Contacts.Service.getRoleTree(params,function(result){
						Contacts.main.renderListItem(showtype,searchShowPanel,result);
						if(result == ""){
							Contacts.Util.controlPlaceholder("show");
						}else{
							Contacts.Util.controlPlaceholder("hide");
						}
					});
					break;
				//常用
				case "favorite" :
					Contacts.Service.getFavorite(params,function(result){
						Contacts.main.renderListItem(showtype,searchShowPanel,result);
						if(result == ""){
							Contacts.Util.controlPlaceholder("show");
						}else{
							Contacts.Util.controlPlaceholder("hide");
						}
					});
					break;
				//搜索
				case "search" :
					if(Contacts.config.toChooseUsers && Contacts.config.toChooseUsers.length > 0){
						var result = [];
						var keyWord = params.keyWord;
						if(keyWord != ""){
							$.each(Contacts.config.toChooseUsers,function(){
								var currName = $(this)[0].name;
								var mobile = $(this)[0].mobile;
								var mobile2 = $(this)[0].mobile2;
								if(currName.indexOf(keyWord) >= 0 || mobile.indexOf(keyWord) >= 0 || mobile2.indexOf(keyWord) >= 0){
									result.push($(this)[0]);
								}
							});
						}else{
							result = Contacts.config.toChooseUsers;
						}
						Contacts.main.renderListItem(showtype,searchShowPanel,result);
						if(result.length > 0){
							Contacts.Util.controlPlaceholder("hide");
						}else{
							Contacts.Util.controlPlaceholder("show");
						}
					}else{
						Contacts.Service.searchContacts(params,function(result){
							Contacts.main.renderListItem(showtype,searchShowPanel,result);
							if(result == ""){
								Contacts.Util.controlPlaceholder("show");
							}else{
								Contacts.Util.controlPlaceholder("hide");
							}
	    				});	
					}
					break;
			}
//			Contacts.selectList.init();
		},
		renderListItem : function(showtype,searchShowPanel,result){
			var userCounts = [];
			if(showtype == "dept"){
				for(var i = 0;i < result.length;i++){
					var params = {"id":result[i].id,"type":showtype == "dept" ? "2" : "3" };
					Contacts.Service.getRoleOrDeptUserCounts(params,function(userCount){
						userCounts.push(userCount);
					});	
				}
			}

			var $showPanel = $("#contacts .contacts-search-show .weui_cells");
			
			//"全部"数据结构与其他不同
			if(showtype === "all"){
				var html = template('atp-contacts-list-item', {
					inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
					select:Contacts.config.select,
					showtype:showtype,
					list:result.datas,
					pageCount:result.pageCount,
					pageNo:result.pageNo,
					userCounts:userCounts
				});
			} else if (showtype === "dept") {
				var html = template('atp-contacts-list-item', {
					inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
					select:Contacts.config.select,
					showtype:showtype,
					list:result,
					userCounts:userCounts
				});
			} else if (showtype === "role" || showtype === "favorite") {
				var html = template('atp-contacts-list-item', {
					inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
					select:Contacts.config.select,
					showtype:showtype,
					list:result,
					pageCount:result.length,
					pageNo:1
				});
			} else if (showtype === "letter") {
				var html = template('atp-contacts-list-item', {
					inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
					select:Contacts.config.select,
					list:result,
					pageCount:result.length,
					pageNo:1
				});
			} else if (showtype === "search") {
				var html = template('atp-contacts-list-item', {
					inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
					select:Contacts.config.select,
					list:result,
					pageCount:result.length,
					pageNo:1
				});
			}

			if($showPanel.size() <= 0){
				searchShowPanel.html(html)
			}else{
				$showPanel.html(html)
			}

			Contacts.User.checkSelectedUsers();	//回选列表中已选数据
		},
		bindEven : function(){
			var $contacts = $("#contacts");

			//搜索
			$contacts.on('focus', '#search_input', function () {
                var $weuiSearchBar = $('#search_bar');
                $weuiSearchBar.addClass('weui_search_focusing');
                $(".contacts-search-index").hide();
                $(".contacts-search-index-panel").hide();
            }).on('blur', '#search_input', function () {
                var $weuiSearchBar = $('#search_bar');
                $weuiSearchBar.removeClass('weui_search_focusing');
                if ($(this).val()) {
                    $('#search_text').hide();
                } else {
                    $('#search_text').show();
                }
                $(".contacts-search-index").show();
            }).on('input', '#search_input', function () {
                var $searchShow = $("#search_show");
                if ($(this).val()) {
                    $searchShow.show();
                } else {
                    $searchShow.hide();
                }
            }).on('click', '#search_cancel', function () {
                $("#search_show").hide();
                $('#search_input').val('');
                $(".contacts-search-index").show();
            }).on('click', '#search_clear', function () {
                $("#search_show").hide();
                $('#search_input').val('');
            }).on('keydown','#search_input',function(event){
            	var $this = $(this);
            	var params = {"keyWord":$this.val()}
        		$('.weui_navbar_item[data-showtype="all"]').addClass('weui_bar_item_on').siblings('.weui_bar_item_on').removeClass('weui_bar_item_on');
        		Contacts.main.renderList("search", $(".contacts-main .contacts-search-show .weui_cells"),params);
        		if(event.keyCode == "13"){
            		return false
            	}
            });
			
			//显示隐藏字母顺序框
			$contacts.on('click', '.contacts-search-index', function () {
                var $searchIndex = $('.contacts-search-index-panel');
                $searchIndex.toggle();
            })
			
            //按字母顺序筛选列表
			$contacts.on('click', '.contacts-search-index-item', function () {
				$(".contacts-search-index-panel").hide();
				$('.weui_navbar_item[data-showtype="all"]').addClass('weui_bar_item_on').siblings('.weui_bar_item_on').removeClass('weui_bar_item_on');
                var $this = $(this);
                var keyWord = $this.text();
                var params = {
                	"keyWord" : keyWord
                }
                Contacts.Service.getListByLetter(params,function(result){
                	if(result.length > 0){
                		$("#contacts").removeClass("placeholder");
                	}else{
                		$("#contacts").addClass("placeholder");
                	}
                	Contacts.main.renderListItem("letter",$(".contacts-main .contacts-search-show .weui_cells"),result);
				});	
            })

			//顶部页签切换		
			$contacts.on('click', '.weui_navbar_item', function () {
				Contacts.Util.controlLoading("show");
				$(".contacts-search-index-panel").hide();
				
				Contacts.config.allPageNo = 1;
				
                $(this).addClass('weui_bar_item_on').siblings('.weui_bar_item_on').removeClass('weui_bar_item_on');
                var $mainHtml = $('.contacts-main').html();
	        	var showtype = $(this).data("showtype");
	        	
	        	var breadcrumb = {
						"name": "返回" + $(this).find("div").text(),
						"type": showtype
					}
	        	Contacts.Util.cache.breadcrumbItem = [];
	        	Contacts.Util.cache.breadcrumbMain = [];
				Contacts.Util.cache.breadcrumbMain.push(breadcrumb);
	        	
	        	$('#tpl_contacts_main').html($mainHtml);
	        	Contacts.main.renderList(showtype, $(".contacts-main .contacts-search-show .weui_cells"), {});
	        	
	        	Contacts.Util.controlLoading("hide");
            });
			
			//列表点击
			$contacts.on("click", "a.weui_cell[data-type]", function () {
				//Contacts.Util.controlLoading("show");
				$(".contacts-search-index-panel").hide();
				var $this = $(this);
				var showTypeNum = $this.data("type")
				
				if((Contacts.config.select && showTypeNum != "1") || !Contacts.config.select){
					
					var href = $this.data("href");
					var $activeNav = $("#contacts").find(".weui_navbar_item.weui_bar_item_on");
					Contacts.Util.cache.showTypeNum = showTypeNum;
	
					var scrollTop = {
							id : Contacts.Util.cache.currentId,
							top : $("#contacts").find(".contacts-search-show").scrollTop()
						}
					if(scrollTop.top == null){
						scrollTop.top = $("body").scrollTop();
					}
					Contacts.Util.cache.scrollTop.push(scrollTop);
	
					if(showTypeNum == "1"){
						Contacts.show.renderShow($this);
					}else if(showTypeNum == "2" || showTypeNum == "3" || showTypeNum == "4"){
						var breadcrumb = {
								"id": $this.data("id"),
								"name": $this.data("name")
							}
						
						Contacts.Util.cache.breadcrumbItem.push(breadcrumb);
	
					}
					Contacts.setPageLink(href);
				}
				
				//Contacts.Util.controlLoading("hide");
            });
			
			//列表点击
			$contacts.on("click", ".breadcrumb", function () {
				$(".contacts-search-index-panel").hide();
				var $a = $(this).find("a.breadcrumb-item[data-showtype]")
				var showtype = $a.data("showtype");
				Contacts.setPageLink('#/:main');
            });
			
			//翻页
			$contacts.on('click', '#pagination', function(a) {
	            var $this = $(this);
	        	var $pageBtn = $(a.target);
	        	var nodeType = $pageBtn.attr("node-type");
	        	var pageNo = parseInt($this.attr("data-page"));
	        	var showtype = $this.attr("data-type");
	        	if(!$pageBtn.hasClass("inactive")){
	        		if($pageBtn.hasClass("pre-page")){
	            		var params = {
	            			pageNo : pageNo-1
	            		}
	            	}else if($pageBtn.hasClass("next-page")){
	            		var params = {
	            			pageNo : pageNo+1
	            		}
	            	}
	        	}
	        	Contacts.main.renderList(showtype, $(".contacts-main .contacts-search-show .weui_cells"), params);
	        });
		}
	},
	/**
	 * 渲染列表页面
	 */
	list : {

		init : function(id,showtype) {
			
			Contacts.Util.controlLoading("show");
			document.title='通讯录';
			
			Contacts.Util.cache.currentId = id;//缓存当前id
			
			for(var i = 0; i < Contacts.Util.cache.breadcrumbItem.length; i++){
				if(Contacts.Util.cache.breadcrumbItem[i].id == id){
					Contacts.Util.cache.breadcrumbItem[i].current = "true";
				}else{
					Contacts.Util.cache.breadcrumbItem[i].current = "false";
				}
			}

			if(showtype == "role-3"){
				var params = {"applictaionId":id};
				Contacts.Service.getRoleTree(params,function(result){
					Contacts.list.renderList(result,showtype);
				});	
			}else if(showtype == "role-3-4"){
				var params = {"roleId":id};
				Contacts.Service.getRoleTree(params,function(result){
					Contacts.list.renderList(result,showtype);
				});	
			}else{
				var params = {"parentId":id};
				Contacts.Service.getContactsTree(params,function(result){
					Contacts.list.renderList(result,showtype);
				});	
			}
			
		},
		renderList : function(result,showtype){
			var $mainPanel = $('#tpl_contacts_list');
        	var $mainHtml = $($('#tpl_contacts_list').html());
        	var currentBreadcrumbItem = [];
        	for(var i = 0; i < Contacts.Util.cache.breadcrumbItem.length; i++){
				if(Contacts.Util.cache.breadcrumbItem[i].current == "true"){
					currentBreadcrumbItem.push(Contacts.Util.cache.breadcrumbItem[i]);
				}
			}
        	var selectAllHtml = template('atp-contacts-list-item-all', {
        			inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
        			multiple : Contacts.config.multiple,
	    			select: Contacts.config.select,
	        		list: Contacts.Util.cache.breadcrumbMain,
	        		current: currentBreadcrumbItem
    			});

        	var userCounts = [];
			for(var i = 0;i < result.length;i++){
				if(result[i].type == "2" || result[i].type == "4"){
					var params = {"id":result[i].id,"type":result[i].type};
					Contacts.Service.getRoleOrDeptUserCounts(params,function(userCount){
						userCounts.push(userCount);
					});	
				}else{
					userCounts.push("0");
				}
			}
        	var html = template('atp-contacts-list-item', {
        			inputType: (Contacts.config.multiple ? "checkbox" : "radio"),
        			select:Contacts.config.select,
        			showtype:showtype,
	        		list:result,
	        		userCounts:userCounts
	    		});

        	if($("#contacts-select-panel").is(":visible")){
        		$("#contacts").height($(window).height()-127); 
        	}

        	if(result == ""){
				Contacts.Util.controlPlaceholder("show");
				$("#contacts").height($(window).height()); 
			}else{
				Contacts.Util.controlPlaceholder("hide");
			}
        	$("#contacts>.contacts-list>.weui_cells_access").html(selectAllHtml + html);

			Contacts.User.checkSelectedUsers();	//回选列表中已选数据
        	Contacts.Util.controlLoading("hide");
        	
        	//$mainHtml.html(selectAllHtml + html);
        	//$mainPanel.html($mainHtml);
		}
	},
	/**
	 * 详细页面
	 */
	show : {
		/**
		 * 渲染详细页面
		 */
		renderShow: function(obj){
			Contacts.Util.controlLoading("show");
			
			document.title='个人信息';
			
			var $mainPanel = $('#tpl_contacts_show');
        	var $mainHtml = $($('#tpl_contacts_show').html());	
        	var isFavorite
        	Contacts.Service.isFavoriteContact({userId:obj.data("id")},function(result){
        		isFavorite = result
			});
        	var data = {
        		id : obj.data("id"),
        		avatar : obj.data("avatar"),
        		name : obj.data("name"),
        		mobile : obj.data("mobile"),
        		mobile2 : obj.data("mobile2"),
        		tel : obj.data("mobile"),
        		sms : obj.data("mobile"),
        		email : obj.data("email"),
        		mailto : obj.data("email"),
        		dept : obj.data("dept"),
        		isFavorite : isFavorite
    		};
        	var html = template('atp-contacts-show', data);
        	$mainPanel.html(html);
        	Contacts.Util.controlLoading("hide");
		},
		/**
		 * 绑定事件
		 */
		bindEven : function(){
			var $contacts = $("#contacts");
			//加入移除常用联系人
			$contacts.on('touchend', '.favorite', function (){

				Contacts.Util.controlLoading("show");
				
				var $this = $(this);
				var id = $this.parents(".weui_cells").data("userid")
				if($this.attr("data-isfavorite") == "1"){
					Contacts.Service.removeFavoriteContact({userId:id},function(result){
						$this.attr("data-isfavorite","2");;
		        		$this.html("<i class='fa fa-star-o'></i>")
		        		Contacts.Util.controlLoading("hide");
						setTimeout(function(){
							Contacts.Util.showToast("已取消常用");
				        },300)
					});
				}else{
					Contacts.Service.addFavorite({userId:id},function(result){
		        		$this.attr("data-isfavorite","1");
						$this.html("<i class='fa fa-star'></i>")
						Contacts.Util.controlLoading("hide");
						setTimeout(function(){
							Contacts.Util.showToast("已添加常用");
				        },300)
					});
				}
			}).on("click", "#all", function(){	//全选点击
				var val = $(this).prop("checked");
				$("[name=_select]").prop("checked", val);
			}).on("click", ".contacts-show-mobile .tel,.contacts-show-mobile2 .tel", function(){
				var tel = $(this).data("mobile");
				window.location.href = "tel:"+tel;
			});
			
		}
	},
	/**
	 * 渲染选中项
	 */
	selectList : {
		init : function(){
			Contacts.selectList.renderSelectList();
		},
		renderSelectList : function(){
//			var $contacts = $("#contacts");
//			var $selectPanel = $("#contacts-select-panel");
//
//			$selectPanel.find(".select-item").each(function(){
//				var id = $(this).data("id");
//				$contacts.find("input[data-id='"+id+"']").prop("checked",true);
//			})
//			
//			
			if(Contacts.config.select){
				var selects = Contacts.config.selecteds;
				for(var o in selects){
					$("#contacts").find("[name=_select][data-id='" + o + "']").prop("checked", true).trigger("change");
				}
			}
		}
	},
	/**
	 * 设置页面滚动条位置
	 */
	setScrollTop : function(id,position){
		var _scrollTop = Contacts.Util.cache.scrollTop;
		if(position == "main"){
			if(_scrollTop[0] && _scrollTop[0] != undefined){
				$("#contacts").find(".contacts-search-show").scrollTop(_scrollTop[0].top);
				Contacts.Util.cache.scrollTop = [];
			}
		}else if(position == "list"){
			var top = 0;
			for(var i = 0; i < _scrollTop.length; i++){
				if(_scrollTop[i].id == id){
					top = _scrollTop[i].top;
					_scrollTop.length = i;
				}
			}
			$("body").scrollTop(top);
		}
	},
	
	setPageLink : function(href){
		if(Contacts.config.select){
			var paramsArr = href.split("/");
			if(paramsArr[1] == "list"){
				var id = paramsArr[2].substring(1);
	        	var type = paramsArr[3].substring(1);
		    	Contacts.list.init(id,type);
		    	$("#contacts").html("<div class='contacts-list'></div>");
		    	$("#contacts").find(".contacts-list").html($('#tpl_contacts_list').html())
		    	Contacts.selectList.init();
		    	Contacts.setScrollTop(id,"list");
			}else if(paramsArr[1] == "show"){
				$("#contacts").html("<div class='contacts-show'></div>");
		    	$("#contacts").find(".contacts-show").html($('#tpl_contacts_show').html())
				Contacts.show.bindEven();
			}else{
				var showtype = paramsArr[1].substring(1);
		    	Contacts.main.init(showtype);
		    	$("#contacts").html("<div class='contacts-main'></div>");
		    	$("#contacts").find(".contacts-main").html($('#tpl_contacts_main').html())
			}
		}else{
			window.location.href = href;
		}
	}
}