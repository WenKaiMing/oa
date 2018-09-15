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
    <link href="./../css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="./../css/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="./../css/dataTables.bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="./../css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="./../css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Datetimepicker CSS -->
    <link href="./../css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">

</head>

<body>

    <div id="wrapper">

        <div id="page-wrapper1" style="min-height: 560px;">
        
            <div class="row">
                <div class="col-lg-12">
                	<article class="obpmSearch"  _val="<%=chartType %>" _name="<%=_name %>" title="">
                		<div class="dataSearch-title"></div>
                		<div class="dataSearch">
	               			<form class="dataSearch-from">
	               				<input type="hidden" name="_code" value="<%=_name %>"/>
								<div class="column chuna">
									<div class="form-group col-sm-4">
										<label class="control-label col-sm-4">日期期间</label>
										
										<div class="form-group col-sm-8">
											<select class="form-control dateRange" style="float:left;">
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
									
								</div>
								<div class="col-sm-12 text-center">
									<button type="button" class="btn btn-primary submit" _val="cnzsearch"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</button>
									<button type="button" class="btn btn-default">重置</button>
								</div>
							</form>
						</div>
						<div style="clear:both;"></div>
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

    <!-- DataTables JavaScript -->
    <script src="./../script/jquery.dataTables.min.js"></script>
    <script src="./../script/dataTables.bootstrap.min.js"></script>
    <script src="./../script/dataTables.responsive.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="./../script/sb-admin-2.js"></script>
	<!-- Datetimepicker JavaScript -->
    <script type="text/javascript" src="./../script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>

	<script type="text/javascript" src="./../script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    
    <!-- DateExpand JavaScript -->
    <script type="text/javascript" src="./../script/dateExpand.js" charset="UTF-8"></script>
	<!-- OBPM JavaScript -->
	<script src="./../script/search_obpm.js"></script>
	<script>
		Search.initListDetail();
		$('.form_datetime').datetimepicker({
	        language:  'zh-CN',
	        minView: "month",
	        format: 'yyyy-mm-dd',
	        autoclose:true
	    });
		$(".submit").click(function(){
			Search.searchTable(this);
		});
		$(".dateRange").change(function(){
			var _val = $(this).find("option:selected").attr("_val");
			var $startTime = $(this).parents(".dataSearch-from").find(".start-time");
			var $endTime = $(this).parents(".dataSearch-from").find(".end-time");
			switch(_val){
				case "100":	//自定义
					$('.form_datetime').datetimepicker('setStartDate', '2000-01-01');
					$('.form_datetime').datetimepicker('setEndDate', '2080-01-01');
					$startTime.val("");
					$endTime.val("");
				  break;
				case "1":	//本年
					$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getYearEndDate);
					$startTime.val(getYearStartDate);
					$endTime.val(getYearEndDate);
				  break;
				case "2":	//本月
					$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getMonthEndDate);
					$startTime.val(getMonthStartDate);
					$endTime.val(getMonthEndDate);
					 break;
				case "3":	//今周
					$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getWeekEndDate);
					$startTime.val(getWeekStartDate);
					$endTime.val(getWeekEndDate);
					break;
				case "4":	//今天
					$('.form_datetime').datetimepicker('setStartDate', getCurrentDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getCurrentDate);
					$endTime.val(getCurrentDate);
					break;
				case "5":	//昨天
					$('.form_datetime').datetimepicker('setStartDate', getYesterdayDate);
					$('.form_datetime').datetimepicker('setEndDate', getYesterdayDate);
					$startTime.val(getYesterdayDate);
					$endTime.val(getYesterdayDate);
					break;
				case "6":	//上周
					$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getUpWeekEndDate);
					$startTime.val(getUpWeekStartDate);
					$endTime.val(getUpWeekEndDate);
					break;
				case "7":	//上月
					$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getLastMonthEndDate);
					$startTime.val(getLastMonthStartDate);
					$endTime.val(getLastMonthEndDate);
					break;
				case "8":	//上年
					$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getUpYearEndDate);
					$startTime.val(getUpYearStartDate);
					$endTime.val(getUpYearEndDate);
					break;
				case "9":	//上周至今天
					$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getUpWeekStartDate);
					$endTime.val(getCurrentDate);
					break;
				case "10":	//上月至今天
					$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getLastMonthStartDate);
					$endTime.val(getCurrentDate);
					break;
				case "11":	//上年至今
					$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getUpYearStartDate);
					$endTime.val(getCurrentDate);
					break;
				case "12":	//本年至今
					$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getYearStartDate);
					$endTime.val(getCurrentDate);
					break;
				case "13":	//本月至今
					$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getMonthStartDate);
					$endTime.val(getCurrentDate);
					break;
				case "14":	//今周至今
					$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
					$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
					$startTime.val(getWeekStartDate);
					$endTime.val(getCurrentDate);
					break;
				default:
					break;
			}
		});
	</script>
</body></html>