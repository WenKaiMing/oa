<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!doctype html>
<html lang="cn" class="app frameset">

<head>
    <meta charset="utf-8" />
    <title>微OA365</title>
    <base target="mainFrame" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content="" name="Keywords" />
    <meta content="" name="Description" />
    <link href="./resource/css/bootstrap.min.css" rel="stylesheet" />
    <link href="./resource/css/animate.min.css" rel="stylesheet" />
    <link href="./resource/css/font-awesome.min.css" rel="stylesheet" />
    <link href="./resource/css/controlpanel.min.css" rel="stylesheet" />
    <link href="./resource/css/iconfont.css" rel="stylesheet" />
    <!--[if lt IE 9]><script src="./resource/js/inie8.min.js"></script><![endif]-->

   
    <script type="text/javascript" src="./resource/js/jquery.min.js"></script>
    <script type="text/javascript">
    	$(function(){
			$("ul[class='nav'] li").click(function(){
				$("ul[class='nav'] li a .a1").hide();
				$("ul[class='nav'] li a .a0").show();
				$("ul[class='nav'] li a .a1").hide();
				$("ul[class='nav'] li a .a0").show();
				$(this).find("a .a0").hide();
				$(this).find("a .a1").show();
            	$("ul[class='nav'] li").attr("class","");
            	$("ul[class='nav'] li a").attr("class","guangli");
                $(this).find("a").attr("class","guangli active");
                $(this).attr("class","active");
			})
			$("ul[class='nav'] li a").mouseover(function(){
				$(this).find(".a0").hide();
				$(this).find(".a1").show();
				$(".active .a0").hide();
				$(".active .a1").show();
			})
			$("ul[class='nav'] li a").mouseout(function(){
				$(this).find(".a0").show();
				$(this).find(".a1").hide();
				$(".nav li a[class='guangli active'] .a0").hide();
				$(".nav li a[class='guangli active'] .a1").show();
			})
		})
    </script>
</head>

<body>
    <section class="vbox hidden-bsection">
        <header class="bg-dark header navbar navbar-fixed-top-xs">
            <div class="navbar-header">
                <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
                    <i class="fa fa-bars"></i>
                </a>
                <a href="org/list.action" class="navbar-brand" data-toggle="fullscreen">
                    <img src="./resource/images/logo.png?v=201504272206" class="m-r-sm" style="height:30px;margin-left:40px;">
                </a>
                <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user">
                    <i class="fa fa-cog"></i>
                </a>
            </div>
            <div class="msgbox"></div>
            <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user">
                <li class="hidden-xs">
                    <a href="../../portal/share/index.jsp" target="_self" class="nav-new-style nav-border-right" title="应用中心" >
                  
             
                        进入系统
                    </a>
                </li>
                <li class="hidden-xs">
                    <a href="http://www.teemlink.com/bbs/forum.php?mod=forumdisplay&fid=42" target="_blank" class="nav-new-style nav-border-right nav-border-left" title="帮助" >
                        帮助
                    </a>
                </li>

                <!-- 通知中心 @begin -->
                <li class="hidden-xs hidden">
                    <a href="#" class="dropdown-toggle nav-border-right nav-border-left nav-new-style" data-toggle="dropdown">
                        <i class="iconfont icon-newsnotice icon-size30"></i>
                        <span class="badge badge-sm up bg-danger m-l-n-sm js_msg_count"></span>
                    </a>
                    <section class="dropdown-menu aside-xl ">
                        <section class="panel bg-white js_msg_content">
                        </section>
                        <script type="text/html" id="js_msg_content_footer">
                            <footer class="panel-footer text-sm no-border">
                                <a href="/System/SetAccountNumber?t=" class="pull-right" title="消息通知设置"><i class="iconfont icon-noticeset"></i></a>
                                <a href="/System/NoticeMessageList?t=">查看所有消息</a>
                                <a href="javascript:;" data-path="/System/EmptyNoticeMessage?t=" class="m-l-sm js_msg_empty">清空全部未读</a>
                            </footer>
                        </script>
                    </section>
                </li>
                <!-- 通知中心 @end -->
                <li class="dropdown" >
                    <a href="javascript:void(0);" class="dropdown-toggle h54 nav-border-left" data-toggle="dropdown" >
                        <span class="thumb-sm avatar pull-left">
                                                            <img src="./resource/images/avatar1.jpg" alt="用户头像">
                                                    </span>
                        &nbsp;&nbsp;<s:property value="#session.FRONT_USER.getName()" />                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight">
                        <span class="arrow top"></span>
						<li>
                            <a href="./security/logout.jsp" data-toggle="ajaxModal" target="_self"><i class="iconfont icon-logout m-r-xs icon-size20"></i>退出</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </header>
        <section>
            <section class="hbox stretch">
                <aside class="bg-dark lter aside-md hidden-print hidden-xs nav-xs" id="nav">
    <section class="vbox">
        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="5px" data-color="#333333">
                <nav class="nav-primary hidden-xs">
                    <ul class="nav">
                    	<!-- 
							<li class="active">
                                <a href="app/list.action" target="mainFrame" class="guangli">
                                   <img src="./resource/images/login1.png" class="a0 login1" style="display: inline;">
                                   <img src="./resource/images/icon1.png" class="a1 icon1" style="display:none">
                                   
                                   <span>我的应用</span>
                                </a>
                            </li>
                         -->
                          <li class="active">
                                <a href="suite/list.action" target="mainFrame" class="toujian">
                                    <img src="./resource/images/login4.png" class="a0 login4">
                                    <img src="./resource/images/icon4.png" class="a1 icon4" style="display:none"><span>我的应用</span>
                                </a>
                            </li>
                            <li >
                                <a href="org/list.action" target="mainFrame" class="guangli">
                                    <img src="./resource/images/login2.png" class="a0 login2">
                                    <img src="./resource/images/icon2.png" class="a1 icon2" style="display:none"><span>通 讯 录</span>
                                </a>
                            </li>
                            <!-- 
                            <li>
                                <a href="/addressList/mrlist" class="fuquan">
                                    <img src="./resource/images/login3.png" class="a0 login3">
                                    <img src="./resource/images/icon3.png" class="a1 icon3" style="display:none"><span>角色赋权</span>
                                </a>
                            </li>
                             -->
                            <!-- 
                             <li>
                                <a class="shezhi"><img src="./resource/images/login5.png" class="a0 login5">
                                <img src="./resource/images/icon5.png" class="a1 icon5" style="display:none">
                                    <span>系统设置</span>
                                </a>
                            </li>
                             -->
                                            </ul>
                </nav>

    
            </div>
        </section>
    </section>
</aside>                <section id="content">
                    <section class="vbox">
                        <iframe id="mainFrame" name="mainFrame" src="suite/list.action" frameborder="0" height="100%" width="100%" style="background: url('') center no-repeat; height: 100%; width: 100%; border: 0px;"></iframe>
                    </section>
                </section>
            </section>
        </section>
    </section>
    <div class="pageload-overlay show"></div>
    <div id="loading_done"></div>
    <script type="text/javascript" src="./resource/js/plugins/bootstrap/bootstrap.min.js"></script>
   
                    
</body>


</html>
</o:MultiLanguage>