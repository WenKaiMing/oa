<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@ page import="cn.myapps.core.dynaform.document.action.DocumentHelper"%>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@ page import="cn.myapps.core.workflow.engine.StateMachine" %>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@ include file="/portal/share/common/lib.jsp"%>
<%
	String contextPath = request.getContextPath();
	String appId = request.getParameter("application");
	String instanceId = request.getParameter("flowStateId");
	String contentId = request.getParameter("contentId");
	String flowName = request.getParameter("flowName");
	String docId = request.getParameter("contentId");
	
	WebUser user = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	
	int workflowType = 0;
	Document doc = (Document) user.getFromTmpspace(docId);
	if(doc!=null && doc.getState()!=null){
		workflowType = doc.getState().getWorkflowType();
	}
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<link href="<s:url value='/portal/H5/resource/css/bootstrap.min.css'/>" rel="stylesheet" type="text/css" />
<link href="<o:Url value='/resource/fonts/awesome/font-awesome.min.css'/>" rel="stylesheet" type="text/css" />
<link href="<s:url value='/portal/H5/resource/css/main.css'/>" rel="stylesheet" type="text/css" />
<script src="<s:url value='/portal/H5/resource/js/jquery-1.11.3.min.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/js/bootstrap.min.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/js/jquery.nicescroll.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/script/common.js'/>"></script>
<script>
var dateTime = new Date().getTime();
var appId = '<%=appId%>';
var _instanceId = '<%=instanceId%>';
var contentId = '<%=contentId%>';
var contextPath = '<%=contextPath%>';
var flowName = '<%=flowName%>';
var workflowType = <%=workflowType%>;

$(function(){
	if(workflowType==1) $("#workflow-history-tabs").hide();
	$.ajax({
		url:contextPath + "/portal/dynaform/document/viewFlow.action?_docid=" + contentId + "&_instanceId=" + _instanceId + "&dateTime=" + dateTime,
		success:function(result){
			var $resultPanel = $("<div></div>").append(result);
			var $txtTable = $resultPanel.find("table");
			var $workFlowPic = $resultPanel.find("img[name='flowImg']");
			var workFlowPicUrl = "../" + $workFlowPic.attr("src");
			$("#workflowimage").append($txtTable);
			$("#workflowimage").append($workFlowPic.attr("src",workFlowPicUrl));
		}
	});
	
	$.ajax({
		url:contextPath + "/portal/document/flow/getHistory.action",
		cache:false,
		dataType:"json",
		data:{"_flowStateId":_instanceId,"_applicationId":appId},
		success:function(result){
			var isComplate = result.data.isComplete;
			var historysEndNum = result.data.historys.length - 1;
			var flowStartTime = result.data.historys[0].processtime.replace("T"," ");
			var flowEndTime = result.data.historys[historysEndNum].processtime.replace("T"," ");
			var totalTime = Common.Util.daysCalc(flowStartTime,flowEndTime);
			var totalTimeContent = "耗时"
			if(totalTime.days > 0){
				totalTimeContent += totalTime.days + "天";
			}
			if(totalTime.hours > 0){
				totalTimeContent += totalTime.hours + "小时";	
			}
			if(totalTime.minutes > 0){
				totalTimeContent += totalTime.minutes + "分";
			}
			if(totalTime.seconds > 0){
				totalTimeContent += totalTime.seconds + "秒";
			}
			$(".flowhistory-totaltime").text(totalTimeContent);
			var prevNodeTime;
			
			$.each(result.data.historys,function(i,his){
				//审批节点
				var _startNodeName = his.startNodeName;
				//目标节点
				var _targetNodeName =  his.targetNodeName;
				//办理人
				var _auditorName
				if(!his.agentAuditorName){
					_auditorName = his.auditorName;
				}else{
					_auditorName = his.agentAuditorName + "<br/> (代理:"+ his.auditorName +")" ;
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
				//签核文字
				var _attitude = "";
				if(his.attitude && his.attitude!=""){
					_attitude = his.attitude;		
				}
				//签核签名
				var _signatureImageDate = "";
				if(his.signatureImageDate && his.signatureImageDate!=""){
					_signatureImageDate ="<a title='点击放大' data-image='"+his.signatureImageDate+"' class='signatureImage'>"
							 + "<img alt='点击放大' src='"+his.signatureImageDate+"'></a>";		
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

				//渲染列表
				var listHtml = "<tr><td>"+_startNodeName+"</td>"
							 +"<td>"+_auditorName+"</td>"
							 +"<td>"+_flowOperation+"</td>"
							 +"<td>"+_attitude + _signatureImageDate+"</td>"
							 +"<td>"+_time+"</td></tr>";
							 
				$("#list").find("tbody").append(listHtml);
				
				//动作图标
				
				var actionIcon = "";
				var popoverHtml = '<div class="reverse-popover"><span class="reverse-startNode">'+_startNodeName+'</span>'
								+ '<span class="reverse-line"></span>'
								+ '<span class="reverse-flowOperation"><i class="fa fa-hand-o-right" aria-hidden="true"></i> '+_flowOperation+'</span>'
								+ '<span class="reverse-line"></span>'
								+ '<span class="reverse-targetNode">'+_targetNodeName+'</span></div>';
				if(_flowOperation == "回退"){
					actionIcon = "<i class='iconfont-h5 iconfont-e058 icon-f76260' data-content='"+popoverHtml+"'></i>"
				}else if(_flowOperation == "回撤"){
					actionIcon = "<i class='iconfont-h5 iconfont-e065 icon-ffc107' data-content='"+popoverHtml+"'></i>"
				}else if(_flowOperation == "挂起"){
					actionIcon = "<i class='iconfont-h5 iconfont-e056 icon-ff6600' data-content='"+popoverHtml+"'></i>"
				}else if(_flowOperation == "恢复"){
					actionIcon = "<i class='iconfont-h5 iconfont-e057 icon-10aeff' data-content='"+popoverHtml+"'></i>"
				}else if(_flowOperation == "流转"){
					actionIcon = "<i class='iconfont-h5 iconfont-e059 icon-09bb07' data-content='"+popoverHtml+"'></i>"
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
					_prevNodeTimeContent = "最新";
				}
				prevNodeTime = _time;
				
				//渲染倒序
				var reverseHtml = "<div class='reverse-list'>"
					+ "<div class='reverse-time text-right'>"+_timeAgo+"</div>"
					+ "<div class='reverse-face text-center'>"+_avatar
					+ "<div class='text-center' style='width: 60px;'>"+_auditorName+"</div>"
					+ "<span class='reverse-face-line'></span></div>"
					+ "<div class='reverse-content'>"
					+ "<span class='reverse-prevNodeTime pull-right'>"+_prevNodeTimeContent+"</span>"
					+ _startNodeName+" "+actionIcon
					+ "<div class='reverse-txt' attitude-show='false'>"
					+ "<div class='reverse-attitude' attitude-show='false'>"+_attitude + "</div>"
					+ "<div class='reverse-attitude-arrow text-right' style='display:none'><i class='fa fa-chevron-down' aria-hidden='true'></i></div></div>"
					+ "<div class='reverse-signature'>" + _signatureImageDate+"</div></div></div>";

				$("#reverse").prepend(reverseHtml);
			});
			
			resizeHistory();
			
			$(".reverse-attitude").each(function(){
				if($(this).height()>40){
					$(this).height(40)
					$(this).next().show();
				};
			});
			
			$(".reverse-content").find("i.iconfont-h5").popover({
				html: true,
				placement: "bottom",
				trigger: "hover"
			})

		}
	});
	Common.Util.renderScroll($(".tab-pane"),{});	
	
	$(".flowhistory-tab").find("button").on("click",function(){
		$(".flowhistory-tab").find("button").removeClass("btn-default btn-success").addClass("btn-default");
		$(this).removeClass("btn-default").addClass("btn-success");
		var tid = $(this).attr("tid");
		$(".flowhistory-centent").hide();
		$("#"+tid).show();
	})	
	
	$(".tab-content").on("click",".reverse-attitude-arrow",function(){
		var $attitude = $(this).prev(".reverse-attitude");
		if($attitude.attr("attitude-show")=="false"){
		    curHeight = $attitude.height(),
		    autoHeight = $attitude.css('height', 'auto').height();
			$attitude.height(curHeight).animate({height: autoHeight},"fast",function(){
				$attitude.attr("attitude-show","true");
				$(this).next().find(".fa").removeClass("fa-chevron-down").addClass("fa-chevron-up");
			});

		}else{
			$attitude.animate({height: "40px"},"fast",function(){
				$attitude.attr("attitude-show","false");
				$(this).next().find(".fa").removeClass("fa-chevron-up").addClass("fa-chevron-down");
			});

		}
		
	});
	
	$(".tab-content").on("click",".signatureImage",function(){
		var $this = $(this);
		var signatureImage = $this.data("image");
		var $signatureImagePreview = $("#signatureImage-preview");
		$signatureImagePreview.find("img").attr("src",signatureImage);
		$signatureImagePreview.show();
	});
	
	$("#signatureImage-preview").on("click",function(){
		var $this = $(this);
		$this.hide();
	});
	
})

function resizeHistory(){
	var leave_list_num = $(".reverse-list").length;
	for(i=0;i<leave_list_num;i++){
		var $reverseFaceLine = $(".reverse-list .reverse-face-line")
		if(i==leave_list_num-1){
			$reverseFaceLine.eq(i).height(0);
		}else{
			var reverseNameH = $reverseFaceLine.eq(i).prev().outerHeight()
			$reverseFaceLine.eq(i).height($(".reverse-list .reverse-content").eq(i).height()-reverseNameH);
		}
    	
    }
}
</script>	
</head>
<body>
<div id="workflow-history-panel" role="tabpanel">
	<ul id="workflow-history-tabs" class="nav nav-tabs" role="tablist">
		<li role="presentation" class="text-center active">
			<a href="#workflowhistory" aria-controls="profile" role="tab" data-toggle="tab">
			<i class="iconfont-h5 iconfont-e061"></i> 流程历史
			</a>
		</li>
		<li role="presentation" class="text-center">
			<a href="#workflowimage" aria-controls="home" role="tab" data-toggle="tab">
			<i class="iconfont-h5 iconfont-e064"></i> 流程图
			</a>
		</li>
	</ul>
	<div class="tab-content">
		<div role="tabpanel" class="tab-pane" id="workflowimage"></div>
		<div role="tabpanel" class="tab-pane active" id="workflowhistory">
			<div class="flowhistory-tab">
				<div class="flowhistory-tab-btn btn-group pull-right" role="group" aria-label="...">
					<button tid="reverse" type="button" class="btn btn-success"><i class="iconfont-h5 iconfont-e062"></i> 时间轴</button>
					<button tid="list" type="button" class="btn btn-default"><i class="iconfont-h5 iconfont-e063"></i> 列表</button>
				</div>
			</div>
			<div id="reverse" class="flowhistory-centent active"></div>
			<div id="list" class="flowhistory-centent" style="display:none">
				<div class="flowhistory-middle">
					<table class="table table-bordered text-center">
						<tr class="active">
							<td style="min-width:100px">审批节点</td>
							<td style="min-width:100px">办理人</td>
							<td style="min-width:100px">签核动作</td>
							<td>签核意见</td>
							<td style="min-width:150px">办理时间</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="signatureImage-preview">
	<div class="signatureImage-panel">
		<div class="signatureImage-pic">
			<img src="" title="点击关闭"/>
		</div>
	</div>
</div>
</body>
</html>
</o:MultiLanguage>	