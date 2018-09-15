<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File,java.util.Date,java.util.List" %>
<%@ include file="/portal/share/common/head.jsp"%>
<%
	List<File> files = null;
	if (request.getAttribute("secFiles") != null) {
		files = (List<File>) request.getAttribute("secFiles");
	}
	List<File> domainFiles = null;
	if (request.getAttribute("secDomainFiles") != null) {
		domainFiles = (List<File>) request.getAttribute("secDomainFiles");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 文件上传页面</title>
  <script type="text/javascript" src="../../share/component/wordField/OfficeContorlFunctions.js"></script>
  <script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
</head>
  <body onload="init()">
    <center>
      <input type="button" onclick="CreateNewSign()" value="创建印章"/>&nbsp;&nbsp;
      <input type="button" onclick="savetourl('<s:property value='#request.secPath'/>')" value="保存印章到服务器"/>&nbsp;&nbsp;
      <input type="button" onclick="SaveToLocal()" value="保存印章到本地"/>&nbsp;&nbsp;
    </center>

    <form id="secForm" method="post" enctype="multipart/form-data" action='<s:url action="uploadfile.action" namespace="/portal/upload"/>'>
      <div align="center">
        <script type="text/javascript" src="../../share/component/wordField/signtoolcontrol.js"></script>
      </div>
      
      <table border="1" cellspacing="0" align="center" width="50%">
        <tr>
          <td>正在编辑</td>
          <td align="center"><input type="text" id="filename" name="filename" disabled="disabled" style="width:220px;"></td>
        </tr>
        <tr>
          <td>印章名称</td>
          <td align="center"><input type="text" id="SignName" name="SignName" style="width:220px;"></td>
        </tr>
        <tr>
          <td>印章使用者</td>
          <td align="center"><input type="text" id="SignUser" name="SignUser" style="width:220px;"></td>
        </tr>
        <tr>
          <td>印章口令</td>
          <td align="center"><input type="password" id="Password1" name="Password1" style="width:220px;"></td>
        </tr>
        <tr>
          <td>确认口令</td>
          <td align="center"><input type="password" id="Password2" name="Password2" style="width:220px;"></td>
        </tr>
        <tr>
          <td>印章源文件</td>
          <td align="center"><input type="file" id="upload" name="upload" width="200px"></td>
        </tr>
      </table>
     </form>
     
     <table id="tb" border="1" cellspacing="0" align="center">
       <tr>
         <td align="center">文件名称</td>
         <td align="center">修改日期</td>
         <td align="center">文件大小</td>
         <td align="center">相关操作</td>
       </tr>
       <tbody id="secList">
       <%
         for(File file : files){
       %>
         <tr>
           <td align="center"><%=file.getName()%></td>
           <td align="center"><%=new Date(file.lastModified()).toLocaleString()%></td>
           <td align="center"><%=file.length()%></td>
           <td align="center"><a href="javascript:editesp('<s:property value='#request.secPath'/><%=file.getName()%>')">编 辑</a></td>
         </tr>
       <%
         }
       %>
       <%
         for(File file : domainFiles){
       %>
         <tr>
           <td align="center"><%=file.getName()%></td>
           <td align="center"><%=new Date(file.lastModified()).toLocaleString()%></td>
           <td align="center"><%=file.length()%></td>
           <td align="center"><a href="javascript:editesp('<s:property value='#request.secDomainPath'/><%=file.getName()%>')">编 辑</a></td>
         </tr>
       <%
         }
       %>
       </tbody>
     </table>
  </body>
</html>