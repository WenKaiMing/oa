<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<%
String contextPath = request.getContextPath();
%>
<HTML>
<o:MultiLanguage>
<head>
<title> {*[Select]*} </title>
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
  var sis = document.all("_selectitem");
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

  window.returnValue = rtn;
  window.close();
}

</script>
</head>
<body topmargin="0">
<s:set name="multiSelect" value="#parameters['MULTISELECT'][0]" />
<table width="98%">
	<tr>
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="120" class="text-label">{*[Form select]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
			<td></td>
			<td class="line-position2">
			  <s:if test="multiSelect == 'TRUE'" > 
    <button type="button" class="button-image"
					onClick="doReturn()"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
      </s:if></td>
			<td class="line-position2"><button type="button" class="button-image"
					onClick="doExit()"><img
					src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</button></td>
			<td class="line-position2"><button type="button" class="button-image"
					onClick="doEmpty()"><img
					src="<s:url value="/resource/image/qingkong.gif"/>">{*[Clear]*}</button></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="4">
 
  <tr class="row-hd">
    <td height="2"> </td>
  </tr>
  <tr>
    <td> <div class="scroll-div">
        <div class="dtree">
          <script type="text/javascript">
				var d = new dTree('d');	
          		d.add('0',-1,'{*[Form]*}');
				<s:iterator value="_formSelect">	
					d.add('<s:property value="id"/>','0',
					'<s:property value="name"/>',
					"javascript:selectOne(\'<s:property value="id"/>,<s:property value="name"/>\');",
					"<s:property value="id"/>;<s:property value="name"/>", 
					"", "<%= contextPath %>/resource/images/dtree/folder.gif", 
					"<%= contextPath %>/resource/images/dtree/folderopen.gif");
				</s:iterator>	
					
			    document.write(d);
					//-->
				</script>
        </div>
      </div></td>
  </tr>
</table>
</body>
</o:MultiLanguage>
</html>
