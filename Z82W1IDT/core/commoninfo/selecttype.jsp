<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();%>

<html><o:MultiLanguage>
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/resource/css/main.css"
	type="text/css">
<script src="<%= contextPath %>/script/util.js"></script>
<script src="<%= contextPath%>/script/tree.js"></script>
<script language="JavaScript">
var contextPath = '<%= contextPath %>';

function selectOne(value) {
  //alert(value);
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

function doExit() {
  window.close();
}
</script>
</head>
<body topmargin="0">
<s:form name="formList" method="post" action="/bug/list.action">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />

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
				<s:set name="field" value="#parameters['field'][0]" />

				<tr class="row-hd">
					<td width="100%">{*[Type]*}
				</tr>
			</table>
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
