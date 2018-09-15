<%@ page pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.workflow.FlowState"%>
<%@ page import="cn.myapps.core.workflow.FlowType"%>
<%@ page import="cn.myapps.core.workflow.element.*"%>
<%@ page import="cn.myapps.core.workflow.storage.definition.ejb.*"%>
<%@ page import="cn.myapps.util.ProcessFactory" %>

<%@page import="cn.myapps.util.StringUtil"%><script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tips.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
</script>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%

	String _nextids = (String) request.getParameter("_nextids") != null ? (String) request.getParameter("_nextids"): "";
	boolean isDisplyAttitude = false;
	boolean isShowHis = false;
	String docState = dochtmlBean.getDoc().getStateLabel();
	String applicationid = dochtmlBean.getDoc().getApplicationid();
	String stateid = (dochtmlBean.getDoc()!=null && dochtmlBean.getDoc().getState()!=null)?dochtmlBean.getDoc().getState().getId():null;
%>
<s:if test=" content.id != null && content.id != ''">
<%
	if (dochtmlBean.getDoc() != null
					&& dochtmlBean.getDoc().getParent() == null)
				if (dochtmlBean.getDoc().getState() != null) {
					StateMachineHelper helper = new StateMachineHelper(
							dochtmlBean.getDoc());
					String htmlText = helper.toFlowHtmlText(dochtmlBean
							.getDoc(), dochtmlBean.getWebUser(),
							dochtmlBean.getFlowAct().getFlowShowType(),request);
					isShowHis = dochtmlBean.getDoc().getStateid() != null;
%>
	<s:token name="token"/>
<%
	if (helper.isDisplyFlow) {
%>	
<style>
.btn-ul {list-style-image: none; margin-left: 0; padding-left: 0;}
.btn-ul li {float:left;display: inline;word-break:keep-all;	margin-right:5px;margin-bottom:3px;}
.flowHtmlText,.flowremark{float:left;max-width:800px;}
.flowHtmlText{padding:7px;}	
.flowHtmlText table{width:auto!important;}
.flowHtmlText table td{width:auto!important;}
.flowremark{padding:13px 10px 0 0;}
.flowremark table{width:auto;}
.button-css{margin-top:10px;}
.button-css div{height: 23px;float: left;}
#handupbutton .btn_left {width:3px;background:url('../../../resource/imgv2/front/main/btn_left.png') no-repeat}
#handupbutton .btn_right {width:3px;background:url('../../../resource/imgv2/front/main/btn_right.png') no-repeat}
#handupbutton .btn_mid {width:50px;background:url('../../../resource/imgv2/front/main/btn_middle.png') repeat-x}
.button-css div a {font-weight:700;line-height:23px;padding-left:18px;background:url('../../../resource/imgv2/front/act/act_5.gif') no-repeat!important}

/**提交按钮风格 begin**/
        /*----------------------------*/
        
        .button
        {
            margin: 3px;
            text-decoration: none;
            font: bold 1.5em 'Trebuchet MS',Arial, Helvetica; /*Change the em value to scale the button*/
            display: inline-block;
            text-align: center;
            color: #fff;
            
            border: 1px solid #9c9c9c; /* Fallback style */
            border: 1px solid rgba(0, 0, 0, 0.3);            
            
            text-shadow: 0 1px 0 rgba(0,0,0,0.4);
            
            box-shadow: 0 0 .05em rgba(0,0,0,0.4);
            -moz-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
            -webkit-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
            
        }
        
        .button, .button span
        {
            -moz-border-radius: .3em;
            border-radius: .3em;
        }
        
        .button span
        {
            border-top: 1px solid #fff; /* Fallback style */
            border-top: 1px solid rgba(255, 255, 255, 0.5);
            display: block;
            padding: 0.5em 2.5em;
            
            /* The background pattern */
            
            background-image: -webkit-gradient(linear, 0 0, 100% 100%, color-stop(.25, rgba(0, 0, 0, 0.05)), color-stop(.25, transparent), to(transparent)),
                              -webkit-gradient(linear, 0 100%, 100% 0, color-stop(.25, rgba(0, 0, 0, 0.05)), color-stop(.25, transparent), to(transparent)),
                              -webkit-gradient(linear, 0 0, 100% 100%, color-stop(.75, transparent), color-stop(.75, rgba(0, 0, 0, 0.05))),
                              -webkit-gradient(linear, 0 100%, 100% 0, color-stop(.75, transparent), color-stop(.75, rgba(0, 0, 0, 0.05)));
            background-image: -moz-linear-gradient(45deg, rgba(0, 0, 0, 0.05) 25%, transparent 25%, transparent),
                              -moz-linear-gradient(-45deg, rgba(0, 0, 0, 0.05) 25%, transparent 25%, transparent),
                              -moz-linear-gradient(45deg, transparent 75%, rgba(0, 0, 0, 0.05) 75%),
                              -moz-linear-gradient(-45deg, transparent 75%, rgba(0, 0, 0, 0.05) 75%);

            /* Pattern settings */
            
            -moz-background-size: 3px 3px;
            -webkit-background-size: 3px 3px;            
        }

        .button:hover
        {
            box-shadow: 0 0 .1em rgba(0,0,0,0.4);
            -moz-box-shadow: 0 0 .1em rgba(0,0,0,0.4);
            -webkit-box-shadow: 0 0 .1em rgba(0,0,0,0.4);
        }
        
        .button:active
        {
            /* When pressed, move it down 1px */
            position: relative;
            top: 1px;
        }
        
        /*----------------------------*/
        
        .button-khaki
        {
            background: #A2B598;
            background: -webkit-gradient(linear, left top, left bottom, from(#BDD1B4), to(#A2B598) );
            background:-moz-linear-gradient(-90deg, #BDD1B4, #A2B598);
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#BDD1B4', EndColorStr='#A2B598');        
        }
        
        .button-khaki:hover
        {           
            background: #BDD1B4;
            background: -webkit-gradient(linear, left top, left bottom, from(#A2B598), to(#BDD1B4) );
            background: -moz-linear-gradient(-90deg, #A2B598, #BDD1B4);
            filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#A2B598', EndColorStr='#BDD1B4');
        }
        
        .button-khaki:active
        {
            background: #A2B598;
        }
        
        /*----------------------------*/        
        
        .button-blue
        {
            background: #4477a1;
            background: -webkit-gradient(linear, left top, left bottom, from(#81a8cb), to(#4477a1) );
            background: -moz-linear-gradient(-90deg, #81a8cb, #4477a1);
            filter:  progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#81a8cb', endColorstr='#4477a1');
        }
        
        .button-blue:hover
        {
            background: #81a8cb;
            background: -webkit-gradient(linear, left top, left bottom, from(#4477a1), to(#81a8cb) );
            background: -moz-linear-gradient(-90deg, #4477a1, #81a8cb);
            filter:  progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#4477a1', endColorstr='#81a8cb');            
        }
        
        .button-blue:active
        {
            background: #4477a1;
        }
        
        /*----------------------------*/
        
        .button-brown
        {
            background: #8f3714;
            background: -webkit-gradient(linear, left top, left bottom, from(#bf6f50), to(#8f3714) );
            background: -moz-linear-gradient(-90deg, #bf6f50, #8f3714);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#bf6f50', EndColorStr='#8f3714');
        }
        
        .button-brown:hover
        {
            background: #bf6f50;
            background: -webkit-gradient(linear, left top, left bottom, from(#8f3714), to(#bf6f50) );
            background: -moz-linear-gradient(-90deg, #8f3714, #bf6f50);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#8f3714', EndColorStr='#bf6f50');
        }

        .button-brown:active
        {
            background: #8f3714;
        }
        
        /*----------------------------*/
        
        .button-green
        {
            background: #428739;
            background: -webkit-gradient(linear, left top, left bottom, from(#c8dd95), to(#428739) );
            background: -moz-linear-gradient(-90deg, #c8dd95, #428739);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#c8dd95', EndColorStr='#428739');
        }
        
        .button-green:hover
        {
            background: #c8dd95;
            background: -webkit-gradient(linear, left top, left bottom, from(#428739), to(#c8dd95) );
            background: -moz-linear-gradient(-90deg, #428739, #c8dd95);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#428739', EndColorStr='#c8dd95');
        }
        
        .button-green:active
        {
            background: #428739;
        }
        
        /*----------------------------*/
        
        .button-red
        {
            background: #D82741;
            background: -webkit-gradient(linear, left top, left bottom, from(#E84B6E), to(#D82741) );
            background: -moz-linear-gradient(-90deg, #E84B6E, #D82741);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#E84B6E', EndColorStr='#D82741');
        }

        .button-red:hover
        {
            background: #E84B6E;
            background: -webkit-gradient(linear, left top, left bottom, from(#D82741), to(#E84B6E) );
            background: -moz-linear-gradient(-90deg, #D82741, #E84B6E);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#D82741', EndColorStr='#E84B6E');
        }
        
        .button-red:active
        {
            background: #D82741;
        }
        /*----------------------------*/
        
        .button-purple
        {
            background: #6F50E7;
            background: -webkit-gradient(linear, left top, left bottom, from(#B8A9F3), to(#6F50E7) );
            background: -moz-linear-gradient(-90deg, #B8A9F3, #6F50E7);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#B8A9F3', EndColorStr='#6F50E7');
        }
        
        .button-purple:hover
        {
            background: #B8A9F3;
            background: -webkit-gradient(linear, left top, left bottom, from(#6F50E7), to(#B8A9F3) );
            background: -moz-linear-gradient(-90deg, #6F50E7, #B8A9F3);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#6F50E7', EndColorStr='#B8A9F3');
        }
        
        .button-purple:active
        {
            background: #6F50E7;
        }

        /*----------------------------*/
        
        .button-black
        {
            background: #141414;
            background: -webkit-gradient(linear, left top, left bottom, from(#656565), to(#141414) );
            background: -moz-linear-gradient(-90deg, #656565, #141414);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#656565', EndColorStr='#141414');
        }
        
        .button-black:hover
        {
            background: #656565;
            background: -webkit-gradient(linear, left top, left bottom, from(#141414), to(#656565) );
            background: -moz-linear-gradient(-90deg, #141414, #656565);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#141414', EndColorStr='#656565');
        }
        
        .button-black:active
        {
            background: #141414;
        }
        
        /*----------------------------*/
        
        .button-orange
        {
            background: #f09c15;
            background: -webkit-gradient(linear, left top, left bottom, from(#f8c939), to(#f09c15) );
            background: -moz-linear-gradient(-90deg, #f8c939, #f09c15);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#f8c939', EndColorStr='#f09c15');
        }
        
        .button-orange:hover
        {
            background: #f8c939;
            background: -webkit-gradient(linear, left top, left bottom, from(#f09c15), to(#f8c939) );
            background: -moz-linear-gradient(-90deg, #f09c15, #f8c939);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#f09c15', EndColorStr='#f8c939');
        }
        
        .button-orange:active
        {
            background: #f09c15;
        }
        
        /*----------------------------*/
        
        .button-silver
        {
            background: #c5c5c5;
            background: -webkit-gradient(linear, left top, left bottom, from(#eaeaea), to(#c5c5c5) );
            background: -moz-linear-gradient(-90deg, #eaeaea, #c5c5c5);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#eaeaea', EndColorStr='#c5c5c5');
        }
        
        .button-silver:hover
        {
            background: #eaeaea;
            background: -webkit-gradient(linear, left top, left bottom, from(#c5c5c5), to(#eaeaea) );
            background: -moz-linear-gradient(-90deg, #c5c5c5, #eaeaea);
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#c5c5c5', EndColorStr='#eaeaea');
        }
        
        .button-silver:active
        {
            background: #c5c5c5;
        }         

/****/
#fieldset_commit_to {margin-left:50px;padding:0 10px 10px 25px; background: url("../../share/workflow/runtime/bg_flowto_fieldset.png") no-repeat ; background-position: center left ;  } 
#fieldset_return_to {margin-left:50px;padding:0 10px 10px 25px; background: url("../../share/workflow/runtime/bg_flowto_fieldset.png") no-repeat ; background-position: center left ;  } 

</style>
<div id="flowprocessDiv" style="border-top: 0px solid #fafafa;float:left;display:none;width:100%;background-color:#ffffe6">
		<div id="flowHtmlText" class="flowHtmlText">
					<%=htmlText%>				
			</div>
				<%if(!helper.isOnlyShowRetracementButton){ %>
				<div class="flowremark"><s:textarea rows="1" name="_attitude"  placeholder="{*[cn.myapps.core.workflow.approve_remarks]*}"
							cssStyle="height:28px;overflow:auto;width:200px;" value="%{#parameters._attitude}"/>
				</div>
				<%} %>
		<div id="handupbutton" class="button-css">
		</div>
		<s:hidden id="submitTo" name="submitTo" value="%{#parameters.submitTo}"></s:hidden>
		<s:hidden id="_subFlowApproverInfo" name="_subFlowApproverInfo"
			value="%{#parameters._subFlowApproverInfo}"></s:hidden>
		<s:hidden id="_circulatorInfo" name="_circulatorInfo" value=""></s:hidden>
		<s:hidden id="_subFlowApproverInfoAll" name="_subFlowApproverInfoAll"
			value=""></s:hidden>
		<%
			}
			  }
		%>
		<input type="hidden" id="input_hidden_id"/>
</div>
	</s:if>
	
<script language="JavaScript">

	
	//最后提交的信息（json格式）
	var submitTo="";
	var nodeids="";
	var back_input_id="opra_back";
	var nextid="";
	//是否指定审批人
	var isToPerson=false;
	//如果指定审批人，审批人是否为空
	var isNullUser;
	//nextNode type checkbox || radio
	var isCheckbox;

	//有没有回退操作
	var back;
	var contextPath = '<%=contextPath%>';

	/**回选之前选中的节点**/
	if (window.attachEvent) {    
		window.attachEvent('onload', ev_loadFLow);    
	}    
	else {    
		window.addEventListener('load', ev_loadFLow, false);   
	}  
	
	if (document.getElementById("att") != null) {
		if ('<%=isDisplyAttitude%>' == 'true') {
			att.style.display='';
		} else {
			att.style.display='none';
			document.getElementById("_attitude").value='';
		}
	}
		
	function ev_setFlowType(isOthers, element, flowOperation) {//设置流程类型
		var back = document.getElementById('back');
		if (element.id != 'back') {
			if (back != null) {
				back.selectedIndex = 0;
				//hiddenBack_toPerson(true);
			}
			if (isOthers && element.type != 'checkbox') {
				var elements = document.getElementsByName('_nextids');
				for (var i=0; i < elements.length; i++) {
					if (elements[i].type == 'checkbox') {
						elements[i].checked = false;
					}
				}
			}
		} else {
			var elements = document.getElementsByName('_nextids');
			for (var i=0; i < elements.length; i++) {
				elements[i].checked = false;
				if(document.getElementById("input_"+i)){
					//回退操作,清空指定审批人文本框
					document.getElementById("input_"+i).value = "";
				}
				if(document.getElementById("input_hidden_id_"+i)){
					//回退操作,清空指定审批人ids
					document.getElementById("input_hidden_id_"+i).value = "";
				}
			}
			if (back != null && back.selectedIndex>0) {
				//hiddenBack_toPerson(false);
				//回退操作,清空指定审批人信息
				document.getElementById("submitTo").value = '';
			}else{
				//hiddenBack_toPerson(true);
				}
		}
		
		if (element.id != 'back') {
			if (document.getElementById('_flowType') && element.checked){
				document.getElementById('_flowType').value = flowOperation;
			}
		}else {
			if (document.getElementById('_flowType')){
				document.getElementById('_flowType').value = flowOperation;
			}
		}
	}

	var isNullTemp = false;

	// 检验选择指定审批人的节点是否已选择审批人
	function checkToPerson(){
		var nextids = document.getElementsByName('_nextids');
		var _flowType = '';
		if(document.getElementById("_flowType") != null){
			_flowType = document.getElementById("_flowType").value;
		}
		
		for (var i=0; i<nextids.length; i++) {
			var nodeid = nextids[i].value;
			//是否指定审批人
			var isToPerson = document.getElementById("isToPerson");
			if((isToPerson && isToPerson.value == 'true') && nextids[i].checked){
				var isNullUser = false;
				if(document.getElementById("input_"+i) && document.getElementById("input_"+i).value==""){
					isNullUser=true;
				}else{
					isNullUser=false;
				}

				// 提交到下一步
				if(_flowType == '80'){
					if(isNullUser){
						alert ('{*[cn.myapps.core.workflow.choose_specify_auditor]*}');
						return false;
					}
				}
			}
		}

		return true;
	}

	/**
	**流程处理
	**/
	function ev_validation(el, actid,isUsbKeyVerify) {
		unbindBeforeUnload();//取消绑定beforeunload事件
		if(!checkIsSelectCirculator()){
			return;
		}
		var docState='<%=docState%>';
		var nextids = document.getElementsByName('_nextids');
		var isToPersonStr = '';
		if(document.getElementById("isToPerson")!=null){
			isToPersonStr = document.getElementById("isToPerson").value;
		}
		var flag = false;
		var parameters ='';
		
		if (nextids != null) {
			if (!checkToPerson()){
				return;
			}
			
			for (var i=0; i<nextids.length; i++) {
				if (nextids[i].type != 'select-one') {
					if (nextids[i].checked) {
						flag = true;
						break;
					}
				} else {
					if (nextids[i].value != null 
					&& nextids[i].value != '') {
						flag = true;
						break;
					}
				}
			}


			if (flag) {
				if(isToPerson || isToPersonStr =='true'){
					prepareReturn();
					var _flowType = '';
					if(document.getElementById("_flowType") != null){
						_flowType = document.getElementById("_flowType").value;
					}

					if(_flowType == '81'){ // 回退时进行校验
						var input_back = 'null';
						if(document.getElementById("input_back") != null){
							input_back = document.getElementById("input_back").value;
						}
						if(input_back !='null' && input_back == ''){
							alert ('{*[cn.myapps.core.workflow.choose_specify_auditor]*}');
							return;
						}
						//回退操作,清空指定审批人信息
						document.getElementById("submitTo").value = '';
					}
				}
				//usbkey verify
				if(isUsbKeyVerify){
					usbkeyVerify(actid);
				}else{
					if(ev_runbeforeScript(actid)){
						doWordSave();
						biuldsubFlowApproverInfoStr();
						biuldCirculatorInfoStr();
						document.forms[0].action='<s:url action="action" namespace="/portal/dynaform/activity" />?_activityid=' + actid;
						if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
						makeAllFieldAble();//提交前将所有的只读字段设置为可编辑
						document.forms[0].submit();
					}
				}
			}
			else {
				alert('{*[page.workflow.chooseaction]*}');
			}
		}
		else {
			alert ('{*[page.workflow.noaction]*}');
		}
	}

	function ev_viewHis() {
		if (his.style.display == "") {
			his.style.display = "none";
		}
		else {
			his.style.display = "";
		}
		ev_onload();
	}

	/**回选之前选中的节点**/
	function ev_loadFLow(){
		var checkedNodeListStr = '<s:property value="#request._nextids" />';
		var nextEls = document.getElementsByName("_nextids");	
		var _back = document.getElementById("back");
		if (nextEls.length == 0 || (_back && _back.value != '')) {
			return;
		}
		
		if (checkedNodeListStr) {
			var checkedNodeList = checkedNodeListStr.split(',');
			for (var i=0; i < nextEls.length; i++) {
				var nextInput = document.getElementById("input_"+i);
				if (nextEls[i].type == 'checkbox') {
					if (checkedNodeListStr.indexOf(nextEls[i].value) == -1) {
						nextEls[i].click();
					}
				} else if(nextEls[i].type == 'radio') {
					if (checkedNodeListStr.indexOf(nextEls[i].value) != -1) {
						nextEls[i].click();
					}
				} //else {
					//selectOne(nextEls[i], checkedNodeList[0], function(oSelect){
					//	oSelect.onchange();
					//});
				//}  
			}
		} else {
			//nextEls[0].click();
		}
	}

	

	var selectFlag = false;
	function showUserSelect(actionName, settings) {
		var url = contextPath + '/portal/share/user/selectbyflow.jsp?application=<%=applicationid%>';
		url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		var valueField = document.getElementById(settings.valueField);
		var value = "";
		if (valueField){
			value = valueField.value;
		}
		
		var ids = document.getElementById(settings.hiddenIds).value;
		OBPM.dialog.show({
			width: 682,
			height: 500,
			url: url,
			//args: {parentObj: window, idField: "submitTo", nameField: settings.textField, readonly: settings.readonly},
			args: {value: value, readonly: settings.readonly,"applicationid":'<%=applicationid%>',"defValue":ids},
			title: '{*[cn.myapps.core.workflow.user_select]*}',
			close: function(result) {
				selectFlag = true;
				var rtn = result;
				var field = document.getElementById(settings.textField);
				if (field) {
					if (rtn) {
						isToPerson = true;
						if (rtn[0] && rtn.length > 0) {
							var rtnValue = '';
							var rtnText = '';
							//userid多个以","分隔
							var selectedNode=document.getElementById(settings.nextNodeId);
							//用户选择曾经选过的节点
							var submitTo = document.getElementById("submitTo").value;
							if(submitTo==null || submitTo==""){
                                 submitTo = "[";
							}else{
								if(submitTo.lastIndexOf("]")!=-1){
								 	submitTo = submitTo.substr(0,submitTo.lastIndexOf("]"));
								 	submitTo = submitTo +',';
								}
							}
							var start=submitTo.indexOf(settings.nextNodeId)+settings.nextNodeId.length+34;
							if(submitTo.indexOf(settings.nextNodeId)>0){
								var strfront=submitTo.substr(0,start);
								var strtemp=submitTo.substr(start+1,submitTo.length);
								if(strtemp.substr(strtemp.length-1,strtemp.length)==","){
									strtemp = strtemp.substr(0,strtemp.length-1);
								}
								var strfoot=strtemp.substr(strtemp.indexOf("]",0)-1,strtemp.length);
								submitTo=strfront;
								for (var i = 0; i < rtn.length; i++) {
									rtnValue += rtn[i].value + ";";
									rtnText += rtn[i].text + ";";
									submitTo+="'"+rtn[i].value+"',";
								}
								//submitTo= submitTo.replace('"userids":"','"userids":"[');
								submitTo=submitTo.substring(0,submitTo.length-2);
								submitTo+=strfoot;

								document.getElementById(settings.hiddenIds).value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
							}
							else{
								submitTo+="{\"nodeid\":'"+settings.nextNodeId+"',\"isToPerson\":'true',\"userids\":\"[";
								var userids="";
								for (var i = 0; i < rtn.length; i++) {
									rtnValue += rtn[i].value + ";";
									rtnText += rtn[i].text + ";";
									userids+="'"+rtn[i].value+"',";
								}
								userids=userids.substring(0,userids.length-1); 
								submitTo+=userids+"]\"}";

								document.getElementById(settings.hiddenIds).value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
							}
							document.getElementById("submitTo").value = submitTo+"]";
							valueField.value = rtnValue.substring(0, rtnValue.lastIndexOf(";"));
							var text = rtnText.substring(0, rtnText.lastIndexOf(";"));
							field.value = text;
							field.title = text;
						}else{
							valueField.value = '';
							field.value = '';
							field.title = '';
							document.getElementById("submitTo").value = '';
							document.getElementById(settings.hiddenIds).value = '';
							isToPerson = false;
						}
					} else {
						
					}
			
					if (settings.callback) {
						settings.callback(valueField.name);
					}
				}
			}
		});
	}

	//返回前参数的准备
	function prepareReturn(){
		if(selectFlag){
			var submitTo = document.getElementById("submitTo").value;
			//submitTo=submitTo.substring(0,submitTo.length-1);
			//获取节点的name集合
			var nextNodes=document.getElementsByName("_nextids");
			//获取节点是否指点审批人isToPerson集合
			//var isToPersons=document.getElementsByName("isToPerson");
			var elength=nextNodes.length;
			var back = document.getElementById("back");
			if (back != null) {
				elength=nextNodes.length-1;
				if(back.selectedIndex>0){
					submitTo=submitTo.replace('\'false\'','\'true\'');
				}
			}
			for(var i=0;i<elength;i++){
				if(nextNodes[i].checked){
					
					if(document.getElementById("input_"+i)==null || document.getElementById("input_"+i).value==null || document.getElementById("input_"+i).value==""){
						isNullUser=true;
					}else{
						isNullUser=false;
					}
					//var start=submitTo.indexOf(nextNodes[i].value)+nextNodes[i].value.length+16;
					//submitTo=submitTo.substr(0,start)+"true"+submitTo.substr(start+4,start.length);
				}
			}
			//submitTo=submitTo+"]";
			
			document.getElementById("submitTo").value=submitTo;
		}
		var nextNodes=document.getElementsByName("_nextids");
		//获取节点是否指点审批人isToPerson集合
		//var isToPersons=document.getElementsByName("isToPerson");
		var elength=nextNodes.length;
		for(var i=0;i<elength;i++){
			if(nextNodes[i].checked){
				if(document.getElementById("input_"+i)==null || document.getElementById("input_"+i).value=="" || document.getElementById("input_"+i).value==null){
					isNullUser=true;
					break;
				}else{
					isNullUser=false;
				}
			}
		}
		selectFlag = false;
	}


	function showBackUserSelect(docid,flowid){
		var back = document.getElementById("back");
		var imgid ="back";
		if(back != null && back.selectedIndex>0){
			var nextNodeId = back.value;
			showUserSelect('actionName', {nextNodeId:nextNodeId, docid:docid,flowid:flowid, textField:'input_' + imgid + '',valueField: 'input_'+ imgid + '', readonly: false});
		} else {
			alert('{*[page.workflow.chooseaction.back]*}');
		}
	}

	var subFlowApproverInfo =[];
	var subFlowApproverInfoAll =[];

	function addSubFlowApproverInfo(Obj,nodeId,info){
		var falg =true;
		for(var i=0;i<Obj.length;i++){
			var tmp =Obj[i];
			if(tmp.indexOf(nodeId)>0){
				Obj[i] =info;
				falg = false;
				break;
			}
		}
		if(falg){
			Obj.push(info);
		}
	}

	function getSubFlowApproverInfo(nodeId){
		for(var i=0;i<subFlowApproverInfoAll.length;i++){
			var tmp =subFlowApproverInfoAll[i];
			if(tmp.indexOf(nodeId)>0){
				return tmp;
			}
		}
		return '';
	}

	function biuldsubFlowApproverInfoStr(){
		var result ='';
		if(subFlowApproverInfo.length>0){
			result+='[';
		}
		for(var i=0;i<subFlowApproverInfo.length;i++){
			result+=subFlowApproverInfo[i]+',';
		}
		if(result.length>0){
			result = result.substring(0,result.length-1);
			result+=']';
			
			jQuery("input[name='_subFlowApproverInfo']").val(result);
		}
		//alert("result==" +result);

		//alert(jQuery("input[name='_subFlowApproverInfo']").val());
		
	}

	
	
		
	/*
	*	子流程节点选择审批人	
	*/       
	function showUserSelectOnSubFlow(actionName, settings){
		var url = contextPath + '/portal/share/user/selectApprover4Subflow.jsp?application=<%=applicationid%>';
		url += "&docid=" + settings.docid + "&instanceId=" + settings.instanceId+"&numberSetingType=" + settings.numberSetingType+"&instanceTotal=" + settings.instanceTotal+"&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		//var jsonStr = jQuery("input[name='_subFlowApproverInfoAll']").val();
		var jsonStr = getSubFlowApproverInfo(settings.nextNodeId);
		//var nodeid = "123456789";
		var value = '';
		OBPM.dialog.show({
			width: 700,
			height:500,
			url: url,
			args: {value: value, readonly: settings.readonly,numberSetingType: settings.numberSetingType,instanceTotal: settings.instanceTotal,nodeid: settings.nextNodeId,jsonStr: jsonStr},
			//args: {"instanceTotal": 5,"nodeid": nodeid,"jsonStr": jsonStr},
			title: '{*[cn.myapps.core.workflow.user_select]*}',
			close: function(jsonObj) {
				if(jsonObj != null){
					//alert(JSON.stringify(jsonObj));
					
					
					addSubFlowApproverInfo(subFlowApproverInfoAll,settings.nextNodeId,JSON.stringify(jsonObj));
					
					//jQuery("input[name='_subFlowApproverInfoAll']").val(JSON.stringify(jsonObj));
					//去除names属性
					var approverObj = JSON.parse(jsonObj.approver);
					var nameStr = "";
					//alert(approverObj.length);
					for(var i = 0; i < approverObj.length; i++){
						if(i != 0)nameStr += ',';
						nameStr += approverObj[i].names;
						delete approverObj[i].names;
					}
					jQuery("input[name="+ settings.textField +"]").val(nameStr);
					jsonObj.approver = approverObj;
					//alert("after delete ==> " + JSON.stringify(jsonObj));
					//-----------------------------------------------------
					//alert(JSON.stringify(jsonObj));
					addSubFlowApproverInfo(subFlowApproverInfo,settings.nextNodeId,JSON.stringify(jsonObj));
					
					biuldsubFlowApproverInfoStr();
					
					
					
					
					//-----------------------------------------------------
					
					//jQuery("input[name='_subFlowApproverInfo']").val(JSON.stringify(jsonObj));
				}
				//组装 json 字符串 并赋值到 一个name为“_subFlowApproverInfo”隐藏域里 作为参数提交到后台处理
			}
		});
	}
	
	
	var circulatorInfos =[];
	/**
	*指定抄送人
	*
	**/
	function selectCirculator(actionName, settings) {
		var url = contextPath + '/portal/share/user/selectCirculatorByFlow.jsp?application=<%=applicationid%>';
		url += "&docid=" + settings.docid + "&nodeid=" + settings.nextNodeId+"&flowid="+ settings.flowid;
		var valueField = document.getElementById(settings.valueField);
		var value = "";
		if (valueField){
			value = valueField.value;
		}
		OBPM.dialog.show({
			width: 610,
			height: 450,
			url: url,
			args: {
				// p1:当前窗口对象
				"parentObj" : window,
				// p2:存放userid的容器id
				"targetid" : "_circulatorInfo",
				// p3:存放username的容器id
				"receivername" : settings.textField,
				// p4:默认选中值, 格式为[userid1,userid2]
				"defValue": settings.defValue,
				//选择用户数
				"limitSum": settings.limitSum,
				//选择模式
				"selectMode":settings.selectMode
			},
			title: '{*[cn.myapps.core.workflow.user_select]*}',
			close: function(result) {
				selectFlag = true;
				var rtn = result;
				var field = document.getElementById(settings.textField);
				if (field) {
					if (rtn) {
						var rtnValue = '';
						var rtnText = '';
						for (var i = 0; i < rtn.length; i++) {
							rtnValue += '"'+ rtn[i].value + '",';
							rtnText += rtn[i].text + ";";
						}
						if(rtnValue.length>0){
							rtnValue = rtnValue.substring(0,rtnValue.length-1);
							rtnValue = '['+rtnValue+']';
							var circulatorInfo ='{circulator:'+rtnValue+'}';
							circulatorInfos[0] = circulatorInfo;
							//addCirculatorInfo(circulatorInfos,settings.nextNodeId,circulatorInfo);
							biuldCirculatorInfoStr();
						}
						var text = (rtnText == ''? rtnText:rtnText.substring(0,rtnText.length-1));
						field.value = text;
						field.title = text;
					}else {
						if (rtn == '') { // 清空
							field.value = '';
							field.title = '';
							circulatorInfos[0] ='';
							document.getElementById("_circulatorInfo").value = '';
						}
					}
				}
			}
		});
	}
	
	function addCirculatorInfo(Obj,nodeId,info){
		var falg =true;
		for(var i=0;i<Obj.length;i++){
			var tmp =Obj[i];
			if(tmp.indexOf(nodeId)>0){
				Obj[i] =info;
				falg = false;
				break;
			}
		}
		if(falg){
			Obj.push(info);
		}
	}
	
	function biuldCirculatorInfoStr(){
		var result ='';
		if(circulatorInfos.length>0){
			result+='[';
		}
		for(var i=0;i<circulatorInfos.length;i++){
			result+=circulatorInfos[i]+',';
		}
		if(result.length>0){
			result = result.substring(0,result.length-1);
			result+=']';
			
			jQuery("input[name='_circulatorInfo']").val(result);
		}
		//alert("result==" +result);

		//alert(jQuery("input[name='_circulatorInfo']").val());
		
	}
	
	function checkIsSelectCirculator(){
		var obj = document.getElementById("_circulator");
		var _flowType = document.getElementById("_flowType").value;
		/* if(obj && _flowType != '81'){
			if(obj.value.length<=0){
				alert("请选择抄送人！");
				return false;
			}
		}
		 */
		return true;
	}
	
	/**
	* USBKEY身份认证
	**/
	function usbkeyVerify(actid){
		var url = contextPath + '/portal/share/security/usbkey/ntko_usbkey_auth.jsp?application=<%=applicationid%>';
		OBPM.dialog.show({
			width: 350,
			height: 250,
			url: url,
			args: {},
			title: '{*[core.sysconfig.usbkey.authenticate]*}',
			close: function(result) {
				if(result =="true") {
					makeAllFieldAble();//提交前将所有的只读字段设置为可编辑
					doWordSave();
					biuldsubFlowApproverInfoStr();
					biuldCirculatorInfoStr();
					document.forms[0].action='<s:url action="action" namespace="/portal/dynaform/activity" />?_activityid=' + actid;
					if(toggleButton("button_act")) return false;//提交前把按钮变成灰色
					document.forms[0].submit();
				}
			}
		});
		return false;
			
	}

	jQuery(document).ready(function(){
		var $ = jQuery;
		var $flowProcessBtn = $("input[activityType='5']");
		if(document.getElementById("_handup")){
			var buttonName = jQuery("input[moduleType='handup']").attr("buttonname");
			var nodertId = jQuery("input[moduleType='handup']").attr("nodertId");
			var html = '<div class="btn_left"></div><div class="btn_mid">';
			html += '<a class="flowicon icon16" href="###" title="' + buttonName + '" onclick="ev_flowHandup(\'' + nodertId + '\')">';
			html += buttonName + '</a></div><div class="btn_right"></div>';
			jQuery("#handupbutton").append(html);
		}else if(document.getElementById("_recover")){
			var buttonName = jQuery("input[moduleType='recover']").attr("buttonname");
			var nodertId = jQuery("input[moduleType='recover']").attr("nodertId");
			var html = '<div class="btn_left"></div><div class="btn_mid">';
			html += '<a class="flowicon icon16" href="###" title="' + buttonName + '" onclick="ev_flowRecover(\'' + nodertId + '\')">';
			html += buttonName + '</a></div><div class="btn_right"></div>';
			jQuery("#handupbutton").append(html);
		}
		if(document.getElementById("btn_retracement")){//渲染回撤按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='{*[Retracement]*}' onclick='doRetracement()' > <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ "../../../resource/imgv2/front/act/act_35.gif"
			+ "' />"
			+ "{*[Retracement]*}"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if(document.getElementById("btn_addAuditor")){//渲染流程加签按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='{*[cn.myapps.core.workflow.add_auditor]*}' onclick='addAuditor()' > <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_35.gif"
			+ "' />"
			+ "{*[cn.myapps.core.workflow.add_auditor]*}"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if(document.getElementById("btn_editAuditor")){//渲染编辑审批人按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='{*[Edit_Auditor]*}' onclick='editAuditor()' > <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_24.gif"
			+ "' />"
			+ "{*[Edit_Auditor]*}"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if(document.getElementById("btn_editFlow")){//渲染调整流程按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='{*[WorkflowAdjustment]*}' onclick='editFlowByFrontUser()' > <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_38.gif"
			+ "' />"
			+ "{*[WorkflowAdjustment]*}"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if(document.getElementById("btn_termination")){//渲染终止流程按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='{*[cn.myapps.core.dynaform.activity.type.flow_terminate]*}' onclick='terminateFlow()' > <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_44.gif"
			+ "' />"
			+ "{*[cn.myapps.core.dynaform.activity.type.flow_terminate]*}"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$flowProcessBtn.after($b);
		}
		if(document.getElementById("btn_back")){//渲染回退流程按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a href='##' name='button_act' title='回退'> <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_44.gif"
			+ "' />"
			+ "回退"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$b.find("a").click(function(){
				var $fieldset = $("#fieldset_return_to");
				var $fpdiv = $("#flowprocessDiv");
				if ($fieldset.is(":hidden")) {//当前没有显示
					//设置流程类型
					$("#back").trigger("change");
					//显示流程操作面板
					$fpdiv.fadeTo(200, 0.3).find("fieldset").width(300).hide();
					$fieldset.show();
					var $btn = $("<a href='##' class='button button-red'><span>Return</span></a>").click(function(){
						$(this).attr("disabled", "disabled");
						var $actButtion = jQuery("input[activityType='5']").trigger("click");
					});
					$("#handupbutton").empty().append($btn);
					$fpdiv.slideDown("fast").fadeTo(200, 1);
				}
				else {
					$fpdiv.slideUp("fast");
				}
			});
			$flowProcessBtn.eq(0).after($b);
		}
		if(document.getElementById("btn_commit")){//渲染提交流程按钮
			var html = "<div class='actBtn'> <span class='button-document' > <a name='button_act' title='提交'> <span> <img style='border:0px solid blue;vertical-align:middle;' src='"
			+ contextPath + "/resource/imgv2/front/act/act_5.gif"
			+ "' />"
			+ "提交"
			+ " </span> </a> </span></div> ";
			var $b = $(html);
			$b.find("a").click(function(){
				var $fieldset = $("#fieldset_commit_to");
				var $fpdiv = $("#flowprocessDiv");
				if ($fieldset.is(":hidden")) {//当前没有显示
					//设置流程类型
				$("[name='_nextids']:first").trigger("click");
					//显示流程操作面板
					$fpdiv.fadeTo(200, 0.3).find("fieldset").width(300).hide();
					$fieldset.show();
					var $btn = $("<a href='##' class='button button-green'><span>Commit</span></a>").click(function(){
						$(this).attr("disabled", "disabled");//锁住当前操作，避免重复提交
						$("input[activityType='5']").trigger("click");
					});
					$("#handupbutton").empty().append($btn);
					$fpdiv.slideDown("fast").fadeTo(200, 1);
				}
				else {
					$fpdiv.slideUp("fast");
				}
			});
			$flowProcessBtn.after($b);
		}
		
		
		var _back = document.getElementById("back");
		if(_back && _back.value != ''){
			ev_setFlowType(false, _back, 81);
		}
	});
</script>
</o:MultiLanguage>
