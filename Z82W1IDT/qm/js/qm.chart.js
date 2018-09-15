var holders;
var answers;

/**
 * 问卷统计
 */
var QM = {
		chart:{
			init : function(holderjson,chartJSON){
				holders = $.parseJSON(holderjson);
				var charts = $.parseJSON(chartJSON);
				var $maindiv = $("#maiDiv");
				qNum = 0;
				$(holders).each(function(a){
					var holder = holders[a];
					var type = holder.type;
					if(type!="head")
						qNum++;
					var $topic = QM.chart._createDiv(holder,charts);
					$maindiv.append($topic);
					$maindiv.append("<br>");
				});

				if(charts){
					for(var i=0;i<charts.length;i++){
						var chart = charts[i];
						var id = chart.id;
						
						var data = chart.data;
						if(data != null){
							for(var j=0;j<data.length;j++){
								var option = data[j];
								var name = option.name;
								var index = option.index;
								var count = option.count;
								var $optionTd = $("td[id='"+id+"_"+index+"']");
								var $div = $("div#"+id);
								var type = $div.data("type");

								if(type == "matrixradio" || type == "matrixcheck" || type == "codematrix"){
									$optionTd.html("<a class='holder-item-details'>"+count+"</a>");
								}else{
									$optionTd.html(count);
								}
							}
						}
					}

					var _id = $("#content_id").val();
					
					
					$.ajax({
						url: contextPath + "/qm/questionnaireservice/reportform.action",
			    		async: false,
			    		cache:false,
			    		data:{"id":_id},
			    		success: function(result){
			    			var chartJson = result.data.chartJson
			    			QM.chart.initChart(chartJson);
			    		}
					})
				}
				
				//填空题翻页
				$maindiv.find(".pagination-panel").each(function(){
					
					var $this = $(this);
					var $currpage = $this.find("[name='_currpage']");
					var $pagelines = $this.find("[name='_pagelines']");
					var $rowcount = $this.find("[name='_rowcount']");
					
					var config = {
						"currpage":	parseInt($currpage.val()),
						"pagelines": parseInt($pagelines.val()),
						"rowcount":	parseInt($rowcount.val())
					}
					
					$this.find(".pagination-body").pagination(config.rowcount, {
						current_page: config.currpage - 1,
						items_per_page: config.pagelines,
						prev_text: "<span class='glyphicon glyphicon-chevron-left'></span>",
						next_text: "<span class='glyphicon glyphicon-chevron-right'></span>",
					    num_edge_entries: 1,
					    num_display_entries: 5,
					    callback: function(){
					    	//翻页事件
					    	$this.find("a").on("click",function(){
					    		var $btn = $(this);
					    		var id = $this.attr("data-id");
					    		var qid = $this.attr("data-qid");
					    		var _pageCount = Math.ceil(config.rowcount/config.pagelines);
					    		var _pageNum;

					    		if($btn.hasClass("prev")){
					    			if (config.currpage > 1) {
					    				_pageNum = config.currpage - 1;
						    		}else{
						    			return;
						    		}
					    		}else if($btn.hasClass("next")){
					    			if (_pageCount > 1 && _pageCount > config.currpage) {
					    				_pageNum = config.currpage + 1;
					    			}else{
						    			return;
						    		}
					    		}else{
					    			_pageNum = parseInt($(this).text());
					    		}
					    		$currpage.val(_pageNum);
					    		
					    		var params = {
				            			"id": id,
				            			"q_id":qid,
				            			"pagelines": $pagelines.val(),
				            			"currpage": $currpage.val()
				            		}
								
								getInputValue(params,function(result){
									var inputHtml = QM.chart.renderInputLine(qid,result.datas);
									$("#"+qid).find("tbody").html(inputHtml);
								})
					    		
					    		return false;
					    	});
					    }
					});

				})
				
				$(".holder-item-details").on("click",function(){
					var dataArr = $(this).parent().data("answername");					
					var $answerMask = $("#qm-mask");
					var $answerNamePanel = $("#qm-answerName-panel");
					var $answerNameUl = $answerNamePanel.find(".answerName-list").find("ul");
					$("body").css("overflow","hidden");
					var winW = $(window).width();
					$answerNamePanel.css("left",winW/2-250+"px");
					$answerNameUl.html("");
					for(var i=0;i<dataArr.length;i++){
						var _answerNameStr = dataArr[i].name + "(" + dataArr[i].department + ")";
						var _html = "<li>"+_answerNameStr+"</li>";
						$answerNameUl.append(_html);
					}
					
					$answerMask.show();
					$answerNamePanel.show();
				})
				
				$("#qm-mask,#qm-answerName-panel").on("click",function(){
					$("#qm-mask").hide();
					$("#qm-answerName-panel").hide();
					$("body").css("overflow","auto");
				})
			},
			
			/**
			 * 初始化试题
			 * @param holder
			 * @returns
			 */
			_createDiv : function(holder,charts){
				//试题id
				var id = holder.id;
				//题号
				var number = holders.indexOf(holder);
				
				//题目
				var topic = holder.topic;
				//类型
				var type = holder.type;
				
				//图片
				var isPic = holder.isPic;

				//题目
				var title = topic;
				if(type!="head")
					title = qNum + "、" +title;
				
				//选项
				var options = holder.options
				
				var $div = $("<div class='holder-item' data-type='"+type+"' id='"+id+"'></div>");
				var $titleDiv = $("<div class='holder-item-title'></div>");
				
				$titleDiv.text(title);
				
				//是否必填
				if(holder.isWill){
					var $will = $("<span style='color:red'>*</span>");
					$titleDiv.prepend($will);
				}
				$div.append($titleDiv);
				
				switch(type){
					case "radio":
					case "check":
					case "voteradio":
					case "votecheck":
					case "coderadio":
					case "codecheck":
					{
						var options = holder.options
						if(options && options.length>0){
							var $table = $("<div class='holder-item-content'><div id='"+id+"_chart' class='holder-item-chart'></div><table><tr><td>选项名</td><td width='15%'>个数</td><td width='15%'>操作</td></tr></table><div>");
							for(var i=0;i<options.length;i++){
								var option = options[i]
								var $lastTr =$table.find("tr:last");
								var $tr = $("<tr><td></td><td id='"+id+"_"+i+"'></td><td data-item='"+option.name+"'><a class='holder-item-details'>详情</a></td></tr>");
								$lastTr.after($tr);
								
								var $td0 = $tr.find("td:eq(0)");
								var optionNameHtml;
								if(isPic){
									optionNameHtml = "<a href='"+option.pic+"' target='_blank'><img src='"+option.pic+"' /></a> "+option.name;
								}else{
									optionNameHtml = option.name;
								}
								$td0.html(optionNameHtml);
								$tr.find("td:eq(1)").html(0);
							}
							$div.append($table);
						}
						break;
					}
					case "matrixinput":
					case "input":{
						var $id = $("#content_id");
						var $answerDiv = $("<div class='holder-item-content'>"
								+"<table><thead><tr><th width='90px'>答卷人</th><th width='90px'>答卷时间</th><th>答案</th></tr></thead>"
								+"<tbody></tbody></table><div class='pagination-panel'>"
								+"<input type='hidden' name='_pagelines' value='5' />"
								+"<input type='hidden' name='_rowcount' value='' />"
								+"<input type='hidden' name='_currpage' value='1' />"
								+"<div class='pagination-body'></div>" 
								+"<div class='pagination-other'>"
								+"<div class='totalRowPanel'></div></div></div>");
						$answerDiv.find(".pagination-panel").attr("data-qid",holder.id).attr("data-id",$id.val());
						var params = {
		            			"id":$id.val(),
		            			"q_id":holder.id,
		            			"pagelines": 5,
		            			"currpage": 1
		            		}
						getInputValue(params,function(result){
							var inputHtml = QM.chart.renderInputLine(holder.id,result.datas);
							$answerDiv.find("[name='_rowcount']").val(result.rowCount);
							$answerDiv.find(".totalRowPanel").text("总条数:"+result.rowCount+"条");
							$answerDiv.find("tbody").append(inputHtml);
						})
						$div.append($answerDiv);						
						break;
					}
					
					case "testradio":
					case "testcheck":{
						var options = holder.options
						if(options && options.length>0){
							var $table = $("<div class='holder-item-content'><div id='"+id+"_chart' class='holder-item-chart'></div><table><tr><td>选项名</td><td width='15%'>个数</td><td width='15%'>操作</td></tr></table></div>");
							for(var i=0;i<options.length;i++){
								var option = options[i]
								var $lastTr =$table.find("tr:last");
								var $tr = $("<tr><td></td><td id='"+id+"_"+i+"'></td><td data-item='"+option.name+"'><a class='holder-item-details'>详情</a></td></tr>");
								$lastTr.after($tr);
								
								var $td0 = $tr.find("td:eq(0)");
								$td0.append(option.name);
								if(option.isAnswer){
									$td0.append("正确答案");
								}
								$tr.find("td:eq(1)").html(0);
							}
							$div.append($table);
						}
						break;
					}
					case "matrixradio":    //矩阵单选
					case "matrixcheck":    //矩阵多选
					case "codematrix":{    //评分矩阵单选题 		
						var options = holder.options
						var labels = holder.leftLabel.split("\n");
						if(options && options.length>0){
							var $table = $("<div class='holder-item-content'><div id='"+id+"_chart' class='holder-item-chart'></div><table><tr><td/></tr></table></div>");
							for (var j = 0; j < options.length; j++) {
								var option = options[j];
								var $trLast = $table.find("tr:last");
								$trLast.append("<td>" + option.name + "</td>");
							}
							if(type == "codematrix"){
								$trLast.append("<td>总分</td><td>平均分</td>");
							}
							
							for (var b = 0; b < labels.length; b++) {
								var $trLast = $table.find("tr:last");
								$trLast.after("<tr><td></tr>");
								$table.find("tr:last td:eq(0)").html(labels[b]);
								for (var k = 0; k < options.length; k++) {
									var option = options[k];
									var $last = $table.find("tr:last");
									$last.append("<td id='"+id+"_"+labels[b]+"_"+option.name+"' data-item='"+labels[b]+"_"+option.name+"'><a class='holder-item-details'>0</a></td>");
								}
								if(type == "codematrix"){
									$last.append("<td id='"+id+"_"+labels[b]+"_score'>"+"0</td>");
									$last.append("<td id='"+id+"_"+labels[b]+"_average'>"+"0</td>");
								}
							}
							
							var width;
							if(type == "codematrix"){
								width = 100 / (options.length + 3);
							} else {
								width = 100 / (options.length + 1);
							}
							
							$table.find("td").css("width",width+"%");
							$div.append($table);
						}
						break;
					}
				}
				
				return $div;
			},
			
			renderInputLine : function(qid,datas){
				var inputHtml = ""
				for(var v = 0; v < datas.length; v++){
					var showInputJson = JSON.parse(datas[v].answer);
					for(var i = 0; i < showInputJson.length; i++){
		        		var showInput = showInputJson[i];
						if(showInput.id == qid){
							inputHtml += "<tr>"
							var value = "";
							if(showInput.options && showInput.type == "matrixinput"){
								
								for(var j = 0; j < showInput.options.length; j++){
									var inputOption = showInput.options[j];
									value += "<span class='matrixinput-title'>" + inputOption.name + " : </span>"+ inputOption.value + " ";
								}
							}else{
								value = showInput.value;
							}
							inputHtml += "<td>"+datas[v].userName+"</td><td>"+datas[v].date+"</td><td>"+value+"</td></tr>"
							
						}
		        	}
				}
				return inputHtml;
			},
			
			/**
			 * 初始化报表(dom渲染完)
			 */
			initChart : function(chartJson){
				
				var chartsJson = JSON.parse(chartJson);
				if(chartsJson){
					for(var i=0;i<chartsJson.length;i++){
						var chart = chartsJson[i];
						var id = chart.id;
						var data = chart.data;
						var series = chart.series;
						var dataType = chart.type;
						var userName = chart.userName;

						if(data != null || series != null){
							switch(dataType){
								case "radio":  
			            		case "coderadio":
			            		case "testradio":	
			            		case "voteradio":
			            			var _labelNum = 0;
			            			var _labelLength;
			            			var _data = [];
			            			var _series = [];

			            			$.each(userName,function(key,data){
			            				var $_td = $("#"+id).find("td[data-item='"+key+"']");
			            				var answerNameStr = JSON.stringify(data);
			            				$_td.attr("data-answerName",answerNameStr);
			            			})
			            			

			            			for(var each in data){_labelNum ++};
			            			_labelLength = parseInt(($(window).width() - 160) / _labelNum / 16);
			            			
			            			$.each(data,function(key,value){
			            				if(key.length > _labelLength){
			            					key = key.substr(0,_labelLength-1) + "...";
			            				}
			            				var _seriesObj = {"value":value,"name":key};
			            				_series.push(_seriesObj)
			            				_data.push(key);
			            			}) 
			            			
			            			var myChart = echarts.init(document.getElementById(id+'_chart'));
							        // 指定图表的配置项和数据
							        var option = {
							        		legend: {
							        			x : 'center',
							        	        y : 'bottom',
							        	        data: _data
							        	    },
							        		series : [
							        	        {
							        	            type:'pie',
							        	            radius : '65%',
							        	            center: ['50%', '45%'],
							        	            data:_series,
							        	            label: {
							        	                normal: {
							        	                    textStyle: {
							        	                        color: 'rgba(0, 0, 0, 0.5)'
							        	                    }
							        	                }
							        	            },
							        	            labelLine: {
							        	                normal: {
							        	                    lineStyle: {
							        	                    	color: 'rgba(0, 0, 0, 0.5)'
							        	                    },
							        	                    smooth: 0.2,
							        	                    length: 10,
							        	                    length2: 20
							        	                }
							        	            },
							        	            itemStyle: {
							        	            	emphasis: {
							        	                    shadowBlur: 10,
							        	                    shadowOffsetX: 0,
							        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
							        	                }
							        	            }
							        	        }
							        	    ]
							        };
							        // 使用刚指定的配置项和数据显示图表。
							        myChart.setOption(option);
									break;
			            		case "check":
			            		case "codecheck":
			            		case "testcheck":
			            		case "votecheck":

			            			var _labelNum = 0;
			            			var _labelLength;
									var _data = [];
			            			var _series = [{"data":[],"type":"bar","itemStyle":{
			                            normal: {
			                                color: function(){
			                                	return "#"+("00000"+((Math.random()*16777215+0.5)>>0).toString(16)).slice(-6); 
			                                }
			                            }
			                        }}];
			            			
			            			$.each(userName,function(key,data){
			            				var $_td = $("#"+id).find("td[data-item='"+key+"']");
			            				var answerNameStr = JSON.stringify(data);
			            				$_td.attr("data-answerName",answerNameStr);
			            			})
			            			
			            			for(var each in data){_labelNum ++};
			            			_labelLength = parseInt(($(window).width() - 160) / _labelNum / 16);
			            			$.each(data,function(key,value){
			            				if(key.length > _labelLength){
			            					key = key.substr(0,_labelLength-1) + "...";
			            				}
			            				_series[0].data.push(value);
			            				_data.push(key);
			            			}) 
			            			
									var myChart = echarts.init(document.getElementById(id+'_chart'));
							        // 指定图表的配置项和数据
							        var option = {

							        	    grid: {
							        	        left: '3%',
							        	        right: '4%',
							        	        bottom: '5%',
							        	        containLabel: true
							        	    },
							        	    xAxis : [
							        	        {
							        	            type : 'category',
							        	            data : _data,
							        	            axisLabel :{  
							        	                interval:0   
							        	            }
							        	        }
							        	    ],
							        	    yAxis : [
							        	        {
							        	            type : 'value'
							        	        }
							        	    ],
							        	    series : _series
							        	};


							        // 使用刚指定的配置项和数据显示图表。
							        myChart.setOption(option);
									break;
			            		case "matrixradio":
			            		case "codematrix":
			            		case "matrixcheck":
			            			var _labelLength;
									var _legend = chart.legend;
									var _xAxis = chart.xAxis;
									var _yAxis = chart.yAxis;
									var _series = chart.series;

									for(var r = 0; r < _series.length; r++){
										var _userName = _series[r].userName;
										$.each(_userName,function(key,data){
											var _key = _series[r].name + "_" + _xAxis[key];
											var $_td = $("#"+id).find("td[data-item='"+_key+"']");
					            			var answerNameStr = JSON.stringify(data);
					            			$_td.attr("data-answerName",answerNameStr);
				            			});
										if(dataType == "codematrix"){
											var code = _series[r].code;
											{
												var _key = _series[r].name + "_score";
												var $_td = $("#"+id+"_"+_key);
												$_td.html(code.score);
											}
											{
												var _key = _series[r].name + "_average";
												var $_td = $("#"+id+"_"+_key);
												$_td.html(code.average);
											}
										}
									}
	
									for(var j = 0; j < _series.length; j++){
										_series[j].type = 'bar';
									}
									_labelLength = parseInt(($(window).width() - 160) / _xAxis.length / 16);
									for(var v = 0; v < _xAxis.length; v++){
										if(_xAxis[v].length > _labelLength){
											_xAxis[v] = _xAxis[0].substr(0,_labelLength-1) + "...";
			            				}
									}

									var myChart = echarts.init(document.getElementById(id+'_chart'));
							        // 指定图表的配置项和数据
							        var option = {
							        	    legend: _legend,
							        	    grid: {
							        	        left: '3%',
							        	        right: '4%',
							        	        bottom: '10%',
							        	        containLabel: true
							        	    },
							        	    xAxis : [
							        	        {
							        	            type : 'category',
							        	            data : _xAxis,
							        	            axisLabel :{  
							        	                interval:0   
							        	            } 
							        	         }
							        	    ],
							        	    yAxis : [
							        	        {
							        	            type : _yAxis
							        	        }
							        	    ],
							        	    series : _series
							        	};

							        // 使用刚指定的配置项和数据显示图表。
							        myChart.setOption(option);
									break;	
							}
							
							
						}
					}
				}
			}
		}	
}