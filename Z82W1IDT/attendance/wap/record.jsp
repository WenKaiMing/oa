<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.Collection" %>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String userName = webUser.getName();
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>微考勤</title>
<link rel="stylesheet" href="./css/weui.min.css" />
<link rel="stylesheet" href="./css/calendar.css" />
<link rel="stylesheet" href="./css/style.css" />

<script src="./js/jquery-2.1.4.min.js"></script>
<script src="./js/template.js"></script>
<script src="./js/calendar.js"></script>
<script src="./js/attendance.core.js"></script>
<script src="./js/attendance.service.js"></script>
<script src="./js/attendance.util.js"></script>
</head>
<body>
	<div id="container" class="container am">
		<div class="page list js_show">
			<div class="page__bd">
				<div class="weui-cells  weiui-cells-am">
					<div class="weui-cell">
						<div id="attendance__calendar"></div>
					</div>
				</div>
				<div class="weui-cells__title">考勤</div>
				<div class="weui-cells-detail" id="AM-detail"></div>
				<div class="weui-cells-detail" id="other"></div>
			</div>
		</div>
	</div>
	<div data-role="footer" class="copyright">
		<div class="divfooter divfooter-signin">
			<a  data-ajax="false" class="sign_color1" href="../sign.jsp?application=am&action=signin">
				<div class="sign_img"></div>
				<div class="sign_txt">签到</div>
			</a>
		</div>
		<div class="divfooter divfooter-signout">
			<a  data-ajax="false"  class="sign_color1" href="../sign.jsp?application=am&action=signout">
				<div class="sign_img"></div>
				<div class="sign_txt">签退</div>
			</a>
		</div>
		<div class="divfooter divfooter-record">
			<a  data-ajax="false"  class="sign_color1" href="record.jsp?application=am">
				<div class="sign_img"></div>
				<div class="sign_txt">记录</div>
			</a>
		</div>
	</div>
<script type="text/html" id="AmList">
	{{each list as data}}
		<div class="weui-cell">
			<div class="weui-cell__bd gowork amList">
				<p>
					<span class="work">{{if data.type == "0" }}上班{{else}}下班{{/if}}:</span>
					<span class="workTime">{{data.signTime}}</span>
					<span class="status {{data.typeCol}}">({{data.statusType}})</span>
				<p class="workAddress">{{data.signAddress.name}}</p>
			</div>
		</div>
	{{/each}}
</script>
<script type="text/html" id="WorkDuration">
	<div class="weui-cell">
		<div class="weui-cell__bd workDuration">
			<p><span class="work">工作时长：</span><span class="longtime"></span></p>
		</div>
	</div>
</script>
<script type="text/html" id="noRecord">
	<div class="weui-cell">
		<div class="weui-cell__bd noRecord">
			<p>无记录</p>
		</div>	
	</div>
</script>

	<script>
	var contextPath = "<%=contextPath%>";
    var action = '<s:property value="#parameters.action" />';
    var _host ='<s:property value="#session.FRONT_USER.getDomain().getServerHost()" />';

    function showAttendanceDetail(id) {
        $.ajax({
            url: 'attendance/attendance/doQueryAttendanceDetail.action?attendanceId='+id,
            success: function(datas){
                $("#attendanceDetail-table-body").html($("#tmplAttendanceDetail").tmpl(datas.rows,{

                    signinTime : function(){
                        var startTime = this.data.signinTime;
                        var startTimeArr = startTime.split("T");
                        return startTimeArr[1];

                    },
                    signoutTime : function(){
                        var endTime = this.data.signoutTime;
                        if(!endTime) return "";
                        var endTimeArr = endTime.split("T");
                        return endTimeArr[1];
                    },
                    signdate : function(){
                        var attendancedate = this.data.attendanceDate;
                        var signdate = new Date(attendancedate).format("yyyy-MM-dd");
                        return signdate;
                    }
                }));

            }
        });
    }
    function onBridgeReady(){
        WeixinJSBridge.call('hideOptionMenu');
    }

    if (typeof WeixinJSBridge == "undefined"){
        if( document.addEventListener ){
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
        }else if (document.attachEvent){
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
    }else{
        onBridgeReady();
    }

    var USER = {
        id:'<s:property value="#session.FRONT_USER.getId()" />',
        name:'<s:property value="#session.FRONT_USER.getName()" />',
        domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
    };

    $(function(){
            if(action == 'signin'){
                var $signin =  $('.divfooter.divfooter-signin');
                $signin.siblings(".active").removeClass("active");
                if(!$signin.hasClass("active")){
                    $signin.addClass("active");
                }
            }else if(action == 'signout'){
                var $signout =  $('.divfooter.divfooter-signout');
                $signout.siblings(".active").removeClass("active");
                if(!$signout.hasClass("active")){
                    $signout.addClass("active");
                }
            }else{
                var $am =  $('.divfooter.divfooter-record');
                $am.siblings(".active").removeClass("active");
                if(!$am.hasClass("active")){
                    $am.addClass("active");
                }
            }
			 var nowDate = new Date().format("yyyy/mm/dd");
			 AM.Core.init(nowDate);
		})
	</script>
</body>
</html>
