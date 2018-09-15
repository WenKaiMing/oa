function renderOreport(datas){
	  var $curPage = ajaxPage.getCurPage();
	  var _id = $curPage.attr("id")+"_report_body";
	  var myChart = echarts.init(document.getElementById(_id));
	  $curPage.find(".report_title").html(datas.name);
	  if("pie"==datas.sign){	//馅饼图
	  	var legendArr = [];
        $.each(datas.data, function(i,obj){ 
        	legendArr.push(obj.name);
        	}); 
        myChart.setOption({
            legend: {
                data:legendArr
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            calculable : true,
            series : [
                {
                    type:'pie',
                    radius : '55%',
                    center: ['50%', '55%'],
                    roseType: 'angle',
                    data:datas.data
                }
            ]
        });
	  }
  
  if("scatter"==datas.sign){	//散点图
        myChart.setOption({
            tooltip : {
                trigger: 'axis'
            },
            grid:{
            	x:25,
            	y:25,
            	x2:15,
            	y2:22,
            	left:'2%',
		    	right: '2%',
		    	containLabel: true
		    },
            calculable : true,
            xAxis : [
                {
                	type : 'value',
                	splitLine: {
                        show: true,
                        lineStyle: {
                            color: '#455061'
                        }
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#4C4C4C'
                        }
                    }
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    splitLine: {
                        show: true,
                        lineStyle: {
                            color: '#455061'
                        }
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#4C4C4C'
                        }
                    }
                }
            ],
            series : [
                {
                    type:'scatter',
                    data:datas.data
                }
            ]
        });
	  }
  
  if("area"==datas.sign){	//面积图
        myChart.setOption({
            tooltip : {
                trigger: 'axis'
            },
            grid:{
            	x:25,
            	y:25,
            	x2:15,
            	y2:22,
            	left:'2%',
		    	right: '2%',
		    	containLabel: true
		    },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : datas.xAxis
                }
            ],
            yAxis : [
                {
                    type : 'value',
                }
            ],
            series : [
                {
                    type:'line',
                    smooth:true,
                    itemStyle: {normal: {areaStyle: {type: 'default'}}},
                    data:datas.yAxis
                }
            ]
        });
	  }
  
  if("line"==datas.sign){	//折线图
        myChart.setOption({
            tooltip : {
                trigger: 'axis'
            },
            grid:{
            	x:25,
            	y:25,
            	x2:15,
            	y2:22,
            	left:'2%',
		    	right: '5%',
		    	containLabel: true
		    },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : datas.xAxis
                }
            ],
            yAxis : [
                {
                    type : 'value',
                }
            ],
            series : [
                {
                    type:'line',
                    data:datas.yAxis
                }
            ]
        });
	  }
  
  if("bar"==datas.sign){	//条形图
        myChart.setOption({
            tooltip : {
                trigger: 'axis'
            },
            grid:{
		    	x:40,
		    	y:25,
		    	x2:10,
		    	y2:22,
		    	left:'2%',
		    	right: '2%',
		    	containLabel: true
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
                    data : datas.xAxis
                }
            ],
            series : [
                {
                    type:'bar',
                    barCategoryGap: '60%',
		            itemStyle: {
		                normal: {
		                    color: 'tomato',
		                    barBorderColor: 'tomato',
		                    barBorderWidth: 0,
		                    barBorderRadius:4,
		                    label : {
		                        show: true, position: 'insideLeft'
		                    }
		                }
		            },
                    data:datas.yAxis
                }
            ]
        });
	  }
  
  if("histogram"==datas.sign){	//柱状图
	  myChart.setOption({
	    tooltip : {
	        trigger: 'axis'
	    },
	    grid:{
	    	x:25,
	    	y:25,
	    	x2:15,
	    	y2:22,
	    	left:'2%',
	    	right: '2%',
	    	containLabel: true
	    },
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            axisLine: {
                    lineStyle: {
                        color: '#4C4C4C'
                    }
                },
	            data : datas.xAxis
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLine: {
                    lineStyle: {
                        color: '#4C4C4C'
                    }
                }
	        }
	    ],
	    series : [
	        {
	            type:'bar',
	            barCategoryGap: '60%',
	            itemStyle: {
	                normal: {
	                    color: 'tomato',
	                    barBorderColor: 'tomato',
	                    barBorderWidth: 6,
	                    barBorderRadius:0,
	                    label : {
	                        show: true, position: 'insideTop'
	                    }
	                }
	            },
	            data:datas.yAxis
	        }
	    ]
	  })
  }
} 
function showReport(){
	var $curPage = ajaxPage.getCurPage();
	var _id = $curPage.attr("id");
	$curPage.find(".report_body").attr("id",_id+"_report_body");	//echart需要获取容器的id，避免id重复，用表单id+"_report_body"
	var data = "";
	var formId = $curPage.find(".report_body").attr("_formId");
	var applicatioId = $curPage.find(".report_body").attr("_applicatioId");;
	$.ajax({
		  //type: "POST",
		  url: contextPath+'/portal/widget/getCustomizeReportData.action',
		  data:{id:formId},
		  success: function(datae){
			  if(datae != ""){
				  $curPage.find(".refreshMenuReport").show();
				  data = JSON.parse(datae);
				  renderOreport(data);
			  }
		    },
		    error:function(error){
		    	console.log(error);
		    }
		})
}