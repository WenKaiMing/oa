<%@page import="cn.myapps.km.org.ejb.NUser"%>
<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ include file="/km/disk/head.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.role.ejb.RoleProcess"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.domain.ejb.DomainVO"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.role.ejb.RoleVO"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.domain.ejb.DomainVO"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
//String contextPath = request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);  
%>

<%
	StringBuffer applicationids = new StringBuffer();
	/* NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER); */
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domain = user.getDomainid();
	RoleProcess rp = (RoleProcess) ProcessFactory.createProcess(RoleProcess.class);
	// DomainVO vo = DomainHelper.getDomainVO(getUser());//获取不到企业域(Bluce)
	DomainVO vo = DomainHelper.getDomainVO(domain);
	Collection<ApplicationVO> apps = vo.getApplications();
	Collection<RoleVO> rtn = new LinkedHashSet<RoleVO>();
	for (Iterator<ApplicationVO> iterator = apps.iterator(); iterator
	.hasNext();) {
	ApplicationVO applicationVO = (ApplicationVO) iterator.next();
	applicationids.append("'" + applicationVO.getId() + "',");
	}
	if(applicationids.length()>0){
	applicationids.setLength(applicationids.length()-1);
	}
	rtn = rp.getRolesByapplicationids(applicationids.toString());
	request.setAttribute("rolelist", rtn);
	request.setAttribute("applicationlist", apps);
%>

<html><o:MultiLanguage>
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/dtreeOfRole.css" />' type="text/css">
<script src='<s:url value="/script/util.js"/>' ></script>
<!-- <script src='<s:url value="/script/dtree.js"/>' ></script> -->
<script src='<s:url value="/core/user/dtree-user.js"/>' ></script>
<script language="JavaScript">
var contextPath = '<s:url value="/" />';

function doReturn() {
  var sis = document.getElementsByName("_selectItem");
  var rtn = new Array();
  var p = 0;

  if (sis.length != null) {
	  for (var i=0; i<sis.length; i++) {
	    var e = sis[i];
	    if (e.type == 'checkbox') {
	      if (e.checked && e.value) {
	        rtn[p++] = e.value;
	      }
	    }
	  }
  }
  else {
    var e = sis;
    if (e.type == 'checkbox') {
      if (e.checked && e.value) {
        rtn[p++] = e.value;
      }
    }
  }
  
  OBPM.dialog.doReturn(rtn.toString());
}

function doExit() {
  OBPM.dialog.doReturn();
}


function doInit(){
	if(OBPM.dialog) {
		var oField = OBPM.dialog.getArgs()['oField'];
		if (oField.value){
			var sis = document.getElementsByName("_selectItem");
			var str = oField.value;
			str = str.substring(1, str.length - 1);
			
			var checkedArray = str.split(";");
			for (var i=0; i < checkedArray.size(); i++) {
				
		 		if (sis) {
			  		for (var j=0; j < sis.length; j++) {
			    		var e = sis[j];
			    		toggleCheck(e, checkedArray);
			 		}
		  		}
			}
	 		
		}
	}
}

//以 role.id相等 为回显条件 
function toggleCheck(oEl, checkedValues){
	if(oEl.value == ''){
		return;
	}
	oElArray = oEl.value.split("|");
	for (var i=0; i < checkedValues.size(); i++) {
		var str = checkedValues[i];
		var checkedValuesArray = str.split("|");
		if(oElArray[0] == checkedValuesArray[0]){
			oEl.checked = true;
			d.openTo(checkedValues[i]);
		}
	}
}


jQuery(document).ready(function(){
	doInit();
	cssListTable();
});

</script>
</head>
<body class="body-back">
<s:form name="formList" method="post" action="">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />

	<table border="0" cellpadding="4" cellspacing="0" width="100%">
		<tr>
			<td class="line-position2" width="50"  valign="top">
   				<button type="button" class="button-class" onClick="doReturn();">
   					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-class" onClick="OBPM.dialog.doReturn('');">
					<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-class" onClick="doExit()">
					<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Exit]*}</button>
			</td>

		</tr>

		<tr>
			<td colspan="3" class="list-srchbar"></td>
		</tr>
	</table>
	<div id="searchFormTable" class="justForHelp" title="{*[Search]*}{*[Role]*}" style="width: 98%">
		<table class="table_noborder">
			<tr>
			<td class="head-text">
				{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
				<input class="button-cmd" type="button" onclick="document.forms[0].submit();" value="{*[Query]*}" />
				<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
			</td></tr>
		</table>
	</div>
	<table border="0" cellpadding="0" cellspacing="1" width="100%">
				<s:bean name="cn.myapps.km.org.ejb.NRoleProcessBean" id="process" />
				<s:bean name = "cn.myapps.core.domain.action.DomainHelper" id = "domainHelper" />
				<tr class="row-hd">
					<td valign="top"><div class="dtree" style="height:100%;">
					<script type="text/javascript">
          				var contextPath = '<s:url value="/" />';
          				
          				/*
          				//注意传入生成checkbox的名称
						var d = new dTree('d','','_selectItem');
						d.config.multiSelect = true;
						//id, pid, name, url, title, target, icon, iconOpen, open, checked
						d.add('Roles',
								-1,
								'',
								'',
								'');
						
						<s:iterator value="#process.doGetRolesByName(#parameters['sm_name'])" id="role">
							<s:if test='#role.name != "企业文档管理员"'>
							d.add('<s:property />',
								'Roles',
								'{*[<s:property value="#role.name" />]*}',
								'javascript:selectOne(\'<s:property />;<s:property />\');',
								'<s:property value="#role.id" />|{*[<s:property value="#role.name" />]*}');
							</s:if>
						</s:iterator>
						document.write(d);
						*/
						
					//---------------------------------------------------
						var selArray = new Array();
						//var dt = new dTree('dt', 'rolelist','_roleSelectItem');
						var dt = new dTree('dt', 'rolelist','_selectItem')
						dt.config.multiSelect = true;

						//--定义一个默认根,名称为：角色选择--
						dt.add(
								'1001',
								-1,
								'{*[cn.myapps.core.domain.userEdit.user_role_select]*}',
								'javascript:selectOne(\'1001;{*[cn.myapps.core.domain.userEdit.user_role_select]*}\');',
								'1001',
								'',
								'<%=contextPath%>/resource/images/dtree/app.gif',
								'',
								'false',
								'',
						        '');
						
						//-----应用列表-----		
						<s:iterator value="#request.applicationlist">
								dt.add(
									'<s:property value="id" />',
									'1001',
									'<s:property value="name" />',
									'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
									'<s:property value="id" />',
									'',
									'<%=contextPath%>/resource/images/dtree/app.gif',
									'<%=contextPath%>/resource/images/dtree/app.gif',
									'',
									'',
									'',
									'<s:property value="activated" />');
								selArray[selArray.length] = {id:'<s:property value="id" />',activated:'<s:property value="activated" />'};
						</s:iterator>

						//--------应用下的角色列表--------
						<s:iterator value="#request.rolelist">
								dt.add(
									'<s:property value="id" />',
									'<s:property value="applicationid" />',
									'<s:property value="name" />',
									'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
									'<s:property value="id" />|{*[<s:property value="name" />]*}',
									'',
									'<%=contextPath%>/resource/images/dtree/role.gif',
									'<%=contextPath%>/resource/images/dtree/role.gif',
									'',
									'',
									'');
						</s:iterator>
						
													
						document.write(dt);

						function displayroles(tempValue){
							if(tempValue == 'all'){
								jQuery(".dTreeNode").css("display","block");
								dt.openAll();
								km_dt.openAll();
							}else if(tempValue == 'selected'){
								showCheckRoles();
								dt.openAll();
								km_dt.openAll();
							}
							setHideRole();//隐藏禁用软件的角色
						}

						function showCheckRoles(){
							jQuery(".dTreeNode").css("display","block");
							jQuery("input[name=_roleSelectItem]").each(function(i){
								if(jQuery(this).attr("checked") != 'checked'){
									jQuery(this).parent().css("display","none");
								}
							});

							//--------KM---------
							jQuery("input[name=_kmRoleSelectItem]").each(function(i){
								if(jQuery(this).attr("checked") != 'checked'){
									jQuery(this).parent().css("display","none");
								}
							});

							jQuery("a").each(function(i){
								jQuery(this).parent().css("display","block");
							});
						}
						
						function showSearchRoles(){
							dt.openAll();
							var textVal = document.getElementById("filterCondition").value;
							jQuery("input[name=_roleSelectItem]").each(function(i){
								var StrVal = jQuery(this).attr("text");
								if(StrVal.indexOf(textVal) == -1){
									jQuery(this).parent().css("display","none");
								}else{
									jQuery(this).parent().css("display","block");									
								}
							});

							//--------KM---------
							jQuery("input[name=_kmRoleSelectItem]").each(function(i){
								var StrVal = jQuery(this).attr("text");
								if(StrVal.indexOf(textVal) == -1){
									jQuery(this).parent().css("display","none");
								}else{
									jQuery(this).parent().css("display","block");									
								}
							});

							jQuery("a").each(function(i){
								jQuery(this).parent().css("display","block");
							});
							setHideRole();//隐藏禁用软件的角色
						}


						//--------KM---------
					
						//var km_dt = new dTree('km_dt', 'kmRoles','_kmRoleSelectItem');
						var km_dt = new dTree('km_dt', 'kmRoles','_selectItem');
						km_dt.config.multiSelect = true;

						km_dt.add(
							'km_id',
							-1,
							'{*[km.name]*}',
							'javascript:selectOne(\'km_id;{*[km.name]*}\');',
							'km_id',
							'',
							'<%=contextPath%>/resource/images/dtree/app.gif',
							'',
							'false',
							'',
					        '');
					//--------KM下的角色列表--------
					<s:iterator value="#process.doGetRolesByName(#parameters['sm_name'])">
						km_dt.add(
								'<s:property value="id" />',
								'km_id',
								'{*[<s:property value="name" />]*}',
								'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
								'<s:property value="id" /> | {*[<s:property value="name" />]*}',
								'',
								'<%=contextPath%>/resource/images/dtree/role.gif',
								'<%=contextPath%>/resource/images/dtree/role.gif',
								'',
								'',
								'');
					</s:iterator>
					document.write(km_dt);
					</script>
					</div></td>
				</tr>
				<!--  
				<s:iterator value="#ch.getStateList(#parameters.application)">
					<tr class="row-content">
						<td width="100%"><a href="javascript:selectOne('<s:property />')" />
						<s:property /></a></td>
					</tr>
				</s:iterator>
				-->
				
				
		</table>
</s:form>
</body>
</o:MultiLanguage></html>
