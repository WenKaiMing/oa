<%@page import="cn.myapps.util.OBPMDispatcher"%>
<%@ page import="cn.myapps.extendedReport.NDataSource"%>
<%

if(!NDataSource.isErpEnable()){
	new OBPMDispatcher().sendRedirect(request.getContextPath() + "/extendedReport/contact.jsp",request, response);
	return;
}
%>
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

    <title>ERP数据查询</title>

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

	<!-- Datetimepicker CSS -->
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
                <a class="navbar-brand" >ERP数据查询</a>
            </div>
            <!-- /.navbar-header -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav in" id="side-menu">
	                    <li>
	                        <a href="./searchDept.jsp"><i class="fa fa-table fa-fw"></i>往来单位查询</a>
	                    </li>
	                    <li>
	                        <a href="./searchGoods.jsp"><i class="fa fa-table fa-fw"></i>货品查询</a>
	                    </li>
	                    <li>
	                        <a href="./searchWarehouse.jsp"><i class="fa fa-table fa-fw"></i>分仓库库存查询</a>
	                    </li>
	                    <li>
	                        <a href="./searchCashier.jsp"><i class="fa fa-table fa-fw"></i>出纳账查询</a>
	                    </li>
	                    <li>
	                        <a href="./searchCharge.jsp" class="active"><i class="fa fa-table fa-fw"></i>应收查询</a>
	                    </li>
	                    <li>
	                        <a href="./searchPay.jsp"><i class="fa fa-table fa-fw"></i>应付查询</a>
	                    </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper" style="min-height: 560px;">

            <div class="row" id="yings_Search">
               <div class="col-lg-12">
                	<article class="obpmSearch"  _val="yings"  title="应收查询" _name="">
                		<h1 class="page-header">应收查询
							<button type="button" class="btn btn-info searchBtn" _val="wlsearch" style="display:none;">查询</button>
                		</h1>
                		<div class="dataSearch" style="display:none;">
                			<form class="dataSearch-from">
								<div class="column chuna">
									<div class="form-group xiala-select col-sm-4">
							            <label class="control-label col-sm-4">日期期间</label>
							            <div class="control-select col-sm-8">
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
							        <div class="form-group col-sm-4">
							        	<label class="input-label col-sm-4">开始时间</label>
							            <div class="input-group date form_datetime col-sm-8">
					                		<input class="form-control start-time" size="16" type="text" value="" name="_startTime">
							                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
							            </div>
							        </div>
							        <div class="form-group col-sm-4">
							        	<label class="input-label col-sm-4">结束时间</label>
							            <div class="input-group date form_datetime col-sm-8">
							                <input class="form-control end-time" size="16" type="text" value="" name="_endTime">
							                <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
							            </div>
							        </div>
							        <div class="form-group col-sm-4">
							            <label class="control-label col-sm-4">客户</label>
										<div class="control-select col-sm-8">
											<select class="form-control clientname_select" name="clientname" _val="clientname" stype="_default">
												<option >&nbsp;</option>
											</select>
										</div>	
							        </div>
								</div>
								<div class="col-sm-12 text-center">
									<button type="button" class="btn btn-primary submit" _val="yingssearch"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</button>
									<button type="button" class="btn btn-default">重置</button>
								</div>
							</form>
						</div>
						<div class="dataList">
							
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
    <script src="./../script/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="./../script/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="./../script/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="./../script/raphael-min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="./../script/sb-admin-2.js"></script>
    
    <!-- Datetimepicker JavaScript -->
    <script type="text/javascript" src="./../script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>

	<script type="text/javascript" src="./../script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    
    <!-- DataTables JavaScript -->
    <script src="./../script/jquery.dataTables.min.js"></script>
    <script src="./../script/dataTables.bootstrap.min.js"></script>
    <script src="./../script/dataTables.responsive.js"></script>
    
	<!-- DateExpand JavaScript -->
    <script type="text/javascript" src="./../script/dateExpand.js" charset="UTF-8"></script>
	<!-- OBPM JavaScript -->
	<script src="./../script/erp_common.js"></script>
	<script src="./../script/search_obpm.js"></script>
	<script>
	Search.init();
	</script>
</body></html>