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
<link href="./resource/jquery/jquery-ui.min.css" rel="stylesheet">
<link href="./resource/jquery/obpm.paging.css" rel="stylesheet">
<style>
body {
	font-size: 9pt;
}

#resultTable {
	width: 100%;
}

.head td {
	font: 10pt "Arial" normal;
	background-color: #a4a4b7;
	color: #fff;
	padding: 5px;
	text-align: center;
}

.head td.subject {
	text-align: left;
	padding: 5px 5px 5px 20px;
}

.row td.subject {text-align:left}

.row td {
	padding: 5px;
	text-align: center;
	font: 9pt "Arial" normal;
	border-bottom: 1px #ccc dashed;
}

.row td.subject a,.row td a {
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
.btn-group .btn-green.active {
    color: #fff;
    background-color: #22aae9;
}
.btn-group .btn-green{
	border: 1px solid rgb(169, 169, 169);
    background: #e6e6e6;
}

.myStartBtn {
	float: left;
    width: 95px;
    border: 1px solid #aaa;
    text-align: center;
    cursor: pointer;
    height: 20px;
    position:relative;
}

.myStartBtn input {
    cursor: pointer;
    margin: 0px 4px 0 4px;
    position: absolute;
    top: 50%;
    left: 0;
    margin-top: -6px;
	*margin-top: -10px;
}

.myStartBtn span {
	-moz-user-select:none;/*firefox*/
	-webkit-user-select:none;/*webkit chrome*/
	-ms-user-select:none;/*IE10*/
	-khtml-user-select:none;/*old borwer*/
	user-select:none;
	vertical-align: top;
}
#searchForm select{
	height:22px; 
	line-height:18px; 
	padding:2px 0;
	max-width: 220px;
}
</style>

<script type="text/javascript" >
var front_total = '{*[front.total]*}';
</script>
<script type="text/javascript" src="./resource/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="./resource/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="./resource/jquery/obpm.paging.js"></script>
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
		$("#searchBtn").button().click(function() {
			loadResult();
			return false;
		});
		//绑定流程查询
		$("#app").bind("change", function(){
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
			loadResult();
		}).trigger("change");
		
		$("#_flowId").bind("click",function(){
			loadResult();
		});
	});

	function loadResult() {
		//添加软件名称
		var $app = $("#app"), url = "../dynaform/work/historyList.action?application="
				+ $app.val(), $result = $("#searchResult");
		// 清除旧的结果
		$("#resultTable").remove();
		//添加表头
		$(
				"<table id='resultTable'><thead><tr class='head'><td class='subject'>{*[Subject]*}</td><td width='80'>{*[Flow]*}</td><td width='80'>{*[State]*}</td><td width='80'>{*[flow.last_time]*}</td><td width='80'>{*[Activity]*}</td></tr></thead><tbody id='resultTbody'></tbody></table>")
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
							title = title ? title : ($li.attr("_flowName") + $li.attr("_stateLabel"));
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
											+ "</td><td width='80'>"
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
	<s:bean
		name="cn.myapps.core.deploy.application.action.ApplicationHelper"
		id="applicationHelper" />
	<s:form id="searchForm" name="formList" method="post" theme="simple">
		<input id="isMyWorkFlow" name="_isMyWorkFlow" type="hidden" value="" style="position:relative;top:3px;">
		<div class="btn-group" role="group" style="float:left;margin-right:20px;margin-top: 2px;">
   			<div id="myStartBtn" class="myStartBtn">
			   	<input type="checkbox" name="myStart" value="1"/>
				<span style="line-height:22px">{*[front.i.started]*}</span>
			</div>
        </div>
		{*[Application]*}:<s:select id="app" name="applicationid"
		list="%{#applicationHelper.getListByWebUser(#session.FRONT_USER)}"
		listKey="id" listValue="name" />
		{*[front.workflow.name]*}:<select id="_flowId" name="_flowId" class="btn btn-default btn-lg active"  ></select>
		{*[Subject]*}:<input type="text" name="_subject" id="_subject" style="padding-top:2px;margin-top:2px;"
size="10" value='<s:property value="#parameters._subject"/>'>
		<input id="_currpage" type="hidden" name="_currpage" value="1" />
		<input id="_pagelines" type="hidden" name="_pagelines" value="100" />
		<button id='searchBtn' style="top: -3px;">{*[Search]*}</button>
	</s:form>
	<div id="searchResult">Loading...</div>
</body>
	</html>
</o:MultiLanguage>