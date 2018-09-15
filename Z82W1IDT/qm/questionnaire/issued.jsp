<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/theme.css" rel="stylesheet" type="text/css">
<link href="../css/contentstyle.css" rel="stylesheet" type="text/css">
<link href="../css/table.css" rel="stylesheet" type="text/css">
<style>
a {
	text-decoration: none;
}

.pagenav { /*color: #7EB8C6;*/
	color: #666666;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	background-color: #FFFFFF;
	background-image: none;
}

.pagenav a{
	color: #2A5685;
}
.pagenav a:hover {
	color: #c61a1a;
	text-decoration: underline;
}
</style>
<title>问卷发布列表</title>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript"
	src="<s:url value='/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript">
	
	var select_id = "";
	/* todo */
	$(document).ready(function() {
    	$("#button").click(function(){
    		 var page=$("#cptext").val();
    		 if(!isNaN(page)){
    			 window.location.href = "list.action?_currpage="+page;
    			}else{
    		     window.location.href = "list.action?_currpage=1";
    			}
    	    }
    	);
    	/* todo */
		$(".q_new").click(function() {
			window.location.href = "new.action";
		});
		$(".q_delete").click(function() {
			if (isSelectedOne2("_selects")) {
				if(confirm("删除后会将已答卷的问卷删除，是否继续?")){
					document.forms[0].action = "delete.action";
					document.forms[0].submit();
				}
			}
		});
		
		$('#publishDialog .theme-poptit .close').click(function(){
			$('.theme-popover-main').hide();
			$('.theme-popover-mask').fadeOut(100);
			$('#publishDialog').slideUp(200);
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
		
	});
	
	function init_scope(){
		var scope = 'user';
		$("#formList_content_scopeuser").attr("checked","checked");
		var ownerNames = '';
		var ownerIds = '';
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

	function showResult(id) {
		window.location.href = "chartMain.jsp?id=" + id;
	}

	function selectAll(b, isRefresh) {
		var c = document.all('_selects');
		if (c == null)
			return;

		if (c.length != null) {
			for (var i = 0; i < c.length; ++i){
				c[i].checked = b && !(c[i].disabled);
			}
		} else {
			c.checked = b;
		}
	}

	function isSelectedOne2(fldName) {
		var c = document.getElementsByName(fldName);
		var flag = false;
		if (c && c.length > 0) {
			for (var i = 0; i < c.length; i++) {
				if (c[i].checked) {
					flag = true;
					break;
				}
			}
		}
		if (!flag) {
			alert("请选择其中一项");
			return false;
		}
		return true;
	}
	 
	function doPubilsh(id){
		$('.theme-popover-main').show();
		$('.theme-popover-mask').fadeIn(100);
		$('#publishDialog').slideDown(200);
		
		init_scope();
		
		select_id = id;
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
	
	function ev_publish(){
		var scope = jQuery("input[name='content.scope']:checked")[0].value;
		var ownerIds = "";
		var ownerNames = "";
		if(scope == "user"){
			ownerIds = document.getElementById("userHidden").value;
			ownerNames = document.getElementById("userInput").value;
		}else if(scope == "role"){
			ownerIds = document.getElementById("roleHidden").value;
			ownerNames = document.getElementById("roleInput").value;
		}else if(scope == "dept"){
			ownerIds = document.getElementById("deptHidden").value;
			ownerNames = document.getElementById("deptInput").value;
		} else if(scope == "deptAndrole"){
			ownerIds = document.getElementById("deptHidden").value + ";;" +  document.getElementById("roleHidden").value;
			ownerNames = document.getElementById("deptInput").value + ";;" + document.getElementById("roleInput").value;
		}
		
		$.ajax({
		    type: 'POST',
		    url: "publishforId.action",
		    dataType:"html",
		    data: {'id':select_id,'scope':scope,'ownerIds':ownerIds,'ownerNames':ownerNames} ,
		    success:function(data){
				if(data){
					if(data.indexOf("SUCCESS") >= 0){
						//todo
						$('#publishDialog').hide();
						alert("成功");
						/* todo */
						var page=$('#cp').text();
						window.location.href = "list.action?_currpage="+page;
						/* todo end*/
					}
				}else{
					alert("回收失败");
				}
			},
			error:function(data,status){
				alert("failling to visited...");
			}
		});
	}
	
	function doRecover(id){
		$.ajax({
		    type: 'POST',
		    url: "recover.action",
		    data: {'id':id} ,
		    dataType:"html",
		    success:function(data){
				if(data){
					if(data.indexOf("SUCCESS") >= 0){
						alert("回收成功");
						/* todo */
						var page=$('#cp').text();
						/* todo begin*/
						window.location.href = "list.action?_currpage="+page;
						/* todo end*/
					}
				}else{
					alert("回收失败");
				}
			},
			error:function(data,status){
				alert("failling to visited...");
			}
		});
	}
	
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
	

	//设置cookie值
	function setCookie(name,value){
	    var exp  = new Date();  
	    exp.setTime(exp.getTime() + 30*24*60*60*1000);
	    jQuery("input[name='_pagelines']").val(value);
	}
	
	
</script>
</head>
<body style="overflow: auto;">
	<s:form id="formList" name="formList" action="list.action"
		method="post" theme="simple">
		<input type='hidden' name="_currpage" value='<s:property value="datas.pageNo"/>' />
		<input type='hidden' name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
		<input type='hidden' name="_rowcount" value='<s:property value="datas.rowCount"/>' />
		<div style="background: #f5f5f5; height:65px; margin-right: 15px;border-left: 1px solid #dcdcdc;border-right: 1px solid #dcdcdc;">
			<a class="btn btn-primary_Blue q_new" href="javascript:void(0)">新建</a> 
			<a class="btn btn-primary_delete q_delete" href="javascript:void(0)">删除</a>			
			<div style="height: 65px; line-height: 65px; float: right; margin-right: 11%; color: white;">
				<s:textfield name="s_title"  style="margin-left: 10px; height: 30px; line-height: 10px; border: none; text-indent: 8px; "></s:textfield><!-- 创建时间<input type="text"
					name="s_explains" /> --> 
					<a href="javascript:document.forms[0].submit()" class="btn btn-primary_green q_new"  style="margin-top: -0px; border: none; height: 30px; line-height: 30px; margin-left: -10px;}" >查询</a>
			</div>			
		</div>
		
		<div style="min-height: 100%;margin-right: 15px;border-left: 1px solid #dcdcdc;border-right: 1px solid #dcdcdc;background:#fff;">
			<table class='gridtable'>
				<thead>
					<tr>
						<td width="15px"><input type="checkbox"
							onclick="selectAll(this.checked)">
						</td>
						<td>标题</td>
						<td>创建者</td>
						<td>发布范围</td>
						<td>创建时间</td>
						<td>状态</td>
						<td>结果</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="datas.datas" status="index" id="questionnaire">
						<tr class="Query_Form_table" >
						<!-- 多选框 -->
							<td class="table-td">
								<s:if test="status==0">
									<input type="checkbox" id="_selects"
									name="_selects" value="<s:property value="id"/>">
								</s:if>
								
								<s:else>
									<input key="enable" type="checkbox" id="_selects"
									name="_selects" disabled='true' value="<s:property value="id"/>">
								</s:else>
							</td>
							
							<!-- 标题 -->
							<td>
								<a  class="Query_Form_table_text"
									href="javascript: document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
										<s:property value="title" />
								</a>
							</td>
							
							<!-- 创建者 -->
							<td>
								<a  class="Query_Form_table_text"
									href="javascript: document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
										<s:property value="creatorName" />
								</a>
							</td>
							
							<!-- 发布范围 -->
							<td>
								<a  class="Query_Form_table_text"
									href="javascript: document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
										<s:property value="ownerNames" />
								</a>
							</td>
							
							<!-- 创建时间 -->
							<td>
								<a  class="Query_Form_table_text"
									href="javascript: document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
										<s:date name="createDate" format="yyyy-MM-dd" />
								</a>
							</td>
							
							<!-- 状态 -->
							<td>
								<input type="hidden" value="" /><a  class="Query_Form_table_text"
									href="javascript: document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
										<s:if test="status==0">
									草稿
								</s:if> <s:elseif test="status==1">
									已发布
								</s:elseif> <s:elseif test="status==2">
									已回收
								</s:elseif>
								</a>
							</td>
							
							<!-- 结果查看 -->
							<td><s:if test="status==0">
									<a style="color: gray">查看</a>
								</s:if> <s:else>
									<a class="Query_Form_table_text " href="javascript:showResult('<s:property value="id" />')">查看</a>
								</s:else></td>
								
							<!-- 操作 -->
							<td><s:if test="status==1">
									<a class="Button_Edit_Blue" href="javascript:doRecover('<s:property value="id" />')">回收</a>
								</s:if> <s:else>
									<a class="Button_Edit" href="javascript:doPubilsh('<s:property value="id" />')">发布</a>
								</s:else></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
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
							<td class="authorizeTableTd2">
							<s:radio style='margin: 0px 1px 0px 2px; cursor: pointer;' name="content.scope"
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
								<div class="userSelect">
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
								<div class="userSelect">
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
					<a class="btn btn-primary_green" name="submit"
						href="javascript:checkout()" style='margin-left: 110px; margin-top: 40px;' />发 布</a>
				</div>
			</div>
			<input type='button' value='确定' id='button' style="float: right;">
			<input type='text' name='cp' id='cptext' value='' style="width: 40px;float: right;"/>
			<span style="float: right;font-size: 10px">页数 :&nbsp;</span>
		</div>
	</s:form>
</body></o:MultiLanguage>
</html>