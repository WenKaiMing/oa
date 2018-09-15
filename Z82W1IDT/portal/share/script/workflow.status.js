//查看流程历史
var WorkFlow = {
	init : function(){
		var flowJson;
		if($("#flow-json").size()>0){
			flowJson = $("#flow-json").text();
		}else{
			flowJson = "[]";
		}
		var workflowJson = eval("("+flowJson+")");
		this.renderProcessor(workflowJson);
	},
	renderProcessor : function(workflowJson){
		var instanceId = $("[name='content.stateid']").val();
		var $processorHtml = $("#processorHtml");
		$.each(workflowJson,function(id,data){
			if(data[0].instanceId == instanceId){
				$.each(data[0].nodes,function(id,data){
					var nodeId = data.nodeId;
					var authorId = $("[name='content.author.id']").val();
					var processorDivText = "更多:(";
					$.each(data.auditors,function(id,data){
						if(data.id == authorId){
							$processorHtml.find(".divFormFlowCls").attr("title","当前处理人:("+data.name+")");
							$processorHtml.find(".formFlowCls").find("span").text(data.name);
						}else{
							processorDivText += data.name+",";
						}
					})
					processorDivText = processorDivText.substring(0,processorDivText.length-1);
					processorDivText += ")";
					if(processorDivText.length > 5){
						$("#processorDiv").find("span").text(processorDivText);
					}
				})
			}
		})		
	}
}