<%@page import="cn.myapps.util.Security"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.user.ejb.UserVO"%>
<%@page import="java.util.Date"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="cn.myapps.core.user.ejb.UserProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.work.action.WorkHtmlUtil"%>
<%
	String skinType = (String)request.getSession().getAttribute("SKINTYPE");
	WebUser webUser = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	
	UserProcess userProcess = (UserProcess)ProcessFactory.createProcess(UserProcess.class);
	
	
	String action = request.getParameter("action");
	
	if("save".equals(action)){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String img = request.getParameter("img");
		String desc = request.getParameter("desc");
		
		JSONArray signs = StringUtil.isBlank(webUser.getSigns())? new JSONArray() : JSONArray.fromObject(webUser.getSigns());
		
		JSONObject sign = new JSONObject();
		sign.put("id", id);
		sign.put("name", name);
		sign.put("password", Security.encryptPassword(password));
		sign.put("img", img);
		sign.put("desc", desc);
		sign.put("date", df.format(new Date()));
		
		signs.add(sign);
		
		
		UserVO user = (UserVO)userProcess.doView(webUser.getId());
		user.setSigns(signs.toString());
		webUser.setSigns(signs.toString());
		userProcess.doUpdate(user);
		request.getSession().setAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER, webUser);
	}
	
	if("remove".equals(action)){
		String[] _selects = request.getParameterValues("_selects");
		JSONArray signs = StringUtil.isBlank(webUser.getSigns())? new JSONArray() : JSONArray.fromObject(webUser.getSigns());
		
		for(int i=0;i<_selects.length;i++){
			String id = _selects[i];
			for(Iterator it = signs.iterator();it.hasNext();){
				JSONObject sign = (JSONObject)it.next();
				if(id.equals(sign.getString("id"))){
					signs.remove(sign);
					break;
				}
			}
		}
		
		UserVO user = (UserVO)userProcess.doView(webUser.getId());
		user.setSigns(signs.toString());
		webUser.setSigns(signs.toString());
		userProcess.doUpdate(user);
		request.getSession().setAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER, webUser);
		
	}
	
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[印章管理]*}</title>
<!-- 兼容ie6半透明 -->
<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
<!-- 滚动条 -->
<script src='<s:url value='/portal/share/script/jquery.slimscroll.min.js' />'></script>	
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var skinType='<%=skinType%>';
</script>

<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css">
<style>
#contentTable {overflow-y:auto; overflow-x:hidden;}
body{margin:4px;padding:2px;}
</style>
</head>
<body style="overflow: hidden;" class="body-front">
<s:form name="formList" method="post" theme="simple" action="">
<input type="hidden" name="action" value="save">
<input type="hidden" name="id" value="">
<input type="hidden" name="name" value="">
<input type="hidden" name="password" value="">
<input type="hidden" name="img" value="">
<input type="hidden" name="desc" value="">
<div id="container">
<div style="margin-bottom:10px;overflow:hidden;">
	<table width="100%;">
		<tr width="100%;">
			<td>
				<div id="activityTable" class="activityTable" style="width:200px;">
					<a href="###" class="sett-form-control-inline btn-primary" onclick="doNew()">{*[New]*}</a>
					<a href="###" class="sett-form-control-inline btn-danger" name='button_act' title='{*[Delete]*}' onclick="doRemove()">{*[Delete]*}</a>
				</div>
			</td>
			<td style="text-align:right;" align= "right ">
			</td>
		</tr>
	</table>
</div>
<div style="border:1px solid #f5f5f5;border-radius:4px;-moz-border-radius: 4px; -webkit-border-radius: 4px;">
 <div id="contentTable" class="contentTable">
	<table class="table_noborder" style="width:100%"  cellspacing="0" cellpadding="0">
	<thead>
		<tr class="dtable-header list-header" style="background:#f3f3f3;">
			<td class="column-head-fresh" width="20px"><input type="checkbox" onclick="selectAll(this.checked)"></td>
			<td class="column-head-fresh" width="50px">{*[印章]*}</td>
			<td class="column-head-fresh" width="150px">{*[名称]*}</td>
			<td class="column-head-fresh" width="80px">{*[创建日期]*}</td>
			<td class="column-head-fresh" width="">{*[备注]*}</td>
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
	</table>
</div>	
</div>
</s:form>
<script type="text/javascript">
	var WebUser = {
		id:'<%=webUser.getId()%>',
		name:'<%=webUser.getName()%>',
		loginNo:'<%=webUser.getLoginno()%>',
		signs:<%=(webUser.getSigns()!=null && webUser.getSigns().trim().length()>0? webUser.getSigns():"[]")%>,
		domainId:'<%=webUser.getDomainid()%>'
	};
	$(document).ready(function(){
		initList();
		
		
	});
	
	function initList(){
		var signs = WebUser.signs;
		var tbody = $("#tbody");
		$.each(signs,function(i,sign){
			$('<tr class="table-tr" onmouseover="this.className=\'table-tr-onchange\';" onmouseout="this.className=\'table-tr\';"><td ><input type="checkbox" name="_selects" value="'+sign.id+'"></td><td><img width="49px;" src="'+contextPath+'/uploads/signs/'+sign.img+'"></img></td><td >'+sign.name+'</td><td >'+sign.date+'</td><td >'+sign.desc+'</td></tr>').appendTo(tbody);
		});
	}
	
	function doNew(){
		var url = contextPath
		+ '/portal/share/component/sign/new.jsp';
		var icons;
		var _path;
		if(skinType == "H5"){
			icons = "icons_1";
			_path = "../H5/resource/component/artDialog"
		}else{
			icons = "";
			_path = "";
		}
		OBPM.dialog.show({
		width : 450,
		height : 350,
		url : url,
		icon:icons,
		path: _path,
		args : {
		},
		title : '新建印章',
		close : function(result) {
			var rtn = result;
			if (rtn) {
				$("input[name='action']").val("save");
				$("input[name='id']").val(rtn.id);
				$("input[name='name']").val(rtn.name);
				$("input[name='password']").val(rtn.password);
				$("input[name='img']").val(rtn.img);
				$("input[name='desc']").val(rtn.desc);
				document.forms[0].submit();
			}
		}
		});
	}
	
	function doRemove(){
		$("input[name='action']").val("remove");
		document.forms[0].submit();
	}

</script>
</body>
</o:MultiLanguage></html>
