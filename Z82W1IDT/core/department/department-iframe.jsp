<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%>
<%@ page import="java.lang.reflect.Method"%>
<%
	String contextPath = request.getContextPath().equals("/")? "":request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_USER);
	//request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%><html>
<o:MultiLanguage>
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper"	id="mh" /> 
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#parameters.domain" />
</s:bean>
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />

<head>
<title>{*[cn.myapps.core.domain.userEdit.user_information]*}</title>
	
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/script/jstree/themes/default/style.min.css'/>" type="text/css" />
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />

<script src='<s:url value="/script/jquery-ui/js/jquery-1.8.3.js"/>'></script>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="../user/dtree-user.js"/>'></script>
<script src='<s:url value="/script/dtree/contextmenu.js"/>'></script>
<script src='<s:url value="/script/jstree/jstree.min.js"/>' ></script>
<script>
	var contextPath='<%=contextPath%>';
</script>
<script>
var departmentRemindedInformation = '{*[cn.myapps.core.domain.userEdit.tips.please_select_department]*}';
var def = "({*[Default]*})";
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';
var depttree;
var _departmentids = [];
var _departmentNames = [];

<s:iterator value="#userUtil.getDepartmentids(content.id)">
	var id ='<s:property />';
	_departmentids.push(id);
</s:iterator> 

function selectDepartment(){
	var deps = document.getElementsByName("_deptSelectItem");
  	var openedId;
  	<s:iterator value="#userUtil.getDepartmentOpenList(content.id)">
		openedId ='<s:property />';
	  	if (deps != null ) {
		  	for (var i=0; i<deps.length; i++) {
		    	if(openedId==deps[i].value){
		       		d.openTo(openedId);
				}
			}
		}
	</s:iterator>
  	var id;
	<s:iterator value="#userUtil.getDepartmentids(content.id)">
		id ='<s:property />';
	  	if (deps != null ) {
		  	for (var i=0; i<deps.length; i++) {
		    	if(id==deps[i].value){
		        	deps[i].click();
				}
			}
		}
	</s:iterator> 
}

function treeload() {
	depttree = jQuery("#deplist").jstree({
		'core' : {
			"check_callback" : false,
	        'data' : {
	            'url' : contextPath + '/core/department/getDepartmentTreeByParent.action?domain=<%=request.getParameter("domain")%>',
	            'data' : function (node) {
	            	var params = {};
					if (node.parent) {
						params['parentid'] = node.id; // 上级部门ID
						params['_departmentids'] = _departmentids.join(";");
					}
					return params;
	            }
	        }
		},
		 "checkbox" : {
		      "keep_selected_style" : false,
		      "cascade": '',
		      "tie_selection" : true,
		      "three_state" :false
		},
		
		"plugins" : [ "checkbox" ]
    }).bind("check_node.jstree",function(e,data){
    	if(_departmentids.join('').indexOf(data.node.id)==-1){
    		_departmentids.push(data.node.id);
    		_departmentNames.push(data.node.text);
    	}
    	
    }).bind("uncheck_node.jstree",function(e,data){
    	
		for(var i=0;i<_departmentids.length;i++){
    		if(_departmentids[i]==data.node.id){
    			_departmentids.splice(i, 1); 
    			_departmentNames.splice(i, 1);  
    		}
    	}
    }).bind("select_node.jstree",function(e,data){
    	if(_departmentids.join('').indexOf(data.node.id)==-1){
    		_departmentids.push(data.node.id);
    		_departmentNames.push(data.node.text);
    	}
    }).bind("deselect_node.jstree",function(e,data){
    	for(var i=0;i<_departmentids.length;i++){
    		if(_departmentids[i]==data.node.id){
    			_departmentids.splice(i, 1);
    			_departmentNames.splice(i, 1);  
    		}
    	}
    }).bind("load_node.jstree",function(e,data){
    	if(data.status){
    		setTimeout(function(){
    			var defaultDepartment = document.getElementById("content.defaultDepartment").value;
        		var dn = jQuery("#"+defaultDepartment+"_anchor");
        		if(dn.length>0){
        			jQuery('.def_dep').remove();
        			jQuery("#"+defaultDepartment+"_anchor").append(jQuery('<span class="def_dep" style="color: green;">(默认部门)</span>'));
        		}
    		},1000);
    	}
    });	
}


jQuery(document).ready(function(){
	treeload();
	
	$("#departmentBtn").click(function(){
		var departments = [];
		for(var i=0;i < _departmentids.length;i++){
			var dept = {"id":_departmentids[i],"name":_departmentNames[i]};
			departments.push(dept);
		};
		parent.OBPM.dialog.doReturn(departments);
	})
});

</script>
<style>
.jstree-default.jstree-checkbox-selection .jstree-clicked .jstree-checkbox, 
.jstree-default .jstree-checked .jstree-checkbox {
    background-position: -228px -4px;
}
#contentMainDiv{
	height:320px;
	overflow:auto;
}
#departmentList {
    text-align: center;
    border-top: 1px solid #999;
    padding: 10px;
    margin-top:10px;
}
#departmentList #departmentBtn{
    padding: 5px 10px;
}
</style>
</head>
<body>

<s:hidden cssClass="input-cmd" theme="simple" name="content.defaultDepartment" id="content.defaultDepartment"/>	
<div id="contentMainDiv" class="contentMainDiv">	
<table cellpadding="0" cellspacing="0" style="vertical-align: top;">
	<tr>
		<td>
			<div id="deplist" class="commFont"></div>
		</td>
	</tr>
</table>
</div>
<div id="departmentList">
	<input type="button" id="departmentBtn" value="确认" />
</div>
</body>
</o:MultiLanguage>
</html>