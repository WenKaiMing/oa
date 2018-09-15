<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>signature</title>
</head>
<body>
<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
<div id="obj2" style="display:none">
<OBJECT id="SignatureControl"  classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E" codebase="iSignatureHTML.cab#version=7,1,0,180" width=0 height=0 VIEWASTEXT>
<!--读去数据库相关信息-->
<param name="ServiceUrl" value="<s:property value="%{#sinfo.mDoCommandUrl}"/>?FormID=<s:property value="%{#sinfo.FormID}"/>"/>
<!--是否自动数字签名(0:不启用，1:启用)-->
<param name="WebAutoSign" value="0"/>
<!--打印控制方式（0:不控制  1：签章服务器控制  2：开发 商控制）-->
<param name="PrintControlType" value="2"/>              
</OBJECT>
</div>
</body>
</html>