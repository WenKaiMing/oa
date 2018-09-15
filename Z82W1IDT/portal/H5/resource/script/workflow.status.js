//查看流程历史
var WorkFlow = {
	init : function(){
		var flowJson;
		if($("#flow-json").size()>0 && $("#flow-json").text() != "[]"){
			flowJson = $("#flow-json").text();
			var instanceId = $("input[name='content.stateid']").val();
			var workflowJson = eval("("+flowJson+")")
			var flowInfo = [];
			for(var i=0;i<workflowJson[0].length;i++){
				if(workflowJson[0][i].instanceId==instanceId){
					flowInfo = workflowJson[0][i];
					break;
				}
			}
			this.bindEvent(flowInfo);
			this.workFlowStatus.init(flowInfo);
			$("#current-processing-node-td").show();
		}else{
			$("#current-processing-node-td").hide();
		}
	},
	bindEvent : function(workflowJson){
		$("#flow-panel").find(".flow-status").off().on("click",function(e){
			if($("#flow-status-panel").is(":visible")){
				$("#flow-status-panel").hide();
			}else{
				$("#flow-status-panel").show();
			}
			$(document).on("click", function(e){
				if($(e.target).parents("#flow-status-panel").size()<=0){
					$("#flow-status-panel").hide();
				}
		    });
			e.stopPropagation();
		})
				
		$("#flow-panel").find(".flow-history").off().on("click",function(){
			var flag = true;
		    var dateTime = new Date().getTime();
		    var _instanceId = document.getElementsByName("content.stateid")[0].value;
		    var application = document.getElementById("applicationid").value;
		    var flowName = workflowJson.flowName
		    
			var url = contextPath + "/portal/H5/dynaform/work/workflow_history.jsp?flowName="+flowName+"&flowStateId=" + _instanceId + "&application=" + application + "&contentId=" + contentId;
			OBPM.dialog.show({
				width: 850,
				height: 480,
				url: url,
				args: {},
				title: "流程历史",
				resize: false,
				close: function(result) {
				}
			});
		})
	},
	workFlowStatus : {
		init : function(workflowJson){
			this.renderWorkFlowStatus(workflowJson);
			this.bindEvent();
		},
		bindEvent : function(){
			$('#flow-Collapse').on('shown.bs.collapse', function(){
				$(this).find(".in").parent().find(".glyphicon").removeClass("glyphicon-menu-down").addClass("glyphicon-menu-up");
			});
			
			$('#flow-Collapse').on('hidden.bs.collapse', function(){
				$(this).find(".collapse").not(".in").parent().find(".glyphicon").removeClass("glyphicon-menu-up").addClass("glyphicon-menu-down");
			});
		},
		renderWorkFlowStatus : function(workflowJson){
			var instanceId = $("[name='content.stateid']").val();
			var flowName = workflowJson.flowName
					
			var _template = {
				flowCollapse : "<div class='panel panel-default'></div>",
				flowCollapseBtn : "<div class='panel-heading' role='tab' id='heading'>" +
								"<a data-toggle='collapse' href='#collapse' aria-expanded='true' aria-controls='collapse'>" +
								"<i class='fa fa-angle-double-down'></i></a></div>" +
								"<div id='collapse' class='panel-collapse collapse' role='tabpanel' aria-labelledby='heading'></div>",
				flowCollapseItem : "<div class='panel-body' data-authorid='{authorid}' style='padding:10px 15px'>" +
								"<span class='flow-name pull-left'>{userFace} <span title='{userName}'>{userName}</span></span>" +
								"<span class='flow-stateLabel pull-right' title='{stateLabel}'>{stateLabel}</span>" +
								"</div>"
			}
			$("#flow-Collapse").html('');
			$("#flow-Collapse").append(_template.flowCollapse);

			var $flowPanel = $("#flow-Collapse .panel-default");

			$.each(workflowJson.nodes,function(id,data){
				
				var nodeId = data.nodeId;
				var stateLabel = data.stateLabel;
				var authorId = $("[name='content.author.id']").val();
				var authorUser = false;
				
				if(nodeId != "" && data.auditors.length > 0){

					$.each(data.auditors,function(id,data){
						if(data.id == authorId){
							authorUser = true;
						}
					})
					
					$.each(data.auditors,function(id,data){
						var avatar = Common.Util.getAvatar(data.id);
						if(avatar!="" && avatar!=undefined){
							_avatar = "<img src ="+avatar+">";
						}else{
							_avatar = "<div class='noAvatar'>"+ data.name.substr(data.name.length-2, 2) +"</div>";
						}
						
						var flowCollapseItem = Common.Util.format(_template.flowCollapseItem,{'authorid' : data.id});
						flowCollapseItem = Common.Util.format(flowCollapseItem,{'userFace' : _avatar});
						flowCollapseItem = Common.Util.format(flowCollapseItem,{'userName' : data.name});
						flowCollapseItem = Common.Util.format(flowCollapseItem,{'stateLabel' : stateLabel});
						
						if(data.id == authorId){
							$flowPanel.prepend($(flowCollapseItem).addClass("panel-body-active"));
						}else{
							if(authorUser){
								if($flowPanel.find(".panel-body[data-authorid='"+authorId+"']").size() <= 0){
									$flowPanel.prepend(flowCollapseItem);
								}else{
									$flowPanel.find(".panel-body[data-authorid='"+authorId+"']").after(flowCollapseItem);
								}
							}else{
								$flowPanel.append(flowCollapseItem);
							}
						}
					})

				}else if(stateLabel != ""){
					var flowCollapseItem = Common.Util.format(_template.flowCollapseItem,{'authorid' : ''});
					flowCollapseItem = Common.Util.format(flowCollapseItem,{'userFace' : ''});
					flowCollapseItem = Common.Util.format(flowCollapseItem,{'userName' : ''});
					flowCollapseItem = Common.Util.format(flowCollapseItem,{'stateLabel' : stateLabel});
					$flowPanel.append(flowCollapseItem);
				}else{
					$(".flow-status").hide();
				}
			})
			
			if($flowPanel.find(".panel-body").size() > 3){
				$flowPanel.find(".panel-body").each(function(i){
					
					
					
					if($flowPanel.find("#collapse").size() <= 0){
						if(i == 2){
							$(this).after(_template.flowCollapseBtn);
						}
					}else{
						$flowPanel.find("#collapse").append($(this));
					}

				})
			}
			
			$(".flow-status-body-other").find(".collapse").addClass("in");
			$(".flow-status-body-active").find(".collapse").find(".flow-stateLabel").remove();
		}
	}
}