var subFlowApproverInfo =[];
var subFlowApproverInfoAll =[];
var $sigdiv;
var circulatorInfos =[];
var defaultSignature;

//window.onhashchange = BackAction;
/**
 * 流程初始化方法
 */
function flowInit() {

	FlowPanel.bindEvent();
	FlowProcess.bindEvent();

	var $curPage = ajaxPage.getCurPage();
	var _flowStateId = $curPage.find("input[name='content.stateid']").val();//流程实例id
	var curNodeName = $curPage.find("input[name='targetNodeRT_name']").val();//当前节点name
	var curNodeId = $curPage.find("input[name='targetNodeRT_id']").val();//当前节点id
	var _HAS_FLOW = _flowStateId && _flowStateId.length>0;//表单是否已启动流程
	
	if(!_HAS_FLOW) return;
	$.ajax({
		type:"get",
		url:contextPath+"/portal/document/flow/getHistory.action",
		data:{_flowStateId:_flowStateId,_applicationId:$("input[name='application']").val()},
		cache:false,
		dataType:"json",
		success:function(result){
			if(result.status==1){
				renderFlowHisModal(result.data);
			}
		}
		}); 
	
	
	$.getJSON(contextPath+"/portal/document/flow/getFlowInstanceJson.action",
			{_flowStateId:_flowStateId,_applicationId:$curPage.find("input[name='application']").val(),_curNodeName:curNodeName,_curNodeId:curNodeId},
			function(result){
		if(result.status==1){
			renderFlowHisPanel(result.data.historys);
		}
	});
};

/**
 * 流程相关按钮渲染
 */
function flowBtn(){

	if(ajaxPage.getCurPage().find("input[activityType='5']").size()==0) return;
	FlowPanel.refreshFlowPanel("init");
	signatureInit();	//手写签批初始化
}

/**
 * 手写签批初始化
 */
function signatureInit(){

	var $curPage = ajaxPage.getCurPage();
	var $signature = $curPage.find("#signature");
	$sigdiv = $signature.jSignature({'UndoButton':false,width:$(window).width()-26,height:$(window).height()-300,color:'#000',lineWidth:0});
	//临时保存默认值 用于提交时判断是否手写
	defaultSignature = ($sigdiv.jSignature('getData', "image"))[1];
	$signature[0].addEventListener("touchstart",function(e){
		$curPage.find("[name=_attitude]").blur();	//签批时意见框取消聚集，避免弹出键盘体验不好
		$(this).parents(".flowPro_con").find(".requiredField").blur();
		e.preventDefault();
		e.stopPropagation();
	},false);
}

/**
 * Phone皮肤 表单流程历史
 */
		
/**
**渲染表单上方流程历史面板
**/
function renderFlowHisPanel(flowHistorys){
	/*JSON格式
	 * [{"nodeType":"hisNode","nodeJson":[{"auditorId":"11e5-975b-abcfab55-8df7-f9d0d3fc48f4","auditorName":"邢儿（行政专员）","startNodeName":"起草","processtime":"2016-07-06 11:50:49.0","currentNode":"0"}]},{"nodeType":"curNode","nodeJson":[{"auditorId":"11e4-7b56-045d6210-a888-6d6b162bf5de","auditorName":"邢主管（行政主管）","startNodeName":"审核","processtime":"","currentNode":"1"},{"auditorId":"11e6-292f-c98bc185-9a78-9b801f3f5251","auditorName":"周杰伦（项目专员）","startNodeName":"审核","processtime":"","currentNode":"1"},{"auditorId":"5e120165-cb23-4131-aade-123ad00893da","auditorName":"李四","startNodeName":"审核","processtime":"","currentNode":"1"},{"auditorId":"880832b0-b0a6-47c0-9bb6-1f8c2debcad8","auditorName":"peng","startNodeName":"审核","processtime":"","currentNode":"1"},{"auditorId":"b5a8cc3d-dc1c-4c56-b27b-8704f4f1689a","auditorName":"张三","startNodeName":"审核","processtime":"","currentNode":"1"}]}]
	 * */
	var $curPage = ajaxPage.getCurPage();
	var $panel_content = $curPage.find("#flowhis_panel_content");
	$panel_content.append("<div class='flowhis_panel_hisnode'></div>");
	var $hisnode = $panel_content.find(".flowhis_panel_hisnode");
	
	$.each(flowHistorys,function(i,node){   // 渲染逻辑需要改
		if(node.nodeType == "hisNode"){
			var hisNodeLength = node.nodeJson.length;
			$.each(node.nodeJson,function(i,his){
				if(i>3){	//审批人超过4个时只获取前四个的头像
					return;
				}
				if(i == "0" || i == hisNodeLength - 1){
					var nodeItem = renderFlowHisPanelItem(i,his,node.nodeType,hisNodeLength);
					$hisnode.append(nodeItem.join(""));
				}else{
					if($panel_content.find(".point-node").size()<=0){
						var nodePoint = '<span class="point-node">'
							+'<div class="icon-box"><i class="iconfont iconfont-e615"></i><div class="icon-line icon-line-left"></div><div class="icon-line icon-line-right"></div>'
							+'</div></span>';
						$hisnode.append(nodePoint);
					}
				}
			});
		}else if(node.nodeType == "curNode"){
			var curNodeLength = node.nodeJson.length;
			var curNodeName = (node.nodeJson.length != 0) ? node.nodeJson[0].startNodeName : "";
			var curNodes = false;
			var $curNodes = "";
			$.each(node.nodeJson,function(i,his){
				if(i>3){	//审批人超过4个时只获取前四个的头像
					return;
				}
				var nodeItem = renderFlowHisPanelItem(i,his,node.nodeType,curNodeLength);
				//是否多节点
				if(his.startNodeName != curNodeName){
					curNodes = true;
				}
				//是否完结
				if(his.isComplete && his.isComplete != "true"){
					//是否多审批人
					if(curNodeLength > 1){
						if($panel_content.find(".curNodes").size()<=0){
							$hisnode.append(nodeItem.join(""));
						}
						$curNodes = $panel_content.find(".curNodes");
						//头像
						var avatar = Common.Util.getAvatar(his.auditorId);
						var avatarHtml = "";
						if(avatar!="" && avatar!=undefined){
							avatarHtml = '<img class="avatar" src="'+avatar+'" >';
						}else{
							avatarHtml = '<div class="noAvatar">'+ his.auditorName.substr(his.auditorName.length-2, 2) +'</div>';
						}
						$curNodes.append(avatarHtml);
					}else{
						$hisnode.append(nodeItem.join(""));
					}
					
				}else{
					$hisnode.append(nodeItem.join(""));
				}
			});
			//是否多节点
			if(curNodes){
				var nodesShadow = "<div class='nodesShadow2'></div><div class='nodesShadow1'></div>"
					$curNodes.parent().append(nodesShadow);
			}
			
		}
	});
	var $a = $('<span class="td more"><a data-ignore="push">更多<span class="icon icon-right"></span></a></span>').bind("click", function(){
		showViewHistory(this);
	});
	
	$panel_content.append($a);
	$curPage.find("#flowhis_panel").show();

	var fixTopHeight = $curPage.find(".fix_top_panel").outerHeight();
	$curPage.find("#form_continer").css("padding-top",fixTopHeight);
}

/**
**渲染表单上方流程历史面板中一项数据
**/
function renderFlowHisPanelItem(i,his,type,length){
	var html = [];
	//头像
	var avatar = Common.Util.getAvatar(his.auditorId);
	var avatarHtml = "";
	if(avatar!="" && avatar!=undefined){
		avatarHtml = '<img class="avatar" src="'+avatar+'" >';
	}else{
		avatarHtml = '<div class="noAvatar">'+ his.auditorName.substr(his.auditorName.length-2, 2) +'</div>';
	}
	//动作图标
	var actionIcon = "";
	switch (his.flowOperation){
		case "1":
		case "80"://"流转"
			actionIcon = "<i class='iconfont iconfont-e631 icon-09bb07'></i>"
			break;
		case "81"://"回退"
			actionIcon = "<i class='iconfont iconfont-e630 icon-f76260'></i>"
			break;
		case "85"://"回撤"
			actionIcon = "<i class='iconfont iconfont-e633 icon-ffc107'></i>"
			break;
		case "88"://"挂起"
			actionIcon = "<i class='iconfont iconfont-e628 icon-ff6600'></i>"
			break;
		case "89"://"恢复"
			actionIcon = "<i class='iconfont iconfont-e629 icon-10aeff'></i>"
			break;
		default://"当前"
			actionIcon = "<i class='iconfont iconfont-e627 icon-8c8c8c'></i>";
			break;
	}	
	
	//是否当前节点
	if(type == "hisNode"){
		//判断流程历史第一和最后节点
		if(i==0){
			html.push('<span><div class="face-name-box"><div class="face"><span class="face-box">');
      	}else{
      		html.push('<span class="show-node"><div class="face-name-box"><div class="face"><span class="face-box">');
      	}
		html.push(avatarHtml);
		html.push('</span></div>');
      	html.push('<div class="start-node-name">'+his.startNodeName+'</div></div>');
      	if(i==0){
      		html.push('<div class="icon-box">'+actionIcon+'<div class="icon-line icon-line-right"></div></div>')
      	}else{
      		html.push('<div class="icon-box">'+actionIcon+'<div class="icon-line icon-line-left"></div><div class="icon-line icon-line-right"></div></div>')
      	}
        html.push('<div>'+his.processtime.substring(5,10)+'</div>');
        html.push('</span>');
	}else if(type == "curNode"){
		html.push('<span><div class="face-name-box"><div class="face"><span class="face-box">');
		//是否完结
		if(his.isComplete && his.isComplete == "true"){
			actionIcon = "<i class='iconfont iconfont-e632 icon-364046'></i>";
		}else{
			//是否多审批人
			if(length > 1){
				html.push('<div class="curNodes"></div>');
			}else{
				html.push(avatarHtml);
			}
		}
		html.push('</span></div>');
      	html.push('<div class="start-node-name">'+his.startNodeName+'</div></div>');
        html.push('<div class="icon-box">'+actionIcon+'<div class="icon-line icon-line-left"></div></div>')
        html.push('<div>'+his.processtime.substring(5,10)+'</div>');
        html.push('</span>');
	}
    return html;
}

/**
**渲染弹出的流程历史模态框
**/
function renderFlowHisModal(data){
	var isComplate = data.isComplete;
	
	var prevNodeTime;
	var $curPage = ajaxPage.getCurPage();
	
	$.each(data.historys,function(i,his){
		var html = [];
		
		//审批节点
		var _startNodeName = his.startNodeName;
		//目标节点
		var _targetNodeName =  his.targetNodeName;
		//办理人
		var _auditorName = his.auditorName;
		if(!his.agentAuditorName){
			_auditorName = his.auditorName;
		}else{
			_auditorName = his.agentAuditorName + "(代理:"+ his.auditorName +")" ;
		}
		//办理人头像
		var avatar = Common.Util.getAvatar(his.auditorId,contextPath);
		var _avatar = "";
		if(avatar!="" && avatar!=undefined){
			_avatar = '<img class="avatar" src="'+avatar+'" >';
		}else{
			_avatar = '<div class="noAvatar">'+ his.auditorName.substr(his.auditorName.length-2, 2) +'</div>';
		}
		
		//签核动作
		var _flowOperation = "";
		switch (his.flowOperation){
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
		
		
		//办理时间
		var _time = his.processtime.replace("T"," ");
		var _processtime = new Date(_time);
		var timeFixArr = _time.split(/[- :]/); 
		var timeFixDate = new Date(timeFixArr[0], timeFixArr[1]-1, timeFixArr[2], timeFixArr[3], timeFixArr[4]);
		var _timeAgo;
		var Month = timeFixDate.getMonth() + 1; 
		var Day = timeFixDate.getDate(); 
		var Hour = timeFixDate.getHours(); 
		var Minute = timeFixDate.getMinutes(); 
		
		var comTime = Common.Util.daysCalc(_time);
		if(comTime.days > 2){
			if (Month >= 10){ 
				_timeAgo = Month + "-"; 
			}else{ 
				_timeAgo = "0" + Month + "-"; 
			} 
			if (Day >= 10) 
			{ 
				_timeAgo += Day + " "; 
			}else{ 
				_timeAgo += "0" + Day; 
			} 
		}else if(comTime.days == 2){ 
			_timeAgo = "前天 ";
			if (Hour >= 10) 
			{ 
				_timeAgo += Hour + ":" ; 
			}else{ 
				_timeAgo += "0" + Hour + ":" ; 
			} 
			if (Minute >= 10) 
			{ 
				_timeAgo += Minute ; 
			}else{ 
				_timeAgo += "0" + Minute ; 
			} 
		}else if(comTime.days == 1){
			_timeAgo = "昨天 ";
			if (Hour >= 10) 
			{ 
				_timeAgo += Hour + ":" ; 
			}else{ 
				_timeAgo += "0" + Hour + ":" ; 
			} 
			if (Minute >= 10) 
			{ 
				_timeAgo += Minute ; 
			}else{ 
				_timeAgo += "0" + Minute ; 
			} 
		}else if(comTime.days <= 0 && comTime.hours > 0){
			_timeAgo = comTime.hours + " 小时前 ";
		}else if(comTime.days <= 0 && comTime.hours <= 0){
			if(comTime.minutes < 5){
				_timeAgo = " 刚刚";
			}else{
				_timeAgo = comTime.minutes + " 分钟前 ";
			}
		}
		
		//动作图标
		var actionIcon = "";
		if(_flowOperation == "回退"){
			actionIcon = '<span class="flowOperation back-f76260"><i class="fa fa-reply"></i>'+_flowOperation+'</span>'
		}else if(_flowOperation == "回撤"){
			actionIcon = '<span class="flowOperation back-ffc107"><i class="fa fa-share-square-o"></i>'+_flowOperation+'</span>'
		}else if(_flowOperation == "挂起"){
			actionIcon = '<span class="flowOperation back-ff6600"><i class="fa fa-coffee"></i>'+_flowOperation+'</span>'
		}else if(_flowOperation == "恢复"){
			actionIcon = '<span class="flowOperation back-10aeff"><i class="fa fa-undo"></i>'+_flowOperation+'</span>'
		}else if(_flowOperation == "流转"){
			actionIcon = '<span class="flowOperation back-09bb07"><i class="fa fa-sign-in"></i>'+_flowOperation+'</span>'
		}
		
		//节点间耗时
		if(i > 0){
			var _prevNodeTime = Common.Util.daysCalc(prevNodeTime,_time);
			var _prevNodeTimeContent = "耗时"
			if(_prevNodeTime.days > 0){
				_prevNodeTimeContent += _prevNodeTime.days + "天";
			}
			if(_prevNodeTime.hours > 0){
				_prevNodeTimeContent += _prevNodeTime.hours + "小时";	
			}
			if(_prevNodeTime.minutes > 0){
				_prevNodeTimeContent += _prevNodeTime.minutes + "分";
			}
			if(_prevNodeTime.seconds > 0){
				_prevNodeTimeContent += _prevNodeTime.seconds + "秒";
			}
		}
		if(!_prevNodeTimeContent){
			_prevNodeTimeContent = "";
		}else if(_prevNodeTimeContent=="耗时"){
			_prevNodeTimeContent = "耗时1分钟";
		}
		prevNodeTime = _time;

		html.push('<div class="leave-list"><div class="leave-list-tr"><div class="leave-list-td w50"></div><div class="leave-list-td"><span style="padding-left:10px">');
		html.push(_timeAgo);
		html.push('</span><span class="pull-right" style="padding-right:10px">'+_prevNodeTimeContent+'</span></div></div>');
		html.push('<div class="leave-list-tr"><div class="leave-list-td w50"><div class="face text-center"><span class="face-box">');
		html.push(_avatar);
		html.push('<div class="arrow"><i class="arrow1"></i><i class="arrow-m"></i></div></span>');
		html.push('<div class="auditor-name">'+his.auditorName+'</div>');
		html.push('</div></div><div class="leave-list-td"><div class="talk-box">');
		html.push('<div class="state">'+ _startNodeName + actionIcon + _targetNodeName +'</div>');
		html.push('<div><br/>'+(his.attitude? his.attitude : '')+'<br/><img onclick="showbig(this);" style="max-height:128px" src="'+his.signatureImageDate+'"></div>');
		html.push('<div class="talk-horn"></div></div></div></div> </div>');
		$curPage.find("#flowhis_modal_content").prepend(html.join(""));
	});
	
	/*if(isComplate){
		var endHis = data.historys[data.historys.length-1];
		var html = [];
		html.push(' <div class="leave-list text-center"><div class="leave-list-tr"><div class="leave-list-td w50" style="line-height: 15px;"><img src="'+contextPath+'/portal/phone/resource/images/ico-03.png" style="margin-top:15px;width: 15px;height: 15px;"><br />');
		html.push(endHis.endNodeName);
		html.push('</div><div class="leave-list-td"><span></span></div></div></div></div>');
		$("#flowhis_modal_content").append(html.join(""));
	}*/

	var leave_list_num = $curPage.find(".leave-list").length;				
	for(i=0;i<leave_list_num;i++){
		var $listArrow = $curPage.find(".leave-list .arrow").eq(i);
		var $listArrowLine = $curPage.find(".leave-list .arrow-m").eq(i);
		if(i==leave_list_num-1){
			$listArrow.remove();
		}else{
			var reverseFaceH = $listArrow.parents(".face").outerHeight();
			$listArrow.height($curPage.find(".leave-list .talk-box").eq(i).height()-reverseFaceH + 40);
			$listArrowLine.height($curPage.find(".leave-list .talk-box").eq(i).height()-reverseFaceH + 40);
		}
    	
    }
}
		

var FlowPanel = {

	bindEvent : function(){
		var $curPage = ajaxPage.getCurPage();
		$curPage.find("#viewHistory").find("a[name='btn_act_committo'], #btn-modal-close").bind("click", function(){
			ajaxPage.clearHashPostfix("popUpLayer");
			$curPage.find("#viewHistory").hide();
		});
		
		var $flowSubmitPanel = $curPage.find(".flow-submit");

		//移除审批人
		$flowSubmitPanel.on("click",".flow-submit__user",function(){
			var $this = $(this);
			var id = $this.data("id");
			var name = $this.data("name");
			var inputID = $this.data("input");
			var $valueField = $this.parents(".weui-cells_checkbox").find("#"+inputID);
			var $textField = $this.parents(".weui-cells_checkbox").find("#"+inputID+"_text");
			var $circulator = $curPage.find("input[name='_circulatorInfo']");
			var $submitStr = $curPage.find("#submitTo");

			if(inputID == "freeflow"){
				$valueField.val("");
				$textField.val("");
				$textField.attr("result","");
				$this.parent().find(".flow-submit__user-select").parent().show();
			}else if(inputID == "_circulator"){
				var value = $circulator.val();
				var valueArr = JSON.parse(value);
				
				for(var i = 0;i < valueArr.length;i++){
					var circulator = valueArr[i].circulator;
					for(var j = 0;j < circulator.length;j++){
						var userid = circulator[j];
						if(userid == id){
							circulator.splice(j, 1);
						}
					}
				}
				$circulator.val(JSON.stringify(valueArr));
				FlowPanel.removeSelectedUser(id,$valueField,$textField);	//移除指定已选用户后的更新已选用户的id以及name的集合
			}else{
				var value = $valueField.val();
				var text = $textField.val();
				var submitStr = $submitStr.val();
				var submitArr = JSON.parse(submitStr);
				var newValue = (value+";").replace(id+";","").substr(0,(value+";").replace(id+";","").length-1);
				var newText = (text+";").replace(name+";","").substr(0,(text+";").replace(name+";","").length-1);
				for(var i = 0;i < submitArr.length;i++){
					var userids = JSON.parse(submitArr[i].userids);
					for(var j = 0;j < userids.length;j++){
						var userid = userids[j];
						if(userid == id){
							userids.splice(j, 1);
							submitArr[i].userids = JSON.stringify(userids);
						}
					}
				}
				$submitStr.val(JSON.stringify(submitArr));
				FlowPanel.removeSelectedUser(id,$valueField,$textField);	//移除指定已选用户后的更新已选用户的id以及name的集合
			}	
			$this.remove();
		})
		
		//隐藏显示常用意见
		$flowSubmitPanel.on("click",".flow-submit__proposal",function(){
			$(this).find(".fa").toggleClass("fa-rotate-180")
			$flowSubmitPanel.find(".flow-submit__proposal-box").slideToggle();
		})
		
		$flowSubmitPanel.on("click",".flow-submit__proposal-box .weui-cell",function(){
			var $this = $(this);
			var $textarea = $(this).parents(".weui-cells_form").find(".weui-textarea");
			var _text = $this.find(".weui-cell__bd").text();
			var oText = $textarea.val();
	
			if(!oText){
				$textarea.val(_text);
			}else{
				$textarea.val($textarea.val() + "," + _text);
			}
			$textarea.trigger("focus");
		})

		//隐藏显示意见文本框
		$flowSubmitPanel.on("focus",".weui-textarea",function(){
			$(this).height(100);
		})
	},
	/**
	 * 移除指定已选用户后的更新已选用户的id以及name的集合
	 *
	 * @param {string} removeUserId 被移除的用户的id
	 * @param {Object} $valueField 存放已选用户id的对象
	 * @param {Object} $textField 存放已选用户name的对象
	 * @return {Object} 返回值描述
	 */ 
	removeSelectedUser : function(removeUserId,$valueField,$textField){
		var selectedText = $textField.attr("result");
		var selectedValue = $valueField.val();
		var separator = ";";
		selectedValue = selectedValue.split(separator);
		selectedText = selectedText.split(separator);
		$.each(selectedValue, function(i,val){ 
			if(removeUserId == val){
				selectedValue.splice(i,1);
				selectedText.splice(i,1);
			}
		});
		var newSelectVal = "";
		var newSelectText = "";
		if(selectedValue.length > 0 ){
			$.each(selectedValue, function(i,val){ 
				newSelectVal += val + separator;
			});
			$.each(selectedText, function(i,val){ 
				newSelectText += val + separator;
			});
			$textField.attr("result",newSelectText.substr(0,newSelectText.length-1));
			$valueField.val(newSelectVal.substr(0,newSelectVal.length-1));
		}else{
			$textField.attr("result","");
			$valueField.val("");
		}
	},
	/**
	 * 指定审批人的可选的静态用户数据
	 */
	getChooseUsers : function(url){
		var toChooseUsers = [];
		$.ajax({
			url : url,
			async : false,
			type : "POST",
			success : function(result){
				if(result.status == 1){
					toChooseUsers = result.data;
				}
			}
		});
		return toChooseUsers;
	},
	renderCommonOpitions : function(){
		var $curPage = ajaxPage.getCurPage();
		var params = {
				userId : USER.id
		};
		$.ajax({
			url : contextPath + "/portal/usersetup/getCommonOpinion.action",
			data : params,
			dataType : "json",
			success : function(result){
				if(result && result.status == 1){					
					var html = template("atp-flowpanel-commonOpitions", result);
					$curPage.find(".flow-submit__proposal-box").html(html);
				}
			}
		});
		
	},
	renderSelectUser : function(id,result){
		var $curPage = ajaxPage.getCurPage();
		result.inputID = id;	
		var $nodePanel = $curPage.find(".flow-submit__panel").find("[data-id='"+id+"']");		
		var $userPanel = $nodePanel.find(".flow-submit__user-panel");
		var $userSelectBtn = $userPanel.find(".flow-submit__user-select").parent();
		var selectUserHtml = template("atp-flowpanel-selectUser",result);
		$userPanel.find(".flow-submit__user").remove();
		$userSelectBtn.before(selectUserHtml);
		if(id == "freeflow"){
			$userSelectBtn.hide();
		}
	},
	//将后端返回的html代码拼接成json
	flowHtmlToJson : function(str){
		var $html = $("<div>"+str+"</div>");
		var isToPerson = $html.find("input#isToPerson").val();
		var currentNodeId = $html.find("#_currentNodeId").val();
		var splitToken = $html.find("input[name='splitToken']").val();
		
		
		var flowPanelJson = {
		    "isToPerson": isToPerson,
		    "currentNodeId": currentNodeId,
		    "splitToken": splitToken,
		    "nodeSelectList": [],
		    "nodeCopyList": []
		}

		//审批
		$html.find("div[data-type='nodeItem']").each(function(i){
			var $this = $(this);
			var $input = $this.find(".flowToPerson-Input-agrs");
			var id = $input.attr("_id");
			var docId = $input.attr("docid");
			var flowid = $input.attr("flowid");
			var hiddenIds = $input.attr("hiddenIds");
			var nextNodeId = $this.find("label").find("input").val();
			var nextNodeType = $this.find("label").find("input").attr("type");
			var nextNodeName = $this.find("label").text();
			var nodeToPerson = $this.find("input[nodeToPerson]").val();
			var value = $input.attr("value");
			var checked = $this.find("label").find("input").attr("checked") || '';
			var lock = $this.find("label").find("input").attr("locked");	//默认选中且锁定

			var nodeItem = {
				"id": id,
				"docId": docId,
				"flowId": flowid,
				"hiddenIds": hiddenIds,
				"nextNodeType":nextNodeType,
				"nextNodeId": nextNodeId,
				"nextNodeName": nextNodeName,
				"nodeToPerson": nodeToPerson,
				"value": value,
				"checked": checked,
				"lock" : lock
			}
			flowPanelJson.nodeSelectList.push(nodeItem);
		});

		//抄送
		$html.find(".copyToPerson").each(function(i){
			var $this = $(this);
			var $input = $this.find(".flowToPerson-Input-agrs");
			var id = $input.attr("_id");
			var docId = $input.attr("docid");
			var flowid = $input.attr("flowid");
			var nextNodeId = $input.attr("nextNodeId");
			
			var nodeItem = {
				"id": id,
				"docId": docId,
				"flowId": flowid,
				"nextNodeId": nextNodeId
			}
			flowPanelJson.nodeCopyList.push(nodeItem);
		});
		
		return flowPanelJson;
	},
	/**
 * 选择审批人后回选用户的id，返回数组
 *
 * @param {string} str 已选所有用户id
 */
	commitUserids : function(str){
		var separator = ";";
		var userIds = []
		if(str != ""){
			userIds = str.split(separator);
		}
		return  userIds;
	},
	/**刷新流程面板， e变量为场景，1、刷新：e=init；2、提交：e=commitTo；3、回退：e=returnTo*/
	refreshFlowPanel : function(actionType,act) {
		
		var $curPage = ajaxPage.getCurPage();
		var $dy_refreshObj = $curPage.find("#dy_refreshObj");
		var formid = $dy_refreshObj.attr("formid");
		var docid = $dy_refreshObj.attr("docid");
		var userid = $dy_refreshObj.attr("userid");
		var flowid = $dy_refreshObj.attr("flowid");
		
		var $auditorList = $curPage.find("#auditorList");

		//当为新建文档（$auditorList.size()==0）、或当前用户在【编辑人】中，显示流程按钮
		if ($auditorList.size()==0 || ($auditorList.size()>0 && $auditorList.val().indexOf(userid)>0)){}
		else{//反向代码写法，方便理解
			//return;
		}
		
		try {
			var url = contextPath + "/portal/dynaform/document/refreshFlowPanelHTML.action";
			var datas = dy_getValuesMap(true);
			datas["formid"]=formid;
			datas["docid"]=docid;
			datas["stateid"] = $curPage.find("input[name='content.stateid']").val();
			datas["userid"]=userid;
			datas["flowid"]=flowid;
			datas["actionType"]=actionType;
			jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:datas,
				    cache:false,
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(str){
				    	try {
				    		var $curPage = ajaxPage.getCurPage();
				    		var flowPanelJson = FlowPanel.flowHtmlToJson(str);
				    		var $currid = $curPage.find("#_currid");
				    		

				    		//var $flowHtmlText = $curPage.find("#flowHtmlText").html(str);
				    		
				    		var $flowHtmlText = $("<div>"+str+"</div>");

							if ($currid.size()>0 && $currid.val()=="") {
								$currid.val(flowPanelJson.currentNodeId);
							}
							switch(actionType) {
								case "commitTo":
									var $nodeBox = $curPage.find(".flow-submit__panel").find("#flow-submit__node-box");

									var nodeSelectList = flowPanelJson.nodeSelectList;

									var html = template("atp-flowpanel-committo", flowPanelJson);
									$nodeBox.html(html);
									
									$nodeBox.find("input[islock='true']").bind("click",function(){	//默认选中且锁定
										return false;
									});
									
									for(var i = 0;i < nodeSelectList.length;i++){
										var id = nodeSelectList[i].id;
										var textField = id + "_text";
										var nextNodeId = nodeSelectList[i].nextNodeId;
										var docId = nodeSelectList[i].docId;
										var flowId = nodeSelectList[i].flowId;
										var value = nodeSelectList[i].value;
										var hiddenIds = nodeSelectList[i].hiddenIds;
										var nodeToPerson = nodeSelectList[i].nodeToPerson || false;
										
										if(!nodeToPerson || nodeToPerson == "false") {
											// 如果不能指定流程审批人，则下一个循环
											continue;
										}
										
										var _url = contextPath + '/contacts/getContactsByFlow.action?flowid='+flowid+'&docid='+docid+'&nodeid='+nextNodeId+'&type=3';
										var toChooseUsers = [];
										toChooseUsers = FlowPanel.getChooseUsers(_url);
										$curPage.find(".flowToPerson-Input:eq("+i+")").userbox({
											//属性和事件回调可自定义，无自定义需求可完全不填，具体用法参考说明文档
											id : id,//必须，存放回选的用户value值的input的id
											textId : textField,//必须，存放回选的用户text值的input的id
											isPhone : true,		//是否手机端
											multiple: true,//是否多选模式
											mode: 'all',//simple:精简模式|all:完整模式
											width: 'auto',//宽度
											disabled: false,//是否禁用
											readOnlyShowValOnly : true,//只读是否只显示值
											required: false,//是否必填
											toChooseUsers : toChooseUsers,
											tabs: {},	// [] 配置显示的tab，全部、部门、职务、常用
											selectUser : value,	//已选择的用户
											clearlabel : "清除",	//清除按钮的title
											selectBtn: $nodeBox.find(".flow-submit__nextNode:eq("+i+")").find(".flow-submit__user-select"),
											separator: ';',//多选模式下的分隔符
											onSuccess : function(result, rtnValue, rtnText){
											
												var submitStr = $curPage.find("#submitTo").val();
												
												var $input = $(this.selectBtn);
												var $nextNodeInput = $input.parents(".weui-cell").prev().find("input");
												var nextNodeId = $nextNodeInput.val();
												//判断是否存在提交数据
												if(submitStr == null || submitStr == ""){
													var submitObj = [];
													var userIds = FlowPanel.commitUserids(rtnValue);
													var userObj = {
														"nodeid":nextNodeId,
														"isToPerson":"true",
														"userids":JSON.stringify(userIds)
													}
													submitObj.push(userObj);
												}else{
													submitObj = JSON.parse(submitStr);
													var hasNode = false;
													//查找是否存在当前节点的提交数据
													for(var i = 0;i < submitObj.length;i++){
														var nodeid = submitObj[i].nodeid;
														if(nodeid == nextNodeId){
															hasNode = true;
															var userids = JSON.parse(submitObj[i].userids);
															submitObj[i].userids = JSON.stringify(FlowPanel.commitUserids(rtnValue));
														}
													}
													//不存在当前节点提交数据时插入新数据
													if(!hasNode){
														var userIds = FlowPanel.commitUserids(rtnValue);
														
														var userObj = {
															"nodeid":nextNodeId,
															"isToPerson":"true",
															"userids":JSON.stringify(userIds)
														}
														submitObj.push(userObj);
													}
												} 
												submitStr = JSON.stringify(submitObj);
												$curPage.find("#submitTo").val(submitStr);
												$curPage.find("#"+this.id).val(rtnValue);
												FlowPanel.renderSelectUser(this.id,result);
												if(result.data.length >0){
													$("#" + (this.id + "_text")).attr("result",rtnText);
												}else{
													$("#" + (this.id + "_text")).attr("result","");
												}
											},
											onOpen : function(){
												
											},
											onClose : function(){
												
											}
										});
										
									}

									var nodeCopyList = flowPanelJson.nodeCopyList;
									
									
									
									for(var i = 0;i < nodeCopyList.length;i++){
										var id = nodeCopyList[i].id;
										var textField = id + "_text";
										var nextNodeId = nodeCopyList[i].nextNodeId;
										var docId = nodeCopyList[i].docId;
										var flowId = nodeCopyList[i].flowId;
										var _copyUrl = contextPath + '/contacts/getContactsForCirculator.action?_flowId='+flowid+'&_docId='+docid+'&_nodeId='+nextNodeId+'&_isGetCirculator=true';
										var toCopyChooseUsers = [];
										toCopyChooseUsers = FlowPanel.getChooseUsers(_copyUrl);
										$curPage.find(".copyToPerson-Input").userbox({
											//属性和事件回调可自定义，无自定义需求可完全不填，具体用法参考说明文档
											id : id,//必须，存放回选的用户value值的input的id
											textId : textField,//必须，存放回选的用户text值的input的id
											isPhone : true,		//是否手机端
											multiple: true,//是否多选模式
											mode: 'all',//simple:精简模式|all:完整模式
											width: 'auto',//宽度
											disabled: false,//是否禁用
											readOnlyShowValOnly : true,//只读是否只显示值
											required: false,//是否必填
											clearlabel : "清除",	//清除按钮的title
											selectBtn: $nodeBox.find(".flow-submit__copyTo .flow-submit__user-select"),
											separator: ';',//多选模式下的分隔符
											toChooseUsers : toCopyChooseUsers,
											tabs: {},	// [] 配置显示的tab，全部、部门、职务、常用
											onSuccess : function(result, rtnValue, rtnText){
												if(id == "_circulator"){	//指定抄送人的回调方法
													if(result.data.length>0){
														var circulatorArr = [];
														for (var i = 0; i < result.data.length; i++) {
															circulatorArr.push(result.data[i].value);
														}
														var circulatorInfo = [{
															"circulator": circulatorArr
														}];
														var circulatorStr = JSON.stringify(circulatorInfo)
														$curPage.find("input[name='_circulatorInfo']").val(circulatorStr);
														
													}else{
														circulatorInfos[0] = '';
														$curPage.find("input[name='_circulatorInfo']").val("");
													}
													FlowPanel.renderSelectUser(this.id,result);
													$curPage.find("#"+id).val(rtnValue);
													$curPage.find("#"+textField).attr("result",rtnText);
												}
											},
											onOpen : function(){
												
											},
											onClose : function(){
												
											}
										});
									}
								
									break;
								case "returnTo":
									var $nodeBox = $curPage.find(".flow-submit__panel").find("#flow-submit__node-box");
									$nodeBox.html($flowHtmlText);
									break;
								case "init":
									var isFlowComplete = $curPage.find("#isComplete").val();
									if(isFlowComplete == "" || isFlowComplete == "false"){
										FlowPanel._renderButtons($flowHtmlText);
									}
									FlowPanel.renderCommonOpitions();
									break;
								default:
							}

							//判断是否展开面板
							if(act){
								var isToPerson_Flag = FlowPanel._checkHideSubmitPanel();
								if(isToPerson_Flag){
									FlowPanel.flowCommitTo();
								}else{
									
									var $page_flowPro = ajaxPage.getCurPage().find("#page_flowPro");
									$page_flowPro.show();
									FlowPanel.refreshFlowPanel("commitTo");
									
									
									var $btn = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='提交'>提交</a></div>").click(function(){
										$(this).attr("disabled", "disabled");//锁住当前操作，避免重复提交
										FlowPanel.flowCommitTo();
									});
									var $cancel = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-block' title='取消'>取消</a></div>").click(function(){
										FlowPanel.cancelAction();
										$curPage.find("#page_flowPro").hide();
									});
			
			//						var $page_flowPro = ajaxPage.addPage();	//false:添加但暂不显示
			//						$page_flowPro.attr("role", "main").addClass("ui-content");
			//						$page_flowPro.append($page_flowProOld.children());
									
									//$page_flowPro显示后再初始化手写签批
									$page_flowPro.find("#div_button_place").empty().append($btn).append($cancel);
									
									var title = $page_flowPro.find(".flow-submit").data("title");
									var curFormId = $curPage.attr("id");
									var curPage_title = ajaxPage.title[curFormId];
									document.title = curPage_title + "-" + title;
									ajaxPage.addHashPostfix("flowPro");
								}
							}
							
						} catch (ex) {
							alert('refreshFlowPanel.callback(): ' + ex.message);
						}
				    },
				    error:function(){ 
				        alert("请求失败");
				    }
				});
		} catch (ex) {
			alert('refreshFlowPanel: ' + ex.message);
		}
	},
	
	/**检查是否选择抄送人*/
	_checkIsSelectCirculator : function (){
		var $curPage = ajaxPage.getCurPage();
		var obj = $curPage.find("#_circulator")[0];
		var _flowType = $curPage.find("#_flowType").val();
		/*if(obj && _flowType != '81'){
			if(obj.val() && obj.val().length<=0){
				alert("请选择抄送人！");
				return false;
			}
		}*/
		return true;
	},
	
	/**检验选择指定审批人的节点是否已选择审批人*/
	_checkToPerson : function (){
		var $curPage = ajaxPage.getCurPage();
		var $nextids = $curPage.find("[name='_nextids']");
		var _flowType = "";
		var $_flowType = $curPage.find("#_flowType");
		if($_flowType && $_flowType.size()>0){
			_flowType = $_flowType.val();
		}
		
		for (var i=0; i<$nextids.length; i++) {
			var nodeid = $nextids[i].value;
			//是否指定审批人
			var $isToPerson = $curPage.find("#isToPerson");
			if(($isToPerson && $isToPerson.val() == 'true') && $nextids[i].checked){
				var isNullUser = false;
				var $input = $curPage.find("#input_"+i);
				if($input && $input.val()==""){
					isNullUser=true;
				}else{
					isNullUser=false;
				}

				// 提交到下一步
				if(_flowType == '80'){
					if(isNullUser){
						alert ('请选择指定审批人');
						return false;
					}
				}
			}
		}

		return true;
	},
	
	_checkHideSubmitPanel : function (){
		var $curPage = ajaxPage.getCurPage();
		var $nodeBox = $curPage.find(".flow-submit__panel").find("#flow-submit__node-box");
		var $nextids = $nodeBox.find("[name='_nextids']");
		var _flowType = '';
		if($nodeBox.find("#_flowType").size() > 0){
			_flowType = $nodeBox.find("#_flowType").val();
		}
		
		var $isToPerson = $nodeBox.find("#isToPerson");
		var multiNodes = $nextids.size() > 1 ? true : false ;
		isToPerson = $isToPerson && $isToPerson.val() == 'true' ? true : false ;

		if(_flowType == '80'){
			if(!isToPerson && !multiNodes){
				return true;
			}
		}
		return false;
	},
	
	/**流程处理*/
	flowCommitTo : function() {		//提交

			var $curPage = ajaxPage.getCurPage();
			var data = $sigdiv.jSignature('getData', "image");
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$curPage.find("input[name='_signature']").val(signatureJson);
				}
			}
		
			if(!FlowPanel._checkIsSelectCirculator()){
				return;
			}
			var $nextids = $curPage.find("[name='_nextids']");
			var isToPersonStr = '';
			var $isToPerson = $curPage.find("#isToPerson");
			if($isToPerson && $isToPerson.size() > 0){
				isToPersonStr = $isToPerson.val();
			}
			var flag = false;
			var parameters ='';
			
			if ($nextids && $nextids.size()>0) {
				if (!FlowPanel._checkToPerson()){
					return;
				}
				
				for (var i=0; i<$nextids.length; i++) {
					if ($nextids[i].type != 'select-one') {
						if ($nextids[i].checked) {
							flag = true;
							break;
						}
					} else {
						if ($nextids[i].value != null 
						&& $nextids[i].value != '') {
							flag = true;
							break;
						}
					}
				}

				if (flag) {
					//设置流程类型为【提交-80】
					var $_flowType = $curPage.find("#_flowType");
					if($_flowType && $_flowType.size()>0){
						$_flowType.val("80");
					}
					var actid = $curPage.find("input[activityType='5']").attr("actid");
					Activity.doExecute(actid,5);
				}
				else {
					alert('请选择一项操作');
				}
			}
			else {
				alert ('没有操作能被执行');
			}
		},
		
		flowReturnTo : function() {		//回退
			var $curPage = ajaxPage.getCurPage();
			if ($curPage.find("#back").val()=='') {
				alert('请选择需要回退的结点！');
				return;
			}
			var data = $sigdiv.jSignature('getData', "image");
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$curPage.find("input[name='_signature']").val(signatureJson);
				}
			}

			//设置流程类型为【回退-81】
			var $_flowType = $curPage.find("#_flowType");
			if($_flowType && $_flowType.size()>0){
				$_flowType.val("81");
			}

			var actid = $curPage.find("input[activityType='5']").attr("actid");
			Activity.doExecute(actid,5);
		},
	
		/**子流程审批信息文本JSON格式*/
		_biuldsubFlowApproverInfoStr : function (){
			var $curPage = ajaxPage.getCurPage();
			var result ='';
			if(subFlowApproverInfo.length>0){
				result+='[';
			}
			for(var i=0;i<subFlowApproverInfo.length;i++){
				result+=subFlowApproverInfo[i]+',';
			}
			if(result.length>0){
				result = result.substring(0,result.length-1);
				result+=']';
				
				$curPage.find("input[name='_subFlowApproverInfo']").val(result);
			}
		},
		
		/**构建抄送信息文本JSON格式*/
		_biuldCirculatorInfoStr : function (){
			var $curPage = ajaxPage.getCurPage();
			var result ='';
			if(circulatorInfos.length>0){
				result+='[';
			}
			for(var i=0;i<circulatorInfos.length;i++){
				result+=circulatorInfos[i]+',';
			}
			if(result.length>0){
				result = result.substring(0,result.length-1);
				result+=']';
				
				$curPage.find("input[name='_circulatorInfo']").val(result);
			}
		},
		
		/**
		 * 流程相关的按钮渲染
		 */
	_renderButtons : function($flowHtmlText) {
		var $ = jQuery;
		var $curPage = ajaxPage.getCurPage();
		var $div_button_box = $curPage.find("#div_button_box");
		$div_button_box.find("td.flowTd").remove();
		
		var curFormId = $curPage.attr("id");
		var curPage_title = ajaxPage.title[curFormId];
		
		var $flowProcessBtn = $curPage.find("input[activityType='5']");
		
		if($flowHtmlText.find("#btn_flow_reminder").size() > 0 && $flowHtmlText.find("#act_flow_reminder").size() == 0){//渲染催办按钮
			var html = "<td><a id='act_flow_reminder' name='button_act' class='btn btn-orange btn-block' title='催办'>"
				+ "催办"
				+ "</a></td>";
			var $b = $(html);
			var $flowhis_panel_hisnode = $curPage.find(".flowhis_panel_hisnode").children();
			var $start_node = $flowhis_panel_hisnode.first();
			var $current_node = $flowhis_panel_hisnode.last();
			var start_node_name = $start_node.find(".start-node-name").html();
			var current_node_name = $current_node.find(".start-node-name").html();
			$curPage.find('#flowReminderDiv').find(".pull-left").html(start_node_name);
			var $t =  $flowHtmlText.find("#btn_flow_reminder");
			var $noderts = $t.data("nodes");
			for(var i = 0; i < $noderts.length ; ++i){
				$('<lable><input type="checkbox" name="_nodertIds" value="'
						+ $noderts[i].nodertId
						+ '" checked="checked" />'
						+ $noderts[i].nodeName 
						+ '</lable></br>').appendTo($curPage.find("#flowReminderDiv").find(".pull-right"));
			}

			$b.click(function(){
				ajaxPage.addHashPostfix("popUpLayer");
				var hasClick = false;	//防止重复点击
				$curPage.find(".flowReminderDiv").show().on('click', '.flowReminder_submit', function () {
					if(!hasClick){
						hasClick = true;
						showLoadingToast();
						var url = contextPath + "/portal/dynaform/document/flowReminder.action";
						var data = ajaxPage.getParams();
						$.ajax({
							type : "post",
							url : url,
							data : data,
							success : function(result){
								ajaxPage.clearHashPostfix("popUpLayer");
								
								$curPage.find('#toast').show();
				                setTimeout(function () {
				                	$curPage.find('#toast').hide();
				                    ajaxPage.reloadPage();
				                }, 2000);
				                $curPage.find('#flowReminderDiv').off('click').hide();
				                hideLoadingToast();
								hasClick = false;
							},
							error:function(){
								$curPage.find('#error_message').show();
				                setTimeout(function () {
				                	$curPage.find('#error_message').hide();
				                }, 2000);
				                $curPage.find('#flowReminderDiv').off('click').hide();
				                hideLoadingToast();
								hasClick = false;
							}
						});
					}
                }).on('click', '.flowReminder_cancel', function () {
                	ajaxPage.clearHashPostfix("popUpLayer");
                	$curPage.find('#flowReminderDiv').off('click').hide();
                });
				$curPage.find("#flowReminderDiv .flowReminder_content").bind('input oninput', function(){
					$curPage.find("#flow-reminder-counter .flow-reminder-num").html($("#flowReminderDiv .flowReminder_content").val().length); 
				});
			});
			$flowProcessBtn.after($b);
		}
		
		if($flowHtmlText.find("#_handup").size() > 0){//流程挂起
			var buttonName = $flowHtmlText.find("input[moduleType='handup']").attr("buttonname");
			var nodertId = $flowHtmlText.find("#_handup").attr("nodertId");
			var html = "<td class='flowTd'><a id='act_flow_retracement' name='button_act' title='挂起'  onclick='ev_flowHandup(\"" + nodertId + "\")' class='btn btn-orange btn-block'>"
				+ buttonName
				+ "</a></td>"
			var $b = $(html);
			$flowProcessBtn.after($b);
		}else if($flowHtmlText.find("#_recover").size() > 0){//流程恢复
			var buttonName = $flowHtmlText.find("input[moduleType='recover']").attr("buttonname");
			var nodertId = $flowHtmlText.find("#_recover").attr("nodertId");
			var html = "<td class='flowTd'><a id='act_flow_retracement' name='button_act' title='恢复'  onclick='ev_flowRecover(\"" + nodertId + "\")' class='btn btn-orange btn-block'>"
				+ buttonName
				+ "</a></td> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if($flowHtmlText.find("#btn_retracement").size() > 0 && $flowHtmlText.find('#act_flow_retracement').size() == 0){//渲染回撤按钮
			var html = "<td class='flowTd'><a id='act_flow_retracement' name='button_act' title='回撤' onclick='doRetracement()' class='btn btn-orange btn-block' >"
			+ "回撤"
			+ "</a></td>";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		/* 手机端不显示加签按钮，这里屏蔽掉。 */
		/*if($flowHtmlText.find("#btn_addAuditor").size() > 0 && $flowHtmlText.find('#act_flow_addAuditor').size() == 0){//渲染流程加签按钮
			var html = "<td class='flowTd'><a id='act_flow_addAuditor' name='button_act' title='加签' onclick='addAuditor()'  class='btn btn-primary btn-block'>"
			+ "加签"
			+ "</a></td>";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}*/
		if($flowHtmlText.find("#btn_editAuditor").size() > 0 && $flowHtmlText.find('#act_flow_editAuditor').size() == 0){//渲染编辑审批人按钮
			var html = "<td class='flowTd'><a id='act_flow_editAuditor' name='button_act' title='编辑流程审批人' onclick='editAuditor()'  class='btn btn-orange btn-block' >"
			+ "编辑流程审批人"
			+ "</a></td>";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if($flowHtmlText.find("#btn_editFlow").size() > 0 && $flowHtmlText.find('#act_flow_editFlow').size() == 0){//渲染调整流程按钮
			var html = "<td class='flowTd'><a id='act_flow_editFlow' name='button_act' title='流程调整' onclick='editFlowByFrontUser()'  class='btn btn-orange btn-block'>"
			+ "流程调整"
			+ "</a></td>";
			var $b = $(html);
			//$flowProcessBtn.after($b);
		}
		if($flowHtmlText.find("#btn_termination").size() > 0 && $flowHtmlText.find('#act_flow_termination').size() == 0){//渲染终止流程按钮
			var html = "<td class='flowTd'><a id='act_flow_termination' name='button_act' title='终止流程' onclick='terminateFlow()'  class='btn btn-negative btn-block'>"
			+ "终止流程"
			+ "</a></td>";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if($flowHtmlText.find("#btn_back").size() > 0 && $flowHtmlText.find('#act_flow_back').size() == 0){//渲染回退流程按钮
			var html = "<td class='flowTd'><a id='act_flow_back' name='button_act' class='btn btn-orange btn-block' title='回退'>"
			+ "回退"
			+ "</a></td>";
			var $b = $(html);
			$b.click(function(){
				var $page_flowPro = $curPage.find("#page_flowPro");
				$page_flowPro.show();
				//点击按钮时需要重新刷新面板
				FlowPanel.refreshFlowPanel("returnTo");

				var $btn = $("<div class='weui-flex__item'><a name='btn_act_returnto' class='btn btn-orange btn-block' data-transition='fade' title='回退'>回退</a></div>").click(function(){
					$(this).attr("disabled", "disabled");
					FlowPanel.flowReturnTo();
				});
				var $cancel = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-block' data-transition='fade' title='取消'>取消</a></div>").click(function(){
					FlowPanel.cancelAction();
					$("#page_flowPro").hide();
				});
				$page_flowPro.find("#div_button_place").empty().append($btn).append($cancel);
				document.title = curPage_title + "-回退";
				ajaxPage.addHashPostfix("flowPro");
			});
			$flowProcessBtn.after($b);
		}

		$.each($flowProcessBtn , function(i,target){
			
			var showtype = $(target).attr("flowshowtype");
			var title = $(target).val();
			var $b; 
			var workFlowType = $(target).attr("workflowtype");	
			if(workFlowType == 0){ //预定流程
				if($flowHtmlText.find("#btn_commit").size() > 0 && $flowHtmlText.find("#act_flow_submit").size() == 0){//渲染提交流程按钮
					var html = '<td><a class="btn btn-positive btn-block" data-transition="fade" title="'+title+'">' + title + '</a></td>';
					var $b = $(html);
					$b.click(function(){
						if(showtype == "ST03"){
							//点击按钮时需要重新刷新面板
							FlowPanel.refreshFlowPanel("commitTo",true);
						}else{
							//点击按钮时需要重新刷新面板
							var $page_flowPro = $curPage.find("#page_flowPro");
							$page_flowPro.show();
							FlowPanel.refreshFlowPanel("commitTo");
							
							var $btn = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='提交'>提交</a></div>").click(function(){
								$(this).attr("disabled", "disabled");//锁住当前操作，避免重复提交
								FlowPanel.flowCommitTo();
							});
							var $cancel = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-block' title='取消'>取消</a></div>").click(function(){
								FlowPanel.cancelAction();
								$("#page_flowPro").hide();
							});
	
	//						var $page_flowPro = ajaxPage.addPage();	//false:添加但暂不显示
	//						$page_flowPro.attr("role", "main").addClass("ui-content");
	//						$page_flowPro.append($page_flowProOld.children());
							
							//$page_flowPro显示后再初始化手写签批
							$page_flowPro.find("#div_button_place").empty().append($btn).append($cancel);
							document.title = curPage_title + "-" + title;
							ajaxPage.addHashPostfix("flowPro");
						}
					});
					$(target).after($b);
				}
			}else if(workFlowType == 1){
				
			  var flag = false ;
				 var auditorList = $curPage.find("#auditorList").val();
				 var userId = WebUser.id;
				 
				 if(auditorList){
					 var author =  JSON.parse(auditorList);
					 for(var index in author){
						 if(index == userId){
							 flag = true ;
							 break ;
						 }
					 }
				 }else{ //新建表单
					 flag = true ;
				 }
				 if(flag){
						 
				var stateid = $curPage.find("input[name='content.stateid']").val();
		     	var actid = $(this).attr("actid");
		     	/**
		     	* 通过判断stateid,渲染不同的按钮（【提交、回退、结束】/【发起】 ）
		     	*/
				if(stateid){
					//-- 提交按钮 -- start 
					var html = '<td><a id="act_flow_commitTo" class="btn btn-positive btn-block" title="'
						+title+'" name="button_act" _flowType = "80" data-transition="fade">'+title+'</a></td>';
					$b = $(html);
					$b.click(function(){
						var type = "commit";
						FlowProcess.renderFreePanel(actid,type);
					});
					$(target).after($b);
					//-- 提交按钮 -- end
					    
					//-- 回退按钮  -- start
					var html = '<td><a id="act_flow_backOff" class="btn btn-orange btn-block" title="回退'
						+'" name="button_act" _flowType = "80" data-transition="fade">回退</a></td>';
					$b = $(html);
					$b.click(function(){
						var type = "back";
						FlowProcess.renderFreePanel(actid,type);
					});
					$(target).after($b);
					//-- 回退按钮  -- end 

					//-- 结束流程按钮  -- start
					var html = '<td><a id="act_flow_complete" class="btn btn-primary btn-block" title="结束流程"'
						+' name="button_act" _flowType = "7" data-transition="fade">结束流程</a></td>';
					$b = $(html);
					$b.click(function(){
						var type = "end";
						FlowProcess.renderFreePanel(actid,type);
					});
					$(target).after($b);
					//--  结束流程按钮  -- end 
				}else{
					//-- 发起按钮 -- start 
					var html = '<td><a id="act_flow_startup" class="btn btn-positive btn-block" title="'
						+title+'" name="button_act" _flowType = "1" data-transition="fade">'+title+'</a></td>';
					$b = $(html);
					$b.click(function(){
						var type = "start";
						FlowProcess.renderFreePanel(actid,type);
					});
					$(target).after($b);
					//-- 提交按钮 -- end
				}
			 }
			}		 
			
		})
		
		
//    	$sigdiv = $("#signature").html("").jSignature({'UndoButton':false,width:$(window).width()-26,height:$(window).height()-300,color:'#000',lineWidth:0});
//    	
//    	var obj = document.getElementById('signature'); 
//    	obj.addEventListener("touchstart",function(e){
//    		e.preventDefault();
//    		e.stopPropagation();
//    	},false);
	},
	/**
		取消流程提交或回退操作
	**/

	cancelAction : function(){
//		console.info("back");
		var curFormId = ajaxPage.getCurPage().attr("id");
		var curPage_title = ajaxPage.title[curFormId];
		document.title = curPage_title;
		history.back();
	},
	
	/*
	*	子流程节点选择审批人	
	*/       
	showUserSelectOnSubFlow : function (actionName, settings){
		var $curPage = ajaxPage.getCurPage();
		var appId =  $curPage.find("input[activityType='5']").attr("applicationid");
		var url = contextPath + '/portal/phone/user/selectApprover4Subflow.jsp?application='+appId;
		url += "&docid=" + settings.docid + "&instanceId=" + settings.instanceId+"&numberSetingType=" + settings.numberSetingType+"&instanceTotal=" + settings.instanceTotal+"&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		//var jsonStr = jQuery("input[name='_subFlowApproverInfoAll']").val();
		var jsonStr = getSubFlowApproverInfo(settings.nextNodeId);
		//var nodeid = "123456789";
		var value = '';
		OBPM.dialog.show({
			width: 700,
			height:500,
			url: url,
			args: {value: value, readonly: settings.readonly,numberSetingType: settings.numberSetingType,instanceTotal: settings.instanceTotal,nodeid: settings.nextNodeId,jsonStr: jsonStr},
			//args: {"instanceTotal": 5,"nodeid": nodeid,"jsonStr": jsonStr},
			title: '用户选择',
			close: function(jsonObj) {
				if(jsonObj != null){
					//alert(JSON.stringify(jsonObj));
					
					
					FlowPanel._addSubFlowApproverInfo(subFlowApproverInfoAll,settings.nextNodeId,JSON.stringify(jsonObj));
					
					//jQuery("input[name='_subFlowApproverInfoAll']").val(JSON.stringify(jsonObj));
					//去除names属性
					var approverObj = JSON.parse(jsonObj.approver);
					var nameStr = "";
					//alert(approverObj.length);
					for(var i = 0; i < approverObj.length; i++){
						if(i != 0)nameStr += ',';
						nameStr += approverObj[i].names;
						delete approverObj[i].names;
					}
					$curPage.find("input[name="+ settings.textField +"]").val(nameStr);
					jsonObj.approver = approverObj;
					//alert("after delete ==> " + JSON.stringify(jsonObj));
					//-----------------------------------------------------
					//alert(JSON.stringify(jsonObj));
					FlowPanel._addSubFlowApproverInfo(subFlowApproverInfo,settings.nextNodeId,JSON.stringify(jsonObj));
					
					//biuldsubFlowApproverInfoStr();
					
					
					
					
					//-----------------------------------------------------
					
					//jQuery("input[name='_subFlowApproverInfo']").val(JSON.stringify(jsonObj));
				}
				//组装 json 字符串 并赋值到 一个name为“_subFlowApproverInfo”隐藏域里 作为参数提交到后台处理
			}
		});
	},
	_addSubFlowApproverInfo : function(Obj,nodeId,info){
		var falg =true;
		for(var i=0;i<Obj.length;i++){
			var tmp =Obj[i];
			if(tmp.indexOf(nodeId)>0){
				Obj[i] =info;
				falg = false;
				break;
			}
		}
		if(falg){
			Obj.push(info);
		}
	},

	
	showUserSelect : function(actionName, settings) {
		var $curPage = ajaxPage.getCurPage();
		var appId =  $curPage.find("input[activityType='5']").attr("applicationid");
		var url = contextPath + '/portal/phone/resource/component/dialog/selectUserByAll.jsp?application='+appId;
		url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid +'&flow=true';
		var valueField = $curPage.find("#" + settings.valueField)[0];
		var value = "";
		if (valueField){
			value = valueField.value;
		}
		var ids = $curPage.find("#" + settings.hiddenIds).val();
		OBPM.dialog.show({
			width: 640,
			height: 480,
			url: url,
			//args: {parentObj: window, idField: "submitTo", nameField: settings.textField, readonly: settings.readonly},
			args: {parentObj: window, value: value, readonly: settings.readonly,"applicationid":appId,"defValue":ids},
			title: '用户选择',
			close: function(result) {
				selectFlag = true;
				var rtn = result.data;
				var field = $curPage.find("#" + settings.textField)[0];
				if (field) {
					if (rtn) {
						isToPerson = true;
						if (rtn[0] && rtn.length > 0) {
							var rtnValue = '';
							var rtnText = '';
							//userid多个以","分隔
							var selectedNode = $curPage.find("#" + settings.nextNodeId)[0];
							//用户选择曾经选过的节点
							var submitTo = $curPage.find("#submitTo").val();
							if(submitTo==null || submitTo==""){
                                 submitTo = "[";
							}else{
								if(submitTo.lastIndexOf("]")!=-1){
								 	submitTo = submitTo.substr(0,submitTo.lastIndexOf("]"));
								 	submitTo = submitTo +',';
								}
							}
							var start=submitTo.indexOf(settings.nextNodeId)+settings.nextNodeId.length+34;
							if(submitTo.indexOf(settings.nextNodeId)>0){
								var strfront=submitTo.substr(0,start);
								var strtemp=submitTo.substr(start+1,submitTo.length);
								if(strtemp.substr(strtemp.length-1,strtemp.length)==","){
									strtemp = strtemp.substr(0,strtemp.length-1);
								}
								var strfoot=strtemp.substr(strtemp.indexOf("]",0)-1,strtemp.length);
								submitTo=strfront;
								for (var i = 0; i < rtn.length; i++) {
									rtnValue += rtn[i].value + ";";
									rtnText += rtn[i].text + ";";
									submitTo+="'"+rtn[i].value+"',";
								}
								//submitTo= submitTo.replace('"userids":"','"userids":"[');
								submitTo=submitTo.substring(0,submitTo.length-2);
								submitTo+=strfoot;

								$curPage.find("#" + settings.hiddenIds).val(rtnValue.substring(0, rtnValue.lastIndexOf(";")));
							}
							else{
								submitTo+="{\"nodeid\":'"+settings.nextNodeId+"',\"isToPerson\":'true',\"userids\":\"[";
								var userids="";
								for (var i = 0; i < rtn.length; i++) {
									rtnValue += rtn[i].value + ";";
									rtnText += rtn[i].text + ";";
									userids+="'"+rtn[i].value+"',";
								}
								userids=userids.substring(0,userids.length-1); 
								submitTo+=userids+"]\"}";

								$curPage.find("#" + settings.hiddenIds).val(rtnValue.substring(0, rtnValue.lastIndexOf(";")));
							}
							$curPage.find("#submitTo").val(submitTo+"]");
							valueField.value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
							var text = rtnText.substring(0, rtnText.lastIndexOf(";"));
							field.value = text;
							field.title = text;
						}else{
							valueField.value = '';
							field.value = '';
							field.title = '';
							$curPage.find("#submitTo").val('');
							$curPage.find("#" + settings.hiddenIds).val('');
							isToPerson = false;
						}
					} else {
						
					}
			
					if (settings.callback) {
						settings.callback(valueField.name);
					}
				}
			}
		});
		
	}
};

function BackAction(){
	if(location.hash != "#flowPro"){
		ajaxPage.getCurPage().find("#page_flowPro").removeClass("active");
	}
}

/*
*	子流程节点选择审批人	
*/       
function showUserSelectOnSubFlow(actionName, settings){
	FlowPanel.showUserSelectOnSubFlow(actionName, settings);
}

/**不想改变服务器端输出HTML文本结构（虽然并不喜欢），在此保留一个接口*/
function showUserSelect(actionName, settings) {
	FlowPanel.showUserSelect(actionName, settings);
} 
/**
 *设置流程类型 
 *服务器端输出的html中输出的组件会调用此JavaScript方法，
 * 不想改变服务器端输出，因此保留一个空的方法接口，避免浏览器错误
 */
function ev_setFlowType(isOthers, element, flowOperation) {
	//Nothing...
}
 
function ev_validation(el, actid) {
	var $nextids = ajaxPage.getCurPage().find("[name='_nextids']");
	var flag = false;
	
//	makeAllFieldAble();
	
	if ($nextids && $nextids.size()>0) {
		for (var i=0; i<$nextids.length; i++) {
			if ($nextids[i].type != 'select-one') {
				if ($nextids[i].checked) {
					flag = true;
					break;
				}
			} else {
				if ($nextids[i].value != null 
				&& $nextids[i].value != '') {
					flag = true;
					break;
				}
			}
		}
		
		if (flag) {
			var action='<s:url action="action" namespace="/portal/dynaform/activity" />?_activityid=' + actid;
			ajaxPage.submitPage(action);
		}
		else {
			alert('{*[page.workflow.chooseaction]*}');
		}
	}
	else {
		alert ('{*[page.workflow.noaction]*}');
	}
}


 function getSubFlowApproverInfo(nodeId){
		for(var i=0;i<subFlowApproverInfoAll.length;i++){
			var tmp =subFlowApproverInfoAll[i];
			if(tmp.indexOf(nodeId)>0){
				return tmp;
			}
		}
		return '';
	}
 
/**
*指定抄送人
*
**/
function selectCirculator(actionName, settings) {
	var $curPage = ajaxPage.getCurPage();
	var url = contextPath + '/portal/phone/user/selectCirculatorByFlow.jsp?application='+application;
	url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
	var valueField = $curPage.find("#" + settings.valueField)[0];
	var value = "";
	if (valueField){
		value = valueField.value;
	}
	OBPM.dialog.show({
		width: 610,
		height: 450,
		url: url,
		args: {
			// p1:当前窗口对象
			"parentObj" : window,
			// p2:存放userid的容器id
			"targetid" : "_circulatorInfo",
			// p3:存放username的容器id
			"receivername" : settings.textField,
			// p4:默认选中值, 格式为[userid1,userid2]
			"defValue": settings.defValue,
			//选择用户数
			"limitSum": settings.limitSum,
			//选择模式
			"selectMode":settings.selectMode
		},
		title: '用户选择',
		close: function(result) {
			selectFlag = true;
			var rtn = result;
			var field = $curPage.find("#" + settings.textField)[0];
			if (field) {
				if (rtn) {
					var rtnValue = '';
					var rtnText = '';
					for (var i = 0; i < rtn.length; i++) {
						rtnValue += '"'+ rtn[i].value + '",';
						rtnText += rtn[i].text + ";";
					}
					if(rtnValue.length>0){
						rtnValue = rtnValue.substring(0,rtnValue.length-1);
						rtnValue = '['+rtnValue+']';
						var circulatorInfo ='{circulator:'+rtnValue+'}';
						circulatorInfos[0] = circulatorInfo;
						//addCirculatorInfo(circulatorInfos,settings.nextNodeId,circulatorInfo);
						biuldCirculatorInfoStr();
					}
					var text = (rtnText == ''? rtnText:rtnText.substring(0,rtnText.length-1));
					field.value = text;
					field.title = text;
				}else {
					if (rtn == '') { // 清空
						field.value = '';
						field.title = '';
						circulatorInfos[0] ='';
						$curPage.find("#_circulatorInfo").val('');
					}
				}
			}
		}
	});
}

function addCirculatorInfo(Obj,nodeId,info){
	var falg =true;
	for(var i=0;i<Obj.length;i++){
		var tmp =Obj[i];
		if(tmp.indexOf(nodeId)>0){
			Obj[i] =info;
			falg = false;
			break;
		}
	}
	if(falg){
		Obj.push(info);
	}
}

function biuldCirculatorInfoStr(){
	var result ='';
	if(circulatorInfos.length>0){
		result+='[';
	}
	for(var i=0;i<circulatorInfos.length;i++){
		result+=circulatorInfos[i]+',';
	}
	if(result.length>0){
		result = result.substring(0,result.length-1);
		result+=']';
		
		ajaxPage.getCurPage().find("input[name='_circulatorInfo']").val(result);
	}
}

function checkIsSelectCirculator(){
	var $curPage = ajaxPage.getCurPage();
	var obj = $curPage.find("#_circulator")[0];
	var _flowType = $curPage.find("#_flowType").val();
	/*if(obj && _flowType != '81'){
		if(obj.value.length<=0){
			alert("请选择抄送人！");
			return false;
		}
	}*/
	return true;
}

//流程回撤
function doRetracement() {
	var action = contextPath + '/portal/dynaform/document/retracement.action';
	ajaxPage.getCurPage().find("[name=_flowType]").val("retracement");
	ajaxPage.submitPage(action);
}

//流程终止
function terminateFlow() {

	$.confirm({
			tip : "你确定要终止流程? 终止后将不可恢复!<br/>请输入审批意见：<textarea></textarea>",
			trueCall : function(val){
				ajaxPage.getCurPage().find('[name=_attitude]').val(val);
		
				var url = contextPath + '/portal/dynaform/document/terminateFlow.action';
				ajaxPage.submitPage(url);
			},
			returnVal : true
	});
}

//流程恢复
function ev_flowRecover(nodertId){
	var url = contextPath + '/portal/dynaform/document/flowRecover.action?nodertId=' + nodertId;
	ajaxPage.submitPage(url);
}

//流程挂起
function ev_flowHandup(nodertId){
	var url = contextPath + '/portal/dynaform/document/flowHandup.action?nodertId=' + nodertId;
	ajaxPage.submitPage(url);
}

/**
 * 加签
 */
function addAuditor(){
	var docid = ajaxPage.getCurPage().find("#_docid").val();
	var url = contextPath + "/portal/share/dynaform/document/addAuditor.jsp?_docid=" + docid + "&application=" + application.value;
	var actionUrl = contextPath
	+ "/portal/dynaform/document/addAuditor.action";
	
	var oCurridArray = ajaxPage.getCurPage().find("[name='_currid']");
	// 当前节点ID
	var currid = '';
	if (oCurridArray && oCurridArray.length > 0) {
		currid = oCurridArray[0].value;
	}
	OBPM.dialog.show({
		width: 580,
		height: 400,
		url: url,
		args: {},
		title: title_addAuditor,
		close: function(result) {
			if(result){
				var map = {};
				var obj = eval('(' + result + ')');
				map[currid] = obj.userlist;
				ajaxPage.getCurPage().find("#auditorList").val(jQuery.json2Str(map));
				makeAllFieldAble();
				document.forms[0].action = actionUrl;
				document.forms[0].submit();
			}
		}
	});
}

/**
编辑审批人
*/
function editAuditor(){
	var actionUrl = contextPath	+ "/portal/dynaform/document/editAuditor.action";

	var $curPage = ajaxPage.getCurPage();
	var oCurridArray = $curPage.find("[name=_currid]");
	// 当前节点ID
	var currid = '';
	if (oCurridArray && oCurridArray.length > 0) {
		currid = oCurridArray[0].value;
	}
	// 目标文本框
	var $oFiled = $curPage.find("#auditorList");
	if ($oFiled && $oFiled.size() > 0) {
		var map = $oFiled.val() ? jQuery.parseJSON($oFiled.val()) : {};
		showUserSelectNoFlow('', {
					defValue: map[currid],
					callback: function(result) {
						// prototype1_6.js
						if (result) {
							if(result && result.length>0 && result.indexOf(';')<0){
								result = result+';';
							}
							var tUserList = new Array();
							var userlist = result.split(";");  
							
							if(userlist.length > 0){   //选择的数据
								for(var key in userlist){      
									var userid = $.trim(userlist[key]);
									if(userid != null  && userid != "" && userid != undefined ){
										tUserList.push(userid);
									}
								}
							}
							var tmpUserList = map[currid] ? map[currid] : {};  //旧数据
							if(tmpUserList.length > 0){
								for(var key in tmpUserList){
									var userid = tmpUserList[key]
									if($.trim(userid)!= null){
										var index = tUserList.toString().indexOf(userid);
										if(index == -1){
											tUserList.push(userid);
										}
									}
								}
							}
							
							// 为当前节点设置
							map[currid] = tUserList;
							$oFiled.val(jQuery.json2Str(map));
							ajaxPage.submitPage(actionUrl);
//							document.forms[0].action = actionUrl;
//							makeAllFieldAble();
//							document.forms[0].submit();
						}
					}
				});
	}
}

/**
 * 显示流程历史信息
 */
function showViewHistory(){
	ajaxPage.addHashPostfix("popUpLayer");
	var $curPage = ajaxPage.getCurPage();
	$curPage.find("#viewHistory").show();
}

function showbig(obj){
	var $curPage = ajaxPage.getCurPage();
	var showPicPanel = "<div class='showPicPanel' style='text-align: center;padding-top: 50%;position: fixed;top: 0px;left: 0px;right: 0px;bottom: 0px;background-color: rgba(0, 0, 0, 0.48);z-index: 100;'><img src='' onclick='hideBig(this);' style='background:#fff'></div>";
	$curPage.find("#viewHistory").append(showPicPanel);
	$curPage.find(".showPicPanel").find("img").attr("src",$(obj).attr("src"));
	
}
function hideBig(obj){
	var $curPage = ajaxPage.getCurPage();
	$curPage.find("#viewHistory").find(".showPicPanel").remove();
}
