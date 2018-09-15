<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.Activity"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.macro.runner.IRunner"%>
<%@ page import="cn.myapps.core.macro.runner.JavaScriptFactory"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.type.*"%>
<%@ page import="cn.myapps.core.user.action.*"%>
<%@ page import="cn.myapps.core.role.ejb.*"%>
<%@ page import="cn.myapps.core.permission.ejb.*"%>
<%@ page import="cn.myapps.core.privilege.res.ejb.*"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.dynaform.view.action.ViewHelper"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%
	String viewid = request.getParameter("_viewid");
	String styleid = ViewHelper.get_Styleid(viewid);
	String parentid = request.getParameter("parentid") != null? request.getParameter("parentid") :"";
	String isRelate = request.getParameter("isRelate") != null? request.getParameter("isRelate") : "";
	String isedit = request.getParameter("isedit") != null? request.getParameter("isedit") : "";
	String innerType = request.getParameter("innerType");
	View view = (View) request.getAttribute("content");
	String applicationid=(String)view.getApplicationid();
	boolean isReadOnly=view.getReadonly().booleanValue();
	String viewname = view.getDescription();
	
	Map<String, Column> columnMapFields = view.getViewTypeImpl().getColumnMapping();
	String nodeNameField = ((Column) columnMapFields.get(TreeType.DEFAULT_KEY_FIELDS[2])).getFieldName();// 树节点名称
	
	if (viewname==null || viewname.trim().length()<=0)
		viewname = view.getName();
	//String newActid="";
	//String delActid="";
	Activity newAct = null;
	Activity delAct = null;
	Document parent = (Document) request.getAttribute("parent");
	Document tdoc = parent != null ? parent : new Document();
	IRunner runner = JavaScriptFactory.getInstance(
			request.getSession().getId(), view.getApplicationid());
	runner.initBSFManager(tdoc, ParamsTable.convertHTTP(request), 
			(WebUser)request.getSession().getAttribute("FRONT_USER"),
			new ArrayList<ValidateMessage>());
	Iterator<Activity> aiter = view.getActivitys().iterator();
	while (aiter.hasNext()) {
		Activity act = (Activity) aiter.next();
		if(act.getType()==2){
			newAct = act;
			//newActid=act.getId();
		}else if(act.getType()==3){
			delAct = act;
			//delActid=act.getId();
		}
	}
	if(newAct == null){
		newAct = new Activity();
	}
	if(delAct == null){
		delAct = new Activity();
	}
	boolean newAct_IsReadOnly = newAct.isReadonly(runner, view.getFullName());
	boolean newAct_IsHidden = newAct.isHidden(runner, view, tdoc);
	boolean delAct_IsReadOnly = delAct.isReadonly(runner, view.getFullName());
	boolean delAct_IsHidden = delAct.isHidden(runner, view, tdoc);
	
	//获得角色列表
	Collection<RoleVO> rolelist = ((WebUser) request.getSession().getAttribute("FRONT_USER")).getRolesByApplication(view.getApplicationid());
	PermissionProcess permissionProcess = (PermissionProcess) ProcessFactory.createProcess(PermissionProcess.class);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/share/common/js_baseH5.jsp"%>
<%@ include file="/portal/share/common/js_componentH5.jsp"%>
<!-- 
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
 -->
<!-- bootstrap引入 -->
<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/bootstrap-datetimepicker.min.css'/>" />
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap.min.js'/>"></script> 
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.min.js'/>"></script> 
<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.zh-CN.js'/>"></script> 
	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/myapp.css'/>" type="text/css" />
	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/view.css'/>" type="text/css" />
	
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<!-- 树形插件 -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<!-- 布局插件 -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>

<s:url id="backURL" action="displayView" >
	<s:param name="_viewid" value="#parameters._viewid" />
	<s:param name="isinner" value="true"/>
	<s:param name="parentid" value="#parameters.parentid" />
	<s:param name="_currpage" value="datas.pageNo"/>
</s:url>
<script type="text/javascript">
	var openNode = ['root'];//记录展开节点
	var treeview = jQuery("#tree").jstree();
	var selectedNode = ""; // 已选中的节点
	var root = "<%=viewname%>";
	var selectNodeClick = false; //检测是否有鼠标点击节点
	var applicationid = '<%=applicationid%>';
	//树形视图菜单项map
	var map = {
				create : {
					label	: "{*[Create]*}", 
					action	: function (node) { 
						var url = contextPath + "/portal/dynaform/activity/action.action?_viewid="+node.attr("viewid")+
						"&treedocid="+node.attr("name")+"&_activityid=<%=newAct.getId()%>&node=" + (node.attr('curr_node')==undefined ? '' : node.attr('curr_node')) + 
						"&super_node_fieldName=" + (node.attr('super_node_fieldName')==undefined ? '' : node.attr('super_node_fieldName'));
						url+="&_backURL=" + encodeURIComponent(contextPath + "/portal/dynaform/view/displayView.action?_viewid="+node.attr("viewid")+"&isinner=true")+"&application=<%=applicationid%>";
						jQuery("#viewFrame").attr("src", url);
					},
					separator_before : true,
					<%if("false".equals(isedit))  
						{
					%>
					_disabled : true
					<%}else {%>
					_disabled : false
					<%}%>
				},
				remove : {
					label	: "{*[Delete]*}", 
					action	: function (node, jstree) {
						if(node.find("li").size()>0){
							alert("存在子节点，无法删除！");
						}else if(node && node.length > 0 && node[0].id == "root"){
							alert("根节点不能删除！");
						}else{
							var url = contextPath + "/portal/dynaform/activity/action.action?_viewid="+node.attr("viewid")+"&_selects="+node.attr("id")+"&content.id="+node.attr("id")+"&operation=doDelete&treedocid="+node.attr("name")+"&_activityid=<%=delAct.getId()%>";
							url+="&_backURL=" + encodeURIComponent(contextPath + "/portal/dynaform/view/displayView.action?_viewid="+node.attr("viewid")+"&isinner=true")+"&application=<%=applicationid%>";
							window.location.href=url;
						}
					},
					separator_before : true,
					<%if("false".equals(isedit))  
					{
					%>
					_disabled : true
					<%}else {%>
					_disabled : false
					<%}%>
				},
				rename : false,
				ccp    : false
				//显示信息与点击链接相同，所以两个菜单都隐藏
				/**,
				doDocView : {
					label	: "{*[Node]*}{*[Info]*}", 
					icon	: "", 
					visible	: function (NODE, TREE_OBJ) { 
						if(NODE.length != 1) return 0; 
						if(TREE_OBJ.get_text(NODE) == "Child node 1") return -1; 
						return 1; 
					}, 
					action	: function (node, jstree) { 
						var nodeid=node.attr("id");
						var params = "";
						// 必须的参数
						params += "?_viewid="+node.attr("viewid") + "&treedocid=" + nodeid + "&parentNodeId="+ nodeid +"&isinner=true";
						params += "&_docid=" + nodeid + "&_backURL=" + encodeURIComponent(contextPath + 
								"/portal/dynaform/view/displayView.action?_viewid="+node.attr("viewid")+"&isinner=true");
            
						// 打开表单时需要的参数
						if (node.attr("formid")) { // 添加表单ID参数
						
							params += "&_formid="+ node.attr("formid"); 
					
						}
					
						var page = contextPath + "/portal/dynaform/view/innerPage.action"+params+"&innerType=FORM&application=<%=applicationid%>";
						jQuery("#viewFrame").attr("src", page);
					},
					separator_before : true
				},
				doSubView : {
					label	: "{*[Node]*}{*[Sub_Node_Help]*}", 
					icon	: "", 
					visible	: function (NODE, TREE_OBJ) { 
						if(NODE.length != 1) return 0; 
						if(TREE_OBJ.get_text(NODE) == "Child node 1") return -1; 
						return 1; 
					}, 
					action	: function (node, jstree) { 
						var nodeid=node.attr("id");
						var params = "";
						// 必须的参数
						params += "?_viewid="+node.attr("viewid") + "&treedocid=" + nodeid + "&parentNodeId="+ nodeid +"&isinner=true"+"&parentid=<%=parentid%>&isRelate=<%=isRelate%>";
						params += "&_docid=" + nodeid + "&_backURL=" + encodeURIComponent(contextPath + "/portal/dynaform/view/displayView.action?_viewid="+node.attr("viewid")+"&isinner=true");
						var page = contextPath + "/portal/dynaform/view/innerPage.action"+params+"innerType=VIEW&application=<%=applicationid%>";
						// 打开表单时需要的参数
						if (node.attr("formid")) { // 添加表单ID参数
							page += "&_formid="+ node.attr("formid"); 
						}
						jQuery("#viewFrame").attr("src", page); 
					},
					separator_before : true
				}
				**/
			};
	//初始化后台定制的创建按钮的权限
	//如果没有定制,则不显示
	//如果有定制并且设置为只读,则设为只读
	//如果有定制并且设置为隐藏,则不显示
	function initNewItem(){
		if("<%=newAct.getId()%>" == "null"){
			map['create'] = null;
		} else {
			if("<%=newAct_IsReadOnly%>" == "true" || "<%=newAct_IsReadOnly%>" == true) {
				map['create']['_disabled'] = true;
			}
			if("<%=newAct_IsHidden%>" == "true" || "<%=newAct_IsHidden%>" == true) {
				map['create'] = null;
			}
		}
		console.dir(map);
	}

	//初始化后台定制的删除按钮的权限
	//如果没有定制,则不显示
	//如果有定制并且设置为只读,则设为只读
	//如果有定制并且设置为隐藏,则不显示
	function initDelItem(){
		if("<%=delAct.getId()%>" == "null"){
			map['remove'] = null;
		} else {
			if("<%=delAct_IsReadOnly%>" == "true" || "<%=delAct_IsReadOnly%>" == true) {
				map['remove']['_disabled'] = true;
			}
			if("<%=delAct_IsHidden%>" == "true" || "<%=delAct_IsHidden%>" == true) {
				map['remove'] = null;
			}
		}
	}

	function getAllSelects() {
		var temp = [];
		var rtn = "";
		var menu = treeview.jstree("get_checked");
		if (menu) {
			for(i=0;i<menu.size();i++){
				if(menu[i] && menu[i].id){
					temp.push(menu[i].id);
				}
			}
			if (temp.length > 0) {
				rtn = temp.join(";");
			}
		}
		
		return rtn;
	}
	
	/**
	 * 更新主页中菜单中的视图数据总数
	 */
	function refreshCountInMenu(){
		var atrr=jQuery("#resourceid").val();
		var resourceid=atrr.split(",")[0];
		var viewid=jQuery("#viewid").val();
		if(resourceid!=null && resourceid!=''){
			if(typeof(window.parent.reflashTotalRow) == "function")
				window.parent.reflashTotalRow(resourceid,viewid);
		}
	};
	
	/**
	 * 树形视图初始化
	 */
	function treeInit(){

		var params = {
			"treedocid":"root",
			"_viewid":jQuery("#viewid").val()
		}
		
		$.ajax({
			url: contextPath + "/portal/dynaform/view/getChildren.action?datetime=" + new Date().getTime()+"&parentid=<%=parentid%>&isRelate=<%=isRelate%>",
			data:params,
			async: false,
    		cache:false,
			success : function(data){
				if(data.length > 0){
					treeview = jQuery("#tree").jstree({ 
						core:{
							initially_open: openNode,
							animation: 100
						},
						// JSON数据插件
						"json_data" : {
							"data" : data,
							"ajax" : { 
								"url" : function (){
											return contextPath + "/portal/dynaform/view/getChildren.action?datetime=" + new Date().getTime()+"&parentid=<%=parentid%>&isRelate=<%=isRelate%>";
										},
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
						"checkbox" : {
							cascade: true
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
									//var key = jQuery("#text").attr("name");
									//params[key] =  jQuery("#text").val(); // 表单字段值
									
									return params;
								}
							}
						},
						"contextmenu" : { 
							items : map
						},
						
						
						"plugins" : [ "themes", "json_data", "types", "ui" , "search", "adv_search", "contextmenu"]
					}).bind("select_node.jstree", function(e, data){
						var node = data.rslt.obj;
						var params = "";
						if (node && node.attr) {
							var nodeid = node.attr("id");
							if (selectedNode != nodeid || (selectedNode == nodeid && selectNodeClick == true)) {//增加检测是否由点击节点进入该方法
								selectNodeClick = false;
								// 必须的参数
								if(window.parent.document.getElementById("isedit")){
									var isedit = window.parent.document.getElementById("isedit").value;
									if(isedit != null && isedit == ""){
										isedit = '<%=isedit%>';
									}
								}else{
									isedit = '<%=isedit%>';
								}
								params += "?application=<%=applicationid%>&_viewid="+node.attr("viewid") + "&treedocid=" + nodeid + "&parentNodeId="+ nodeid +"&isinner=true"+"&parentid=<%=parentid%>&isRelate=<%=isRelate%>&isedit="+isedit;
								params += "&_docid=" + nodeid + "&_backURL=" + encodeURIComponent(contextPath + "/portal/dynaform/view/displayView.action?_viewid="+node.attr("viewid")+"&isinner=true"); 
								// 打开表单时需要的参数
								if (node.attr("formid")) { // 添加表单ID参数
									params += "&_formid="+ node.attr("formid"); 
								}
								var page = contextPath + "/portal/dynaform/view/innerPage.action" + params;
								
								//后台设置视图的基本信息为只读时
								var isReadOnly='<%=isReadOnly%>';
								if(isReadOnly=="true"){
									//alert("{*[Tree]*}{*[View]*}{*[Reaonly]*}");
									page+="&innerType=VIEW";
								}
								
								jQuery("#viewFrame").attr("src", page);
								selectedNode = node.attr("id");
							}
						}
			        }).bind("open_node.jstree", function (event, data) {
			        	var id = data.rslt.obj[0].id;
			        	var index = openNode.indexOf(id)
			        	if(index < 0){
			        		openNode.push(id);
			        	}
			        }).bind("close_node.jstree", function (event, data) {
			        	var id = data.rslt.obj[0].id;
			        	var index = openNode.indexOf(id)
			        	if(index >= 0){
			        		openNode.splice(index,1);
			        	}
			        })

				}
			}
		});
		
		//更新主页中菜单中的视图数据总数
		refreshCountInMenu();
	}
	
	function treeload() {
		var params = {
			"treedocid":"root",
			"_viewid":jQuery("#viewid").val()
		}
		
		treeInit();
		
		//根节点iframe页面
		if(params._viewid && params._viewid != ""){
			var nodeid = params.treedocid;
			var viewid = params._viewid;
			var url = "";
			if (selectedNode != nodeid || (selectedNode == nodeid && selectNodeClick == true)) {//增加检测是否由点击节点进入该方法
				selectNodeClick = false;
				// 必须的参数
				if(window.parent.document.getElementById("isedit")){
					var isedit = window.parent.document.getElementById("isedit").value;
					if(isedit != null && isedit == ""){
						isedit = '<%=isedit%>';
					}
				}else{
					isedit = '<%=isedit%>';
				}
				url += "?application=<%=applicationid%>&_viewid="+viewid+ "&treedocid=" + nodeid + "&parentNodeId="+ nodeid +"&isinner=true"+"&parentid=<%=parentid%>&isRelate=<%=isRelate%>&isedit="+isedit;
				url += "&_docid=" + nodeid + "&_backURL=" + encodeURIComponent(contextPath + "/portal/dynaform/view/displayView.action?_viewid="+viewid+"&isinner=true"); 
				var page = contextPath + "/portal/dynaform/view/innerPage.action" + url;
				
				//后台设置视图的基本信息为只读时
				var isReadOnly='<%=isReadOnly%>';
				if(isReadOnly=="true"){
					page+="&innerType=VIEW";
				}
				
				jQuery("#viewFrame").attr("src", page);
				selectedNode = nodeid;
			}
		}

		// 注册查询事件
		jQuery("#search").unbind("click").bind("click", function () {
			jQuery("#tree").jstree("search", jQuery("#text").val());
		});
	}

	function doInTab(){
		if(jQuery(".ui-layout-center").css("display") == "none" || jQuery(".ui-layout-center").width() <= 10){
			jQuery(".ui-layout-west").css("display","block");
			jQuery(".ui-layout-center").css("display","block");
			if(window.parent && window.parent.document.body){
				var bodyW = window.parent.document.body.clientWidth;
				var bodyH = window.parent.document.body.clientHeight;
				jQuery(".ui-layout-west").width(bodyW*0.2);
				jQuery(".ui-layout-center").width(bodyW*0.79);
				jQuery("iframe",parent.document).css("height",700);
			}
		}
	}

	//包含元素包含视图时调整iframe高度
	function ev_resize4IncludeViewPar(){
		var divid = document.getElementsByName("divid")[0].value;
		var _viewid = document.getElementsByName("_viewid")[0].value;
		ev_resize4IncludeView(divid,_viewid,'TREEVIEW');
	}
	//左边树结构的高度,为了兼容ie11不出滚动条的问题
	function setTreeLeftHeight(){
		var treeHeight = $("#right .crm_right").height()-30;
		$("#treeLeft").height("100%");
		//$("#treeLeft").height(treeHeight);
	}
	jQuery(document).ready(function () {
		initNewItem();
		initDelItem();
		treeload();
		/**
		jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		**/
		
		setTreeLeftHeight();
		ev_resize4IncludeViewPar();
		
		$("form").on("submit",function(){
			jQuery("#tree").jstree("search", jQuery("#text").val());
			return false;
		})
		//监听iframe是否加载完
		var iframe = document.getElementById("viewFrame");
		if (iframe.attachEvent){ 
			iframe.attachEvent("onload", function(){ 
				treeInit();
			}); 
		} else { 
			iframe.onload = function(){ 
				treeInit();
			}; 
		} 
	});
	
</script>
<title>Tree View</title>
</head>
<body style="overflow: hidden;height:100%;" class="body-front">

<div id="right" style="height:100%;background:none">
    <div class="crm_right" style="height:95%;">
    	<table width="100%" style="height: 100%; "><tbody><tr><td style="width: 210px;/*overflow:auto;*/ height:100%; vertical-align: top;">
		<div id="treeLeft" class="treeViewContent" style="_margin-left:0px;overflow:auto;">
			<s:form name="treeForm" action="" theme="simple" cssClass="form-group" role="form">
				<s:hidden id="viewid" name="_viewid" />
				<s:hidden name="divid" value="%{#parameters.divid}" />
				<!-- 当前视图对应的菜单编号 -->
				<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
				<s:hidden id="innerType" name="content.innerType" />
				<s:hidden id="application" name="application" value="%{#content.application}"/>
	            <div id="treeViewSearchHeader" class="input-group">
	                <input type="text" id="text" class="form-control" placeholder="{*[cn.myapps.core.dynaform.view.search_value]*}" style="width:100px;height:25px;float:left;"/>
	                <span class="input-group-btn">
	                <button class="btn btn-myapp" type="button" id="search"></button>
	                </span>
	            </div>
			</s:form>
			<div id="treeViewContent">
			<div id="tree" class="treeview"></div>
			</div>
		</div>
		</td>
		<td style="height:100%;vertical-align: top;overflow:auto;">
		<div id="treeRight" class="treeRight" style="width:100%;height:100%;">
			<iframe src="" id="viewFrame" frameborder="0" name="viewFrame" style="width:100%; height:100%;border:0px;"></iframe>
		</div>
		</td></tr></tbody></table>
	</div>
</div>
</body>
</o:MultiLanguage>
</html>