<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="cn.myapps.core.dynaform.dts.datasource.ejb.DataSourceProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="net.sf.json.JSONArray"%>
<%
	String chartType = request.getParameter("chartType");
	String active = request.getParameter("active");
	String pBillcode = request.getParameter("pBillcode");
	String pBillid = request.getParameter("pBillid");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>订单</title>
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

	<!-- 订单表单采购页面内容 -->
	<script type="text/html" id="purchaseCon" style="display: none;">
	{{each list as list1}}
		<div class='table table-bordered' style='width: 100%'>
			<div class="title1">采购订单明细表</div>
			<tbody>
				<div class="field1">
					<div class='label1'>*单据编号:</div>
					<div class='comp1'><input class='form-control' type='text'
						name='BILLCODE' value='{{list1.BILLCODE}}' /></div>
				</div>
				<div class="field1">
					<div class='label1'>*单据日期:</div>
					<div class='comp1'>
						<div class='input-group date form_datetime'>
							<input class='form-control' name='order.BILLDATE' size='16'
								type='text' value='{{list1.TIME}}'> <span class='input-group-addon'><span
								class='glyphicon glyphicon-th'></span></span>
						</div>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>*部门：</div>
					<div class='comp1'>
						<select class='form-control form-deptname' name='deptname' id='deptname' stype='_default' _value='{{list1.DEPNAME}}'>
							<option value=''>&nbsp;</option>
						</select>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>业务员:</div>
					<div class='comp1'><select class='form-control form-empname' name='empname'
						id='empname' stype='_default' _value='{{list1.EMPNAME}}'><option value=''>&nbsp;</option></select>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>供应商：</div>
					<div class='comp1'><input type='hidden' name='vendorcode' value='{{list1.VENDORCODE}}' /> <select
						class='form-control form-vendor' name='vendor' id='vendor'
						stype='_default' _value='{{list1.VENDORNAME}}'><option value=''>&nbsp;</option></select></div>
				</div>
				<div class="field1">
					<div class='label1'>单据金额:</div>
					<div class='comp1'><input class='form-control' type='text'
						name='order.BILLAMT' value='{{list1.BILLAMT}}' /></div>
				</div>
				<div class="field2">
					<div class='label2'>备注：</div>
					<div class='comp2'><input class='form-control' type='text' name='remark'
						value='{{list1.REMARK}}' /></div>
				</div>
				<div class="field2">
					<div class='label2'>采购明细:</div>
					<div class='comp2' id='subList'>请保存订单信息</div>
				</div>
				<div class="field2">
					<div>功能说明</div>
					<div colspan='3'>1.查阅公司的货品各个仓库的库存量及成本单价基础信息资料。</br>2.采购专员、会计、仓库专员可以看见成本价。
					</div>
				</div>
				<div style="clear:both;"></div>
			</tbody>
		</div>
	{{/each}}
	</script>

	<!-- 订单表单销售页面内容 -->
	<script type="text/html" id="saleCon" style="display: none;">
	{{each list as list1}}
		<div class='table table-bordered' style='width: 100%'>
			<div class="title1">销售订单明细表</div>
			<tbody>
				<div class="field1">
					<div class='label1'>*单据编号:</div>
					<div class='comp1'>
						<input type='hidden' name='clientno' value='{{list1.CLIENTID}}' />
						<input class='form-control' type='text'
							name='BILLCODE' value='{{list1.BILLCODE}}' />
					</div>
				</div>
				<div class="field1">
					<div class='label1'>*单据日期:</div>
					<div class='comp1'>
						<div class='input-group date form_datetime'>
							<input class='form-control' name='order.BILLDATE' size='16'
								type='text' value='{{list1.TIME}}'> <span class='input-group-addon'><span
								class='glyphicon glyphicon-th'></span></span>
						</div>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>*部门：</div>
					<div class='comp1'>
						<select class='form-control form-deptname' name='deptname' id='deptname' stype='_default' _value='{{list1.DEPNAME}}'>
							<option value=''>&nbsp;</option>
						</select>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>业务员:</div>
					<div class='comp1'>
						<select class='form-control form-empname' name='empname'
							id='empname' stype='_default' _value='{{list1.EMPNAME}}'><option value=''>&nbsp;</option></select>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>客户：</div>
					<div class='comp1'><input type='hidden' name='clientno' value='{{list1.CLIENTNO}}' /> <select
						class='form-control form-clientname' name='clientname'
						id='clientname' stype='_default' _value='{{list1.CLIENTNAME}}'><option value=''>&nbsp;</option></select>
					</div>
				</div>
				<div class="field1">
					<div class='label1'>单据金额:</div>
					<div class='comp1'><input class='form-control' type='text'
						name='order.BILLAMT' value='{{list1.BILLAMT}}' /></div>
				</div>
				<div class="field2">
					<div class='label2'>备注：</div>
					<div class='comp2'><input class='form-control' type='text' name='remark'
						value='{{list1.REMARK}}' /></div>
				</div>
				<div class="field2">
					<div class='label2'>销售明细:</div>
					<div class='comp2' id='subList'>请保存订单信息</div>
				</div>
				<div class="field2">
					<div>功能说明</div>
					<div colspan='3'>1.查阅公司的货品各个仓库的库存量及成本单价基础信息资料。</br>2.采购专员、会计、仓库专员可以看见成本价。
					</div>
				</div>
				<div style="clear:both;"></div>
			</tbody>
		</div>
	{{/each}}
	</script>
	<!-- 订单表单页面子表行内容 -->
	<script id="subTrPhone" type="text/html">
	{{each list as list1}}
		<div class='list-row'>
			<div class="field1">
				<div class='label1'>序号</div>
				<div class='comp1'>
					<input type='hidden' value='{{list1.orderType}}' name='orderType'>
					<input type='hidden' value='{{list1.pBillcode}}' name='BILLCODE'>
					<input class='form-control' readonly='readonly' type='text' value='{{list1.ITEMNO}}' name='sub.ITEMNO'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>编号</div>
				<div class='comp1'>
					<input class='form-control' readonly='readonly' type='text' name='sub.BILLCODE' value='{{list1.BILLCODE}}'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>名称</div>
				<div class='comp1'>
					<input type='hidden' name='sub.GOODSCODE' value='{{list1.GOODSCODE}}'>
					<select class='form-control form-goodsname' name='GOODSNAME' id='goodsname'	stype='_select' _value='{{list1.GOODSNAME}}'>
						<option value=''>&nbsp;</option>
					</select>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>规格</div>
				<div class='comp1'>
					<input class='form-control' readonly='readonly' type='text' value='{{list1.GOODSSPEC}}'
						name='sub.GOODSSPEC'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>数量</div>
				<div class='comp1'>
					<input class='form-control' type='text' name='sub.QTY'
						value='{{list1.QTY}}'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>单位</div>
				<div class='comp1'>
					<input class='form-control' readonly='readonly' type='text' value='{{list1.UNITNAME}}'
						name='sub.UNITNAME'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>单价</div>
				<div class='comp1'>
					<input class='form-control' readonly='readonly' type='text' value='{{list1.PRICE}}'
						name='sub.PRICE'>
				</div>
			</div>
			<div class="field1">
				<div class='label1'>金额</div>
				<div class='comp1'>
					<input class='form-control' readonly='readonly' type='text'
						name='sub.GOODSAMT' value='{{list1.GOODSAMT}}'>
				</div>
			</div>
			<div style='clear:both;'></div>
		</div>
		<div class="actPanel">
			<button type='button' class='btn btn-success btn-sub-save' >保存</button>
			{{if showDel}}
			<button type='button' class='btn btn-danger btn-sub-delete' >删除</button>
			{{/if}}
			<button type='button' class='btn btn-default btn-sub-back' >返回</button>
		</div>
	{{/each}}
	</script>
	<!-- 订单表单页面子表行内容 -->
	<script id="subTr" type="text/html">
	{{each list as list1 i}}
		<tr class='list-row listDataTr' index='{{i+1}}'>
			<td class='listDataTrFirstTd'><input class='form-control' readonly='readonly' type='hidden' value='{{list1.ITEMNO}}'
				name='sub.ITEMNO'>{{list1.ITEMNO}}</td>
			<td class='listDataTrTd'><input class='form-control' readonly='readonly' type='hidden'
				name='sub.BILLCODE' value='{{list1.BILLCODE}}'>{{list1.BILLCODE}}</td>
			<td class='listDataTrTd'>
				<input type='hidden' name='sub.GOODSCODE' value='{{list1.GOODSCODE}}'>
				<select class='form-control form-goodsname' name='goodsname' id='goodsname'
					stype='_select' _value='{{list1.GOODSNAME}}' style="display:none;">
					<option value=''>&nbsp;</option>
				</select>
				{{list1.GOODSNAME}}
			</td>
			<td class='listDataTrTd'>
				<input class='form-control' readonly='readonly' type='hidden' value='{{list1.GOODSSPEC}}' name='sub.GOODSSPEC' />
				{{list1.GOODSSPEC}}
			</td>
			<td class='listDataTrTd'>
				<input class='form-control' type='hidden' name='sub.QTY' value='{{list1.QTY}}'>
				{{list1.QTY}}
			</td>
			<td class='listDataTrTd'>
				<input class='form-control' readonly='readonly' type='hidden' value='{{list1.UNITNAME}}' name='sub.UNITNAME'>
				{{list1.UNITNAME}}
			</td>
			<td class='listDataTrTd'>
				<input class='form-control' readonly='readonly' type='hidden' value='{{list1.PRICE}}' name='sub.PRICE'>
				{{list1.PRICE}}
			</td>
			<td class='listDataTrTd'>
				<input class='form-control' readonly='readonly' type='hidden' name='sub.GOODSAMT' value='{{list1.GOODSAMT}}'>
				{{list1.GOODSAMT}}
			</td>
		</tr>
	{{/each}}
	</script>
	<!-- 订单表单页面子表及列头内容 -->
	<script type="text/html" id="subTable">
	<div>
		<table class='table' data-role="table" data-mode='columntoggle' id='subData' style='width:100%'>
			<thead>
				<tr class='list-row listDataTh'>
					<th class='listDataThFirstTd' ishiddencolumn='false' isvisible='true'>序号</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>编号</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>名称</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>规格</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>数量</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>单位</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>单价</th>
					<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>金额</th>
				</tr>
			</thead>
			<tbody>
				{{include 'subTr'}}
			</tbody>
		</table>
		{{if showAdd}}
		<div class='btn-sub-insert'>
			<button type="button" class="btn btn-primary btn-show-add">新增</button>
		</div>
		{{/if}}
	</div>
	</script>
</head>
<body>
    <div id="wrapper">
        <div id="page-wrapper1" style="min-height: 560px;">
            <div class="row" id="order_purchase">
            	<div class="col-lg-12">
               		<article class="obpmSearch"  _val="<%=chartType %>" pBillcode="<%=pBillcode %>" pBillid="<%=pBillid %>" title="">
               			<form class="dataSearch-from">
               				<div class="activity-panel">
	                			<button type="submit" class="btn btn-success btn-show-save">保存</button>
								<button type="button" class="btn btn-default btn-show-back">返回</button>
								<!-- <button type="button" class="btn btn-info btn-show-print">打印</button> -->
	                		</div>
	                		<div class="dataSearch-title"></div>
	                		<div class="dataList"></div>
						</form>
                	</article>
                </div>
            </div> 
        </div>
    </div>
</body>

<script src="./../script/jquery.min.js"></script>
<script src="./../script/bootstrap.min.js"></script>
<script src="./../script/metisMenu.min.js"></script>
<script src="./../script/raphael-min.js"></script>
<script src="./../script/sb-admin-2.js"></script>
<script type="text/javascript" src="./../script/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="./../script/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="./../script/jquery.dataTables.min.js"></script>
<script src="./../script/dataTables.bootstrap.min.js"></script>
<script src="./../script/dataTables.responsive.js"></script>
<script src="./../script/dateExpand.js"></script>
<script src="./../script/template.js"></script>
<script src="./../script/cookie.js"></script>
<script src="./../script/jquery.cookie.js"></script>
<script src="./../script/tableList.js"></script>
<script src="./../script/erp_common.js"></script>
<script src="./../script/erp_order.js"></script>
<script>
//设置cookie，浏览器通过后退返回到视图时可正常刷新
if(typeof(cook) == "object" && typeof(cook.reloadByCookie) == "function"){
	cook.reloadByCookie();
}
var active = "<%=active%>";
var orderType = "<%=chartType%>";
$(function(){
	Order.initContent();
});
</script>
</html>