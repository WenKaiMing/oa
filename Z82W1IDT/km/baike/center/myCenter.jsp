<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<%@ page import="java.util.date.*" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<%
	String contextPath = request.getContextPath();  
	String basePath = request.getScheme() + "://"  
        + request.getServerName() + ":" + request.getServerPort()  
        + contextPath;  
%>
<script src="<%=basePath %>/km/baike/script/jquery-ui/jquery-1.9.1.js" type="text/javascript"></script>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<meta content="IE=7" http-equiv="X-UA-Compatible"/>
<title>我的词条</title>



<style>
	th{
		border-bottom:1px #000000 solid;
		word-break: break-all;
		text-overflow:ellipsis;
		white-space:nowrap; 
		overflow:hidden;
	}
	
	td{
		font-size:12px;
		border-bottom: 1px dotted #AEC9EA; 
		margin-top: 3px;
		word-break: break-all;
		text-overflow:ellipsis;
		white-space:nowrap; 
		overflow:hidden;
	}
	
	tr 
	{
		height:35px;
	}
</style>

<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 12px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a{text-decoration: none;color: #000;cursor:pointer;}
a:hover, a:link, a:visited {
    color: #136EC2;
}

#tabbox{ width:100%; overflow:hidden; margin:0 auto;}
.tab_conbox{border: 1px solid #999;border-top: none;}
.tab_con{ display:none;}

.tabs{height: 32px;border-bottom:1px solid #999;width: 100%;}
.tabs li{height:31px;line-height:31px;float:left;border:1px solid #999;border-left:none;margin-bottom: -1px;background: #e0e0e0;overflow: hidden;position: relative;}
.tabs li a {display: block;padding: 0 20px;border: 1px solid #fff;outline: none;}
.tabs li a:hover {background: #ccc;}	
.tabs .thistab,.tabs .thistab a:hover{background: #fff;border-bottom: 1px solid #fff;}

.tab_con {padding:12px;font-size: 14px; line-height:175%;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	jQuery.jqtab = function(tabtit,tab_conbox,shijian) {
		$(tabtit).find("li:last").addClass("thistab").show();
	};
	/*调用方法如下：*/
	$.jqtab("#tabs","#tab_conbox","click");
	
	$.jqtab("#tabs2","#tab_conbox2","mouseenter");
	
});
</script>

	
</head>
<body>
	<div id="myentry" class="tab clearfix" style="background:#D8D8D8 ; width:100%; height:32px;">
		<div id="tabbox" ;width:100%; height:32px;">
			<ul class="tabs" id="tabs">
				<li style="width:10px;border-top:0px; padding-left:0px; padding-right:0px;border-left:0px;border-bottom:0px;"></li>
				<li style="padding-left:0px; padding-right:0px;border-left: 1px solid #999;"><a>我的词条</a></li>
			</ul>
		</div>
				<%-- <font style="padding-left:10px;font-size: 14px;">总分:</font><s:property value='attributer.integral' /> --%>
			<table style="width:100%;table-layout:fixed;" cellSpacing="0"  cellPadding="0" >
				<tr class="tr clearfix" style="text-align:center">
					<th  width="25%" class="time" style="padding-left:10px;font-size: 14px;font-weight: bold; text-align:left;">发布时间</th>
					<th  width="25%" class="version" style="text-align:center;font-size: 14px;font-weight: bold;">词条名称</th>
					<th  width="25%" class="contributor" style="text-align:center;font-size: 14px;font-weight: bold;">发布积分</th>
					<th  width="25%" class="reason" style="text-align:center;font-size: 14px;font-weight: bold;">修改积分</th>
				</tr>
				 <s:iterator value="centerPoints.datas" id="cenScore" status="anyStatus">
				 	<s:set name="index" value="#anyStatus.index" />
					<tr class="tr clearfix">
						<td class="time" style="padding-left: 10px;"><s:property value="#cenScore.get(\"CREATED\").toString()"   /></td>
						<td class="version" style="text-align:center;"><s:property value="#cenScore.get('NAME')" /></td>
						<td class="contributor" style="text-align:center;"><s:property value="#cenScore.get(\"DEPLOY_POINTS\")" /></td>
						<td class="reason" style="text-align:center;"><s:property value="#cenScore.get(\"MODIFY_POINTS\")" /></td>
					</tr>  
				</s:iterator>
			</table> 
			<div align="right" style="margin-top:5px;">
				<a href='<s:url action="doGetMyEntry">
						</s:url>'>首页</a>
				<a href='<s:if test="datas.pageNo>1">
						<s:url action="doGetMyEntry">
						<s:param name="page" value="datas.pageNo-1" />
						<s:param name="lines" value="datas.linesPerPage" />
						<s:param name="entry.author" value="fasdf"/>
						<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
						
						<s:param name="userId" ><s:property value="userId" /></s:param>
						</s:url></s:if><s:else><s:property value="#" /></s:else>' >上一页</a> 
				<a href="<s:if test="datas.pageNo<datas.getPageCount()">
						<s:url action="doGetMyEntry">
						<s:param name="page" value="datas.pageNo+1" />
						<s:param name="lines" value="datas.linesPerPage" />
						<s:param name="entry.author" value="fasdf"/>
						
						<s:param name="userId" ><s:property value="userId" /></s:param>
						<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
						</s:url></s:if><s:else><s:property value="#" /></s:else>" >下一页</a>
				<a href="<s:url action='doGetMyEntry'>
						<s:param name="page" value="datas.getPageCount()" />
						<s:param name="lines" value="datas.linesPerPage" />
						<s:param name="entry.author" value="fasdf"/>
						<s:param name="userId" ><s:property value="userId" /></s:param>
						<s:param name="selectedMenu" ><s:property value="selectedMenu" /></s:param>
						</s:url>" >尾页</a>
						页次：<s:property value="datas.pageNo" />/<s:property value="datas.getPageCount()" />
						页 共<s:property value="datas.rowCount" />条记录 <s:property value="datas.linesPerPage" />条记录/页
			</div>
	</div>
</body>
</html>