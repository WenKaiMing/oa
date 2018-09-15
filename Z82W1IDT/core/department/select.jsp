<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<%
String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<title> {*[Select internal user]*} </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<%= contextPath %>/resource/css/dtree.css"
	type="text/css">
<link rel="stylesheet"
	href="<%= contextPath %>/resource/css/main.css"
	type="text/css">
<script src="<%= contextPath %>/script/dtree.js"></script>
<script src="<%= contextPath %>/script/util.js"></script>
<script language="JavaScript">
var contextPath = '<%= contextPath %>';

function selectOne(value) {
  window.returnValue = value;
  window.close();
}

function doReturn() {
  var sis = document.getElementsByName("_selectitem");
  var rtn = new Array();
  var p = 0;

  if (sis.length != null) {
	  for (var i=0; i<sis.length; i++) {
	    var e = sis[i];
	    if (e.type == 'checkbox') {
	        if (e.checked) {
	          rtn[p++] = e.value;
	        }
	    }
	  }
  }
  else {
    var e = sis;
    if (e.type == 'checkbox') {
      if (e.checked) {
        rtn[p++] = e.value;
      }
    }
  }
  //alert(rtn);
  window.returnValue = rtn;
  window.close();
}

function ev_init() {
  var ids = '<s:property value="#parameters['SELECTEDID'][0]" />';
  var idList = ids.split(';'); 
  if (idList != '' && idList != null) {
	  var sis = document.getElementsByName("_selectitem");
	  if (sis != null && sis != '') {
		  for (var i=0; i<sis.length; i++) {
		    var e = sis[i];
		    for (var j=0; j<idList.length; j++) {
		    	var tmp = e.value.split(';');
			    if (tmp!=null && tmp.length > 0 && tmp[0] == idList[j]) {
		          e.checked = true;
			      d.openTo(tmp[0].substring(1));
			    }
		    }
		 }
	  }
  }
}

</script>
</head>
<body topmargin="0" onload="ev_init()">
<table width="98%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="50" class="text-label">{*[Roles]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
				<td class="line-position2" width="50"  valign="top">
			 <c:if test="${!empty param.MULTISELECT and param.MULTISELECT eq 'TRUE'}" >
   				<button type="button" class="button-image"
					onClick="doReturn();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
              </c:if>
				</td>
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-image"
					onClick="doExit()"><img
					src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</button>
				</td>
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-image"
					onClick="doEmpty()"><img
					src="<s:url value="/resource/image/qingkong.gif"/>">{*[Clear]*}</button>
				</td>
					</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="4">
  
  <tr><td><input class="button-cmd" type="button" value="{*[Expand]*}" onclick="d.openAll()"/><input class="button-cmd" type="button" value="{*[Indent]*}" onclick="d.closeAll();"/></td></tr>
  <tr class="row-hd">
    <td height="2"> </td>
  </tr>
  <tr>
      <td>	
    	<div class="scroll-div">
        <div class="dtree">
          <s:set name="selectChild" value="#parameters['SELECTEDID'][0]" />
          <script type="text/javascript">
		  <s:set name="multiSelect" value="#parameters['MULTISELECT'][0]" />		
					var d = new dTree('d');
					
					<s:if test=" #multiSelect == 'TRUE' ">
						d.config.multiSelect = true;
						d.config.selectChild = false;
					</s:if>
					
					
					<s:iterator value="_deptSelect">
						<s:if test="%{superior.id != null && superior.id != ''}">
							d.add(
								'<s:property value="id" />',
								'<s:property value="superior.id" />',
								'<s:property value="name" />',
								'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
								'D<s:property value="id" />;<s:property value="name" />',
								'',
								'<%= contextPath %>/resource/images/dtree/dept.gif',
								'<%= contextPath %>/resource/images/dtree/dept.gif');
								'',
								"",
						</s:if>
						
						<s:else>
							d.add('<s:property value="id" />',
								-1,
								'<s:property value="name" />',
								'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
								'D<s:property value="id" />;<s:property value="name" />',
								'',
								'<%= contextPath %>/resource/images/dtree/dept.gif');
								'',
								'',
								"",
						</s:else>
						
						<s:set name="deptid" value="id" />
						<s:iterator value="roles">
							d.add('<s:property value="id" />',
							'<s:property value="#deptid" />',
							'<s:property value="name" />',
							'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
							'R<s:property value="id" />;<s:property value="name" />',
							'',
							'<%= contextPath %>/resource/images/dtree/group.gif');
							'',
							'',
							"",
						</s:iterator>
						
						<s:iterator value="users">
							d.add('<s:property value="id" />',
							'<s:property value="#deptid" />',
							'<s:property value="name" />',
							'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
							'U<s:property value="id" />;<s:property value="name" />',
							'',
							'<%= contextPath %>/resource/images/dtree/user.gif');
							'',
							'',
							"",
						</s:iterator>
					</s:iterator>
					document.write(d);
			</script>
        </div>
      </div></td>
  </tr>
</table>
</body>
</o:MultiLanguage></html>
