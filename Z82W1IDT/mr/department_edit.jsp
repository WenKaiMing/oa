<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>department_edit</title>
</head>
<body>

<s:form action="departmentEditAction" method="post" theme="simple">
<table border="1">
  <tr>
    <td>名称：</td>
    <td><s:textfield name="content.name" /></td>
    <td>编号：</td>
    <td><s:textfield name="content.code" /></td>
  </tr>
  <tr>
    <td colspan="4">
	<button type="button" onClick="forms[0].action='<s:url action="createuser"></s:url>';forms[0].submit();">新建</button>
	<button type="button" onClick="forms[0].action='<s:url action="deleteuser"></s:url>';forms[0].submit();">删除</button>
	<br/>
	名称：
	<s:textfield name="user1vo.name" />
	上级：
	<s:textfield name="user1vo.superior"/>
	
	<button type="button" onClick="forms[0].action='<s:url action="queryuser"></s:url>';forms[0].submit();">查询</button>
	<s:reset value="重置" />
	<br/>
	
<table border="1">
  <tr>
    <td>&nbsp; </td>
    <td>名称</td>
    <td>性别</td>
    <td>邮件</td>
    <td>爱好</td>
    <td>上级</td>
  </tr>
  <s:iterator value="content.users" >
  <tr>
    <td><s:checkbox name="pk" fieldValue="%{#id}"/></td>
    <td><s:property value="name"/></td>
    <td>
	<s:if test="gender==0">男</s:if><s:else>女</s:else>
	</td>
    <td><s:property value="email"/></td>
    <td>
	<s:if test="hobby==0">读书</s:if>
	<s:elseif test="hobby==1">体育运动</s:elseif>
	<s:elseif test="hobby==2">上网</s:elseif>
	<s:else>旅游</s:else>
	</td>
    <td><s:property value="superior"/></td>
  </tr>
  </s:iterator>
</table>
</td>
</tr>
</table>

<button type="button" onClick="forms[0].action='<s:url action="saveuser"></s:url>';forms[0].submit();">保存</button>
	
<a href="">下一页</a>
<a href="">尾页</a> <a href="#">1</a>页/共<a href="#">1</a>页

</s:form>


<h3><a href="index.jsp" >index</a></h3>
<s:debug></s:debug>

</body>
</html>