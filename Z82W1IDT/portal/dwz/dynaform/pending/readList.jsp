<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%
//禁止浏览器缓存
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>
	<s:url id="backURL" value="/portal/dispatch/homepage.jsp" >
		<s:param name="application" value="summaryCfg.applicationid" />
	</s:url>
	<s:url id="viewDocURL" action="view" namespace="/portal/dynaform/document">
		<s:param name="_backURL" value="%{backURL}" />
		<s:param name="_currpage" value="datas.pageNo" />
		<s:param name="_pagelines" value="datas.linesPerPage" />
		<s:param name="_rowcount" value="datas.rowCount" />
	</s:url>
	
	<s:url id="moreDocURLRead" action="more-circulatorlist-default" namespace="/portal/workflow/storage/runtime">
		<s:param name="_currpage" value="datas.pageNo" />
		<s:param name="_pagelines" value="datas.linesPerPage" />
		<s:param name="_rowcount" value="datas.rowCount" />
		<s:param name="application" value="summaryCfg.applicationid" />
		<s:param name="summaryCfgId" value="%{#parameters.summaryCfgId}" />
	</s:url>
<link rel="stylesheet"
		href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<style type="text/css">

body{
}
.over { background-color: #FFFFCC;color:#FFFFFF;}
.out { background-color: #ffffff;color:#000000;}
#pendingDiv a:link {
	text-decoration: none;
}
#pendingDiv a:visited {
	text-decoration: none;
	color: blue;
}
#pendingDiv a:hover {
	text-decoration: underline;
	color: blue;
}
#pendingDiv a:active {
	text-decoration: none;
	color: blue;
}
.pending{text-align:left;}
</style>

	<script type="text/javascript">
	function viewDoc(docid, formid,summaryCfgId) {
		if (docid && formid) {
			var viewDocURL = '<s:property value="#viewDocURL" escape="false"/>';
			viewDocURL += "&_docid=" + docid;
			viewDocURL += "&_formid=" + formid;
			viewDocURL += "&summaryCfgId=" + summaryCfgId;
			viewDocURL += "&application=<s:property value='summaryCfg.applicationid'/>";
			window.location.href = viewDocURL;
		}
	}
	
	function doMoreDocRead(summaryCfgId){
		var url = '<s:property value="#moreDocURLRead" escape="false"/>';
			url += "&summaryCfgId=" + summaryCfgId;
		OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[More]*}{*[core.dynaform.work.label.to.read]*}',
				close: function(rtn) {
				}
				
		});	
	}
	
	jQuery(document).ready(function init(){
		
		var summaryCfgId = '<s:property value="summaryCfg.id"/>';
	   	var tdImage = document.getElementsByName("images");
	   	var td_head =document.getElementById("header");
	   	if(summaryCfgId == ""){
	   		alert("{*[core.homepage.nosummaryCfg]*}！");
	   		return;
	   	}
	});
</script>

	<s:hidden name="formid" value="%{#parameters.formid}" />
	<s:hidden name="summaryCfgId" value="%{#parameters.summaryCfgId}" />
	<div style="margin: 0px; padding: 5px; background-color: rgb(255,255,255);" align="center" id="pendingDiv">
		<div id="header" class="column-head" style="font-size: 13px;">
			<img class='<s:property value="summaryCfg.id" />' alt="pending-head" id="image1"	src="<s:url value='/portal/share/images/imgnew/pending_head.gif'/>" />
			<font style="font-size: 14px;cursor: context"><s:property
					value="summaryCfg.title" /></font>
		</div>
		<div class="pending">
			<table border='0' cellspacing='0' cellpadding='0' >
				<s:iterator value="datas.datas" status="index">
				<tr>
					<td>
					<s:property value="toHtmlText(#session.FRONT_USER,summaryCfg.id )" escape="false"/>
					</td>
				</tr>
				</s:iterator>
			</table>
		</div>
		<div align="left" style="margin-left: 10px;">
			<s:if test="datas.rowCount > datas.linesPerPage">
				<a href="#" onclick=doMoreDocRead('<s:property value="summaryCfg.id" />') id="<s:property value='summaryCfg.id' />">{*[More]*}...</a>
			</s:if>
		</div>
	</div>

</o:MultiLanguage>