<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<s:bean name="cn.myapps.km.disk.ejb.NDirHelper" id="nd"></s:bean>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.move_to]*}</title>
<link href='<s:url value="/km/script/dtree/dtree.css" />' rel="StyleSheet" type="text/css" />
<link href='<s:url value="/km/disk/css/km.css" />' rel="StyleSheet" type="text/css" />

<script type="text/javascript" src='<s:url value="/km/script/dtree/dtree4MoveTo.js"/>'></script>
<script src='<s:url value="/km/disk/script/share.js"/>'></script>

<script type="text/javascript">
var args = OBPM.dialog.getArgs();
var checkedJson = args['checkedJson'];

//检查选中节点是否为移动节点的子节点
function checkNodeRela(curNodeId){
	var rtnNum = jQuery("#" + curNodeId).next().find(".dTreeNode[id=" + curVal + "]").size();
	if(rtnNum > 0) return true;
}

//确定
function doSave(){
	var obj = eval("(" + checkedJson + ")");

	var _dirSelects = obj._dirSelects;
	var _fileselects = obj._fileselects;

	if(curVal.length == 0){
		alert("{*[cn.myapps.km.disk.move_to_tip]*}");
	}else if(checkNodeRela(_dirSelects)){//选中子节点时
		alert("{*[cn.myapps.km.disk.move_to_error]*}");
	}else if(_dirSelects == curVal){//选中当前节点时
		alert("{*[cn.myapps.km.disk.move_to_error2]*}");
	}else{
		document.forms[0].action = contextPath + '/km/disk/move.action?_dirSelects=' + _dirSelects + "&_fileSelects=" + _fileselects + "&moveto=" + curVal;
		document.forms[0].submit();
		//setTimeout(function(){
		//	OBPM.dialog.doReturn();
		//},1);
	}
}

//取消
function doCancel(){
	OBPM.dialog.doExit("");
}

var curVal = "";	//当前选中的树形节点

var d = new dTree('d');
d.clearCookie();
//初始化dtree
function initDtree(){
	var $node = jQuery("#obpmDtree");
	var curId = $node.attr("obpmId");
	d.add(curId,$node.attr("obpmPid"),$node.attr("obpmName"), $node.attr("obpmIsparent"));	//添加节点对象
	jQuery("#obpmDtree").html(d.toString());
	d.adjxAddNode(curId);
}

//添加监听事件
function listenAction(){
	jQuery(".dTreeNode").each(function(){
		//添加鼠标滑过事件
		jQuery(this).bind("mouseover",function(){
			this.style.backgroundColor = "#ddd";
		}).bind("mouseout",function(){
			this.style.backgroundColor = "";
		}).bind("click",function(){
			if(curVal=="" || curVal != this.id){
				jQuery(".dTreeNode").each(function(){
					this.style.backgroundColor = "";
					//重新添加鼠标滑过事件
					jQuery(this).bind("mouseover",function(){
						this.style.backgroundColor = "#ccc";
					}).bind("mouseout",function(){
						this.style.backgroundColor = "";
					});
					
				});
				curVal = this.id;
				this.style.backgroundColor = "#ccc";
				jQuery(this).unbind("mouseover");
				jQuery(this).unbind("mouseout");
				
			}
		});
	});
}

jQuery(document).ready(function(){
	initDtree();	//初始化dtree
	listenAction();	//添加监听事件
});
</script>
</head>
<body>
<s:form action="" method="post" theme="simple" >
<s:hidden name="ndiskid" id="ndiskid" value="%{#parameters.ndiskid}"></s:hidden>
<%@include file="/common/msg.jsp"%>
<div class="dtreeDiv" style="overflow:auto;">
	<div class="dtreeBtn"><a href="javascript: d.openAll();">{*[cn.myapps.km.disk.open_all]*}</a><a href="javascript: d.closeAll();">{*[cn.myapps.km.disk.close_all]*}</a></div>
	<s:iterator value="#nd.getRootNDirByNDisk(#parameters.ndiskid)" id="dir">
		<s:if test="parentId == null || parentId == '' " >
			<div type="hidden" id="obpmDtree" obpmId='<s:property value="id" />' obpmPid='-1' 
				obpmName='<s:property value="name" />' obpmIsparent='true'></div>
		</s:if>
	</s:iterator>
</div>
<div class="btnDiv">
	<!--
	  <div style="float:left;">
		<p class="button_left"></p>
		<p class="button_center"><a href="javascript:void();" class="btn_square"><span><b class="share">新建文件夹</b></span></a></p>
		<p class="button_right"></p>
	  </div>
	-->
	<div>
		<p class="button_left"></p>
		<p class="button_center"><a href="javascript:doCancel();" class="btn_square"><span><b class="share">{*[cn.myapps.km.disk.cancel]*}</b></span></a></p>
		<p class="button_right"></p>
	</div>
	<div>
		<p class="button_left"></p>
		<p class="button_center"><a id="btn_move" href="javascript:doSave();" class="btn_square"><span><b class="share">{*[cn.myapps.km.disk.confirm]*}</b></span></a></p>
		<p class="button_right"></p>
	</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>