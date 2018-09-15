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

    <title>报表</title>

    <!-- Bootstrap Core CSS -->
    <link href="./../css/bootstrap.min.css" rel="stylesheet">
    <!-- MetisMenu CSS -->
    <link href="./../css/metisMenu.min.css" rel="stylesheet">
    <!-- Timeline CSS -->
    <link href="./../css/timeline.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="./../css/dataTables.bootstrap.css" rel="stylesheet">
    <!-- DataTables Responsive CSS -->
    <!-- Custom CSS -->
    <link href="./../css/sb-admin-2.css" rel="stylesheet">
    <!-- Morris Charts CSS -->
    <link href="./../css/morris.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="./../css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Echarts CSS -->
	<link rel="stylesheet" href="./../css/echarts.css"/>
	<link rel="stylesheet" href="./../css/erpReport.css"/>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
				<button type="button" class="btn btn-list-search head-search" style="display:none;">查询</button>
                <a class="navbar-brand" >ERP报表</a>
            </div>
            <!-- /.navbar-header -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav in" id="side-menu">
                        <li>
                            <a href="./../erpReport/goodsonhand.jsp"><i class="fa fa-bar-chart-o fa-fw"></i>实时库存比较分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/sumDep.jsp"><i class="fa fa-table fa-fw"></i>部门业绩比较分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/sumRep.jsp"><i class="fa fa-table fa-fw"></i>业务员业绩比较分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/sumTrader.jsp"><i class="fa fa-table fa-fw"></i>客户业绩比较分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/supplier.jsp"><i class="fa fa-table fa-fw"></i>供应商应付比较分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/wareHouse.jsp"><i class="fa fa-table fa-fw"></i>仓库库存占比分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/bestSelling.jsp"><i class="fa fa-table fa-fw"></i>畅销产品类别占比分析表</a>
                        </li>
                        <li>
                            <a href="./../erpReport/productType.jsp"><i class="fa fa-table fa-fw"></i>产品类别库存占比分析表</a>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper" style="min-height: 560px;">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">畅销产品类别占比分析表</h3>
                </div>
                <div class="headerDesc">显示畅销产品类别对比信息</div>
                <!-- /.col-lg-12 -->
                <!-- 查询 -->
           		<div class="erpSearch" style="display:none; margin-top: 2em;">
              		<div class="form-group xiala-select col-md-3">
			            <label class="control-label">日期期间</label>
			            <div class="control-select">
			                <select class="form-control dateRange">
			                	<option _val="100">&nbsp;</option>
								<option _val="1">本年</option>
								<option _val="2">本月</option>
								<option _val="3">今周</option>
								<option _val="4">今天</option>
								<option _val="5">昨天</option>
								<option _val="6">上周</option>
								<option _val="7">上月</option>
								<option _val="8">上年</option>
								<option _val="9">上周至今</option>
								<option _val="10">上月至今</option>
								<option _val="11">上年至今</option>
								<option _val="12">本年至今</option>
								<option _val="13">本月至今</option>
								<option _val="14">今周至今</option>
								
							</select>
			            </div>
			        </div>
			        <div class="form-group col-md-3">
			        	<label class="input-label">从</label>
			            <div class="input-group date form_datetime">
	                		<input class="form-control start-time" size="16" type="text" value="">
			                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
			            </div>
			        </div>
			        <div class="form-group col-md-3">
			        	<label class="input-label">至</label>
			            <div class="input-group date form_datetime">
			                <input class="form-control end-time" size="16" type="text" value="">
			                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
			            </div>
			        </div>
			        <div class="col-md-3">
			            <button type="button" class="btn btn-primary submit" _starttime="" _endtime=""><i class="fa fa-search" aria-hidden="true"></i> 查询</button>
			            <button type="button" class="btn btn-default">重置</button>	
			        </div>
				</div>
            </div>
            <!-- /.row -->
            <div class="row" >
                <div class="col-lg-8" >
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="bestSelling" _magicType="pie" _title="" _href="sumTable.jsp" 
									_fromField="类别" _nameField="gdtype" _valField="sqt">
							</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-8 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="bestSelling"  title="畅销产品类别占比分析图表">
						<div class="obpmTable-title">列表</div>
						<div class="erpTable">
							
						</div>
					</article>
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->

    <script src="./../script/jquery.min.js"></script>
    <script src="./../script/bootstrap.min.js"></script>
    <script src="./../script/metisMenu.min.js"></script>
    <script src="./../script/raphael-min.js"></script>
    <script src="./../script/jquery.dataTables.min.js"></script>
    <script src="./../script/dataTables.bootstrap.min.js"></script>
    <script src="./../script/dataTables.responsive.js"></script>
	<!-- Datetimepicker JavaScript -->
    <script src="./../script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
	<script src="./../script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="./../script/echarts.js"></script>
	<!-- OBPM JavaScript -->
	<script src="./../script/erp_common.js"></script>
    <script src="./../script/sb-admin-2.js"></script>
	<script src="./../script/erpReport.js"></script>
	<script>
	Chart.init();
	Chart.initTable();
	</script>
</body></html>