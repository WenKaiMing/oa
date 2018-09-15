;
(function($) {
	$.fn.SmohanPopLayer = function(options) {
		var Config = {
			Shade : true,
			Title : "抱歉！此处发生运行时异常，可能导致您的程序无法正常运行！",
			Content : "出错啦出错啦",
			contentFull : contentFull
		};
		var options = $.extend(Config, options);
		var layerhtml = "";
		if (options.Shade == true) {
			layerhtml += '<div class="Smohan_Layer_Shade"></div>';
		}
		layerhtml += '<div class="Smohan_Layer_box" id="layer_content">';
		layerhtml += '<h3><a class="textImg"></a><b class="text">' + options.Title + '</b><a href="javascript:void(0)" class="close"></a></h3>';
		layerhtml += '<div class="layer_content">';
		layerhtml += '<div id="layerContent" class="layerOn"><a></a><div><span class="layerContentSpan">'+ options.Content + '</span></div></div>';
		layerhtml += '<pre ';
		if(navigator.userAgent.indexOf("MSIE 8.0")>0)
			layerhtml += 'style="width: 100%" ';
		layerhtml += 'id="contentFull">'+ options.contentFull + '</pre>';
		layerhtml += '<button id="contentButton">点击查看详细信息</button>';
		layerhtml += '</div>';
		layerhtml += '</div>';
		
		if($(".thisDisplay").html()){
			 function U(a, b, d) {
		            if (a.match(/^(\w+):\/\//i) && !a.match(/^https?:/i) || /^#/i.test(a) || /^data:/i.test(a)) return a;
		            var c = d ? e('<a href="' + d + '" />')[0] : location,
		            d = c.protocol,
		            h = c.host,
		            m = c.hostname,
		            i = c.port,
		            c = c.pathname.replace(/\\/g, "/").replace(/[^\/]+$/i, "");
		            "" === i && (i = "80");
		            "" === c ? c = "/": "/" !== c.charAt(0) && (c = "/" + c);
		            "abs" !== b && (a = a.replace(RegExp(d + "\\/\\/" + m.replace(/\./g, "\\.") + "(?::" + i + ")" + ("80" === i ? "?": "") + "(/|$)", "i"), "/"));
		            "rel" === b && (a = a.replace(RegExp("^" + c.replace(/([\/\.\+\[\]\(\)])/g, 
		            "\\$1"), "i"), ""));
		            if ("rel" !== b && (a.match(/^(https?:\/\/|\/)/i) || (a = c + a), "/" === a.charAt(0))) {
		                for (var m = [], a = a.split("/"), k = a.length, c = 0; c < k; c++) i = a[c],
		                ".." === i ? m.pop() : "" !== i && "." !== i && m.push(i);
		                "" === a[k - 1] && m.push("");
		                a = "/" + m.join("/");
		            }
		            "abs" === b && !a.match(/^https?:\/\//i) && (a = d + "//" + h + a);
		            return a = a.replace(/(https?:\/\/[^:\/?#]+):80(\/|$)/i, "$1$2");
	       }
			 var J = J=U(contextPath + "/portal/share/common/msgbox/msgBox.css","abs");
			 $("head",parent.document).append("<link rel='stylesheet' href='" + J + "' type='text/css' />");
			 
			setTimeout(function(){
				$('body',parent.document).prepend(layerhtml);
				$(".Smohan_Layer_box",parent.document).css('top',(parent.document.body.clientHeight - $(".Smohan_Layer_box",parent.document).height() - 40)/2);
				$(".Smohan_Layer_box",parent.document).css('left',(parent.document.body.clientWidth - $(".Smohan_Layer_box",parent.document).width())/2);
				
				$("#contentButton",parent.document).click(function(){
					if($("#layerContent",parent.document).attr("class") == "layerOn"){
						$("#layerContent",parent.document).removeClass("layerOn");
						$("#contentFull",parent.document).addClass("layerOn");
						$(".Smohan_Layer_box",parent.document).css("height","auto");
						if($(".Smohan_Layer_box",parent.document).height() >= parent.document.body.clientHeight - 50){
							$(".Smohan_Layer_box",parent.document).height(parent.document.body.clientHeight - 50);
							$("#contentFull",parent.document).height($(".Smohan_Layer_box",parent.document).height() - 150);
						}
						$("#contentButton",parent.document).html("点击收起详细信息");
					}else if($("#contentFull",parent.document).attr("class") == "layerOn"){
						$("#contentFull",parent.document).removeClass("layerOn");
						$("#layerContent",parent.document).addClass("layerOn");
						$(".Smohan_Layer_box",parent.document).css("height","180px");
						$("#contentButton",parent.document).html("点击查看详细信息");
					}
					$(".Smohan_Layer_box",parent.document).css('top',(parent.document.body.clientHeight - $(".Smohan_Layer_box",parent.document).height() - 40)/2);
					$(".Smohan_Layer_box",parent.document).css('left',(parent.document.body.clientWidth - $(".Smohan_Layer_box",parent.document).width())/2);
				});
				
				$('#layer_content',parent.document).show();
				$('.Smohan_Layer_Shade',parent.document).show();
				
				var size = 25;
				while($(".layerContentSpan",parent.document).height() > "45"){
					size = size - 1;
					$(".layerContentSpan",parent.document).css("font-size",size + "px");
				}
				
				$('.Smohan_Layer_box .close',parent.document).click(function(e) {
					$('.Smohan_Layer_box',parent.document).animate( {
						opacity : 'hide'
					}, "500", function() {
						$('.Smohan_Layer_Shade',parent.document).hide();
					});
					$("#layer_content",parent.document).remove();
					$(".Smohan_Layer_Shade",parent.document).remove();
					jQuery("#save_btn",parent.document).removeAttr("disabled");
				});
			},1);
		}else{
			$('body').prepend(layerhtml);
			var documentH = document.documentElement.clientHeight;
			$(".Smohan_Layer_box").css('top',(document.documentElement.clientHeight  - $(".Smohan_Layer_box").height() - 40)/2);
			$(".Smohan_Layer_box").css('left',(document.body.clientWidth - $(".Smohan_Layer_box").width())/2);
			
			$("#contentButton").click(function(){
				if($("#layerContent").attr("class") == "layerOn"){
					$("#layerContent").removeClass("layerOn");
					$("#contentFull").addClass("layerOn");
					$(".Smohan_Layer_box").css("height","auto");
					if($(".Smohan_Layer_box").height() >= documentH - 50){
						$(".Smohan_Layer_box").height(documentH - 50);
						$("#contentFull").height(documentH - 50 - 150);
					}
					$("#contentButton").html("点击收起详细信息");
				}else if($("#contentFull").attr("class") == "layerOn"){
					$("#contentFull").removeClass("layerOn");
					$("#layerContent").addClass("layerOn");
					$(".Smohan_Layer_box").css("height","180px");
					$("#contentButton").html("点击查看详细信息");
				}
				$(".Smohan_Layer_box").css('top',(document.documentElement.clientHeight - $(".Smohan_Layer_box").height() - 40)/2);
				$(".Smohan_Layer_box").css('left',(document.body.clientWidth - $(".Smohan_Layer_box").width())/2);
			});
			
			$('#layer_content').show();
			$('.Smohan_Layer_Shade').show();
			
			var size = 25;
			while($(".layerContentSpan").height() > "45"){
				size = size - 1;
				$(".layerContentSpan").css("font-size",size + "px");
			}
			
			$('.Smohan_Layer_box .close').click(function(e) {
				$('.Smohan_Layer_box').animate( {
					opacity : 'hide'
				}, "500", function() {
					$('.Smohan_Layer_Shade').hide();
				});
				$("#layer_content").remove();
				$(".Smohan_Layer_Shade").remove();
				jQuery("#save_btn").removeAttr("disabled");
			});
		}
			
	};
})(jQuery);
