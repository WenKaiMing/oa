<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/webwork" prefix="ww" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>No Title</title>
    <script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
    <script type="text/javascript" src="<s:url value="/portal/share/report/standardreport/swfobject.js"/>"></script>
    <script src='<s:url value="/dwr/engine.js"/>'></script>
    <script src='<s:url value="/dwr/util.js"/>'></script>
    <script src='<s:url value="/dwr/interface/ReportUtil.js"/>'></script>
    <script type="text/javascript">
      swfobject.embedSWF("open-flash-chart.swf", "my_chart", "<s:property value='#parameters.width'/>", "<s:property value='#parameters.height'/>", "9.0.0");
    </script>

    <script type="text/javascript">

      var params = new Object();
      params["sid"] = "<%=session.getId()%>";
      params["applicationid"] = "<s:property value='#parameters.applicationid'/>";
      params["formid"] = "<s:property value='#parameters.formid'/>";
      params["col"] = "<s:property value='#parameters.col'/>";
      params["ct"] = "<s:property value='#parameters.ct'/>";
      params["dbmethod"] = "<s:property value='#parameters.dbmethod'/>"

      var data ="";
      DWREngine.setAsync(false);
      ReportUtil.getSummaryReportChart(params, function(json){
            data=json;
      });
      DWREngine.setAsync(true);

     function open_flash_chart_data(){
         return data;
     }
    </script>
  </head>
  
  <body bgcolor="#dfe8f6">
    <input type="hidden" id="chartType" name="chartType" value="<s:property value='#parameters.ct'/>">
    <div style="float:left;" id="my_chart"></div>
  </body>
</html>