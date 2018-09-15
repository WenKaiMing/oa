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
<link href="../css/list.css" rel="stylesheet" type="text/css">
<link href="../js/jquery.pagination/jquery.pagination.css" rel="stylesheet" type="text/css">
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
<script type="text/javascript" src="../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../bootstrap/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<s:url value='/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<link href="../js/toastr/toastr.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../js/toastr/toastr.min.js"></script>	
<script type="text/javascript" src="../js/jquery.pagination/jquery.pagination.js"></script>	
<script type="text/javascript" src="../js/common.js"></script>	
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<script type="text/javascript" src="../../portal/H5/resource/script/jquery.slimscroll.min.js" ></script>
<script type="text/javascript" src="../js/qm.list.js"></script>

<script>
var contextPath = '<%=request.getContextPath()%>';
</script>


</head>
<body style="overflow: auto;">
	<div class="mask"></div>
	<s:form id="formList" name="formList" action="list.action" autocomplete="off"
		method="post" theme="simple">
		<input type='hidden' name="type" value="<s:property value='#parameters.type' />" />
		<input type='hidden' name="status" value="<s:property value='#parameters.status' />" />
		<input type='hidden' name="_currpage" value="<s:property value='#parameters._currpage' />" />
		<input type='hidden' name="_pagelines" value="<s:property value='#parameters._pagelines' />" />
		<input type='hidden' name="_rowcount" value='' />
		<div style="min-height: 100%;background: #fff;">
			
			<div class="cell-content-part">
				<div class="title list-search">
					<div class="search-input on-search-active"> 
					
						<input name="search-list-name" class="nav-search-input"  type="search" placeholder="请输入主题，按回车键搜索"> 
					</div>
					<!-- <a class="cell-btn-blue newTaskInPro q_new" href="javascript:void(0);">
						<span class="glyphicon glyphicon-plus-sign"></span>
					</a> -->	
					<a class="cell-btn-blue newTaskInPro q_new" href="javascript:void(0);">
						<span>+新建问卷</span>
					</a>		
				</div>
				<!-- 高级搜索开始 -->
				<div class="search-advance" style="display: block;">
					<div class="all-right">
						<button type="button" _value="1" class="btn-list all-right-two btn-default">我参与的</button>
						<button type="button" _value="0" class="btn-list all-right-one btn-default  btn-active">我发布的</button>
					</div>
					<div class="all-left">
						<button type="button" status="0" class="btn-list all-left-one btn-default ">草稿</button>
						<button type="button" status="1" class="btn-list all-left-two btn-default  btn-active">进行中</button>
						<button type="button" status="2" class="btn-list all-left-thre btn-default">已完成</button>
					</div>
					
				</div>
				<div class="content">
					<div class="pm-task-list-all">
							<table class="pm-task-table" id="pm-follow-task-table" style="table-layout: fixed;">
								<thead>
									<tr class="head">
									    <td  class="pm-list-order" width="60px"><span>状态</span></td>
										<td  class="pm-list-order"><span>主题</span></td>
										<td  class="pm-list-order" width="130px" style="display:none;"><span>答题情况</span></td>
										<td class="pm-list-order" width="100px"><span>时间</span></td>
										<td class="pm-list-order"  width="300px"><span>操作</span></td>
										
									</tr>
								</thead>
								<tbody class="tbody" id="pm-task-table-body2">
									
								</tbody>
							</table>
						
						
					</div>
					<div id="pagingDiv" class="table_pagenav" style="padding:20px 0px;background: #fff;">
						<!-- 分页导航(page navigate) -->
					    <div id="isPagination">
					    	<div id="pagination-panel" data-options="
					    		{'_isPagination': 'true',
								'_isShowTotalRow': 'true',
								'_datasPageNo': '<s:property value="workDatas.pageNo" />',
								'_datasPageCount': '<s:property value="workDatas.rowCount" />',
								'_totalRowText': '<s:property value="workDatas.rowCount" />',
								'_isShowItem': 'true'}">
							</div>
					    </div>	
					</div>
				</div>
			
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
					<a class="btn btn-primary_green" name="submit"
						href="javascript:checkout()" style='margin-left: 110px; margin-top: 40px;height:auto;' />发 布</a>
				</div>
			</div>
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
			<!-- 删除2次确认 -->
			<div id="qm_delete" class="popup">
				<input type="hidden" value="" id="dodeleteId"/>
				<div class="popup-title clearfix"><span class="pull-left">回收问卷</span><a href="javascript:void(0);" class="pull-right close-popup">X</a></div>
				<div class="popup-co">
					<div style="margin:20px auto;text-align:center;font-size: 16px;">确定删除此问卷吗？</div>
					
					<div class="btn-wrap">
						<button class="btn btn-cancel">取消</button>
						<button type="button" id="redoDelete" class="btn btn-danger">删除</button>
					</div>
				</div>
			</div>
		</div>
	</s:form>
	

</body></o:MultiLanguage>
</html>