<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp" %>
<%@ page import="cn.myapps.constans.Environment"%>

<%
String contextPath = request.getContextPath();
String applicationid = request.getParameter("content.applicationid");
if (applicationid == null) {
	applicationid = request.getParameter("id");
}

//枚举常用jndi上下文工厂类
java.util.HashMap contextFactoryMap = new java.util.LinkedHashMap();
contextFactoryMap.put("org.jnp.interfaces.NamingContextFactory", "org.jnp.interfaces.NamingContextFactory");
contextFactoryMap.put("weblogic.jndi.WLInitialContextFactory", "weblogic.jndi.WLInitialContextFactory");
contextFactoryMap.put("com.apusic.jndi.InitialContextFactory", "com.apusic.jndi.InitialContextFactory");
contextFactoryMap.put("com.ibm.websphere.naming.WsnInitialContextFactory", "com.ibm.websphere.naming.WsnInitialContextFactory");
contextFactoryMap.put("com.sun.jndi.cosnaming.CNCtxFactory", "com.sun.jndi.cosnaming.CNCtxFactory");
contextFactoryMap.put("com.sssw.rt.jndi.AgInitCtxFactory", "com.sssw.rt.jndi.AgInitCtxFactory");
contextFactoryMap.put("com.evermind.server.rmi.RMIInitialContextFactory", "com.evermind.server.rmi.RMIInitialContextFactory");
request.setAttribute("contextFactoryList", contextFactoryMap);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[DataSource]*}</title>
<script src='<s:url value="/dwr/interface/ApplicationHelper.js"/>'></script>
</head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
	
<script type="text/javascript">
var applicationid ='<%=applicationid %>';
function ev_dbtypechange(type) {
	var dbdriver = document.getElementById("driver");
	var dburl = document.getElementById("url");
	
	if (type==1){
		dbdriver.value = "oracle.jdbc.driver.OracleDriver";
		dburl.value = "jdbc:oracle:thin:@<server>:1521:<database_name>";
	}
	else if (type==2){
		dbdriver.value = "net.sourceforge.jtds.jdbc.Driver";
		dburl.value = "jdbc:jtds:sqlserver://<hostname>:1433/<dbname>";
	}
	else if (type==3){
		dbdriver.value = "com.ibm.db2.jcc.DB2Driver";
		dburl.value = "jdbc:db2://<hostname>:50000/<dbname>";
	}
	else if (type==4){
		dbdriver.value = "com.mysql.jdbc.Driver";
		dburl.value = "jdbc:mysql://<hostname>:3307/<dbname>?useUnicode=true&characterEncoding=utf8&useSSL=false";
	}
	else if (type==5){
		dbdriver.value = "org.hsqldb.jdbcDriver";
		dburl.value = "jdbc:hsqldb:hsql://<hostname>:9001/<dbname>";
	}
}

function ev_jndidbtypechange(type) {
	document.getElementsByName("content.dbType")[0].value=type;
}

function ev_usetypechange(type) {
	jQuery(".showcontent").attr("class","hidecontent");	
	if (type=="JDBC") {
		jQuery("#cjdbc").attr("class","showcontent");	
	} else if (type=="JNDI") {
		jQuery("#cjndi").attr("class","showcontent");	
	}
}

function clearJdbcInfo() {
	document.getElementsByName("content.dbType")[0].value="";
	document.getElementsByName("content.driverClass")[0].value="";
	document.getElementsByName("content.url")[0].value="";
	document.getElementsByName("content.username")[0].value="";
	document.getElementsByName("content.password")[0].value="";
	document.getElementsByName("content.poolsize")[0].value="";
	document.getElementsByName("content.timeout")[0].value="";
}

function clearJndiInfo() {
	document.getElementsByName("content.jndiName")[0].value="";
	document.getElementsByName("jndiDBType")[0].value="";
	document.getElementsByName("content.initialContextFactory")[0].value="";
	document.getElementsByName("content.urlPkgPrefixes")[0].value="";
	document.getElementsByName("content.providerUrl")[0].value="";
	document.getElementsByName("content.securityPrincipal")[0].value="";
	document.getElementsByName("content.securityCredentials")[0].value="";
}

function ev_factorychange(factory) {
	var providerUrl = document.getElementById("provider_url");
	if (factory=="org.jnp.interfaces.NamingContextFactory") {
		providerUrl.value = "jnp://localhost:1099";
	} else if (factory=="weblogic.jndi.WLInitialContextFactory") {
		providerUrl.value = "t3://localhost:7001";
	} else if (factory=="com.apusic.jndi.InitialContextFactory") {
		providerUrl.value = "rmi://localhost:6888";
	} else if (factory=="com.ibm.websphere.naming.WsnInitialContextFactory") {
		providerUrl.value = "iiop://localhost:900";
	} else if (factory=="com.sun.jndi.cosnaming.CNCtxFactory") {
		providerUrl.value = "iiop://localhost:1050";
	} else if (factory=="com.sssw.rt.jndi.AgInitCtxFactory") {
		providerUrl.value = "sssw://localhost:80";
	} else if (factory=="com.evermind.server.rmi.RMIInitialContextFactory") {
		providerUrl.value = "ormi://localhost";
	} 	
}

function IsDigit(){
	return ((event.keyCode>=48)&&(event.keyCode<=57));
}

function test() {
	var useType = document.getElementsByName("content.useType")[0].value;
	if (useType=="JDBC") {
		var dbdriver = document.getElementsByName("content.driverClass")[0].value;
		var dburl = document.getElementsByName("content.url")[0].value;
		var dbusername = document.getElementsByName("content.username")[0].value;
		var dbpassword = document.getElementsByName("content.password")[0].value;
		
		ApplicationHelper.testDB(dbusername,dbpassword,dbdriver,dburl, function(msg){
			alert(msg);
		});
	} else if (useType=="JNDI") {
		var jndiName = document.getElementsByName("content.jndiName")[0].value;
		if (jndiName==null || jndiName=="") {
			alert("JNDI{*[Name]*}不能为空！");
		} else {
			var contextFactory = document.getElementsByName("content.initialContextFactory")[0].value;
			var providerUrl = document.getElementsByName("content.providerUrl")[0].value;
			var urlPkg = document.getElementsByName("content.urlPkgPrefixes")[0].value;
			var securityPrincipal = document.getElementsByName("content.securityPrincipal")[0].value;
			var securityCredentials = document.getElementsByName("content.securityCredentials")[0].value;
			
			ApplicationHelper.testJNDI(jndiName, contextFactory, urlPkg, providerUrl, securityPrincipal, securityCredentials, function(msg){
				alert(msg);
			});
		}
	}
	
	
}

/**
 * 2.6新增的设置退出按钮是否显示
 * 目的：2.6新增的元数据管理需要引进这个页面,为了减少重复代码,在此引进此方法用于判断
 * 是否显示该按钮,此操作不会影响旧版本
 */
function init_ExitButton(){
	var noNeedExit = '<s:property value="#parameters.noNeedExit"/>';
	if(noNeedExit == null || noNeedExit == false || noNeedExit == ''){
		jQuery("#exit").attr("style", "display:''");
	}else{
		//元数据管理退出按钮，since 磐石版
		jQuery("#metadataMgrExit").attr("style", "display:''");
	}
}

function doSave(){
	var useType = jQuery("#usetype").val();
	if(document.getElementsByName("content.name")[0].value == ""){
		alert("名称不能为空！");
		return false;
	}
	if(document.getElementsByName("content.dbType")[0].value == 0){
		alert("数据库类型不能为空，请选择！");
		return false;
	}
	if (useType=="JDBC") {
		clearJndiInfo();
	} else if (useType=="JNDI") {
		var jndiName = document.getElementsByName("content.jndiName")[0].value;
		if (jndiName==null || jndiName=="") {
			alert("JNDI{*[Name]*}不能为空！");
			return;
		}else{
			clearJdbcInfo();
			document.getElementsByName("content.dbType")[0].value = document.getElementsByName("jndiDBType")[0].value	
		}
	}
	var form = document.forms[0];
	form.action = '<s:url value="/core/dynaform/dts/datasource/saveDataSource.action"/>?operation=save';
	form.submit();
}

//标准版隐藏mysql外的其他数据源选项
function checkVersion(){
	var licenseType = "<%=Environment.licenseType%>";	//如：S.标准版
	if(licenseType.indexOf("S") != -1){
		jQuery("#formItem_content_dbType").children().each(function(){
			if(jQuery(this).val() != 4){
				jQuery(this).remove();
			}else{
				var name = document.getElementsByName("content.name")[0];
				if(name && name.value == ""){
					ev_dbtypechange(jQuery(this).val());
				}
			}
		});
	}
}

jQuery(window).resize(function(){
	adjustUserSetupPageLayout();
});


jQuery(document).ready(function(){
	init_ExitButton();
	window.top.toThisHelpPage("application_info_advancedTools_dataSource_info");
	var useType = jQuery("#usetype").val();
	jQuery(".showcontent").attr("class","hidecontent");
	if (useType=="JDBC") {
		jQuery("#cjdbc").attr("class", "showcontent");
	} else if (useType=="JNDI") {
		jQuery("#cjndi").attr("class", "showcontent");
	}
	
	if('<s:property value="%{#parameters.parent}"/>' == 'datasource' && 
			'<s:property value="%{#parameters.refresh}"/>' == 'true' && 
			'<s:property value="%{#parameters.operation}"/>' == 'save'){
		parent.refresh();
	}
	checkVersion();
});

function doIndexManager(){
	var url = contextPath + "/core/dynaform/dts/metadata/list.action";
	url += "?datasourceId="+document.getElementsByName("content.id")[0].value;
	OBPM.dialog.show({
		width: 800,
		height: 540,
		url: url,
		args: {},
		title: '{*[core.dts.metadata.indexmanager]*}',
		close: function() {
					
		}
});
	
}

function exit(){
	//退出元数据管理，since 磐石版
	var url = '<s:url value="/core/dynaform/dts/metadata/metadataManager.jsp"/>?id='+applicationid+'&mode=application&tab=3&selected=btnMetadataMgr';
	window.parent.location.href = url;
}

</script>
<style>
	.contentTop {
		width: 100%;
		margin-top: 10px;
		border-style: solid;
		border-width: 1px;
		border-color: #f5f5f5;
	}
	
	
	.contentCenter {
		width: 100%;
		margin-top: 10px;
		border-style: solid;
		border-width: 1px;
		border-color: #f5f5f5;
	}
	
	.showcontent {
	    display: inline;
	}
	
	.hidecontent {
		display: none;
	}
	.fieldgroup {
		border: 1px solid  #f5f5f5;
	}
</style>
<body id="bodyid" class="contentBody" style="overflow: hidden;">
	<div id="contentActDiv">
		<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[DataSource]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
				<s:if test="#parameters._comefrom != null">
					<button type="button" class="button-image"
						onClick="doIndexManager();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[core.dts.metadata.indexmanager]*}</button>
				</s:if>
					<button type="button" class="button-image" onClick="test();">
						<img src="<s:url value="/resource/imgnew/act/act_0.gif"/>">{*[cn.myapps.core.deploy.application.test_db]*}
					</button>
					<button type="button" class="button-image" onClick="doSave();">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
					</button>
					<button type="button" id="exit" class="button-image" style="display:none;" onClick="forms[1].action='<s:url action="listAllDts"></s:url>';forms[1].submit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
					<button type="button" id="metadataMgrExit" class="button-image" style="display:none;" onClick="exit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
		<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<s:form id="formItem" theme="simple" action="saveDataSource" method="post">
			<s:textfield name="tab" cssStyle="display:none;" value="3" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnDataSource'}" />
			<s:hidden name="content.id" />
			<s:hidden name="content.sortId" />
			<s:hidden name="content.applicationid" />
			<s:hidden name="id" value="%{#parameters.id}" />
			<s:hidden name="application" value="%{#parameters.application}" />
			<s:hidden name="_currpage" value="%{#parameters._currpage}" />
			<s:hidden name="_pagelines" value="%{#parameters._pagelines}" />
			<s:hidden name="_rowcount" value="%{#parameters._rowcount}" />
			<!-- 2.6版本增加 -->
			<s:hidden name="noNeedExit" value="%{#parameters.noNeedExit}"/>
			<s:hidden name="parent" value="%{#parameters.parent}"/>
			<s:hidden name="refresh" value="%{#parameters.refresh}"/>
			
			
			<div id="contentTop" class="contentTop" >
				<table class="id1" width="100%">
					<tr>
						<td class="commFont">{*[Name]*}:</td>
						<td class="commFont">{*[cn.myapps.core.deploy.application.use_type]*}:</td>
					</tr>
					<tr>		
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.name" size="50" /></td>
						<td><s:select id="usetype" name="content.useType" cssClass="input-cmd"
							theme="simple" list="_typelist" onchange="ev_usetypechange(this.value)" ></s:select>
						</td>
					</tr>
				</table>	
			</div>
		
			<div id="contentCenter" class="contentCenter">
				<!-- JDBC配置 -->
				<div id="cjdbc" class="showcontent">
					<table class="id1" width="100%">
					<tr>
						<td class="commFont">{*[cn.myapps.core.deploy.application.database_type]*}:</td>
						<td class="commFont">{*[cn.myapps.core.deploy.application.user_name]*}:</td>
					</tr>
					<tr>		
						<td><s:select name="content.dbType" cssClass="input-cmd"
							theme="simple" list="_dblist" onchange="ev_dbtypechange(this.value)"></s:select>
						</td>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.username" size="50" /></td>
					</tr>
					<tr class="seperate">
						<td class="commFont">{*[DriverClass]*}:</td>
						<td class="commFont">{*[Password]*}:</td>
					</tr>
					<tr>
						<td><s:textfield cssClass="input-cmd" theme="simple" name="content.driverClass" size="50" id="driver" /></td>
						<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.password" size="50" /></td>
					</tr>
					<tr class="seperate">
						<td class="commFont">{*[URL]*}:</td>
						<td class="commFont">{*[DB_PoolSize]*}:</td>
					</tr>
					<tr>		
						<td><s:textfield cssClass="input-cmd" theme="simple" name="content.url" size="50" id="url" /></td>
						<td align="left"><s:textfield  cssClass="input-cmd" theme="simple" 
							name="content.poolsize" onkeypress="event.returnValue=IsDigit();"/>
						</td>
					</tr>
					<tr class="seperate">
						<td class="commFont">{*[DB_Timeout]*}:</td>
					</tr>
					<tr>
						<td align="left" ><s:textfield  cssClass="input-cmd" theme="simple" 
							name="content.timeout" onkeypress="event.returnValue=IsDigit();"/>
						</td>
					</tr>
					</table>
				</div>
				
				<!-- JNDI配置 -->
				<div id="cjndi" class="hidecontent">
					<table class="id1" width="100%">
						<tr class="seperate">
							<td class="commFont" style="width:40px;">JNDI{*[Name]*}:</td>
							<td class="commFont">{*[cn.myapps.core.deploy.application.database_type]*}:</td>
						</tr>
						<tr>
							<td><s:textfield cssClass="input-cmd" theme="simple"
							name="content.jndiName" size="50" /></td>
							<td><s:select id="jndiDBType" name="jndiDBType" cssClass="input-cmd"
							theme="simple" list="_dblist" onchange="ev_jndidbtypechange(this.value)" value="content.dbType"></s:select>
						</td>
						</tr>
					</table>
					
					<fieldset class="fieldgroup">
    					<legend>上下文</legend>
    					<table class="id1" width="100%">
							<tr class="seperate">
								<td class="commFont" style="width:40px; text-align:left;">INITIAL_CONTEXT_FACTORY:</td>
								<td><s:select name="content.initialContextFactory" cssClass="input-cmd"
							theme="simple" list="#request.contextFactoryList" headerKey="" headerValue="" onchange="ev_factorychange(this.value)"></s:select></td>
							</tr>
							<tr class="seperate">
								<td class="commFont" style="width:40px; text-align:left;">URL_PKG_PREFIXES:</td>
								<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.urlPkgPrefixes"/></td>
							</tr>
							<tr class="seperate">
								<td class="commFont" style="width:40px;text-align:left;">PROVIDER_URL:</td>
								<td><s:textfield id="provider_url" cssClass="input-cmd" theme="simple"
								name="content.providerUrl"/></td>
							</tr>
							<tr class="seperate">
								<td class="commFont" style="width:40px;text-align:left;">SECURITY_PRINCIPAL:</td>
								<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.securityPrincipal"/></td>
							</tr>
							<tr class="seperate">
								<td class="commFont" style="width:40px;text-align:left;">SECURITY_CREDENTIALS:</td>
								<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.securityCredentials"/></td>
							</tr>
						</table>
    				</fieldset>	
				</div>
			</div>
		</s:form>
		<form action="" method="post">
			<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
			<%@include file="/common/page.jsp"%>
		</form>
	</div>
</body>
</o:MultiLanguage>
</html>