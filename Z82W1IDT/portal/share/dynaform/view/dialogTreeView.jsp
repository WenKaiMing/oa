<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.type.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String viewid = request.getParameter("_viewid");
	String styleid = ViewHelper.get_Styleid(viewid);
	String mutil=request.getParameter("mutil");
	
	View view = (View) request.getAttribute("content");
	Map<String, Column> columnMapFields = view.getViewTypeImpl().getColumnMapping();
	String nodeNameField = ((Column) columnMapFields.get(TreeType.DEFAULT_KEY_FIELDS[2])).getFieldName();// 树节点名称
%>
<%@page import="cn.myapps.core.dynaform.view.action.ViewHelper"%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@include file="/portal/share/common/lib.jsp"%>
	<%@include file="/portal/share/common/js_base.jsp"%>
	<link rel="stylesheet" href="<s:url value='/portal/share/css/share-front.css'/>" type="text/css" media="all" />
	<!-- 树形插件 -->
	<script type="text/javascript"
		src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.tree.js'/>"></script>
	<script type="text/javascript"
		src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
	<!-- 布局插件 -->
	<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
	<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
	
	<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
	<style type="text/css">
<!--
body {
	margin: 0px;
	overflow:auto;
}
-->
</style>
	<script type="text/javascript">
	var args = OBPM.dialog.getArgs();
	var treeview = null;
	var selectedNode = ""; // 已选中的节点
	var mutil='<%=mutil%>';//是否多选
	
	jQuery(document).ready(function () {
		OBPM.dialog.resize(document.body.scrollWidth+100, document.body.scrollHeight+30);
		jQuery('body').layout({ 
			applyDefaultStyles: false 
		});
		// 注册查询事件
		jQuery("#search").click(function () {
			jQuery("#tree").jstree("search", jQuery("#text").val());
		});
		
		$("form").on("submit",function(){
			jQuery("#tree").jstree("search", jQuery("#text").val());
			return false;
		})
		
		if(mutil=='false')
			singleSelTreeLoad();
		else if(mutil=='true')
			multipleSelTreeLoad();
		else
			return;
	});
	//单选视图
	function singleSelTreeLoad() {        
	  	treeview = jQuery("#tree").jstree({ 
			core:{
				initially_open: ['root'],
				animation: 100
			},
			// JSON数据插件
			"json_data" : {
				//去掉根节点root，因为root无数据
				/*
				"data" : [
					{ 
						"data" : "root", //视图名称
						"state" : "closed",
						"attr" : { 
							"id" : "root", 
							"viewid": jQuery("#viewid").val() //视图ID
						} 
					}
				],*/
				"ajax" : { 
						"url" : function (){
									return contextPath + "/portal/dynaform/view/getChildren.action?_viewid="+jQuery("#viewid").val()+"&datetime=" + new Date().getTime();
								},
						"type": "POST",
						"dataType": "json",
						"data" : function (node) { 
							// buildParams
							var params = {};
							if (node.attr) {
								params['treedocid'] = node.attr("id"); // 树形父文档ID
								params['_viewid'] =  node.attr("viewid"); // 视图ID
							}
							return params;
						}
				}
			},
			"search" : {
				"case_insensitive" : true, // 区分大小写
				"ajax" : {
					"url" : function (){
						var cnameParam={<%=nodeNameField%>:jQuery("#text").val()};
						return contextPath + "/portal/dynaform/view/search.action?"+jQuery.param(cnameParam,true)+"&datetime=" + new Date().getTime();
					},
					"data" : function (node) { 
						// buildParams
						var params = {};
						params['_viewid'] =  jQuery("#viewid").val(); // 视图ID
						var key = jQuery("#text").attr("name");
						params[key] =  jQuery("#text").val(); // 表单字段值
						return params;
					}
				}
			},
			"plugins" : [ "themes", "json_data", "types", "ui", "search", "adv_search"]
		}).bind("select_node.jstree", function(e, data){
			var node = data.rslt.obj;
			var params = "";
			if (node && node.attr) {
				var rtn="{'id':"+node.attr("valuesMap")+"}";
				var params = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
	  			params["_selects"] = node.attr("id");
	  			var isEdit = '<s:property value="#parameters.isEdit[0]"/>';
	  			if(isEdit == "true"){
	  				ev_return(params, rtn);
	  			}
			}
		});
	}
	//多选视图
	function multipleSelTreeLoad() {        
	  	treeview = jQuery("#tree").jstree({ 
			core:{
				initially_open: ['root'],
				animation: 100
			},
			// JSON数据插件
			"json_data" : {
				//去掉根节点root，因为root无数据
				/*
				"data" : [
					{ 
						"data" : "root", //视图名称
						"state" : "closed",
						"attr" : { 
							"id" : "root", 
							"viewid": jQuery("#viewid").val() //视图ID
						} 
					}
				],*/
				"ajax" : { 
					"url" : contextPath + "/portal/dynaform/view/getChildren.action?_viewid="+jQuery("#viewid").val()+"&datetime=" + new Date().getTime() ,
					"data" : function (node) { 
						// buildParams
						var params = {};
						if (node.attr) {
							params['treedocid'] = node.attr("id"); // 树形父文档ID
							params['_viewid'] =  node.attr("viewid"); // 视图ID
							valueMapStr =  node.attr("valuesMap"); // 视图ID
						}
						return params;
					}
				}
			},
			"search" : {
				"case_insensitive" : true, // 区分大小写
				"ajax" : {
					"url" : function (){
						return contextPath + "/portal/dynaform/view/search.action?datetime=" + new Date().getTime();
					},
					"data" : function (node) { 
						// buildParams
						var params = {};
						params['_viewid'] =  jQuery("#viewid").val(); // 视图ID
						var key = jQuery("#text").attr("name");
						params[key] =  jQuery("#text").val(); // 表单字段值
						return params;
					}
				}
			},
			//级联配置
			"checkbox" : {
				cascade: false
			},
			"plugins" : [ "themes", "json_data", "types", "ui", "core","checkbox", "search", "adv_search"]
		}).bind("click.jstree", function(e, data){
			var menu = treeview.jstree("select_node");
			var ischeck = treeview.jstree("is_checked");
			//if(ischeck)
				//alert("menu-->"+menu.attr("valuesMap"));
		});
	}
	
	// 根据值映射获取文档ID
	function getAllSelects() {
		var temp = [];
		var rtn = "";
		var menu = treeview.jstree("get_checked");	
		if (menu) {
			for(i=0;i<menu.size();i++){
				temp.push(menu[i].id);
			}
			
			if (temp.length > 0) {
				rtn = temp.join(";");
			}
		}
		
		return rtn;
	}
	
	//多选时获取选定的value并拼接成json格式字符串返回
	function getAllchecked(){
		var menu = treeview.jstree("get_checked");	
		var valueMapStr="{";
		for(var i=0;i<menu.size();i++){
			valueMapStr = valueMapStr+"'"+menu[i].id+"':"+menu[i].getAttribute('valuesMap')+",";
			if(menu[i].id=="root"){
				alert("root-->"+menu[i].id);
			}
		}
		if(valueMapStr.length >1 ){
			valueMapStr=valueMapStr.substring(0,valueMapStr.length-1);
		}
		valueMapStr+="}";
		return valueMapStr;
	}
	
	// 执行确定脚本(okscript)并返回
	function ev_return(params, result) {
		var result = {
			params :params,
			selectedValue:result
		};
		ViewHelper.runScript(params, function(rtn) {
			if (rtn) {
				if(rtn.indexOf('doAlert')>-1){
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

	
	function doReturn() {
		var valueMapStr=getAllchecked();
		var params = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
		params["_selects"] = getAllSelects();
		ev_return(params, valueMapStr);
	}
	
	function ev_selectAll(b) {
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
</script>
<title>Tree View</title>
</head>

<body>
<s:form id="formList" name="formList" action="dialogView" method="post" theme="simple">
	<table border="0" width="97%" align="center" cellpadding="4" cellspacing="0">
		<tr id="btnbarTR">
			<td>
				<fieldset> 
	    			<legend></legend>
	    			<table>
						<tr>
							<s:if test="#parameters.isEdit[0] == 'true' && #parameters.selectOne[0] == 'false'">
								<td class="line-position2" width="80" valign="top">
								<button type="button" class="button-class" onClick="doReturn();"><img
									src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</button>
								</td>
							</s:if>
				
							<td class="line-position2" width="80" valign="top">
							<button type="button" class="button-class" onClick="OBPM.dialog.doExit()">
							<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Cancel]*}</button>
							</td>
				
							<td class="line-position2" width="80" valign="top">
							<button type="button" class="button-class" onClick="OBPM.dialog.doClear()">
							<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
							</td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="list-srchbar">
			</td>
		</tr>
	</table>
<div style="height: 360px; margin-bottom:20px; width: 100%; overflow: auto;">
	<table border="0" width="97%" align="center" cellpadding="0" cellspacing="1">
		<tr class="row-hd">
			<td>
			<fieldset> 
	    		<legend></legend>
	    		<table width="100%">
	    			<tr height="5px" class="row-hd">
						<td align="left" valign="top">查询值：
							<input type="text" id="text" name='<s:property value="content.nodeNameField" />' value="" size="15"/>
							<input type="button" id="search" value="{*[Query]*}" />
						</td>
					</tr>
					<tr><td align="left" valign="top"  height="310">
						<div id="tree" class="commFont"></div>
					</td></tr>
				</table>
			</fieldset>
			</td>
		</tr>
	</table>
	<s:hidden id="viewid" name="_viewid" />
	<s:hidden id="formid" name="formid" value="%{#parameters.formid}"/>
	<s:hidden id="fieldid" name="fieldid" value="%{#parameters.fieldid}"/>
	</div>
	<script>
		var args = OBPM.dialog.getArgs();
		document.write(args['html']);
	</script>
</s:form>
</body>
</o:MultiLanguage>
</html>