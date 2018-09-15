<%@page import="cn.myapps.constans.Environment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String contextPath=request.getContextPath();
%>
<html>
<o:MultiLanguage>
<head>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>{*[cn.myapps.core.main.domain_info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script>

	//loading show
	function dy_lock() {
		var loadingDiv = document.getElementById('loadingDiv');
		var loadingDivBack = document.getElementById('loadingDivBack');
		if(loadingDiv)	loadingDiv.style.display = '';
		if(loadingDivBack)	loadingDivBack.style.display = '';
	}
	function doExit(){
		var url = '<s:url action="findManager"><s:param name="t_users.id" value="#session.USER.id" /></s:url>';
		if (parent) {
			// use prototype1.6	
			var params = decodeURIComponent(jQuery("form").serialize());
			
			url += "&" + params;
			parent.location = url;
		} else {
			forms[0].action = url;
			forms[0].submit();
		}
	}
	function changeSkinType(value){
		document.getElementById("skinTypePerview").innerHTML="<img height='100px' width='200px' src='../../resource/images/preview/preview-" + value + ".png' />";
	}
	
	jQuery(document).ready(function(){
		var uskin='<s:property value="content.skinType" />';
		var obj = jQuery("#skinType").children();
		for(var i=0;i<obj.length;i++){
			if(obj[i].value==uskin){
				obj[i].selected='ture';
				var thisSkinType = jQuery("#skinType").val();
				changeSkinType(thisSkinType);
			}
		}
		//回选Logo
		var logo = document.getElementById("logo").value
		if(logo){
			document.getElementById("_iconImg").src ='<s:url value="/lib/icon/" />'+logo;
		}else{
			document.getElementById("_iconImg").style.display = 'none';
		}		
		window.top.toThisHelpPage("domain_info");
	});
	
	function testSMS(){
		var telephone = prompt("{*[cn.myapps.core.domain.page.tips.input_telephone]*}","");
		if(telephone.length!=11){
			alert("{*[cn.myapps.core.domain.page.tips.invalid_telephone]*}");
			return;
		}
		var url = '<s:url value="/core/domain/testSMS.action"/>';
		url+="?_telephone="+telephone;
		jQuery.ajax({
			url: url,
			type: 'post',
			data: jQuery("[name='domainForm']").serialize(),
			success: function(result){
				if(result && result.length>0){
					var msg = JSON.parse(result);
					if(msg.type=="invalid"){
						alert("{*[cn.myapps.core.domain.page.tips.invalid_sms_account]*}");
					}else if(msg.type=="insufficient"){
						alert("{*[cn.myapps.core.domain.page.tips.insufficient_sms]*}");
					}else if(msg.type=="connectionFailed"){
						alert("{*[cn.myapps.core.domain.page.tips.connect_sms_server_failed]*}");
					}else if(msg.type=="success"){
						alert("{*[Success]*}");
					}else if(msg.type=="failed"){
						alert("{*[core.shortmessage.failure]*}");
					}
				}
				
			}
		});
		
	}
	function selectIcon(){
		  var url = contextPath + '/core/resource/iconLib.jsp' ;
		  OBPM.dialog.show({
				opener:window.parent.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[Select]*}{*[Icon]*}',
				close: function(rtn) {
					if (rtn != null && rtn != '') {
						document.getElementById("_iconImg").style.display = '';
						document.getElementById("logo").value=rtn;
						document.getElementById("_iconImg").src ='<s:url value="/lib/icon/" />'+rtn;
					}
				 	
				}
			});
		}

	function cleanIcon(){
		document.getElementById("_iconImg").style.display = 'none';
		document.getElementById("logo").value='';
	}

	function testwechat()
		{
			var CorpID = document.getElementById("CorpID").value;
			var CorpSecret = document.getElementById("CorpSecret").value;
			var url = '<s:url value="/core/domain/testWeChat.action"/>';
			jQuery.ajax({
			type:"POST", 
			url:url,  //当前页地址。发送请求的地址。
			data:"CorpID="+CorpID+"&CorpSecret="+CorpSecret, //发送到服务器的数据。将自动转换为请求字符串格式。
			success:function(data){//请求成功后的回调函数。
				if(data == "success")
			    	alert("{*[cn.myapps.core.domain.success]*}!");
				else if(data == "error")
			    	alert("{*[cn.myapps.core.domain.failure]*}!");
				else
					alert("{*[cn.myapps.core.domain.timedout]*}!");//Weixin server connection timed out.
			},
			
			
			
			error:function(){alert("{*[cn.myapps.core.domain.timedout]*}!");}
			});
		}
	
	function doExcelInput(){
		var url = contextPath + '/core/domain/importbyid.jsp';
		
		
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 780,
			height: 560,
			url: url,
			title: "EXCEL用户导入",
			args : {domain:domainId},
			close: function(result){
			}
		});
	}
	
	function doExcel(){
		var url = contextPath + '/core/domain/excel.jsp';
		
		var domainId = document.getElementsByName('content.id')[0].value;
		
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 780,
			height: 560,
			url: url,
			title: "EXCEL用户导入导出",
			args : {domain:domainId},
			close: function(result){
			}
		});
	}
	
</script>
</head>
<body id="domain_info" class="contentBody">
<s:form id="domainForm" action="save" method="post" theme="simple">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_users.loginno" value="%{#parameters['sm_users.loginno']}"/>
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
						<button type="button" id="btnPort" class="button-image" onclick="doExcel();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[User]*}{*[Import]*}/{*[Export]*}</button>
						<button type="button" id="btnSave" class="button-image" onclick="forms[0].action='<s:url action="saveBasic" />';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>" />{*[Save]*}</button>
						<button type="button" class="button-image" onclick="doExit();"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>" />{*[Exit]*}</button>
					</div>
				</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/basic.jsp" %>
		<s:hidden name="content.id" />
		<s:hidden name="content.sortId" />
		<s:hidden name="content.weixinAgentId" value="0" />
		<s:hidden name="content.weixinConfigJson" />
		<s:hidden name="content.systemModuleConfigJson" />
		<s:hidden name="content.weixinProxyType" />
		<s:hidden name="content.weixinCorpID" />
		<s:hidden name="content.weixinCorpSecret" />
		<s:hidden name="content.serverHost" />
		<s:hidden name="content.weixinEncodingAESKey" />
		<fieldset>
		<legend>{*[cn.myapps.core.domain.basicset]*}</legend>
		
		<table class="table_noborder id1" border="0">
			<tr>
				<td class="commFont">{*[cn.myapps.core.domain.label.name]*}：</td>
				<td class="commFont">{*[cn.myapps.core.domain.select_skin]*}：</td>
			</tr>
			<tr>
				<td><s:textfield cssClass="input-cmd" name="content.name" /></td>
				<td>
					<select class="input-cmd" id="skinType" name="content.skinType" onchange="changeSkinType(this.value)">
						<%
							DomainHelper domainH=new DomainHelper();
							Map skinType=(Map)domainH.querySkinTypes(null);
							for(Iterator iter=skinType.keySet().iterator();iter.hasNext();){
								String skin=(String)iter.next();
								//cool皮肤先屏蔽，等拿掉再删
								if(!"phone".equals(skin) && !"cool".equals(skin)){
							%>
								<option name="content.userSetup.userSkin" value="<%=skin %>" />{*[<%=skin %>]*}</option>																			
							<%	}
							}
						%>
					</select>
				</td>
			</tr>
	
		<tr>
			<td class="commFont">{*[cn.myapps.core.domain.system_name]*}:</td>
			<td class="commFont">{*[cn.myapps.core.domain.skin_preview]*}：</td>
		</tr>
		<tr>
			<td class="justForHelp" id="name_td" title="{*[cn.myapps.core.domain.label.name]*}" pid="main">
				<s:textfield cssClass="input-cmd" id="systemName" name="content.systemName" />
			</td>
			<td rowspan="5">
				<div id="skinTypePerview" title="{*[cn.myapps.core.domain.skin_preview]*}"></div>
			</td>
		</tr>
			<tr>
				<td class="commFont" >{*[cn.myapps.core.domain.SMS_member_code]*}：<span><a href="http://sms.teemlink.com/sms/register/register.jsp" target="_blank">[{*[cn.myapps.core.domain.page.label.no_account]*}]</a></span></td>
			</tr>
			<tr>
				<td id="smsMemberCode" class="justForHelp" title="{*[cn.myapps.core.domain.SMS_member_code]*}" pid="main" >
					<s:textfield cssClass="input-cmd" name="content.smsMemberCode" /></td>
			</tr>
			<tr>
				<td class="commFont" >{*[cn.myapps.core.domain.SMS_member_pwd]*}：<span><a href="http://sms.teemlink.com/sms/" target="_blank">[{*[cn.myapps.core.domain.page.label.change_password]*}]</a></span></td>
			</tr>
			<tr>
				<td id="_password" class="justForHelp" pid="main" ><s:password cssClass="input-cmd" name="_password" showPassword="true" />  
					<button type="button" class="button-image" onClick="testSMS();">
						<img src="<s:url value="/resource/imgnew/act/act_0.gif"/>">{*[cn.myapps.core.domain.page.label.test_sms]*}
					</button> 
				</td>
			</tr>
		<tr>
			<td class="commFont">{*[Description]*}：</td>
			<td class="commFont">Logo(60 x 60):</td>
		</tr>
		<tr>
			<td id="description" class="justForHelp" title="{*[Description]*}" pid="main" ><s:textarea cssClass="input-cmd" cols="43" rows="2"
					label="{*[Description]*}" name="content.description" /></td>
			<td rowspan="2" align="left" class="commFont">
			<s:hidden id="logo" name="content.logoUrl"/>
			<img id="_iconImg" alt="" src=''>
				<input type="button" class="button-cmd" onclick="selectIcon()" value="{*[Select]*}"/>
				<input type="button" class="button-cmd" onclick="cleanIcon()" value="{*[Clear]*}"/>
			</td>
		</tr>
			<tr>
				<td class="commFont">{*[Status]*}：</td>
			</tr>
			<tr>
				<td>
				<s:radio label="{*[Status]*}" name="_strstatus" theme="simple"	list="#{'true':'{*[Enable]*}','false':'{*[Disable]*}'}" /></td>
			</tr>
		</table>
		</fieldset>
	</div>
	<div id="loadingDiv"
		style="position: absolute; z-index: 100; width: 60%; height: 60%; left: 40%; top: 40%; display: none;">
	<table>
		<tr>
			<td><img src='<s:url value="/resource/imgnew/loading.gif"/>'></td>
			<td><b><font size='3'>数据同步中...</font> </b></td>
		</tr>
	</table>
	</div>
	<div id="loadingDivBack"
		style="position: absolute; z-index: 50; width: 104%; height: 100%; top: 0px; left: 0px; display: none; background-color:#DED8D8; filter: alpha(opacity = 20); opacity: 0.20;">
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
