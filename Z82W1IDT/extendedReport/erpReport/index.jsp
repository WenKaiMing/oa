<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.extendedReport.NDataSource"%>
<%

if(!NDataSource.isErpEnable()){
	new OBPMDispatcher().sendRedirect(request.getContextPath() + "/extendedReport/contact.jsp",request, response);
	return;
}
%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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

	.header {
		text-align : center;
	}
</style>
</head>

<body>
	<div class="header">
        <a class="btn btn-success" href="./../erpReport/goodsonhand.jsp">实时库存比较分析表</a>
        <a class="btn btn-success" href="./../erpReport/sumDep.jsp">部门业绩比较分析表</a>
        <a class="btn btn-success" href="./../erpReport/sumRep.jsp">业务员业绩比较分析表</a>
        <a class="btn btn-success" href="./../erpReport/sumTrader.jsp">客户业绩比较分析表</a>
        <a class="btn btn-success" href="./../erpReport/supplier.jsp">供应商应付比较分析表</a>
        <a class="btn btn-success" href="./../erpReport/wareHouse.jsp">仓库库存占比分析表</a>
        <a class="btn btn-success" href="./../erpReport/bestSelling.jsp">畅销产品类别占比分析表</a>
        <a class="btn btn-success" href="./../erpReport/productType.jsp">产品类别库存占比分析表</a>
	</div>
</body>
</html>
