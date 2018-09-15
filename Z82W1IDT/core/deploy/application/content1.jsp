<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%
	String contextPath = request.getContextPath();
%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="fh" />
<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.deploy.application.application_information]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<style type="">
<!--
	.input-cmd{width: 350px;}
-->
</style>
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<SCRIPT language="javascript">
function submit(){ 
	document.forms[0].action = document.forms[0].action + "?refresh=true";
	document.forms[0].submit();
}

function ev_onload(){
	if ('<s:property value="#parameters.refresh"/>'=='true') {
		parent.parent.frames['navigator'].location.href="<s:url value='/core/deploy/application/appnavigator.jsp'/>" 
	}
}

function ev_dbtypechange(type) {
	if (type) {
		var dbdriver = document.getElementsByName("content.dbdriver")[0];
		var dburl = document.getElementsByName("content.dburl")[0];
		
		if (type=='ORACLE'){
			dbdriver.value = "oracle.jdbc.driver.OracleDriver";
			dburl.value = "jdbc:oracle:thin:@<server>:1521:<database_name>";
		}
		else if (type=='MSSQL'){
			dbdriver.value = "net.sourceforge.jtds.jdbc.Driver";
			dburl.value = "jdbc:jtds:sqlserver://<hostname>:1433/<dbname>";
		}
		else if (type=='HSQLDB'){
			dbdriver.value = "org.hsqldb.jdbcDriver";
			dburl.value = "jdbc:hsqldb:hsql://<hostname>:9001/<dbname>";
		}
		else if (type=='MYSQL'){
			dbdriver.value = "com.mysql.jdbc.Driver";
			dburl.value = "jdbc:mysql://<hostname>:3306/<dbname>?useUnicode=true&characterEncoding=utf8";
		}
		else if (type=='DB2'){
			dbdriver.value = "com.ibm.db2.jcc.DB2Driver";
			dburl.value = "jdbc:db2://<hostname>:50000/<dbname>";
		}
	}
}
function attechmentupload(excelpath){
	 var rtr = uploadFile(excelpath,'logourl');
	 if(rtr!=null&&rtr!='') {
		if (rtr.indexOf("_") < 0)
	   		formItem.elements['content.logourl'].value = rtr;
		else
			formItem.elements['content.logourl'].value = rtr.substring(0,rtr.indexOf("_"));
	 }
}

function attechmentupload2(excelpath){
	 var rtr = uploadFile(excelpath,'videodemo');
	 if(rtr!=null&&rtr!='') {
		 if (rtr.indexOf("_") < 0)
			 formItem.elements['content.videodemo'].value = rtr;
		 else
	   		formItem.elements['content.videodemo'].value = rtr.substring(0,rtr.indexOf("_"));
	 }
}
function ev_onSumbit(){
		document.forms[0].action='<s:url value="/core/deploy/application/addDeveloper.action"></s:url>';
		document.forms[0].submit();
}

function testDB() {
	var dbdriver = document.getElementsByName("content.dbdriver")[0];
	var dburl = document.getElementsByName("content.dburl")[0];
	var dbusername = document.getElementsByName("content.dbusername")[0];
	var dbpassword = document.getElementsByName("content.dbpassword")[0];
	
	var url = "testdb.jsp?username="
	+ dbusername.value
	+ "&password="
	+ dbpassword.value
	+ "&driver="
	+ dbdriver.value
	+ "&url="
	+ dburl.value;
	window.open(url, "newwindow", "height=100, width=200, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no"); //��?????
}

function IsDigit(){
	return ((event.keyCode>=48)&&(event.keyCode<=57));
}
//去两边空格   
String.prototype.trim = function(){   
    return this.replace(/(^\s*)|(\s*$)/g, "");   
};   
function PeripheralTrim(){   
    var tmp = document.getElementById("content.name").value.trim();   
    document.getElementById("content.name").value = tmp;   
} 

jQuery(document).ready(function(){
	ev_onload();
	initBodyLayOut();
	initHelpMsg();
});
</SCRIPT>
</head>
<body id="application_info" class="contentBody">
<div class="ui-layout-center" id="tabContainerid">
	<div id="contentActDiv">
		<s:hidden name="operation" value="%{#request.operation}" />
	    <s:hidden name="domain" value="%{#request.domain}" />
		<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.deploy.application.application_information]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="save_btn" title="{*[Save]*}" class="justForHelp button-image" onClick="forms[0].submit()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
					</button>
					<button type="button" id="exit_btn" title="{*[Exit]*}" class="justForHelp button-image"
						onClick="forms[0].action='<s:url action="list-apps"></s:url>';forms[0].submit();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
		</table>
	</div>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<table class="table_noborder id1">
			<s:form action="update" method="post" name="formItem" theme="simple">
				<%@include file="/common/page.jsp"%>
				<s:hidden name='mode' value="%{#parameters.mode}" />
				<tr>
					<td class="commFont">{*[cn.myapps.core.deploy.application.application_name]*}:</td>
					<td class="commFont">{*[Type]*}:</td>
				</tr>
				<tr>
				  <td align="left" id="Application_Name" title="{*[cn.myapps.core.deploy.application.application_name]*}" pid="contentTable" class="justForHelp">
				  	<s:textfield  cssClass="input-cmd" theme="simple" name="content.name" onblur="PeripheralTrim()"/></td>
				  <td align="left" id="Application_Type" title="{*[cn.myapps.core.deploy.application.application_type]*}" pid="contentTable" class="justForHelp">
				  	<s:select cssClass="input-cmd" theme="simple" name="_type"  list="#fh.getApplicationType()" /></td>
			    </tr>
			    <!-- 
				<tr class="seperate">
			       <td class="commFont">{*[LogoUrl]*}:</td>
			        <td class="commFont">{*[Application]*}{*[LogoUrl]*}:</td>
			       <td class="commFont">{*[VideoDemoUrl]*}:</td>
			    </tr>
			    <tr>
				<td align="left"><s:textfield id="logourl" name="content.logourl"  cssStyle="width:328px;" readonly="true" theme="simple"/>
		      	       <button type="button" name='logoUrl' class="button-image" onClick="attechmentupload('EXCELTEMPLATE_PATH')">
		      	       <img align="middle" src="<s:url value="/resource/image/search.gif"/>"></button>
	      	     </td>		
				   <td align="left"><s:textfield id="videodemo" name="content.videodemo"  cssStyle="width:328px;" readonly="true" theme="simple"/>
		      	       <button type="button" name='videoDemoUrl' class="button-image" onClick="attechmentupload2('EXCELTEMPLATE_PATH')">
		      	       <img src="<s:url value="/resource/image/search.gif"/>"></button>
	      	       </td>
			    </tr>
			     -->
			    <!--  
				<tr class="seperate">
					<td class="commFont"   >{*[AliSoftAppKey]*}:</td>
					<td class="commFont"   >{*[AliSoftCertCode]*}:</td>
				</tr>
				<tr>
					<td align="left"><s:textfield  cssClass="input-cmd" theme="simple" 
						name="content.sipAppkey" /></td>
					<td align="left"><s:textfield  cssClass="input-cmd" theme="simple" 
						name="content.sipAppsecret" /></td>
				</tr>
				-->
				<tr class="seperate">
					<td class="commFont">{*[DB_Type]*}:</td>
					<td class="commFont">{*[DB_Driver]*}:</td>
				</tr>
				<tr>
					<td align="left" id="DB_Type" title="{*[DB_Type]*}" pid="contentTable" class="justForHelp">
						<s:select cssClass="input-cmd" theme="simple" onchange="ev_dbtypechange(this.value)" name="content.dbtype"
						list="{'','DB2','ORACLE','MSSQL','MYSQL','HSQLDB'}" /></td>
					<td align="left" id="DB_Driver" title="{*[DB_Driver]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dbdriver" /></td>
				</tr>
				<tr class="seperate">
					<td class="commFont"   >{*[DB_URL]*}:</td>
					<td class="commFont"   >{*[DB_Username]*}:</td>
				</tr>
				<tr>
					<td align="left" id="DB_URL" title="{*[DB_URL]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dburl" /></td>
					<td align="left" id="DB_Username" title="{*[DB_Username]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dbusername" /></td>
				</tr>
				<tr class="seperate">
					<td class="commFont"   >{*[DB_Password]*}:</td>
					<td class="commFont"   >{*[DB_PoolSize]*}:</td>
				</tr>
				<tr>
					<td align="left" id="DB_Password" title="{*[DB_Password]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dbpassword" /></td>
					<td align="left" id="DB_PoolSize" title="{*[DB_PoolSize]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dbpoolsize" onkeypress="event.returnValue=IsDigit();"/></td>
				</tr>
				<tr class="seperate">
					<td class="commFont">{*[DB_Timeout]*}:</td>
					<td class="commFont">{*[cn.myapps.core.deploy.application.application_logo]*}:</td>
					
				</tr>
				<tr valign="top">
					<td align="left" id="DB_Timeout" title="{*[DB_Timeout]*}" pid="contentTable" class="justForHelp">
						<s:textfield  cssClass="input-cmd" theme="simple" name="content.dbtimeout" onkeypress="event.returnValue=IsDigit();"/></td>
					<td align="left" id="Application_LogoUrl" title="{*[cn.myapps.core.deploy.application.application_logo]*}" pid="contentTable" class="justForHelp">
						<s:textfield id="logourl" name="content.logourl"  cssStyle="width:328px;" readonly="true" theme="simple"/>
		      	       <button type="button" name='logoUrl' class="button-image" onClick="attechmentupload('EXCELTEMPLATE_PATH')">
		      	       <img align="middle" src="<s:url value="/resource/image/search.gif"/>"></button>
		      	    </td>
				</tr>
				
				<tr class="seperate">
			        <td class="commFont"   >{*[Description]*}:</td>
			    </tr>
			    <tr>
			    <td align="left" id="Application_Description" title="{*[Description]*}" pid="contentTable" class="justForHelp">
			    	<s:textarea cssClass="input-cmd"  cols="50" rows="2"
						 theme="simple" name="content.description" /></td>
				
				  <td colspan=2 id="Test_DB" title="{*[cn.myapps.core.deploy.application.test_db]*}" pid="contentTable" class="justForHelp" align="right" valign="bottom">
				  <button type="button" class="button-image" onClick="testDB();"><img
					src="<s:url value="/resource/imgnew/act/act_0.gif"/>">{*[cn.myapps.core.deploy.application.test_db]*}</button>
				</td>
				</tr>
			</s:form>
		</table>
	</div>
</div>
<%@include file="/common/right_help.jsp"%>
</body>
</o:MultiLanguage>
</html>
