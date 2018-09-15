<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="java.util.Calendar" %>
<%
Calendar cld = Calendar.getInstance();
int currentYear = cld.get(Calendar.YEAR);
String userId = ((WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER)).getId();
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>{*[page.title]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href='<s:url value="/portal/share/css/login.css"/>'	type="text/css" />
<link rel="stylesheet" href='<s:url value="/portal/share/css/animate.min.css"/>' type="text/css" />
<script src='<s:url value="/portal/share/script/bootstrap/script/jquery.min.js"/>' ></script>
<script src='<s:url value="/portal/share/script/iepngfix_tilebg.js"/>'></script><!--png24图片兼容ie6 -->
<script>
var contextPath = '<%=request.getContextPath()%>';
function errorHide(){
	var errorText =  $('#errorMessage').text();
	if(errorText != ""){
		$('#errorCon').attr("style","");
		$('#errorCon').css("dispaly","block");
		$('#login-box').removeClass("animated bounceInDown");
	}
}
function typeChange(value) {
	var obj = document.getElementById("proxyShow");
	obj.style.visibility="hidden";
/* 	if (value=="1"){
		obj.style.visibility="visible";
	} */
}
function ev_save(type,_proxyUser){
	var radioes = document.getElementsByName("_userType");
	var options = $("#_proxyUserId").find("option");

	if(type!=0){
		radioes[0].checked=true;
		for(var j=0;j<options.length;j++){
			if(options.eq(j).attr("value") == _proxyUser){
				options.eq(j).attr("selected","selected");
			}
		}
	}else{
		radioes[1].checked=true;
		$("#_proxyUserId").find("option:checked").val(_proxyUser);
	}
	
	var _ssoType = '<%=request.getParameter("_ssoType")%>';
	if(_ssoType && "ad"==_ssoType){
		alert("_ssoType");
		var action = '<s:url action="loginProxy" namespace="/portal/login" />';
		var userTypes = document.getElementsByName("_userType");
		var _userType = 0;
		for(var i=0;i<userTypes.length;i++){
			if(userTypes[i].checked){
				_userType = userTypes[i].value;
				break;
			}
		}
		action+= "?_userType="+_userType+"&_proxyUser="+_proxyUser;
		document.forms[0].action = action;
	}
	//alert(document.forms[0].action);
	document.forms[0].submit();
}
function ev_init(){
	
	//追加多个代理人
	var _proxyUserNum = document.getElementById("_proxyUserId").options.length;
	for(var i= 0;i<_proxyUserNum;i++){
		var _proxyName = document.getElementById("_proxyUserId").options[i].text;
		var _proxyValue = document.getElementById("_proxyUserId").options[i].getAttribute("value");
		var _proxyHtml = "<a onclick=\"ev_save(1,'"+_proxyValue+"');\">"
			+"<div class='perImg'><img src='" +contextPath+ "/portal/share/images/login/dai_self.png' /></div>"
			+"<p class='p_user' value='"+_proxyValue+"'>"+_proxyName+"</p></a>";
		$("#xuanze").append(_proxyHtml);
	}
	typeChange("<s:property value="_userType"/>");
	errorHide();
}
</script>
</head>
<body onload="ev_init()" style="margin: 0px; text-align: center;">
	<s:form id="loginform" action="/portal/login/loginProxy.action" method="POST" theme="simple">
	<s:hidden name="debug" value="%{#parameters.debug}" id="debug" />
	<s:hidden name="returnUrl" value="%{#parameters.returnUrl}" />
	<s:hidden name="myHandleUrl" value="%{#request.myHandleUrl}" />
		<div align="center" class="container loginBg" style="padding-top: 1px;">			
		    <div class="login">
		    	<!-- <ul class="titleName">
		        	<li class="english">myApps|OBPM</li>
		            <li class="chinese">流程管理平台</li>
		        </ul> -->
		        <ul class="loginInfo">		        	
		            <li class="userTypeLi" style="dispaly:none;">
			            <span class="userTypeSpan">{*[page.login.user_type]*}</span>
			            <s:radio id="_userTypeId" name="_userType" onclick="typeChange(this.value)" theme="simple" list="_userTypes"></s:radio>
		            </li>
		            <li class="proxyShow" id="proxyShow" style="visibility:hidden;">
		            	<span class="proxyShowSpan">{*[User]*}</span>
		            	<s:select id ="_proxyUserId" name="_proxyUser" theme="simple" list="_proxyUsers"></s:select>
		            </li>
		            <!-- <li class="operationLi" >
		            	<input type="button" id="save_btn"  alt="{*[Reset]*}" onclick="ev_save();" value="{*[Login]*}" class="btn_login" />
						<input type="button" alt="{*[Reset]*}" onclick="javascript:history.go(-1);" value="{*[Back]*}" class="btn_login" />
		            </li>-->
		        </ul>
		    </div>
		    <table class="login-box agent-box animated fadeInDown" style="margin-top:100px;">
				<tr>
					<td>
						<div class="login agent_con">
							<div class="top">
								<p class="title">
									<a class="a-return" onclick="javascript:history.go(-1);" alt="{*[Reset]*}">
										<span class="dai-return">重新登录</span>
									</a>
								</p>
							</div>
							<div class="xuanzeTitle">
								用户选择
							</div>
							<div class="content xuanze" id="xuanze">
								<a onclick="ev_save(0,'<%=userId %>');"><!-- 设置本人 -->
									<div class="perImg"><img src='<s:url value="/portal/share/images/login/dai_self.png"/>' /></div>
									<p class="p_self">自己</p>
								</a>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<div class="errorCon animated bounceInDown" id="errorCon" style="display:none;">
    <div class="errorMsg">
		<s:if test="hasFieldErrors()">
			<span class="errorMessage" id="errorMessage"> 
			<b style="display:block;">
			<s:iterator value="fieldErrors">
				<s:property value="value[0]"/><br/>
			</s:iterator>
			</span>
		</s:if>
	</div>
</div>
		    <div class="copyright loginBg">
		    	<span>{*[front.page.login.copyright]*}</span>
		    </div>       
		</div>
	</s:form>
</body>
</html>
</o:MultiLanguage>
