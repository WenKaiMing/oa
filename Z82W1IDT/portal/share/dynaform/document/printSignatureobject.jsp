<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<div id="obj3" style="display:none">
<OBJECT id="SignatureControl"  classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E" 
	codebase="iSignatureHTML.cab#version=7,1,0,180" 
	width=0 
	height=0 
	VIEWASTEXT>
<param name="ServiceUrl" value="<%=mDoCommandUrl%>?FormID=<s:property value="content.formid"/>"/><!--读去数据库相关信息-->
<param name="WebAutoSign" value="0"/>             <!--是否自动数字签名(0:不启用，1:启用)-->
<param name="PrintControlType" value="1"/>               <!--打印控制方式（0:不控制  1：签章服务器控制  2：开发
<param name="MenuDocVerify" value=false>                  <!--菜单验证文档-->
<param name="MenuServerVerify" value=false>               <!--菜单在线验证-->
<param name="MenuDigitalCert" value=false>                <!--菜单数字签名-->
<param name="MenuDocLocked" value=false>                  <!--菜单文档锁定-->
<param name="MenuDeleteSign" value=false>                 <!--菜单撤消签章-->
<param name="MenuMoveSetting" value=true>                <!--菜单禁止移动-->

</OBJECT>
</div>