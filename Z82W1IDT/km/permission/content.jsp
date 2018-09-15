<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script type="text/javascript" src='<s:url value="/km/disk/script/share.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script type="text/javascript">
	function radioAct(){
		jQuery("#save_content_scopeuser").click(function(){
			jQuery("#userTr").css("display","");
			jQuery("#roleTr").css("display","none");
			jQuery("#deptTr").css("display","none");
			
			//清除角色信息
			jQuery("#roleInput").attr("title","");
			jQuery("#roleInput").val("");
			jQuery("#roleHidden").val("");
			//清除部门信息
			jQuery("#deptInput").attr("title","");
			jQuery("#deptInput").val("");
			jQuery("#deptHidden").val("");
		});
		jQuery("#save_content_scoperole").click(function(){
			jQuery("#roleTr").css("display","");
			jQuery("#userTr").css("display","none");
			jQuery("#deptTr").css("display","none");
			
			//清除用户信息
			jQuery("#userInput").attr("title","");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
			//清除部门信息
			jQuery("#deptInput").attr("title","");
			jQuery("#deptInput").val("");
			jQuery("#deptHidden").val("");
		});
		jQuery("#save_content_scopedept").click(function(){
			jQuery("#deptTr").css("display","");
			jQuery("#userTr").css("display","none");
			jQuery("#roleTr").css("display","none");
			//清除用户信息
			jQuery("#userInput").attr("title","");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
			//清除角色信息
			jQuery("#roleInput").attr("title","");
			jQuery("#roleInput").val("");
			jQuery("#roleHidden").val("");
		});
		jQuery("#save_content_scopedeptAndrole").click(function(){
			jQuery("#deptTr").css("display","");
			jQuery("#userTr").css("display","none");
			jQuery("#roleTr").css("display","");
			//清除用户信息
			jQuery("#userInput").attr("title","");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
			
		});
	}
	//选项卡
	(function($){
		$.fn.tabs = function(options){
			//默认值
			var defaults = {
				mouseEvent: "click"
			};
			var options = $.extend({}, $.fn.tabs.defaults, options);
			
			var tit = $(this).find(".shareTab_title .tt_li");
			var cont = $(this).find(".shareTab_content .tc_li");
			if(options.mouseEvent == "click"){
				tit.each(function(i){
					$(this).bind({
						"click":function(){
							THIS = $(this);
							hovertime = setTimeout(function(){
								THIS.addClass("active");
								THIS.siblings().removeClass("active");
								cont.eq(i).css("display","block");
								cont.eq(i).siblings().css("display","none");
							},200);
						}
					});				  
				});	
			}
		};
	})(jQuery);
	jQuery(document).ready(function(){
		radioAct();
		jQuery("#clear1User").click(function(){
			jQuery("#userInput").attr("title","");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
		});
		jQuery("#clear2User").click(function(){
			jQuery("#roleInput").attr("title","");
			jQuery("#roleInput").val("");
			jQuery("#roleHidden").val("");
		});
		jQuery("#clear3User").click(function(){
			jQuery("#deptInput").attr("title","");
			jQuery("#deptInput").val("");
			jQuery("#deptHidden").val("");
		});
		jQuery("#indexSubmit").bind("click",function(){
			//document.forms[0].action = "";
			//document.forms[0].submit();
		});
		jQuery("#return_back").click(function(){
			return_back(); //返回按钮
		});
		
		jQuery("#shareTab").tabs({				
			mouseEvent: "click"
		});
		init_scope();
		jQuery("#userInput").attr("title",jQuery("#userInput").val());
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
			var ownerId = ownerIds.split(";");
			var ownerName = ownerNames.split(";");
			jQuery("#deptInput").val(ownerName[0]);
			jQuery("#deptHidden").val(ownerId[0]);
			jQuery("#roleInput").val(ownerName[1]);
			jQuery("#roleHidden").val(ownerId[1]);
		}
	}
	function return_back(){
		var _fileId = '<s:property value="content.fileId" />';
		var _fileType = '<s:property value="content.fileType" />';
		var url = contextPath + "/km/permission/list.action?_fileId="+_fileId+"&_fileType="+_fileType;
		location.href = url;
	}

	/*
	* 用户授权表单校验
	*/
	function checkout(){
		var readMode = document.getElementsByName("content.readMode")[0].checked;
		var downloadMode = document.getElementsByName("content.downloadMode")[0].checked;
		var writeMode = document.getElementsByName("content.writeMode")[0].checked;
		var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		var u_ownerNames = document.getElementsByName("u_ownerNames")[0].value;
		var r_ownerNames = document.getElementsByName("r_ownerNames")[0].value;
		var d_ownerNames = document.getElementsByName("d_ownerNames")[0].value;
		//var scope = document.getElementsByName("content.scope")[0].checked;
		var scope = jQuery("input[name='content.scope']:checked")[0].value;
		if(readMode == false && downloadMode == false && writeMode == false){
			alert("{*[cn.myapps.km.permission.user_authorization_check_null]*}");
			return;
		}
		if( (startDate!='' && endDate=='') ||  (endDate!='' && startDate=='')){
			alert("{*[cn.myapps.km.permission.user_authorization_check_time]*}");
			return;
		}
		if(scope=="user" && u_ownerNames.length<=0){
			alert("{*[cn.myapps.km.permission.user_authorization_check_user]*}");
			return;
		}
		if(scope=="role" && r_ownerNames.length<=0){
			alert("{*[cn.myapps.km.permission.user_authorization_check_role]*}");
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
		ev_save();
		
	}

	function ev_save(){
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
			document.getElementsByName("content.ownerIds")[0].value = document.getElementById("deptHidden").value + ";" +  document.getElementById("roleHidden").value;
			document.getElementsByName("content.ownerNames")[0].value = document.getElementById("deptInput").value + ";" + document.getElementById("roleInput").value;
		}
		document.forms[0].submit();
	}
</script>
</head>
<body>
		
<div class="authorizeHead">
	<div>
		<button id="return_back">{*[Back]*}</button>
		<button onclick="checkout();" style="cursor:pointer;" id="indexSubmit">{*[cn.myapps.km.disk.confirm]*}</button>
	</div>
</div>
<s:form action="save" method="post" theme="simple">
<s:hidden name="content.id"/>
<s:hidden name="content.fileId"/>
<s:hidden name="content.fileType"/>
<s:hidden id="_fileId" name="_fileId" />
<s:hidden name="content.ownerIds" />
<s:hidden name="content.ownerNames" />
	<%@include file="/common/msg.jsp"%>
	<div class="shareTab" id="shareTab">
		<ul class="shareTab_title clearfix">
			<li class="tt_li active"><span><a href="javascript:void(0);">{*[cn.myapps.km.permission.basic_setup]*}</a></span></li>
			<li class="tt_li"><span><a href="javascript:void(0);">{*[cn.myapps.km.permission.temporary_authorization]*}</a></span></li>
		</ul>
		<ul class="shareTab_content">
			<li class="tc_li">
				<table class="authorizeTable">
					<%-- <tr>
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.name]*}：</td>
						<td class="authorizeTableTd2">
							<s:textfield name="content.name"/>
						</td>
					</tr> --%>
					<tr>
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.authorization_to]*}：</td>
						<td class="authorizeTableTd2">
							<s:radio name="content.scope" theme="simple"
											list="#{'user':'{*[User]*}','role':'{*[Role]*}','dept':'{*[Department]*}','deptAndrole':'{*[Department]*}+{*[Role]*}'}"></s:radio>
						</td>
					</tr>
					<tr id="userTr">
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.user_name]*}：</td>
						<td class="authorizeTableTd2">
							<div class="user1Select">
								<s:hidden id="userHidden"  name="content.userId" />
								<s:textfield id="userInput" name="u_ownerNames" readonly="true"/> 
								<span onclick="selectUser4Km('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')" title="{*[cn.myapps.km.disk.select_user]*}">{*[cn.myapps.km.disk.select_user]*}</span>
								<span id="clear1User" title="{*[Clear]*}">{*[Clear]*}</span>
							</div>
						</td>
					</tr>
					
					 <tr id="deptTr" style="display: none;">
						<td class="authorizeTableTd1">部门名：</td>
						<td class="authorizeTableTd2">
							<div class="userSelect">
								<s:hidden id="deptHidden"  name="content.deptId" />
								<s:textfield id="deptInput" name="d_ownerNames" readonly="true"/> 
								<span onclick="selectDept4Km('actionName',{textField:'deptInput',valueField:'deptHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择部门'},'')" title="选择部门">选择部门</span>
								<span id="clear3User" title="{*[Clear]*}">{*[Clear]*}</span>
							</div>
						</td>
					</tr> 
					<tr id="roleTr" style="display: none;">
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.role_name]*}：</td>
						<td class="authorizeTableTd2">
							<div class="userSelect">
								<s:hidden id="roleHidden"  name="content.roleId" />
								<s:textfield id="roleInput" name="r_ownerNames" readonly="true"/> 
								<span onclick="selectRole4Km('actionName',{textField:'roleInput',valueField:'roleHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.permission.select_role]*}'},'')" title="{*[cn.myapps.km.permission.select_role]*}">{*[cn.myapps.km.permission.select_role]*}</span>
								<span id="clear2User" title="{*[Clear]*}">{*[Clear]*}</span>
							</div>
						</td>
					</tr>
					<tr>
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.permissions]*}：</td>
						<td class="authorizeTableTd2">
							<s:checkbox name="content.readMode" fieldValue="1" label="阅读" />{*[cn.myapps.km.logs.read]*} &nbsp;
							<s:checkbox name="content.writeMode" fieldValue="1" label="修改" />修改&nbsp;
							<s:checkbox name="content.downloadMode" fieldValue="1" label="下载" />{*[cn.myapps.km.disk.download]*}&nbsp;
						</td>
					</tr>
				</table>
			</li>
			<li class="tc_li" style="display: none;">
				<table>
					<tr class="authorizeTime">
						<td class="authorizeTableTd1" >{*[cn.myapps.km.permission.aging]*}：</td>
						<td class="authorizeTableTd2">
							{*[From]*}<input type='text' name='startDate' id='startDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'endDate\')}',skin:'whyGreen'})"  value='<s:date name="content.startDate" format="yyyy-MM-dd HH:mm" />'/>
							{*[cn.myapps.km.permission.to]*}<input type='text' name='endDate' id='endDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startDate\')}',skin:'whyGreen'})" value='<s:date name="content.endDate" format="yyyy-MM-dd HH:mm"/>'/>
						</td>
					</tr>
				</table>
			</li>
		</ul>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>