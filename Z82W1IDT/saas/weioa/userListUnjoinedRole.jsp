<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<!DOCTYPE html>
<html lang="cn" class="app fadeInUp animated">

<head>
    <meta charset="utf-8" />
    <title>微OA365</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
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
     <section class="vbox">
     <section class="scrollable wrapper w-f">
         <section class="panel panel-default  ">
             <div class="table-responsive">
             	<form action="" name="user-list">
                 <table class="table m-b-none entity-view text-center">
					<thead>
						<tr>
							<th class="with-checkbox">
                            	<input type="checkbox" id="inputCheck" />
                             </th>
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
							<td><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
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
					data-pages-total="1" data-page-current="1"></ul>
					<o:PageNavigation dpName="datas" css="linktag" />
			</div>
		</div>
	</footer>
 </section>
    
    <script type="text/javascript" src="../resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="../resource/js/plugins/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
	    $('#inputCheck').click(function() {
			$("input[name='_selects']").prop("checked", $(this).is(':checked'));
		}); 
	    var contextPath = '<%=request.getContextPath()%>';
		var USER = {
				id:'<s:property value="#session.FRONT_USER.getId()" />',
				name:'<s:property value="#session.FRONT_USER.getName()" />',
				domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
					};
		$(function () {
		});
    </script>
</body>
</html>
</o:MultiLanguage>