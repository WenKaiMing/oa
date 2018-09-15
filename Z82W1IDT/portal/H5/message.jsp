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
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="resource/css/bootstrap-ie6.css">
<![endif]-->
    <!--[if lte IE 7]>
   <link rel="stylesheet" type="text/css" href="resource/css/ie.css">
   <link rel="stylesheet" type="text/css" href="resource/css/myapp-ie.css" />
   <link rel="stylesheet" type="text/css" href="resource/css/message-ie.css" />
<![endif]-->
    <!--[if lt IE 9]> 
   <script src="js/html5shiv.min.js"></script>
<![endif]-->
    <style type="text/css">
    html {
        overflow: hidden
    }
    </style>


</head>
<body>

    <div id="right" style="height: 100%; min-height:100%">
        <table style="height:100%; width:100%">
            <tr valign="top">
                <td width="145">
                    <div id="message" class="message">
                        <div class="title">消息</div>
                        <div class="content">
                            <ul id="menu_bar" class="nav nav-stacked">
                            	<li id="m_message">
                            		<a _url="../personalmessage/query.action?id=11e1-7f98-53d7e5e8-a04d-05b43c063ac2&messageType=0"><i class="iconfont-h5">&#xe028;</i><span>{*[message.instation_GoNews]*}</span></a>
								</li>

								<li id="m_sms">
                            		<a _url="../shortmessage/submission/list.action?application=11de-f053-df18d577-aeb6-19a7865cfdb6"><i class="iconfont-h5">&#xe026;</i><span>{*[message.phone_SMS]*}</span></a>
								</li>

                            </ul>
                        </div>
                    </div>
                </td>
                <td>
                    <div id="con_right" class="con_right"></div>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
    </div>

        <script src="resource/js/jquery-1.11.3.min.js"></script>
    <script src="resource/script/bootstrap.min.js"></script>
    <!--[if lte IE 6]>
    <script type="text/javascript" src="resource/script/bootstrap-ie.js"></script>
<![endif]-->
    <script type="text/javascript">
    $(function() {
        $("#menu_bar").find("li a")
            .click(
                function() {
                    $("#menu_bar").find("li.active").removeClass(
                        "active");
                    $(this).parent().addClass("active");
                    var url = $(this).attr("_url");
                    var id = "iframe_" + $(this).parent().attr("id");
                    $("iframe").hide();
                    if ($("#" + id).size() <= 0) {
                        $(
                                "<iframe id='" + id + "' style='border:none;height:" + $(window).height() + "px' width='90%' height='" + $(window).height() + "' scrolling='auto' frameborder='no' border='0'></iframe>")
                            .appendTo($("#con_right")).attr(
                                "src", url).show();
                    } else {
                        $("#" + id).show();
                    }
                });
        $("#m_message>a>span").trigger("click");
    });
    $(window).resize(function() {
        $("#con_right").css("width", $(window).width() - 145);
    });
    $("#con_right").css("width", $(window).width() - 145);
    </script>
    <!--[if lt IE 8]> 
    <script type="text/javascript">
        $(window).resize(function() {$("#con_right").css("width",$(window).width()-160);});
        $("#con_right").css("width",$(window).width()-160);
    </script>
<![endif]-->

</body>
</html>
</o:MultiLanguage>