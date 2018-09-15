<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
   String contextPath = request.getContextPath();
   String result = (String)request.getAttribute("result");
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head><title>{*[{Import result]]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css"></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url id="url" value='/resourse/main.css'/>"/>
<body>
<script type="text/javascript">

var result = '<%=result%>';
var jsonObject = eval('(' + result + ')'); 

//结果返回数据
var update_user_success = jsonObject.general.USER_ADD_SUCCESS;
var update_dept_success = jsonObject.general.DEPT_ADD_SUCCESS;
var update_user_fail = jsonObject.general.USER_ADD_FAIL;
var update_dept_fail =jsonObject.general.DEPT_ADD_FAIL;

$(function(){


	$("#update_user_success").text(update_user_success);
	$("#update_dept_success").text(update_dept_success);
	$("#update_user_fail").text(update_user_fail);
	$("#update_dept_fail").text(update_dept_fail);

	//详细情况添加相关数据
	var detail = jsonObject.detail;
	for(var index = 0 ; index < detail.length; index ++){
		var obj = detail[index];
		var NAME = obj.NAME ;
		var EMAIL = obj.EMAIL ;
		var ROWNUM = obj.ROWNUM;
		var LOGINNO = obj.LOGINNO;
		var TELEPHONE = obj.TELEPHONE;
		var depts = obj.depts;
		var error = obj.error;
		var tips = ""; 
		for(var opt = 0 ; opt < error.length ; opt++){
			tips += error[opt];
			tips +=",";
		}
		tips = tips.substring(0,tips.length-1);
		
		var $table= $("#result_detail");
		var vTr= "<tr><td>"+ROWNUM+"</td><td>"+NAME+"</td><td>"+LOGINNO+"</td><td>"+TELEPHONE+"</td><td>"+EMAIL+"</td><td>"+depts+"</td><td>"+tips+"</td></tr>";
		$table.append(vTr);
	}
})

	
</script>

<table>
<tr><td>
<s:if test="hasFieldErrors()">
	<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
	<s:iterator value="fieldErrors">
		*<s:property value="value[0]" />;</br>
	</s:iterator> </span>
</s:if><s:else>
<div class="result_list">
		<p>成功同步部门<span class="success_num" id="update_dept_success"></span>个，失败<span class="fail_num" id="update_dept_fail"></span>个</p>
		<p>成功同步用户<span class="success_num" id="update_user_success"></span>个，失败<span class="fail_num" id="update_user_fail"></span>个</p>
</div>
<div>
<div>详细情况</div>
<table id = result_detail>
      <tr>
      	<th>列号</th>
      	<th>姓名</th>
      	<th>账号</th>
      	<th>手机</th>
      	<th>邮箱</th>
      	<th>部门</th>
      	<th>错误提示</th>
      </tr>
</table>
</s:else>
</td></tr>

<tr>
<td>
<s:property value="_msg" />
</td>
</tr>
</table>

</div>	  	
</body>
</o:MultiLanguage></html>
