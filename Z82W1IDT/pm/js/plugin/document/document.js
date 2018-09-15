/**
 * 前台皮肤表单页面私有
 */
var activityAction = contextPath + '/portal/dynaform/activity/action.action';
var printAction = contextPath + '/portal/dynaform/document/print.action';

var OPEN_TYPE_DIV = 0x0000115;

/**
 * save and start workflow button
 */
var SAVE_SARTWORKFLOW = 4;
/**
 * 按钮类型保存并新建(新建有一条有旧数据Document)
 */
var SAVE_NEW_WITH_OLD=12;
/**
 * 按钮类型为保存并新建(新建一条空Document)
 */
var SAVE_NEW_WITHOUT_OLD = 17;
/**
 * 按钮类型为更新Document.
 */
var DOCUMENT_UPDATE = 34;

/**
 * 按钮类型为关闭窗口.
 */
var CLOSE_WINDOW = 8;
/**
 * 按钮类型为跳转.
 */
var JUMP = 32;
/**
 * 按钮类型为跳转页面.
 */
var JUMP_PAGE = 39;
/**
 * 按钮类型为转发.
 */
var DISPATCHER  = 37;
/**
 * 按钮类型为返回.
 */
var BACK = 10;
/**
 * 离开表单页面是否检验
 */
var fieldValChanged = false;

/**
 * 表单修改后，是否保存
 */
function ifSubSaveForm(){
	var ifSubSave = true;
	jQuery("#toAll").find("iframe[name='display_view']").each(function(){
		var $conWin = jQuery(this)[0].contentWindow;
		if($conWin && typeof $conWin.getFieldValChanged=="function"){
			if($conWin.getFieldValChanged()){   //表单修改过返回true;
				if(confirm("确实要保存主表单吗?\r\n子表单数据已修改且未保存！\r\n按“确定”继续，或按“取消”留在当前页面。")){
					$conWin.getFieldValChanged(false);
					return false;
				}else{
					ifSubSave = false;
					return false;
				}
			}
		}
	});
	return ifSubSave;
}

function doSave(type, actid) {
	if(isRefreshLoading){	//刷新重计算未执行完时延时保存
		setTimeout(function(){
			doSave(type, actid);
		},200);
		return false;
	}
	var oOperation = document.getElementById("operation");
	if (oOperation) {
		oOperation.value = "doSave";
	}
	ev_action(type, actid);
}

function ev_action(types, actid) {
	ev_action2(types, actid);
}

function ev_action2(type, actid) {
	if(type==10){
		window.history.back();
	}else{
		var url = activityAction;
		if (actid) {
			var view_id = document.getElementById("view_id").value;
			//待办页表单不是弹出框时，关闭窗口的处理
			/*if(view_id==null||view_id.length<1){
				var appid=jQuery("#applicationid").val();
				//location.href=contextPath+"/portal/share/welcome.jsp?application="+appid;
				//return false;
			}*/
			var newUrl = url + '?_activityid=' + actid + '&view_id=' + view_id;
		}
		try {
			$.post(newUrl
					,$(document.forms[0]).serialize()
					,function(result){
			    	//$("span").html(result);
				var keyStr = '<div class="msgSub" msgType="error">';
				var pos = result.indexOf(keyStr);
				if (pos > 0) {
					var msg = result.substring(result.indexOf(keyStr)+keyStr.length);
					msg = msg.substring(0,msg.indexOf('</div>'));

					showMessage("error",'<div class="msgSub" msgType="error">'+ msg + '</div>');
				}
				else {
//					if (result.indexOf("<script>ev_close();</script>") > 0) {
//						ev_close();
//					}
					$("#msg").html(result);
					//alert(result);
					//$(document).html(result);
				}
			});
			
			//document.forms[0].action = newUrl;
			//document.forms[0].submit();
		} catch (ex) {
		}
	}
}

function beforeAct(actTypes){
	var actType = parseInt(actTypes);
	if(actType==CLOSE_WINDOW || actType==JUMP || actType==JUMP_PAGE || actType==DISPATCHER || actType==BACK){
		if(fieldValChanged){//表单内容被修改
			if(!confirm('确实要离开该页面吗?\r\n数据已修改！\r\n按“确定”继续，或按“取消”留在当前页面。')){
				return false;
			}else{
				unbindBeforeUnload();//取消绑定beforeunload事件
			};
		}
	}else{
		unbindBeforeUnload();//取消绑定beforeunload事件
	}
	return true;
}

//ajax执行操作按钮的执行前脚本
function ev_runbeforeScript(actid){
	var flag = false;//执行完脚本后,是否进行下一步提交
	jQuery.ajax({
		type: 'POST',
		async:false, 
		url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + actid,
		dataType : 'text',
		data: jQuery("#document_content").serialize(),
		success:function(result) {
			if(result != null && result != ""){
				result = result.replace(/\n/g,"<br/>");
				result = result.replace(/\r/g,"<br/>");
	        	var jsmessage = eval("(" + result + ")");
	        	var type = jsmessage.type;
	        	var content = jsmessage.content;
	        	
	        	if(type){
	        		if(type == '16'){
		        		alert(content);
		        		flag = false;
		        	}
		        	
		        	if(type == '32'){
		        		var rtn = window.confirm(content);
		        		if(!rtn){
		        			flag = false;
		        		}else {
		        			flag = true;
		        		}
		        	}
	        	}else {
	        		flag = true;
	        	}
	        	
	        	if(flag){
	        		var changedField = jsmessage.changedField;
	        		if(changedField){
	        			var fields = changedField.split(";");
	        			for(var i=0; i<fields.length; i++){
	        				var field = fields[i].split(":");
	        				if(document.getElementsByName(field[0])){
	        					document.getElementsByName(field[0])[0].value = field[1];
	        				}
	        			}
	        		}
	        	}
	        }else {
	        	flag = true;
	        }
		},
		error: function(result) {
			alert("运行脚本出错");
		}
	});
	
	return flag;
}

//查看流程图表
function ev_viewFlow(title) {
	var dateTime = new Date().getTime();
	var _instanceId = document.getElementsByName("content.stateid")[0].value;
	var url = contextPath + "/portal/dynaform/document/viewFlow.action?_docid=" + contentId + "&_instanceId=" + _instanceId + "&dateTime=" + dateTime;
	OBPM.dialog.show({
		width: 600,
		height: 420,
		url: url,
		args: {},
		title: title,
		ok:true,
		okVal:'Close',
		close: function(result) {
			var rtn = result;
		}
	});
}

//查看流程历史
function ev_viewHistory(title) {
	var flag = true;
	var dateTime = new Date().getTime();
	var _instanceId = document.getElementsByName("content.stateid")[0].value;
	var application = document.getElementById("applicationid").value;
	//var url = "<ww:url value='/portal/share/workflow/runtime/flowhis.jsp' />?_docid=<ww:property value='content.id' />&flowStateId=<ww:property value='content.stateid' />&application=<%=dochtmlBean.getDoc().getApplicationid()%>&dateTime=" + dateTime;
	var url = contextPath + "/portal/dynaform/document/showFlowHistory.action?flowStateId=" + _instanceId + "&application=" + application + "&dateTime=" + dateTime;
	//showFrameByDiv(url, '{*[Workflow_History]*}', 700, 550);
	OBPM.dialog.show({
		width: 510,
		height: 540,
		url: url,
		args: {},
		title: title,
		ok:true,
		okVal:'Close',
		close: function(result) {
		}
	});
}

//文件下载
function downloadFile(name,path){
	var url = encodeURI(encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ name + "&filepath=" + path));
	var _tmpwin = window.open(url,"_blank");
	_tmpwin.location.href = url;
}

//流程挂起
function ev_flowHandup(nodertId){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowHandup.action?nodertId=' + nodertId;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}

//流程恢复
function ev_flowRecover(nodertId){
	unbindBeforeUnload();
	document.forms[0].action = contextPath + '/portal/dynaform/document/flowRecover.action?nodertId=' + nodertId;
	if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
	makeAllFieldAble();
	document.forms[0].submit();
}


/*
 * 表单公用的初始化方法
 * for:所有皮肤
 */
function initFormCommon(){
	jqRefactor(); //表单控件jquery重构
}
