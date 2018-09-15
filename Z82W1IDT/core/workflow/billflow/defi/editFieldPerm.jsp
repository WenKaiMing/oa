<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.FormProcessBean"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.FormField"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.TabField"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.Activity" %>
	
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
WebUser user = (WebUser)session.getAttribute("USER");
String formid = request.getParameter("formid");
String formname = "";
FormProcessBean formProxy = new FormProcessBean();
Collection colls = new ArrayList();
Form form = (Form)formProxy.doView(formid);
Set<Activity> activity_Set = new TreeSet<Activity>();
if (form != null) {
	colls = form.getAllFields();
	formname = form.getName();
	activity_Set = form.getActivitys();
}
Iterator iters = colls.iterator();
Iterator tmp = colls.iterator();
Iterator activity_iters = activity_Set.iterator();
%>


<%@page import="cn.myapps.core.dynaform.form.ejb.CalctextField"%><html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[Edit FieldPerm]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<style type="text/css">
<!--
td {
	font-size: 12px;
	white-space:nowrap;
}
-->
</style>
<script src='<s:url value="/script/util.js" />'></script>
<script language="JavaScript">
function getFieldPermList(){
    var fieldPermList = "";
	jQuery("input[radioType='fieldPermList']").each(function(){
		if(jQuery(this).attr("checked")){
			var obj = jQuery(this).val();
			if(obj.indexOf("@")==0 || obj.indexOf("$")==0){
				fieldPermList += obj + ";";
			}
		}
	});
	return fieldPermList;
}

//获取操作按钮集合
function getActivityPermList(){
	
	var activityPermList ="";
	jQuery("input[radioType='activityPermList']").each(function(){
		if(jQuery(this).attr("checked")){
			var permission = jQuery(this).val();
			if("hide" == permission){
		      var id = jQuery(this).attr("id");	
		      id = id.substring(6,id.length);
			  activityPermList += "{'id':'" + id + "','permission':'"+permission+"'},";
			}
		}
	});
	activityPermList = activityPermList.substring(0, activityPermList.length-1);
    return activityPermList;
	
}

function setFieldPermList(formid){
	var fieldPermList = '';
	
	if (!parent || !parent.document.getElementById("fieldPermList")) {
		return;
	}
	
	var listStr = parent.document.getElementById("fieldPermList").value;
	if (listStr) {
		try {
			var list = eval("("+listStr+")");
			for (var i=0; i<list.length; i++) {
				if(list[i].formid == formid) {
					fieldPermList = list[i].fieldPermList;
				}
			}
		} catch(ex) {
		}
	}
  	
  	var hdchecked, rdchecked;
	var fieldPermListArray = fieldPermList.split(";");
	for(var i=0;i<fieldPermListArray.length; i++){
		var name = fieldPermListArray[i].substring(1,(fieldPermListArray[i].length));
		jQuery("input[name=" + name + "]").each(function(){
			if(jQuery(this).val() == fieldPermListArray[i]){
				jQuery(this).attr("checked",true);
			}
		});
	} 
}

//设置操作按钮集合
function setActivityPermList(formid){
	var activityPermList = '';
		//父级菜单必须放置按钮操作集合 （父窗口）
	 	if (!parent || !parent.document.getElementById("activityPermList")) {
			return;
		}
	 	var activityListStr = parent.document.getElementById("activityPermList").value;
	    if (activityListStr) {
	 		try {
				var activityList = eval("("+activityListStr+")");
				
				for (var i=0; i<activityList.length; i++) {
					if(activityList[i].formid == formid) {
						activityPermList = activityList[i].activityPermList;
					}
				}
			} catch(ex) {
			}
		}
		
		if(activityPermList){
			try {
				var _activityList = activityPermList;
				
				//遍历获取到相应formId的按钮集合
				for (var i=0; i<_activityList.length; i++) {
					    var activityId = _activityList[i].id;
						if("hide" == _activityList[i].permission){
							jQuery("input[id=btn_hd" + activityId + "]").attr("checked",true);
						}else{
							jQuery("input[id=btn_wt" + activityId + "]").attr("checked",true);
						}
				}
			} catch(ex) {
			}
		}
}


function doCheck(id,tp){
	var rd = document.getElementById('rd'+id);
	var wt = document.getElementById('wt'+id);
	var hd = document.getElementById('hd'+id);
	var tmp = document.getElementsByName("tmp")[0];

	if (tp){
		tmp.allrd.checked = false;
		tmp.allwt.checked = false;
		tmp.allhd.checked = false;
	}
}

function doBtnCheck(id,tp){
	var wt = document.getElementById('btn_wt'+id);
	var hd = document.getElementById('btn_hd'+id);
	var tmp = document.getElementsByName("tmp")[0];

	if (tp){
		tmp.all_btn_wt.checked = false;
		tmp.all_btn_hd.checked = false;
	}
}

function selectAll(a,b){
	jQuery("." + a).each(function(){
		jQuery(this).attr("checked",b);
	});
	if(a == 'rd'){
		tmp.allhd.checked = false;
	    tmp.allwt.checked = false;		
	}else if(a == 'wt'){
		tmp.allhd.checked = false;
	    tmp.allrd.checked = false;	
	}else if(a == 'hd'){
		tmp.allrd.checked = false;
	    tmp.allwt.checked = false;	
	}
}

function selectBtnAll(a,b){
	jQuery("." + a).each(function(){
		jQuery(this).attr("checked",b);
	});
	if(a == 'btn_wt'){
		tmp.all_btn_hd.checked = false;
	}else if(a == 'btn_hd'){
		tmp.all_btn_wt.checked = false;
	}
}
</script>
</head>

<body>
<form name="tmp" id="temp">
<input type="hidden" name="formname" value="<%=formname%>"/>
<input type="hidden" name="formid" value="<%=formid%>"/>
<table width="100%" cellspacing="0">
    <tr>
      <td width="100%" valign="top">
			<table width="100%" cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd">
			  <tr bgcolor="#FFFFFF">
			    <td class="commFont" width="10%">{*[Field]*}:</td>
			    <td align="left" valign="top">
			     <table width="100%">
			       <tr>
			         <td width="10%" align="left">&nbsp;</td>
			         <td width="10%" class="commFont">
			         	<input type="checkbox" name="allrd" onclick="selectAll('rd',this.checked)">
			         	{*[all]*}
			         </td>
			         <td width="10%" class="commFont">
			         	<input type="checkbox" name="allwt" onclick="selectAll('wt',this.checked)">
			         	{*[all]*}
			         </td>
			         <td width="70%" class="commFont">
			         	<input type="checkbox" name="allhd" onclick="selectAll('hd',this.checked)">
			         	{*[all]*}
			         </td>
			       </tr>
			<%
			   int id = 0;
			   while(iters.hasNext()){
			   		FormField ff = (FormField)iters.next();
			   		if(!(ff instanceof TabField) && !(ff instanceof CalctextField)){
			   			id++; 
			
			%>
					<tr>
					  <td><%=ff.getName()%>:</td>
			    	  <td><input type="radio" radioType ="fieldPermList" name="<%=ff.getName()%>" class="rd" value="@<%=ff.getName()%>" id="rd<%=id%>" onclick='doCheck("<%=id%>","rd")'>{*[Read-only]*}</td>
			    	  <td><input type="radio" radioType ="fieldPermList" name="<%=ff.getName()%>" class="wt" value="#<%=ff.getName()%>" id='wt<%=id%>' onclick='doCheck("<%=id%>","wt")' checked=true>{*[Modify]*}</td>
			    	  <td><input type="radio" radioType ="fieldPermList" name="<%=ff.getName()%>" class="hd" value="$<%=ff.getName()%>" id='hd<%=id%>' onclick='doCheck("<%=id%>","hd")'>{*[Hidden]*}</td>
			    	</tr>
			<%
						}
			   }
			%>
			    	</table>
			    </td>
			  </tr>  
			  <tr bgcolor="#FFFFFF">
			  <!-- 操作表单字段 -->
			    <td class="commFont" width="10%">操作按钮:</td>
			    <td align="left" valign="top">
			     <table width="100%">
			      <tr>
			         <td width="10%" align="left">&nbsp;</td>
			         <td width="10%" class="commFont">
			         	<input type="checkbox" name="all_btn_wt" onclick="selectBtnAll('btn_wt',this.checked)">
			         	{*[all]*}
			         </td>
			         <td width="70%" class="commFont">
			         	<input type="checkbox" name="all_btn_hd" onclick="selectBtnAll('btn_hd',this.checked)">
			         	{*[all]*}
			         </td>
			       </tr>
			<%
			    id = 0;
			   while(activity_iters.hasNext()){
				    int btn_id = 0;
			   		Activity act =(Activity)activity_iters.next();
			   		btn_id++; 
			%>
					<tr>
					  <td><%=act.getName()%>:</td>
			    	  <td><input type="radio" radioType ="activityPermList" name="<%=act.getName()%>" class="btn_wt" value="show" id="btn_wt<%=act.getId()%>" checked="checked" onclick='doBtnCheck("<%=act.getId()%>","rd")'>显示</td>
			    	  <td><input type="radio" radioType ="activityPermList" name="<%=act.getName()%>" class="btn_hd" value="hide" id="btn_hd<%=act.getId()%>" onclick='doBtnCheck("<%=act.getId()%>","hd")'>隐藏</td>
			    	</tr>
			<%
			   }
			%>
			    	</table>
			    </td>
			  </tr>  
			</table>
      </td>
    </tr>
 </table>
</form>
</body>
<script language="JavaScript">
	
    var formid = document.getElementsByName("formid")[0];
    if (formid) {
    	setFieldPermList(formid.value);
    	setActivityPermList(formid.value);
    }
</script>
</o:MultiLanguage>
</html>


