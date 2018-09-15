<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<% 
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<%@include file="/portal/share/common/js_base.jsp"%>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[User]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<!-- 树形插件 -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script type="text/javascript">
	function donew(){
		jQuery("#isclick").attr("value","true");
		jQuery("#selectnode").attr("value","");
		var page = contextPath + "/portal/user/new.action?domain=<%=request.getParameter("domain")%>";
		jQuery("#userFrame").attr("src", page);	
	}
	
	function isSelectedOne2(fldName) {
		var c = userFrame.window.document.getElementsByName(fldName);
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
	var treeview = null;
	var selectedNode = ""; // 已选中的节点
	
	function userlist(sm_name,sm_loginno,departmentId,roleId,applicationId){
		jQuery("#selectnode").attr("value","");
		jQuery("#isclick").attr("value","true");
		jQuery("#name").attr("value",sm_name);
		jQuery("#loginno").attr("value",sm_loginno);
		jQuery("#selectnode").attr("value",departmentId);
		jQuery("#applicationid").attr("value",applicationId);
		jQuery("#roleid").attr("value",roleId);
		jQuery("#departid").attr("value",departmentId);

		var page = contextPath + "/portal/user/superusertreelist.action?domain=<%=request.getParameter("domain")%>&applicationid=" + applicationId + "&sm_name="+sm_name+"&sm_loginno="+sm_loginno+"&sm_userDepartmentSets.departmentId="+departmentId+"&sm_userRoleSets.roleId="+roleId+"&_orderby=orderByNo&_orderby=id";
		jQuery("#userFrame").attr("src", page);	
	}
	jQuery(document).ready(function () {
		var thislayout=jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		treeload();
		autoHeight();
	});
		
	function treeload() {        
		treeview = jQuery("#tree").jstree({ 
			core:{
				initially_open: ['root']
			}, 
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
						}
						
						return params;
					}
				}
			},		
			"checkbox" : {
				cascade: true
			},		
			"plugins" : [ "themes", "json_data","lang", "ui",]
		}).bind("select_node.jstree", function(e, data){
			var isclick = document.getElementById("isclick").value;	
			//alert(isclick);
			var isEdit = document.getElementById("isedit").value;
			if(isclick=="true"||isEdit=="true"){
				selectedNode = "";
			}
			//alert(isEdit);
			var node = data.rslt.obj;
			if (node && node.attr) {
				if (selectedNode != node.attr("id")) { // 是否刷新右窗口	
					document.getElementById("selectnode").value = node.attr("id");
					document.getElementById("isclick").value="false";	
					document.getElementById("isedit").value="false";
					var page = contextPath + "/portal/user/superusertreelist.action?domain=<%=request.getParameter("domain")%>&departid="+node.attr("id")+"&_orderby=orderByNo&_orderby=id";
			      	jQuery("#userFrame").attr("src", page);
		          	selectedNode = node.attr("id");
				}
			}
		});
	}

	/*contentTable高度自适应，兼容ie/ff*/
	function autoHeight()
	{
		var bodyHeight=document.body.scrollHeight+"px";
		jQuery("#userFrame").parent("div").css("height",bodyHeight);
		
		jQuery(window).resize(function(){
			bodyHeight=document.body.scrollHeight+"px";
			jQuery("#userFrame").parent("div").css("height",bodyHeight);				
		});
	}
</script>
</head>
<body>
<div class="ui-layout-west" style="overflow: auto;"><div id="tree" style="padding: 5px;"></div></div>
<div class="ui-layout-center">
	<div id="main" style="border-top:0px">
	 	<iframe width="100%" height="100%" src="<s:url value='/portal/user/superusertreelist.action'><s:param name="domain" value="%{#parameters.domain}" ></s:param><s:param name="_orderby" value="orderByNo" ></s:param><s:param name="_orderby" value="id" ></s:param></s:url>";
				id="userFrame" frameborder="0" name="userFrame" /></iframe>
				
	</div>
</div>
<s:hidden id="isclick" value="false"></s:hidden>
<s:hidden id="selectnode" value=""></s:hidden>	
<s:hidden id="name" value=""></s:hidden>
<s:hidden id="loginno" value=""></s:hidden>
<s:hidden id="roleid" value=""></s:hidden>
<s:hidden id="isedit" value="false"></s:hidden>	
</body>
</o:MultiLanguage></html>
