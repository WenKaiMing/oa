<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd"> -->
<%@page import="java.util.*"%>
<%@page import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="cn.myapps.core.user.action.UserUtil" %>

<%@ taglib uri="myapps" prefix="o"%>

<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
body {
	font-size: 9pt;
}

table.head {
	width: 100%;
	font: 10pt bold "Arial" normal
}

table.head td {
	background-color: #a4a4b7;
	color: #fff;
	padding: 5px;
	text-align: center;
}

table.head td.subject {
	text-align: left;
	padding: 5px 5px 5px 20px;
}

table.row {
	width: 100%;
	font: 9pt "Arial" normal;
	border-bottom: 1px #ccc dashed;
}

table.row td {
	padding: 5px;
	text-align: center;
}

table.row td.subject,table.row td a {
	cursor: pointer;
	text-align: left;
	padding: 5px 0px 5px 1px;
	color: #00f;
	text-decoration: none;
}

div.foldHead {
	border-bottom: 2px #ccc solid;
}

.app {
	padding: 10px;
}

.open {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jia+.png) 10px 20px no-repeat;
}

.close {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/jian-.png) 10px 20px no-repeat;
}

.fHeadOpen {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/foldopen.png) 10px 22px no-repeat;
}

.fHeadClose {
	padding: 20px 20px 5px 30px;
	background: url(resource/launchpad/foldclose.png) 10px 22px no-repeat;
}

#refreshBtn {
	position: absolute; right: 10px; top: 5px; 
	height:24px;
	width:24px;
	cursor: pointer;
	background:url('./resource/launchpad/refresh.png')
}
</style>
<script src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript">
	$(function() {
		//关闭缓存
		$.ajaxSetup({cache:false});
		//刷新按钮
		$("<span id='refreshBtn'></span>").css("opacity",0.2)
			.hover(function(){
				$(this).stop().fadeTo(500, 1);
			},function(){
				$(this).stop().fadeTo(500, 0.2);
			})
			.click(function(){
				$("ul").trigger("refresh");
			}
		).prependTo("body");
		
		//添加流程代办切换按钮
		var $isFlowAgent = $("#isFlowAgent");
		if($isFlowAgent !=null){
			$isFlowAgent.prependTo("body");
			$("#isFlowAgent").click(function(){
				$("ul").trigger("refresh");
			});
		}

		//添加折叠、展开按钮
		var $content = $("ul").wrap("<div class='content'></div>");
		$("<div class='app'></div>").insertBefore($content)
				.each(
						function(index) {
							$(this).text(
									$($content.get(index)).attr("_appName")
											+ ":");
						}).append("<a href='#' class='open'>{*[list.open]*}</a>").delegate(
						".open",
						"click",
						function() {
							$(this).parent().siblings(".fold").children(
									"div.foldHead").removeClass("fHeadClose")
									.addClass("fHeadOpen");
							$(this).parent().siblings(".fold").children(
									"div.foldContent").show();
						}).append("<a href='#' class='close'>{*[list.fold]*}</a>").delegate(
						".close",
						"click",
						function() {
							$(this).parent().siblings(".fold").children(
									"div.foldHead").removeClass("fHeadOpen")
									.addClass("fHeadClose");
							$(this).parent().siblings(".fold").children(
									"div.foldContent").hide();
						});

		//添加表头
		$(
				"<table class='head'><thead><tr><td class='subject'>{*[Subject]*}</td><td width='80'>{*[State]*}</td><td width='160'>{*[Current_Processor]*}</td><td width='80'>{*[flow.last_time]*}</td><td width='80'>{*[Activity]*}</td></tr></thead><tbody id='resultTbody'></tbody></table>")
				.insertBefore($content);
		$("ul").bind("refresh", function(event) {
			var $ul = $(this);
			var url = "../dynaform/work/pendingList.action?application="
				+ $ul.attr("_appId");
			url += "&_pagelines=100";
			
			//判断是否有流程代理
			var $isFlowAgent =  $("#isFlowAgent");
			if($isFlowAgent.length>0){
				var check = $isFlowAgent.get(0).checked;
				if(check != null){
					url += "&isFlowAgent="+check;
				}
			}
			
			$ul.load(url, function() {
				render($ul);
			});
		}).trigger("refresh");
	});

	function render($ul) {
		$ul.siblings("div.fold").remove();
		$ul
				.find(">li")
				.each(
						function() {
							var $li = $(this);
							//			$("<div>"+$li.attr("_formName")+"<div>").insertBefore($li);
							var id = $li.attr("_flowName");
							var $p = $("#" + id);
							if ($p.size() <= 0) {
								$p = $(
										"<div id='"+id+"' class='fold'><div class='foldHead fHeadOpen'>"
												+ $li.attr("_flowName")
												+ "</div><div class='foldContent'></div></div>")
										.delegate(
												".foldHead",
												"click",
												function() {
													if ($(this).siblings(
															".foldContent").is(
															':hidden')) {
														$(this).siblings(
																".foldContent")
																.show();
														$(this)
																.removeClass(
																		"fHeadClose")
																.addClass(
																		"fHeadOpen");
													} else {
														$(this).siblings(
																".foldContent")
																.hide();
														$(this)
																.removeClass(
																		"fHeadOpen")
																.addClass(
																		"fHeadClose");
													}
												}).insertBefore($ul);
							}

							var title = $li.text();
							var url = $li.attr("_url");
							title = title ? title : ($li.attr("_auditorNames") + $li.attr("_stateLabel"));
							title = title.length > 5 ? title.substring(0, 3)
									+ ".." + title.charAt(title.length - 1)
									: title;
									
							var deleteHtml = "";
							if ($li.attr("_isdeletable")=="true") {
								deleteHtml = "<a class='remove' _docid='"+$li.attr("_docid")+"'>[{*[Delete]*}]</a>";
							}
							
							var $row = $("<table class='row'><tr><td class='subject'>"
									+ $li.text()
									+ "</td><td width='80'>"
									+ $li.attr("_stateLabel")
									+ "</td><td width='160'>"
									+ $li.attr("_auditorNames")
									+ "</td><td width='80'>"
									+ $li.attr("_lastProcessTime")
									+ "时"
									+ "</td><td width='80' class='option'><a class='edit' href='#' _docid='"
									+ $li.attr("_docid")
									+ "' _title='"
									+ title
									+ "' _url='"
									+ $li.attr("_url")
									+ "'>[{*[Open]*}]</a>"
									+deleteHtml
									+"</td></tr></table>");
							$p.find(">div.foldContent").append($row);

							$row.find("a.edit").click(
									//点击[打开]，在新tab中打开url
									function() {
										var $a = $(this);
										var title = $a.attr('_title')
										if(!title){
											//title = $a.
										}
										parent.parent.addTab($a.attr("_docid"), title, $a
												.attr("_url"));
									});
							$row.find("a.remove").click(
									//点击[删除]，在新tab中打开url
									function() {
										if(confirm("{*[Delete]*}？")){
											var $contentDiv = $(this).closest("div.content");
											$contentDiv.find("div.fold").remove();
											var $ul = $contentDiv.find("ul");
											var $a = $(this);
											var url = "../dynaform/work/removeWork.action?application="
													+ $ul.attr("_appId")+"&_docid="+$a.attr("_docid");
											$ul.load(url, function() {
												render($ul);
											});
										}
									});
							$row.find(".subject").click(
									function() {//点击主题等同于点击打开
										$(this).closest("table").find("a.edit")
												.trigger("click");
									});
							$li.remove();
						});

		//添加总数
		$("div.foldHead").each(
				function() {
					var $this = $(this);
					if ($this.find(".total").size() > 0) {
						$this.find(".total").text(
								"("
										+ $this.siblings(".foldContent")
												.children("table.row").size() + ")");
					} else {
						$this.append("<span class='total' style='color:#f00'>("
								+ $this.siblings(".foldContent").children("table.row")
										.size() + ")</span>");
					}
				});
	}
</script>
</head>
<body>
	<%
		WebUser user = (WebUser) session
				.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		
		//判断用户是否属于流程代理人
		UserUtil userUtil = new UserUtil();
		boolean flag = userUtil.isFlowAgent(user);
		
		if(flag){
			out.println("<input type='checkbox' id='isFlowAgent'>{*[front.workflowcenter.agent_for_display]*}</input>");
		}
		
		ApplicationProcess process = (ApplicationProcess)ProcessFactory.createProcess(ApplicationProcess.class);
		Collection<ApplicationVO> appList = process.queryAppsByDomain(user.getDomainid(),1,Integer.MAX_VALUE);
		
		for (ApplicationVO applicationVO : appList) {
			if (!applicationVO.isActivated())
				continue;
			String applicationId = applicationVO.getId();
			out.println("<ul refreshId='" + applicationId + "' _appId='" + applicationId + "' _appName='"
					+ applicationVO.getName() + "'>");

			out.println("Loading......</ul>");
		}
	%>
</body>
</html>
</o:MultiLanguage>