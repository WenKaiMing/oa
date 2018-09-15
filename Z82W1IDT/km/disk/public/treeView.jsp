<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<s:bean name="cn.myapps.km.disk.ejb.NDirHelper" id="nd"></s:bean>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.move_to]*}</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/script/dtree/dtree.css" />' rel="StyleSheet" type="text/css" />
<script type="text/javascript" src='<s:url value="/km/script/dtree/dtree4TreeView.js"/>'></script>
<script type="text/javascript" src='<s:url value="/km/disk/script/treeView.js"/>'></script>
<style>
.mainLeft{float:left;}
.mainRight{float:left;}
.mainLeft{height:390px;border:1px solid #ECECEC;border-right:none;}
.mainRight{width:500px;height:390px;border:1px solid #ECECEC;border-right:none;margin:0px;padding:0px;}
</style>
<script>
jQuery(window).resize(function(){
	getDimensions();
});

jQuery(document).ready(function(){
	getDimensions();
	initDtree();	//初始化dtree
	switchTreeList();	//点击树形切换显示相应的内容
	listenAction();	//添加监听事件
});
</script>
</head>
<body>
<s:form action="" method="post" theme="simple" >
<s:hidden name="movetotitle" id="movetotitle" value="{*[cn.myapps.km.disk.move_to]*}" />
<s:hidden name="ndiskid" id="ndiskid" value="%{#parameters.ndiskid}"></s:hidden>
<s:hidden name="ndirid" id="ndirid" value="%{#request.ndirid}" />
<s:hidden name="_type" id="_type" />
<s:hidden name="_currpage" id="_currpage" value="%{#request.datas.pageNo}"/>
<s:hidden name="_sortStatus" id="_sortStatus" value="%{#request._sortStatus}"/>
<s:hidden name="orderbyfield" id="orderbyfield" value="%{#request.orderbyfield}"/>
<s:hidden name="viewType" id="viewType" value="2"></s:hidden>
<div class="mainLeft">
<div class="dtreeDiv" style="overflow:auto; width:200px;height:100%;background:#F3F3F5;">
	<s:iterator value="#nd.getNDirByNDisk(#parameters.ndiskid)" id="dir">
		<s:if test="parentId == null || parentId == '' " >
			<div type="hidden" id="obpmDtree" obpmId='<s:property value="id" />' obpmPid='-1' 
				obpmName='<s:property value="name" />' obpmIsparent='true'></div>
		</s:if>
	</s:iterator>
</div>
</div>
<div class="mainRight">
<iframe id="dirFrame" src="<s:url value='/km/disk/viewndir.action'><s:param name='_type' value='%{#parameters._type}'/><s:param name='_sortStatus' value='%{#parameters._sortStatus}'/><s:param name='orderbyfield' value='%{#parameters.orderbyfield}'/><s:param name='ndiskid' value='%{#parameters.ndiskid}'/><s:param name='ndirid' value='%{#request.ndirid}'/><s:param name='viewType' value='2'/></s:url>" width="100%" height="100%" frameborder="0" scrolling="no" ></iframe>
</div>
<div class="clear"></div>
</s:form>
</body>
</o:MultiLanguage></html>