/**
 * 流程仪表分析
 * <p>封装应用层界面渲染与交互行为</p>
 * @author Bill
 */
var EFFICIENCY = {
		
			/**
			 * 初始化
			 */
			init : function() {
				
				this.bindEvent();
				EFFICIENCY.search();
			},
		
			/**
			 * 绑定事件
			*/
			bindEvent : function() {
				
				$("#search").on("click",function(){
					EFFICIENCY.search();
					});
					
					
				$("#efficiency-list").on("click",'.node', function(){
					var $row = $(this).parent().parent();
					var applicationid = $("#applicationid").val();
					var ShowMode = $("#showMode").val();
					var DateRange = $("#dateRange").val();
					var flowName = $(this).text();
					var Statelabel = $row.find("#statelabel").data().status;
					var startDate = $("#startdate").val();
					var endDate = $("#enddate").val();
					$("#node").show();
					$("#efficiency").hide();
					$.ajax({
						  type: "POST",
						  url: contextPath+'/portal/share/workflow/analyzer/node.action',
						  data:{startdate:startDate,enddate:endDate,flowname:flowName,statelabel:Statelabel,application:applicationid,showMode:ShowMode,dateRange:DateRange},
						  success: function(result){
							  if(result.status==1){
								  nodeChart(result.data);
								  $("#node-list").children(":not(.row-title)").remove().end().append($("#tmplNodeTableListItem").tmpl(result.data[0].table));
						  		}
						  }
								});
							});
				
				$("#node-list").on("click",'.names', function(){
					var applicationid = $("#applicationid").val();
					var $row = $(this).parent().parent();
					var flownames = $row.find("#flowname").text();
					var nodeName = $(this).text();
					var Statelabel = $row.find("#statelabel").data().status;
					var startDate = $("#startdate").val();
					var endDate = $("#enddate").val();
					$("#names").show();
					$("#node").hide();
					$.ajax({
						  type: "POST",
						  url: contextPath+'/portal/share/workflow/analyzer/names.action',
						  data:{startdate:startDate,enddate:endDate,nodename:nodeName,statelabel:Statelabel,application:applicationid,flowname:flownames},
						  success: function(result){
							  if(result.status==1){
								  namesChart(result.data);
								  $("#names-list").children(":not(.row-title)").remove().end().append($("#tmplNamesTableListItem").tmpl(result.data[0].table));
					  			}
						  	}
								});
							})
				
				$("#names-list").on("click",'.detailed', function(){
					var applicationid = $("#applicationid").val();
					var Initiator = $(this).text();
					var $row = $(this).parent().parent();
					var Statelabel = $row.find("#statelabel").data().status;
					var nodeName = $row.find("#nodename").text();
					var startDate = $("#startdate").val();
					var endDate = $("#enddate").val();
					$("#detailed").show();
					$("#names").hide();
					$.ajax({
						  type: "POST",
						  url: contextPath+'/portal/share/workflow/analyzer/detailed.action',
						  data:{startdate:startDate,enddate:endDate,nodename:nodeName,initiator:Initiator,statelabel:Statelabel,application:applicationid},
						  success: function(result){
							  if(result.status==1){
							  $("#detailed-list").children(":not(.row-title)").remove().end().append($("#tmplDetailedTableListItem").tmpl(result.data));
						  			}
						  }
								});
							})
							
			},
			
			search : function(){
				var applicationid = $("#applicationid").val();
				var ShowMode = $("#showMode").val();
				var DateRange = $("#dateRange").val();
				var Status = $("#stateselect").val();
				var startDate = $("#startdate").val();
				var endDate = $("#enddate").val();
				$.ajax({
					  type: "POST",
					  url: contextPath+'/portal/share/workflow/analyzer/Consuming.action',
					  data:{select:Status,startdate:startDate,enddate:endDate,application:applicationid,showMode:ShowMode,dateRange:DateRange},
					  success: function(result){
						  if(result.status==1){
							  efficiencyChart(result.data);
							  $("#efficiency-list").children(":not(.row-title)").remove().end().append($("#tmplEfficiencyTableListItem").tmpl(result.data[0].table));
						  }
						  
					  }
					});
			}
			
			
};

/**
 * 图形报表
 */
function efficiencyChart(datas){
	require.config({
        paths: {
            echarts: './resource'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
			'echarts',
			'echarts/chart/pie',
			'echarts/chart/bar',
			'echarts/chart/line',
			'echarts/chart/scatter'
        ],
        function (ec) {
            //--- 考勤情况 ---
            if(datas[0].echart.yAxis != ""){
                var myChart = ec.init(document.getElementById('histogram'));
            	myChart.setOption({
                	title : {
                        text: averageTime,
                        x:'center'
                    },
                    tooltip : {
    			        trigger: 'item'
    			    },
    			    grid:{
    			    	x:50,y:25,x2:15,y2:35
    			    },
    			    calculable : true,
    			    xAxis : [
    			        {
    			            type : 'category',
    			            data : datas[0].echart.xAxis
    			        }
    			    ],
    			    yAxis : [
    			        {
    			            type : 'value'
    			        }
    			    ],
    			    series : [
    			        {
    			            type:'bar',
    			            barCategoryGap: '60%',
    			            itemStyle: {
    			                normal: {
    			                    color: function(params) {
    			                        // build a color map as your need.
    			                        var colorList = [
    			                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
    			                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
    			                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
    			                        ];
    			                        return colorList[params.dataIndex]
    			                    },
    			                    label: {
    			                        show: false,
    			                        position: 'top',
    			                        formatter: '{b}\n{c}'
    			                    }
    			                }
    			            },
    			            data: datas[0].echart.yAxis
    			        }
    			    ]
                });
            	
	            var myChart = ec.init(document.getElementById('bar'));
	            var i = datas.length-1;
	            myChart.setOption({
	            	title : {
	                    text: processInstances,
	                    x:'center'
	                },
	                tooltip : {
				        trigger: 'item'
				    },
				    grid:{
				    	x:110,y:25,x2:15,y2:35
				    },
				    calculable : true,
				    xAxis : [
			                    {
			                        type : 'value',
			                        boundaryGap : [0, 0.01]
			                    }
			                ],
			                yAxis : [
			                    {
			                        type : 'category',
			                        data : datas[0].echart.xAxis
			                    }
			                ],
			                series : [
			                    {
			                        type:'bar',
			                        barCategoryGap: '60%',
			                        itemStyle: {
						                normal: {
						                    color: function(params) {
						                        // build a color map as your need.
						                        var colorList = [
						                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
						                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
						                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
						                        ];
						                        return colorList[params.dataIndex]
						                    },
						                    label: {
						                        show: false,
						                        position: 'top',
						                        formatter: '{b}\n{c}'
						                    }
						                }
						            },
			                        data: datas[0].echart.num
			                    }
			                ]
	            });
            }else{
				initchart();
            }
        }
    );
}

function nodeChart(datas){
	require.config({
        paths: {
            echarts: './resource'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
			'echarts',
			'echarts/chart/pie',
			'echarts/chart/bar',
			'echarts/chart/line',
			'echarts/chart/scatter'
        ],
        function (ec) {
            //--- 考勤情况 ---
            var myChart = ec.init(document.getElementById('nodehistogram'));
            var i =datas.length-1;
            myChart.setOption({
            	title : {
                    text: '节点平均耗时',
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:25,y:25,x2:15,y2:22
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data :datas[0].echart.xAxis
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            type:'bar',
			            barCategoryGap: '60%',
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        // build a color map as your need.
			                        var colorList = [
			                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
			                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
			                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
			                        ];
			                        return colorList[params.dataIndex]
			                    },
			                    label: {
			                        show: false,
			                        position: 'top',
			                        formatter: '{b}\n{c}'
			                    }
			                }
			            },
			            data: datas[0].echart.yAxis
			        }
			    ]
            });
            
            
            var myChart = ec.init(document.getElementById('nodebar'));
            var i = datas.length-1;
            myChart.setOption({
            	title : {
                    text: '流程节点个数',
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:110,y:25,x2:15,y2:22
			    },
			    calculable : true,
			    xAxis : [
		                    {
		                        type : 'value',
		                        boundaryGap : [0, 0.01]
		                    }
		                ],
		                yAxis : [
		                    {
		                        type : 'category',
		                        data : datas[0].echart.xAxis
		                    }
		                ],
		                series : [
		                    {
		                        type:'bar',
		                        barCategoryGap: '60%',
		                        itemStyle: {
					                normal: {
					                    color: function(params) {
					                        // build a color map as your need.
					                        var colorList = [
					                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
					                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
					                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
					                        ];
					                        return colorList[params.dataIndex]
					                    },
					                    label: {
					                        show: false,
					                        position: 'top',
					                        formatter: '{b}\n{c}'
					                    }
					                }
					            },
		                        data: datas[0].echart.num
		                    }
		                ]
            });
        }
    );
}

function namesChart(datas){
	require.config({
        paths: {
            echarts: './resource'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
			'echarts',
			'echarts/chart/pie',
			'echarts/chart/bar',
			'echarts/chart/line',
			'echarts/chart/scatter'
        ],
        function (ec) {
            //--- 考勤情况 ---
            var myChart = ec.init(document.getElementById('nameshistogram'));
            var i =datas.length-1;
            myChart.setOption({
            	title : {
                    text: '节点平均耗时',
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:25,y:25,x2:15,y2:22
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data : datas[0].echart.xAxis
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            type:'bar',
			            barCategoryGap: '60%',
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        // build a color map as your need.
			                        var colorList = [
			                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
			                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
			                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
			                        ];
			                        return colorList[params.dataIndex]
			                    },
			                    label: {
			                        show: false,
			                        position: 'top',
			                        formatter: '{b}\n{c}'
			                    }
			                }
			            },
			            data: datas[0].echart.yAxis
			        }
			    ]
            });
            
            
            var myChart = ec.init(document.getElementById('namesbar'));
            var i = datas.length-1;
            myChart.setOption({
            	title : {
                    text: '流程节点个数',
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:110,y:25,x2:15,y2:22
			    },
			    calculable : true,
			    xAxis : [
		                    {
		                        type : 'value',
		                        boundaryGap : [0, 0.01]
		                    }
		                ],
		                yAxis : [
		                    {
		                        type : 'category',
		                        data : datas[0].echart.xAxis
		                    }
		                ],
		                series : [
		                    {
		                        type:'bar',
		                        barCategoryGap: '60%',
		                        itemStyle: {
					                normal: {
					                    color: function(params) {
					                        // build a color map as your need.
					                        var colorList = [
					                          '#C1232B','#FCCE10','#E87C25','#27727B','#B5C334',
					                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
					                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
					                        ];
					                        return colorList[params.dataIndex]
					                    },
					                    label: {
					                        show: false,
					                        position: 'top',
					                        formatter: '{b}\n{c}'
					                    }
					                }
					            },
		                        data: datas[0].echart.num
		                    }
		                ]
            });
        }
    );
}

function initchart(){
	require.config({
        paths: {
            echarts: './resource'
        }
    });
    
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
			'echarts',
			'echarts/chart/pie',
			'echarts/chart/bar',
			'echarts/chart/line',
			'echarts/chart/scatter'
        ],
        function (ec) {
            //--- 考勤情况 ---
            var myChart = ec.init(document.getElementById('histogram'));
            myChart.setOption({
            	title : {
                    text: averageTime,
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:50,y:25,x2:15,y2:35
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'category',
			            data : [0,0]
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value'
			        }
			    ],
			    series : [
			        {
			            type:'bar',
			            barCategoryGap: '60%',
			            data:[0,0]
			        }
			    ]
            });
            
            
            var myChart = ec.init(document.getElementById('bar'));
            myChart.setOption({
            	title : {
                    text: processInstances,
                    x:'center'
                },
                tooltip : {
			        trigger: 'item'
			    },
			    grid:{
			    	x:110,y:25,x2:15,y2:35
			    },
			    calculable : true,
			    xAxis : [
		                    {
		                        type : 'value',
		                        boundaryGap : [0, 0.01]
		                    }
		                ],
		                yAxis : [
		                    {
		                        type : 'category',
		                        data : [0,0]
		                    }
		                ],
		                series : [
		                    {
		                        type:'bar',
		                        barCategoryGap: '60%',
		                        data:[0,0]
		                    }
		                ]
            });
        }
    );
}
