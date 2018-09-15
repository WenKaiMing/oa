<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
	<s:url id="viewDocURL" action="view" namespace="/portal/dynaform/document">
		<s:param name="_currpage" value="datas.pageNo" />
		<s:param name="_pagelines" value="datas.linesPerPage" />
		<s:param name="_rowcount" value="datas.rowCount" />
	</s:url>
	
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<style type="text/css">
<!--
body{
}
.over { background-color: #FFFFCC;color:#FFFFFF;}
.out { background-color: #ffffff;color:#000000;}
a:link {
	margin-top: 5px;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: underline;
	color: #0000FF;
}
a:active {
	text-decoration: none;
}

-->
</style>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>

	<script type="text/javascript">

	var back = "<s:url value = '/portal/dynaform/document/moreDoc.action'/>%3FsummaryCfgId=" + '<s:property value="summaryCfg.id"/>';
		back += '%26application=<s:property value="summaryCfg.applicationid"/>';
		back += '%26_currpage=<s:property value="datas.pageNo"/>';
	function viewDoc(docid, formid,summaryCfgId) {
		if (docid && formid) {
			var viewDocURL = '<s:property value="#viewDocURL" escape="false"/>';
			viewDocURL += "&_docid=" + docid;
			viewDocURL += "&_formid=" + formid;
			viewDocURL += "&summaryCfgId=" + summaryCfgId;
			viewDocURL += "&application=<s:property value='summaryCfg.applicationid'/>";
			viewDocURL += "&_backURL=" + back;
			window.location.href = viewDocURL;
		}
	}
	
	jQuery(document).ready(function init(){
		var type = '<s:property value="summaryCfg.style"/>';
		var summaryCfgId = '<s:property value="summaryCfg.id"/>';
	   	var tdImage = document.getElementsByName("images");
	   	var td_head =document.getElementById("header");
	   	
			if(type==2){
		    	td_head.background='<s:url value="/resource/imgnew/pending_head_1.gif"/>';
		    	jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_img_1.gif'/>");
		  	}
			else if(type==3){
		    	td_head.background='<s:url value="/resource/imgnew/pending_head_2.gif"/>';
		      	jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_img_2.gif'/>");
		   	}
		   	else if(type==4){
		      	td_head.background='<s:url value="/resource/imgnew/pending_head_3.gif"/>';
		      	jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_img_3.gif'/>");
		   	}
		   	else if(type==5){
		      	td_head.background ='<s:url value="/resource/imgnew/pending_head_4.gif"/>';
		      	jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_img_4.gif'/>");
		   	}
		   	else if(type==1){
		   		jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_head.gif'/>");
	        } else {
	        	td_head.background='<s:url value="/resource/imgnew/pending_head_1.gif"/>';
		    	jQuery("." + summaryCfgId).attr("src","<s:url value='/resource/imgnew/pending_img_1.gif'/>");
			}
			jQuery("[moduleType='pending']").obpmPending();  //待办元素
			OBPM.dialog.resize(800, 500);
	});
	
	function doExit(){
	  	OBPM.dialog.doReturn();
	}
	
</script>
	<s:form name="formList" action="moreDoc" theme="simple" method="post">
	<s:hidden name="formid" value="%{#parameters.formid}" />
	<s:hidden name="summaryCfgId" value="%{#parameters.summaryCfgId}" />
	<%@include file="/common/list.jsp"%>
	<div style="padding:5px;height: 100%\9;">
		<table width="100%">
			<tr>
				<td width="30%">
					<img src="<s:url value="/resource/image/email2.jpg"/>" /><span style="">{*[Pending]*}{*[List]*}</span>
				</td>
				<td width="70%" align="right">
					<button type="button" class="button-class" onClick="doExit()"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
			<hr width="100%"/>
		<table style="width: 100%;border: 1px solid #BFBFBF;">
			<tr>
				<td style="padding-left: 15px;">
					<div id="header" class="" style="font-size: 17px;font-weight: bold;margin-top: 5px;margin-bottom: 5px;color: #1268A5;">
						<img class='<s:property value="summaryCfg.id" />' alt="pending-head" id="image1"	src="" />
						<font style="font-size: 14px;cursor: context"><s:property
								value="summaryCfg.title" /></font>
					</div>
					<div class="context">
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
					<div style="text-align: right;">
						<o:PageNavigation dpName="datas" css="linktag" ></o:PageNavigation>
					</div>
				</td>
			</tr>
		</table>
	</div>
	</s:form>
</o:MultiLanguage>