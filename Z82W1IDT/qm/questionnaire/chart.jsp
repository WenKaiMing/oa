<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
table,td{
	font-size:12px;
	color:#333333;
}


.holder-item{
    border: 1px solid #ccc;
}

.holder-item-title {
	background-color: #F9F9F9;
    padding: 10px;
}
.holder-item-content {
	padding: 20px 40px;
}

.holder-item-content table {
	width: 100%
}

.holder-item-content td ,
.holder-item-content th {
	padding: 10px;
	border: 1px solid #ccc;
	color: #666666;
	font-weight: normal;
}

.holder-item-content td img {
	max-height: 25px;
	max-width: 40px; 
}

.holder-item-chart {
	width: 100%;
	height: 300px;
}

.pagination-panel {
	padding:20px 0;
	text-align: right;
	font: 12px/1.5 tahoma,"microsoft yahei","\5FAE\8F6F\96C5\9ED1";
	background: #fff;
}

.pagination-panel .pagination-body, .pagination-panel .pagination-other {
	display: inline-block;
}
    
.pagination-panel a {
    text-decoration: none;
}

.pagination-panel a.glyphicon , .pagination-panel span.glyphicon  {
    margin-right: 0px;
    padding: 0px;
    line-height: 20px;
}

.pagination-panel a, .pagination-panel span {
    display: inline-block;
    margin-right: 3px;
    padding: 1px 9px;
    color: #333;
    height: 23px;
    line-height: 23px;
    -webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
    text-decoration: none;
}

.pagination-panel a:hover {
    padding: 0 8px;
    border: 1px solid #eee;
    background-color: #eee;
    color: #333;
    text-decoration: none;
}

.pagination-panel .current.prev, .pagination-panel .current.next{
	display:none;
}

.pagination-panel .current {
	padding: 0 8px;
    border: 1px solid #488fcd;
    background-color: #488fcd;
    color: #fff;
    margin-right: 3px;
    height: 23px;
    line-height: 23px;
    -webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
}

.pagination-panel .totalRowPanel{
	display: inline-block;
	padding: 0 8px;
    color: #333;
    margin-right: 3px;
    height: 24px;
    line-height: 24px;
}

.pagination-panel .showItemPanel{
	display: inline-block;
	padding: 0px;
    background-color: #eee;
    color: #333;
    margin-right: 3px;
    height: 24px;
    line-height: 24px;
    -webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
    position: relative;
}
.pagination-panel .showItemPanel .showItemBtn{
	padding: 0 8px;
	cursor: pointer;
}

.pagination-panel .showItemPanel ul{
	background-color: #eee;
	-webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
    position: absolute;
    width: 100%;
    bottom: 17px;
}

.pagination-panel .showItemPanel ul li{
	cursor: pointer;
}


.pagination-panel .showItemPanel ul li:hover{
	color: #fff;
	-webkit-border-radius: 2px;
    -moz-border-radius: 2px;
    border-radius: 2px;
	background-color: #488fcd;
}

.matrixinput-title{
	font-weight: bold;
    margin-right: 5px;
}

.holder-item-details{
    cursor: pointer;
}

#qm-answerName-panel{
    width: 500px;
    background: #fff;
    position: fixed;
    height: 500px;
    z-index: 20;
    border-radius: 3px;
    display:none;
    top: 20px;
}

#qm-answerName-panel .answerName-title{
    padding: 10px;
    border-bottom: 1px solid #ccc;
    font-weight: bold;
}

#qm-answerName-panel .answerName-close{
	float:right;
	margin-top: -6px;
	padding: 0 12px;
	font-size: 22px;
    color: #919191;
    text-decoration: none;
}
#qm-answerName-panel .answerName-close:hover{
	color:#333;
}
#qm-answerName-panel .answerName-list{
	height: 459px;
	overflow: auto;
}
#qm-answerName-panel .answerName-list ul{
	padding: 0px;
}
#qm-answerName-panel .answerName-list li{
	list-style-type: none;
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

#qm-mask{
	position: fixed;
    top: 0px;
    bottom: 0px;
    left: 0px;
    right: 0px;
    z-index: 10;
    background: rgba(0,0,0,.5);
    display:none;
}

    


</style>
<title>结果统计</title>
</head>
<link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="../js/echarts.min.js"></script>
<script type="text/javascript" src="../js/jquery.pagination/jquery.pagination.js"></script>
<script type="text/javascript" src="../js/qm.core.js"></script>
<script type="text/javascript" src="../js/qm.questionnaire.js"></script>
<script type="text/javascript" src="../js/qm.chart.js"></script>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		 
		var html2 = $("#aaaa").val();
		var html = $("#bbbb").val();
		
		 
		var charts = $.parseJSON(html)
		var json = charts.map(function(v) {
			var t = {};
		    $(v.data).each(function (k) {
		        t[this.name] = t[this.name] || {
		            name: this.name,
		            index: this.index,
		            count: 0
		        };
		        t[this.name].count++;
		    });

		    return {"id":v.id,
		        "data": Object.keys(t).map(function (v) {
		            return t[v];
		        })
		    };
		}); 
		var chartJSON = JSON.stringify(json);
		QM.chart.init(html2,chartJSON);
	});
</script>
<body>

<textarea id="aaaa" name='content.content' style="display:none"><s:property value='content.content'/></textarea>
<textarea id="bbbb" name='content.chartJson' style="display:none"><s:property value='content.chartJson'/></textarea>
<s:hidden id="content_id" name="content.id"/>
<div style="padding:20px">	
	<div style="padding-bottom:50px;text-align: center;word-break: break-all;">
		<h1><s:property value='content.title' /></h1>
	</div>
	<div>
		<div id="maiDiv" style="word-break: break-all;"></div>
	</div>
</div>
<div id="qm-answerName-panel">
	<div class="answerName-title">人员名单<a href="javascript:void(0);" class="answerName-close">×</a></div>
	<div class="answerName-list"><ul></ul></div>
</div>
<div id="qm-mask"></div>
</body>
</html>