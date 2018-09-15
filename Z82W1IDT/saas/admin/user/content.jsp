<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%>
<%@ page import="java.lang.reflect.Method"%>
<%
	String contextPath = request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_USER);
	//request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%><html>
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
	<script type="">
		var contextPath='<%=contextPath%>';
	</script>
	<script src="<s:url value='/script/help.js'/>"></script>
	<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="dtree-user.js"/>'></script>
	<script src='<s:url value="/script/dtree/contextmenu.js"/>'></script>
	<script src='<s:url value="/script/datePicker/WdatePicker.js"/>' ></script>
	<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
<script>
var departmentRemindedInformation = '{*[please.select]*}{*[Department]*}';
var def = "({*[Default]*})";
	
function dosubmit(url){
	if(checkStringAsDefault() && checkIsNumber()){
		var btnSave=document.getElementById("btnSave");
		var btnSaveNew=document.getElementById("btnSaveNew");
		var pw=document.getElementById("_password");
		if (url == "saveAndNew") {
			document.forms[0].action="saveAndNew.action";
		}if(pw.value.length>0){
			btnSave.disabled=true;
			btnSaveNew.disabled=true;
			document.forms[0].submit();
		}else{
			alert("{*[page.login.password]*}");
		}
	}
}

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
function selectRole(){
	var openedNode = document.getElementsByName("_roleSelectItem");
	var openedId;
  	<s:iterator value="#userUtil.getApplicationOpenList(content.id)">
		openedId ='<s:property />';
	  	if (openedNode != null ) {
		  	for (var i=0; i<openedNode.length; i++) {
		    	if(openedId==openedNode[i].value){
		       		dt.openTo(openedId);
				}
			}
		}
	</s:iterator>
  	var roleid;
	<s:iterator value="#userUtil.getRolesids(content.id)">
		roleid ='<s:property />';
	  	if (openedNode != null ) {
		  	for (var i=0; i<openedNode.length; i++) {
		    	if(roleid==openedNode[i].value){
		    		openedNode[i].click();
				}
			}
		}
	</s:iterator>
	
	selectKmRole();
}

function selectKmRole(){
	var openedNode = document.getElementsByName("_kmRoleSelectItem");
  	var roleid;
	<s:iterator value="#userUtil.getKmRolesids(content.id)">
		roleid ='<s:property />';
	  	if (openedNode != null ) {
		  	for (var i=0; i<openedNode.length; i++) {
		    	if(roleid==openedNode[i].value){
		    		openedNode[i].click();
				}
			}
		}
	</s:iterator>
}

function doexit(){
	var page = contextPath + "/core/user/treelist.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>&_orderby=orderByNo&_orderby=id";
	//window.parent.document.getElementById("userFrame").src=page;
	//===========firefox兼容性修改--start=================
	var parentIframe = window.parent.document.getElementById("userFrame");
	var divParent = jQuery(parentIframe).parent();
	var strIframe = '<iframe width="100%" height="100%" frameborder="0"'; 
		strIframe += ' name="userFrame" id="userFrame" src="' + page  + '"></iframe>';
	jQuery(divParent).html(strIframe);
	//===========firefox兼容性修改--end=================
}

//去所有空格   
String.prototype.trimAll = function(){   
    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
};  

//检查用户中名称中是否包含()字符
function checkStringAsDefault(){
	var s =document.getElementById("content.name").value;
	document.getElementById("content.name").value=s.trimAll();
	s = document.getElementById("content.name").value;;
	if(s.indexOf("(")!=-1){
		alert("{*[CanNotHaveKeyword]*} (  ");
		return false;
	}else if(s.indexOf(")")!=-1){
		alert("{*[CanNotHaveKeyword]*} )  ");
		return false;
	}
	return true;
}
//检查排序号是否为数字类型
function checkIsNumber(){
	var obj = document.getElementsByName('content.orderByNo');
	var regex = /^[0-9]*$/;
	if(regex.test(obj[0].value)){
		return true;
	}else{
		alert("{*[page.user.orderbyno.legal]*}!");
		return false;
	}
}

function initLockFlag(){
	//var sa = "<s:property value = 'content.lockFlag'/>";
	var sa = '<s:property value="#userUtil.findUserLockFlag(content.id)" />';
	var name = document.getElementsByName("content.name")[0].value;
	if(sa=="1"||name==""){
		document.getElementsByName("content.lockFlag")[0].checked = true;
	}else{
		document.getElementsByName("content.lockFlag")[1].checked = true;
	}	
}

</script>
<script>
//已选择的resource;
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';

jQuery(document).ready(function(){
	initLockFlag();
	jQuery("#btnSave").attr("disabled",true);
	selectDepartment();
	selectRole();//初始化角色
	jQuery("#btnSave").attr("disabled",false);
	window.top.toThisHelpPage("domain_user_info");
	dtreeMenu();
	initSuperiorText();
	
});

function doUsbKeyCfg(){
	
  	var url =  contextPath + "/core/user/usbKeyCfg.jsp?_userId=" + "<s:property value='content.id' />";
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '{*[core.usbkey.cfg]*}',
			close: function(dataSource) {
			}
	});
}

</script>
</head>
<body id="domain_user_info" class="contentBody" style="width:99%;margin-bottom:5px;overflow:auto;">
<div class="contextMenu" id="jqueryDtreeMenu" style="display:none">
    <ul>
      <li id="defaultDepartment"><img src="<s:url value="/resource/images/dtree/default.png"/>"/>{*[Make]*}{*[Default]*}</li>
    </ul>
</div>
<s:form name="formItem" action="save" method="post" validate="true" theme="simple">
	<input type="hidden" name="content.domainid" value="<s:property value='#parameters.domain' />" />
	<s:hidden name="content.defaultApplication" theme="simple" />
	<div id="contentActDiv">
		<table class="table_noborder">
				<tr><td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.userEdit.user_information]*}</div>
				</td>
				<td>
					<div class="actbtndiv">
						<button type="button" id="btnSaveNew" title="{*[Save&New]*}{*[Button]*}" class="justForHelp button-image" onClick="javascript:dosubmit('saveAndNew')"><img src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
						<button type="button" id="btnSave" title="{*[Save]*}{*[Button]*}" class="justForHelp button-image" onClick="javascript:dosubmit();"><img	src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" id="exitbtn" title="{*[Exit]*}{*[Button]*}" class="justForHelp button-image" onClick="doexit();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/basic.jsp"%> 
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<table class="table_noborder id1">
			<tr>
				<td class="commFont">{*[User_Name]*}:</td>
				<td class="commFont">{*[Account]*}:</td>
			</tr>
			<tr>
				<td id="name_h" pid="contentTable" title="{*[User_Name]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.name" id="content.name" onblur="checkStringAsDefault()" /></td>
				<td id="loginno_h" pid="contentTable" title="{*[Account]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.loginno" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[Password]*}:</td>
				<td class="commFont">{*[Email]*}:</td>
			</tr>
			<tr>
				<td id="password_h" pid="contentTable" title="{*[Password]*}" class="justForHelp"><s:password cssClass="input-cmd" theme="simple"
					name="_password" id="_password" show="true" /></td>
				<td id="email_h" pid="contentTable" title="{*[Email]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.email" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[Mobile]*}:</td>

				<td class="commFont">{*[Calendar]*}:</td>
			</tr>
			<tr>
				<td id="telephone_h" pid="contentTable" title="{*[Mobile]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.telephone" /></td>
				<td id="calendarType_h" pid="contentTable" title="{*[Calendar]*}" class="justForHelp"><s:if
					test="content.calendarType!=null && content.calendarType!=\"\"">
					<s:select theme="simple" cssClass="input-cmd"
						name="content.calendarType" list="#ch.getWorkCalendars()" />
				</s:if> <s:else>
					<s:select cssClass="input-cmd" theme="simple"
						name="content.calendarType" list="#ch.getWorkCalendars()"
						value="#ch.getDefaultCalendarByDomain()" />
				</s:else></td>
			</tr>
			<tr>
				<td class="commFont">{*[Status]*}:</td>
				<td class="commFont">{*[Superior]*}:</td>
			</tr>
			<tr>
				<td id="strstatus_h" pid="contentTable" title="{*[Status]*}" class="justForHelp"><s:radio name="_strstatus" theme="simple"
					list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" /></td>
				<td id="superiorid_h" pid="contentTable" title="{*[Superior]*}" class="justForHelp">
					<s:hidden name="reportTree"/>
					<input id="superiorname" readonly="readonly" class="input-cmd" style="width:250px;"/>
					<s:hidden id="superiorid" name="superiorid"/>
					<input type="button" value="..." onclick="superiorSelect();">
				<script type="text/javascript">

				function initSuperiorText(){
					var reportTree = jQuery("[name='reportTree']").val();
					var superiorid = jQuery("[name='superiorid']").val();
					var start = reportTree.indexOf(superiorid);
					if(superiorid=="" || start == -1){
						jQuery("#superiorname").val("{*[none]*}");
					}else{
						var end = reportTree.indexOf(",",start+superiorid.length+1);
						var superiorname = reportTree.substring(start+superiorid.length+1,end);
						jQuery("#superiorname").val(superiorname);
					}
				}
				
				function superiorSelect(){
					var url = contextPath + "/core/user/selectsuperior.jsp";
					var contentId = jQuery("[name='content.id']").val();
					OBPM.dialog.show({
						width : 610,
						height : 450,
						url : url,
						args : {
							"parentObj" : window,
							"targetid" : "superiorid",
							"receivername" : "superiorname",
							"domainid" : '<%=domain%>',
							"contentId": contentId
						},
						title : '{*[Superior]*}{*[Select]*}',
						close : function(result) {
							//alert(result);
						}
					});
				}

				function agentStart(){
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'',maxDate:'2050-12-30',skin:'whyGreen'});
				}

				function agentEnd(){
					var time = jQuery("#11e0-8ce4-41e1e3fb-a1e7-47475ec6c04b_startProxyTime").val();
					WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'time',maxDate:'2050-12-30',skin:'whyGreen'});
				}
				</script>
				</td>
			</tr>
			<tr>
				<td class="commFont">{*[Setup]*}{*[DomainAdmin]*}{*[Authority]*}：</td>
				<td class="commFont">{*[Remarks]*}：</td>
			</tr>
			<tr>
				<td><s:checkbox id="domainUser" label="domainUser" name="content.domainUser"  />{*[DomainAdmin]*}</td>
				<td id="Remarks_h" pid="contentTable" title="{*[Remarks]*}" class="justForHelp"><s:textfield cssClass="input-cmd" theme="simple"
					name="content.remarks" /></td>
			</tr>
			<tr>
				<td class="commFont">{*[Setup]*}{*[OrderNumber]*}:</td>
				<TD class="commFont">{*[if.can.login]*}：</TD>
			</tr>
			<tr>
				<td>
					<s:textfield cssClass="input-cmd" theme="simple"
					name="content.orderByNo" />
				 </td><TD><s:radio name="content.lockFlag"  theme="simple" 
					list="#{'1':'{*[Yes]*}','0':'{*[No]*}'}" />
					</TD>
			</tr>
			<!-- 扩展字段开始 -->
			<%
			UserVO user = (UserVO) request.getAttribute("content");
			FieldExtendsHelper helper = new FieldExtendsHelper();
			List<FieldExtendsVO> fes = new ArrayList<FieldExtendsVO>();
			for(int i=0;i<fieldExtendses.size();i++){
				FieldExtendsVO fevo = fieldExtendses.get(i);
				if(fevo != null && fevo.getEnabel()){
					fes.add(fevo);
				}
			}
			out.append(helper.getFieldHtml(fes, user));
			%>
			<!-- 扩展字段结束 -->
			<tr>
				<td class="commFont">{*[Department]*}:<span style="color:green"> 必须设置一个默认部门(请勾选部门右击选中其为默认部门)</span></td>
				<td class="commFont">{*[Roles]*}:</td>
			</tr>
			<tr style="vertical-align: top;">
				<td id="Department_h" pid="contentTable" title="{*[Department]*}" class="justForHelp">
				<table cellpadding="0" cellspacing="0" style="vertical-align: top;">
					<tr>
						<td>
						<s:hidden cssClass="input-cmd" theme="simple" name="content.defaultDepartment" id="content.defaultDepartment"/>
						<div id="deplist" class="commFont"><script
							type="text/javascript">
						var d = new dTree('d', 'deplist','_deptSelectItem', dtreeMenu);	
						d.config.multiSelect = true;
						<s:iterator value="_departmentlist">
						<s:if test="%{superior.id != null && superior.id != ''}">
						
							<s:if test="%{id==content.defaultDepartment}">
							    //alert(1); 
								d.add(
									'<s:property value="id" />',
									'<s:property value="superior.id" />',
									'<s:property value="name" />'+def+'',
									'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />'+def+'\');',
									'<s:property value="id" />',
									'',
									'<%=contextPath%>/resource/images/dtree/dept.gif',
									'<%=contextPath%>/resource/images/dtree/dept.gif',
									'',
									'',
									'<%=contextPath%>/core/department/subNodes.action');
							</s:if>
								
							<s:else>
								// alert(2);
								d.add(
										'<s:property value="id" />',
										'<s:property value="superior.id" />',
										'<s:property value="name" />',
										'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
										'<s:property value="id" />',
										'',
										'<%=contextPath%>/resource/images/dtree/dept.gif',
										'<%=contextPath%>/resource/images/dtree/dept.gif',
										'',
										'',
										'<%=contextPath%>/core/department/subNodes.action');
							</s:else>
							
						</s:if>
						
						<s:else>
							<s:if test="id==content.defaultDepartment">
							// alert(3);
								d.add('<s:property value="id" />',
									-1,
									'<s:property value="name" />'+def+'',
									'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />'+def+'\');',
									'<s:property value="id" />',
									'',
									'<%=contextPath%>/resource/images/dtree/dept.gif',
									'',
									'',
									'',
									'<%=contextPath%>/core/department/subNodes.action');	
							</s:if>
							<s:else>
								// alert(4);
								d.add('<s:property value="id" />',
										-1,
										'<s:property value="name" />',
										'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
										'<s:property value="id" />',
										'',
										'<%=contextPath%>/resource/images/dtree/dept.gif',
										'',
										'false',
										'',
										'<%=contextPath%>/core/department/subNodes.action');
							</s:else>					
						</s:else>
					</s:iterator>
					document.write(d);
						</script></div>
						</td>
					</tr>

				</table>
				</td>
				<td style="vertical-align: top;" id="Roles_h" pid="contentTable" title="{*[Roles]*}" class="justForHelp">
						<!-- <s:radio name="filterRoles" list="%{#{'all':'显示全部','selected':'显示选中项'}}" onclick ="displayroles(this.value)"></s:radio> -->
						<input type="radio" name="filterRoles" value="all" checked="checked" onclick ="displayroles(this.value)"/>{*[core.user.showAllRole]*}
						<input type="radio" name="filterRoles" value="selected" onclick ="displayroles(this.value)"/>{*[core.user.showChoseRole]*}
						<br/>
						<div style="margin-top: 5px;margin-bottom: 5px;">
							<span>{*[Role]*}{*[Name]*}:</span>
							<input type="text" id="filterCondition" name="filterCondition" size="4"/>				
							<input type="button" value="{*[Query]*}" onclick="showSearchRoles()"/>
						</div>
				<table cellpadding="0" cellspacing="0" style="vertical-align: top">
					<tr>
						<td class="commFont">
						<div id="rolelist" class="commFont"><script
							type="text/javascript">
						var dt = new dTree('dt', 'rolelist','_roleSelectItem');
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
						<s:iterator value="_applicationlist">
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
									'');
						</s:iterator>

						//--------应用下的角色列表--------
						<s:iterator value="_roleList">
								dt.add(
									'<s:property value="id" />',
									'<s:property value="applicationid" />',
									'<s:property value="name" />',
									'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
									'<s:property value="id" />',
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
							km_dt.openAll();
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
						}
						
						var km_dt = new dTree('km_dt', 'kmRoles','_kmRoleSelectItem');
						km_dt.config.multiSelect = true;
						//--------KM---------
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
					<s:iterator value="_kmRoles">
						km_dt.add(
								'<s:property value="id" />',
								'km_id',
								'<s:property value="name" />',
								'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
								'<s:property value="id" />',
								'',
								'<%=contextPath%>/resource/images/dtree/role.gif',
								'<%=contextPath%>/resource/images/dtree/role.gif',
								'',
								'',
								'');
					</s:iterator>
					document.write(km_dt);
						</script></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>