<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd"> -->
<%@page import="java.util.*"%>
<%@page
	import="cn.myapps.core.deploy.application.action.ApplicationHelper"%>
<%@page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingVO"%>
<%@page import="cn.myapps.core.dynaform.pending.ejb.PendingProcessBean"%>
<%@page import="cn.myapps.base.dao.DataPackage"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="java.text.SimpleDateFormat"%>
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
				//location.reload();
				$("ul").trigger("refresh");
			}).prependTo("body");

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
				"<table class='head'><thead><tr class='head'><td class='subject'>{*[Subject]*}</td><td width='80'>{*[State]*}</td><td width='160'>{*[Current_Processor]*}</td><td width='80'>{*[flow.last_time]*}</td><td width='80'>{*[Activity]*}</td></tr></thead><tbody id='resultTbody'></tbody></table>")
				.insertBefore($content);
		
		$("ul").bind("refresh", function(event) {
			var $ul = $(this);
			var url = "../dynaform/work/processedList.action?application="
					+ $ul.attr("_appId");
			
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
							var $row = $("<table class='row'><tr><td class='subject'>"
									+ $li.text()
									+ "</td><td width='80'>"
									+ $li.attr("_stateLabel")
									+ "</td><td width='160'>"
									+ $li.attr("_auditorNames")
									+ "</td><td width='80'>"
									+ $li.attr("_lastProcessTime")
									+ "时"
									+ "</td><td width='80' class='option'><a href='#' _docid='"
									+ $li.attr("_docid")
									+ "' _title='"
									+ title
									+ "' _url='"
									+ $li.attr("_url")
									+ "'>[{*[Open]*}]</a></td></tr></table>");
							$p.find(">div.foldContent").append($row);

							$row.find("a").click(
									//点击打开，在新tab中打开url
									function() {
										var $a = $(this);
										parent.parent.addTab($a.attr("_docid"), $a
												.attr("_title"), $a
												.attr("_url"));
									});
							$row.find(".subject").click(
									function() {//点击主题等同于点击打开
										$(this).closest("tr").find("a")
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