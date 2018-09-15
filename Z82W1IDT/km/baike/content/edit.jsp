
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.km.base.dao.DataPackage" %>
<%@ page import="cn.myapps.km.baike.content.ejb.ReferenceMaterial" %>
<%@ page import="cn.myapps.km.baike.content.ejb.EntryContent" %>
<%@ page import="cn.myapps.km.baike.entry.ejb.Entry" %>
<html>

<link type="text/css" href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" href='<s:url value="/km/baike/component/kindeditor/themes/default/default.css" />' />
<link rel="stylesheet" href='<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.css" />' />
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/jquery.js" />' ></script>
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/kindeditor.js" />' ></script>
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/lang/zh_CN.js" />'></script>
<script charset="utf-8" src='<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.js" />'></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
<script>
	var editor = "";
	KindEditor.ready(function(K) {
			editor = K.create('textarea[name="entryContent.content"]', {
			cssPath : '<s:url value="/km/baike/component/kindeditor/plugins/code/prettify.css" />',
			uploadJson : '<s:url value="/km/baike/component/kindeditor/jsp/upload_json.jsp" />',
			fileManagerJson : '<s:url value="/km/baike/component/kindeditor/jsp/file_manager_json.jsp" />',
			allowFileManager : true,
			afterCreate : function() {
				this.sync();
			}
		});
	});
</script>
<head>
<title>编辑内容 </title>
  <style>

.table-list .tr {
    border-bottom: 1px solid #ECECEC;
    line-height: 28px;
}
.table-head  {
    border-bottom: 1px solid #665666;
    line-height: 28px;
}
.table-head li {
    color: #333333;
    float: left;
    font-size: 14px;
    font-weight: bold;
}

.page {
    font-family: "????";
    font-size: 14px;
    line-height: 128px;
    text-align: center;
}


.label-name {
    display: inline-block;
    font-weight: bold;
   
}
#create {
    border: 1px solid #CFCFCF;
    padding: 5px 1px;
}
.converttips {
    font-size: 12px;
    line-height: 25px;
    margin-left: 62px;
}
#demoarea {
    border: 1px solid #D2DAE7;
    line-height: 22px;
    margin: 0 0 27px;
    width: 440px;
}
.b1 form p {
    color: #999999;
}
.content {
    margin: 5px 0;
}
.top-line {
    border-top: 1px dashed #EFEFEF;
    line-height: 20px;
    padding: 14px 0;
}

.btn {
    border: 0 none;
    height: 30px;
    width: 50px;
}

.yes {
    height: 8px;
    width: 11px;
}
.yes, .no {
    display: inline-block;
    margin-right: 8px;
    overflow: hidden;
}

.no {
    height: 9px;
    width: 9px;
}

a {
    color: #2D64B3;
    text-decoration: none;
}
#submmit {
	background-image: url('<s:url value="/km/baike/content/images/submmit.jpg" />');
}
#save {
	background-image: url('<s:url value="/km/baike/content/images/save.jpg" />');
}
	</style>
</head>

<script src='<s:url value="/km/baike/script/jquery-ui/jquery-1.9.1.js" />' type="text/javascript"></script>
<script type="text/javascript">
	function doSave() {
		editor.sync();
		document.getElementsByName("content_handle")[0].action = '<s:url value="/km/baike/content/doUpdate.action" />';
		document.getElementsByName("content_handle")[0].submit();
	}
	
	function doSubmit() {
		editor.sync();
		document.getElementsByName("content_handle")[0].action = '<s:url value="/km/baike/content/doSubmmit.action" />';
		document.getElementsByName("content_handle")[0].submit();
	}
</script>
<body id="baike" style="margin:0;padding:0;text-align:center">
<%
 	 System.out.print("QQQQQ");
	 Entry entry=(Entry)session.getAttribute("entry");
	 //System.out.print(c.getLatestContent().getReason());
%>
	<div id="wrap">
			<%@ include file="/km/baike/entry/baikeHead.jsp"%>
		
		<div id="page"  >
			<div class="edithistory">
				<div id="navbar-collection" class="navbar" style=""><div class="line"></div></div>
				<form action="/diff/" method="get" name="diff" target="_blank">
					<input type="hidden" name="vid1" value="">
					<input type="hidden" name="vid2" value="">
				</form>
				<div class="tab clearfix" style="width:100%; height:30px; background:#888888"></div>
				<div class="xian" style="border-bottom: 1px solid #AEC9EA; margin-top: 1px;"></div>
			</div>

		  	<div style='margin-top:22px'></div>
		</div>
	</div>
		
					
			<div class="b1" style="background-color: #FBFBFB;">
			<form name="content_handle" action='<s:url value="/km/baike/content/doUpdate.action"/>' method="post">
			<div class="ml" style="text-align:left;">
				<table align="center">
					<input type="hidden"  name="entryContent.state" value='<s:property value="#session.entry.getLatestContent().getState()" />'/> 
					<input type="hidden"  name="entryContent.entryId" value='<s:property value="#session.entry.getId()" />' /> 
					<input type="hidden"  name="entryContent.author" value='<s:property value="#session.entry.getLatestContent().getAuthor().id" />'/> 
					<input type="hidden"  name="entryContent.versionNum" value='<s:property value="#session.entry.getLatestContent().getVersionNum()"/>' /> 
				    <input type="hidden"  name="entryContent.summary" value='<s:property value="#session.entry.getLatestContent().getSummary()"/>' />	
		
				<div class="converttips">
						<tr>
							<td>
								<div>
									<textarea id="demoarea" rows="18"  name="entryContent.content"  style="border: 1px solid #CFCFCF;width:810px;align:center">
										<s:property value="#session.entry.getLatestContent().getContent()" />
									</textarea>
								</div>
							</td>
						</tr>
				
						<tr>
							<td>
								<label class="label-name" for="create" style="margin-top:20px;">修改原因：</label>
							</td>
						</tr>
						
						<tr>
							<td>
								<div>
									<textarea id="demoarea" rows="5" name="entryContent.reason" style="border: 1px solid #CFCFCF;width:810px;align:center;">
									</textarea>
								</div>
							</td>
						</tr>
				
						<tr>
							<td>
								<input id="submmit" class="bg btn" type="button" value="" onclick="doSubmit();">
								&nbsp;&nbsp;&nbsp;&nbsp;<input id="save" class="bg btn" type="button" value="" onclick="doSave();">
							</td>
						</tr>
				</table>
				</div>
			</div>
		</form>
	</div>
	

<div class="bgpagLn" align="center" >
		
		
		<div id="footer" class="nslog-area"  align="center" data-nslog-type="1001" style="margin: 0 auto;margin-top:20px;margin-top: 115px;">
		2013 BaiKe
		<a target="_blank"  >版权所有@天翎网络</a>
			</div>
		</div>
	</body>
</html>


