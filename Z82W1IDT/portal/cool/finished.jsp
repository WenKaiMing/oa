<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
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

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="./resource/jquery-ui-1.11.1.custom/jquery-ui.css" rel="stylesheet">
<link href="./resource/jquery/obpm.paging.css" rel="stylesheet">
<style>
body {
	font-size: 9pt;
	padding: 0px 30px 30px 30px;
}

.row td.subject {text-align:left}

.row td {
	text-align: center;
	font: 9pt "Arial" normal;
	border-bottom: 1px #ccc solid;
}

.row td.subject a,.row td a {
	cursor: pointer;
	text-align: left;
	padding: 5px 5px 5px 30px;
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
	position: absolute;
	right: 30px;
	top: 5px; 
	height:24px;
	width:24px;
	cursor: pointer;
	background:url('./resource/launchpad/refresh.png')
}

.content {
	font-size: 18px;
	font-family: Microsoft YaHei, tahoma, arial;
	margin-top: 40px;
}

.app1 {
    height: 36px;
    border: 2px solid #5cbad8;
}

.app2 {
    height: 36px;
    border: 2px solid #5cbad8;
}

.subject1 {
    height: 30px;
    _height: 36px;
    width: 200px;
    border: 2px solid #5cbad8;
    background-repeat: no-repeat;
	vertical-align: middle;
	font-size: 16px;
	color: #666;
	font-family: Microsoft YaHei, tahoma, arial;
	padding-left: 5px;
	padding-right: 5px;
	_padding-top: 5px;
}

.subject1:FOCUS {
	background-image: none;
}

#searchBtn {
	background-color: #6bc2dc;
	background-image: none;
	margin-left: -5px;
	border: 1px solid #6bc2dc;
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px;
	vertical-align: middle;
	width: 84px;
	height: 36px;
	line-height: 30px;
	font-size: 16px;
	padding: 0px 0px;
	color: #fff;
	font-family: Microsoft YaHei, tahoma, arial;
	cursor: pointer;
}

#resultTable {
	width: 100%;
	margin-top: 13px;
	border-radius: 2px;
	border-top: 1px solid #d2d2d2;
}

#resultTable thead {
}

#resultTable thead td {
	border-radius: 2px;
	border-bottom: 1px solid #d2d2d2;
	font-family: Microsoft YaHei, tahoma, arial;
	height: 40px;
	line-height: 40px;
	font-size: 16px;
	background-color: #f7f7f7;
	color: #666;
	font-weight: bold;
	text-align: center;
}

#resultTable thead  td.subject {
	text-align: left;
	padding-left: 20px;
	border-left: 1px solid #d2d2d2;
}

#resultTable thead  td.lasthead {
	border-right: 1px solid #d2d2d2;
}

#resultTable td {
	height: 40px;
	line-height: 40px;
	font-family: Microsoft YaHei, tahoma, arial;
	font-size: 14px;
	color: #666;
}

#resultTable td.subject a {
	color: #666;
}

.content .searchDiv {
	height: 40px;
	line-height: 40px;
}

/**下拉框样式优化-start**/
.content .searchDiv .ui-state-default .ui-icon {
	background-image: url("resource/launchpad/finished_pic1.png");
	right: 0px;
	margin-top: 0px;
	top: 0px;
	background-color: #fff;
}

.content .searchDiv .ui-icon-triangle-1-s {
	background-position:0px 0px;
	background-color: #fff;
}

.content .searchDiv .ui-icon {
	width: 36px;
	height: 36px;
	background-color: #fff;
}

.content .searchDiv .ui-state-default{
	width: 200px!important;
	height: 32px;
	_height: 36px;
	border: 2px solid #6bc2dc;
	background-image: none;
	background-color: #fff;
	border-radius: 0;
	vertical-align: middle;
}

.content .searchDiv .ui-selectmenu-text {
	color: #666;
	line-height: 30px;
	padding: 0px 0 0 15px;
}

.content .searchDiv .ui-selectmenu-text:HOVER {
	color: #666;
}

.content .searchDiv .ui-state-focus, .ui-widget-content .ui-state-focus {
	background: none;
	font-weight: bold;
	color: #666;
}

.ui-widget-content .ui-state-focus {
	border: none;
}
.searchDiv .btn-group .btn-green.active {
    color: #fff;
    background-color: #22aae9;
}
.searchDiv .btn-group .btn-green{
	border: 2px solid #6bc2dc;
    background: #fff;
}
/**下拉框样式优化--end**/

.myStartBtn {
	border: 2px solid #5cbad8;
    cursor: pointer;
    height: 30px;
    padding: 2px 4px 0 4px;
    line-height: 30px;
}

.myStartBtn input {
	cursor: pointer;
    margin: 0 4px 0 4px;
}

.myStartBtn span {
	-moz-user-select:none;/*firefox*/
	-webkit-user-select:none;/*webkit chrome*/
	-ms-user-select:none;/*IE10*/
	-khtml-user-select:none;/*old borwer*/
	user-select:none;
}
</style>

<script type="text/javascript" >
var front_total = '{*[front.total]*}';
</script>
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery-ui-1.11.1.custom/jquery-ui.min.js"></script>
<script type="text/javascript" src="./resource/jquery/obpm.paging.js"></script>
<script type="text/javascript">
function getFlowByApp(){
	var $app = $("#app"), url = "../dynaform/work/getFlowListByApplication.action";
	
	$.ajax({url : url,
		data : {applicationId : $app.val()},
		dataType : "json",
		success : function(data){
			if(data != null && data.length > 0){
				var $flowId = $("#_flowId");
				$flowId.html("").append("<option value='' ></option>");
				for(var i=0; i<data.length; i++){
					var jsonF = data[i];
					$flowId.append("<option value='" + jsonF.id + "' >" + jsonF.name + "</option>");
				}
			}
		}
	});
}

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
				location.reload();
			}).prependTo("body");
		//选择创办还是经办
		$("#myStartBtn").click(function() {
			var $input = $(this).find("input");
			if($input.prop("checked")){
				$input.removeProp("checked");
			}else{
				$input.prop({checked : "checked"});
			}
			if($input.prop("checked")){
				$("#isMyWorkFlow").val($input.val());
			}else{
				$("#isMyWorkFlow").val("");
			}
			loadResult();
			return false;
		});
		$("#myStartBtn input").bind("click", function(event) {
			event.stopPropagation();
			var $input = $(this);
			if($input.prop("checked")){
				$("#isMyWorkFlow").val($input.val());
			}else{
				$("#isMyWorkFlow").val("");
			}
			loadResult();
		});
		//绑定查询按钮
		$("#searchBtn").click(function() {
			loadResult();
			return false;
		});
		
		//绑定流程查询
		$(".app1").selectmenu({
			change : function(){
				getFlowByApp();
				loadResult();
			}
		});
		
		$("#_flowId").bind("click",function(){
			loadResult();
		});

		getFlowByApp();		
		loadResult();
	});

	function loadResult() {
		//添加软件名称
		var $app = $("#app"), url = "../dynaform/work/historyList.action?application="
				+ $app.val(), $result = $("#searchResult");
		// 清除旧的结果
		$("#resultTable").remove();
		//添加表头
		$(
				"<table id='resultTable' cellpadding='0' cellspacing='0'><thead><tr class='head'><td class='subject'>{*[Subject]*}</td><td width='80'>{*[Flow]*}</td><td width='80'>{*[State]*}</td><td width='100'>{*[flow.last_time]*}</td><td width='80' class='lasthead'>{*[Activity]*}</td></tr></thead><tbody id='resultTbody'></tbody></table>")
				.insertBefore($result);
		$result.load(url, $("#searchForm").serializeArray(), function() {
			render($result);
		});
	}

	function render($ul) {
		var $resultTbody = $("#resultTbody");

		$ul.find("#paging").obpmPaging(function(pageNow) {
			$("#_currpage").val(pageNow);
			loadResult();
		});

		$ul
				.find(">li")
				.each(
						function() {
							var $li = $(this);
							var title = $li.text();
							var url = $li.attr("_url");
							title = title.length == 0 ? "..." : title;
							title = title.length > 5 ? title.substring(0, 3)
									+ ".." + title.charAt(title.length - 1)
									: title;
							var $row = $(
									"<tr class='row'><td class='subject'>"
											+ $li.text()
											+ "</td><td width='120'>"
											+ $li.attr("_flowName")
											+ "</td><td width='80'>"
											+ $li.attr("_stateLabel")
											+ "</td><td width='100'>"
											+ $li.attr("_lastProcessTime")
											+ "时"
											+ "</td><td width='80' class='option'><a href='#' _docid='"
											+ $li.attr("_docid") + "' _title='"
											+ title + "' _url='"
											+ $li.attr("_url")
											+ "'>[{*[Open]*}]</a></td></tr>")
									.appendTo($resultTbody);

							$row.find("a").click(
									//点击打开，在新tab中打开url
									function() {
										var $a = $(this);
										parent.parent.addTab($a.attr("_docid"), $a
												.attr("_title"), $a
												.attr("_url"));
									});

							$row.find(".subject").wrapInner("<a href='#'></a>")
							.click(
									function() {//点击主题等同于点击打开
										$(this).closest("tr").find(".option a")
												.trigger("click");
									});
							$li.remove();
						});
	}
</script>
</head>
<body>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="applicationHelper" />
<div class="content">
	<form id="searchForm" name="formList">
		<div class="searchDiv">
			<input id="isMyWorkFlow" name="_isMyWorkFlow" type="hidden" value="">
			<div class="btn-group" role="group" style="float:left;margin-top: 4px;">
	   			<div id="myStartBtn" class="myStartBtn">
				   	<input type="checkbox" name="myStart" value="1"/>
					<span>{*[front.i.started]*}</span>
				</div>
            </div>
            
			<span class="label">{*[Application]*}:</span>
			<s:select id="app" cssClass="app1" name="applicationid"	list="%{#applicationHelper.getListByWebUser(#session.FRONT_USER)}"
				listKey="id" listValue="name" />
			
			<span class="label">{*[front.workflow.name]*}:</span>
			<select id="_flowId" name="_flowId" class="app2"  ></select>
			
			<span class="label">{*[Subject]*}:</span>
			<input type="text" name="_subject" id="_subject" class="subject1" size="10" value='<s:property value="#parameters._subject"/>'></input>
			<input type="button" id="searchBtn" value="{*[Search]*}">
			<input id="_currpage" type="hidden" name="_currpage" value="1" />
			<input id="_pagelines" type="hidden" name="_pagelines" value="100" />
		</div>
	</form>
	<div id="searchResult">Loading...</div>
</div>
</body>
	</html>
</o:MultiLanguage>