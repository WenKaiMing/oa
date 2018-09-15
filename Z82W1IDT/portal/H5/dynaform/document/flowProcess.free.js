var FlowProcess = {
	bindEvent : function(){
		var $flowprocessDiv = $("#flowprocessDiv");
		
		//移除审批人
		$flowprocessDiv.on("click",".flow-submit__user",function(){
			var $this = $(this);
			var $textField = $("#nextUser");
			var $valueField = $("#nextUserId");
			
			$valueField.val("");
			$textField.val("");
			$this.siblings(".flow-submit__user-select-box").show();
			$this.remove();
		});
		
		
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
				var $userPanel = $textField.parent();
				var $userSelect = $textField.siblings(".flow-submit__user-select-box");
				if(result && $textField.size()>0 && $valueField.size()>0){
					$userSelect.hide();
					var textStr = "";
					var valueStr = "";
					for(var i = 0;i < result.length;i++){
						var avatar = Common.Util.getAvatar(result[0].value);
						var text = result[i].text;
						var value = result[i].value;
						if(avatar && avatar != ""){
							var _avatar = '<img class="avatar" src="'+avatar+'">';
						}else{
							var _avatar = '<div class="noAvatar">'+(result[i].text).substr(0,2)+'</div>';
						}
						
						var userHtml = '<div class="flow-submit__user">'
							+'<div class="flow-submit__user-avatar" style="background: #A2A2A2;">'
							+ _avatar +'<i class="fa fa-minus-square"></i></div>'
							+'<div class="flow-submit__user-name">'+text+'</div></div>'
						
							
						$userSelect.before($(userHtml));	
							
						$textField.val(text);
						$valueField.val(value);
					}
				}else{
					if($userPanel.find(".flow-submit__user").size() > 0){
						return false;
					}
					$userSelect.show();
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
					+'<div class="flow-submit__user-panel" data-type="nodeItem" style="padding: 10px;">'
					+'<div class="flow-submit__user-select-box">'
					+'<div class="flow-submit__user-avatar flow-submit__user-select"></div>'
					+'</div>'
					+'<input type="hidden" id="nextUserId" name="nextUserId" />'
					+'<input type="hidden" id="nextUser" name="nextUser" />'
					+'</div></fieldset>';
				
				$flowNodePanel.html(html);
				var $btn = $("<button type='button' class='btn btn-primary' name='btn_act_startup' >"+ "确认发起" +"</button>").click(function(){
					FlowPanel.freeFlowStartUp(actid);
				});
			}else if(type == "back"){//回退
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="back"><legend>提交至</legend>'
					+'<div class="flow-submit__user-panel" data-type="nodeItem" style="padding: 10px;">'
					+'<div class="flow-submit__user-select-box">'
					+'<div class="flow-submit__user-avatar flow-submit__user-select"></div>'
					+'</div>'
					+'<input type="hidden" id="nextUserId" name="nextUserId" />'
					+'<input type="hidden" id="nextUser" name="nextUser" />'
					+'</div></fieldset>';
			
				$flowNodePanel.html(html);
				var $btn = $("<button type='button' class='btn btn-warning' name='btn_act_startup' >"+ "确认回退" +"</button>").click(function(){
					FlowPanel.freeFlowBackOff(actid);
				});
			}else if(type == "end"){//结束
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="end" style="position: relative;"><legend>提交至</legend>'
					+'<div data-type="nodeItem"><img src="'+ contextPath +'/portal/H5/resource/images/icon_freeflow_end.png" '
					+'style="position: absolute;left: 50%;top: 50%;margin-top: -33px;margin-left: -33px;"></div></fieldset>';
				$flowNodePanel.html(html);
				var $btn = $("<button type='button' class='btn btn-success' name='btn_act_complete' _flowType = '7' >确认结束</button>").click(function(){
					FlowPanel.freeFlowComplete(actid);
				});
			}else if(type == "commit"){//提交
				var html = '<fieldset id="fieldset_freeFlow_'+type+'" acttype="commit"><legend>提交至</legend>'
					+'<div class="flow-submit__user-panel" data-type="nodeItem" style="padding: 10px;">'
					+'<div class="flow-submit__user-select-box">'
					+'<div class="flow-submit__user-avatar flow-submit__user-select"></div>'
					+'</div>'
					+'<input type="hidden" id="nextUserId" name="nextUserId" />'
					+'<input type="hidden" id="nextUser" name="nextUser" />'
					+'</div></fieldset>';
			
				$flowNodePanel.html(html);
				var $btn = $("<button type='button' class='btn btn-primary' name='btn_act_startup' >"+ Multilingual.commit +"</button>").click(function(){
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
					var url = contextPath + "/portal/H5/resource/component/dialog/selectUserByAll.jsp?application="+appId;
				}else{
					var url = contextPath + "/portal/H5/resource/component/dialog/selectUser4Free.jsp?application="+appId;
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
				title: Multilingual.flowUserSelect,
				ok: null,
				cancel: null,
				button: null,
				close: function(result) {
					if(callback && typeof callback == "function"){
						callback(result);
					}	
				}
			});
		}
	}
}