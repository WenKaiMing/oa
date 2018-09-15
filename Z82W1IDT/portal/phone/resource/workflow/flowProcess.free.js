var FlowProcess = {
	bindEvent : function(){

	},
	//渲染自由流程
	renderFreePanel : function(actid,type){

		var $page_flowPro = ajaxPage.getCurPage().find("#page_flowPro");
		$page_flowPro.show();
		
		
		var $nodeBox = $(".flow-submit__panel").find("#flow-submit__node-box");
		
		
		
		var $start = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='发起'>发起</a></div>").click(function(){
			$(this).attr("disabled", "disabled");//锁住当前操作，避免重复操作
			FlowProcess.active.freeFlowStartUp(actid);
		});
		
		var $commit = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='提交'>提交</a></div>").click(function(){
			$(this).attr("disabled", "disabled");//锁住当前操作，避免重复操作
			FlowProcess.active.freeFlowCommitTo(actid);
		});
		
		var $back = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='回退'>回退</a></div>").click(function(){
			$(this).attr("disabled", "disabled");//锁住当前操作，避免重复操作
			FlowProcess.active.freeFlowBackOff(actid);
			$("#page_flowPro").hide();
		});
		var $end = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-positive btn-block' title='结束'>结束</a></div>").click(function(){
			$(this).attr("disabled", "disabled");//锁住当前操作，避免重复操作
			FlowProcess.active.freeFlowComplete(actid);
			$("#page_flowPro").hide();
		});
		var $cancel = $("<div class='weui-flex__item'><a name='btn_act_committo' class='btn btn-block' title='取消'>取消</a></div>").click(function(){
			FlowPanel.cancelAction();
			$("#page_flowPro").hide();
		});
		
		
		if(type == "start"){//开始
			var html = '<div class="weui-cells weui-cells_checkbox" style="margin-top:-1px" data-id="freeflow">'
				+'<label class="weui-cell  weui-check__label">'
				+'<div class="weui-cell__bd">审批人</div></label>'
				+'<div class="weui-cell">'
				+'<div class="flow-submit__user-panel">'
				+'<div class="flow-submit__user-select-box">'
				+'<div name="free_flow" class="flow-submit__user-avatar flow-submit__user-select"></div>'
				+'</div></div></div>'
				+'<input type="hidden" id="freeflow_text" name="nextUser" />'
				+'<input type="hidden" id="freeflow" name="nextUserId" />'
				+'</div>';
			$nodeBox.html(html);
			$page_flowPro.find("#div_button_place").empty().append($start).append($cancel);
		}else if(type == "commit"){//提交
			var html = '<div class="weui-cells weui-cells_checkbox" style="margin-top:-1px" data-id="freeflow">'
				+'<label class="weui-cell  weui-check__label">'
				+'<div class="weui-cell__bd">审批人</div></label>'
				+'<div class="weui-cell">'
				+'<div class="flow-submit__user-panel">'
				+'<div class="flow-submit__user-select-box">'
				+'<div name="free_flow" class="flow-submit__user-avatar flow-submit__user-select"></div>'
				+'</div></div></div>'
				+'<input type="hidden" id="freeflow_text" name="nextUser" />'
				+'<input type="hidden" id="freeflow" name="nextUserId" />'
				+'</div>';
			$nodeBox.html(html);
			$page_flowPro.find("#div_button_place").empty().append($commit).append($cancel);
		}else if(type == "back"){//回退
			var html = '<div class="weui-cells weui-cells_checkbox" style="margin-top:-1px" data-id="freeflow">'
				+'<label class="weui-cell  weui-check__label">'
				+'<div class="weui-cell__bd">审批人</div></label>'
				+'<div class="weui-cell">'
				+'<div class="flow-submit__user-panel">'
				+'<div class="flow-submit__user-select-box">'
				+'<div name="free_flow" class="flow-submit__user-avatar flow-submit__user-select"></div>'
				+'</div></div></div>'
				+'<input type="hidden" id="freeflow_text" name="nextUser" />'
				+'<input type="hidden" id="freeflow" name="nextUserId" />'
				+'</div>';
			$nodeBox.html(html);
			$page_flowPro.find("#div_button_place").empty().append($back).append($cancel);
		}else if(type == "end"){//结束
			$nodeBox.html("");
			$page_flowPro.find("#div_button_place").empty().append($end).append($cancel);
		}
		ajaxPage.addHashPostfix("flowPro");
		var toChooseUsers = [];
		var tabs = {
				// [] 配置显示的tab，全部、部门、职务、常用
				all : {name:'全部',url: 'contacts/getAllUser.action'},
				dept : {name:'部门',url: 'contacts/getContactsTree.action'},
			    role : {name:'角色',url: 'contacts/getApplicationAndRoleContactsTree.action'},
			    favorite : {name:'常用',url: 'contacts/getFavoriteContacts.action'}
			}
		if(type == "back"){
			tabs = {
				// [] 配置显示的tab，全部、部门、职务、常用
				all : {name:'全部',url: 'contacts/getAllUser.action'}
			}
			var params = {
				"stateId":$("#content_stateid").val(),
				"applicationId":$("#application").val()
			}	
			$.ajax({
	    		url: contextPath+"/contacts/getHisActors4FreeFlow.action",
	    		type:"post",
	    		async: false,
	    		cache:false,
				data:params,
				success: function(result){
					toChooseUsers = result.data;
	    		}
	    	})	
		}
		$nodeBox.find("#freeflow").userbox({
			//属性和事件回调可自定义，无自定义需求可完全不填，具体用法参考说明文档
			id : 'freeflow',//必须，存放回选的用户value值的input的id
			textId : 'freeflow_text',//必须，存放回选的用户text值的input的id
			isPhone : true,		//是否手机端
			multiple: false,//是否多选模式
			mode: 'all',//simple:精简模式|all:完整模式   
			tabs : tabs,
			width: 'auto',//宽度
			disabled: false,//是否禁用
			readOnlyShowValOnly : true,//只读是否只显示值
			required: false,//是否必填
			clearlabel : "清除",	//清除按钮的title
			separator: ';',//多选模式下的分隔符
			selectBtn: $nodeBox.find(".flow-submit__user-select"),
			toChooseUsers: toChooseUsers,
			onSuccess : function(result){
				var userValue = "";
				if(result.data.length>0){
					for(var i = 0;i < result.data.length;i++){
						var id = result.data[i].value;
						userValue += id + ";";
					}
					$("#freeflow").val(userValue.substr(0,userValue.length-1));
					FlowPanel.renderSelectUser("freeflow",result);
				}
			},
			onOpen : function(){
				
			},
			onClose : function(){
				
			}
		});
	},
	active : {
		/**自由流程启动**/
		freeFlowStartUp : function(actid) {
			//指定下一节点审批人
			if ($("input[name='nextUserId']").val()=='') {
				Activity.showMessage('请选择审批人！',"error");
				return;
			}
			//手写签名
			var data = $sigdiv.jSignature('getData', "image");
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$("input[name='_signature']").val(signatureJson);
				}
			}
			
			//设置流程类型为【自由流程启动-1】
			if(document.getElementById("_flowType")){
				document.getElementById("_flowType").value = "1";
			}
			//执行提交流程按钮操作
			Activity.doExecute(actid,5);
		},
		
		/**自由流程提交**/
		freeFlowCommitTo : function(actid) {
			//指定下一节点审批人
			if ($("input[name='nextUserId']").val()=='') {
				Activity.showMessage('请选择审批人！',"error");
				return;
			}
			//手写签名
			var data = $sigdiv.jSignature('getData', "image");
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$("input[name='_signature']").val(signatureJson);
				}
			}
			
			//设置流程类型为【自由流程提交-80】
			if(document.getElementById("_flowType")){
				document.getElementById("_flowType").value = "80";
			}
			//执行提交流程按钮操作
			Activity.doExecute(actid,5);
		},
		
		/**自由流程回退**/
		freeFlowBackOff : function(actid) {
			//指定下一节点审批人
			if ($("input[name='nextUserId']").val()=='') {
				Activity.showMessage('请选择审批人！',"error");
				return;
			}
			//手写签名
			var data = $sigdiv.jSignature('getData', "image");
						
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$("input[name='_signature']").val(signatureJson);
				}
			}
			
			//设置流程类型为【自由流程回退-81】
			if(document.getElementById("_flowType")){
				document.getElementById("_flowType").value = "81";
			}
			//执行提交流程按钮操作
			Activity.doExecute(actid,5);
		},
		
		/**自由流程结束**/
		freeFlowComplete : function(actid) {
			//设置流程类型为【自由流程结束-7】
			if(document.getElementById("_flowType")){
				document.getElementById("_flowType").value = "7";
			}
			//手写签名
			var data = $sigdiv.jSignature('getData', "image");
			if(data && data.length==2){
				if(data[1] != defaultSignature){
					var signatureJson = '{"type":"'+data[0]+'","data":"'+data[1]+'"}';
					$("input[name='_signature']").val(signatureJson);
				}
			}
			//执行提交流程按钮操作
			Activity.doExecute(actid,5);
		}
	}
}