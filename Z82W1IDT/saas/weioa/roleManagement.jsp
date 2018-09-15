<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

	<!DOCTYPE html>
	<html lang="cn" class="app fadeInUp animated">

<head>
<meta charset="utf-8" />
<title>微OA365，爱工作365天</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta content="微OA365 微信企业号 微信办公 移动OA 微信打卡 微信审批 移动协作平台 " name="Keywords" />
<meta content="" name="Description" />
<link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resource/css/animate.min.css" rel="stylesheet" />
<link href="../resource/css/font-awesome.min.css" rel="stylesheet" />
<link href="../resource/css/style.min.css" rel="stylesheet" />
<link href="../resource/css/iconfont.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
</head>

<body>
	<section class="hbox stretch">
		<aside class="aside-md bg-white b-r">
			<div class="wrapper b-b header">
				<b>角色授权</b>
			</div>
			<ul class="nav">
				<s:iterator value="roleList" status="index" id="role">
				
					<li class="b-b b-light 
						<s:if test="id==#request.roleId || #request.roleId==null"> open</s:if>
						"><a href="list.action?roleId=<s:property value='id' />&applicationId=<s:property value='#request.applicationId' />">
							<i
							class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="name" />
					</a></li>
				</s:iterator>
			</ul>
		</aside>
		<aside>
			<section class="vbox">
				<header class="header bg-white b-b clearfix">
					<form class="talbe-search" method="get" action="list.action">
						<input type="hidden" name="method" id="method" />
						<div class="row m-t-sm">
							<div class="col-sm-1 m-b-xs">
								<!-- <button type="button" class="btn btn-default btn-sm" data-toggle="openPost" data-set="download"  data-type="get"><i class="fa fa-cloud-download m-r-xs"></i>导出</button>  -->
								<button type="button" class="btn btn-default btn-sm" id="btn-add-user">
									<i class="fa fa-plus m-r-xs"></i>添加
								</button>
							</div>
							<!--  
							<div class="col-sm-3 m-b-xs col-sm-offset-4">
								<div class="input-group">
									<input class="input-sm form-control"
										data-toggle="tokeninputtree"
										data-path="/wAddressList/getDepartment"
										data-contact="/wAddressList/getMember" type="text" value=""
										name="keyword" id="keyword" /> <span class="input-group-btn">
										<button class="btn btn-sm btn-default" type="submit"
											title="搜索">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div>
							</div>
							-->
						</div>
						<s:hidden name="roleId"/>
						<s:hidden name="applicationId"/>
						<input type="hidden" name="pageNumber" id="pageNumber" value="1" />
						<input type="hidden" name="orderBy" id="orderBy" value="desc" /> 
						<input type="hidden" name="order" id="order" value="depart" /><input
							type="hidden" name="bdid" value="">
						<input type="hidden" name="_currpage" value="<s:property value="datas.pageNo"/>"/>
						<input type="hidden" name="_pagelines" value="<s:property value="datas.linesPerPage"/>"/>
						<input type="hidden" name="_rowcount" value="<s:property value="datas.rowCount"/>"/>
					</form>
				</header>
				<section class="scrollable wrapper w-f">
					<section class="panel panel-default ">
						<div class="table-responsive">
							<table class="table m-b-none entity-view text-center">
								<thead>
									<tr>
										<th class="text-center">姓名</th>
										<th class="text-center">账号</th>
										<th class="text-center">手机</th>
										<th class="text-center">邮箱</th>
										<th class="text-center">状态</th>
									</tr>
								</thead>
								<tbody>
								<s:iterator value="datas.datas" status="index" id="user">
									<tr data-id="<s:property value="id" />">
										<td><s:property value="name" /></td>
										<td><s:property value="logonno" /></td>
										<td><s:property value="telephone" /></td>
										<td><s:property value="email" /></td>
										<td><s:if test="dimission == 1">
										{*[cn.myapps.core.user.isdimission.on_job]*}
										</s:if>
										<s:else>
										{*[cn.myapps.core.user.isdimission.dimission]*}
										</s:else></td>
									</tr>
								</s:iterator>
								</tbody>
							</table>
						</div>
					</section>
				</section>
				<footer class="footer bg-white b-t">
					<div class="row text-center-xs">
						<div class="col-md-6 hidden-sm">
							<p class="text-muted m-t"></p>
						</div>
						<div class="col-md-6 col-sm-12 text-right text-center-xs">
							<ul class="pagination pagination-sm m-t-sm m-b-none"
								data-pages-total="1" data-page-current="1"></ul>
								<o:PageNavigation dpName="datas" css="linktag" />
						</div>
					</div>
				</footer>

			</section>
		</aside>
	</section>

	<!-- Modal -->
	<div class="modal fade" id="applist-modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加用户</h4>
				</div>
				<div class="modal-body" style="height: 400px; padding: 0;">
					<iframe id="modal-iframe" name=modal-iframe " src=""
						frameborder="0" height="100%" width="100%"
						style="height: 100%; width: 100%; border: 0px;"> </iframe>
				</div>
				<div class="modal-footer">
					<button type="button" id="modal-btn-close" class="btn btn-default"
						data-dismiss="modal">关闭</button>
					<button type="button" id="modal-btn-save" class="btn btn-primary">添加</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript" src="../resource/js/jquery.min.js"></script>
	<script type="text/javascript"
		src="../resource/js/plugins/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="../resource/js/core.page.js"></script>
	<script type="text/javascript">
		var listAction = "http://localhost:8080/obpm/saas/weioa/role/list.action";
	    var contextPath = '<%=request.getContextPath()%>';
		var USER = {
			id : '<s:property value="#session.FRONT_USER.getId()" />',
			name : '<s:property value="#session.FRONT_USER.getName()" />',
			domainId : '<s:property value="#session.FRONT_USER.getDomainid()" />'
		};
		$(function() {
			$("#btn-add-user").on("click",function(e){
				$("#modal-iframe").attr("src",contextPath+"/saas/weioa/role/userListUnjoinedRole.action?roleId=<s:property value='roleId'/>&domain="+USER.domainId);
				$("#applist-modal").modal({
				});
			});
			$("#modal-btn-save").on("click",function(e){
				$.ajax({
					   type: "POST",
					   url: contextPath+"/saas/weioa/role/addUserToRole.action?roleId=<s:property value='roleId'/>",
					   data: $(window.frames[0].document.forms["user-list"]).serialize(),
					   success: function(result){
					     $("#user-edit-modal").modal('hide');
					     location.reload();
					     //location=location 
					   },
					   error : function(r,s,e){
					   }
					});
			});
			$("#modal-btn-close").on("click",function(e){
				$(window.frames['modal-iframe'].document.body).html("");
				$("#user-edit-modal").modal('hide');
			});
		});
	</script>
</body>
	</html>
</o:MultiLanguage>