<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="resource/css/myapp.css" />
    <link rel="stylesheet" type="text/css" href="resource/css/message.css" />


	<script src="resource/js/jquery-1.11.3.min.js"></script>
	<!-- <script type="text/javascript"
		src="./resource/jquery/jquery.layout-latest.js"></script> -->

	<script type="text/javascript">
		var $layout;
		$(function() {
			$("#kmIframeBox").height($(window).height()-3);

			$("#menu_bar>li>a>span").click(function() {
				$("#menu_bar>li.active").removeClass("active");
				$(this).parents("li").addClass("active");
				var url = $(this).parent().attr("_url");
				$("#center").attr("src", url);
			});

			//选择第一个
			$("#hotest>a>span").trigger("click");
		});
	</script>
</head>
<body>

    <div id="right" style="height: 100%; min-height:100%">
        <table style="height:100%; width:100%">
            <tr valign="top">
                <td width="145">
                    <div id="message" class="message">
                        <div class="title">知识文档管理</div>
                        <div class="content">
                            <ul id="menu_bar" class="nav nav-stacked">
                            
                            			<li id="hotest"><a _url="../../km/disk/listHotest.action"><span>{*[cn.myapps.km.disk.popular_share]*}</span></a></li>
			<li id="newest"><a _url="../../km/disk/listNewest.action"><span>{*[cn.myapps.km.latest_upload]*}</span></a></li>
			<li id="publicDisk"><a _url="../../km/disk/view.action?_type=1"><span>{*[cn.myapps.km.disk.public_disk]*}</span></a></li>
			<li id="personalDisk"><a
				_url="../../km/disk/view.action?_type=2"><span>{*[cn.myapps.km.disk.my_disk]*}</span></a></li>
			<li id="archiveDisk"><a _url="../../km/disk/view.action?_type=5"><span>{*[cn.myapps.km.disk.archive_disk]*}</span></a></li>
			<li id="baike"><a _url="../../km/baike/entry/doInit.action"><span>{*[km.encyclopedia]*}<font style="font-size:9pt;color:red;">(beta)</font></span></a></li>
		
                            	

                            </ul>
                        </div>
                    </div>
                </td>
                <td>
                    <div id="con_right" class="con_right" style="margin-top:3px;padding:0 15px 0 14px;">
                    	<div id="kmIframeBox" style="border-left: 1px solid #E3E3E3; border-right: 1px solid #E3E3E3;background:#fff;overflow: hidden;">
                    		<iframe id="center" src="" style="border:0px; margin:0px; padding:0px;" frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='auto' allowtransparency='yes'></iframe>
						</div>
                    </div>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
    </div>


	</div>
</body>
</html>
</o:MultiLanguage>