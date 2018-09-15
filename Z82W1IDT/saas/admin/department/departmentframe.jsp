<%@include file="/common/tags.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<% 
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<%@include file="/common/head.jsp" %>
<%
	String app=(String) session.getAttribute("DOMAIN");
%>
<title>{*[Departments]*}</title>
<style type="text/css">
	#departmentTreeSwitch{
		border-bottom:solid 1px #D8DADC;
		padding-left:10px
		}
	#departmentTree{
		padding-left:8px;
		padding-top:5px
		}
</style>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href='<s:url value="/script/dtree/dtree.css" />' type="text/css">
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<link rel="stylesheet" href='<s:url value="/script/dtree/dtree.css" />' type="text/css">
<script src="<s:url value='/script/dtree/dtree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DepartmentHelper.js"/>'></script>
<script type="text/javascript">
	function isSelectedOne2(fldName) {
		var c = userFrame.window.document.getElementsByName(fldName);
		//alert(c);
		var flag = false;
		if (c && c.length > 0) {
			for (var i = 0; i < c.length; i++) {
				if (c[i].checked) {
					flag = true;
					break;
				}
			}
		}
	
		if (!flag) {
			alert("{*[please.choose.one]*}");
			return false;
		}
		return true;
	}
	function doDelete(){

		//userFrame.window.document.getElementById("formname")
		document.getElementById("selectnode").value="";
		var listform = userFrame.window.document.getElementById("formList");
		var parentid = userFrame.window.document.getElementById("parentid");
	    if(isSelectedOne2("_selects")){
	    	listform.action='<s:url action="delete"><s:param name="parentid" value='+parentid+' /></s:url>';
	    	listform.submit();
	    }
	}

function departlist(){
	document.getElementById("selectnode").value="";
	document.getElementById("isclick").value ="true";
	document.getElementById("selectnode").value= document.getElementById("superiorid").value;
	document.getElementById("departname").value= document.getElementById("sm_name").value;
	var sm_name= document.getElementById("sm_name").value;
	var superiorid = document.getElementById("superiorid").value;
	//alert(departmentId);
	var page = contextPath + "/saas/admin/department/departmentlist.action?domain=<%=request.getParameter("domain")%>&sm_name="+sm_name+"&sm_superior.id="+superiorid;
	jQuery("#userFrame").attr("src", page);	
}
function donew(){
	document.getElementById("selectnode").value="";
	document.getElementById("isclick").value ="true";
	var page = contextPath + "/saas/admin/department/new.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="datas.pageNo"/>&_pagelines=<s:property value="datas.linesPerPage"/>&_rowcount=<s:property value="datas.rowCount"/>";
	jQuery("#userFrame").attr("src", page);	
}

    var treeview = null;
    var selectedNode = ""; // 已选中的节点
    
	jQuery(document).ready(function () {
		var thislayout=jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		//treeload();
		autoHeight();
		init_DepartmentTree();

		jQuery("#departmentTree").height(jQuery("body").height()-25);
		jQuery(window).resize(function(){
			jQuery("#departmentTree").height(jQuery("body").height()-25);
		});
	});
	
	function treeload() {        
		treeview = jQuery("#tree").jstree({ 
			core:{
				initially_open: ['root']
			}, 
			// JSON数据插件
			"json_data" : {
				"ajax" : { 
					"url" : function (){
						return contextPath + "/saas/admin/department/departTree.action?domain=<%=request.getParameter("domain")%>&datetime=" + new Date().getTime();
					},
					"data" : function (node) { 
						// buildParams
						var params = {};
						if (node.attr) {
							params['parentid'] = node.attr("id"); // 上级部门ID
							//params['_viewid'] =  node.attr("viewid"); // 视图ID
							//alert(node.attr("id"));
						}
						return params;
					}
				}
			},
			"checkbox" : {
				cascade: true
			},
			//右键功能
			contextmenu :{
				items :{
				"add" : {
				    "separator_before"	: true,
				    "separator_after"	: true,
				    "label"				: "{*[core.departmenttree.addDepartment]*}",
				    "action"			: function(node){
					                        var page = contextPath + "/saas/admin/department/new.action?domain=<%=request.getParameter("domain")%>&_superiorid="+node.attr("id");
					                        jQuery("#userFrame").attr("src", page);
				                         }
					   },
			   "edit" : {
				    "separator_before"	: true,
				    "separator_after"	: true,
				    "label"				: "{*[core.departmenttree.editDepartment]*}",
				    "action"			: function(node){
					                        var page = contextPath + "/saas/admin/department/edit.action?domain=<%=request.getParameter("domain")%>&id="+node.attr("id");
					                        jQuery("#userFrame").attr("src", page);
				                         }
					   },
			    "delete" : {
					    "separator_before"	: true,
					    "separator_after"	: true,
					    "label"				: "{*[core.departmenttree.deleteDepartment]*}",
					    "action"			: function(node){	
						                               var menu = treeview.jstree("get_checked");//获取选中的部门id
						                               if(menu.size()==0){
							                               alert("{*[core.departmenttree.selectDepartment]*}");
							                               return;
							                               }
						                            if(confirm("{*[core.departmenttree.ensure]*}")){
					    	                             var ids="";
					    	                             for(i=0;i<menu.size();i++){
						    	                             if(i!=menu.size()-1){
						    	                            	 ids += menu[i].id+";";
						    	                             }else if(i==menu.size()-1){
						    	                            	 ids += menu[i].id;
							    	                             }
					    	                              
					    	                              }
						                            var url = contextPath+"/saas/admin/department/treeDelete.action?domain=<%=request.getParameter("domain")%>&departmentids="+ids+"&datetime=" + new Date().getTime(); 					                        
                                                    jQuery.post(url,function(){
                                                     }).success(function(response){
                                                    	 if(response.responseText!=null&&response.responseText!='')//提示不能删除
																if(response.responseText=="rootdepartment"){
																	alert("{*[core.departmenttree.rootdepartment]*}");
																	}
																else if(response.responseText=="hasChild"){
																	alert("{*[core.departmenttree.hasChild]*}");
																}else{
																alert("{*[core.departmenttree.hasUser]*}");	
 																	}
                                                     });
                                                    
													treeview.jstree("refresh")																																	                        															                         
						                            var page = contextPath + "/saas/admin/department/departmentlist.action?domain=<%=request.getParameter("domain")%>";
							                        jQuery("#userFrame").attr("src", page);
						                            }
					                         }
						}
				}
			},
	
			"plugins" : [ "themes", "json_data","lang", "ui","checkbox"]
		}).bind("select_node.jstree", function(e, data){
			var evt = document.all ? window.event : e;
 			var o = evt.target || evt.srcElement;
 			var isclick = document.getElementById("isclick").value;	
 			
			//alert(isclick);
 			var isEdit = document.getElementById("isedit").value;
			if(isclick=="true"||isEdit=="true"){
				selectedNode = "";
			}
			// 判断当前元素是否为checkbox
			var isCheckEl = jQuery(o).attr("class") == "jstree-checkbox" 
			
			var node = data.rslt.obj;
			if (node && node.attr) {
				if (selectedNode != node.attr("id") && !isCheckEl) { // 是否刷新右窗口	
				  document.getElementById("isclick").value="false";	
				  document.getElementById("isedit").value="false";  	
				  document.getElementById("selectnode").value=node.attr("id");
			      var page = contextPath + "/saas/admin/department/departmentlist.action?domain=<%=request.getParameter("domain")%>&sm_superior.id="+node.attr("id");
			      jQuery("#userFrame").attr("src", page);
		          selectedNode = node.attr("id");
				}
			}
		});
		
		//jQuery("#tree").jstree("select_node","#root");
	}

	/*contentTable高度自适应，兼容ie/ff*/
	function autoHeight(){
		var bodyHeight=document.body.scrollHeight;
		jQuery("#userFrame").parent("div").css("height",bodyHeight);
		jQuery("#userFrame").css("height",bodyHeight - 3);	
		
	}
	jQuery(window).resize(function(){
		autoHeight();			
	});
	/*实现dtree*/
	var d = new dTree('d','<s:url value="/script/dtree"/>','menusCheckbox');
	function init_DepartmentTree()
	{
		var domain='<%=request.getParameter("domain")%>';
		d = new dTree('d','<s:url value="/script/dtree"/>','menusCheckbox');
		var root = domain;
		var rightFunction;
		d.add(root, '-1', '{*[Departments]*}', '', '', 'userFrame', null, null, null, '');

		DepartmentHelper.getDepartmentList(domain, function(data){
			if(data!=null){
				var departments=data;
				for(var i=0; i<departments.length;i++){
					var url = contextPath + '/saas/admin/department/departmentlist.action?domain='+'<%=request.getParameter("domain")%>';
					if(departments[i].superior==null || departments[i].superior.id==""){
						d.add(departments[i].id, root, departments[i].name, url, departments[i].name, 'userFrame', '', '', '', '');
					}else{
						url+='&sm_superior.id='+departments[i].id;
						d.add(departments[i].id, departments[i].superior.id, departments[i].name, url, departments[i].name, 'userFrame', '', '', '', '');
					}
				}
			}
			jQuery("#departmentTree").html(""+d);
		});
		//jQuery("#dtree").html(""+d);
	}

</script>
</head>
<body style="margin: 0;padding: 0;">
<div class="ui-layout-west">
 <!-- 原来的jsTree
	<div id="tree" style="padding-top: 5px;"></div>
  -->
  <!-- 以下为dtree -->
  	<div id='departmentTreeSwitch'>
  		<a href="javascript:d.openAll();">{*[Open]*}{*[All]*}</a>&nbsp;|&nbsp;<a href="javascript:d.closeAll();">{*[Close]*}{*[All]*}</a>
	</div>
	<div id="departmentTree" style="overflow:auto;"></div>
</div>
	
<div class="ui-layout-center">
	<div id="main">
		<div id="contentTable" style="height:100%;overflow-y:auto;">
			<iframe width="100%" height="100%" scrolling="auto" src="<%=request.getContextPath() %>/saas/admin/department/departmentlist.action?domain=<%=request.getParameter("domain")%>"
				id="userFrame" frameborder="0" name="userFrame" style="border: 0px;"  /></iframe>
		</div>
	</div>
</div>
	<s:hidden id="isclick" value="false"></s:hidden>
	<s:hidden id="selectnode" value=""></s:hidden>
	<s:hidden id="departname" value=""></s:hidden>
	<s:hidden id="isedit" value="false"></s:hidden>
</body>
</o:MultiLanguage></html>