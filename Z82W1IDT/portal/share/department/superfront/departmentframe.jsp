<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/portal/share/common/lib.jsp"%>
<% 
	String domain = request.getParameter("domain");
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<%@include file="/portal/share/common/js_base.jsp"%>
<title>{*[Departments]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
	var domain = '<%=domain%>';
</script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
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
		var listform = userFrame.window.document.getElementById("departmentlist");
		var parentid = userFrame.window.document.getElementById("parentid");
	    if(isSelectedOne2("_selects")){
	    	listform.action='<s:url action="delete"><s:param name="parentid" value='+parentid+' /></s:url>';
	    	listform.submit();
	    }
	}
</script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script type="text/javascript">
function departlist(){
	document.getElementById("selectnode").value="";
	document.getElementById("isclick").value ="true";
	document.getElementById("selectnode").value= document.getElementById("superiorid").value;
	document.getElementById("departname").value= document.getElementById("sm_name").value;
	var sm_name= document.getElementById("sm_name").value;
	var superiorid = document.getElementById("superiorid").value;
	//alert(departmentId);
	var page = contextPath + "/portal/department/departmentlist.action?domain=<%=request.getParameter("domain")%>&sm_name="+sm_name+"&sm_superior.id="+superiorid;
	jQuery("#userFrame").attr("src", page);	
}
function donew(){
	document.getElementById("selectnode").value="";
	document.getElementById("isclick").value ="true";
	var page = contextPath + "/portal/department/new.action?domain=<%=request.getParameter("domain")%>";
	jQuery("#userFrame").attr("src", page);	
}
</script>
<script type="text/javascript">
    var treeview = null;
    var selectedNode = ""; // 已选中的节点
    
	jQuery(window).load(function () {
		var thislayout=jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		//alert(domain);
		treeload();
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
						return contextPath + "/portal/department/departTree.action?domain=<%=request.getParameter("domain")%>&datetime=" + new Date().getTime();
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
				cascade: false
			},
			//右键功能
			contextmenu :{
				items :{
				"add" : {
				    "separator_before"	: true,
				    "separator_after"	: true,
				    "label"				: "{*[core.departmenttree.addDepartment]*}",
				    "action"			: function(node){
					                        var page = contextPath + "/portal/department/new.action?domain=<%=request.getParameter("domain")%>&_superiorid="+node.attr("id");
					                        jQuery("#userFrame").attr("src", page);
				                         }
					   },
			   "edit" : {
				    "separator_before"	: true,
				    "separator_after"	: true,
				    "label"				: "{*[core.departmenttree.editDepartment]*}",
				    "action"			: function(node){
					                        var page = contextPath + "/portal/department/edit.action?domain=<%=request.getParameter("domain")%>&id="+node.attr("id");
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
						                            var url = contextPath+"/portal/department/treeDelete.action?domain=<%=request.getParameter("domain")%>&departmentids="+ids+"&datetime=" + new Date().getTime(); 					                        
										        	jQuery.post(url,function(){//表单提交方式 
										        	   }).success(function(x){//提交成功回调 
										        		   if(x.responseText!=null&&x.responseText!='')//提示不能删除
																if(x.responseText=="rootdepartment"){
																	alert("{*[core.departmenttree.rootdepartment]*}");
																	}
																else if(x.responseText=="hasChild"){
																	alert("{*[core.departmenttree.hasChild]*}");
																}else{
																alert("{*[core.departmenttree.hasUser]*}");	
   																	}
										        	   });
													treeview.jstree("refresh")																																	                        															                         
						                            var page = contextPath + "/portal/department/departmentlist.action?domain=<%=request.getParameter("domain")%>";
							                        jQuery("#userFrame").attr("src", page);
						                            }
					                         }
						}
				}
			},
	
			"plugins" : [ "themes", "json_data","lang", "ui","contextmenu"]
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
			      var page = contextPath + "/portal/department/departmentlist.action?domain=<%=request.getParameter("domain")%>&sm_superior.id="+node.attr("id");
			      jQuery("#userFrame").attr("src", page);
		          selectedNode = node.attr("id");
				}
			}
		});
		
		//jQuery("#tree").jstree("select_node","#root");
	}

</script>
</head>
<body style="margin: 0;padding: 0;">
<div class="ui-layout-west" style="overflow: auto;"><div id="tree" style="padding-top: 5px;"></div></div>
	
<div class="ui-layout-center">
	<div id="main" style="height:100%;border-top:0px">
		<div id="contentTable" style="height:100%;">
			<iframe width="100%" height="100%" src="<s:url value='/portal/department/departmentlist.action'/>?domain=<%=domain %>"
				id="userFrame" scrolling="no" frameborder="0" name="userFrame" style="border: 0px;" /></iframe>
		</div>
	</div>
</div>
	<s:hidden id="isclick" value="false"></s:hidden>
	<s:hidden id="selectnode" value=""></s:hidden>
	<s:hidden id="departname" value=""></s:hidden>
	<s:hidden id="isedit" value="false"></s:hidden>
</body>
</o:MultiLanguage>
</html>