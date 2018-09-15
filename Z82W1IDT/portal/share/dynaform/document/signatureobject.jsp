<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<div id="obj3" style="display: none">
	<OBJECT id="SignatureControl"
		classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E"
		codebase="iSignatureHTML.cab#version=7,1,0,180" width=0 height=0
		VIEWASTEXT>
		<param name="ServiceUrl"
			value="<%=mDoCommandUrl %>?FormID=<s:property value="content.formid"/>" />
		<!--读去数据库相关信息-->
		<param name="WebAutoSign" value="0" />
		<!--是否自动数字签名(0:不启用，1:启用)-->
		<param name="PrintControlType" value="2" />
		<!--打印控制方式（0:不控制  1：签章服务器控制  2：开发商控制）--> 
	</OBJECT>
</div>