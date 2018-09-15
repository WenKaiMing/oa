<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../resource/images/favicon.ico">

    <title>登录 微OA365云办公平台 开启微信办公新时代</title>

    <!-- Bootstrap core CSS -->
    <link href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../resource/css/style.css">
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond/1.4.2/respond.min.js"></script>
	<script type="text/javascript">FileManager.get('http://core.pc.lietou-static.com/revs/js/common/DD_belatedPNG_849d7004.js');</script>
	<script>DD_belatedPNG.fix('.pngfix');</script>
<[endif]>

<script src="../resource/js/jquery.min.js" type="text/javascript"></script>
<script src="../resource/js/plugins/bootstrap/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#errorSpan").css("display","block");
		setTimeout("hideTip()" , 2000);
	});
	function hideTip(){
		$("#errorSpan").css("display","none");
	}

	</script>
  </head>

  <body>
  		<div class="container">
		<section class="loginBox row-fluid" style="	height: 350px;">
			<section class="login">
            	<div class="logo">
                  	<img style="margin-left:20px; width:100px;height:100px; margin-bottom:20px;margin-top:8px;" src="../resource/images/logo1.png">    
                </div>
                <span style="font-size:20px; color:#646464 ; margin-left:66px; font-weight:300">开启微信办公新时代</span>
            </section>

			<section class="span7 left">
		<form class="form-signin" id="form-login" action="login.action" method="post">
				<div class="name" style="margin-top:10px; margin-left:40px; border-width: 1px;border-radius: 4px;border-color: #c6d0db; width:220px; height:32px;  background-color:rgba(231, 237, 243, 0.39)">
					<img style="margin-left:7px;" width="20" src="../resource/images/icon11.png"/>
					<input type="text" value="" placeholder="请输入邮箱账号" tal="username" style="font-size:10px;padding-left:5px;color:#646464;width:188px; border:0; background-color:rgba(169, 185, 201, 0.34); height:32px;" name="username" id="username" tabindex="1" autocomplete="off" />
				</div>
				<div class="password" style="margin-top:10px; margin-left:40px; border-width: 1px;border-radius: 4px;border-color: #c6d0db; width:220px; height:32px;  background-color:rgba(231, 237, 243, 0.39);">
					<img style="margin-left:7px; margin-top:-3px;" width="20" src="../resource/images/icon21.png"/>
					<input type="password" value="" placeholder="请输入密码" style="padding-left:5px; color:#646464;width:188px; border:0; background-color:rgba(169, 185, 201, 0.34); height:32px;" name="password" maxlength="16" id="password" tabindex="2" />
				</div>
                <div style="margin-top:1px; margin-left:40px; height:40px; width:230px;">
                	<input type="checkbox" style="margin-top:11px; margin-left:0px; float:left" name="remenberMe" value="1">
                	<label style="color:#646464;margin-top:10px; margin-left:5px; width: 90px; font-size:12px; ">记住登陆状态</label></div>
				<div>

				<s:if test="#request.failtoLogin=='failtoLogin'">
                	<span id="errorSpan" style="font-size:10px; margin-left:90px; color:#ff0000; display:block;margin-top:-5px">用户不存在或密码错误</span>
				</s:if>
			
						<input type="submit" id="btn-login" style="margin-top:0px; margin-left:40px; height:35px; width:220px; font-size:18px; background-image:url(images/but.png);" value="登录" class="btn btn-primary">
                </div>
 				<span style="margin-left:165px; font-size:12px; color:#676b6f; display:inline"><a href=" href="http://yun.weioa365.com/suite-service/signup/"">注册</a></span>	
                <span style="margin-left:20px; font-size:12px; color:#676b6f;display:inline"><a href="http://yun.weioa365.com/suite-service/forgotpwd/">忘记密码</a></span>
                
        </form>
               
</section>
		
	<!-- /container -->
	<div class="screenbg">
		<ul>
			<li><a href="#"><img src="../resource/images/bg.png"/></li>
		</ul>
	</div>
	</div>
	<div class="copy">
		<img src="../resource/images/login.png" style="position:fixed;bottom:14px; left:50%; margin-left:-200px">
		<span style="position:fixed; color:#FFFFFF; bottom:10px; left:50%; margin-left:-184px; font-size:12px">Copyright ? 2013 TEEMLINK 广州市天翎网络科技有限公司 版权所有</span>
	</div>
	
  </body>
</html>