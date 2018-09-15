<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<script type="text/javascript">
function authorizeW() {
	var _fileId = '<s:property value="_fileId" />';
	var _fileType = '<s:property value="_fileType" />';
	var url = '<s:url value="/km/permission/new.action"></s:url>';
	url+="?_fileType="+_fileType+"&_fileId="+_fileId;
	window.location.href = url;
}

function ev_edit(id){
	var _fileId = '<s:property value="_fileId" />';
	var _fileType = '<s:property value="_fileType" />';
	var url = '<s:url value="/km/permission/edit.action"></s:url>';
	url+="?id="+id;
	window.location.href = url;
}

function ev_remove(){
	var fieldid = document.getElementById("_fileId").value;
	var checkBlo = false;
	var checkboxs = document.getElementsByName("_selects");
	for(var i=0;i<checkboxs.length;i++){
		if(checkboxs[i].checked == true){
			checkBlo = true;
			break;
		}
	}
	if(checkBlo == false) {
		alert("{*[select_one_at_least]*}");
	}else{
		document.forms[0].action = '<s:url value="/km/permission/delete.action"/>';
		document.forms[0].submit();
	}
}


function reset(){
	jQuery("#_scope").attr("value","");
	jQuery("#_ownerName").attr("value","");
	jQuery("#_readOnly").attr("checked",false);
	jQuery("#_write").attr("checked",false);
	jQuery("#_download").attr("checked",false);
}

jQuery(document).ready(function(){
/* 	jQuery("#authorizeAdd").click(function(){
		authorizeW();
	}); */
	jQuery(".checkAll").click(function() {
		if(jQuery(this).attr("checked")=="checked") {
			jQuery(".select").attr("checked", "checked");
		} else {
			jQuery(".select").removeAttr("checked");
		}
	});
	
	jQuery(".delete").click(function () {
		jQuery(".select").attr("checked", false);
		jQuery(this).parent().parent().find("[name='_selects']").attr("checked", true);
		var fieldId = jQuery("#_fileId").val();
		var fileType = jQuery("#_fileType").val();
		document.forms[0].action = '<s:url value="/km/permission/delete.action"/>';
		document.forms[0].submit();
	});
	
	jQuery("#query").click(function () {
		var fieldId = jQuery("#_fileId").val();
		var scope  = jQuery("#_scope").val();
		var readOnly  = jQuery("#_readOnly").attr("checked") ? 1 : 0;
		var write  = jQuery("#_write").attr("checked") ? 1 : 0;
		var download  = jQuery("#_download").attr("checked") ? 1 : 0;
		var ownerName  = jQuery("#_ownerName").val();
		document.forms[0].action = '<s:url value="/km/permission/doQuery.action"/>'
				+ '?_scope=' + scope + '&_readOnly=' + readOnly
				+ '&_write=' + write+ '&_download='
				+ download+ '&_ownerName=' + ownerName;
		document.forms[0].submit();
	});
});
</script>
<style>
.authorizeTable{
	margin-bottom: 50px;
	margin-top: 50px;
	width:100%;
}

.authorizeTableTd1{
	width: 30%;
	text-align:right;
	padding-right:10px;
	height:30px;
}

.authorizeTableTd2{
	width: 60%;
	text-align:left;
}
#_readOnly,
#_write,
#_download{
	margin: 0;
    position: relative;
    top: 2px;
}
</style>
</head>
<body>
<div class="authorizeList" align="center">
		<div>
			<a>{*[cn.myapps.km.permission.authorization_list]*}</a>
			<button class="aLD" onclick="ev_remove();">{*[Delete]*}</button>
			<button id="authorizeAdd" onclick="authorizeW()">{*[cn.myapps.km.permission.add]*}</button>
		</div>
</div>
	<!-- 	授权对象:<input type="text"  style="width:45px;">
		权限:	<input type="text"  style="width:45px;">
		用户/角色名称:<input type="text"  style="width:45px;"> -->
	

<div style="width:100%;margin:0;padding:0;">
	<div style="float:left;">
		<span>
			{*[cn.myapps.km.permission.authorization_object]*}:
			<s:select id="_scope" name="_scope" value="params.getParameterAsString('_scope')" list="#{'user':'{*[User]*}','role':'{*[Role]*}','dept':'{*[Department]*}','deptAndrole':'{*[Department]*}+{*[Role]*}'}" listKey="key" listValue="value" cssClass="input-cmd" emptyOption="true" />
		</span>
		
		<span style="margin-left:15px;">
			{*[cn.myapps.km.permission.permissions]*}:
			<s:checkbox name="_readOnly" value='params.getParameterAsInteger(\"_readOnly\")==\"1\"' fieldValue="1" label="{*[cn.myapps.km.logs.read]*}" />
			<s:checkbox name="_write" value='params.getParameterAsInteger(\"_write\")==\"1\"' fieldValue="1" label="{*[修改]*}" /> 
			<s:checkbox name="_download" value='params.getParameterAsInteger(\"_download\")==\"1\"' fieldValue="1" label="{*[cn.myapps.km.disk.download]*}" /> 
		</span>
			
		<span style="margin-left:15px;">
			{*[cn.myapps.km.permission.name]*}:
			<input type="text" name="_ownerName" id="_ownerName" size="11" value='<s:property value="params.getParameterAsString('_ownerName')" />'></input>
		</span>
	</div>
	<table>
		<tr>
			<td>
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="queryicon icon16" href="###" id="query">{*[Query]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>
			</td>
			<td>
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a href="javascript:reset();" class="reseticon icon16" >{*[Reset]*}</a>
					</div>
					<div class="btn_right"></div>
				</div>
			</td>
		</tr>
	</table>
</div>	
<s:form theme="simple" action="list">
	<s:hidden id="_fileId" name="_fileId" />
	<s:hidden id="_fileType" name="_fileType" />
	<div class="authorizeList" align="center">
	
		<table>
			<tr>
				<td><input type="checkbox" name="checkAll" class="checkAll"/></td>
				<td class="authorizeLName" ><a>{*[cn.myapps.km.permission.authorization_object]*}</a></td>
				<!-- <td class="authorizeLName" ><a>{*[cn.myapps.km.permission.user_role_name]*}</a></td> -->
				<td class="authorizeLName"><a>{*[cn.myapps.km.permission.name]*}</a></td>
				<td class="authorizeLOther"><a>{*[cn.myapps.km.permission.permissions]*}</a></td>
				<td class="authorizeLOther" style="width:22%;text-align: center;"><a>{*[cn.myapps.km.permission.aging]*}</a></td>
				<td class="authorizeLOther"><a>{*[State]*}</a></td>
				<td class="authorizeLOther"><a>{*[Operate]*}</a></td>
			</tr>
			<s:iterator value="datas.datas" id="p">
			<tr>
				<td><input type="checkbox" class="select" name="_selects" value='<s:property value="id"/>' /></td>
				<td><a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')"><s:if test="scope==\"user\"">{*[User]*}</s:if><s:elseif test="scope==\"role\"">{*[Role]*}</s:elseif><s:elseif test="scope==\"dept\"">{*[部门]*}</s:elseif><s:elseif test="scope==\"deptAndrole\"">{*[部门+角色]*}</s:elseif></a></td>
				<td><a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')"><s:property value="ownerNames" /></a></td>
				<td>
					<a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')">
						<s:if test="#p.readMode==1 && #p.downloadMode==1 && #p.writeMode==1">
							{*[cn.myapps.km.permission.fullcontrol]*}
						</s:if>
						<s:elseif test="#p.readMode==-1 && #p.downloadMode==-1 && #p.writeMode==-1">
							{*[cn.myapps.km.permission.bannedaltogether]*}
						</s:elseif>
						<s:else>
							<s:if test="#p.readMode==1">
								{*[cn.myapps.km.permission.read]*}
							</s:if>
							<s:if test="#p.downloadMode==1">
								{*[cn.myapps.km.permission.download]*}
							</s:if>
							<s:if test="#p.writeMode==1">
								{*[Modify]*}
							</s:if>
						</s:else>
					</a>
				</td>
				<td style="text-align: center;">
					<a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')">
						<s:if test="#p.isTimeLimit()">
							{*[From]*}&nbsp<s:date name='#p.startDate' format='yyyy-MM-dd HH:mm'/>  &nbsp{*[cn.myapps.km.permission.to]*}&nbsp<s:date name='#p.endDate' format='yyyy-MM-dd HH:mm'/>
						</s:if>
						<s:else>
							{*[cn.myapps.km.permission.forever]*}
						</s:else>
					</a>
				</td>
				<td>
					<a style="cursor:pointer; " onclick="ev_edit('<s:property value="id"/>')">
						<s:if test="#p.isTimeAct()">
							{*[Effective]*}
						</s:if>
						<s:else>
							{*[cn.myapps.km.permission.invalid]*}
						</s:else>
					</a>
				</td>
				<td><a style="cursor:pointer;color:blue; "  class="delete">{*[Delete]*}</a></td>
			</tr>
			</s:iterator>
		</table>
	</div>
	</s:form>
</body>
</o:MultiLanguage></html>