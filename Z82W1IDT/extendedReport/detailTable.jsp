<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="cn.myapps.core.dynaform.dts.datasource.ejb.DataSourceProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="cn.myapps.extendedReport.Charts"%>
<%
	String chartType = request.getParameter("chartType");
	String _name = request.getParameter("_name");
%>
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
	<link rel="stylesheet" href="./css/responsive.css"/>

</head>

<body>

    <div id="wrapper">

        <div id="page-wrapper1" style="min-height: 560px;">
        	<!-- 
            <div class="row">
                <div class="col-lg-12">
               		<div class="activity-panel" style="padding-top: 25px;">
						<button type="button" class="btn btn-default btn-show-back">返回</button>
               		</div>
                </div>
            </div>
             -->
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmTable"  _val="<%=chartType %>" _name="<%=_name %>" title="">
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
    <script src="./script/jquery.min.js"></script>

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
	
	<!-- OBPM JavaScript -->
	<script src="./script/echarts_obpm.js"></script>
	<script>
	Chart.initCommonTable();
	</script>
</body></html>