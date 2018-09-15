<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" href="<s:url value='/portal/share/workflow/runtime/flowhis/css/style.css'/>" rel="stylesheet"/>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script>
function showBigPic(obj){
	$("#bigPicBox").css("top","10%").show();
	$("#bigPicBox>img").attr("src",$(obj).attr("_href"));
}

function hideBigPic(obj){
	$("#bigPicBox").hide();
	$("#bigPicBox>img").attr("src","");
}

</script>
<style>
#bigPicBox{
	position: absolute;
	width: 80%;
	left: 10%;
	height: 80%;
	background: #fff;
	border: 3px solid;
	z-index: 300;
	display:none;
}
#bigPicBox img {
	width:100%
}
</style>
</head>
<body>
<div class="flow-history">
	<div class="history">
		<div class="history-date">
			<ul>
				<h2 class="first">
					<a href="#" title="<s:property value="#request.flowName" />"><s:property value="#request.flowName" /></a>
				</h2>
				<s:iterator value="#request.historys" id="history" status="status">
				<s:if test="#request.isComplete && #status.first">
					<li class="green">
					<h3><s:date name="#history.processtime" format="MM-dd HH:mm"/><span><s:date name="#history.processtime" format="yyyy"/></span></h3>
					<dl>
						<dt><s:property value="#history.targetNodeName"/>
							<span >
							</span>
						</dt>
					</dl>
					</li>
					<li>
					<h3><s:date name="#history.processtime" format="MM-dd HH:mm"/><span><s:date name="#history.processtime" format="yyyy"/></span></h3>
					<dl>
						<dt><s:property value="#history.startNodeName"/>
							<span title='<s:property value="#history.attitude"/>'>
							<s:if test="#history.agentAuditorName !=null">
								<s:property value="#history.agentAuditorName"/>(<s:property value="#history.auditorName"/>)
							</s:if>
							<s:else>
								<s:property value="#history.auditorName"/>
							</s:else>
								：<s:property value="#history.attitude"/>
								<s:if test="#history.signature != null && #history.signature !=''">
									<a href='<s:property value="#history.getSignatureImageDate()"/>' title="查看大图" target='_blank' ><img alt="查看大图" src='<s:property value="#history.getSignatureImageDate()"/>' height="23px"></a>
								</s:if>
							</span>
						</dt>
					</dl>
					</li>
				</s:if>
				<s:else>
					<s:if test="#status.first">
						<li class="green">
					</s:if>
					<s:else>
						<li>
					</s:else>
						<h3><s:date name="#history.processtime" format="MM-dd HH:mm"/><span><s:date name="#history.processtime" format="yyyy"/></span></h3>
						<dl>
							<dt><s:property value="#history.startNodeName"/>
								<span title='<s:property value="#history.attitude"/>'>
								<s:if test="#history.agentAuditorName !=null">
									<s:property value="#history.agentAuditorName"/>(<s:property value="#history.auditorName"/>)
								</s:if>
								<s:else>
									<s:property value="#history.auditorName"/>
								</s:else>
									：<s:property value="#history.attitude"/>
								<s:if test="#history.signature != null && #history.signature !=''">
									<a onclick="showBigPic(this)" _href="<s:property value="#history.getSignatureImageDate()"/>" href="<s:property value="#history.getSignatureImageDate()"/>" title="查看大图" target='_blank' ><img alt="查看大图" src='<s:property value="#history.getSignatureImageDate()"/>' height="23px"></a>
								</s:if>
								</span>
							</dt>
						</dl>
					</li>
				</s:else>
				</s:iterator>
				<!--<li class="end">
				</li>
			--></ul>
		</div>
	</div>
</div>

<div id="bigPicBox" onclick="hideBigPic(this)"><img src=''></div>
								

<script type="text/javascript" src="<s:url value='/portal/share/workflow/runtime/flowhis/js/history.js'/>"></script>
</body>
</html>
</o:MultiLanguage>