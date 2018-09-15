<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="cn.myapps.core.dynaform.dts.datasource.ejb.DataSourceProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="net.sf.json.JSONArray"%>
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
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="./css/metisMenu.min.css" rel="stylesheet">

    <!-- Timeline CSS -->
    <link href="./css/timeline.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="./css/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    
    <!-- Custom CSS -->
    <link href="./css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="./css/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="./css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Echarts CSS -->
	<link rel="stylesheet" href="./css/echarts.css"/>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" >ERP报表</a>
            </div>
            <!-- /.navbar-header -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav in" id="side-menu">
                        <li>
                            <a href="#">速达<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse">
                                <li>
                                    <a href="./chartIndex.jsp"><i class="fa fa-bar-chart-o fa-fw"></i>  图表</a>
                                </li>
                                <li>
                                    <a href="./tableIndex.jsp"><i class="fa fa-table fa-fw"></i>  表格</a>
                                </li>
                            </ul>
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
                    <h1 class="page-header">图表</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> 实时库存图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<article class="echarts" _val="goodsonhand" _magicType="bar" _title="" _href="sumTable.jsp" 
                        			_fromField="类别" _nameField="stname" _valField="">
                        			
                        	</article>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>部门业绩比较分析表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<article class="echarts" _val="sumDep" _magicType="bar" _title="" _href="sumTable.jsp" 
                        			_fromField="" _nameField="deptname" _valField=""></article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>业务员业绩比较分析表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="sumRep" _magicType="bar" _title="" _href="sumTable.jsp" 
									_fromField="" _nameField="repname" _valField="">
							</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>客户业绩图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="sumTrader" _magicType="bar" _title="" _href="sumTable.jsp" 
									_fromField="" _nameField="tradername" _valField="">
							</article>
                        	</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>供应商应付比较分析图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="supplier" _magicType="bar" _title="" _href="sumTable.jsp" 
									_fromField="" _nameField="tradername" _valField="">
							</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    <!-- 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>现金银行余额分析图表
                        </div>
                        <div class="panel-body">
							<article class="echarts" _val="cashBanTrend" _magicType="line" _title="" _href="sumTable.jsp" 
									_fromField="" _nameField="nmonth" _valField="standardbala" _groupField="subname">
							</article>
		                </div>
                    </div>
                     -->
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-8 -->
                <div class="col-lg-4">
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-pie-chart fa-fw"></i>仓库库存占比分析图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="wareHouse" _magicType="pie" _title="" _href="sumTable.jsp" 
									_fromField="仓库" _nameField="st" _valField="cqt">
							</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-pie-chart fa-fw"></i>畅销产品类别占比分析图表
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
                    
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-pie-chart fa-fw"></i>产品类别库存占比分析图表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
							<article class="echarts" _val="productType" _magicType="pie" _title="" _href="sumTable.jsp" 
									_fromField="产品名称" _nameField="gdtype" _valField="onhandqty">
							</article>
		                </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-4 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="./script/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="./script/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="./script/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="./script/raphael-min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="./script/sb-admin-2.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="./script/jquery.dataTables.min.js"></script>
    <script src="./script/dataTables.bootstrap.min.js"></script>
    <script src="./script/dataTables.responsive.js"></script>
    
    <!-- Echarts JavaScript -->
	<script src="./script/echarts.js"></script>
	
	<!-- OBPM JavaScript -->
	<script src="./script/echarts_obpm.js"></script>
	<script>
	Chart.init();
	</script>
</body></html>