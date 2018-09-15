<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="cn.myapps.core.dynaform.dts.datasource.ejb.DataSourceProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.extendedReport.NDataSource"%>
<%

if(!NDataSource.isErpEnable()){
	new OBPMDispatcher().sendRedirect(request.getContextPath() + "/extendedReport/contact.jsp",request, response);
	return;
}
%>
<!DOCTYPE html>
<!-- saved from url=(0076)http://blackrockdigital.github.io/startbootstrap-sb-admin-2/pages/index.html -->
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ERP订单</title>

	<link href="./../css/bootstrap.min.css" rel="stylesheet">
	<link href="./../css/metisMenu.min.css" rel="stylesheet">
	<link href="./../css/timeline.css" rel="stylesheet">
	<link href="./../css/dataTables.bootstrap.css" rel="stylesheet">
	<link href="./../css/sb-admin-2.css" rel="stylesheet">
	<link href="./../css/morris.css" rel="stylesheet">
	<link href="./../css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="./../css/echarts.css"/>
	<link rel="stylesheet" href="./../css/responsive.css"/>
	<link href="./../css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" >ERP订单</a>
            </div>
            <!-- /.navbar-header -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav in" id="side-menu">
	                    <li>
	                        <a href="./orderPurchase.jsp"><i class="fa fa-bar-chart-o fa-fw"></i>采购订单</a>
	                    </li>
	                    <li>
	                        <a href="./orderSale.jsp"><i class="fa fa-table fa-fw"></i>销售订单</a>
	                    </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper" style="min-height: 560px;">
            <div class="row" id="order_purchase">
               <div class="col-lg-12">
                	<article class="obpmSearch"  _val="purchase" _isSelect="true" title="采购订单">
                		<form class="dataSearch-from">
                			<input type="hidden" name="_orderType" value="purchase"/>
                			<div class="activity-panel" style="padding-top: 25px;">
	                			<button type="button" class="btn btn-primary btn-list-add">新建</button>
								<button type="button" class="btn btn-danger btn-list-delete">删除</button>
								<button type="button" class="btn btn-info btn-list-search">查询</button>
	                		</div>
	                		<h1 class="page-header">采购订单</h1>
	                		<div class="dataSearch" style="display:none;">
	               				<div class="column">
									<div class="col-sm-1 textAlign">单据编号:&nbsp;</div>
									<div class="col-sm-2"><input type="text" class="form-control" name="orderNum" id="orderNum" /></div>
									<div class="col-sm-1 textAlign">供应商:&nbsp;</div>
									<div class="col-sm-2">
										<select class="form-control form-vendor"  name="vendor" id="vendor" stype='_default'>
											<option value="">&nbsp;</option>
										</select>
									</div>
									<div class="col-sm-1 textAlign">部门:&nbsp;</div>
									<div class="col-sm-2">
										<select class="form-control form-deptname"  name="deptname" id="deptname" stype='_default'>
											<option value="">&nbsp;</option>
										</select>
									</div>
									<div class="col-sm-1 textAlign">业务员:&nbsp;</div>
									<div class="col-sm-2">
										<select class="form-control form-empname" name="empname" id="empname" stype='_default'>
											<option value="">&nbsp;</option>
										</select>
									</div>
								</div>
								<div class="column">
									<div class="col-sm-1 textAlign">开始时间:&nbsp;</div>
									<div class="col-sm-2">
										<div class="input-group date form_datetime">
								            <input class="form-control start-time" name="_startTime" size="16" type="text" value="">
					                		<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
								        </div>
									</div>
									<div class="col-sm-1 textAlign">结束时间:&nbsp;</div>
									<div class="col-sm-2">
										<div class="input-group date form_datetime">
											<input class="form-control start-time" name="_endTime" size="16" type="text" value="">
						                	<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
										</div>
									</div>
									<div class="col-sm-1 textAlign"></div>
									<div class="col-sm-2"></div>
									<div class="col-sm-1 textAlign"></div>
									<div class="col-sm-2"></div>
								</div>
								<div class="col-sm-12 text-center">
									<button type="submit" class="btn btn-primary" _val="">查询</button>
									<button type="reset" class="btn btn-default">重置</button>
								</div>
							</div>
							<div class="dataList"></div>
						</form>
                	</article>
                </div>
            </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

	<script src="./../script/jquery.min.js"></script>
	<script src="./../script/bootstrap.min.js"></script>
	<script src="./../script/metisMenu.min.js"></script>
	<script src="./../script/raphael-min.js"></script>
	<script src="./../script/sb-admin-2.js"></script>
	<script src="./../script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
	<script src="./../script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="./../script/jquery.dataTables.min.js"></script>
	<script src="./../script/dataTables.bootstrap.min.js"></script>
	<script src="./../script/dataTables.responsive.js"></script>
	<script src="./../script/dateExpand.js"></script>
	<script src="./../script/cookie.js"></script>
	<script src="./../script/jquery.cookie.js"></script>
	<script src="./../script/tableList.js"></script>
	<script src="./../script/erp_common.js"></script>
	<script src="./../script/erp_order.js"></script>
	<script>
	Order.initList();
	</script>
</body>
</html>