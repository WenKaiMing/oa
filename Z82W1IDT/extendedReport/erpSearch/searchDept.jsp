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
	                        <a href="./searchDept.jsp" class="active"><i class="fa fa-table fa-fw"></i>往来单位查询</a>
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
	                        <a href="./searchCharge.jsp"><i class="fa fa-table fa-fw"></i>应收查询</a>
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
            
            <!-- /.row -->
            
            <div class="row" id="wldw_Search">
               <div class="col-lg-12">
                	<article class="obpmSearch"  _val="wldw"  title="往来单位查询" _name="">
                		<h1 class="page-header">往来单位查询
							<button type="button" class="btn btn-info searchBtn" _val="wlsearch" style="display:none;">查询</button>
                		</h1>
                		
                		<form class="dataSearch-from">
                		<div class="dataSearch" style="display:none;">
							<div class="column">
								<div class="col-sm-1 textAlign">简称:&nbsp;</div>
								<div class="col-sm-2"><input type="text" class="form-control" name="jname" id="jname"/></div>
								<div class="col-sm-1 textAlign">全称:&nbsp;</div>
								<div class="col-sm-2"><input type="text" class="form-control" name="fullname" id="fullname"/></div>
								<div class="col-sm-1 textAlign">隶属部门:&nbsp;</div>
								<div class="col-sm-2">
									<select class="form-control deptment_select" name="deptname" _val="deptname" stype="_default">
										<option>&nbsp;</option>
									</select>
								</div>
								<div class="col-sm-1 textAlign">类别:&nbsp;</div>
								<div class="col-sm-2">
									<select class="form-control tradertype_select"  name="tradertype" _val="tradertype" stype='_default'>
										<option>&nbsp;</option>
									</select>
								</div>
							</div>
							<div class="column">
								<div class="col-sm-1 textAlign">地区:&nbsp;</div>
								<div class="col-sm-2">
									<select class="form-control areaname_select" name="areaname" _val="areaname" stype='_default'>
										<option>&nbsp;</option>
									</select>
								</div>
								<div class="col-sm-1 textAlign">编号:&nbsp;</div>
								<div class="col-sm-2"><input type="text" class="form-control" name="code" id="code"/></div>
								<div class="col-sm-1 textAlign">业务员:&nbsp;</div>
								<div class="col-sm-2">
									<select class="form-control empname_select" name="empname" _val="empname" stype='_default'>
										<option>&nbsp;</option>
									</select>
								</div>
								<div class="col-sm-1 textAlign"></div>
								<div class="col-sm-2">
									
								</div>
							</div>
							<div class="col-sm-12 text-center">
								<button type="button" class="btn btn-primary submit" _val="wlsearch"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</button>
								<button type="button" class="btn btn-default">重置</button>
							</div>
						</div>
						<div class="dataList">
							
						</div>
						</form>
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