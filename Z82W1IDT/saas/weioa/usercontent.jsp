<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>
<%
	String contextPath = request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_USER);
	//request.setAttribute("fieldExtendses", fieldExtendses);
	DomainHelper dh = new DomainHelper();
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%>
<o:MultiLanguage>
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper"	id="mh" /> 
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#parameters.domain" />
</s:bean>
<!DOCTYPE html>
<html lang="cn" class="app fadeInUp animated">
<head>
<title>{*[cn.myapps.core.domain.userEdit.user_information]*}</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
 	<link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
	<link rel="stylesheet" href="../resource/js/plugins/tip/tip-yellow/tip-yellow.css" type="text/css" />
	<script type="">
		var contextPath='<%=contextPath%>';
	</script>
	<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script src='<s:url value="/portal/share/user/superfront/dtree-user.js"/>'></script>
	<script src='<s:url value="/script/dtree/contextmenu.js"/>'></script>
	<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>' ></script>
	<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
	<!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
	<script type="text/javascript" src="../resource/js/plugins/tip/jquery.poshytip.min.js"></script>
<script type="text/javascript">
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
	var page = contextPath + "/portal/user/superusertreelist.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="#parameters._currpage"/>&_pagelines=<s:property value="#parameters._pagelines"/>&_rowcount=<s:property value="#parameters._rowcount"/>&_orderby=orderByNo&_orderby=id";
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
<script type="text/javascript">
//已选择的resource;
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';

jQuery(document).ready(function(){
	initLockFlag();
	jQuery("#btnSave").attr("disabled",true);
	dtreeMenu();
	selectDepartment();
	selectRole();//初始化角色
	jQuery("#btnSave").attr("disabled",false);
	initProxyUserText();
	initSuperiorText();
	//window.top.toThisHelpPage("domain_user_info");
	
	
	
});

</script>
</head>
<body id="domain_user_info" class="contentBody" style="overflow: auto;">
<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div class="contextMenu" id="jqueryDtreeMenu" style="display:none">
    <ul>
      <li id="defaultDepartment"><img src="<s:url value="/resource/images/dtree/default.png"/>"/>{*[Make]*}{*[Default]*}</li>
    </ul>
</div>
<s:form name="formItem" action="save" method="post" validate="true" theme="simple">

<div id="formContent" class="modal-body">
	
     <div class="form-group">
         <label class="col-sm-2 control-label must"><font color="#FF0000">*</font>{*[User_Name]*}</label>
         <div class="col-sm-7">
         	<s:textfield cssClass="form-control valid" data-rule-required="true" maxlength="40" aria-required="true" aria-invalid="false" theme="simple" name="content.name" id="content.name" onblur="checkStringAsDefault()" />
         </div>
     </div>
     <div class="form-group">
         <label class="col-sm-2 control-label must"><font color="#FF0000">*</font>{*[Account]*}({*[Email]*})</label>
         <div class="col-sm-7">
         	<s:textfield cssClass="form-control tips" data-rule-required="true" placeholder="请输入邮箱，成员唯一标识，设定后不可更改" 
         		maxlength="120" aria-required="true" theme="simple" id="id-account" name="content.loginno" 
         		rule="^[A-Za-z0-9_@\.-]+@([A-Za-z0-9_-]+\.)+[A-Za-z0-9_-]{2,3}$" title="请填写真实正确的邮箱格式，用来接收重要邮件"/>
         
         </div>
     </div>
     <div class="form-group">
         <label class="col-sm-2 control-label must"><font color="#FF0000">*</font>{*[Password]*}</label>
         <div class="col-sm-7">
         	<s:password cssClass="form-control tips" theme="simple" name="_password" id="_password" 
         		showPassword="true" title="请输入登录密码, 密码要大于6位且要包含字母、数字"/>
         </div>
     </div>
     <div class="form-group" style="display: none">
         <label class="col-sm-2 control-label"><font color="#FF0000">*</font>{*[Email]*}</label>
         <div class="col-sm-7">
         	<s:textfield cssClass="form-control js_partial_require" maxlength="220" theme="simple" name="content.email" />
         </div>
     </div>
     <div class="form-group">
         <label class="col-sm-2 control-label"><font color="#FF0000">*</font>手机号</label>
         <div class="col-sm-7">
         	<s:textfield cssClass="form-control tips" maxlength="120" theme="simple"
					name="content.telephone" rule="^[0-9]{11}$" title="请输入11位的手机号"/>
         </div>
     </div>
     <div style="display: none" class="form-group">
         <label class="col-sm-2 control-label">{*[Calendar]*}</label>
         <div class="col-sm-7">
            <s:select cssClass="form-control" theme="simple"
						name="content.calendarType" list="#ch.getWorkCalendars()"
						value="#ch.getDefaultCalendarByDomain()" />
         </div>
     </div>
     
      <div class="form-group">
         <label class="col-sm-2 control-label">{*[Superior]*}</label>
         <div class="col-sm-7">
             	<s:hidden name="reportTree"/>
             	<table>
             	<tr>
					<td><input id="superiorname" readonly="readonly" class="form-control" style="width:430px;"/></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<s:hidden id="superiorid" name="superiorid"/>
					<td><input type="button" class="btn btn-default" value="选择上级" onclick="superiorSelect();"></td>
				</tr>
				</table>
				<script type="text/javascript">
				function initSuperiorText(){
					var superiorid = jQuery("[name='superiorid']").val();
					var superiorname = '<s:property value="#userUtil.findUserName(superiorid)" />';
					if(superiorid==""){
						jQuery("#superiorname").val("{*[none]*}");
					}else{
						jQuery("#superiorname").val(superiorname);
					}
				}
				
				function superiorSelect(){
					var url = contextPath + "/portal/share/user/selectUser4Superior.jsp";
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
				<script type="text/javascript">
				//校验
				var smsauth = '';
				var mobilephone = '';
				$(function(){
				    // 表单提示
				    $(' .tips').poshytip(
				        {showOn: 'focus', alignTo: 'target',
				        alignX: 'inner-left',
				        offsetX: 0,
				        offsetY: 5,
				        showTimeout: 100}
				    );
				    $(' .tips').on('click keyup change', function () {
				        $(this).removeClass('error');
				        if ($(this).hasClass(' .tips')) {
				            if ($(this).is(':checked')) {
				                $(this).poshytip('hide');
				                $(this).poshytip('disable');
				            } else {
				                $(this).poshytip('enable');
				                $(this).poshytip('show');
				            }
				        }
				    });
				});

				// 提交手机验证表单
			    $(' .tips').blur(function(){
			        var error = false;
			        
			         var inputs = $(this);;
				     error = _form_check(inputs);
			        if (error) {            
			            return;
			        }
			        
			        return false;
			    });

				
				function _form_check(inputs) {
				    var error = false;
				            var rule = $(inputs).attr('rule');
				            if (rule) {
				                rule = new RegExp(rule);
				                $(inputs).poshytip('enable');
				                if (!rule.test($(inputs).val())) {
				                	$(inputs).focus();
				                    $(inputs).addClass('error');
				                    $(inputs).poshytip('show');
				                   
				                    error = true;
				                }
				            } else {
				                if ($(inputs).val() == '') {
				                	$(inputs).focus();
				                    $(inputs).addClass('error');
				                    $(inputs).poshytip('show');
				                    error = true;
				                } else if($(inputs).attr('id') == '_password') {
				                         var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
				                         var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
				                         var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
				                         //密码小于六位的时候，密码强度太低不给通过 
				                         if (false == enoughRegex.test($(inputs).val())) { 
				                            error = true;
				                            $(inputs).focus();
				                            $(inputs).addClass('error');
				                            $(inputs).poshytip('update', '密码长度不要少于六位');
				                            $(inputs).poshytip('show');
				                         } else if (strongRegex.test($(inputs).val())) {
				                         } else if (mediumRegex.test($(inputs).val())) { 
				                         } else {
				                        	$(inputs).focus();
				                            $(inputs).addClass('error');
				                            $(inputs).poshytip('update', '密码要包含字母、数字、特殊字符等。');
				                            $(inputs).poshytip('show');
				                            error = true;
				                         }
				                }
				            }
				    return error;
				}
				</script>
         </div>
     </div>
    
     <div class="form-group">
         <label class="col-sm-2 control-label"> {*[cn.myapps.core.user.isdimission]*}</label>
         <div class="col-sm-7">
             <s:radio theme="simple" cssClass="" name="content.dimission" list="#{'1':'{*[cn.myapps.core.user.isdimission.on_job]*}','0':'{*[cn.myapps.core.user.isdimission.dimission]*}'}"/>
         </div>
     </div>
     <!--<div class="col-sm-offset-2">  <div class="text-muted m-xs js_form_tips">以下三项信息至少填写一项</div></div>      -->
     
 </div>




<!-- 下面是老的表单 -->
	<input type="hidden" name="content.domainid" value="<s:property value='#parameters.domain' />" />
	<s:hidden name="content.defaultApplication" theme="simple" />
	<%@include file="/common/basic.jsp"%> 
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<s:hidden name="content.status" />
		<s:hidden name="content.remarks" />
		<s:hidden name="startProxyTime" />
		<s:hidden name="endProxyTime" />
	
	<div id="contentMainDiv" class="contentMainDiv">
		
		<table class="table_noborder id1">
				<script type="text/javascript">

				function initProxyUserText(){
					var _proxyUser = jQuery("[name='_proxyUser']").val();
					var proxyusername = '<s:property value="#userUtil.findUserName(_proxyUser)" />';			
					if(_proxyUser==""){
						jQuery("#proxyusername").val("{*[none]*}");
					}else{					
						jQuery("#proxyusername").val(proxyusername);
					}
				}
				
				function proxyUserSelect(){
					//var url = contextPath + "/portal/share/user/selectUser4Proxy.jsp";
					var url = contextPath + "/portal/share/component/dialog/selectUserByAll.jsp";
					var contentId = jQuery("[name='content.id']").val();
					OBPM.dialog.show({
						width : 610,
						height : 450,
						url : url,
						args : {
							"parentObj" : window,
							"targetid" : "_proxyUser",
							"receivername" : "proxyusername",
							"domainid" : '<%=domain%>',
							"contentId": contentId
						},
						title : '{*[cn.myapps.core.domain.userEdit.proxy_user_select]*}',
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
				<s:hidden name="content.domainUser" />
				<s:hidden name="content.useIM" />
				<s:hidden name="content.orderByNo" />
				<s:hidden name="content.lockFlag" />
			<!-- 扩展字段开始 -->
			<%
			/**
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
			**/
			%>
			<!-- 扩展字段结束 -->
			<tr>
				<td class="commFont"><font color="#FF0000">*</font>{*[Department]*}:<span class="tipsStyle"> {*[page.user.defaultdepartment.required]*}</span></td>
				<td style="display: none"  class="commFont">{*[Roles]*}:</td>
			</tr>
			<tr style="vertical-align: top;">
				<td id="Department_h" pid="contentTable" title="{*[Department]*}" class="justForHelp">
				<table cellpadding="0" cellspacing="0" style="vertical-align: top;">
					<tr>
						<td>
						<s:hidden cssClass="form-control" theme="simple" name="content.defaultDepartment" id="content.defaultDepartment"/>
						<div id="deplist" class="commFont">
						<script type="text/javascript">
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
									'<%=contextPath%>/portal/department/subNodes.action')
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
										'<%=contextPath%>/portal/department/subNodes.action')
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
									'<%=contextPath%>/portal/department/subNodes.action')	
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
										'<%=contextPath%>/portal/department/subNodes.action')	
							</s:else>					
						</s:else>
					</s:iterator>
					document.write(d);
						</script></div>
						</td>
					</tr>

				</table>
				</td>
				<td style="vertical-align: top;display: none" id="Roles_h" pid="contentTable" title="{*[Roles]*}" class="justForHelp">
						<!-- <s:radio name="filterRoles" list="%{#{'all':'显示全部','selected':'显示选中项'}}" onclick ="displayroles(this.value)"></s:radio> -->
						<input type="radio" name="filterRoles" value="all" onclick ="displayroles(this.value)"/>{*[core.user.showAllRole]*}
						<input type="radio" name="filterRoles" value="selected" onclick ="displayroles(this.value)"/>{*[core.user.showChoseRole]*}
						<br/>
						<div style="margin-top: 5px;margin-bottom: 5px;">
							<span>{*[Role]*}{*[Name]*}:</span>
							<input type="text" id="filterCondition" class="form-control" name="filterCondition" size="4"/>				
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
						        '')
						
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
									'')
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
									'')
						</s:iterator>
													
						document.write(dt);

						function displayroles(tempValue){
							if(tempValue == 'all'){
								jQuery(".dTreeNode").css("display","block");
								dt.openAll();
							}else if(tempValue == 'selected'){
								showCheckRoles();
							}
						}

						function showCheckRoles(){
							jQuery(".dTreeNode").css("display","block");
							jQuery("input[name=_roleSelectItem]").each(function(i){
								if(jQuery(this).attr("checked") != "checked"){
									jQuery(this).parent().css("display","none");
								}
							});

							jQuery("a").each(function(i){
								jQuery(this).parent().css("display","block");
							});
						}
						
						function showSearchRoles(){
							var textVal = document.getElementById("filterCondition").value;
							jQuery("input[name=_roleSelectItem]").each(function(i){
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

						//--------KM---------
						<% 
						if(dh.getModuleConfigByDomain(domain,SystemModuleConfig.KM)){
						%>
						var km_dt = new dTree('km_dt', 'kmRoles','_kmRoleSelectItem');
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
				<%}%>
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
</html>
</o:MultiLanguage>