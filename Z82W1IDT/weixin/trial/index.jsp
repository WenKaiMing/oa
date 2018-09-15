<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="./images/favicon.ico">
    <title>微信办公 注册试用</title>
	<link href="./css/main.css" rel="stylesheet">
	
    <!-- Bootstrap core CSS -->
    <link href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="./js/zepto.min.js"></script>
    <script src="./js/helper.js"></script>
    <script src="./js/index.js"></script>

  </head>
  <body style="background-color: #eee;">
    <div id="msgbox" style="padding: 5px;margin: 0 auto;"></div>    	
    <div class="container" id="page-register" >    
      <form class="form-signin" id="form-register">     	      	
	    <header id="header" class="header">
	        <span class="cur">填写信息</span>
	        <span>扫码关注</span>
	    </header><br/>
      	
        <h2 class="form-signin-heading">每天限量200个名额 体验期为1周</h2>
        <label for="name" class="sr-only">请输入您的姓名</label>
        <input type="text" id="name" name="name" class="form-control" placeholder="请输入您的姓名" required autofocus>
        <label for="telephone" class="sr-only">请输入您的手机号码</label>
        		
        <input type="tel" id="telephone" name="telephone" class="form-control" placeholder="请输入您的手机号码" required>
        <input type="hidden" name="domainid" value="11e1-81e2-37f74759-9124-47aada6b7467">
        	<p class="tips">注:请务必填写您真实手机号码，否则将无法通过企业微信官方验证</p>
		       <!--
			       <div class="checkbox">
			          <label>
			          </label>
			        </div>
		        -->
        <button class="btn btn-lg btn-primary btn-block" id="btn-register" type="button">下一步</button>
      </form>

    </div>
     <!-- /container -->
	<div class="container-fluid">	
	<div class="row" id="page-qrcode" style="max-width: 420px;padding: 5px;margin: 0 auto;display: none;">	    
	  <div class="col-md-12">
  	    <header id="header" class="header">
	        <span>填写信息</span>
	        <span class="cur">扫码关注</span>
	    </header>
	    <br/>
	<div id="msgbox" style="padding: 5px;margin: 0 auto;"></div>  
	    <div class="thumbnail">
	      <img src="./images/qrcode.gif" alt="扫一扫">
	      <div class="caption">
              <h3 class="tips">温馨提示：</h3>
              <p>1.长按二维码，可将其保存到本地相册.</p>
              <p>2.打开微信扫一扫，点击扫码界面右上角，从相册中选取二维码进行扫描.</p>
              <p>3.企业号的体验有效期为1周.</p>
	        <p><a href="#" class="btn btn-primary" role="button">关闭</a></p>
	      </div>
	    </div>
	  </div>
	</div>
	</div>
	<br/><br/><br/><br/>
	<footer class="footer">客服热线：<a href="tel:400-0503-365" class="high">400-678-0211</a></footer>

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="./js/lib/jquery.js"></script>
	<script src="./js/lib/jquery.tmpl.js"></script>
	<script src="./js/core.js"></script>

	<script type="text/javascript">
	$(document).ready(function(){
		$.ajaxSetup({
	        error:function(x,e){
			alert("请求服务端发生异常,请稍后尝试！");
	        return false;
	        }
	    });
		
		WeixinTrial.init();
		
	});

	</script>
  </body>
</html>
