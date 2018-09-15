<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>department</title>
<link href="css/style1.css" type="text/css" rel="stylesheet" />




<script src="http://res.xiami.net/pc/lay/lib.js"></script>
		<script src="layer/layer.min.js"></script>
		<script type="text/javascript" src="mylayer.js" ></script>
		<script type="text/javascript" src="laydate/laydate.js" ></script>
		<script type="text/javascript" src="js/mr.core.js" ></script>
		<script type="text/javascript" src="./js/plugin/jquery.tmpl.js"></script>
</head>
<body>
<h1>部门列表界面</h1>

<s:form action="department1Action" method="post" theme="simple" namespace="/test/department">
	
	<button type="button" onClick="forms[0].action='<s:url action="create"></s:url>';forms[0].submit();">新建</button>
	<button type="button" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();">删除</button>
	<br/>
	名称：
	<s:textfield name="department1.name" />
	编号：
	<s:textfield name="department1.code" value="0" onkeyup="value=value.replace(/[^\d]/g,'')"/>
	<button type="button" onClick="forms[0].action='<s:url action="query"></s:url>';forms[0].submit();">查询</button>
	<s:reset value="重置" />
	<br/>
	
<table border="1" class="rowhand">
  <tr>
    <td>&nbsp; </td>
    <td>名称</td>
    <td>编号</td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>名称</td>
    <td>编号</td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>名称</td>
    <td>编号</td>
  </tr>
  <s:iterator value="datas.datas" id="department">
  <tr>
    <td><s:checkbox name="pk" fieldValue="%{#department.id}"/></td>
    <td><a href="create.action?param=<s:property value="#department.id"/>" ><s:property value="#department.name"/></a></td>
    <td><s:property value="#department.code"/></td>
  </tr>
  </s:iterator>
</table>
<a href="">下一页</a>
<a href="">尾页</a> <a href="#">1</a>页/共<a href="#">1</a>页

</s:form>


<h3><a href="index.jsp" >index</a></h3>

<s:debug></s:debug>
</body>
</html>