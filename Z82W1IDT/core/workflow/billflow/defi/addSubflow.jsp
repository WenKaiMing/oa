<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%
String contextPath = request.getContextPath();
String applicationid = request.getParameter("application");
%>
<html><o:MultiLanguage>
<head>
<title>{*[SubFlow]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<%@include file="/common/head.jsp"%>
<script type="text/javascript" src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FieldMappingUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>

<SCRIPT LANGUAGE="JavaScript">
var contextPath = '<%=contextPath%>';
var fieldMappingCache = [];
var fieldMappingCache2 = [];
//Class FieldMappingItem
function FieldMappingItem(){
	this.parentField = null;
	this.subField = null;
	this.script = null;
}

//启动的父表单加载表单字段
function parentFormIdLoad(){
	var pFormIdVal = jQuery("input[name=parentFormId]").val();
	if(pFormIdVal == null || pFormIdVal == ""){
		return;
	}
	FormHelper.creatFormfieldOptionsWithDocProp("parentColum",
			pFormIdVal, "", function(str) {var func=eval(str);func.call();});
}

//父表单加载表单字段
function parentFlowFormIdLoad(){
	var pFormIdVal = jQuery("input[name=parentFlowFormId]").val();
	if(pFormIdVal == null || pFormIdVal == ""){
		return;
	}
	FormHelper.creatFormfieldOptionsWithDocProp("parentFlowFormName", 
			pFormIdVal, "", function(str) {var func=eval(str);func.call();});
	window.setTimeout("removeSelect('parentFlowFormName');",200);
}
	
//表单映射子表单加载表单字段
function subFlowFormIdLoad(){
	var sFormIdVal = jQuery("input[name=subFlowFormId]").val();
	if(sFormIdVal == null || sFormIdVal == ""){
		return;
	}
	FormHelper.creatFormfieldOptionsWithDocProp("subFlowFormName", 
			sFormIdVal, "", function(str) {var func=eval(str);func.call();});
	window.setTimeout("removeSelect('subFlowFormName');",200);
}

//iScript子表单加载表单字段
function subFlowFormId2Load(){
	var sFormIdVal2 = jQuery("input[name=subFlowFormId2]").val();
	if(sFormIdVal2 == null || sFormIdVal2 == ""){
		return;
	}
	//var subFormName2Val = jQuery("select[name=subFlowFormName2]").val();
	FormHelper.creatFormfieldOptionsWithDocProp("subFlowFormName2",
			sFormIdVal2, "", function(str) {var func=eval(str);func.call();});
	window.setTimeout("removeSelect('subFlowFormName2');",200);
}

//移除下拉框中的“选择”
function removeSelect(selectObj){
	jQuery("select[name=" + selectObj + "] option[index=0]").remove();
}

//===========参数传递--start===========
//绑定数据1
function doPeddingData(pFormVal,sFormVal,scriptStr,paramType){
	if(paramType == 02){//表单映射
		var peddingDataStr = "<tr><td><div>" + pFormVal + "</div><div>  <-->  </div><div>";
		peddingDataStr += sFormVal + "</div></td><td width='50px' align='center'>";
		peddingDataStr += "<input type='button' onclick='delPeddingData(this)' id='delPedding' value='取消'/></td></tr>";
		jQuery("#peddingData").append(peddingDataStr);
	}else{//iScript脚本
		var peddingStr = "<tr><td><div>" + sFormVal + "</div><div>  <-->  </div><div>";
		peddingStr += "<button type=\"button\" class=\"button-image\"";
		peddingStr += "onclick=\"openIscriptEditor('iScript" + sFormVal + "','{*[Script]*}{*[Editor]*}','{*[IScript.Script]*}','name','{*[Save]*}{*[Success]*}');\">";
		peddingStr += "<img alt=\"{*[page.Open_with_IscriptEditor]*}\" src=\"<s:url value='/resource/image/editor.png' />\"/>";
		peddingStr += "</button><input type='hidden' onpropertychange='changepeddingData2(this);' name='iScript" + sFormVal + "' value='" + scriptStr + "'/>";
		peddingStr += "</div></td><td width='50px' align='center'><input type='button' onclick='delPeddingData2(this)' id='delPedding' value='取消'/></td></tr>";
		jQuery("#peddingData2").append(peddingStr);
		
	}
	window.setTimeout("removePeddingSelect('"+ pFormVal+"','"+sFormVal+"','"+paramType+"')",200);
}

//移除己绑定的字段
function removePeddingSelect(pFormVal,sFormVal,paramType){
	if(paramType == 02){//表单映射
		//移除选项
		jQuery("select[name=parentFlowFormName] option[text=" + pFormVal + "]").remove();
		jQuery("select[name=subFlowFormName] option[text=" + sFormVal + "]").remove();	
	}else{
		//移除选项
		jQuery("select[name=subFlowFormName2] option[text=" + sFormVal + "]").remove();
		jQuery("textarea[name=paramPassingScript]").val("");
	}
	
}

//取消绑定1--表单映射
function delPeddingData(obj){
	var divNodes = obj.parentNode.previousSibling.childNodes;
	var pFormVal = divNodes[0].innerHTML;
	var sFormVal = divNodes[2].innerHTML;
	obj.parentNode.parentNode.removeNode(true);
	jQuery("select[name=parentFlowFormName]").append("<option value='Value'>" + pFormVal + "</option>");  
	jQuery("select[name=subFlowFormName]").append("<option value='Value'>" + sFormVal + "</option>");
	doDeleteFieldMappingItem(sFormVal,"02");
}

//取消绑定2--iScript脚本
function delPeddingData2(obj){
	var divNodes = obj.parentNode.previousSibling.childNodes;
	var sFormVal = divNodes[0].innerHTML;
	obj.parentNode.parentNode.removeNode(true);
	jQuery("select[name=subFlowFormName2]").append("<option value='Value'>" + sFormVal + "</option>");
	doDeleteFieldMappingItem(sFormVal,"03");
}
//===========参数传递--end===========


//@author--jack
jQuery(document).ready(function(){
	//===========设置传递过来的参数值--start===========
	var oldAttr=OBPM.dialog.getArgs()["oldAttr"];
	try{
	    if (oldAttr != null) {
		  	//设置默认值
		  	if(oldAttr.subFlowDefiType == "" || oldAttr.subFlowDefiType == null) oldAttr.subFlowDefiType = "01";
		  	if(oldAttr.numberSetingType == "" || oldAttr.numberSetingType == null) oldAttr.numberSetingType = "01";
		  	if(oldAttr.paramPassingType == "" || oldAttr.paramPassingType == null) oldAttr.paramPassingType = "01";
		  	if(oldAttr.callback == "" || oldAttr.callback == null) oldAttr.callback = "true";

		  	if(oldAttr.issplit == "" || oldAttr.issplit == null) oldAttr.issplit = "false";
		  	if(oldAttr.isgather == "" || oldAttr.isgather == null) oldAttr.isgather = "false";
		  	
			//基本信息
			document.tmp.name.value = oldAttr.name;
			document.tmp.subflowid.value = HTMLDencode(oldAttr.subflowid);
		  	document.tmp.statelabel.value = oldAttr.statelabel;
		  	jQuery("input[name=subFlowDefiType][value=" + oldAttr.subFlowDefiType + "]").attr("checked","true");
			
			if(oldAttr.subFlowDefiType == 01){
				jQuery("#subflowPredef").css("display","inline");
				jQuery("input[name=subflowname]").val(oldAttr.subflowname);
			}else if(oldAttr.subFlowDefiType == 02){
				jQuery("#subIScript").css("display","inline");
				jQuery("textarea[name=subflowScript]").val(HTMLDencode(oldAttr.subflowScript));
			}
			
			//启动
			jQuery("input[name=numberSetingType][value=" + oldAttr.numberSetingType + "]").attr("checked","true");
			var numberSetingType = jQuery("input[name=numberSetingType]").val();
			var numberSetingContent = jQuery("input[name=numberSetingContent]").val();
			jQuery("input[name=numberSetingContent]").val(oldAttr.numberSetingContent);
			if(oldAttr.numberSetingType == 01){
				jQuery("#subflowPredef2").css("display","inline");
				jQuery("input[name=subflowPredef2]").val(oldAttr.numberSetingContent);
			}else if(oldAttr.numberSetingType == 02){
				jQuery("#parentColumId").css("display","inline");
				jQuery("input[name=parentFormId]").val(oldAttr.parentFlowFormId);
				jQuery("input[name=parentFormNameText]").val(oldAttr.parentFlowFormId);
				parentFormIdLoad();
				//alert("oldAttr.numberSetingContent = " + oldAttr.numberSetingContent);
				//jQuery("select[name=parentColum]").find("option[value=" + oldAttr.numberSetingContent + "]").attr("selected","selected");
				jQuery("select[name=parentColum]").val(oldAttr.numberSetingContent);
			}else if(oldAttr.numberSetingType == 03){
				jQuery("#subIScript2Id").css("display","inline");
				jQuery("textarea[name=subIScript2]").val(HTMLDencode(oldAttr.numberSetingContent));
			}

			//审批设置
			var selectList=document.getElementById("splitStartNode");
			selectList.options.add(new Option("--{*[Select]*}--",""));
			if(oldAttr.getAllSplitNode != null){
				var nodes = oldAttr.getAllSplitNode.split(",");
				for(var i=0; i<nodes.length; i++){
					var stropt = nodes[i];
					if(stropt!=''){
						var opt =stropt.split("=");
						selectList.options.add(new Option(opt[1],opt[0]));
					}
				}
			}
			if(oldAttr.splitStartNode!=null){
				selectList.value = oldAttr.splitStartNode;
			}

			var issplits = jQuery("input[name=issplit]");
			if(issplits[0].value == oldAttr.issplit.toString()){
				issplits[0].checked = "checked";
			}else
				issplits[1].checked = "checked";

			var isgathers = jQuery("input[name=isgather]");
			if(isgathers[0].value == oldAttr.isgather.toString()){
				isgathers[0].checked = "checked";
				isgatherEvent(true);
				jQuery("select[name=splitStartNode]").val(oldAttr.splitStartNode);
			}else
				isgathers[1].checked = "checked";
			if(oldAttr.isToPerson == true || oldAttr.isToPerson == "true")
				jQuery("input[name=isToPerson]").attr("checked","checked");
			
			
			
			//参数传递
		  	jQuery("input[name=paramPassingType][value=" + oldAttr.paramPassingType + "]").attr("checked","true");
		  	if(oldAttr.paramPassingType == 02){
		  		jQuery("#FormMapping").css("display","inline");
				jQuery("input[name=parentFlowFormId]").val(oldAttr.parentFlowFormId);
				jQuery("input[name=parentFlowFormNameText]").val(oldAttr.parentFlowFormId);
				jQuery("input[name=subFlowFormId]").val(oldAttr.subFlowFormId);
				jQuery("input[name=subFlowFormNameText]").val(oldAttr.subFlowFormId);
				jQuery("select[name=parentFlowFormName]").val(oldAttr.parentFlowFormName);
				jQuery("select[name=subFlowFormName]").val(oldAttr.subFlowFormName);
		  		jQuery("input[name=fieldMappingXML]").val(oldAttr.fieldMappingXML);
				jQuery("select[name=subFlowFormName]").val(oldAttr.subFlowFormName);
		  		parentFlowFormIdLoad();
		  		subFlowFormIdLoad();
		  		selectFormName("parentFlowFormName",oldAttr.parentFlowFormId);
		  		//selectFormName("subFlowFormName",oldAttr.subFlowFormId);
		  		loadPeddingData(oldAttr.fieldMappingXML,oldAttr.paramPassingType);
			}else if(oldAttr.paramPassingType == 03){
		  		jQuery("#paramPassingScriptId").css("display","inline");
				jQuery("input[name=subFlowFormId2]").val(oldAttr.subFlowFormId);
				jQuery("select[name=subFlowFormName2Text]").val(oldAttr.subFlowFormName);
		  		jQuery("textarea[name=paramPassingScript]").val(HTMLDencode(oldAttr.paramPassingScript));
				subFlowFormId2Load();
				loadPeddingData(oldAttr.fieldMappingXML,oldAttr.paramPassingType);
		  	}
		  	
		  	//流程等待
		  	jQuery("input[name=callback][value=" + oldAttr.callback + "]").attr("checked","true");
		  	oldAttr.callback = jQuery("input[name=callback]:checked").val();
		  	if(oldAttr.callback == 'true'){
				jQuery("#launchLater").css("display","inline");
		  		jQuery("textarea[name=callbackScript]").val(HTMLDencode(oldAttr.callbackScript));
		  	}
		}
	 }catch(ex){}
	 
	//===========设置传递过来的参数值--end===========

	//===========设置样式--start===========
	jQuery("label[for=_subFlowDefiType01]").css("width","100");
	jQuery("label[for=_subFlowDefiType02]").css("width","100");
	
	jQuery("label[for=_numberSetingType01]").css("width","100");
	jQuery("label[for=_numberSetingType02]").css("width","150");
	jQuery("label[for=_numberSetingType03]").css("width","100");
	jQuery("label[for=_numberSetingType04]").css("width","150");
	
	jQuery("label[for=_callbacktrue]").css("width","280");
	jQuery("label[for=_callbackfalse]").css("width","280");
	//===========设置样式--end===========


	//===========保存--start===========
	jQuery("#confirm").click(function(){
		if(tmp.name.value==''){
	    	alert("{*[page.name.notexist]*}!");
	      	return;
	  	}
	  	var numberSetingType = jQuery("input[name=numberSetingType]:checked").val();
	  	var paramPassingType = jQuery("input[name=paramPassingType]:checked").val();
	  	if(numberSetingType == 01){
			if(tmp.subflowPredef2.value == null||tmp.subflowPredef2.value == ""){
				alert("{*[Please]*}{*[Input]*}{*[Predefined]*}{*[Value]*}");
				return;
			}else if(isNaN(tmp.subflowPredef2.value)){
				alert("{*[cn.myapps.core.workflow.must_be_num]*}");
				return;
			}
		}
	  	if(numberSetingType == 02 && paramPassingType == 02){
		  	var parentFormIdVal = jQuery("input[name=parentFormId]").val();
		  	var parentFlowFormIdVal = jQuery("input[name=parentFlowFormId]").val();
		  	if(parentFormIdVal != parentFlowFormIdVal){
		  		alert("{*[启动和参数传递的父表单要相同]*}!");
		      	return;
		  	}
		}
		
		var actorAttr=new Object();
		
		//基本信息
	  	actorAttr.name = document.tmp.name.value;
	   	actorAttr.statelabel = document.tmp.statelabel.value;
	   	actorAttr.subFlowDefiType = jQuery("input[name=subFlowDefiType]:checked").val();
		actorAttr.subflowid = jQuery("input[name=subflowid]").val();
		actorAttr.subflowname = jQuery("input[name=subflowname]").val();
	  	
	  	//启动
		actorAttr.subflowScript = jQuery("textarea[name=subflowScript]").val();
	   	actorAttr.numberSetingType = jQuery("input[name=numberSetingType]:checked").val();
	   	actorAttr.numberSetingContent = jQuery("input[name=numberSetingContent]").val();

	   	//审批设置
	   	actorAttr.issplit = jQuery("input[name=issplit]:checked").val();
	   	actorAttr.isgather = jQuery("input[name=isgather]:checked").val();
	   	if(actorAttr.isgather == true || actorAttr.isgather == "true"){
	   		actorAttr.splitStartNode = jQuery("select[name=splitStartNode]").find("option:selected").val();
		}
	   	actorAttr.isToPerson = jQuery("input[name=isToPerson]").val();
	   	
	   	//参数传递
		actorAttr.paramPassingType = jQuery("input[name=paramPassingType]:checked").val();
	   	actorAttr.parentFlowFormId = jQuery("input[name=parentFlowFormId]").val();
	   	if(actorAttr.paramPassingType == 01){//共享父表单
	   	}else if(actorAttr.paramPassingType == 02){//表单映射
	   		actorAttr.subFlowFormId = jQuery("input[name=subFlowFormId]").val();
	   		actorAttr.subFlowFormName = jQuery("select[name=subFlowFormName]").find("option:selected").val();
	   	}else{//iScript脚本
	   		actorAttr.subFlowFormId = jQuery("input[name=subFlowFormId2]").val();
	   		actorAttr.subFlowFormName = jQuery("select[name=subFlowFormName2]").find("option:selected").val();
	   	}
	   	actorAttr.parentFlowFormName = jQuery("select[name=parentFlowFormName]").find("option:selected").val();
	   	
		//初始化 fieldMappingXML ------------------------
		DWREngine.setAsync(false);
		if(actorAttr.paramPassingType == 02){
			FieldMappingUtil.parseObject(fieldMappingCache, function(xml){
				DWRUtil.setValue('fieldMappingXML', xml);
			});
		}else if(actorAttr.paramPassingType == 03){
			FieldMappingUtil.parseObject(fieldMappingCache2, function(xml){
				DWRUtil.setValue('fieldMappingXML', xml);
			});
		}
		//初始化 fieldMappingXML  ------------------------
	   	actorAttr.fieldMappingXML = jQuery("input[name=fieldMappingXML]").val();
	   	
	  	
	   	//流程等待
	   	actorAttr.callback = jQuery("input[name=callback]:checked").val();
	   	actorAttr.callbackScript = jQuery("textarea[name=callbackScript]").val();
	  	OBPM.dialog.doReturn(actorAttr);
	});
	//===========保存--end===========
	

	//===========退出--start===========
	jQuery("#exit").click(function(){
  		OBPM.dialog.doReturn();
  	});
	//===========退出--end===========
	
	
	//===========菜单切换--start===========
	var objChecked = "BaseInfo";	//当前选中的菜单
	//添加菜单点击事件
	//实现页面和菜单样式切换功能
	jQuery("#divMenu > div > input").click(function(){
		jQuery("#" + objChecked).css("display","none");
		jQuery("input[name=" + objChecked + "]").removeClass("btcaption-s-selected");
		objChecked = this.name;
		jQuery("#" + objChecked).css("display","block");
		jQuery("input[name=" + objChecked + "]").addClass("btcaption-s-selected");
	});
	//===========菜单切换--end===========
	
	
	//===========基本信息--start===========
	//添加子流程单选按钮点击事件
	//实现预定义和IScript的切换
	jQuery("input[name=subFlowDefiType]").click(function(){
		if(this.value == 01){
			jQuery("#subflowPredef").css("display","inline");
			jQuery("#subIScript").css("display","none");
			//显示参数传递中的表单映射
			jQuery("#_paramPassingType02").css("display","inline");
			jQuery("label[for=_paramPassingType02]").css("display","inline");
		}else{
			jQuery("#subflowPredef").css("display","none");
			jQuery("#subIScript").css("display","inline");
			//隐藏参数传递中的表单映射
			if(jQuery("input[name=paramPassingType]").val() == 02){
				jQuery("#_paramPassingType01").attr("checked","true");
			}
			jQuery("#_paramPassingType02").css("display","none");
			jQuery("label[for=_paramPassingType02]").css("display","none");
			jQuery("#FormMapping").css("display","none");
		}
	});
	//===========基本信息--end===========
	
	
	//===========启动--start===========
	//添加启动实例数单选按钮点击事件
	//实现预定义、父表单字段值和IScript的切换
	jQuery("input[name=numberSetingType]").click(function(){
		if(this.value == 01){
			jQuery("#subflowPredef2").css("display","inline");
			jQuery("#parentColumId").css("display","none");
			jQuery("#subIScript2Id").css("display","none");
			
			//设置传回的隐藏域的值
			jQuery("input[name=numberSetingContent]").val(document.tmp.subflowPredef2.value);
		}else if(this.value == 02){
			jQuery("#subflowPredef2").css("display","none");
			jQuery("#parentColumId").css("display","inline");
			jQuery("#subIScript2Id").css("display","none");
			
			//设置传回的隐藏域的值
			jQuery("input[name=numberSetingContent]").val(jQuery("select[name=parentColum]").find("option:selected").val());
		}else if(this.value == 03){
			jQuery("#subflowPredef2").css("display","none");
			jQuery("#parentColumId").css("display","none");
			jQuery("#subIScript2Id").css("display","inline");
			
			//设置传回的隐藏域的值
			jQuery("input[name=numberSetingContent]").val(jQuery("textarea[name=subIScript2]").val());
		}else if(this.value == 04){
			jQuery("#subflowPredef2").css("display","none");
			jQuery("#parentColumId").css("display","none");
			jQuery("#subIScript2Id").css("display","none");
		}
	});
	
	//值改变时重新设置传回的隐藏域值
	jQuery("input[name=subflowPredef2]").change(function(){
		jQuery("input[name=numberSetingContent]").val(jQuery("input[name=subflowPredef2]").val());
	});	
	
	//选项改变时重新设置传回的隐藏域值
	jQuery("select[name=parentColum]").change(function(){
		jQuery("input[name=numberSetingContent]").val(jQuery("select[name=parentColum]").find("option:selected").val());
	});
	
	//选项改变时重新设置传回的隐藏域值
	jQuery("textarea[name=subIScript2]").change(function(){
		jQuery("input[name=numberSetingContent]").val(jQuery("textarea[name=subIScript2]").val());
	});
	//===========启动--end===========
	
		
	//===========参数传递--start===========
	//子流程为"通过iScript指定"时隐藏"参数传递"中的"表单映射"
	if(jQuery("#paramPassingType").val() == 02){
		jQuery("#_paramPassingType1").css("display","none");
		jQuery("label[for=_paramPassingType1]").css("display","none");
	}
	
	//添加参数传递方式单选按钮点击事件
	//实现共享父表单、表单映射和iScript脚本的切换
	jQuery("input[name=paramPassingType]").click(function(){
		if(this.value == 01){//共享父表单
			jQuery("#shareParentForm").css("display","inline");
			jQuery("#FormMapping").css("display","none");
			jQuery("#paramPassingScriptId").css("display","none");
		}else if(this.value == 02){//表单映射
			jQuery("#shareParentForm").css("display","none");
			jQuery("#FormMapping").css("display","inline");
			jQuery("#paramPassingScriptId").css("display","none");
			if(jQuery("#peddingData").text() == ""){
				parentFlowFormIdLoad();
				subFlowFormIdLoad();
			}
		}else{//iScript脚本
			jQuery("#shareParentForm").css("display","none");
			jQuery("#FormMapping").css("display","none");
			jQuery("#paramPassingScriptId").css("display","inline");
			if(jQuery("#peddingData2").text() == ""){
				subFlowFormId2Load();
			}
		}
	});

	//iScript子表单改变时更换表单字段
	jQuery("input[name=subFlowFormId2]").change(function(){
		subFlowFormId2Load();
		//清除绑定
		jQuery("#peddingData2").html("");
	});
	
	//绑定数据1--表单映射
	jQuery("#peddingForm").click(function(){
		var pFormVal = jQuery("select[name=parentFlowFormName]").find("option:selected").text();
		var sFormVal = jQuery("select[name=subFlowFormName]").find("option:selected").text();
		if(pFormVal == "" || pFormVal == null){
			alert("{*[Please.change.parent.form.colum]*}");
			return;
		}
		if(sFormVal == "" || sFormVal == null){
			alert("{*[Please.change.sub.form.colum]*}");
			return;
		}
		
		//创建字段参数映射项
		doCreateFieldMappingItem(pFormVal,sFormVal,'','02');
		
		//生成绑定
		doPeddingData(pFormVal,sFormVal,"","02");
	});	
	
	//绑定数据2--iScript脚本
	jQuery("#peddingForm2").click(function(){
		//var pFormVal = jQuery("select[name=parentFlowFormName]").find("option:selected").text();
		var sFormVal = jQuery("select[name=subFlowFormName2]").find("option:selected").text();
		var iScriptVal = jQuery("textarea[name=paramPassingScript]").val();
		
		if(sFormVal == "" || sFormVal == null){
			alert("{*[Please.change.sub.form.colum]*}");
			return;
		}
		
		//去掉左右空格
		iScriptVal = iScriptVal.replace(/\s+$|^\s+/g,"");
		if(iScriptVal == "" || iScriptVal == null){
			alert("{*[请输入IScript]*}");
			return;
		}
		
		//创建字段参数映射项
		doCreateFieldMappingItem("",sFormVal,iScriptVal,"03");
		
		//生成绑定
		doPeddingData("",sFormVal,iScriptVal,"03");
	});
	//===========参数传递--end===========
	
	
	//===========流程等待--start===========
	//添加回调等待设置单选按钮点击事件
	//实现内容切换功能
	jQuery("input[name=callback]").click(function(){
		if(this.value == 'true'){
			jQuery("#launchLater").css("display","inline");
		}else{
			jQuery("#launchLater").css("display","none");
		}
	});
	//===========流程等待--end===========

	//===========流程等待--end===========
	jQuery(".addFlowForm").click(function(){
	  	var url = contextPath + '/core/workflow/billflow/defi/selectsubform.action?application=<s:property value="#parameters.application"/>' ;
	  	//var rtn = showframe('{*[Please choose a form]*}', url);
	  	var objId = this.name.substring(3,this.name.length);
	  	var objName = objId.replace("Id","Name");
	  	objName += "Text";
	  	//var objName = objId.substring(0,objId.length-2) + "Name";
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {},
			title: '{*[Select]*}{*[SubForm]*}',
			close: function(rtn) {
			    var t = rtn.split(";");
			    var objIdVal = jQuery("input[name=" + objId + "]").val();
			    var objNameVal = jQuery("input[name=" + objName + "]").val();
				if (rtn == null || rtn == 'undefined') {
				}
				else if (rtn == '') {
					jQuery("input[name=" + objId + "]").val("");
					jQuery("input[name=" + objName + "]").val("");
				}else{
					jQuery("input[name=" + objId + "]").val(t[0]);
					jQuery("input[name=" + objName + "]").val(t[1]);
				}
				eval(objId + "Load()");
			}
		});
	});
	//===========流程等待--end===========
});

//创建字段参数映射项
function doCreateFieldMappingItem(parentField,subField,script,paramType){
	var fieldMappingItem = new FieldMappingItem();
	DWREngine.setAsync(false);
	fieldMappingItem.parentField = parentField;
	fieldMappingItem.subField = subField;
	fieldMappingItem.script = script;
	
	if(paramType == 02){
		fieldMappingCache.push(fieldMappingItem);
	}else if(paramType == 03){
		fieldMappingCache2.push(fieldMappingItem);
	}
}

//登录时生成绑定数据
function loadPeddingData(xmlStr,paramType){
	if(xmlStr == null || xmlStr == ""){
		return;
	}
	DWREngine.setAsync(false);
	if(paramType == 02){
		FieldMappingUtil.parseXML(xmlStr, function(fieldMappingItems){
			fieldMappingCache = fieldMappingItems;
		});
		for(var i=0;i<fieldMappingCache.length;i++){
			var fieldMappingItem = fieldMappingCache[i];
			//生成绑定
			doPeddingData(fieldMappingItem.parentField, fieldMappingItem.subField, fieldMappingItem.script, paramType);
		}
	}else if(paramType == 03){
		FieldMappingUtil.parseXML(xmlStr, function(fieldMappingItems){
			fieldMappingCache2 = fieldMappingItems;
		});
		
		for(var i=0;i<fieldMappingCache2.length;i++){
			var fieldMappingItem = fieldMappingCache2[i];
			//生成绑定
			doPeddingData(fieldMappingItem.parentField, fieldMappingItem.subField, fieldMappingItem.script, paramType);
		}
		
	}
}


//修改iScript子表单字段对应的iScript
function doUpdateFieldMappingItem(subField,scriptStr) {
	for(var i=0;i<fieldMappingCache2.length;i++){
		var fieldMappingItem = fieldMappingCache2[i];
		if(fieldMappingItem.subField == subField){
			fieldMappingCache2[i].script = scriptStr;
			fieldMappingCache2 = jQuery.grep(fieldMappingCache2,function(val,key){
				return val==null || val== undefined;
			},true);
			return;
		}
	}	
}

//删除绑定时修改xml内容
function doDeleteFieldMappingItem(sFormVal,paramType) {
	if(paramType == 02){
		for(var i=0;i<fieldMappingObj.length;i++){
			var fieldMappingItem = fieldMappingObj[i];
			if(fieldMappingItem.subField == sFormVal){
				fieldMappingObj[i] = null;
				fieldMappingObj = jQuery.grep(fieldMappingObj,function(val,key){
					return val==null || val== undefined;
				},true);
				return;
			}
		}
	}else if(paramType == 03){
		for(var i=0;i<fieldMappingObj2.length;i++){
			var fieldMappingItem = fieldMappingObj2[i];
			if(fieldMappingItem.subField == sFormVal){
				fieldMappingObj2[i] = null;
				fieldMappingObj2 = jQuery.grep(fieldMappingObj2,function(val,key){
					return val==null || val== undefined;
				},true);
				return;
			}
		}
	}
}

//删除绑定时修改xml内容
function doDeleteFieldMappingItem(subField) {
	for(var i=0;i<fieldMappingCache.length;i++){
		var fieldMappingItem = fieldMappingCache[i];
		if(fieldMappingItem.subField == subField){
			fieldMappingCache[i] = null;
			fieldMappingCache = jQuery.grep(fieldMappingCache,function(val,key){
				return val==null || val== undefined;
			},true);
			return;
		}
	}	
}

//查询子流程表单
function selectSubflow(){
	var url = contextPath + '/core/workflow/billflow/defi/selectflow.action?application=<%=applicationid%>' ;
	OBPM.dialog.show({
		opener:window.parent.parent,
		width: 700,
		height: 500,
		url: url,
		args: {},
		title: '{*[Select]*}{*[SubFlow]*}',
		close: function(rtn) {
			if (rtn == null || rtn == 'undefined') {
		 	}else if (rtn == '') {
		    	tmp.subflowid.value = "";
		    	tmp.subflowname.value = "";
		  	}else{
		    	var t = rtn.split(";");
		    	tmp.subflowid.value = t[0];
		    	tmp.subflowname.value = t[1];
		  	}
		}
	});
}

//iScript子表单字段的iScript(隐藏域)改变时重新构建xml
function changepeddingData2(obj){
	var sFormVal = obj.name.substring(7,obj.name.length);
	var scriptStr = obj.value;
	doUpdateFieldMappingItem(sFormVal,scriptStr);
}


function isgatherEvent(s){
	if(s == true || s == 'true'){
		//document.getElementById("splitStartNode").style.display="";
		document.getElementById("splitStartNodeLabel").style.display="";
	}else{
		//document.getElementById("splitStartNode").style.display='none';
		document.getElementById("splitStartNodeLabel").style.display="none";
	}
}

//查询子流程表单名称
function selectFormName(ObjName,idVal){
	if(idVal == null || idVal == ""){
		return;
	}
	var url = contextPath + "/core/dynaform/form/selectFormName.action";
	jQuery.ajax({
			url:url,
			type:"post",
			datatype:"json",
			data:{"_formid": idVal,"application":"<%=applicationid%>"},
			success:function(data){
				//alert("data = " + data);
				//jQuery("input[name=" + ObjName + "]").val(data.name);
			}
	});	
}
</SCRIPT>

<style type="text/css">
body {
	padding: 0px;
	margin: 0px;
}

.bigTable {
	border-bottom: 1px solid dotted;
	border-color: black;
	width: 100%;
	margin: 5px;
}

.divMenu {
	padding-left: 15px;
	padding-right: 0px;
	margin: 0px;
}

.divShow {
 margin: 10px;
}

.divShow table {
	width: 100%;
}

.launch table {
	width: 100%;
}

.input-cmd {
	width: 80%;
	align: left;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	margin: 1px;
	padding: 1px;
}

.peddingData {
	border: #d8dadc 1px solid;
	border-collapse: collapse;
	width: 100%;	

}

.peddingData td {
	border: #d8dadc 1px solid;

}

.peddingData div {
	float: left;
	padding-left: 10px;
	max-width: 200px;
}

.columTd div {
	margin: 3px;
}

</style>
</head>
<body>

<s:form name="tmp" action="" method="post" theme="simple">
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="formHelper" >
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<table class="bigTable" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[SubFlow]*}{*[Info]*}</td>
		<td align="right">
		<table border=0 cellpadding="0" cellspacing="0">
			<tr>
				<td valign="top">
					<button type="button" class="button-image" id="confirm">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
					</button>
				</td>
				<td valign="top">
					<button type="button" class="button-image" id="exit">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div style="margin-left:auto; margin-right:auto; text-align: center; overflow:auto;">
<div id="divMenu" class="divMenu nav-s-td">
	<div class="listContent" style="color:red;">
		<input type="button" name="BaseInfo" class="btcaption btcaption-s-selected" value="{*[cn.myapps.core.workflow.basic_info]*}" />
	</div>
	<div class="listContent nav-seperate">
		<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
	</div>
	<div class="listContent">
		<input type="button" name="launch" class="btcaption" value="{*[Startup]*}" />
	</div>
	<div class="listContent nav-seperate">
		<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
	</div>	
	<div class="listContent">
		<input type="button" name="auditSetting" class="btcaption" value="{*[Audit]*}{*[Setup]*}" />
	</div>
	<div class="listContent nav-seperate">
		<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
	</div>
	<div class="listContent">
		<input type="button" name="ParamTransfer" class="btcaption" value="{*[Params.transfer]*}" />
	</div>
	<div class="listContent nav-seperate">
		<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
	</div>
	<div class="listContent">
		<input type="button" name="WorkFlowWait" class="btcaption" value="{*[Flow.wait]*}" />
	</div>
</div>
<!-- 基本信息 -->
<div id="BaseInfo" class="divShow" style="display: block;">
	<s:hidden name="subflowid"></s:hidden>
	<table>
		<tr>
			<td width="50%">{*[Name]*}：</td>
			<td width="50%">{*[State_Label]*}：</td>
		</tr>
		<tr>
			<td>
				<s:textfield cssClass="input-cmd" name="name"/>
			</td>
			<td>
				<s:textfield cssClass="input-cmd" name="statelabel"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">{*[SubFlow]*}：
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<s:radio name="subFlowDefiType" list="#{'01':'{*[Through.Predefined.extends]*}','02':'{*[Through.iScript.extends]*}'}"
					theme="simple"></s:radio>
			</td>
		</tr>
		<tr id="subflowPredef" style="display: none;">
			<td colspan="2">
			 	<s:textfield name="subflowname" cssStyle="width:200px;" readonly="true" />
				<input type="button" class="button-cmd" onclick="selectSubflow()" value="{*[Select]*}"/>
			</td>
		</tr>
		<tr id="subIScript" style="display: none;">
			<td colspan="2">
				<div>{*[IScript.Script]*}：
					<button type="button" class="button-image" onclick="openIscriptEditor('subflowScript',
						'{*[Script]*}{*[Editor]*}','{*[IScript.Script]*}','name','{*[Save]*}{*[Success]*}');">
						<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
					</button>
				</div>
				<div>
					<s:textarea name="subflowScript" cssStyle="width: 500px; height: 200px;"></s:textarea>
				</div>
			</td>
		</tr>
	</table>
</div>
<!-- 启动 -->
<div id="launch" class="divShow" style="display: none;">
	<s:hidden name="numberSetingContent"></s:hidden>
	<table>
		<tr>
			<td>{*[Startup.example.count]*}：</td>
		</tr>
		<tr>
			<td>
				<s:radio name="numberSetingType" theme="simple"
					list="#{'01':'{*[Through.Predefined.extends]*}','02':'{*[Through.parent.form.extends]*}','03':'{*[Through.iScript.extends]*}','04':'{*[from.approver.group.amount]*}'}"></s:radio>
			</td>
		</tr>
		
		<tr id="subflowPredef2" style="display: none;">
			<td colspan="2" class="columTd">
				<div>{*[Predefined]*}：</div>
				<div>
					<s:textfield name="subflowPredef2"></s:textfield>
				</div>
			</td>
		</tr>
		
		<tr id="parentColumId" style="display: none;">
			<td colspan="2" class="columTd">
				<div>{*[Parentflow.form]*}：
				</div>
				<div>
        			<input type="hidden" name="parentFormId">
		          	<input type="text" name="parentFormNameText" class="input-cmd" style="width:230px;" readonly>
		          	<input type="button" name="bt_parentFormId" class="button-cmd addFlowForm" value="{*[Select]*}"/>
					<!-- select name="parentFormId" cssStyle="width:200px;" 
						list="#formHelper.get_normalFormList(#parameters.application)" listKey="id" listValue="name"></-->
				</div>
				<div>{*[Parent.form.colum]*}：
				</div>
				<div>
					<s:select id="addABCD" name="parentColum" cssStyle="width:200px;" list="{}" listKey="id" listValue="name"></s:select>
				</div>
			</td>
		</tr>
		
		<tr id="subIScript2Id" style="display: none;">
			<td colspan="2" class="columTd">	
				<div>{*[IScript.Script]*}：
					<button type="button" class="button-image" 
						onclick="openIscriptEditor('subIScript2','{*[Script]*}{*[Editor]*}','{*[IScript.Script]*}','name','{*[Save]*}{*[Success]*}');">
						<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
					</button>
				</div>
				<div>
					<s:textarea name="subIScript2" cssStyle="width: 500px; height: 200px;"></s:textarea>
				</div>
			</td>
	</table>
</div>
<!-- 审批设置 -->
<div id="auditSetting" class="divShow" style="display: none;">
		<table class="table_noborder">
			<tr>
				<td class="commFont" style="display: none;">{*[Distribute]*}:</td>
				<td class="commFont">{*[Centralized]*}:</td>
			</tr>
			<tr>
			
				<td align="left" style="display: none;">
				 <input type="radio" name="issplit" value="true">{*[step-by-step_approval_current_node,select_multiple_nodes]*}<br/>
				 <input type="radio" name="issplit" value="false" checked="checked">{*[step-by-step_approval_current_node_only_choose]*}  
				</td>
				<td align="left">
				 <input type="radio" name="isgather" onclick="isgatherEvent(this.value)" value="true">{*[step-by-step_approval_node,select_multiple_nodes]*}
				 <div id="splitStartNodeLabel" style="display:none"><font color="red">分散{*[StartNode]*}:</font>
				 <select id="splitStartNode" name="splitStartNode"></select>
				 </div>
				<br/>
				 <input type="radio" name="isgather"  onclick="isgatherEvent(this.value)" value="false" checked="checked"/>{*[multiple-step_approval_nodes,completion_one_node,arrival_process]*}  
				</td>
			</tr>
			<tr>
				<td>
					<input name="isToPerson" type="checkbox" id="isToPerson" value="true" />{*[Specify]*}{*[Auditor]*}
				</td>
			</tr>
		</table>
</div>
<!-- 参数传递 -->
<div id="ParamTransfer" class="divShow" style="display: none">
	<table>
		<tr>
			<td>{*[Params.transfer.type]*}：</td>
		</tr>
		<tr>
			<td>
				<s:radio name="paramPassingType" list="#{'01':'{*[Share.parent.form]*}',
					'02':'{*[Form.mapping]*}','03':'{*[IScript.Script]*}'}" theme="simple"></s:radio>
			</td>
		</tr>
		<tr id="shareParentForm" style="display: none;">
			<td colspan="2">&nbsp;
			</td>
		</tr>
		
		<tr id="FormMapping" style="display: none;">
			<td colspan="2">
				<table>
					<tr>
						<td class="columTd">
							<div>{*[Parentflow.form]*}：</div>
							<div>
        						<input type="hidden" name="parentFlowFormId">
					          	<input type="text" name="parentFlowFormNameText" style="width:230px;" readonly>
					          	<input type="button" name="bt_parentFlowFormId" class="button-cmd addFlowForm" value="{*[Select]*}"/>
								<!-- select name="parentFlowFormId" cssStyle="width:200px;"
									list="#formHelper.get_normalFormList(#parameters.application)" listKey="id" listValue="name"></-->
							</div>
						</td>
						<td></td>
						<td class="columTd">
							<div>{*[Subflow.form]*}：</div>
							<div>
        						<input type="hidden" name="subFlowFormId">
								<input type="text" name="subFlowFormNameText" style="width:230px;" readonly>
					          	<input type="button" name="bt_subFlowFormId" class="button-cmd addFlowForm" value="{*[Select]*}"/>
								<!-- select name="subFlowFormId" cssStyle="width:200px;" 
									list="#formHelper.get_normalFormList(#parameters.application)" listKey="id" listValue="name"></-->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<s:select name="parentFlowFormName" cssStyle="width: 230px; margin-left: 5px;" 
								size="10" list="{}" emptyOption="true" theme="simple"></s:select>
						</td>
						<td>
							<input id="peddingForm" type="button" value="{*[Pedding]*}"/>
						</td>
						<td>
							<s:select name="subFlowFormName" cssStyle="width: 230px; margin-left: 5px;" size="10" list="{}"></s:select>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div>{*[Pedding.result]*}：</div>
							<div>
								<table id="peddingData" class="peddingData">
								</table>
							</div>
							<s:hidden name="fieldMappingXML"></s:hidden>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr id="paramPassingScriptId" style="display: none;">
			<td colspan="2">
				<div style="margin: 10px">
					<div>{*[Subflow.form]*}：</div>
   						<input type="hidden" name="subFlowFormId2">
						<input type="text" name="subFlowFormName2Text" class="input-cmd" style="width:230px;" readonly>
			          	<input type="button" name="bt_subFlowFormId2" class="button-cmd addFlowForm" value="{*[Select]*}"/>
						<!-- select name="subFlowFormId2" cssStyle="width:200px;" 
						list="#formHelper.get_normalFormList(#parameters.application)" listKey="id" listValue="name"></ -->
				</div>
				<div style="float: left; margin-left: 10px; margin-right: 10px; margin-top: 20px;">
					<s:select name="subFlowFormName2" cssStyle="width: 200px; margin-left: 5px;" size="10" list="{}"></s:select>
				</div>
				<div>
					<div>
						{*[IScript.Script]*}：
						<button type="button" class="button-image" 
							onclick="openIscriptEditor('paramPassingScript','{*[Script]*}{*[Editor]*}','{*[IScript.Script]*}','name','{*[Save]*}{*[Success]*}');">
							<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
						</button>
					</div>
					<div>
						<s:textarea name="paramPassingScript" cssStyle="width: 300px; height: 160px;"></s:textarea>
					</div>
				</div>
				<div align="center">
					<input id="peddingForm2" type="button" value="{*[Pedding]*}"/>
				</div>
				<div>
					<div>{*[Pedding.result]*}：</div>
					<div>
						<table id="peddingData2" class="peddingData">
						</table>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
<!-- 流程等待 -->
<div id="WorkFlowWait" class="divShow" style="display: none">
	<table>
		<tr>
			<td>{*[Callback.wait.setting]*}：</td>
		</tr>
		<tr>
			<td>
				<s:radio name="callback" theme="simple" list="#{'true':'{*[All.sub.flow.finish.parent.flow.startup.next.node]*}','false':'{*[Startup.sub.flow.then.parent.flow.startup.next.node.rightnow]*}'}"></s:radio>
			</td>
		</tr>
		<tr id="launchLater" style="display: none;">
			<td>{*[Sub.flow.finish.then.startup.script]*}：
					<button type="button" class="button-image" onclick="openIscriptEditor('callbackScript','{*[Script]*}{*[Editor]*}','{*[IScript.Script]*}','name','{*[Save]*}{*[Success]*}');">
						<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
					</button>
				</div>
				<div>
					<s:textarea name="callbackScript" cssStyle="width: 500px; height: 200px;"></s:textarea>
				</div>
			</td>
		</tr>
	</table>
</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>
