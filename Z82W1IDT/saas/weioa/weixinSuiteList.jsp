<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<!DOCTYPE html>
	<html lang="cn" class="app fadeInUp animated">
<head>
<meta charset="utf-8" />
<title>微OA365，开启微信办公新时代</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta content="微OA365 微信企业号 微信办公 移动OA 微信打卡 微信审批 移动协作平台 " name="Keywords" />
<meta content="微OA365,让工作更简单、高效，开启微信办公新时代。" name="Description" />
<link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resource/css/animate.min.css" rel="stylesheet" />
<link href="../resource/css/font-awesome.min.css" rel="stylesheet" />
<link href="../resource/css/style.min.css" rel="stylesheet" />
<link href="../resource/css/iconfont.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
</head>

<body>
	<section class="vbox">
		<header class="header bg-white b-b clearfix">
			<p>
				应用中心<small style="color: #333"></small>
			</p>
		</header>
		<section class="scrollable wrapper w-f">
			<section class="panel panel-default">
				<div class="panel-heading bg-light lter clearfix">
					<p class="panel-title" style="display: inline-block">
						<span
							style="font-size: 20px; margin-right: 30px;">微OA356协作办公套件</span>
							<!--  您已安装了0个应用套件，<a id="btn-install" style="color: #368ee0;cursor: pointer;" >点击批量安装</a>-->
					</p>
				</div>
				<div class="row m-l-none m-r-none bg-light lter panel-body">
				<s:iterator value="list" status="index" id="app">
					<div class="app-item center js_entity_view" data-id="<s:property value="appid" />" data-status="<s:property value="status" />">
						<img class="app-item-img" alt="微OA365 "
							src="<s:property value="logourl" />" />
						<div class="app-item-name"><s:property value="name" /></div>
						<div class="app-item-count"></div>
						<div class="app-item-versions"><s:property value="description" /></div>
					</div>
				</s:iterator>
				</div>
			</section>
		</section>
	</section>
		<div class="modal fade in" id="modal-install" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <form class="form-horizontal form-validate form-modal" method="post"  action="">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">温馨提示</h4>
                    </div>

                    <div class="modal-body">
                        <p>完成套件授权后，需要进入企业号管理后台设置应用的可见范围，否则无法在企业号中显示应用！</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" id="btn-complate" data-loading-text="">已完成授权,现在去设置可见范围</button>
                        <button type="button" class="btn btn-default" id="jumptolist" >返回</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal" style="display: none;">取消</button>
                        
                    </div>
                </form>
            </div>
        </div>
    </div>
	<script type="text/javascript" src="../resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="../resource/js/plugins/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript">
	    var contextPath = "<%=request.getContextPath()%>";
	    
	    //var serverAddr="http://yun.weioa365.com/obpm";
	    //var authAddr = "http://yun.weioa365.com/suite-service/suite/index.jsp";
	    var serverAddr="http://office.teemlink.com:9988/obpm";
	    var authAddr = "http://office.teemlink.com:7788/suite/suite/index.jsp";
		var USER = {
				id:'<s:property value="#session.FRONT_USER.getId()" />',
				name:'<s:property value="#session.FRONT_USER.getName()" />',
				domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
				};
		$(function () {
			$("#btn-install").on("click",function(e){
				var url = authAddr+"?state=";
	      		var domainid=USER.domainId;
	      		var memberId = USER.id;
	      		var params ="{";
	      		params+="domainId:'"+domainid+"',";
	      		params+="serverAddr:'"+serverAddr+"',";
	      		params+="memberId:'"+memberId+"'";
	      		params+="}";
	      		url+=encodeURIComponent(params);
	      		window.open(url);
	      		//$("#modal-iframe").attr("src",url);
	      		
	      		$("#modal-install").modal({});
			});
			
			$("#btn-complate").on("click",function(e){
				var url ="https://qy.weixin.qq.com/cgi-bin/home?lang=zh_CN&token=#app/list";
	      		window.open(url);
	      		//$("#modal-install").modal('hide');
	      		//$("#jumptolist").trigger("click");
			});
			
			$(".app-item").on("click",function(e){
				var appid = $(this).data("id");
				var status = $(this).data("status");
				if(status==1){
					alert("您已安装此应用！");
					return;
				}
				var url = authAddr+"?appid="+appid+"&state=";
	      		var domainid=USER.domainId;
	      		var memberId = USER.id;
	      		var params ="{";
	      		params+="domainId:'"+domainid+"',";
	      		params+="serverAddr:'"+serverAddr+"',";
	      		params+="memberId:'"+memberId+"'";
	      		params+="}";
	      		url+=encodeURIComponent(params);
	      		window.open(url);
	      		//$("#modal-iframe").attr("src",url);
	      		
	      		$("#modal-install").modal({});
			});
			
			$("#jumptolist").on("click",function(e){
				location.href = "list.action";
				$("#modal-install").modal('hide');
			});
			
		});
		
		
		
		
    </script>
</body>
	</html>
</o:MultiLanguage>