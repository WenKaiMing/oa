<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.usergroup.inputname]*}</title>
<style type="text/css">
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

.btn.active.focus,.btn.active:focus,.btn.focus,.btn:active.focus,.btn:active:focus,.btn:focus {
    outline: thin dotted;
    outline: 5px auto -webkit-focus-ring-color;
    outline-offset: -2px
}

.btn.focus,.btn:focus,.btn:hover {
    color: #333;
    text-decoration: none
}

.btn.active,.btn:active {
    background-image: none;
    outline: 0;
    -webkit-box-shadow: inset 0 3px 5px rgba(0,0,0,.125);
    box-shadow: inset 0 3px 5px rgba(0,0,0,.125)
}
.btn-danger {
    color: #fff;
    background-color: #d9534f;
    border-color: #d43f3a
}

.btn-danger.focus,.btn-danger:focus {
    color: #fff;
    background-color: #c9302c;
    border-color: #761c19
}

.btn-danger:hover {
    color: #fff;
    background-color: #c9302c;
    border-color: #ac2925
}

.btn-danger.active,.btn-danger:active,.open>.dropdown-toggle.btn-danger {
    color: #fff;
    background-color: #c9302c;
    border-color: #ac2925
}

.btn-danger.active.focus,.btn-danger.active:focus,.btn-danger.active:hover,.btn-danger:active.focus,.btn-danger:active:focus,.btn-danger:active:hover,.open>.dropdown-toggle.btn-danger.focus,.open>.dropdown-toggle.btn-danger:focus,.open>.dropdown-toggle.btn-danger:hover {
    color: #fff;
    background-color: #ac2925;
    border-color: #761c19
}
.btn-success {
    color: #fff;
    background-color: #5cb85c;
    border-color: #4cae4c
}

.btn-success.focus,.btn-success:focus {
    color: #fff;
    background-color: #449d44;
    border-color: #255625
}

.btn-success:hover {
    color: #fff;
    background-color: #449d44;
    border-color: #398439
}

.btn-success.active,.btn-success:active,.open>.dropdown-toggle.btn-success {
    color: #fff;
    background-color: #449d44;
    border-color: #398439
}

.btn-success.active.focus,.btn-success.active:focus,.btn-success.active:hover,.btn-success:active.focus,.btn-success:active:focus,.btn-success:active:hover,.open>.dropdown-toggle.btn-success.focus,.open>.dropdown-toggle.btn-success:focus,.open>.dropdown-toggle.btn-success:hover {
    color: #fff;
    background-color: #398439;
    border-color: #255625
}

.btn-success.active,.btn-success:active,.open>.dropdown-toggle.btn-success {
    background-image: none
}

.btn-success.disabled,.btn-success.disabled.active,.btn-success.disabled.focus,.btn-success.disabled:active,.btn-success.disabled:focus,.btn-success.disabled:hover,.btn-success[disabled],.btn-success[disabled].active,.btn-success[disabled].focus,.btn-success[disabled]:active,.btn-success[disabled]:focus,.btn-success[disabled]:hover,fieldset[disabled] .btn-success,fieldset[disabled] .btn-success.active,fieldset[disabled] .btn-success.focus,fieldset[disabled] .btn-success:active,fieldset[disabled] .btn-success:focus,fieldset[disabled] .btn-success:hover {
    background-color: #5cb85c;
    border-color: #4cae4c
}

.btn-success .badge {
    color: #5cb85c;
    background-color: #fff
}
.sett-form-control {
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.sett-form-control input{
	border:none;
	outline:medium;
}
</style>
</head>
<script type="text/javascript" >
	function ev_ok(type){
		var name = document.getElementById("name").value;
		if(!name){
			alert("{*[cn.myapps.core.usergroup.inputname]*}");
			return;
		}
		if(type == 'save'){
			document.forms[0].action = '<s:url value="/portal/usergroup/save.action" />';
			document.forms[0].submit();
		}else if(type == 'save_new'){
			document.forms[0].action = '<s:url value="/portal/usergroup/saveNew.action" />';
			document.forms[0].submit();
		}else if(type == 'save_close'){
			document.forms[0].action = '<s:url value="/portal/usergroup/save.action" />';
			document.forms[0].submit();
			OBPM.dialog.doReturn();
		}
	}
	function ev_close(){
		OBPM.dialog.doReturn();
	}
</script>
<body>
	<s:form name="usergroup" action="/portal/usergroup/save.action" method="post" theme="simple">
		<div style="height:36px;"> <%@include file="/portal/share/common/msg.jsp"%></div>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
				<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<s:hidden name="content.id" />
		<s:hidden name="domain" value="%{#parameters.domain}" />
		<div style="width: 210px;margin:20px auto 20px;" class="sett-form-control">
			<s:textfield name="content.name" id="name" placeholder="请输入..."/>
		</div>
		<div style="text-align: right;margin-right:50px;">
			<input type="button" value="{*[Close]*}" class="btn" onclick="ev_close()"/>
			<input type="button" value="{*[Save]*}" class="btn btn-success" onclick="ev_ok('save')"/>
			<!-- <input type="button" value="{*[Save&New]*}" onclick="ev_ok('save_new')"/>
			<input type="button" value="{*[Save&Close]*}" onclick="ev_ok('save_close')"/> -->
			
		</div>
	</s:form>
</body>
</o:MultiLanguage>
</html>