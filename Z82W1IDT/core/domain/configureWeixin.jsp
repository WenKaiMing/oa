<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.constans.Environment"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微信端配置</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	cssListTable();
	binding();
});
</script>
<script type="text/javascript">

var domainId = '<s:property value="content.id" />';

function viewURL(applicationId) {

	var corpID = jQuery("[name='content.weixinCorpID']").val().trim();
	var serverHost = jQuery("[name='content.serverHost']").val().trim();
	var agentId = jQuery("tr#app_" + applicationId).find("#weixinAgentIdContent").html().trim();
	var weixinSecretContent = jQuery("tr#app_" + applicationId).find("#weixinSecretContent").html().trim();
	var weixinProxyType = jQuery("input[name='content.weixinProxyType']:checked").val();

	if(!corpID){
		alert('请先填写企业微信CorpID');
		return;
	}
	
	if(!serverHost){
		alert('请先填写外网访问系统地址');
		return;
	}
	
	if(!agentId){
		alert('请先填写对应软件的agentId');
		return;
	}
	
	if("EnterpriseWeChat" == weixinProxyType && !weixinSecretContent){
		alert('请先填写对应软件的Secret');
		return;
	}
	
	var url = contextPath + '/core/domain/getWeinxinURL.action?domain=' + domainId + '&applicationId=' + applicationId + '&corpID= ' + corpID + '&serverHost=' + serverHost;
	OBPM.dialog.show({
		opener:parent.parent.window,
		width: 700,
		height: 500,
		url: url,
		args: {},
		title: '{*[微信端配置]*}',
		close: function(rtn) {
		
		}
	});

}

function editWeixinAgentId(obj){
	var target = obj;
	var weixinAgentId = "";
	var applicationId = jQuery(obj).data("id");
	var value =  jQuery(obj).data("value");
	weixinAgentId = prompt("请输入微信应用AgentId","");
	if(weixinAgentId == null) return;
	if(weixinAgentId.length==0 || isNaN(weixinAgentId)){
		alert("微信应用AgentId必须为数字格式，请重试！");
		return;
	}
	var url = '<s:url value="/core/domain/updateWeixinAgentId.action"/>';
	jQuery.ajax({
		url: url,
		type: 'post',
		data: {"domainId":domainId,"applicationId":applicationId,"weixinAgentId":weixinAgentId},
		success: function(result){
			if(result=="success"){
				jQuery(target).parent().parent().find(".weixinAgentId").find("#weixinAgentIdContent").text(weixinAgentId);
			}else{
				alert("服务器发生异常:"+result);
			}
			
		}
	});
}

// 测试微信
function testwechat() {
	var CorpID = document.getElementById("CorpID").value;
	var CorpSecret = document.getElementById("CorpSecret").value;
	var ServerHost = document.getElementById("ServerHost").value;
	var url = '<s:url value="/core/domain/testWeChat.action"/>';
	jQuery.ajax({
	type:"POST", 
	url:url,  //当前页地址。发送请求的地址。
	data:"CorpID="+CorpID+"&CorpSecret="+CorpSecret+"&ServerHost="+ServerHost, //发送到服务器的数据。将自动转换为请求字符串格式。
	success:function(data){//请求成功后的回调函数。
		if(data == "success")
	    	alert("{*[cn.myapps.core.domain.success]*}!");
		else if(data == "error")
	    	alert("{*[cn.myapps.core.domain.failure]*}!");
		else if(data == "serverHostError")
			alert("外网访问系统地址格式不正确");
		else
			alert("{*[cn.myapps.core.domain.timedout]*}!");//Weixin server connection timed out.
		
	},
	
	
	
	error:function(){alert("{*[cn.myapps.core.domain.timedout]*}!");}
	});
}

function editWeixinSecret(obj){
	var target = obj;
	var weixinSecret = "";
	var applicationId = jQuery(obj).data("id");
	var value =  jQuery(obj).data("value");
	weixinSecret = prompt("请输入微信应用Secret","");
	if(weixinSecret == null) return;
	var url = '<s:url value="/core/domain/updateWeixinSecret.action"/>';
	jQuery.ajax({
		url: url,
		type: 'post',
		data: {"domainId":domainId,"applicationId":applicationId,"weixinSecret":weixinSecret},
		success: function(result){
			if(result=="success"){
				jQuery(target).parent().parent().find(".weixinSecret").find("#weixinSecretContent").text(weixinSecret);
			}else{
				alert("服务器发生异常:"+result);
			}
			
		}
	});
}
//微信企业号模块显示控制
function binding(value){
	if(!value){
		value = jQuery("input[name='content.weixinProxyType']:checked").val();
		if(!value){
			jQuery("input[name='content.weixinProxyType'][value='cloud']").attr("checked","checked");
			value = jQuery("input[name='content.weixinProxyType'][value='cloud']").val();
		}
	}
	jQuery(".secret-td").hide();
	jQuery("#weixinCorpIDBindBlock").hide();
	if(value=="local" || value == "EnterpriseWeChat") {
		jQuery("#synchronize2Weixin").show();
		jQuery("#synchronizeFromWeixin").show();
		jQuery("#weixinCorpIDBindBlock").show();
		jQuery("#main").show();
		if (value == "local") {
			document.getElementById("localLabel").style.display = '';
			document.getElementById("EnterpriseWeChatLabel").style.display = 'none';
			jQuery(".secret-td").hide();
		} else if (value == "EnterpriseWeChat") {
			document.getElementById("localLabel").style.display = 'none';
			document.getElementById("EnterpriseWeChatLabel").style.display = '';
			jQuery(".secret-td").show();
		}
	} else {
		jQuery("#synchronize2Weixin").hide();
		jQuery("#synchronizeFromWeixin").hide();
		jQuery("#main").hide();
	}
	if(value=="cloud"){
		document.getElementById("weixin_cloud_panel").style.display = '';
	}else{
		document.getElementById("weixin_cloud_panel").style.display = 'none';
	}
}

function synFromWeixin(){
	var domainId = document.getElementsByName('content.id')[0].value;
  	var url =  '<s:url action="synchFromWeixin"/>';
  	    url += "?domainId="+domainId;
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '同步结果',
			close: function(dataSource) {
			}
	});
}

function syn2Weixin(){
	var domainId = document.getElementsByName('content.id')[0].value;
	var url =  '<s:url action="synch2Weixin"/>';
	    url += "?domainId="+domainId;
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '同步结果',
			close: function(dataSource) {
			}
	});
}

function syn2Lanxin(){
	var domainId = document.getElementsByName('content.id')[0].value;
	var url =  '<s:url action="syn2Lanxin"/>';
	    url += "?domainId="+domainId;
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '同步结果',
			close: function(dataSource) {
			}
	});
}

function synFromLanxin(){
	var domainId = document.getElementsByName('content.id')[0].value;
	var url =  '<s:url action="synFromLanxin"/>';
	    url += "?domainId="+domainId;
	OBPM.dialog.show({
			opener:window.parent,
			width: 680,
			height: 460,
			url: url,
			args: {},
			title: '同步结果',
			close: function(dataSource) {
			}
	});
}

</script>
</head>
<body id="domain_application_list" class="listbody">
<%@include file="/common/msg.jsp"%>
<s:form id="domainForm" theme="simple">
	<input type="hidden" name="domain" value="<s:property value='content.id' />"/>
	<input type="hidden" name="content.id" value="<s:property value='content.id' />"/>
	<div id="contentActDiv">
		<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.main.domain_info]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<s:if test="synchronize == 'true'">
					<button type="button" id="synchronize" class="button-image" onclick="forms[0].action='<s:url action="synchLDAP"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[cn.myapps.core.domain.synchLDAP]*}</button>
					</s:if>
					<s:if test=" content.weixinCorpID !='' && content.weixinCorpSecret !=''">
					<button type="button" id="synchronize2Weixin" class="button-image" onclick="syn2Weixin();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[cn.myapps.core.domain.domaintowechat]*}</button>
					<button type="button" id="synchronizeFromWeixin" class="button-image" onclick="synFromWeixin();" ><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[cn.myapps.core.domain.wechattodomain]*}</button>
					</s:if>
					<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
					<s:if test="#dh.isLanxinEnable()">
					   <button type="button" id="btnPort" class="button-image" onclick="syn2Lanxin();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />同步组织架构至蓝信</button>
					   <button type="button" id="btnPort" class="button-image" onclick="synFromLanxin();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />从蓝信更新组织架构</button>
					</s:if>
					<button type="button" id="btnSave" class="button-image" onclick="forms[0].action='<s:url action="configureWeixin" />';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" />{*[Save]*}</button>
				</div>
			</td></tr>
		</table>
	</div>

	<fieldset>
		<legend>{*[cn.myapps.core.domain.wechatCorpIDBind]*}</legend>
		{*[cn.myapps.core.domain.wechatCorpIDShow]*}：
		<s:radio name="content.weixinProxyType" id="weixinProxyType" onclick="binding(this.value)" list="weixinProxyType"></s:radio>
		<table id="weixinCorpIDBindBlock" style="display:none" class="table_noborder id1" border="0">
			<tr id="localLabel">
				<td class="commFont"> <span style="color:red">*</span>{*[cn.myapps.core.domain.CorpID]*}：</td>
				<td class="commFont"> <span style="color:red">*</span>{*[cn.myapps.core.domain.AppSecret]*}：</td>
			</tr>
			<tr id="EnterpriseWeChatLabel">
				<td class="commFont"> <span style="color:red">*</span>{*[cn.myapps.core.domain.CorpID2]*}：</td>
				<td class="commFont"> <span style="color:red">*</span>{*[cn.myapps.core.domain.AppSecret2]*}：</td>
			</tr>
			<tr >
				<td class="commFont"><s:textfield cssClass="input-cmd" id="CorpID" name="content.weixinCorpID" /></td>
				<td class="commFont"><s:textarea cssClass="input-cmd" cols="43" rows="2" id="CorpSecret" name="content.weixinCorpSecret" /></td>
			</tr>
			<tr>
				<td class="commFont"> <span style="color:red">*</span>{*[cn.myapps.core.domain.DomainName]*}：(如:http://www.xxx.com/obpm)</td>
			</tr>
			<tr>
				<td>
				<s:textfield cssClass="input-cmd" placeholder="http://www.xxx.com/obpm" name="content.serverHost" id="ServerHost" />
				<button type="button" class="button-image" onClick="testwechat();">
						<img src="<s:url value="/resource/imgnew/act/act_0.gif"/>">{*[cn.myapps.core.domain.validation]*}
				</button>
				</td>
			</tr>
			<tr>
				<td>
				<s:hidden cssClass="input-cmd" name="content.weixinAgentId" value="0" />
				</td>
			</tr>
		</table>
		<table id="weixin_cloud_panel" style="display:none" class="table_noborder id1" border="0">
		<tr>
		<td ><a style="background: #008000;color: #fff;border: 1px solid #006900;padding: 3px 8px;margin-left: -10px;" href="http://yun.weioa365.com/weixin/main?siteId=<%=Environment.getMACAddress() %>&domainId=<s:property value='content.id'/>" target="_blank">{*[cn.myapps.core.domain.weixinProxyType.gotoCloud]*}</a></td>
		</tr>
		</table>
	</fieldset>
	<div id="main">
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[已启用的软件列表]*}</div>
			</td>
		</tr>
	</table>
		
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col">{*[cn.myapps.core.domain.holdApp.application_name]*}</td>
					<td class="column-head" scope="col">{*[Description]*}</td>
					<td class="column-head" scope="col"><span style="color:red">*</span>{*[微信应用AgentId]*}</td>
					<td class="column-head secret-td" scope="col"><span style="color:red">*</span>{*[微信应用Secret]*}</td>
					<td class="column-head" scope="col">{*[微信菜单跳转链接]*}</td>
				</tr>
				<s:iterator value="applications" status="index">
					<tr id='app_<s:property value="id" />'>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td><s:property value="name" /></td>
					<td><s:property value="description.length()>40?description.substring(0,40)+'...':description" /></td>
					<td class="weixinAgentId">
					<a href="#" data-id="<s:property value='id' />" data-name="<s:property value='name' />" data-value="<s:property value='weixinAgentId' />" onclick="editWeixinAgentId(this)" ><img title="编辑微信应用AgentId" src="<s:url value="/resource/imgnew/act/act_7.gif"/>"></a>
					<span id="weixinAgentIdContent" >
						<s:property value="weixinAgentId" />
					</span>
					</td>
					<td class="weixinSecret secret-td">
					<a class="secret-td" href="#" data-id="<s:property value='id' />" data-name="<s:property value='name' />" data-value="<s:property value='weixinSecret' />" onclick="editWeixinSecret(this)" ><img title="编辑微信应用Secret" src="<s:url value="/resource/imgnew/act/act_7.gif"/>"></a>
					<span id="weixinSecretContent" >
						<s:property value="weixinSecret" />
					</span>
					</td>
					<td><a id="weixin-url" onclick="viewURL('<s:property value="id" />')">生成跳转链接</a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>