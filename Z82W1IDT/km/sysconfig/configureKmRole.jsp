<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/admin/css/bootstrap.min.css" />' rel="StyleSheet" type="text/css" />
<link href='<s:url value="/km/admin/css/admin.css" />' rel="StyleSheet" type="text/css" />
<script src="<s:url value='/km/admin/js/jquery-2.1.4.js'/>"></script>
<script type="text/javascript">
	function loadUserByDomainId(domainId) {
		var url = contextPath + "/portal/sysconfig/configure.action?domainId=" + domainId;
		window.location.href=url;
	}

	function checkForm() {
		var _selects = document.getElementsByName("_selects");
		if(_selects.length == 0) {
			alert("{*[core.sysconfig.km.role.config.domain.select.alert]*}");
			return false;
		}

		var count = 0;
		for (var i = 0; i < _selects.length; i++) {
			if (_selects[i].checked == true) {
				count++;
			}
		} 
		if (count == 0) {
			alert("{*[core.sysconfig.km.role.config.user.select.alert]*}");
			return false;
		}
		return true;
	}

	function resetAll(){
		jQuery('#sm_name,#sm_loginno').val('');
		jQuery("#departmentId").get(0).selectedIndex=0;
		
	}

	function userlist(keyword,departmentId){
		/* jQuery("#name").attr("value",sm_name);
		jQuery("#loginno").attr("value",sm_loginno);
		 */
		var targetUrl = "&keyword="+keyword;

		/* if(sm_loginno != null && sm_loginno != ""){
			targetUrl += "&sm_loginno="+encodeURI(sm_loginno);
		} */
		if(departmentId != null && departmentId != ""){
			targetUrl += "&deptId="+departmentId;
		}
		var page = contextPath + "/portal/sysconfig/configure.action?domainId=<%=request.getParameter("domainId")%>" + targetUrl;
		 var f= document.createElement('form');
		 f.action = page;
		 f.method = 'post';
		 document.body.appendChild(f);
		 /* if(keyword != null && keyword != ""){
			 var temp=document.createElement('input');
			 temp.type= 'hidden';
			 temp.value=keyword; 
			 temp.name='keyWord';
			 f.appendChild(temp);
			} */
		 f.submit();
	}
	function roleChooseShow(){
		var isShow = false;
		$("#contentTable").find("input[type='checkbox']").each(function(){
			if($(this).is(':checked')){
				isShow = true;
			}
		});
		if(isShow){
			$(".chooseRole").show();
		}else{
			$(".chooseRole").hide();
		}
	}
	$(function(){
		$(".chooseRole>a").click(function(){
			var val = $(this).attr("_id");
			$("input[value="+val+"]").prop("checked");
			$(this).toggleClass("select");
			if($(this).hasClass("select")){
				$("input[value="+val+"]").prop("checked",true);
			}else{
				$("input[value="+val+"]").prop("checked",false);
			}
		});
		
		$("body").find("#selectAll").on("click",function(){
			selectAll(this.checked);
			roleChooseShow()
		});

		$("body").find("#keyWord").on("keydown",function(){
			if (event.keyCode == 13) {
				$(this).siblings("#search_btn").trigger("click");
				return false;
			}
		});

	})
</script>
<title>Insert title here</title>
</head>
<body>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="role_tipsStyle">{*[core.sysconfig.km.role.config.tips]*}</div>
	<form action="saveConfig.action" method="post" class="kmRole">
	<input type="hidden" name='domainId' value='<%=request.getParameter("domainId")%>'/>&nbsp;&nbsp;
	<div class="handle">
		<s:if test='null!=params.getParameterAsString("domainId")'>	
		<div class="search_left">
   			<select id="departmentId" name="departmentId" style="width: 100px" class="form-control">
   				<option value="" style="color:#ccc;">{*[Department]*}</option>
   				<s:iterator value="departments">
   				<s:if test="valid == 1">
  						<option value="<s:property value="id"/>" <s:if test='id==params.getParameterAsString("deptId")'> selected="selected" </s:if>><s:property value="name"/></option>
  					</s:if>
  				</s:iterator>
  			</select>
		</div>
		</s:if>
		<div class="chooseCheck">
			<s:iterator value="datas.datas">
				<input type="checkbox" name="_kmRoleSelectItem" value="<s:property value="id" />"/>
			</s:iterator>
	    </div>
		<div class="chooseRole btn-group">
			<s:iterator value="datas.datas">
				<a class="btn btn-default" _id="<s:property value="id" />">{*[<s:property value="name" />]*}</a>
			</s:iterator>
		</div>
		<s:if test='null!=params.getParameterAsString("domainId")'>	
		<div class="seacch_right">
			<div class="input-group">
		      <input class="form-control" name="keyword" id="keyword" type="text" placeholder="{*[Name]*}和{*[Account]*}">
		      <button type="button" class="justForHelp btn btn-search" id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}" type="button" onclick="userlist(jQuery('#keyword').val(),jQuery('#departmentId').val());">{*[Query]*}</button>
		    </div>
		</div>
		</s:if>
	</div>
	
	
	<div class="moduleSpace" style="display:none;">
		<fieldset>
			<legend>{*[core.sysconfig.km.role.config.domain.select]*}</legend>
			<select onchange="loadUserByDomainId(this.value);">
				<option value="0">--{*[core.sysconfig.km.role.config.select]*}--</option>
				<s:iterator value="domains">
				<s:if test='id==params.getParameterAsString("domainId")'>
				<option value="<s:property value="id"/>" selected="selected"><s:property value="name"/></option>
				</s:if>
				<s:else>
				<option value="<s:property value="id"/>"><s:property value="name"/></option>
				</s:else>
				</s:iterator>
			</select>
			<span class="tipsStyle">（{*[core.sysconfig.km.role.config.tips]*}）</span>
		</fieldset>
	</div>
	
	<!-- 用户列表 -->
	<div id="contentTable" class="moduleSpace">
	<table class="list-table" border="0" cellpadding="2" cellspacing="2"
		width="100%">
		<tr class="dtable-header">
			<td class="column-head" scope="col"><input id="selectAll" type="checkbox"></td>
			<td class="column-head" scope="col" style="width:154px;text-align:center;"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="loginno"
				css="ordertag">{*[Account]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="email"
				css="ordertag">{*[Email]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="telephone"
				css="ordertag">{*[Mobile]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="departments"
				css="ordertag">{*[Department]*}</o:OrderTag></td>
		</tr>
		<s:iterator value="users" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-tr table-text">
			</s:if>
			<s:else>
				<tr class="table-tr table-text2">
			</s:else>
			<td class="table-td" style="text-align: center;">
				<input type="checkbox" name="_selects" onchange="roleChooseShow()" value="<s:property value="id"/>">
			</td>
			<td><span class="roleName"><s:property value="name" /></span></td>
			<td><s:property value="loginno" /></td>
			<td><s:property value="email" /></td>
			<td><s:property value="telephone"/></td>
			<td>
				<s:iterator value="departments">
					<s:property value="name" />
				</s:iterator>
			</td>
		</s:iterator>
	</table>
	</div>
	<div style="text-align:right;" class="moduleSpace">
		<input type="button" class="btn btn-default" value="{*[Cancel]*}" onclick="OBPM.dialog.doExit();"/>&nbsp;&nbsp;
		<input type="submit" class="btn btn-save" value="保存" onclick="return checkForm();"/>&nbsp;&nbsp;
	</div>
	</form>
	
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
</body>
</o:MultiLanguage>
</html>