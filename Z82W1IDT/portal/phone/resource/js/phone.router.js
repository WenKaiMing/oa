ajaxPage.Router = {
	init : function (){
		Route.init({
			//首页
	        'homePage': function(){
	        	ajaxPage.hideCurPage();
	        	loadContent("homePage");
	        	ajaxPage.showCurPage("homePage");
	        	ajaxPage.closeOrHidePage("homePage");
	        	ajaxPage.setNavPanel("homePage");
	        },
	        //流程
	        'flowCenter': function(){
	        	ajaxPage.hideCurPage();
	        	loadContent("flowCenter");
	        	ajaxPage.showCurPage("flowCenter");
	        	ajaxPage.closeOrHidePage("flowCenter");
	        	ajaxPage.setNavPanel("flowCenter");
	        },
	        //菜单
	        'menu': function(){
	        	ajaxPage.hideCurPage();
	        	loadContent("menu");
	        	ajaxPage.showCurPage("menu");
	        	ajaxPage.closeOrHidePage("menu");
	        	ajaxPage.setNavPanel("menu");
	        },
	        //首页widget更多
	        'iconMore': function(){
	        	ajaxPage.hideCurPage();
	        	ajaxPage.showCurPage("iconMore");
	        	ajaxPage.closeOrHidePage("iconMore");
	        	ajaxPage.setNavPanel("iconMore");
	        },
	        //进表单
	        'form_view/*path': function(path){
	        	if(ajaxPage.refresh){	//为true时，加载页面
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/document/view.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("form_view",urlParams);	//关闭后打开的页面，打开当前页面，返回false
		        	if(closeOrHidePage){	//当浏览器刷新当前页面的时候，需重加载页面内容
		        		ajaxPage.routerLoadPage(url,params);
		        	}
		        	ajaxPage.hidePopUpLayer();	//隐藏当前页面的弹出层
		        	ajaxPage.setNavPanel("view");
		        }else{	//为false时，已存在
		        	ajaxPage.refresh = true;
	        	}
	        },
	        //从菜单进表单
	        'form_newWithPermission/*path': function(path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/document/newWithPermission.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("form_newWithPermission",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params);
		        	}
		        	ajaxPage.hidePopUpLayer();	//隐藏当前页面的弹出层
		        	ajaxPage.setNavPanel("form_newWithPermission");
	        	}else{
	        		ajaxPage.refresh = true;
	        	}
	        },
	        
	        //进视图(主)
	        'view_displayViewWithPermission/*path': function(path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/view/displayViewWithPermission.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("view_displayViewWithPermission",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params);
		        	}else{
		        		ajaxPage.refreshView();
		        	}
		        	ajaxPage.setNavPanel("view_displayViewWithPermission");
	        	}else{
	        		ajaxPage.refresh = true;
	        	}
	        },
	        //进视图，配置按钮跳转到视图(可能跳主视图，可以能跳子视图)
	        'view_displayView/*path': function(path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/view/displayView.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("view_displayView",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params);
		        	}else{
		        		ajaxPage.refreshView();
		        	}
		        	ajaxPage.setNavPanel("view_displayView");
	        	}else{
	        		ajaxPage.refresh = true;
	        	}
	        },
	        //进子视图（子表）
	        'subView_displayView/:id/*path': function(id,path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var _action = "../dynaform/view/displayView.action?"+params;
		        	var url = contextPath+"/portal/dynaform/view/displayView.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("subView_displayView",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params,function(){
							var $tabParameter = ajaxPage.getCurPage().find(".tab_parameter_Display");
							var viewid = id + "_params";
							var $viewDiv = $("<div></div>").attr("id",id+"_params").attr("_action",_action).css("display","none");
							//表单元素转成span标签存入dom中
							$.each($tabParameter.find("input[type!=button],select,textarea").serializeArray(),function(){
								$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
							});
						
							//去掉表单元素
							$tabParameter.find("input[type!=button],select,textarea").each(function(){
								if(!$(this).attr("moduleType")) $(this).remove();
							});
	
							ajaxPage.getCurPage().find("title").attr("id",id);
							ajaxPage.getCurPage().append($viewDiv);
						});
		        	}else{
		        		ajaxPage.refreshView();
		        	}
	        	
		        }else{
		        	ajaxPage.refresh = true;
	        	}
	        },
	        //子视图进表单
	        'subView_view/*path': function(path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/document/view.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("subView_view",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params);
		        	}
		        	ajaxPage.hidePopUpLayer();	//隐藏当前页面的弹出层
		        	ajaxPage.setNavPanel("subView_view");
		        }else{
		        	ajaxPage.refresh = true;
	        	}
	        },
	        //新建
	        'activity_create/*path': function(path){
	        	if(ajaxPage.refresh){
		        	var params = ajaxPage.Router.resolveHash(path);
		        	var url = contextPath+"/portal/dynaform/activity/process.action";
		        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
		        	var closeOrHidePage = ajaxPage.closeOrHidePage("form_newWithPermission",urlParams);
		        	if(closeOrHidePage){
		        		ajaxPage.routerLoadPage(url,params);
		        	}
		        	ajaxPage.hidePopUpLayer();	//隐藏当前页面的弹出层
		        	ajaxPage.setNavPanel("activity_create");
		        }else{
		        	ajaxPage.refresh = true;
	        	}
	        },
	        'report_oReport/*path': function(path){
	        	var params = ajaxPage.Router.resolveHash(path);
	        	var url = contextPath+"/portal/phone/dynaform/report/oReport.jsp";
	        	var urlParams = url+"?"+params;		//用于比较带参数的url是否已存在
	        	ajaxPage.routerLoadPage(url,params,function(){	
	        		//回调函数
        			var $curPage = ajaxPage.getCurPage();
        			showReport();	//渲染报表图表
        			$curPage.find(".refreshMenuReport").bind("click",function(){	//渲染刷新按钮
        		  		showReport();
        		  	})
        		});
	        	ajaxPage.setNavPanel("report_oReport");
	        }
	        
	    });
	},
	//解析hash，/改拼成&形式传参,并且去掉popUpLayer,flowPro,_searchForm参数
	resolveHash : function(path){
		var arr = path.split("/");
		var params = "";
		$.each(arr, function(){
			if(this != "popUpLayer" && this != "flowPro" && this != "_searchForm"){
				params += this;
				params += "&"
			}
		});
		if(params.length>0){
			params = params.substring(0,params.length-1);
		}
		return params;
	}
}