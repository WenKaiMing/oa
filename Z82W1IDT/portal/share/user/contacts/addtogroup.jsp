<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<s:bean name="cn.myapps.core.usergroup.action.UserGroupHelper" id="uh" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.usergroup.addtogroup]*}</title>
</head>
<style type="text/css">
	#usergroupid{
	width:200px;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.btn {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px
}
.confirm {
    display: inline-block;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    color: #fff;
    background-color: #5cb85c;
    border-color: #4cae4c;
}
.confirm:hover {
    color: #fff;
    background-color: #449d44;
    border-color: #398439;
}
</style>
<script type="text/javascript">
function ev_ok(){
	var usergroupid=document.getElementById("usergroupid").value;
	if(usergroupid!=null&&usergroupid!=""){
		document.forms[0].action = '<s:url value="/portal/usergroup/addtogroup.action" />';
		document.forms[0].submit();
	}else{
		alert("{*[cn.myapps.core.usergroup.group_select]*}");
	}
}
function ev_close(){
	OBPM.dialog.doReturn();
}
</script>
<body>
	<%@include file="/portal/share/common/msg.jsp"%>
	<br/>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
		<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
	<s:form action="" method="post" theme="simple">
	<s:hidden name="userids" id="userids" value="%{#parameters._selects}"></s:hidden>
	<table align="center" style="margin-top: 80px;">
		<tr>
			<td>
				{*[cn.myapps.core.usergroup.addtogroup]*}:
				<s:select name="usergroupid" id="usergroupid" list="#uh.getAllGroupByUser(#session.FRONT_USER.id)" emptyOption="true" theme="simple"></s:select>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;">
				<input type="button" value="{*[Close]*}" class="btn" onclick="ev_close()"/>
				<input type="button" value="{*[cn.myapps.core.usergroup.submit]*}" onclick="ev_ok()" style="margin: 10px;" class="btn confirm"/>
			</td>
		</tr>
	</table>
	</s:form>
</body>
</o:MultiLanguage>
</html>