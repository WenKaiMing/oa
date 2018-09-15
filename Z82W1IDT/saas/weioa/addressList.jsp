<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<!DOCTYPE html>
	<html lang="cn" class="app fadeInUp animated">

<head>
<meta charset="utf-8" />
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta content=" " name="Keywords" />
<meta content="" name="Description" />
<link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resource/css/animate.min.css" rel="stylesheet" />
<link href="../resource/css/font-awesome.min.css" rel="stylesheet" />
<link href="../resource/css/style.min.css" rel="stylesheet" />
<link href="../resource/css/iconfont.css" rel="stylesheet" />
<link href="../resource/js/plugins/jstree/themes/default/style.min.css"
	rel="stylesheet" />
<script type="text/javascript" src="../resource/js/jquery.min.js"></script>
<link href="../resource/js/plugins/messenger/messenger.css" type="text/css" rel="stylesheet" />
<link href="../resource/js/plugins/messenger/messenger-theme-flat.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../resource/js/plugins/messenger/messenger.min.js"></script>
<script type="text/javascript" src="../resource/js/plugins/messenger/messenger-theme-flat.js"></script>
<!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
</head>

<body>
	<section class="hbox stretch">
		<aside class="aside-md bg-white b-r">
			<div class="wrapper b-b header">
				<b>通讯录</b><small class="m-l-xs text-muted">右键可编辑</small>
			</div>
			<div id="js_party_tree" class="js_party_tree  tree_box"
				data-method-path="/addressList/{0}" data-selected="" data-edit="1"></div>
		</aside>
		<aside>
			<section class="vbox">
				<header class="header bg-white b-b clearfix">
					<%@include file="/common/msg.jsp"%>
					<form class="talbe-search" method="post" action="list.action">
						<div class="row m-t-sm">
							<div class="col-sm-8 m-b-xs">
								<div class="btn-group">
									<!-- 添加成员操作 -->
									<button type="button" class="btn btn-sm btn-default"
										id="user-btn-create" title="新建">新建</button>
									<!-- 批量删除 -->
									<button type="button" class="btn btn-sm btn-default"
										id="user-btn-delete" title="删除" data-toggle="batch">
										删除</button>
								</div>

								<!-- 同步 -->
								<div class="btn-group">
									<button type="button" class="btn btn-default btn-sm "
										data-toggle="modal" data-target="#js_modal">
										同步通讯录
									</button>
								</div>
							</div>
							<div class="col-sm-4 m-b-xs ">
								<div class="input-group">
									<input type="text" class="input-sm form-control" name="keyword"
										value="" placeholder="请输入姓名/账号/电话"/> <span class="input-group-btn">
										<button class="btn btn-sm btn-default" type="submit"
											title="搜索">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
						<input type="hidden" name="pageNumber" id="pageNumber" value="1" />
						<input type="hidden" name="orderBy" id="orderBy" value="desc" />
						<input type="hidden" name="order" id="order" value="depart" /> <input
							type="hidden" name="bdid" value="">
						<input type="hidden" name="_currpage" value="<s:property value="datas.pageNo"/>"/>
						<input type="hidden" name="_pagelines" value="<s:property value="datas.linesPerPage"/>"/>
						<input type="hidden" name="_rowcount" value="<s:property value="datas.rowCount"/>"/>
					</form>
				</header>
				<section class="scrollable wrapper w-f">
					<section class="panel panel-default  ">
						<div class="table-responsive">
							<form action="deleteUser.action" name="user-list">
								<table class="table table-hover m-b-none entity-view">
									<thead>
										<tr>
											<th class="with-checkbox"><input type="checkbox" id="inputCheck"/></th>
											<th>姓名</th>
											<th>帐号</th>
											<th>电话</th>
											<th>邮箱</th>
											<th>状态</th>
										</tr>
									</thead>
									<tbody>
										<s:iterator value="datas.datas" status="index" id="uservo">
											<tr data-id="<s:property value="id"/>"
												data-domainid="<s:property value="domainid"/>">
												<td><input type="checkbox" name="_selects"
													value="<s:property value="id"/>"></td>

												<td data-id="<s:property value="id"/>"
													data-domainid="<s:property value="domainid"/>"
													class="user-item"><img
													src="
	                                             	<s:if test="avatar !=null && avatar!=''"><s:property value="getAvatarUri()"/></s:if>
	                                        		<s:else>../resource/images/avatar1.jpg</s:else>
	                                              "
													alt="<s:property value='name' />" class="face"> <s:property
														value="name" /></td>
												<td data-id="<s:property value="id"/>"
													data-domainid="<s:property value="domainid"/>"
													class="user-item"><s:property value="loginno" /></td>
												<td data-id="<s:property value="id"/>"
													data-domainid="<s:property value="domainid"/>"
													class="user-item"><s:property value="telephone" /></td>
												<td data-id="<s:property value="id"/>"
													data-domainid="<s:property value="domainid"/>"
													class="user-item"><s:property value="email" /></td>
												<td><s:if test="dimission == 1">
													{*[cn.myapps.core.user.isdimission.on_job]*}
													</s:if> <s:else>
													{*[cn.myapps.core.user.isdimission.dimission]*}
													</s:else></td>
											</tr>
										</s:iterator>
									</tbody>
								</table>
							</form>
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
								data-pages-total="1" data-page-current="1">
								<o:PageNavigation dpName="datas" css="linktag" />
							</ul>
						</div>
					</div>
				</footer>
			</section>

			<div class="modal fade in" id="js_modal" tabindex="-1" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<form class="form-horizontal form-validate form-modal"
							method="post" action="synch.action">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title">温馨提示</h4>
							</div>

							<div class="modal-body">
								<p>建议您今后在微OA365中修改和添加通讯录员工信息将自动同步到微信端后台，如在微信后台修改，请点击“同步通讯录”与微OA365通讯录进行合并，以便员工能够正常使用相关功能，如需多次同步通讯录建议隔5分钟后再操作。</p>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary"
									data-loading-text="同步中....">确认</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">取消</button>
							</div>
						</form>
					</div>
				</div>
			</div>

		</aside>
	</section>
	<script type="text/javascript"
		src="../resource/js/plugins/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="../resource/js/plugins/jstree/jstree.min.js"></script>
	<script type="text/javascript" src="../resource/js/core.utils.js"></script>
	<script type="text/javascript" src="../resource/js/core.member.js"></script>
	<script type="text/javascript" src="../resource/js/core.page.js"></script>
	
	<script type="text/javascript">
		$('#inputCheck').click(function() {
			$("input[name='_selects']").prop("checked", $(this).is(':checked'));
		}); 
		var listAction = "/obpm/saas/weioa/org/list.action";
    	var contextPath = '<%=request.getContextPath()%>';
		var USER = {
			id : '<s:property value="#session.FRONT_USER.getId()" />',
			name : '<s:property value="#session.FRONT_USER.getName()" />',
			domainId : '<s:property value="#session.FRONT_USER.getDomainid()" />'
		};
		$(function() {
			AddressList.init();
		});
	</script>



	<!-- Modal -->
	<div class="modal fade" id="user-edit-modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编辑用户</h4>
				</div>
				<div class="modal-body" style="height: 430px; padding: 0;">
					<iframe id="user-edit-iframe" name="user-edit-iframe" src=""
						frameborder="0" height="100%" width="100%"
						style="height: 100%; width: 100%; border: 0px;"> </iframe>
				</div>
				<div class="modal-footer">
					<div id="alert-danger" class="alert alert-danger alert-dismissible fade in" role="alert" style="height:50px;display:none;top:40%;left:25%;position:absolute;">
	     			 	<button type="button" class="close" onclick="$('#alert-danger').hide();" aria-label="Close" style="position:absolute;right:10px;top:25%;"><span aria-hidden="true">×</span></button>
	    				<div class="alert-body" style="padding: 0;">
						<iframe id="user-edit-result-iframe" name="user-edit-result-iframe" src=""
							frameborder="0" height="100%" width="100%"
							style="height: 100%; width: 100%; border: 0px;"> </iframe>
						</div>
	   	 			</div>
					<button type="button" id="user-edit-modal-btn-close"
						class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="user-edit-modal-btn-save"
						class="btn btn-primary">保存</button>
						
				</div>
			</div>
		</div>
	</div>

	
</body>


	</html>
</o:MultiLanguage>