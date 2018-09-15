<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.FormProcessBean"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.FormField"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
WebUser user = (WebUser)session.getAttribute("FRONT_USER");
String formid = request.getParameter("formid");
String formname = "";
FormProcessBean formProxy = new FormProcessBean();
Collection colls = new ArrayList();
Form form = (Form)formProxy.doView(formid);
if (form != null) {
	colls = form.getAllFields();
	formname = form.getName();
}
Iterator iters = colls.iterator();
Iterator tmp = colls.iterator();
%>

<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[Edit FieldPerm]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<style type="text/css">
<!--
td {
	font-size: 12px;
	white-space:nowrap;
}
-->
</style>
<script src='<s:url value="/portal/share/script/util.js" />'></script>
<script language="JavaScript">
var rd = document.getElementsByName("rd");
var hd = document.getElementsByName("hd");
var wt = document.getElementsByName("wt");

function getFieldPermList(){
    var fieldPermList = "";
    if(hd.length>0){
	  	for(i=0;i<hd.length;++i){
	  		if(hd[i].checked){
		  		  if(hd[i].value.indexOf("@") ==0 || hd[i].value.indexOf("$") ==0){
		  			fieldPermList += hd[i].value + ";"; 
		  		  }
		  	  }else if(rd[i].checked){
				  if(rd[i].value.indexOf("@") ==0 || rd[i].value.indexOf("$") ==0){
					fieldPermList += rd[i].value + ";";
			  	  }
		  	  }
		}
	}
	//alert("fieldPermList>>>>>>>"+fieldPermList);
	return fieldPermList;
}

function setFieldPermList(formid){
	var fieldPermList = '';
	
	if (!parent || !parent.document.getElementById("fieldPermList")) {
		return;
	}
	
	var listStr = parent.document.getElementById("fieldPermList").value;
	if (listStr) {
		try {
			var list = eval("("+listStr+")");
			for (var i=0; i<list.length; i++) {
				if(list[i].formid == formid) {
					fieldPermList = list[i].fieldPermList;
				}
			}
		} catch(ex) {
			
		}
	}
  	
  	var hdchecked, rdchecked;
  	if(tmp.hd != null){
		for(i=0;i<hd.length;i++)
		{
		  hdchecked = (fieldPermList.indexOf(hd[i].value+';')>=0);
			hd[i].checked = hdchecked;
			rdchecked = (fieldPermList.indexOf(rd[i].value+';')>=0);
			rd[i].checked = rdchecked;
			if(!(hdchecked || rdchecked)){
			  wt[i].checked = true;
			}
		}
	}

}

function doCheck(id,tp){
	var rd = document.getElementById('rd'+id);
	var wt = document.getElementById('wt'+id);
	var hd = document.getElementById('hd'+id);
	var tmp = document.getElementById("tmp");
	
	if (tp=='rd'){
		tmp.allrd.checked = false;
		if (rd.checked){
			wt.checked = false;
			hd.checked = false;
		}
	}
	if (tp=='wt'){
		tmp.allwt.checked = false;
		if (wt.checked){
			rd.checked = false;
			hd.checked = false;
		}
	}
	if (tp=='hd'){
		tmp.allhd.checked = false;
		if (hd.checked){
			rd.checked = false;
			wt.checked = false;
		}
	}
}

function selectAllRd(b){
	var tmp = document.getElementById("tmp");
 if(rd!= null){
		for(i=0;i<rd.length;i++){
			rd[i].checked = b;
			hd[i].checked = false;
			wt[i].checked = false;
		}
	  tmp.allhd.checked = false;
	  tmp.allwt.checked = false;
  }
}

function selectAllHd(b){
	var tmp = document.getElementById("tmp");
  if(hd != null){
		for(i=0;i<hd.length;i++){
			rd[i].checked = false;
			hd[i].checked = b;
			wt[i].checked = false;
		}
	  tmp.allrd.checked = false;
	  tmp.allwt.checked = false;
	}
}

function selectAllWt(b){
	var tmp = document.getElementById("tmp");
  if(wt != null){
		for(i=0;i<wt.length;i++){
			rd[i].checked = false;
			hd[i].checked = false;
			wt[i].checked = b;
		}
	  tmp.allrd.checked = false;
	  tmp.allhd.checked = false;
  }
}


</script>
</head>

<body>
<form name="tmp" id="temp">
<input type="hidden" name="formname" value="<%=formname%>"/>
<input type="hidden" name="formid" value="<%=formid%>"/>
<table width="100%" cellspacing="0">
    <tr>
      <td width="100%" valign="top">
			<table width="100%" cellpadding="2" cellspacing="1"  border="0"  bgcolor="#dddddd">
			  <tr bgcolor="#FFFFFF">
			    <td class="commFont" width="10%">{*[Field]*}:</td>
			    <td align="left" valign="top">
			     <table width="100%">
			       <tr>
			         <td width="10%" align="left">&nbsp;</td>
			         <td width="10%" class="commFont">
			         	<input type="checkbox" name="allrd" onclick="selectAllRd(this.checked)">
			         	{*[all]*}
			         </td>
			         <td width="10%" class="commFont">
			         	<input type="checkbox" name="allwt" onclick="selectAllWt(this.checked)">
			         	{*[all]*}
			         </td>
			         <td width="70%" class="commFont">
			         	<input type="checkbox" name="allhd" onclick="selectAllHd(this.checked)">
			         	{*[all]*}
			         </td>
			       </tr>
			<%
			   int id = 0;
			   while(iters.hasNext()){
			   		FormField ff = (FormField)iters.next();
			   		id++; 
			
			%>
					<tr>
					  <td><%=ff.getName()%>:</td>
			    	  <td><input type="checkbox" name="rd" value="@<%=ff.getName()%>" id="rd<%=id%>" onclick='doCheck("<%=id%>","rd")'>{*[Read-only]*}</td>
			    	  <td><input type="checkbox" name="wt" value="#<%=ff.getName()%>" id='wt<%=id%>' onclick='doCheck("<%=id%>","wt")'>{*[Modify]*}</td>
			    	  <td><input type="checkbox" name="hd" value="$<%=ff.getName()%>" id='hd<%=id%>' onclick='doCheck("<%=id%>","hd")'>{*[Hidden]*}</td>
			    	</tr>
			<%
					}
			%>
			    	</table>
			    </td>
			  </tr>  
			</table>
      </td>
    </tr>
 </table>
</form>
</body>
<script language="JavaScript">
    var formid = document.getElementById("formid");
    if (formid) {
    	setFieldPermList(formid.value);
    }
</script>
</o:MultiLanguage>
</html>


