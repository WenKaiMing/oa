<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.constans.Web" %>
<%@ page import="cn.myapps.core.user.action.WebUser" %>
<%@ page import="cn.myapps.core.dynaform.document.ejb.DocumentProcess" %>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document" %>
<%@ page import="java.util.Collection" %>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.ActorRT" %>
<%@ page import="cn.myapps.core.workflow.storage.runtime.ejb.NodeRT" %>
<%@ page import="cn.myapps.core.workflow.engine.StateMachine" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String docid = request.getParameter("_docid");
	String _application = request.getParameter("application");
	DocumentProcess process = (DocumentProcess)ProcessFactory.createRuntimeProcess(DocumentProcess.class, _application);
	WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	
	Document doc = (Document)process.doView(docid);
	
	Collection<ActorRT> actors = null;
	
	NodeRT nodert = StateMachine.getCurrUserNodeRT(doc, user,null);
	if(nodert != null){
		actors = nodert.getAllActorrts();
	}
	
	request.setAttribute("actors", actors);
%>

<%@page import="cn.myapps.util.ProcessFactory"%><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.button-cmd a {
	color: #000;
	cursor: pointer;
	display: inline;
	float: left;
	height: 23px;
	font-size:14px;
	text-decoration: none;
}

.button-cmd a img{
	vertical-align: middle;
	border:none;
}

.button-cmd a:hover {
	background-repeat: repeat-x;
	color: #000;
	cursor: pointer;
	display: inline;
	float: left;
	height: 23px;
	text-decoration: none;
}

.button-cmd a span {
	background-repeat: repeat-x;
	cursor: pointer;
	display: inline;
	float: left;
	height: 23px;
	margin: 0 0 0 10px;
	padding: 3px 10px 3px 0;
}

.button-cmd a:hover span {
	background-repeat: repeat-x;
	cursor: pointer;
	display: inline;
	float: left;
	height: 23px;
	margin: 0 0 0 10px;
	padding: 3px 10px 3px 0;
}
.tableClass{
	border-left:1px solid #B4CCEE;
	border-bottom:1px solid #B4CCEE;
}
.tr-head{
	background:#E5EDF8;color:#6CC5F8;
	border:1px solid #f00;
	font-weight:bold;
	font-size:14px;
}
.tr-body{
	color:#636365;
	font-size:14px;
}
.listDataTrTd{
	border-top:1px solid #B4CCEE;
	border-right:1px solid #B4CCEE;
}
</style>
<script type="text/javascript" >
function moveup(obj){
	var current = jQuery(obj).parent().parent();
	var prev = current.prev();
	if(prev.index() > 0){
		current.insertBefore(prev);
	}
}

function movedown(obj){
	var current = jQuery(obj).parent().parent();
	var next = current.next();
	if(next){
		current.insertAfter(next);
	}
}

function ev_ok(){
	var result = '';
	var userlist = '"userlist":[';
	jQuery("input[name=userlist]").each(function(){
		var _userid = jQuery(this).attr("value");
		userlist += '"' + _userid + '",';
	});

	userlist = userlist.substring(0, userlist.length-1);

	userlist += ']';
	result = '{' + userlist + '}';

	OBPM.dialog.doReturn(result);
}

function ev_cancel(){
	OBPM.dialog.doReturn();
}

function ev_addAuditor(){
	document.getElementById("username").value = '';
	document.getElementById("userid").value = '';
	showUserSelectWithFlow('', {
		textField:"username",
		valueField:"userid",
		callback: function(result) {
			if (result) {
				var usernames = document.getElementById("username").value.split(";");
				var userid = document.getElementById("userid").value.split(";");
				var html = '';
				for(var i=0; i<userid.length; i++){
					var flag = true;
					jQuery("input[name=userlist]").each(function(){
						if(jQuery(this).attr("id") == userid[i]){
							flag = false;
						}
					});

					if(flag){
						html += '<tr align="center" class="usertr tr-body">';
						html += '<input type="hidden" name="userlist" id="' +userid[i] + '" value="' + userid[i] + '" />';
						html += '<td style="width:50%;" class="listDataTrTd">' + usernames[i] + '</td>';
						html += '<td style="width:25%;" class="listDataTrTd"><a href="javascript:void(0)" onClick="moveup(this)"><img border="0" src="<s:url value="/resource/image/leftStep.GIF"/>" /></a></td>';
						html += '<td style="width:25%;" class="listDataTrTd"><a href="javascript:void(0)" onClick="movedown(this)"><img border="0" src="<s:url value="/resource/image/rightStep.GIF"/>" /></a></td>';
					}
				}
				jQuery(".usertr").each(function(){
					if(jQuery(this).index() == '1'){
						jQuery(this).after(html);
					}
				});
			}
		}
	});
}

function showUserSelectWithFlow(actionName, settings, roleid) {
	var oApp = document.getElementsByName("application")[0];
	var url = contextPath + "/portal/share/component/dialog/selectUserByAddAuditor.jsp?application="+oApp.value;
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	
	OBPM.dialog.show({
				width : 700,
				height : 550,
				url : url,
				args : {
					// p1:当前窗口对象
					"parentObj" : window,
					// p2:存放userid的容器id
					"targetid" : settings.valueField,
					// p3:存放username的容器id
					"receivername" : settings.textField,
					// p4:默认选中值, 格式为[userid1,userid2]
					"defValue": settings.defValue,
					//选择用户数
					"limitSum": settings.limitSum,
					//选择模式
					"selectMode":settings.selectMode,
					// 存放userEmail的容器id
					"receiverEmail" : settings.showUserEmail
				},
				title : title_uf,
				close : function(result) {
					var textObj = document.getElementById(settings.textField);
					if(textObj != null){
						textObj.style.border = "1px solid #ff0000";
					}
					if (settings.callback) {
						if(typeof settings.callback == "function"){
							settings.callback(result);
						}else{//用户选择框控件
							eval(settings.callback);
						}
					}
				}
			});
}
</script>
<title>{*[cn.myapps.core.workflow.add_auditor]*}</title>
</head>
<body>
	<s:form name="addAuditor" theme="simple">
	<s:hidden name="auditorList" value="%{#parameters.auditorList}"/>
	<s:hidden name="application" value="%{#parameters.application}" />
	<s:hidden name="userid" id="userid"/>
	<s:hidden name="username" id="username" />
	<div style="width:100%;height:40px;">
		<span class="button-cmd">
			<a href="#" onclick="ev_addAuditor();">
				<span><img src="<s:url  value='/resource/imgnew/add.gif' />">{*[Add]*}</span>
			</a>
		</span>
		<span class="button-cmd">
			<a href="#" onclick="ev_ok();">
				<span><img src="<s:url  value='/resource/imgv2/front/act/act_4.gif' />">{*[OK]*}</span>
			</a>
		</span>	
		<span class="button-cmd">
			<a href="#" onclick="ev_cancel();">
				<span><img src="<s:url  value='/resource/imgv2/front/act/act_10.gif' />">{*[Cancel]*}</span>
			</a>
		</span>	
	</div>
	<table class="tableClass" style="width:100%;" border="0" cellpadding="0" cellspacing="0">
		<tr class="tr-head" align="center">
			<td style="width:50%;" class="listDataTrTd">{*[Name]*}</td>
			<td style="width:25%;" class="listDataTrTd">{*[Up]*}</td>
			<td style="width:25%;" class="listDataTrTd">{*[Down]*}</td>
		</tr>
		<s:iterator value="#request.actors" status="status">
			<tr align="center" class="usertr tr-body">
				<input type="hidden" name="userlist" id='<s:property value="actorid"/>' value='<s:property value="actorid"/>' />
				<td style="width:50%;" class="listDataTrTd"><s:property value="name"/></td>
				<td style="width:25%;" class="listDataTrTd">
					<a href="javascript:void(0)" onClick="moveup(this)"><img border="0" src="<s:url value="/resource/image/leftStep.GIF"/>" /></a>
				</td>
				<td style="width:25%;" class="listDataTrTd">
					<a href="javascript:void(0)" onClick="movedown(this)"><img border="0" src="<s:url value="/resource/image/rightStep.GIF"/>" /></a>
				</td>
			</tr>
		</s:iterator>
	</table>
	</s:form>
</body>
</html>
</o:MultiLanguage>