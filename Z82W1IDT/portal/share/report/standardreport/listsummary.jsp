<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@page import="cn.myapps.util.StringUtil"%>
<%@page import="cn.myapps.core.user.action.WebUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<o:Url value='/resource/css/style.jsp'/>" />
<link rel="stylesheet" href="<s:url value='/resource/css/select.css'/>" type="text/css"  media="all" />
<title>{*[cn.myapps.core.report.crossreport.aging_report]*}</title>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script src="<s:url value="/portal/share/report/standardreport/swfobject.js"/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ReportUtil.js"/>'></script>
<style type="text/css">
body {
	background-color:#dfe8f6;
}
</style>
</head>
<%
String domainid = ((WebUser)request.getSession().getAttribute("FRONT_USER")).getDomainid();
String formId = (String)request.getParameter("_formid");
String applicationId = (String)request.getParameter("application");
String startdate = (String)request.getParameter("startdate");
String enddate =(String)request.getParameter("enddate");
String dbmethod = (String)request.getParameter("dbmethod");
%>
<body>
<script><!--
var width = document.body.offsetWidth*0.9;
var height = document.body.offsetHeight*0.7;
var formId = '<%=formId%>';
var applicationId = '<%=applicationId%>';
var startdate = '<%=startdate%>';
var enddate = '<%=enddate%>';
var colcount = 1;
var dbmethod = '<%=dbmethod%>';


//根据columnIds,列出下拉框
  function ev_verify(obj){
     if(checkRepeatValue()){       
      if(checkOverAmount()){
          alert('{*[cn.myapps.core.report.standardreport.please_select_data]*}');
          document.getElementById(obj.id).value ='';
      }else{

           refreshSWF(getSrcForReload());

       }    
     }else{
         alert('{*[cn.myapps.core.report.standardreport.please_confirm_select_value]*}');
         document.getElementById(obj.id).value ='';
     }
  }
  
  function refreshSWF(col){
	  
	  //var bar = findSWF("chart");
	  //var line = findSWF("chart2");
	  //var pie = findSWF("chart3");
	  //var list = null;

	  var chartType = document.getElementById("frame").contentWindow.document.getElementById("chartType");
	  if(!chartType){
		  chartType = new Object();
		  chartType.value = "0";
	  }
	  
	  switch(chartType.value){
	    case "1": document.getElementById("frame").contentWindow.location.href="ChartPage.jsp?ct=1&col=" + col + "&width=" + width + "&height=" + height; break;
	    case "2": document.getElementById("frame").contentWindow.location.href="ChartPage.jsp?ct=2&col=" + col + "&width=" + width + "&height=" + height; break;
	    case "3": document.getElementById("frame").contentWindow.location.href="ChartPage.jsp?ct=3&col=" + col + "&width=" + width + "&height=" + height; break;
	    default: document.getElementById("frame").contentWindow.location.href="frame-list.jsp"; break;
	  }
  }

function findSWF(movieName) {
  if (navigator.appName.indexOf("Microsoft")!= -1) {
    return frame.window.document["ie_" + movieName];
  } else {
    return document[movieName];
  }
}

function change(obj){
	  var btn = document.getElementsByName("btn");
	  for(var i=0; i<btn.length; i++){
		  if(btn[i].id==obj.id){
			  btn[i].disabled = true;
			  btn[i].style.color = "gray";
		  }else{
			  btn[i].disabled = false;
			  btn[i].style.color = "black";
		  }
	  }

	  var paras = "width="+width+"&height="+height+"&col="+getSrcForReload();

	  var riframe = document.getElementById("frame");

	  switch(obj.id){
	    case "btnList": riframe.src="frame-list.jsp?" + paras; break;
	    case "btnBar": riframe.src="ChartPage.jsp?ct=1&" + paras; break;
	    case "btnLine": riframe.src="ChartPage.jsp?ct=2&" + paras; break;
	    case "btnPie": riframe.src="ChartPage.jsp?ct=3&" + paras; break;
	    default: riframe.src="frame-list.jsp?" + paras; break;
	  }
}

function addSelectCols(){
var selLen = document.getElementsByName('col').length;
var colLen = document.getElementById('col1').length;
var count = selLen + 1;
 if((colLen-1) == selLen){
	   alert('{*[cn.myapps.core.report.standardreport.not_add_col]*}');
 }else{
	   var str1="{*[cn.myapps.core.report.standardreport.select_col]*}:<SELECT ID=col"+count+" NAME=col onchange=ev_verify(this)>";
	   for (var i=0; i<colLen; i++){
		   str1 += "<OPTION value="+document.getElementById('col1').options[i].value+"> " + document.getElementById('col1').options[i].text + " </OPTION>";
	   }
	   str1 += "</SELECT>";
	   var str2 = "<span class='button-cmd' style=\"position:absolute;\"><a href=\"#\" onclick='removSelectCols("+selLen+");'><span>{*[cn.myapps.core.report.standardreport.remove_col]*}</span></a></span>";
	   var newTr = document.getElementById('selectCol').insertRow(-1);
	   newTr.id = "row"+selLen;
	   var newTd= newTr.insertCell(-1);
	   var newTd2= newTr.insertCell(-1);
	   newTd.className = "commFont";
	   newTd.innerHTML = str1 +str2;
}
}

function removSelectCols(len){
  var deleterow=document.getElementById("row"+len);
  selectCol.removeChild(deleterow);
	  var btn = document.getElementsByName("btn");
	  for(var i=0; i<btn.length; i++){
		  if(btn[i].disabled == true){
			  change(btn[i]);
		  }
	  }
}

function getSrcForReload()
{  
   var tempObj = document.getElementsByName('col');
   var parameters = '';
   var j =0;
   for(var i=0 ;i<tempObj.length;i++)
   {
     if(tempObj[i].value != null&& tempObj[i].value!=''){
       parameters = parameters + tempObj[i].value +';';
       j++;
       }
   }
         //根据所选择的列刷新flash,如没有选择则默认为auditor
     if(parameters != null && parameters!='')
       parameters = parameters.substr(0,parameters.length-1);
     else
       parameters = 'AUDITOR';
       var app = document.getElementById('application').value;
       var dbmethod = document.getElementsByName('dbmethod')[0].value;
       parameters = encodeURIComponent(parameters) + '&formid='+formId+'&applicationid='+app+'&dbmethod='+dbmethod+ getDatePara();

   return parameters;
}

function checkRepeatValue(){
   var rtn = true;
   var tempValue='';
   var tempObj = document.getElementsByName('col');

     for(var i=0 ;i<tempObj.length;i++){
      if(tempObj[i].value != null && tempObj[i].value !='' ){
    	  for(var j=i+1 ;j<tempObj.length;j++){
    		  if(tempObj[j].value != null && tempObj[j].value !='' ){
        		  if(tempObj[j].value==tempObj[i].value){
        			  rtn =false;
        			  break;  
                }                      
        	  }
        	}
         }
       }
   return rtn;
}

function checkOverAmount(){
	
   DWREngine.setAsync(false);  
   var arrayObj = new Array() ;
   var tempObj = document.getElementsByName('col');
   var flag = false;
  
   var j =0;
   for(var i=0 ;i<tempObj.length;i++){
     if(tempObj[i].value != null&& tempObj[i].value!=''){
       arrayObj[j] = tempObj[i].value;
       j++;
     }
   }

   if(arrayObj.length == 0)
     arrayObj[0] = 'AUDITOR';
     ReportUtil.getRowsNum(document.getElementById('application').value,document.getElementById('_formid').value,document.getElementById('startdate').value,document.getElementById('enddate').value, arrayObj, '<%=dbmethod%>', function(num){
         if(num>500)
         flag = true;
    });
    return flag;
    
}

function getDatePara(){
   var rtn ='';
   var startdate = document.getElementById("startdate").value;
   var enddate = document.getElementById("enddate").value;
   if(startdate)
      rtn = rtn + '&startdate='+startdate;
     
   if(enddate)
      rtn = rtn + '&enddate='+enddate;
    
   return rtn;
}
--></script>
<s:form name="formList" action="exportReport" method="post">
<s:hidden name="addedcolumn" />
<s:hidden id="_formid" name="_formid" value="%{#parameters._formid}"/>
<s:hidden name="application" id="application" value="%{#parameters.application}"/>
<s:hidden id="startdate" name="startdate" value="%{#parameters.startdate}"/>
<s:hidden id="enddate" name="enddate" value="%{#parameters.enddate}"/>
<s:hidden id="dbmethod" name="dbmethod" value="%{#parameters.dbmethod}"/>
<table width="100%">
  <tbody id="selectCol">
  <tr>
    <td class="commFont" width="30%">
                {*[cn.myapps.core.report.standardreport.select_col]*}:<s:select name="col" id="col1" list="columns" onchange="ev_verify(this)" theme='simple'/>
      <span class="button-cmd" style="position:absolute;">
        <a href="###" onclick="addSelectCols();">
          <span>{*[cn.myapps.core.report.standardreport.add_col]*}</span>
        </a>
      </span>
    </td>
    <td>
      <span class="button-cmd" style="background-color:#dfe8f6;">
        <a href="###" onclick="formList.submit()">
          <span>{*[cn.myapps.core.report.standardreport.excelExport]*}</span>
        </a>
      </span>
    </td>
  </tr>
</tbody>

</table>
<table width="100%" height="85%"  border="0" cellspacing="0" cellpadding="0" >
  <tr style="margin:0px;">
    <!-- remove td style：background-image: url(<s:url value='/resource/imgnew/nav_back.gif'/>); -->
    <td align="left" class="table-header" height="5%" style="background-position: bottom; background-repeat:repeat-x;">
	  <table cellspacing="0" cellpadding="0">
	    <tr>
		  <td><input type="button"  name="btn" id="btnList" class="btcaption" style="color:gray" disabled="disabled" onclick="change(this)" value="{*[List]*}"/></td>
		  <td><input type="button"  name="btn" id="btnBar" class="btcaption" onclick="change(this)" value="{*[cn.myapps.core.report.standardreport.columnchart]*}"/></td>
		  <td><input type="button"  name="btn" id="btnLine" class="btcaption"  onclick="change(this)" value="{*[cn.myapps.core.report.standardreport.linechart]*}"/></td>
		  <td><input type="button"  name="btn" id="btnPie" class="btcaption"  onclick="change(this)" value="{*[cn.myapps.core.report.standardreport.piechart]*}"/></td>
	    </tr>
	  </table>	
	</td>
  </tr>
  <tr>
    <td valign="top" height="95%" width="100%">
      <iframe id="frame" name="Frame"  src="frame-list.jsp" height="100%" width="100%" frameborder="0"/></iframe>
	</td>
  </tr>
</table>
</s:form>

</body>
<script>
/*function change(obj) {

    document.getElementById("btnList").style.color="black";
	document.getElementById("btnBar").style.color="black";
	document.getElementById("btnLine").style.color="black";
    document.getElementById("btnPie").style.color="black";
	
	document.getElementById("btnList").style.color="black";
	document.getElementById("btnBar").style.fontWeight="normal";
	document.getElementById("btnLine").style.fontWeight="normal";
	document.getElementById("btnPie").style.fontWeight="normal";

	document.getElementById("btnList").className = "btcaption";
	document.getElementById("btnBar").className = "btcaption";
	document.getElementById("btnLine").className = "btcaption";
	document.getElementById("btnPie").className = "btcaption";

	
	obj.style.color = "#4f4e4e";
	obj.style.fontWeight = "bold";
	obj.className = "btcaption-selected";
	var paras = "?width="+width+"&height="+height+"&col="+getSrcForReload();
	switch (obj.name){ 
	    case "btnList": frames["frame"].location.href="frame-list.jsp"+paras;break;
		case "btnBar": frames["frame"].location.href="frame-bar.jsp"+paras;break;
		case "btnLine": frames["frame"].location.href="frame-line.jsp"+paras;break;
	    case "btnPie": frames["frame"].location.href="frame-pie.jsp"+paras;break;
		} 
}*/
</script>

</o:MultiLanguage></html>
