<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage>
<!DOCTYPE html>
<html>
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords"
	content="免费知识文档管理,云存储,免费网盘,网络硬盘,免费网络硬盘,最好的网盘,最安全的网盘,最大的网盘,最好的网络硬盘,最安全的网络硬盘,最大的网络硬盘,手机网盘,安全,免费,加密,永久保存,永不丢失,同步盘,跨平台,网络硬盘哪个好,免费大容量网络硬盘,网络U盘,云U盘,文件共享,相册,云相册,发文件到手机" />
<meta name="Description"
	content="翎盘是天翎科技开发的分享式云存储服务知识文档管理产品。为广大中小企业提供了存储容量大、免费、云端阅读、知识分享、安全、便携、稳定的跨平台文件存储、备份、传递和共享服务。" />

<title>{*[page.km.login_title]*}</title>

<link type="text/css" rel="stylesheet" href="resource/css/login.css" />
<!--[if (lt IE 8.0)]><link type="text/css" rel="stylesheet" href="resource/css/ie67.css" /><![endif]-->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="resource/script/jquery.placeholder.1.3.js"></script>

<script type="text/javascript" src="resource/script/qwrap.js"></script>

<script type="text/javascript">
function changeLanguage(){
	var language = document.getElementById("language").value;
	if(language!=null&&language!=""){
		document.forms[0].action = "<s:url value='/saas/changeLanguageKm.action' />" +"?language="+language;
		}else{document.forms[0].action = "<s:url value='/saas/changeLanguageKm.action' />";
		}
	
	document.forms[0].submit();
}	

$(document).ready(function(){
	$.Placeholder.init();
	//$("input[name='input1']").blur(function(){ alert("Custom event triggered."); });	
});
</script>
</head>
<body>
<div id="header">
<div  style="text-align:right;">
    	<span>{*[Language]*}：</span><s:select name = "language" id = "language" list="#mh.getTypeList()" value="#mh.getType(#session.USERLANGUAGE)" theme="simple" onchange="changeLanguage()" />
    </div>
	<div class="content">
		<div id="logo">
			<a title="{*[page.km.teemlink_disk]*}" href="http://km.xapps.net/"> </a>
		</div>
		<div id="nav" class="clearfix">
			<a href="http://www.teemlink.com/" class="cur">{*[page.km.teemlink_official_website]*}</a>
			<a href="admin/login.jsp" class="releasenote">{*[page.km.manager_login]*}</a>
		</div>
		<div
			style="position: absolute; color: rgb(234, 229, 94); top: 15px; right: 400px; line-height: 26px;">
		</div>
	</div>
	<div class="header-shadow"></div>
</div>
<div id="main">

	<script>
		if (top !== self) {
			top.location = location.href;
		}

		function show(img) {
			var src = img.getAttribute('src').replace('s-', ''), nImg = new Image();
			nImg.src = src;
			img.parentNode.appendChild(nImg);
		}
		function getSecurityCode() {
			var numkey = Math.random();
			document.getElementById("checkCodeImg").src = '<s:url value="/checkCodeImg"/>?num=' + numkey;
		}
		
	</script>
	<div id="funBoxBg">
		<div id="funBox">

			<div id="download">
				<span><br />{*[page.km.version]*}：V1.2.beta<br />{*[page.km.unlimited_number_of_user]*}<br />{*[page.km.updated]*}：2013-04-27<br />
				</span>
				<div class="btns"></div>
			</div>
			<div id="login">
				<h1>{*[page.km.login_teemlink_disk]*}</h1>
				<div class="regist clearfix">
					<span>{*[page.km.no]*}</span> <span class="iteemlink"></span> <span>{*[page.km.teemlink_disk_account]*}</span> <a
						href="register.jsp" target="_blank">{*[page.km.register]*}</a>
						<span style="clear: both;"></span>
					<s:if test="hasFieldErrors()">
						<span class="errorMessage"> 
						<s:iterator value="fieldErrors">
							*<s:property value="value[0]" />;
						</s:iterator>
						</span>
					</s:if>
				</div>
				<div id="modLoginWrap" class="mod-qiuser-pop">
					<form id="loginForm" method="post" action="kmlogin.action">
						<div class="login-wrap">
							<div>
								<span id="loginTitle"></span>
							</div>
							<div>
								<div class="quc-clearfix login-item">
									<label for="domainName">企业名</label> <span class=" input-bg">
										<input placeholder="{*[page.km.domain]*}" tabindex="1" id="domainName"
										name="domainName" autocomplete="off" maxlength="100"
										class="ipt tipinput1" type="text">
									</span><b style="display: none;" class="tips-wrong icon-loginAccount"></b>
								</div>
							</div>
							<div>
								<div class="quc-clearfix login-item">
									<label for="loginAccount">用户名</label> <span class=" input-bg">
										<input placeholder="{*[page.km.user_name]*}" tabindex="2" id="username"
										name="username" autocomplete="off" maxlength="100"
										class="ipt tipinput1" type="text">
									</span><b style="display: none;" class="tips-wrong icon-loginAccount"></b>
								</div>
							</div>
							<div class="password">
								<div class="quc-clearfix login-item">
									<label for="password">密码</label><span class="input-bg">
									<!--[if ( IE)]>
										<span id="pw_placeholder" style="font-size: 16px;margin: 7px;position: relative;top: 4px;color: rgb(169,169,169);">{*[page.km.password_enter]*}</span>
									<![endif]-->
									<input placeholder="{*[page.km.password_enter]*}" tabindex="3" id="password"
										name="password" maxlength="20" autocomplete="off"
										class="ipt tipinput1" type="password" style="color: #A9A9A9;"></span><b
										class="tips-wrong icon-lpassword"></b>
								</div>
							</div>
							<div class="find">
<span style="height:40px"><%
Object obj = request.getAttribute("showCode");
boolean showCode = false;
if (obj != null) {
	showCode = ((Boolean)obj).booleanValue();
}
if (showCode) { %>

<input type="text" css="code-input" style="height:20px;width:40px" name="checkcode" />
<img src="<s:url value="/checkCodeImg"/>" align="absmiddle" onclick="getSecurityCode(this);" width="70" height="26" id="checkCodeImg" />
<%} %><br/></span>
								<label for="iskeepalive"><input tabindex="4"
									name="iskeepalive" id="iskeepalive" checked="checked"
									type="checkbox"> {*[page.km.automatic_login]*}</label> <a
									href="registerfindpwd.jsp" target="_blank" class="fac"
									id="findPwd">{*[page.km.forgot_your_password]*}</a>

							</div>
							<div class="submit">
								<div>
									<input id="loginSubmit" value="" class="btn-login"
										type="submit">
								</div>
								<div class="no-account">
									<span class="no-account-text">{*[page.km.no_account]*}</span> <a href="###"
										class="fac clk-regnew">&nbsp;{*[page.km.sign_in]*}</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div id="slider">
				<div class="page page0" style="z-index:0">
					<img src="resource/img/s-content-page0.jpg" onload="show(this)"
						width="950" height="435" />
				</div>
				<div class="page page1">
					<img src="resource/img/s-content-page1.jpg" onload="show(this)"
						width="950" height="435" />
				</div>
				<div class="page page2">
					<img src="resource/img/s-content-page2.jpg" onload="show(this)"
						width="950" height="435" />
				</div>
				<div class="page page3">
					<img src="resource/img/s-content-page3.jpg" onload="show(this)"
						width="950" height="435" />
				</div>
				<div class="page page4">
					<img src="resource/img/s-content-page4.jpg" onload="show(this)"
						width="950" height="435" />
				</div>
				
				<div class="switch">
					<a href="#" data-index="0" onclick="return false;"><img
						src="resource/img/slider-focus.png"></a> 
					<a href="#" data-index="1" onclick="return false;"><img
						src="resource/img/slider-focus.png"></a>
					<a href="#" data-index="2" onclick="return false;"><img
						src="resource/img/slider-focus.png"></a>
					<a href="#" data-index="3" onclick="return false;"><img
						src="resource/img/slider-focus.png"></a>
					<a href="#" data-index="4" onclick="return false;"><img
						src="resource/img/slider-focus.png"></a>
				</div>
			</div>
		</div>
	</div>
	<ul id="desc" class="clearfix">
		<li class="space">
			<h3>{*[page.km.tip_a]*}</h3> <span>{*[page.km.tip_b]*}</span>
		</li>
		<li class="vol">
			<h3>{*[page.km.tip_c]*}</h3> <span>{*[page.km.tip_d]*}</span>
		</li>
		<li class="share">
			<h3>{*[page.km.tip_e]*}</h3> <span>{*[page.km.tip_f]*}</span>
		</li>
		<li class="search">
			<h3>{*[page.km.tip_g]*}</h3> <span>{*[page.km.tip_h]*}</span>
		</li>
		<li class="lock">
			<h3>{*[page.km.tip_i]*}</h3> <span>{*[page.km.tip_j]*}</span>
		</li>
		<li class="teemlink">
			<h3>{*[page.km.tip_k]*}</h3> <span>{*[page.km.tip_l]*}</span>
		</li>
	</ul>

</div>
<div id="footer">
	<span class="clearfix" style="">
		<a href="http://www.teemlink.com/bbs" target="_blank">{*[page.km.forum]*}</a> | <a
			href="http://www.teemlink.com" target="_blank">{*[page.km.teemlink_official_website]*}</a> | <a
			href="agreement.html" target="_blank" class="last-a">{*[page.km.use_agreement]*}</a>
	</span>
	Copyright&copy;2005-2013 360.CN All Rights Reserved Teemlink.<br>粤ICP证11093750号
</div>
<!--[if IE 6]>
<script type="text/javascript" src="resource/script/Ie6Filter.js"></script>
<script>
	DD_belatedPNG.fix('#logo a');
</script>
<![endif]-->
<!--[if IE 6]>
<script>
	DD_belatedPNG.fix('#slider .page img, #login, #slider .switch, #logo a');
</script>
<![endif]-->

</body>
</html>
</o:MultiLanguage>
<script type="text/javascript" src="resource/script/e2.js"></script>
