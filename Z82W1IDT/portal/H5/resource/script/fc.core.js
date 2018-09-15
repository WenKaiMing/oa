/**
 * FC 核心类
 * 封装KM界面渲染与交互行为
 */
;
var FC = FC || {};

FC.Config = {
	actionType : "Pending",
    params : {
    	isAll : true,		//经办不显示已完结
    	isMyWorkFlow : false,	//经办不显示我发起
    	title : "",
    	initiatorId : "",
    	flowId : "",
    	applicationId : "",
    	domainId : ""
    },
    Pending : {
    	url : {
    		allFlowList : "/portal/flowcenter/getAllPendingFlowList.action",	//--获取所有软件以及其流程分组列表
    		list : "/portal/flowcenter/getPendingList.action"	//--获取指定代办流程下数据
    	}
    },
    Processed : {
    	url : {
    		allFlowList : "/portal/flowcenter/getAllProcessedFlowList.action",	//--获取所有软件以及其流程分组列表
    		list : "/portal/flowcenter/getProcessedList.action"	//--获取指定经办流程下数据
    	}
    }
};
FC.Core = {
		handle : {	//handle包括代办（待处理）和经办（已处理）
			init : function() {
				FC.Util.dy_lock();
				this.bindEvent();
				this.setConfig();
				this.renderAllPendingFlowList();	
			},
			setConfig : function(){		//设置配置信息
				FC.Config.actionType = $("#appList").attr("_actionType");	//判断是“代办Pending”“经办Processed”
			},
			setParams : function(name,value){		//设置参数信息
				FC.Config.params[name] = value;
			},
			//
			bindEvent : function() {
				var $container = $("#flowCenter-box");
				$container.on('click','.flow-collapse li', function(){	//点击分组
					FC.Util.dy_lock();
					$(this).addClass("active").siblings().removeClass("active");
					$(this).parents(".panel").find(".soft-heading").removeClass("active");
					$("#flowtitle").val(""); 
					$("#clearUser").trigger("click");
					$('.showEndInput').prop("checked",false);	//经办的“显示已完结”重置
					$('#myStartBtn').find("input").prop("checked",false);	//经办的“我发起的”重置
					var flowId = $(this).attr("flowId");
					FC.Core.handle.setParams("isAll",true);
					FC.Core.handle.setParams("isMyWorkFlow",false);
					FC.Core.handle.setParams("applicationId",$(this).attr("appId"));
					FC.Core.handle.setParams("flowId",flowId);
					FC.Core.handle.setParams("title",$("#flowtitle").text());
					FC.Core.handle.renderHandleList(FC.Config.params);
				});
				$container.on('click','.showEndInput', function(event){		//经办“显示已完结的”				
					event.stopPropagation();
					FC.Core.handle.searchFlowCenter();
				});
				$container.on('click','#myStartBtn', function(){	//经办“我发起的”文字
					var $input = $(this).find("input");
					if($input.prop("checked")){
						$input.prop("checked",false);
					}else{
						$input.prop("checked",true);
					}
					FC.Core.handle.searchFlowCenter();
					return false;
				});
				$container.on('click','#myStartBtn input', function(event){		//经办“我发起的”input
					event.stopPropagation();
					FC.Core.handle.searchFlowCenter();
				});
				$container.on('click','.flowCenterSearch .btn-search', function(){	//搜索
					FC.Core.handle.searchFlowCenter();
				});
				$container.on('keydown', '.flowCenterSearch #flowtitle', function (e) {		//回车搜索
					if (e.keyCode == 13) {
						FC.Core.handle.searchFlowCenter();
						return false;
					}
				});
				$container.on('click','#selectUser', function(){	//选人
					var _appId = $("#flowAccordion").find(".active").attr("appid")
					var settings = {
							textField:'initiator_text',
							valueField:'initiator',
							limitSum:'10',
							selectMode:'selectOne',
							readonly:false,
							callback:''
					}
					FC.Util.showUserSelectNoFlow('actionName', settings, '',_appId);
				});
				$container.on('click','#clearUser', function(){		//清空发起人
					$('#initiator_text').val('');
					$('#initiator_text').attr('title','');
					$('#initiator').attr('value','');
				});
				$container.on('click','.flowCenter-table .tbody_tr', function(){	//点击列表进入表单
					var $this = $(this);
					$this.find("span.noread").removeClass("noread").addClass("isread");		//仅待办
					var id = $this.attr("id");
					var title = $(this).find(".title").text();
					if(!title){
						title = $(this).find('.dept_name').text();
					}
					var url = $this.attr("_url");
					if(typeof(top.addTab) == "function"){
						top.addTab(id,title,url);
					}else{
						window.open(url);
					}
				});
				
				$container.on('click','#flowAccordion .soft-heading', function(){	//软件切换
					FC.Util.dy_lock();
					$(this).addClass("active");
					$(this).parents(".panel").find(".flow-collapse").collapse("show");
					$(this).parents(".panel").addClass("selected");		//类“selected”，三角符号向下
					$(this).parents(".panel").siblings().removeClass("selected").find(".flow-collapse").collapse("hide");
					$(this).parents(".panel").siblings().find(".soft-heading").removeClass("active");
					//取消该软件下的流程分组的选中状态
					$(this).next().find("li").removeClass("active");
					$("#flowtitle").val(""); 	//重置“主题”
					$("#clearUser").trigger("click"); 	//重置“申请人”
					$('.showEndInput').prop("checked",false);	//经办的“显示已完结”重置
					$('#myStartBtn').find("input").prop("checked",false);	//经办的“我发起的”重置
					FC.Core.handle.setParams("applicationId",$(this).attr("appId"));
					FC.Core.handle.setParams("flowId","");
					FC.Core.handle.setParams("title",$("#flowtitle").text());
					FC.Core.handle.renderHandleList(FC.Config.params);
				});
			},
			//点击回车搜索
			searchFlowCenter : function(){
				FC.Util.dy_lock();
				var _title = $("#flowtitle").val();
				var _initiatorId = $("#initiator").val();
				var $flowAccordion = $("#flowAccordion").find(".active");
				var _appId = $flowAccordion.attr("appid")
				var _flowId = $flowAccordion.attr("flowid");
				var $input = $("#myStartBtn").find("input");
				var _isMyWorkFlow;
				var _isAll;
				if($input.prop("checked")){
					_isMyWorkFlow = true;
					FC.Core.handle.setParams("isMyWorkFlow",true);
				}else{
					_isMyWorkFlow = false;
					FC.Core.handle.setParams("isMyWorkFlow",false);
				}
				if( $(".showEndInput").prop("checked")){
					_isAll = false;
					FC.Core.handle.setParams("isAll",false);
				}else{
					_isAll = true;
					FC.Core.handle.setParams("isAll",true);
				}
				FC.Core.handle.setParams("title",_title);
				FC.Core.handle.setParams("initiatorId",_initiatorId);
				FC.Core.handle.renderHandleList(FC.Config.params);
			},
			//经办和代码的所有软件以及其流程分组的data数据处理
			getAllPendingFlowListData: function(result){
				$.each(result,function(i){
					var num = 0;
					var sup;
					if(FC.Config.actionType == "Processed"){
						var flowListName = "processedFlowList";
					}else{
						var flowListName = "pendingFlowList";
					}
					$.each(this[flowListName],function(i,obj){
						var eachNum = obj.num;
						if(eachNum > 9999){
							eachNum = "9999+";
						}
						obj.num = eachNum
						if(obj.id ==""){
							sup = i;
							num = eachNum;
						}
					});
					this[flowListName].splice(sup,1);
					this.num = num;
				});
				return result;
			},
			//流程分组渲染后的回选方法
			choiceFlowList : function(){
				if(FC.Config.params.applicationId != ""){	//刷新时
					var appIdSelected = FC.Config.params.applicationId;
					var flowIdSelected = FC.Config.params.flowId;

					$(".soft-heading[appid="+appIdSelected+"]").next().collapse("show");
					var selectEle = $("#flowAccordion li[flowid='"+flowIdSelected+"']");
					if(flowIdSelected !=""){
						if(selectEle.size()>0){
							selectEle.addClass("active");
						}else{
							$(".soft-heading[appid="+appIdSelected+"]").addClass("active");
							flowIdSelected = "";
						}
					}else{
						$(".soft-heading[appid="+appIdSelected+"]").addClass("active");
					}
					$("#flowgroup li").removeClass("active");
					if($("#flowgroup li[flowid='"+flowIdSelected+"']").size()>0){
						$("#flowgroup li[flowid='"+flowIdSelected+"']").addClass("active");
					}
					
					var params = FC.Config.params;
					if(FC.Config.params.isAll){
						$('.showEndInput').prop("checked",false);	//经办的“显示已完结”
					}else{
						$('.showEndInput').prop("checked",true);	//经办的“显示已完结”重置
					}
					if(FC.Config.params.isMyWorkFlow){
						$('#myStartBtn').find("input").prop("checked",true);	//经办的“我发起的”
					}else{
						$('#myStartBtn').find("input").prop("checked",false);	//经办的“我发起的”重置
					}
					params.flowId = flowIdSelected;
					params.applicationId = appIdSelected;
					FC.Core.handle.renderHandleList(params);
				}else{			//初始化时
					$(".panel").eq(0).find(".soft-heading").trigger("click");
				}
			},
			//经办和代码的所有软件以及其流程分组
			renderAllPendingFlowList: function(){
				FC.Service.getAllPendingFlowList({
					success : function(result){
						data = result;
						if(data.length != 0){
							data = FC.Core.handle.getAllPendingFlowListData(data);
							
							var end = false;
							data.map(function(item,index){
								var listParams = {
							    	isAll : false,
							    	isMyWorkFlow : FC.Config.params.isMyWorkFlow,	
							    	title : FC.Config.params.title,
							    	initiatorId : FC.Config.params.initiatorId,
							    	flowId : FC.Config.params.flowId,
							    	applicationId : item.id,
							    	domainId : FC.Config.params.domainId
							    }
								FC.Service.handle.getHandleList(listParams,function(result){
									item.endnum = item.num - result.rowCount
									if(index == data.length - 1){
										end = true
									}
								});
							})

							var readyState = setInterval(function(){
								if(end){
									var obj = {};
									obj.app = [];
									obj.app = data;

									var html = template('tempFlowAccordion', obj);
									$("#flowCenter-box").find("#flowAccordion").html(html);
									//回选方法：选中flowId,渲染流程列表
									FC.Core.handle.choiceFlowList();
									
									/*//找到流程总数不为0的软件展开
									var hasAppFlowShow = true;
									$(".panel").each(function(){
										var total = parseInt($(this).find(".soft-heading").find(".sum").text());
										if(hasAppFlowShow){
											if(total>0){
												hasAppFlowShow = false;
												$(this).find(".soft-heading").trigger("click");
											}
										}
										if(hasAppFlowShow){
											$(".panel").eq(0).find(".soft-heading").trigger("click");
										}
									});*/
									clearInterval(readyState);
								}
							},100);
							FC.Util.dy_unlock();
						}else{
							$("#flowAccordion").html("<span class='noAppFlowList'>没有流程数据!</span>")
							FC.Core.handle.isShowNullPage(data);
							FC.Util.dy_unlock();
						}
					},
					error : function(){
						var data = [];
						FC.Core.handle.isShowNullPage(data);
						FC.Util.dy_unlock();
	            	}
				});
			},
			//获取指定分组代办流程下数据
			renderHandleList : function(params) {
				FC.Service.handle.getHandleList(params,function(result){
					var data = result.datas;
					var listParams = {
							isAll : params.isAll,
							isMyWorkFlow : params.isMyWorkFlow,
							title : params.title,
					    	initiatorId : params.initiatorId,
					    	flowId : params.flowId,
					    	applicationId : params.applicationId,
					    	domainId : params.domainId,
					    	_rowcount : result.rowCount,
					    	linesPerPage : result.linesPerPage,
					    	pageNo : result.pageNo
					};
					FC.Core.handle.isShowNullPage(data);
					$.each(data,function(i){
						var _url = contextPath+"/portal/dynaform/document/view.action?"+
							"_formid="+data[i].formId+
							"&_docid="+data[i].docId+
							"&application="+data[i].applicationId+
							"&_backURL="+contextPath+"/portal/H5/closeTab.jsp?refreshId="+data[i].applicationId;
						var _initiatorID = data[i].initiatorId;
						var _time = data[i].lastProcessTime.replace('T', ' ');;
						var _initiator = data[i].initiator;
						var _timeAgo,_avatar,_flowOperation;
						var avatar = Common.Util.getAvatar(_initiatorID);	//获取微信头像
						var isImg = false;
						if(avatar!="" && avatar!=undefined){
							isImg = true;
							_avatar = "<img src ="+avatar+">";
						}else{
							_avatar = "<div class='noAvatar'>" + _initiator.substr(_initiator.length-2, 2) + "</div>";
						}
						_timeAgo = Common.Util.calculateTime(_time);
						data[i].avatar = _avatar;
						data[i].timeAgo = _timeAgo;
						data[i]._url = _url;
						
						switch (data[i].lastFlowOperation){
							case "81":
								_flowOperation = "回退"
								break;
							case "85":
								_flowOperation = "回撤"
								break;
							case "88":
								_flowOperation = "挂起"
								break;
							case "89":
								_flowOperation = "恢复"
								break;
							default:
								_flowOperation = "流转"
								break;
						}
						data[i]._flowOperation = _flowOperation;
						//在代办下,判断是否是代办
						data[i].isAgent = false;
						if(data[i].auditorList.indexOf(USER.id) == -1){
							data[i].isAgent = true;
						}
						
					});
					var obj = {}; 
					obj.list = data;
					var html = template('tempTbody_tr', obj);
					$("#flowCenter-tbody").html("").append(html);
					FC.Core.handle.setPage(listParams);
					FC.Util.dy_unlock();
				});
			},
			setPage : function(listParams){
				//获取各软件参数
				var $paginationPanel = $("#flowCenter-box").find("#pagination-panel");
				$paginationPanel.html("").append("<div class='pagination-body'></div><div class='pagination-other'></div>")
				
				$paginationPanel.find(".pagination-body").pagination(listParams._rowcount, {
					current_page: (listParams.pageNo - 1),
					items_per_page: listParams.linesPerPage,
					prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
					next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
				    num_edge_entries: 1,
				    num_display_entries: 5
				});
				$paginationPanel.find(".pagination-other").append("<div class='totalRowPanel'>" 
						+ flowCenter.multilingual["total"] + ": "+ listParams._rowcount +"</div>");
				
				//监听事件
				$paginationPanel.find("a").on("click",function(){
					FC.Util.dy_lock();
					var $this = $(this);
					
					var _pageCount = Math.ceil(listParams._rowcount/listParams.linesPerPage);
					var _pageNum;
					if (isNaN(listParams.pageNo)||isNaN(listParams._rowcount)|| isNaN(listParams.linesPerPage)) {
						return;
					}		    		
					if($this.hasClass("prev")){
						if (listParams.pageNo > 1) {
							_pageNum = listParams.pageNo - 1;
			    		}else{
			    			return;
			    		}
					}else if($this.hasClass("next")){
						if (_pageCount > 1 && _pageCount > listParams.pageNo) {
							_pageNum = parseInt(listParams.pageNo) + 1;
						}else{
			    			return;
			    		}
					}else{
						_pageNum = parseInt($(this).text());
					}
					var $input = $("#myStartBtn").find("input");
					var _isMyWorkFlow;
					var _isAll;
					if($input.prop("checked")){
						_isMyWorkFlow = true;
					}else{
						_isMyWorkFlow = false;
					}
					if($(".showEndInput").prop("checked")){
						_isAll = false;
					}else{
						_isAll = true;
					}
					listParams.isAll = _isAll;
					listParams.isMyWorkFlow = _isMyWorkFlow;
					listParams.pageNo = _pageNum;	//设置软件当前页
					listParams.title = $("#flowtitle").val(); 
					listParams.initiatorId = $("#initiator").val();
					FC.Core.handle.renderHandleList(listParams);
				});
			},
			isShowNullPage : function(data){
				if(data && data.length<=0){	//无数据时显示点位符
					$("#content-space").show();
					$("#pagination-panel").hide();
				}else{	
					$("#pagination-panel").show();
					$("#content-space").hide();
				}
			},
			refresh : function(){
				FC.Core.handle.renderAllPendingFlowList();		//刷新遍历软件以及其下的流程分组列表
			}
		}
}