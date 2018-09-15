<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>

<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[DataSource]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
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
			
			if (type==0){
				dbdriver.value = "oracle.jdbc.driver.OracleDriver";
				dburl.value = "jdbc:oracle:thin:@<server>:1521:<database_name>";
			}
			else if (type==1){
				dbdriver.value = "net.sourceforge.jtds.jdbc.Driver";
				dburl.value = "jdbc:jtds:sqlserver://<hostname>:1433/<dbname>";
			}
			else if (type==4){
				dbdriver.value = "org.hsqldb.jdbcDriver";
				dburl.value = "jdbc:hsqldb:hsql://<hostname>:9001/<dbname>";
			}
			else if (type==3){
				dbdriver.value = "com.mysql.jdbc.Driver";
				dburl.value = "jdbc:mysql://<hostname>:3306/<dbname>?useUnicode=true&characterEncoding=utf8";
			}
			else if (type==2){
				dbdriver.value = "com.ibm.db2.jcc.DB2Driver";
				dburl.value = "jdbc:db2://<hostname>:50000/<dbname>";
			}
		}
	}
</script>
<script src="<s:url value='/portal/share/script/check.js'/>"></script>
<script src="<s:url value='/portal/share/script/util.js'/>"></script>
<script>

</script>
</head>
<body class="body-back" onload="inittab()">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-td"  style="height:27px;">
		<td rowspan="2"><%@include file="/common/commontab.jsp"%></td>
		<td class="nav-td" >&nbsp;
		</td>
	</tr>
	<tr class="nav-s-td">
		<td align="right" class="nav-s-td">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					</td>
					<td valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@include file="/portal/share/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:form id="formItem" theme="simple" action="save" method="post">
<s:textfield name="tab" cssStyle="display:none;" value="3" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnDataSource'}" />
	<%@include file="/common/page.jsp"%>	
	<table class="id1" width="100%">
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
		<td><s:textfield cssClass="input-cmd" theme="simple"
			name="content.driverClass" size="50" value="oracle.jdbc.driver.OracleDriver" /></td>
		<td><s:textfield cssClass="input-cmd" theme="simple"
			name="content.url" size="50" value="jdbc:oracle:thin:@<server>:1521:<database_name>" /></td>
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
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
