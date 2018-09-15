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

    <title>ERP报表</title>

    <!-- Bootstrap Core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="./css/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="./css/dataTables.bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="./css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="./css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
	<!-- Datetimepicker CSS -->
    <link href="./css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
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
                <a class="navbar-brand" >ERP报表</a>
            </div>
            <!-- /.navbar-header -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav in" id="side-menu">
                        <li>
                            <a href="./chartIndex.jsp"><i class="fa fa-bar-chart-o fa-fw"></i>客户业绩图表</a>
                        </li>
                        <li>
                            <a href="./tableIndex.jsp"><i class="fa fa-table fa-fw"></i>客户业绩汇总表</a>
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
                    <h1 class="page-header">客户业绩汇总表</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                	
                	<article class="obpmTable"  _val="goodsonhand"  title="实时库存表" >
                		<div class="obpmTable-title"></div>
                		
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="sumDep"  title="部门业绩比较分析表" >
						<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
					</article>
                </div>
            </div>
            
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="sumRep"  title="业务员业绩比较分析表" _name="">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="sumTrader"  title="客户业绩表" _name="">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
             
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="supplier"  title="供应商应付比较分析表" _name="">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="cashBanTrend"  title="现金银行余额分析表" _name="">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="wareHouse"  title="仓库库存占比分析表">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            
            <!-- /.row -->
          	
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="bestSelling"  title="畅销产品类别占比分析图表">
                		<div class="obpmTable-title"></div>
                		<div class="erpSearch">
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
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
         	
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="productType"  title="产品类别库存占比分析图表">
                		<div class="obpmTable-title"></div>
                		
						<div class="erpTable">
							
						</div>
                	</article>
                </div>
            </div>
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="subjectBalance"  title="科目余额汇总表">
                		<div class="obpmTable-title"></div>
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

    <!-- jQuery -->
	<script src="./script/jquery-1.11.3-min.js" charset="UTF-8"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="./script/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="./script/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="./script/jquery.dataTables.min.js"></script>
    <script src="./script/dataTables.bootstrap.min.js"></script>
    <script src="./script/dataTables.responsive.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="./script/sb-admin-2.js"></script>
    
	<!-- Datetimepicker JavaScript -->
    <script type="text/javascript" src="./script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>

	<script type="text/javascript" src="./script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    
    <!-- DateExpand JavaScript -->
    <script type="text/javascript" src="./script/dateExpand.js" charset="UTF-8"></script>
    
	<!-- OBPM JavaScript -->
	<script src="./script/echarts_obpm.js"></script>
	<script>
	Chart.initTable();
	</script>
</body></html>