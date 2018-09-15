var FlowProcess = {
	bindEvent : function(){
		var $flowprocessDiv = $("#flowprocessDiv");
		
		//自由流程选择审批人
		$flowprocessDiv.on("click",".flow-submit__user-select-box",function(){
			
			var $fieldset = $(this).parents("fieldset");
			var _actType = $fieldset.attr("actType");
			
			var settings = {
				"actType": _actType,
				"selectMode": "selectOne", 
				"textField": "nextUser",
				"valueField": "nextUserId",
				"readonly": false
			}
			
			FlowProcess.util.showUserSelect("freeFlow",settings,function(result){
				var $textField = $("#nextUser");
				var $valueField = $("#nextUserId");
				if(result && $textField.size()>0 && $valueField.size()>0){
					var textStr = "";
					var valueStr = "";
					for(var i = 0;i < result.length;i++){
						$textField.val(result[i].text);
						$valueField.val(result[i].value);
					}
				}
			})
		})
	},
	//渲染自由流程
	renderFreePanel : function(actid,type){
		var $flowprocessDiv = $("#flowprocessDiv");
		var $flowNodePanel = $("#flowHtmlText");
		var $fieldset = $("#fieldset_freeFlow_"+type);

		if ($fieldset.is(":hidden") || $fieldset.size()==0) {//当前没有显示
			if(type == "start"){//开始
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="start"><legend>提交至</legend>'
				+'<div data-type="nodeItem">'
				+'&nbsp&nbsp指定审批人:&nbsp<span class="flowToPerson" id="opra_0" style="display:inline;">'
				+'<input type="hidden" id="nextUserId" name="nextUserId" />'
				+'<input class="flowToPerson-Input flowToPerson-Input-agrs" id="nextUser" name="nextUser" readonly="true" type="text" size="10" />'
				+'<img class="flow-submit__user-select-box" style="cursor:pointer;display:inline;" src="'+contextPath+'/portal/share/component/dialog/images/userselect.gif" />'
				+'</div></fieldset>';
				$flowNodePanel.html(html);
				var $btn = $("<a href='##' name='btn_act_startup' class='button button-green'><span>确认提交</span></a>").click(function(){
					FlowPanel.freeFlowStartUp(actid);
				});
			}else if(type == "back"){//回退
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="back"><legend>提交至</legend>'
				+'<div data-type="nodeItem">'
				+'指定审批人:&nbsp<span class="flowToPerson" id="opra_0" style="display:inline;">'
				+'<input type="hidden" id="nextUserId" name="nextUserId" />'
				+'<input class="flowToPerson-Input flowToPerson-Input-agrs" id="nextUser" name="nextUser" readonly="true" type="text" size="10" />'
				+'<img class="flow-submit__user-select-box" style="cursor:pointer;display:inline;" src="'+contextPath+'/portal/share/component/dialog/images/userselect.gif" />'
				+'</div></fieldset>';
				$flowNodePanel.html(html);
				var $btn = $("<a href='##' name='btn_act_startup' class='button button-red'><span>确认回退</span></a>").click(function(){
					FlowPanel.freeFlowBackOff(actid);
				});
			}else if(type == "end"){//结束
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="end" style="position: relative;"><legend>提交至</legend>'
					+'<div data-type="nodeItem"><img src="'+ contextPath +'/portal/H5/resource/images/icon_freeflow_end.png" '
					+'style="position: absolute;left: 50%;top: 50%;margin-top: -33px;margin-left: -33px;"></div></fieldset>';
				$flowNodePanel.html(html);
				var $btn = $("<a href='##' name='btn_act_complete' class='button button-red'><span>确认结束</span></a>").click(function(){
					FlowPanel.freeFlowComplete(actid);
				});
			}else if(type == "commit"){//提交
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="commit"><legend>提交至</legend>'
				+'<div data-type="nodeItem">'
				+'指定审批人:&nbsp<span class="flowToPerson" id="opra_0" style="display:inline;">'
				+'<input type="hidden" id="nextUserId" name="nextUserId" />'
				+'<input class="flowToPerson-Input flowToPerson-Input-agrs" id="nextUser" name="nextUser" readonly="true" type="text" size="10" />'
				+'<img class="flow-submit__user-select-box" style="cursor:pointer;display:inline;" src="'+contextPath+'/portal/share/component/dialog/images/userselect.gif" />'
				+'</div></fieldset>';
				$flowNodePanel.html(html);
				var $btn = $("<a href='##' name='btn_act_startup' class='button button-green'><span>确认提交</span></a>").click(function(){
					FlowPanel.freeFlowCommitTo(actid);
				});
			}
			$("#div_button_place").empty().append($btn);
			$flowprocessDiv.css({'opacity':'0.2'}).slideDown("fast").fadeTo(200, 1);
		}else {
			$flowprocessDiv.slideUp("fast");
		}
	},
	util : {
		showUserSelect : function(type,settings,callback) {
			var appId =  $("input[activityType='5']").attr("applicationid");	
			if(type == "freeFlow"){
				if(settings.actType == "start" || settings.actType == "commit"){
					var url = contextPath + '/portal/share/component/dialog/selectUserByAll.jsp?application='+appId;
				}else{
					var url = contextPath + "/portal/share/component/dialog/selectUser4Free.jsp?application="+appId;
				}
			}
			
			var $valueField = $("#"+settings.valueField);
			var value = "";
			if ($valueField){
				value = $valueField.val();
			}
			var ids = "";
			var args = {
				"parentObj" : window,
				"targetid" : settings.valueField,
				"receivername" : settings.textField,
				"selectMode":settings.selectMode,
				"stateId": $("input[name='content.stateid']").val()
			}

			OBPM.dialog.show({
				width: 682,
				height: 500,
				url: url,
				args: args,
				title: "指定审批人",
				close: function(result) {
					if(callback && typeof callback == "function"){
						callback(result);
					}	
				}
			});
		}
	}
}