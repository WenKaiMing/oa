<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.extendedReport.NDataSource"%>
<%

if(!NDataSource.isErpEnable()){
	new OBPMDispatcher().sendRedirect(request.getContextPath() + "/extendedReport/contact.jsp",request, response);
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>微ERP</title>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<link rel="shortcut icon" href="https://qy.weixin.qq.com/favicon.ico">
<meta name="description" content="">
<meta name="author" content="">

<style>
	.bug{ 
		width: 100%;
		height: 100%;
		text-align: center;
		color:#000000;margin-top: 30px;
		}
	.bug .img {text-align: center;}

	.footer{
		margin-top: 50%;
		float: none;
		bottom: 20px;
		text-align: center;
	}
	.bug h3 {color: #e26d4e;}

	.footer {color: #8b8888;}

	a:link{
		text-decoration:none;
	}

	.btn{
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
		border-radius: 4px;
	}	

	.btn-success {
		color: #fff;
		background-color: #11bc00;
		border-color: #10b000;
		width: 250px;
		height: 30px;
		line-height: 30px;
		text-align: center;
		margin: 10px;
	}

	.btn-success:hover {
		background-color: #0fa400;
	}



</style>
</head>

<body>

	<div class="footer">
		<a class="btn btn-success" href='./erpReport/index.jsp'>ERP报表</a>
		<a class="btn btn-success" href='./erpSearch/searchDept.jsp'>ERP数据查询</a>
		<a class="btn btn-success" href='./erpOrder/orderPurchase.jsp'>ERP订单</a>
	</div>

	<!--
	<div class="bug">
		<div class=""img><img src="http://www.weioa365.com/images/bug.png"></div>
		<h1>权限错误</h1>
		<h3>您当前版本不支持微ERP！</h3>
	</div>
	<div class="footer">
		<a class="btn btn-success" role="button" href="tel:4006780211">联系商务</a><br/>
		<p>400 - 678 - 0211</p>		
	</div>
	-->
</body>
</html>
