<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath().equals("/")? "":request.getContextPath();
	// 获取扩展字段
	String domain = request.getParameter("domain");
	String orderBy = request.getParameter("_orderby");
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTableAndEnabel(domain, FieldExtendsVO.TABLE_USER, true);
	request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="java.util.List"%>
<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%><html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[User_List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="text/javascript">
	var contextPath='<%=contextPath%>';
	var orderBy = '<%=orderBy%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function showMessage() {
  	if(document.getElementById("msg")){
		/**根据提示信息长度计算倒计时时间--start**/
		var sum = 0;
		var timeSize = 3;
		var content = "*删除的用户中存在下级，请先删除下级"
		for(var i=0;i<content.length;i++) { 
		    if((content.charCodeAt(i)>=0) && (content.charCodeAt(i)<=255)) {
		      	sum=sum+1;
		    }else {
		      	sum=sum+2;
		    }
		}
		timeSize += (sum>20)?Math.round((sum-20)/10):0;
		/**根据提示信息长度计算倒计时时间--end**/
		
		var $msgObj = jQuery("#msg");
		
		$msgObj.find("#tip").html("(<span>"+timeSize+"</span>)("+"{*[page.msg.mouse_hover_pause_hide]*}"+")")	//初始化倒计时内容
			.end().fadeIn(1000)//显示消息
			.bind("mousedown",function(){//鼠标按下后停止倒计时隐藏
				clearTimeout(time2);
				$msgObj.find("#tip").html("(单击隐藏)");
			}).bind("click",function(){//鼠标点击时隐藏
				$msgObj.fadeOut(1000);
			}).bind("mouseover",function(){
				isOut = false;
			}).bind("mouseout",function(){
				isOut = true;
			});

		//倒计时功能
		var time2 = 0;
		var isOut = true;
		var timer = function(){
			time2 = setTimeout(function(){
				timer();
			},1000);
			if(isOut){
				var $msgTip = $msgObj.find("#tip > span");
				$msgTip.html($msgTip.html()-1);
				if($msgTip.html() <= 0){
					clearTimeout(time2);
					$msgObj.fadeOut(1000);//隐藏消息
				}
			}
		};
		setTimeout(function(){
			timer();
		},1000);
	}
}

	function doDelete(){
		var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	if(confirm("删除后不可恢复，确认删除吗？")){
		    	listform.action='<s:url action="delete"><s:param name="id" value="#parameters.id" /></s:url>';
		    	listform.submit();
	    	}
	    }
	}
	function isEdit(){
		window.parent.document.getElementById("isedit").value="true";
	}
	
	jQuery(document).ready(function(){
		showMessage();
		cssListTable();
		window.top.toThisHelpPage("domain_user_list");
		
		initRoleSelect('<s:property value="#parameters['applicationid'][0]"/>', '<s:property value="#parameters['sm_userRoleSets.roleId'][0]"/>');
		
		var roleId = jQuery('#roleId').attr('value');
		
		if(roleId == null || roleId == ""){    //判断roleId是否为空
		  getRoles(jQuery('#applicationId').attr('value'));
		}
		
		//查询按钮监听事件
		jQuery("#search_btn").unbind().bind("click",function(){
			parent.userlist(jQuery('#sm_name').attr('value'),
					jQuery('#sm_loginno').attr('value'),
					jQuery('#sm_superior').attr('value'),
					jQuery('#departmentId').attr('value'),
					jQuery('#roleId').attr('value'),
					jQuery('#applicationId').attr('value')
			);
			jQuery("#selectnode").attr("value","");
			jQuery("#isclick").attr("value","true");
			jQuery("#name").attr("value",sm_name);
			jQuery("#loginno").attr("value",sm_loginno);
			//jQuery("#selectnode").attr("value",departmentId);
			jQuery("#applicationid").attr("value",applicationId);
			jQuery("#roleid").attr("value",roleId);
			
			var targetUrl = "";
			
			if(sm_name != null && sm_name != ""){
				targetUrl += "&sm_name="+encodeURI(sm_name);
			}
			if(applicationId != null && applicationId != ""){
				targetUrl += "&applicationId="+applicationId;
			}
			/* if(departmentId != null && departmentId != ""){
				targetUrl += "&departid="+departmentId;
			} */
			if(sm_loginno != null && sm_loginno != ""){
				targetUrl += "&sm_loginno="+encodeURI(sm_loginno);
			}
			if(sm_superior != null && sm_superior != ""){
				targetUrl += "&superior.name="+encodeURI(sm_superior);
			}
			if(roleId != null && roleId != ""){
				targetUrl += "&sm_userRoleSets.roleId="+roleId;
			}
			targetUrl += "&_orderby=orderByNo&_orderby=id";
			
			//var page = contextPath + "/core/user/treelist.action?domain=<%=request.getParameter("domain")%>" + targetUrl;
		});
	});
	function initRoleSelect(applicationid, roleid){
		if(!applicationid){
			applicationid = '<s:property value="#parameters['applicationId'][0]"/>';
		}
		if(applicationid!='' && roleid!=''){
			DWREngine.setAsync(false);
			getRoles(applicationid);
		    var applications = document.getElementById("applicationId");
		    var roles = document.getElementById("roleId");
		    for(i=0;i<applications.options.length;i++){
			    if(applications.options[i].value==applicationid){
				    applications.options[i].selected = true;
				}
			}

			for(i=0;i<roles.options.length;i++){
				if(roles.options[i].value==roleid){
					roles.options[i].selected = true;
				}
			}
		}
	}
    function setSelectOptionsTitle(id){//css限制角色选择框长度,js显示过长的内容
        var obj = document.getElementById(id);
	    for(i=0;i<obj.options.length;i++){
	    	obj.options[i].title = obj.options[i].text;
	    }
    }
    function getRoles(value){
    	UserUtil.getRolesByApplicationid(value, function(arr){
          var roles = document.getElementById("roleId");
          DWRUtil.removeAllOptions("roleId");
          roles.options.add(new Option("",""));
          DWRUtil.addOptions("roleId", arr);
		  setSelectOptionsTitle("roleId");
        	});
    }
    

    function donew(){
		parent.document.getElementById("selectnode").value="";
		parent.document.getElementById("isclick").value ="true";
		var page = contextPath + "/core/user/new.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="datas.pageNo"/>&_pagelines=<s:property value="datas.linesPerPage"/>&_rowcount=<s:property value="datas.rowCount"/>";
		//window.parent.document.getElementById("userFrame").src=page;
		//===========firefox兼容性修改--start=================
		var parentIframe = window.parent.document.getElementById("userFrame");
		var divParent = jQuery(parentIframe).parent();
		var strIframe = '<iframe width="100%" height="100%" frameborder="0"'; 
			strIframe += ' name="userFrame" id="userFrame" src="' + page  + '"></iframe>';
		jQuery(divParent).html(strIframe);
		//===========firefox兼容性修改--end=================
	}

	function resetAll(){
		jQuery('#sm_name,#sm_loginno,#sm_superior,sm_department,#applicationId').val('');
		DWRUtil.removeAllOptions('roleId');
	}
</script>
</head>
<body id="domain_user_list" class="listbody" style="overflow-y:auto;overflow-x:hidden;">
<div>
<s:form id="formList" name="formList" action="treelist" method="post" theme="simple">
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[User_List]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button"  id="new_User" title="{*[cn.myapps.core.domain.userlist.title.new_user]*}" class="justForHelp button-image" onClick="donew();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					<button type="button" id="delete_User" title="{*[cn.myapps.core.domain.userlist.title.delete_user]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td>
		</tr>
	</table>
	<div id="main">	
		<%@include file="/common/basic.jsp" %>
 		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<div id="msg" style="color: #23571d;font-size: 14px;width: auto;height: 30px;line-height: 16px;padding: 5px;text-align: center;position:absolute;z-index: 1000;width: 100%;background-color: #ffa3a9;" onclick="showMessage()">
			<div id="tip" style="position:absolute;font-size:12px;left:10px;bottom: 2px;">(<span>3</span>)(鼠标悬停暂停隐藏)</div>
			<div>*删除的用户中存在下级，请先删除下级</div>
			</div>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}">
			<table class="table_noborder">
				<tr><td>
				    <table border="0" style="width: 790px;">
				      	<tr>
					      	<td class="head-text">{*[Name]*}:</td>
					       	<td>
				       			<input pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.by_name]*}" class="justForHelp input-cmd" type="text" id="sm_name" name="sm_name" value='<s:property value="params.getParameterAsString('sm_name')" />' size="10" /></td>
					        <td class="head-text">{*[Application]*}:</td>
					        <td>
					        	<s:select cssClass="input-cmd" theme="simple" value="#parameters['applicationId'][0]" id="applicationId" name="applicationId" list="_applicationlist" listKey="id" listValue="name"  onchange="getRoles(this.value)" cssStyle="width:130px;" />
					        </td>
					        <td class="head-text"></td>
					        <td>
					        </td>
						    <td rowspan="2" align="left">
						      	<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}" class="justForHelp button-cmd" type="button" value="{*[Query]*}" />
						      	<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
						    </td>
				      	</tr>
				      	<tr>
					        <td class="head-text">{*[Account]*}:</td>
					        <td>
						        <input pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.by_account]*}" class="justForHelp input-cmd" type="text" id="sm_loginno" name="sm_loginno" value='<s:property value="params.getParameterAsString('sm_loginno')" />' size="10" />
					        </td>
					        <td class="head-text">{*[Role]*}:</td>
					        <td>
				          		<select class="input-cmd" id="roleId" name="sm_userRoleSets.roleId" style="width:130px;">
					        		<option value="" ></option>
					      		</select>
						   </td>
						   <td></td>
						   <td></td>
				      	</tr>
				      	<tr>
					      	<td class="head-text">{*[cn.myapps.core.domain.userlist.title.superior_name]*}:</td>
					       	<td>
					           <input pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.by_superior]*}" class="justForHelp input-cmd" type="text" id="sm_superior" name="sm_superior.name" value='<s:property value="params.getParameterAsString('sm_superior.name')" />' size="10" />
					        <td class="head-text"></td>
					       	<td>
					        <td class="head-text"></td>
					        <td>
					        </td>
				      	</tr>
				    </table>
					
					<script type="text/javascript">
					  setSelectOptionsTitle("applicationId");
					</script>
					
					<s:hidden id="isclick" value="false"></s:hidden>
					<s:hidden id="selectnode" value=""></s:hidden>	
					<s:hidden id="name" value=""></s:hidden>
					<s:hidden id="loginno" value=""></s:hidden>
					<s:hidden id="roleid" value=""></s:hidden>
					<input type="hidden" name="departid" value='<s:property value="#parameters['departid']"/>'>
				</td></tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div id="contentTable">
			<table class="table_noborder tableTOver">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col" title="{*[Name]*}"><o:OrderTag field="name"
						css="ordertag">{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Account]*}"><o:OrderTag field="loginno"
						css="ordertag">{*[Account]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Email]*}"><o:OrderTag field="email"
						css="ordertag">{*[Email]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Mobile]*}"><o:OrderTag field="telephone"
						css="ordertag">{*[Mobile]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Superior]*}"><o:OrderTag field="superior"
						css="ordertag">{*[Superior]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Department]*}">{*[Department]*}</td>
					
					<!-- 扩展字段头 -->
					<s:iterator value="#request.fieldExtendses">
						<td class="column-head" scope="col" title='<s:property value="label"/>'><s:property value="label"/></td>
					</s:iterator>
				</tr>
				<s:iterator value="datas.datas" status="index" id="uservo">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id"/>"></td>
					<td title='<s:property value="name" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="name" />
						</a>
					</td>
					<td title='<s:property value="loginno" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="loginno" />
						</a>
					</td>
					<td title='<s:property value="email" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="email" />
						</a>
					</td>
					<td title='<s:property value="telephone"/>'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="telephone"/>
						</a>
					</td>
					
					<td title='<s:property value="superior"/>'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="superior.name"/>
						</a>
					</td>
					
					<td title='<s:iterator value="departments" status="index"><s:property value="name"/><s:if test="!#index.last">|</s:if></s:iterator>'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="#uservo.id"/></s:url>';document.forms[0].submit();">
							<s:iterator value="departments" status="index">
			              		<s:property value="name"/><s:if test="!#index.last">&nbsp;&nbsp;|&nbsp;&nbsp;</s:if>			
							</s:iterator>
						</a>
					</td>
					
					<!-- 扩展字段内容 -->
					<s:iterator value="#request.fieldExtendses" id="field">
						<td title='<s:property value="#field.getValue(#uservo)"/>'>
							<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="#uservo.id"/></s:url>';document.forms[0].submit();">
								<s:property value="#field.getValue(#uservo)"/>
							</a>
						</td>
					</s:iterator>
					
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav">
					<o:PageNavigation dpName="datas" css="linktag" />
				</td>
			</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
