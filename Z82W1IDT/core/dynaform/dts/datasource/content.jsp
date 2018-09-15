<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.constans.Environment"%>

<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<title>{*[DataSource]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src="<s:url value='/dwr/interface/ApplicationHelper.js'/>"></script>
<script language="javaScript">
	var contextPath = '<%=contextPath%>';
	
	function selectField(actionName,field){
	  wx = '300px' ;
	  wy = '400px' ;
	  
	  var url = contextPath + '/core/commoninfo/'+ actionName +'.action';
	  if (field != '' && field != null) {
	  	url = url + '?field=' + field;
	  }
	 //alert("url->" + url);
	  
	  var rtn = showframe('{*[Select]*}', url);
	 
	  if (rtn == null || rtn == 'undefined'){
	  }else if(rtn =='') {
	    var formfield = eval("formItem.elements['content."+field+"']");
		  formfield.value = '';
	  }else{
	    var formfield = eval("formItem.elements['content."+field+"']");
	    formfield.value = rtn;
	  }
	  
}

	function ev_dbtypechange(type) {
		if (type) {
			var dbdriver = document.getElementsByName("content.driverClass")[0];
			var dburl = document.getElementsByName("content.url")[0];
			
			if (type==1){
				dbdriver.value = "oracle.jdbc.driver.OracleDriver";
				dburl.value = "jdbc:oracle:thin:@<server>:1521:<database_name>";
			}
			else if (type==2){
				dbdriver.value = "net.sourceforge.jtds.jdbc.Driver";
				dburl.value = "jdbc:jtds:sqlserver://<hostname>:1433/<dbname>";
			}
			else if (type==5){
				dbdriver.value = "org.hsqldb.jdbcDriver";
				dburl.value = "jdbc:hsqldb:hsql://<hostname>:9001/<dbname>";
			}
			else if (type==4){
				dbdriver.value = "com.mysql.jdbc.Driver";
				dburl.value = "jdbc:mysql://<hostname>:3306/<dbname>?useUnicode=true&characterEncoding=utf8";
			}
			else if (type==3){
				dbdriver.value = "com.ibm.db2.jcc.DB2Driver";
				dburl.value = "jdbc:db2://<hostname>:50000/<dbname>";
			}
		}
	}

	function testDB() {
		var useType = "JDBC";//document.getElementsByName("content.useType")[0].value;
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
				alert("JNDI名称不能为空！");
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
	
	function save(){
		var name = document.getElementsByName("content.name")[0];
		if(name && name.value == ""){
			alert("名称不能为空！");
			return false;
		}
		if(document.getElementsByName("content.dbType")[0].value ==0){
			alert("数据库类型不能为空，请选择！");
			return false;
		}
		document.forms[0].submit();
	}
	
	jQuery(document).ready(function(){
		inittab();
		checkVersion();
		window.top.toThisHelpPage("application_info_advancedTools_dataSource_info");
	});

</script>
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script>

</script>
</head>
<body id="application_info_advancedTools_dataSource_info" class="contentBody">
<s:form id="formItem" theme="simple" action="save" method="post">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td"  style="height:27px;">
			<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onclick="save();">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
							</button>
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="list"/>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="navigation_title">{*[DataSource]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">
			<s:textfield name="tab" cssStyle="display:none;" value="3" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnDataSource'}" />
			<tr>
				<td class="commFont">{*[Name]*}:</td>
				<td class="commFont">{*[Database]*}{*[Type]*}:</td>
			</tr>
			<tr>		
				<td><s:textfield cssClass="input-cmd" theme="simple"
					name="content.name" size="50" /></td>
				<td><s:select name="content.dbType" cssClass="input-cmd"
					theme="simple" list="_dblist" onchange="ev_dbtypechange(this.value)"></s:select></td>
			</tr>
			<tr class="seperate">
				<td class="commFont">{*[DriverClass]*}:</td>
				<td class="commFont">{*[URL]*}:</td>
			</tr>
			<tr>
				<s:if test="content.driverClass != null">
						<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.driverClass" size="50"  /></td>
				</s:if>
				<s:else>
						<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.driverClass" size="50" value="oracle.jdbc.driver.OracleDriver" /></td>
				</s:else>
				<s:if test="content.url != null">
						<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.url" size="50"  /></td>
				</s:if>
				<s:else>
						<td><s:textfield cssClass="input-cmd" theme="simple"
								name="content.url" size="50" value="jdbc:oracle:thin:@<server>:1521:<database_name>" /></td>
				</s:else>		
			</tr>
		
			<tr class="seperate">
				<td class="commFont">{*[User]*}{*[Name]*}:</td>
				<td class="commFont">{*[Password]*}:</td>
			</tr>
			<tr>		
				<td><s:textfield cssClass="input-cmd" theme="simple"
					name="content.username" size="50" /></td>
				<td><s:textfield cssClass="input-cmd" theme="simple"
					name="content.password" size="50" /></td>
			</tr>
			<tr class="seperate">
					<td class="commFont">{*[DB_PoolSize]*}:</td>
					<td class="commFont">{*[DB_Timeout]*}(ms):</td>
			</tr>
			<tr>
				<td align="left"><s:textfield  cssClass="input-cmd" theme="simple" 
					name="content.poolsize" onkeypress="event.returnValue=IsDigit();"/>
				</td>
				<td align="left" ><s:textfield  cssClass="input-cmd" theme="simple" 
					name="content.timeout" onkeypress="event.returnValue=IsDigit();"/>
				</td>
			</tr>
			<tr >
				<td align="right"></td>
				<td align="left" > 
					<button type="button" class="button-image" onClick="testDB();"><img
					src="<s:url value="/resource/imgnew/act/act_0.gif"/>">{*[Test]*}{*[DB]*}</button>
				</td>
			</tr>
		<table class="id1" width="100%">
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
