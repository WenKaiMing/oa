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
		jQuery("#manage_permission_save_content_scopeuser").click(function(){
			jQuery("#userTr").css("display","");
			jQuery("#roleTr").css("display","none");
		});
		jQuery("#manage_permission_save_content_scoperole").click(function(){
			jQuery("#roleTr").css("display","");
			jQuery("#userTr").css("display","none");
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
			jQuery("#roleInput").val(ownerNames);
			jQuery("#roleHidden").val(ownerIds);
		}else{
			jQuery("#userInput").val(ownerNames);
			jQuery("#userHidden").val(ownerIds);
		}
	}
	function return_back(){
		var resource = '<s:property value="content.resource" />';
		var resourceType = '<s:property value="content.resourceType" />';
		var url = contextPath + "/km/permission/manage_permission_list.action?resource="+resource+"&resourceType="+resourceType;
		location.href = url;
	}

	/*
	* 用户授权表单校验
	*/
	function checkout(){
		var u_ownerNames = document.getElementsByName("u_ownerNames")[0].value;
		var r_ownerNames = document.getElementsByName("r_ownerNames")[0].value;
		var scope = document.getElementsByName("content.scope")[0].checked;
		if(scope && u_ownerNames.length<=0){
			alert("{*[cn.myapps.km.permission.user_authorization_check_user]*}");
			return;
		}
		if(!scope && r_ownerNames.length<=0){
			alert("{*[cn.myapps.km.permission.user_authorization_check_role]*}");
			return;
		}
		ev_save();
		
	}

	function ev_save(){
		var scope = document.getElementsByName("content.scope")[0].checked;
		if(scope){
			document.getElementsByName("content.ownerIds")[0].value = document.getElementById("userHidden").value;
			document.getElementsByName("content.ownerNames")[0].value = document.getElementById("userInput").value;
		}else {
			document.getElementsByName("content.ownerIds")[0].value = document.getElementById("roleHidden").value;
			document.getElementsByName("content.ownerNames")[0].value = document.getElementById("roleInput").value;
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
<s:form action="manage_permission_save" method="post" theme="simple">
<s:hidden name="content.id"/>
<s:hidden name="content.resource"/>
<s:hidden name="content.resourceType"/>
<s:hidden id="resource" name="resource" />
<s:hidden name="content.ownerIds" />
<s:hidden name="content.ownerNames" />
<s:hidden name="content.domainId" />
	<%@include file="/common/msg.jsp"%>
	<div class="shareTab" id="shareTab">
		<ul class="shareTab_content">
			<li class="tc_li">
				<table class="authorizeTable">
					<tr>
						<td class="authorizeTableTd1">{*[cn.myapps.km.permission.authorization_to]*}：</td>
						<td class="authorizeTableTd2">
							<s:radio name="content.scope" theme="simple"
											list="#{'user':'{*[User]*}','role':'{*[Role]*}'}"></s:radio>
						</td>
					</tr>
					<tr id="userTr">
						<td class="authorizeTableTd1">{*[User]*}：</td>
						<td class="authorizeTableTd2">
							<div class="user1Select">
								<s:hidden id="userHidden"  name="u_ownerIds" />
								<s:textfield id="userInput" name="u_ownerNames" readonly="true"/> 
								<span onclick="selectUser4Km('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')" title="{*[cn.myapps.km.disk.select_user]*}">{*[cn.myapps.km.disk.select_user]*}</span>
								<span id="clear1User" title="{*[Clear]*}">{*[Clear]*}</span>
							</div>
						</td>
					</tr>
					<tr id="roleTr" style="display: none;">
						<td class="authorizeTableTd1">{*[Role]*}：</td>
						<td class="authorizeTableTd2">
							<div class="userSelect">
								<s:hidden id="roleHidden"  name="r_ownerIds" />
								<s:textfield id="roleInput" name="r_ownerNames" readonly="true"/> 
								<span onclick="selectRole4Km('actionName',{textField:'roleInput',valueField:'roleHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.permission.select_role]*}'},'')" title="{*[cn.myapps.km.permission.select_role]*}">{*[cn.myapps.km.permission.select_role]*}</span>
								<span id="clear2User" title="{*[Clear]*}">{*[Clear]*}</span>
							</div>
						</td>
					</tr>
				</table>
			</li>
		</ul>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>