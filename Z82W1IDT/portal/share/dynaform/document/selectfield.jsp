<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%String contextPath = request.getContextPath();%>

<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/resource/css/main.css"
	type="text/css">
<script src="<%= contextPath %>/portal/share/script/util.js"></script>
<script src="<%= contextPath%>/script/tree.js"></script>
<script language="JavaScript">
var contextPath = '<%= contextPath %>';

function selectOne(value) {
  //alert(value);
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

  window.returnValue = rtn;
  window.close();
}

function doExit() {
  window.close();
}
</script>
</head>
<body topmargin="0">
<s:form name="formList" method="post" action="/bug/list.action">
	<%@include file="/common/page.jsp"%>
	
	<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td colspan="2" width="100%"><input type="button" class="bt-cancel"
				onclick="doExit()" value="{*[Cancel]*}"> <input type="button" class="bt-empty"
				onclick="doEmpty()" value="{*[Clear]*}"></td>
		</tr>

		<tr>
			<td colspan="2" class="list-srchbar"></td>
		</tr>

		<tr>
			<td colspan="2">
			<table border="0" cellpadding="0" cellspacing="1">
				<tr class="row-hd">
					<td width="100%">
					{*[<s:property value="#parameters.fieldname[0]"/> ]*}
					</td>
				</tr>

				<s:iterator value="_fieldSelect">
					<tr class="row-content">
						<td width="100%"><a
								href="javascript:selectOne('<s:property />')" /> <s:property />
						</a></td>
					</tr>
				</s:iterator>
			
			</table>
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
