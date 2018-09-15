<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.Column"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.*"%>
<%@ page import="cn.myapps.constans.Web"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/portal/share/common/lib.jsp"%>
<%@ include file="/portal/share/common/js_baseH5.jsp"%>
<%@ include file="/portal/share/common/js_componentH5.jsp"%>
<%

	View view = ((View) request.getAttribute("content"));
	WebUser user =(WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ParamsTable params = ParamsTable.convertHTTP(request);
	String defaultSize = request.getParameter("_defaultSize");
	IRunner jsrun = JavaScriptFactory.getInstance(params.getSessionid(), view.getApplicationid());
	Collection errors = new HashSet();
	Collection columns=view.getColumns();
	String contextPath = request.getContextPath();
	// 组装queryString，WebSphere不支持getQueryString
	String queryString = "";
	Map parameterMap = request.getParameterMap();
	for(Iterator it = parameterMap.entrySet().iterator(); it.hasNext();) {
		Map.Entry entry = (Map.Entry)it.next();
		String[] values = (String[])entry.getValue();
		/*
		if(entry.getKey().equals("_viewid") || entry.getKey().equals("application") || entry.getKey().equals("isEdit") 
				|| entry.getKey().equals("_defaultSize") || entry.getKey().equals("allow") || entry.getKey().equals("fieldid")
				|| entry.getKey().equals("mutil") || entry.getKey().equals("parentid") || entry.getKey().equals("formid")
				|| entry.getKey().equals("_selectsText") || entry.getKey().equals("selectOne") || entry.getKey().equals("className")
				|| entry.getKey().equals("datetime") || entry.getKey().equals("_pagelines")){
			queryString += entry.getKey() + "="+values[0]+"&";
		}
		*/
		queryString += entry.getKey() + "="+values[0].replaceAll("[\t|\n|\r]", "")+"&";
	}
	
	if (!parameterMap.isEmpty()) {
		queryString = queryString.substring(0, queryString.length() - 1);
	}

%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge,chrome=1">
<!-- 
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
 -->
<!-- bootstrap引入 -->
<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/bootstrap-datetimepicker.min.css'/>" />
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap.min.js'/>"></script> 
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.min.js'/>"></script> 
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.zh-CN.js'/>"></script> 

<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/myapp.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/view.css'/>" />

<link rel="stylesheet" href="<s:url value='/resource/css/dialog.css'/>" type="text/css" media="all" />

<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="/portal/share/script/bootstrap/css/bootstrap-ie6.css">
    <link rel="stylesheet" type="text/css" href="/portal/share/script/bootstrap/css/myapp-ie.css" />
<![endif]-->
<!--[if lte IE 7]>
   <link rel="stylesheet" type="text/css" href="/portal/share/script/bootstrap/css/ie.css">
   <link rel="stylesheet" type="text/css" href="/portal/share/script/bootstrap/css/myapp-ie.css" />
<![endif]-->

<!--[if lt IE 9]> 
   <script src="/portal/share/script/bootstrap/script/html5shiv.min.js"></script>
<![endif]-->

<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/portal/share/script/drag.js"/>'></script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value='/portal/share/component/view/obpm.displayView.js' />'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<title>Insert title here</title>
<style type="text/css">
#dspview_divid {width: 100%;}
.display_view-table{word-wrap : break-word ;word-break:break-all;}
</style>
<script>
var rtn = {};
var rtnStr = "";
var args = OBPM.dialog.getArgs();
document.write(args['html']);
var importURL = "<s:url value='/portal/share/dynaform/dts/excelimport/importbyid.jsp'/>";
jQuery(function(){
	importURL +="&applicationid="+jQuery("#application").val();
});
var downloadURL = '<s:url value="/portal/share/download.jsp" />'; // Excel下载URL

var isEdit = '<%=request.getParameter("isEdit")%>';

//改为弹出层后，此属性将失效，不需要判断打开方式
var type='<%=request.getParameter("_isdiv")%>';

var rtn = {};
var selectString = "";

function ev_select(key,value,isChecked,obj) {
	var htmls = $(obj).parent().parent().html();
	var flag = true;
	if (isChecked) {
		jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
			if($(obj).attr("value") == jQuery(this).attr("value")){
				flag = false;
			}
		});
	if(flag){
		jQuery(".viewRightInfo").append("<tr id='right_" + key + "' onmouseout=\"this.className='listDataTr';\"onmouseover=\"this.className='listDataTr_over';\" class=\"listDataTr\">"+htmls+"</tr>");
		jQuery(".viewRightInfo").children().find("input[name=_selects]").replaceWith("<input type='checkbox'  name='_rightselects'  value='" + key + "' />");
	}
	rtn[key] = value;
	rtnStr += '"' + key + '":' + jQuery.json2Str(value,true) + ",";
	} else {
		jQuery(".viewRightInfo").children().remove("#right_"+ key);
		//使用正则表达式
		var del = new RegExp("\"" + escape(key)+ "\".+?},");
			
		//从全局变量rtnStr中删除“右侧选中删除项”
		rtnStr = rtnStr.replace(del,"");
		delete rtn[key];
	}
}

function ev_selectone(docid, value, selectOne) {
	if(selectOne=='false'){
		$("input[value='"+ docid +"']").click();
	}else{
		var params = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
		params['_selects'] = docid;
		ev_return(params, "{id:"+value+"}");
	}
}

function ev_selectAll_Left(b) {
	var c = document.getElementsByName('_selects');
    if(c==null)
    return;
    if (c.length!=null){
      for(var i = 0; i < c.length ;++i) {
        c[i].checked = b && !(c[i].disabled);
    	c[i].onclick();
      }
    }else{
      c.checked = b;
	}
	return b;

}

function ev_ok() {
	var params = jQuery.par2Json(decodeURIComponent(jQuery("#iframe").find("form").serialize()));
	var selects = "";
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		selects += jQuery(this).attr("value") + ";";
	});
	if(selects){
		selects = selects.substring(0,selects.length-1);
	}
	params['_selects'] = selects;
	
	//ev_return(params, jQuery.json2Str(rtn,true));
	rtnStr = "{" + rtnStr.substring(0,rtnStr.length - 1) + "}"; 
	//rtn改为字符拼接方式传递，解决IE10视图选择框跳页后不能执行已释放script问题
	ev_return(params,rtnStr);
}

//执行确定脚本(okscript)并返回
function ev_return(params, selectedValue) {
	DWREngine.setAsync(false);
	var result = {
			params :params,
			selectedValue:selectedValue
	};
	ViewHelper.runScript(params, function(rtn) {
		if (rtn) {
			if(rtn.indexOf('doAlert')>-1 || rtn.indexOf('doConfirm')>-1){
				eval(rtn);
			}else{
				var regExp = /<script.*>(.*)<\/script>/gi;
				if (regExp.test(rtn)) { // 2.执行脚本
					eval(RegExp.$1);
					OBPM.dialog.doReturn(result);
				} else {
					alert(rtn);
				}
			}
		} else {
			OBPM.dialog.doReturn(result);		
		}
	});
}

function doAlert(msg) {
	if (msg) {
		alert(msg);
	}
}

function doConfirm(msg, result) {
	if (msg) {
		if (confirm(msg)) {
			OBPM.dialog.doReturn(result);
		}
	}
}

/**
 * 禁用enter自动提交
 */
function stopEnterSubmit(){
	$("#formList").submit(function(e){
		e.preventDefault();
		queryDocument();
	});
}

function ev_init() {
	var defalutSize = <%=defaultSize%>;
	//Resize dialog, set the dialog window size as the body size.
	if(defalutSize){//后台显示大小为默认时，允许页面根据内容设置弹出层大小
		OBPM.dialog.resize(900, document.body.scrollHeight+270);
	}

	var c = document.getElementsByName('_selects');
	if (c) {
		for (prop in rtn) {
			
			for(var i = 0; i < c.length ;++i) {
				if (prop == c[i].value) {
					c[i].checked = true;
				}
			}
		}
	}
	
	var text = '<%=queryString%>';
	loaddialogViewByIframe(text);
	/*var func = new Function("changeElState('btn',false);");
	initElonclick('btn', func);*/
	
	//changeElState('btn',true); // change button state
	//viewDiv.style.width = (document.body.clientWidth - 45) + "px";
}

function loaddialogViewByIframe(text){

	var loadingDivBack = document.getElementById('loadingDivBack');
	if(loadingDivBack)	loadingDivBack.style.display = '';
	jQuery.ajax({
		url:contextPath + "/portal/dynaform/view/iframeDialogView.action",
		type:"post",
		data:text,
		dataType:"html",
		success:function(data){
			jQuery("#iframe").css("overflow","auto").html(data);
			jQuery(".viewRightInfo",document).find("input[name=_rightselects]").each(function(){
				var value = jQuery(this).attr("value");
				jQuery("#viewLeft").find("input[name=_selects]").each(function(){
					if(jQuery(this).attr("value") == value){
						jQuery(this).attr("checked",'true');
					}
				});
			});
			stopEnterSubmit();	//禁用表单自动提交

			var loadingDivBack = document.getElementById('loadingDivBack');
			if(loadingDivBack)	loadingDivBack.style.display = 'none';
			},
		error:function(data,status){
			var loadingDivBack = document.getElementById('loadingDivBack');
			if(loadingDivBack)	loadingDivBack.style.display = 'none';
			}
	});	 
}

/**
 * 第一页
 */
function showFirstPageByAjax(){
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageCount > 1) {
		var currPage = 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 上一页
 */
function showPreviousPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(FO[0]._currpage.value);

	if (pageNo > 1) {
		var currPage = pageNo - 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 下一页
 */
function showNextPageByAjax(){
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}
	var pageNo = parseInt(FO[0]._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageCount > 1 && pageCount > pageNo) {
		var currPage = pageNo + 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 最后一页
 */
function showLastPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	// var pageNo = parseInt(FO._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));

	if (pageCount > 0) {
		var currPage = pageCount;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

function ev_doClear(){
	var result = {
			params :"",
			selectedValue:""
	};
	OBPM.dialog.doClear(result);
}

/**
 * 跳转页面
 */
function jumpPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._jumppage.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(FO[0]._jumppage.value);
	var _pageCount = parseInt(FO[0]._pageCount.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageNo > _pageCount||pageNo<=0||isNaN(pageNo)) {
		alert(" 输入参数有误!");
		return;
	}
	if (pageCount > 1 && pageCount >= pageNo) {
		var currPage = pageNo;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 查询
 */
function queryDocument(){
	var FO = jQuery("#iframe").find("form");
	FO.find("[name='_currpage']").val("1");
	var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
	loaddialogViewByIframe(text);
	
}

function resetAll() {
	var elements = document.forms[0].elements;
	if(elements){
		for (var i = 0; i < elements.length; i++) {
			//alert(elements[i].type);
			if (elements[i].type == 'text') {
			   if(elements[i].id==elements[i].name){
			   }
				elements[i].value="";
			}
		}
	}
}
/**
function emptycheck(){
	jQuery(".viewRightInfo").find("tr[class=table-tr]").remove();
	jQuery(window.frames["iframe"].document).find("input[name=_selects]").attr("checked",false);
	rtn = {};
}
*/
function emptycheck(){
	//清空右方选择数据
	var selectAll_right = jQuery(".viewRightInfo").find(".listDataThFirstTd").find("input[type='checkbox']").attr("checked",false);
	jQuery(".viewRightInfo").find("tr[class=listDataTr]").remove();
	//清空左方勾选数据
	jQuery("#viewLeft").find(".listDataThFirstTd").find("input[type='checkbox']").attr("checked",false);
	jQuery("#viewLeft").find(".listDataTr").find("input[type='checkbox']").attr("checked",false);
	rtnStr = "";
	rtn = {};
	
	/* jQuery("#viewLeft").find("input[name=_selects]").each(function(){
		jQuery(this).attr("checked",false);
		rtnStr = "";
	});  
	rtn = {};
	*/
}

function deletechecked(){
	var checkboxs = document.getElementsByName("_rightselects");
	var isSelect = false;
	for (var i = 0; i < checkboxs.length; i++) {
		if (checkboxs[i].checked == true) {
			isSelect = true;
			break;
		}
	}
	if(isSelect){
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		if(jQuery(this).prop("checked")){
			var key = jQuery(this).attr("value");
			jQuery(".viewRightInfo").children().remove("#right_"+ key);

			jQuery("#viewLeft").find("input[value=" + key + "]").attr("checked",false);

			//使用正则表达式
			var del = new RegExp("\"" + escape(key)+ "\".+?},");
				
			//从全局变量rtnStr中删除“右侧选中删除项”
			rtnStr = rtnStr.replace(del,"");
			
			delete rtn[key];
		}
	});
	}else{
		alert("请选择要删除的项！");
		}
}

/**
function deletechecked(){
	var checkboxs = document.getElementsByName("_rightselects");
	var isSelect = false;
	for (var i = 0; i < checkboxs.length; i++) {
		if (checkboxs[i].checked == true) {
			isSelect = true;
			break;
		}
	}
	if(isSelect){
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		if(jQuery(this).attr("checked")){
			var key = jQuery(this).attr("value");
			jQuery(".viewRightInfo").children().remove("#right_"+ key);
			jQuery(window.frames["iframe"].document).find("input[value=" + key + "]").attr("checked",false);
			delete rtn[key];
		}
	});
	}else{
		alert("请选择要删除的项！");
		}
}
*/

function ev_selectAll_main(checked){
	var c = document.getElementsByName('_rightselects');
    if(c==null)
    return;
    if(checked){
        jQuery(".viewRightInfo").find("input[name=_rightselects]").prop("checked",true);
    }else{
    	jQuery(".viewRightInfo").find("input[name=_rightselects]").prop("checked",false);
    }
}
function viewDoc(docid, formid,isDiv) {
	// 查看common.js
	var url = contextPath + '/portal/dynaform/document/view.action';
	url += '?_docid=' + docid;
	if (formid != null && formid != "") {
		url += '&_formid=' +  formid;
	}
	url += "&show_act=false&signatureExist=false";
	url = appendApplicationidByView(url);
	
	showfrontframe({
		title : '{*[Select]*}',
		url : url,
		w : 800,
		h : 600,
		callback : function(result) {
		}
	});
}

function appendApplicationidByView(url) {
	var appObject = document.getElementsByName("application")[0];
	if (appObject && url.indexOf("application") < 0) {
		if (url.indexOf("?") >= 0) {
			url += "&application=" + appObject.value;
		} else {
			url += "?application=" + appObject.value;
		}
	}
	return url;
}
OBPM(document).ready(function(){
	ev_init();
	//表单控件jquery重构
	jqRefactor();
});
</script>
<style type="text/css">
.nowrap {table-layout: fixed;}
.viewRight{width:99%;overflow:auto;height:92%;}
.buttoncontainer{margin:3px 0px;}
.buttoncontainer a{margin:0 3px; cursor:pointer;}
.viewRight{border: 1px solid #b5b8c8;margin:0px;margin-top:8px;padding:0px;}
.tableContainer{border: 2px solid #e5e5e5;}
.tableContainer .bordertd{border-right: 2px solid #e5e5e5;}
.display_view-table{word-wrap : break-word ;word-break:break-all;}
</style>
</head>
<body style="margin:0;padding:0;overflow:auto;">
<!-- <div id="view_iframe"> --><div style="height:80%">
<!-- <table width="100%" height="80%" class="nowrap tableContainer"> --><table width="100%" height="100%">
	<tbody>
		<tr>
			<td width="50%" height="100%" valign="top" class="bordertd">
				<%-- <iframe name="iframe" id="iframe" frameborder=0 width="100%" height="100%" scrolling="auto" src="<%= contextPath %>/portal/dynaform/view/iframeDialogView.action?<%=queryString%>"></iframe> --%>
				<!-- 遮挡层 -->
				<div id="loadingDivBack" style="position: absolute; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.3;">
					<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;">
						<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
					</div>
				</div>
				<div name="iframe" id="iframe" style="width:100%;height:100%"></div>
			</td>
			<td class="right-box" width="50%" valign="top" align="left" style="padding: 15px;">
	            <div class="searchDiv">
	           		<ul class="nav nav-pills" style="_height:25px;">
	                    <li role="presentation" class="active" onclick="emptycheck()" style="_width:80px;_float: left;"><a class="ico-new"><i class="fl"></i>{*[cn.myapps.core.dynaform.view.ClearFile]*}</a></li>
	                    <li role="presentation" onclick="deletechecked()" style="_width:120px;_float:left;"><a class="ico-del"><i class="fl"></i>{*[cn.myapps.core.dynaform.view.delete_checked]*}</a></li>
	                </ul>
	            </div>
				<div class="dataTable">
				<table class="listDataTable text-center">
						<tbody class="viewRightInfo">
						<tr class="dtable-header listDataTh">
							<s:if test="#parameters.mutil[0] == 'true'">
								<td class="column-head2 listDataThFirstTd" scope="col"><input type="checkbox"
									onClick="ev_selectAll_main(this.checked)"></td>
							</s:if>
							<%
							Collection hiddns = new ArrayList();
							%>
							<s:iterator value="content.columns" status="colstatus">
							<s:set name="column" scope="page" />
							<%
								Boolean isHidden = new Boolean(false);
								Column column = (Column) pageContext.getAttribute("column");
								StringBuffer label = new StringBuffer();
								label.append("View").append("." + view.getName()).append(".Activity(").append(column.getId())
										.append(")." + column.getName()).append(".runHiddenScript");
								jsrun.initBSFManager(new Document(), params, user, errors);
								Object result = jsrun.run(label.toString(), column.getHiddenScript());//运行脚本
								if (result != null && result instanceof Boolean) {
									isHidden = ((Boolean) result).booleanValue();
								}else{
									isHidden = !column.isVisible();
								}
								hiddns.add(isHidden);
								if (isHidden.booleanValue()){
									
								}else{
									%>
								<s:if test="width != null && width != \"0\" && !#colstatus.last">
									<td class="listDataThTd" nowrap="nowrap" width='<s:property value="width"/>'>
										<a>{*[<s:property value="name" />]*}</a>
									</td>
								</s:if>
								<s:elseif test="width == \"0\"">
									<td class="listDataThTd" style="display: none;">
										<a>
										{*[<s:property value="name" />]*}
										</a>
									</td>
								</s:elseif>
								<s:else>
									<td class="listDataThTd">
										<a>
										{*[<s:property value="name" />]*}
										</a>
									</td>
								</s:else>
								<%} %>
							</s:iterator>
			
							<s:if test="#parameters.allow[0] == 'true'">
								<td class="listDataThTd">
									<a>{*[View]*}</a>
								</td>
							</s:if>
						</tr>
						</tbody>
						</table>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<div class="viewselect">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<ul class="nav nav-pills">
					<s:if test="(#parameters.mutil[0] == 'true'||#parameters.selectOne[0] == 'true')&&#parameters.isEdit[0] == 'true'">	
		            <li role="presentation" style="_float:left;"><a class="ico-new" href="#" onClick="ev_ok()"><i class="fl"></i>{*[OK]*}</a></li>
					</s:if> 
					<s:if test="#parameters.isEdit[0] == 'true'">
		            <li role="presentation" style="_float:left;"><a class="ico-del" onClick="ev_doClear()"><i class="fl"></i>{*[Clear]*}</a></li>
					</s:if>	
		        </ul>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</o:MultiLanguage>
</html>