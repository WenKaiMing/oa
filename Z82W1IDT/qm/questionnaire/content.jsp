<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@include file="/common/taglibs.jsp"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../css/theme.css" rel="stylesheet" type="text/css">
<link href="../css/contentstyle.css" rel="stylesheet" type="text/css">
<link href="../css/list.css" rel="stylesheet" type="text/css">
<title>问卷内容</title>
</head>

<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/Math.uuid.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.questionnaire.js"></script>

<script type="text/javascript" src="../js/qm.upload.js"></script>
<script type="text/javascript" src="../js/webuploader/webuploader.js"></script>
<link rel="stylesheet" type="text/css" href="../js/webuploader/webuploader.css">

<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>

<link href="../js/toastr/toastr.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../js/toastr/toastr.min.js"></script>	

<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			//初始化发布窗口
			init_scope();
			
			//初始化问卷
			QM.questionnaire.init($("#aaaa").val(), "");
			//计算div#main的高度
			$("#main").height($("body").height()-$(".box").height()-65);
			//问卷发布框
			$('.theme-login').click(function() {
				$('.theme-popover-main').show();
				$('.theme-popover-mask').fadeIn(100);
				if($(this).text()=="发布"){
					if($("#content_title").val() == ""){
						$('.theme-popover-main').hide();
						Common.Util.showMessage("问卷标题未设置", "warning");
					}else{
						$('#publishDialog').slideDown(200);
					}
				}
				keepHide();
			})
			$('#publishDialog .theme-poptit .close').click(
					function() {
						$('.theme-popover-main').hide();
						$('.theme-popover-mask').fadeOut(100);
						$('#publishDialog').slideUp(200);
						keepShow();
					});

			//标题内容编辑框
			$('#title').click(function() {

				//标题赋值
				var $e_title = $("#e_title");
				var $span = $("#content_title");
				$e_title.val($span.val());

  			    $e_title.on("keydown",function(event){
					if (event.keyCode == 13) {
		        		doEdit();
		        		event.stopPropagation();
		        		event.preventDefault();
		    		}
				});
				

				//描述赋值
				var $e_explains = $("#e_explains");
				var $span2 = $("#content_explains");
				$e_explains.val($span2.val());

				$('.theme-popover-main').show();
				$('.theme-popover-mask').fadeIn(100);
				$('#titleDialog').slideDown(200);
			})
			
			$("#clear1User").click(function(){
				$(".user1Select").find("#userHidden").val("");
				$(".user1Select").find("#userInput").val("");
			});
			
			$("#clear2User").click(function(){
				$(".user2Select").find("#roleHidden").val("");
				$(".user2Select").find("#roleInput").val("");
			});
			
			$("#clear3User").click(function(){
				$(".user3Select").find("#deptHidden").val("");
				$(".user3Select").find("#deptInput").val("");
			});
			
			$('#titleDialog .theme-poptit .close').click(
					function() {
						$('.theme-popover-main').hide();
						$('.theme-popover-mask').fadeOut(100);
						$('#titleDialog').slideUp(200);
					});


			$("#back").click(function() {
				if($("#_back_url_homepage").val() !="" && $("#_back_url_homepage").val() == "HOMEPAGE"){
					document.forms[0].action = contextPath+"/qm/answer/index.jsp";
					document.forms[0].submit();
				}else{
					
					document.forms[0].action = 'list.action';
					document.forms[0].submit();
				}
			});

			$('#nav-menu .menu > li').hover(function() {
				$(this).find('.children').animate({
					opacity : 'show',
					height : 'show'
				}, 200);
				$(this).find('.xialaguang').addClass('navhover');
			}, function() {
				$('.children').stop(true, true).hide();
				$('.xialaguang').removeClass('navhover');
			});

			$('#nav-menu .menu .stmenu').click(function() {
				var type = $(this).attr("type");
				QM.questionnaire.addQ(type);
			});

			jQuery("#formList_content_scopeuser").click(function() {
				jQuery("#userTr").css("display", "");
				jQuery("#roleTr").css("display", "none");
				jQuery("#deptTr").css("display", "none");

				//清除角色信息
				jQuery("#roleInput").attr("title", "");
				jQuery("#roleInput").val("");
				jQuery("#roleHidden").val("");
				//清除部门信息
				jQuery("#deptInput").attr("title", "");
				jQuery("#deptInput").val("");
				jQuery("#deptHidden").val("");
			});
			jQuery("#formList_content_scoperole").click(function() {
				jQuery("#roleTr").css("display", "");
				jQuery("#userTr").css("display", "none");
				jQuery("#deptTr").css("display", "none");

				//清除用户信息
				jQuery("#userInput").attr("title", "");
				jQuery("#userInput").val("");
				jQuery("#userHidden").val("");
				//清除部门信息
				jQuery("#deptInput").attr("title", "");
				jQuery("#deptInput").val("");
				jQuery("#deptHidden").val("");
			});
			jQuery("#formList_content_scopedept").click(function() {
				jQuery("#deptTr").css("display", "");
				jQuery("#userTr").css("display", "none");
				jQuery("#roleTr").css("display", "none");
				//清除用户信息
				jQuery("#userInput").attr("title", "");
				jQuery("#userInput").val("");
				jQuery("#userHidden").val("");
				//清除角色信息
				jQuery("#roleInput").attr("title", "");
				jQuery("#roleInput").val("");
				jQuery("#roleHidden").val("");
			});
			jQuery("#formList_content_scopedeptAndrole").click(
					function() {
						jQuery("#deptTr").css("display", "");
						jQuery("#userTr").css("display", "none");
						jQuery("#roleTr").css("display", "");
						//清除用户信息
						jQuery("#userInput").attr("title", "");
						jQuery("#userInput").val("");
						jQuery("#userHidden").val("");

					});
			//初始化遮罩层
			init_keep();
			$(".doRecover").click(function(){//回收问卷
				Common.Util.showMask();
	        	var target = $(this).attr("data-target");
	        	var $id = $("[name='content.id']").val();
	        	$(target).find("#doRecoverId").val($id);
	        	return $(target).show();
	        
	        });
			$(".close-popup,.btn-cancel").click(function() {//关闭弹出层的钮点击事件
				$('.theme-popover-main').hide();
				$('.theme-popover-mask').fadeOut(100);
				$('#titleDialog').slideUp(200);
	            return Common.Util.hidePop();
	        });
			$("#redoRecover").unbind().click(function() {//弹出层的回收按钮点击事件
				Common.Util.hidePop();
	            doRecover($("#doRecoverId").val());
	        });
		});

function init_scope(){
var scope = '<s:property value="content.scope"/>';
var ownerNames = '<s:property value="content.ownerNames"/>';
var ownerIds = '<s:property value="content.ownerIds"/>';
if(scope =='role'){
jQuery("#roleTr").css("display","");
jQuery("#userTr").css("display","none");
jQuery("#deptTr").css("display","none");
jQuery("#roleInput").val(ownerNames);
jQuery("#roleHidden").val(ownerIds);
}else if(scope =='user'){
jQuery("#userTr").css("display","");
jQuery("#roleTr").css("display","none");
jQuery("#deptTr").css("display","none");
jQuery("#userInput").val(ownerNames);
jQuery("#userHidden").val(ownerIds);
}else if(scope =='dept'){
jQuery("#deptTr").css("display","");
jQuery("#roleTr").css("display","none");
jQuery("#userTr").css("display","none");
jQuery("#deptInput").val(ownerNames);
jQuery("#deptHidden").val(ownerIds);
}else if(scope =='deptAndrole'){
jQuery("#deptTr").css("display","");
jQuery("#roleTr").css("display","");
jQuery("#userTr").css("display","none");
var ownerId = ownerIds.split(";;");
var ownerName = ownerNames.split(";;");
jQuery("#deptInput").val(ownerName[0]);
jQuery("#deptHidden").val(ownerId[0]);
jQuery("#roleInput").val(ownerName[1]);
jQuery("#roleHidden").val(ownerId[1]);
}
}

/*
* 发布校验
*/
function checkout(){
var u_ownerNames = document.getElementsByName("u_ownerNames")[0].value;
var r_ownerNames = document.getElementsByName("r_ownerNames")[0].value;
var d_ownerNames = document.getElementsByName("d_ownerNames")[0].value;
var scope = jQuery("input[name='content.scope']:checked")[0].value;
if(scope=="user" && u_ownerNames.length<=0){
alert("请选择用户");
return;
}
if(scope=="role" && r_ownerNames.length<=0){
alert("请选择角色");
return;
}
if(scope=="dept" && d_ownerNames.length<=0){
alert("请选择部门");
return;
}
if(scope=="deptAndrole" && (d_ownerNames.length<=0 || r_ownerNames.length<=0)){
alert("请同时选择部门和角色");
return;
}
ev_publish();
}

function doSave() {
	
	var json = QM.questionnaire.encodeJson();
	var $content = $("#aaaa");
	$content.val(json);
	//document.forms[0].submit();
	//Common.Util.showMessage("保存成功", "success");
	var params = $("#formList").serialize();
	$.ajax({
		url: contextPath + "/qm/questionnaireservice/save.action",
		type:"POST",
		async: false,
	    data: params ,
		success: function(result){
			if(result && result.status == 1){
				var q = result.data;
				$("input[name='content.id']").val(q.id);
				Common.Util.showMessage("保存成功", "success");
			}
			else{
				Common.Util.showMessage("保存失败","error");
			}
		}
	});
}

/**
 * 再次编辑问卷
 */
function doRebuild(){
	if(confirm("改问卷已经发布过，如果再次编辑将清除已作答问卷，是否继续?")){
		document.forms[0].action = "rebuild.action";
		document.forms[0].submit();
	}
}

/**
 * 回收问卷
 */
function doRecover(id){
	$.ajax({
	    type: 'POST',
	    url: "recover.action",
	    data: {'id':id} ,
	    dataType:"html",
	    success:function(data){
			if(data){
				if(data.indexOf("SUCCESS") >= 0){
					//alert("回收成功");
					window.location.href = "list.action";
				}
			}else{
				Common.Util.showMessage("回收失败", "error");
			}
		},
		error:function(data,status){
			//alert("failling to visited...");
			Common.Util.showMessage("failling to visited...", "warning");
		}
	});
}

/**
 * 发布问卷
 */
function ev_publish() {
/* var scope = document.getElementsByName("content.scope")[0].checked; */
var scope = jQuery("input[name='content.scope']:checked")[0].value;
if(scope == "user"){
document.getElementsByName("content.ownerIds")[0].value = document.getElementById("userHidden").value;
document.getElementsByName("content.ownerNames")[0].value = document.getElementById("userInput").value;
}else if(scope == "role"){
document.getElementsByName("content.ownerIds")[0].value = document.getElementById("roleHidden").value;
document.getElementsByName("content.ownerNames")[0].value = document.getElementById("roleInput").value;
}else if(scope == "dept"){
document.getElementsByName("content.ownerIds")[0].value = document.getElementById("deptHidden").value;
document.getElementsByName("content.ownerNames")[0].value = document.getElementById("deptInput").value;
} else if(scope == "deptAndrole"){
document.getElementsByName("content.ownerIds")[0].value = document.getElementById("deptHidden").value + ";;" +  document.getElementById("roleHidden").value;
document.getElementsByName("content.ownerNames")[0].value = document.getElementById("deptInput").value + ";;" + document.getElementById("roleInput").value;
}
var json = QM.questionnaire.encodeJson();
var $content = $("#aaaa");
$content.val(json);

document.forms[0].action = "publish.action";
document.forms[0].submit();
/* if($("#_back_url_homepage").val() !="" && $("#_back_url_homepage").val() == "HOMEPAGE"){
	document.forms[0].action = contextPath+"/qm/answer/index.jsp";
	document.forms[0].submit(); 
}else{
	document.forms[0].action = "publish.action";
	document.forms[0].submit();
} */
var params = $("#formList").serialize();
$.ajax({
	url: "publish.action",
	async: false,
    data: params ,
	success: function(result){
		if($("#_back_url_homepage").val() !="" && $("#_back_url_homepage").val() == "HOMEPAGE"){
			window.location.href = contextPath+"/qm/answer/index.jsp";
		}else{
			window.location.href = contextPath+"/qm/questionnaire/list.jsp";
		} 
	}
});
}

function doEdit() {
	//标题赋值
	var $e_title = $("#e_title");
	var value = $e_title.val();
	var $content_title = $("#content_title");
	$content_title.val(value);
	
	var $span = $("#title").find("div").eq(0);
	$span.text(value);
	
	//说明赋值
	var $e_explains = $("#e_explains");
	var value2 = $e_explains.val();
	var $content_explain = $("#content_explains");
	$content_explain.val(value2);
	
	var $span2 = $("#title").find("div").eq(1);
	$span2.text(value2);
	
	$('.theme-popover-main').hide();
	$('.theme-popover-mask').fadeOut(100);
	$('#titleDialog').slideUp(200);
}


/**
 * 预览问卷/打印问卷
 */
function preview() 
{ 
	var json = QM.questionnaire.encodeJson();
	$("#previewPrint").find("input[name='previewId']").val($("#formList_content_id").attr("value"));
	$("#previewPrint").find("input[name='previewTitle']").val($("#content_title").val());
	$("#previewPrint").find("input[name='previewText']").val(json);
	$("#previewPrint").submit();
} 


/**
* 选择部门 for QM
* 
* @param {}
*            actionName
* @param {}
*            settings
*/
function selectUser4Qm(actionName, settings, roleid) {
var url = contextPath + "/qm/questionnaire/selectUserByAll4Qm.jsp";
var setValueOnSelect = true;
if (settings.setValueOnSelect == false) {
setValueOnSelect = settings.setValueOnSelect;
}
var title = "选择用户";

OBPM.dialog.show({
opener : window.top,
width : 690,
height : 500,
url : url,
args : {
	// p1:当前窗口对象
	"parentObj" : window,
	// p2:存放userid的容器id
	"targetid" : settings.valueField,
	// p3:存放username的容器id
	"receivername" : settings.textField,
	// p4:默认选中值, 格式为[userid1,userid2]
	"defValue" : settings.defValue,
	//选择用户数
	"limitSum" : settings.limitSum,
	//选择模式
	"selectMode" : settings.selectMode,
	// 存放userEmail的容器id
	"receiverEmail" : settings.showUserEmail
},
title : title,
maximized : false, // 是否支持最大化
close : function(result) {
}
});
}

/**
* 选择角色 for QM
* 
* @param {}
*            actionName
* @param {}
*            settings
*/
function selectRole4Qm(actionName, settings, roleid) {
var url = contextPath + "/qm/questionnaire/selectrolelist4Qm.jsp";
var setValueOnSelect = true;
if (settings.setValueOnSelect == false) {
	setValueOnSelect = settings.setValueOnSelect;
}
var title = "选择角色";
if(settings.title){title = settings.title;}

OBPM.dialog.show({
		opener : window.top,
		width : 300,
		height : 400,
		url : url,
		args : {
			// p1:当前窗口对象
			"parentObj" : window,
			// p2:存放userid的容器id
			"targetid" : settings.valueField,
			// p3:存放username的容器id
			"receivername" : settings.textField,
			// p4:默认选中值, 格式为[userid1,userid2]
			"defValue": settings.defValue,
			//选择用户数
			"limitSum": settings.limitSum,
			//选择模式
			"selectMode":settings.selectMode,
			// 存放userEmail的容器id
			"receiverEmail" : settings.showUserEmail
		},
		title : title,
		maximized: false, // 是否支持最大化
		close : function(result) {
			if(result && result.indexOf("|")>0){
				if(result && result.length>0){
					var roleIds ="";
					var roleNames = "";
					var _rtn = result.split(",");
					for(var i=0;i<_rtn.length;i++){
						var r = _rtn[i].split("|");
						roleIds+=r[0]+";";
						roleNames+=r[1]+";";
					}
					if(roleIds.length>0){
						roleIds = roleIds.substring(0, roleIds.length-1);
					}
					if(roleNames.length>0){
						roleNames = roleNames.substring(0, roleNames.length-1);
					}
					jQuery("#roleInput").attr("value",roleNames);
					jQuery("#roleHidden").attr("value",roleIds);
				}
			}
		}
	});
}

/**
* 选择部门 for QM
* 
* @param {}
*            actionName
* @param {}
*            settings
*/
function selectDept4Qm(actionName, settings, roleid) {
var url = contextPath + "/qm/questionnaire/selectDeptByAll4Qm.jsp";
var setValueOnSelect = true;
if (settings.setValueOnSelect == false) {
	setValueOnSelect = settings.setValueOnSelect;
}
var title = "选择部门";
if(settings.title){title = settings.title;}

OBPM.dialog.show({
			opener : window.top,
			width : 450,
			height : 350,
			url : url,
			args : {
				// p1:当前窗口对象
				"parentObj" : window,
				// p2:存放userid的容器id
				"targetid" : settings.valueField,
				// p3:存放username的容器id
				"receivername" : settings.textField,
				// p4:默认选中值, 格式为[userid1,userid2]
				"defValue": settings.defValue,
				//选择用户数
				"limitSum": settings.limitSum,
				//选择模式
				"selectMode":settings.selectMode,
				// 存放userEmail的容器id
				"receiverEmail" : settings.showUserEmail
			},
			title : title,
			maximized: false, // 是否支持最大化
			close : function(result) {
			}
		});
}

function keepShow(){
	var status = $("input[name='content.status']").val();
	if(status == 0){
		return;
	}
	$("div[name='keep']").show();
	$("#maiDiv").children("div").removeClass("hover");
}

function keepHide(){
	$("#keep").hide();
}

//初始化遮罩层
function init_keep(){
	$("div[name='keep']").each(function(){
		var $parent = $(this).parent();
		$(this).height($parent.height());
	});
	keepShow();
}
</script>
<body>
	<s:form id="formList" name="formList" action="save.action"
		method="post" theme="simple">

		<s:hidden name="content.id" />
		<s:hidden name="content.status" />
		<s:hidden name="content.actorIds" />
		<s:hidden name="content.actorNames" />
		<s:hidden name="content.creator" />
		<s:hidden name="content.creatorName" />
		<s:hidden name="content.status" />
		<s:hidden name="content.ownerIds" />
		<s:hidden name="content.ownerNames" />
		<s:hidden name="content.creatorDeptId" />
		<s:hidden name="content.creatorDeptName" />
		<input type="hidden" id="_back_url_type" name="type" value="<s:property value='#parameters.type' />" />
		<input type="hidden" id="_back_url_status" name="status" value="<s:property value='#parameters.status' />" />
		<input type="hidden" id="_back_url_currpage" name="_currpage" value="<s:property value='#parameters._currpage' />" />
		<input type="hidden" id="_back_url_pagelines" name="_pagelines" value="<s:property value='#parameters._pagelines' />" />
		<input type="hidden" id="_back_url_homepage" name="s_jumpType" value="<s:property value='#parameters.s_jumpType' />" />
		<div style="background:#f5f5f5; height:65px; ">
			<s:if test="content.status == 0">
				<a id="back" class='btn btn-primary' href='javascript:void(0)'>返回</a> 
				<a class='btn btn-primary_Blue' href='javascript:doSave();'>保存</a>
				<a class='btn btn-primary_green theme-login' href='javascript:void(0)'>发布</a>
				<div class="right-btn">
					<a class='btn btn-primary_Blue btn-preview' href='javascript:void(0);' onClick="preview()">预览</a>
				</div>
			</s:if>
			<s:else>
				<a class='btn btn-primary_green' href='javascript:doRebuild();'>再次编辑</a>
				<s:if test="content.status == 2">
					<a class='btn btn-primary_green theme-login' href='javascript:void(0)'>发布</a>
				</s:if>
				<s:elseif test="content.status == 1">
					<%-- <a class='btn btn-primary_Blue theme-login' href="javascript:doRecover('<s:property value="content.id"/>')">回收</a> --%>
					<a class='btn btn-primary_Blue theme-login doRecover'  data-target="#qm_deleteRecover">回收</a>

				</s:elseif>
				<a id="back" class='btn btn-primary' href='javascript:void(0)'>返回</a> 
				<span style="color:red; margin-top: 30px; margin-left: 20px;">*已发布问卷不可编辑</span>
			</s:else>
			
		</div>


		<div class="box">
			<div name="keep" style="width: 100%;height:100%;z-index:999;position: absolute;display:none">
				

			</div>

			<div id="nav-menu">
				<ul class="menu">
					<li class="stmenu" type='radio'>
						<h3>
							<a href="#" class="xialaguang" ><span>单选题</span></a>
						</h3>
					</li>
					<li class="stmenu" type='check'>
						<h3>
							<a href="#" class="xialaguang"><span>多选题</span></a>
						</h3>
					</li>
					<li class="stmenu" type='input'>
						<h3>
							<a href="#" class="xialaguang"><span>填空题</span></a>
						</h3>
					</li>
					<li class="stmenu_last">
						<h3>
							<a href="#" class="xialaguang"><span>矩阵题</span></a>
						</h3>
						<ul class="children">
							<li class="stmenu" type='matrixradio'><h3>
									<a href="#"><span>矩阵单选题</span></a>
								</h3></li>
							<li class="stmenu" type='matrixcheck'><h3>
									<a href="#"><span>矩阵多选题</span></a>
								</h3></li>
							<li class="stmenu" type='matrixinput'><h3>
									<a href="#"><span>矩阵填空题</span></a>
								</h3></li>
						</ul>
					</li>
					<li class="stmenu_last">
						<h3>
							<a href="#" class="xialaguang"><span>评分题</span></a>
						</h3>
						<ul class="children">
							<li class="stmenu" type='coderadio'><h3>
									<a href="#"><span>评分单选题</span></a>
								</h3></li>
							<li class="stmenu" type='codecheck'><h3>
									<a href="#"><span>评分多选题</span></a>
								</h3></li>
							<li class="stmenu" type='codematrix'><h3>
									<a href="#"><span>评分矩阵单选题</span></a>
								</h3></li>
						</ul>
					</li>
					<li class="stmenu_last">
						<h3>
							<a href="#" class="xialaguang"><span>考试题</span></a>
						</h3>
						<ul class="children">
							<li class="stmenu" type='testradio'><h3>
									<a href="#"><span>考试单选题</span></a>
								</h3></li>
							<li class="stmenu" type='testcheck'><h3>
									<a href="#"><span>考试多选题</span></a>
								</h3></li>
							<li class="stmenu" type='testinput'><h3>
									<a href="#"><span>考试填空题</span></a>
								</h3></li>
						</ul>
					</li>
					<li class="stmenu_last">
						<h3>
							<a href="#" class="xialaguang"><span>投票题</span></a>
						</h3>
						<ul class="children">
							<li class="stmenu" type='voteradio'><h3>
									<a href="#"><span>投票单选题</span></a>
								</h3></li>
							<li class="stmenu" type='votecheck'><h3>
									<a href="#"><span>投票多选题</span></a>
								</h3></li>
						</ul>
					</li>
					<li class="stmenu" type='head'>
						<h3>
							<a href="#" class="xialaguang" ><span>标题</span></a>
						</h3>
					</li>
				</ul>
			</div>
			<div style="clear:both;"></div>
		</div>

		<textarea id="aaaa" style="display: none;" name='content.content'>
			<s:property value="content.content" />
		</textarea>

		<div id="main" style=" text-align: center; width:100%;overflow: auto;">
			
			<div style="min-height: 80px;">
				<div name="keep" style="width: 98.5%;height:102px;z-index:999;position: absolute;display: none;">
					
				</div>
				<div id="title">
					<!-- 标题 -->
					<input id="content_title" type="hidden" name="content.title"
						value='<s:property value="content.title"/>' />
					<div class="title_sizi" style=" "><s:property value="content.title" /></div>
					<!-- 描述 -->
					<input id="content_explains" type="hidden" name="content.explains"
						value='<s:property value="content.explains"/>' />
					<div
						style="text-align: left; text-indent: 20px; word-wrap: break-word; word-break: normal; margin-bottom: 20px;">
						<s:property value="content.explains" />
					</div>
				</div>
			</div>
			<div>
				<div id="maiDiv"></div>
			</div>

			<div id="editDiv"
				style="display: none; border-top: solid 1px #ddd; width: 100%; margin-top: 40px;">
				<table class="Set_of_questions" style="width: 100%;">
					<tr>
						<td width="70%">题目标题</td>
						<td width="35%" style="text-align: right;display: none;">设置字体</td>
						<td width="30%" style="display:none">当前题型:<span id="type"></span><select></select>
						</td>
					</tr>
					<tr>
						<td colspan="2"><textarea id="topic"
								style="width: 100%; height: 50px"></textarea></td>
						<td>
							<div id="divWill" style="float:left;margin-left: 8px;">
								<input type="checkbox" id="isWill" checked="checked"/>必答题
							</div>
							<div id="divPic" style="display:none;float:left;margin-left: 8px;">
								<input type="checkbox" id="isPic"/>图片题
							</div>
							<div id="divTips" style="float:left;margin-left: 8px;">
								<input type="checkbox" id="isTips" />填写提示 <input type="text"
									id="tips" />
							</div>
						</td>
					</tr>
				</table>
				<!-- 选项题table -->
				<div id="optionDiv" style="display: none; width: 70%; ">
					<table id="optionsTable"
						style="display: none; width: 100%;">
						<thead>
							<tr>
								<td>题目选项</td>
								<td class='option-pic' style="text-align: center;">图片</td>
								<td style="text-align: left;">可填空(选中时出现)</td>
								<td style="text-align: center;">默认</td>
								<td style="text-align: center;width:100px;">操作</td>
							</tr>
						<thead>
						<tbody></tbody>
					</table>
					<table>
						<tr>
							<td style="width: 25%"><a id="newOptions" class="btn btn-primary_Blue" style='margin-left: 0px;'>新增选项+</a></td>
							<%-- <td style="width: 25%">最多选<s:select id="most_select" list={''}/>项</td>
							<td style="width: 25%">最少选 <s:select id="least_select" list={''}/>项</td> --%>
							<td style="width: 25%" id="order_td" >排列顺序<s:select id="order"
									list="#{'1':'垂直排列','2':'每行两个','3':'每行三个','4':'每行四个','5':'每行五个'}" /></td>
					</table>
				</div>
				<!-- 填空题 -->
				<div id="inputDiv" style="display: none; width: 70%; padding: 5px">
					<table id="inputTable" style="width: 100%; padding: 5px">
						<tbody>
							<tr>
								<td width="25%">高度:<s:select id="heightValue"
										list="#{'1':'1行','2':'2行','3':'3行','4':'4行','5':'5行'}"
										value="1" /></td>
								<td width="25%">宽度:<s:select id="widthValue"
										list="#{'50%':'50%','60%':'60%','70%':'70%','80%':'80%','90%':'90%','100%':'100%'}"
										value="50%" /></td>
								<td width="25%"><input type="checkbox" id="underlineStyle" />下划线样式</td>
								<td width="25%">默认值<input type="checkbox" id="isdefault" /><input
									type="text" id="defaultValue" style="display: none" /></td>
							</tr>
							<!-- 考试题属性 -->
							<tr id="testAttribute" style="display: none;">
								<td>
									<div>
										分数
										<s:select id="code_select"
											list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}"
											value="5"></s:select>
									</div>
								</td>
								<td>
									<div>
										标准答案:<input type="text" id="standard_answer" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 评分题table  padding: 5px-->
				<div id="codeDiv" style="display: none; width: 70%;">
					<table id="codeOption"
						style="display: none; width: 100%; padding: 5px">
						<thead>
							<tr>
								<td>题目选项</td>
								<td></td>
								<td style="text-align: center;">分值</td>
								<td style="text-align: center;">操作</td>
								<td></td>
							</tr>
						<thead>
						<tbody></tbody>
					</table>
					<div>
						<a id="newOptions" class="btn btn-primary_Blue" style="margin-left: 0px">新增选项+</a>
					</div>
				</div>
				<!-- 评分题矩阵table -->
				<div id="codeMatrixDiv"
					style="display: none; width: 70%;">
					<div style="">
						<div>左行标签</div>
						<div>
							<textarea rows="6" id="leftLabel"></textarea>
						</div>
					</div>
					<table id="matrixOption">
						<thead>
							<tr>
								<td>题目选项</td>
								<td style="text-align: center;">分值</td>
								<td style="text-align: center;">操作</td>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div>
						<a id="newOptions" class="btn btn-primary_Blue" style="margin-left: 0px">新增选项+</a>
					</div>
				</div>
				<!-- 考试选项题table  padding: 5px-->
				<div id="testOptionDiv"
					style="display: none; width: 70%; ">
					<table id="testOption"
						style="display: none; width: 100%;">
						<thead>
							<tr>
								<td>题目选项</td>
								<td style="text-align: center;">是否正确答案</td>
								<td style="text-align: center;">操作</td>
							</tr>
						<thead>
						<tbody></tbody>
					</table>
					
					<table>
						<tr>
							<td style="width: 25%"><a id="newOptions" class="btn btn-primary_Blue" style="margin-left: 0px">新增选项+</a></td>
							<%-- <td style="width: 25%">最多选<s:select id="most_select" list={''}/>项</td>
							<td style="width: 25%">最少选 <s:select id="least_select" list={''}/>项</td> --%>
							<td style="width: 25%" >
								分数
								<s:select id="code_select" list="{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}" value="5">
								</s:select>
							</td>
					</table>
				</div>

				<!-- 矩阵题 padding: 5px-->
				<div id="matrixDiv" style="display: none; width: 70%;">
					<div style="">
						<div>左行标签</div>
						<div>
							<textarea rows="6" id="leftLabel" style="width:70%"></textarea>
						</div>
					</div>
					<div id="matrixOptionDiv">
						<table id="matrixOption">
							<thead>
								<tr>
									<td>题目选项</td>
									<td>操作</td>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<div>
							<a id="newOptions" class="btn btn-primary_Blue" style="margin-left: 0px">新增选项+</a>
						</div>
					</div>
				</div>

				<button id="completeB" class="btn btn-primary_green" style="margin-left: 0px;">完成编辑</button>
				<button id="completeC" class="btn btn-primary_green" style="margin-left: 0px;">取消编辑</button>
			</div>

			<div class="theme-popover-main"></div>
			<div id="publishDialog" class="theme-popover">
				<div class="theme-poptit">
					<a href="javascript:;" title="关闭" class="close">×</a>
					<h3 style='text-align:center;'>发布问卷</h3>
				</div>
				<div class="theme-popbod dform" style=' cursor: pointer;'>
					<table class="authorizeTable">
						<tr style='height: 50px; line-height: 50px;'>
							<td class="authorizeTableTd1">发布给：</td>
							<td class="authorizeTableTd2"><s:radio  style='margin: 0px 1px 0px 2px; cursor: pointer;' name="content.scope" 
									theme="simple"
									list="#{'user':'用户','role':'角色','dept':'部门','deptAndrole':'部门和角色'}"></s:radio>
							</td>
						</tr>
						<tr id="userTr">
							<td class="authorizeTableTd1">用户：</td>
							<td class="authorizeTableTd2">
								<div class="user1Select">
									<s:hidden id="userHidden" name="u_ownerIds" />
									<s:textfield id="userInput" name="u_ownerNames" readonly="true" />
									<span
										onclick="selectUser4Qm('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')"
										title="{*[cn.myapps.km.disk.select_user]*}">选择用户</span> <span
										id="clear1User" title="{*[Clear]*}">清理</span>
								</div>
							</td>
						</tr>
						<tr id="deptTr" style="display: none;">
							<td class="authorizeTableTd1">部门名：</td>
							<td class="authorizeTableTd2">
								<div class="user3Select">
									<s:hidden id="deptHidden" name="content.deptId" />
									<s:textfield id="deptInput" name="d_ownerNames" readonly="true" />
									<span
										onclick="selectDept4Qm('actionName',{textField:'deptInput',valueField:'deptHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择部门'},'')"
										title="选择部门">选择部门</span> <span id="clear3User"
										title="{*[Clear]*}">清理</span>
								</div>
							</td>
						</tr>
						<tr id="roleTr" style="display: none;">
							<td class="authorizeTableTd1">角色：</td>
							<td class="authorizeTableTd2">
								<div class="user2Select">
									<s:hidden id="roleHidden" name="content.roleId" />
									<s:textfield id="roleInput" name="r_ownerNames" readonly="true" />
									<span
										onclick="selectRole4Qm('actionName',{textField:'roleInput',valueField:'roleHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择角色'},'')"
										title="选择角色">选择角色</span>
									<span id="clear2User" title="{*[Clear]*}">清理</span>
								</div>
							</td>
						</tr>
					</table>
					<a class="btn btn-primary_green"" name="submit"
						href="javascript:checkout()" style='margin-left: 110px; margin-top: 20px; float: left;' />发 布</a>
				</div>
			</div>

			<div id="titleDialog" class="theme-popover">
				<div class="theme-poptit">
					<a href="javascript:;" title="关闭" class="close">×</a>
					<h3>编辑信息问卷</h3>
				</div>
				<div class="theme-popbod dform">
					<table class="authorizeTable" style="width: 80%; margin-left: 40px; " >
						<tr id="titleTr" style="height: 50px; line-height: 50px;">
							<td class="authorizeTableTd1" nowrap="nowrap" >标题：</td>
							<td class="authorizeTableTd2" width="100%">
								<div class="user1Select">
									<s:textfield id="e_title" name="e_title" style='width:100%;' readonly="false" />
								</div>
							</td>
						</tr>
						
						<tr id="explainsTr">
							<td class="authorizeTableTd1">说明：</td>
							<td class="authorizeTableTd2" width="100%">
								<div>
									<s:textarea id="e_explains" name="e_explains" style="width:100%; min-height:60px" readonly="false" />
								</div>
							</td>
						</tr>
					</table>
					<a class="btn btn-primary_green" style="margin-right: 145px; margin-top: 20px;} " name="edit" href="javascript:doEdit()" />确
					定</a>
				</div>
			</div>

		</div>

	</s:form>
	<!-- 回收2次确认 -->
	<div id="qm_deleteRecover" class="popup">
		<input type="hidden" value="" id="doRecoverId"/>
		<div class="popup-title clearfix"><span class="pull-left">回收问卷</span><a href="javascript:void(0);" class="pull-right close-popup">X</a></div>
		<div class="popup-co">
			<div style="margin:20px auto;text-align:center;font-size: 16px;">确定回收此问卷吗？</div>
			
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button type="button" id="redoRecover" class="btn btn-success">回收</button>
			</div>
		</div>
	</div>
	<form action="../previewPrint.jsp" method="post" target="_blank" id="previewPrint" name="previewPrint" style="display:none;">
		<input type="hidden" name="previewId"/>
		<input type="hidden" name="previewTitle"/>
		<input type="hidden" name="previewText"/>
	</form>
</body>
</html>
</o:MultiLanguage>