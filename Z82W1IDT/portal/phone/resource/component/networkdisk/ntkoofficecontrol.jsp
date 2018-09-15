<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*,cn.myapps.core.networkdisk.ejb.NetDiskFileProcess,cn.myapps.core.networkdisk.ejb.NetDiskFile,cn.myapps.util.ProcessFactory" %>
    
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
NetDiskFileProcess netDiskFileProcess = (NetDiskFileProcess)ProcessFactory.createProcess(NetDiskFileProcess.class);
NetDiskFile netDiskFile = (NetDiskFile)netDiskFileProcess.doView(id);
String name = netDiskFile.getName();
String path = netDiskFile.getFolderPath()+"/"+name;
path = path.substring(path.lastIndexOf("networkdisk") - 1).replace("\\","/");
path = request.getContextPath()+path;

String type = request.getParameter("type");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=name %></title>
<script type="text/javascript">
function init(){
 var path = '<%=path%>';
 var type = '<%=type%>';
 var OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
 if(type==".doc" || type == ".docx"){
 	OFFICE_CONTROL_OBJ.OpenFromURL(path,false,'Word.Document');
 }else if(type==".xls" || type == ".xlsx"){
 	OFFICE_CONTROL_OBJ.OpenFromURL(path,false,'Excel.Sheet');
 }
}
</script>
</head>
<body onload="init()">
<script type="text/javascript" src="ntkoofficecontrol.js"></script>
</body>
</html>