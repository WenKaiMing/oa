<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp" %>
<% 
	String contextPath = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/common/head.jsp"%>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	
	<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
	
	<style type="text/css">
	body{
	padding: 0px;
	margin: 0px;
	}
	</style>
	<script type="text/javascript">
	var appId = '<s:property value="#parameters.id"/>';
	function treeload() {
		jQuery.ajaxSetup({cache:false});//IE缓存区清理
		treeview = jQuery("#leftTree").jstree({ 
			core:{
				initially_open: ['datasource']
			}, 
			json_data : {
				data : [
							{
								data : "{*[DataSource]*}",
								state : "closed",
								attr : {
									rel : "datasource",
									id : "datasource"
								} 
							}
						],
				ajax : {
					url : function (){
						return '<s:url value="/core/dynaform/dts/datasource/getMetadata.action"/>?application='+appId;
					},
					data : function (node) {
						var params = {};
						if (node.attr) {
							params['application'] = node.attr("application");
							params['subNodes'] = node.attr("subNodes");
							params['datasourceId'] = node.attr("datasourceId");
						}
						return params;
					}
				}
			},
			types :{
				valid_children : ["datasource"],
				types : {
				datasource : {
	                	valid_children : ["db", "db_selected"],
	                	icon : {    
	                    	image : '<s:url value="/resource/imgnew/datasource.gif"/>'
	                	}
	            	},
	            	db : {
	                	valid_children : ["table"],
	                	icon : {    
	                    	image : '<s:url value="/resource/imgnew/db.png"/>'
	                	}
	            	},
	            	db_selected : {
	            		valid_children : ["table"],
	                	icon : {    
	                    	image : '<s:url value="/resource/imgnew/db_selected.png"/>'
	                	}
	            	},
	            	table : {
	                	valid_children : "none",
	                	icon : {    
	                    	image : '<s:url value="/resource/imgnew/table.gif"/>'
	                	}
	            	}
				}
			},
			checkbox : {
				cascade: true
			},
			plugins : ["themes", "json_data", "ui", "checkbox", "types"]
		}).bind("select_node.jstree", function(e, data){
			var node = data.rslt.obj;
			if (node && node.attr) {
				//if (selectedNode != node.attr("id")) {
					var datasourceId = node.attr("datasourceId");
					var formId = node.attr("formId");
					var curNode = node.attr("curNode");
					if(curNode == 'isTable') {
					    var page = '<s:url value="/core/dynaform/dts/datasource/viewMetadata.action"/>?datasourceId=' + 
					    datasourceId + "&formId=" + formId+"&_comefrom=metadataManager";
					} else if(curNode == 'isDts') {
						var page = '<s:url value="/core/dynaform/dts/datasource/editDataSource.action"/>?id=' + 
						datasourceId + "&noNeedExit=true&content.applicationid=" + appId + "&refresh=true&parent=datasource&_comefrom=metadataManager";
					}
				    jQuery("#tableInfo").attr("src", page);
				//}
			}
		});
	}
	</script>
	<script type="text/javascript">
		function doAdd(){
			var newDataSourceUrl = '<s:url value="/core/dynaform/dts/datasource/newDataSource.action"/>' + 
			"?noNeedExit=true&content.applicationid=" + appId + '&refresh=true&parent=datasource';
			jQuery("#tableInfo").attr("src", newDataSourceUrl);
		}
		function doDelete(){
			var seletes = getAllSelects();
			if(seletes && seletes != ""){
				var deleteDataSourceUrl = '<s:url value="/core/dynaform/dts/datasource/deleteSource.action"/>?selectId=' + 
				seletes + "&tab=3&id=" + appId + '&selected=<s:property value="#parameters.selected"/>&application=' + appId;
				//var form = document.forms[0];
				window.location.href = deleteDataSourceUrl;
			} else {
				alert("{*[please.select.datasource]*}");
			}
		}
		function getAllSelects() {
			var temp = [];
			var rtn = "";
			var menu = treeview.jstree("get_checked");
			var curNode = menu.attr("curNode");
			if (menu) {
				for(i=0;i<menu.size();i++){
					if(curNode == "isDts"){
						temp.push(menu[i].id);
					}
				}
				if (temp.length > 0) {
					rtn = temp.join(";");
				}
			}
			
			return rtn;
		}
		function refresh(){
			treeload();
			//window.location.href = '<s:url value="/core/dynaform/dts/metadata/metadataManager.jsp"/>?id=' + 
			//appId + '&mode=application&tab=3&selected=<s:property value="#parameters.selected"/>';
		}
	</script>
	<script type="text/javascript">
	jQuery(document).ready(function(){
		inittab();
		window.top.toThisHelpPage("application_info_advancedTools_metadataManager");
		treeload();
		var thislayout=jQuery('#leftFrame').layout({ 
			applyDefaultStyles: true 
		});
	});
	function adjustViewLayout(){		
		var documentH=parent.document.body.offsetHeight;
		jQuery("body").height(documentH);
		var tab_tableH=jQuery("#tab_table").height();
		jQuery("#leftFrame").height(documentH-tab_tableH);
		if(navigator.userAgent.indexOf("MSIE")>0)
			{ 
				jQuery("#leftTree").height(documentH-tab_tableH-80);
	  		}
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0)
			{
				jQuery("#leftTree").height(documentH-tab_tableH-90);
		   	}
		if(isChrome=navigator.userAgent.indexOf("Chrome")>0)
          {
				jQuery("#leftTree").height(documentH-tab_tableH-72);
	      } 
	}
jQuery(window).load(function(){
	adjustViewLayout();	
});
jQuery(window).resize(function(){
	adjustViewLayout();	
});
	</script>
	
	<title>{*[cn.myapps.core.validate.repository.metadatamanager]*}</title>
	</head>
	<body>
	<%@include file="/common/commontab.jsp"%>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="navigation_title">{*[cn.myapps.core.validate.repository.metadatamanager]*}</div>	
	<div id="leftFrame" style="overflow: auto;padding-bottom: 20px;border:0px;">
		<div class="ui-layout-west">
			<table width="100%" cellpadding="4" cellspacing="0" 
				 style="border-color: #cccccc;border-bottom:1px;border-bottom-style: solid;">
				<tr>
					<td width="14%" style="border-right: 0px;">{*[DataSource]*}：</td>
					<td width="6%" align="right" style="border-left: 0px">
						<button type="button" id="add" class="" onclick="doAdd();">{*[Add]*}</button>
						<button type="button" id="delete" class="" onclick="doDelete();">{*[Delete]*}</button>
					</td>
				</tr>
			</table>
			<div id="leftTree" style="overflow: auto;"></div>
		</div>
		<div class="ui-layout-center">
			<table width="100%" cellpadding="4" cellspacing="0" 
				border="0" style="border-color: #cccccc;">
				<tr>
					<td valign="top"><iframe id="tableInfo" frameborder="0" scrolling="no" 
					src="" width="100%" height="600"></iframe></td>
				</tr>
			</table>
		</div>
	</div>
	</body>
</o:MultiLanguage>
</html>