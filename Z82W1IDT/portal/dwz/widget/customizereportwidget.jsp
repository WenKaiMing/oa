<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!-- <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="100%"
	codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
	id="ie_chart"
	align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="movie"
		value="widget/open-flash-chart.swf?data-file=<s:url value='/portal/widget/getCustomizeReportData.action'> <s:param name='id' value='#request.widget.actionContent'/> </s:url>" />
	<param name="quality" value="high" />
	<param name="bgcolor" value="#eeeeee" />
	<param name="wmode" value="opaque" />
	<embed src="widget/open-flash-chart.swf?data-file=<s:url value='/portal/widget/getCustomizeReportData.action'> <s:param name='id' value='#request.widget.actionContent'/> </s:url>" quality="high" width="100%" height="100%"
		bgcolor="#eeeeee" style="width:100%;height:100%;" wmode="opaque"
		name="chart" align="middle" allowScriptAccess="sameDomain"
		type="application/x-shockwave-flash"
		pluginspage="http://www.macromedia.com/go/getflashplayer"
		id="chart3" wmode="window"/>
</object> -->
<%String id = request.getParameter("id"); %>
<html>
<body>
	<div id="ec<%=id%>" style="height:250px;border:0px solid #ccc;padding:0px;"></div>
</body>
<script type="text/javascript" src="./resource/chart/echarts.js"></script>

<script type="text/javascript">

function initEchar(){
	    // 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
	    require.config({
	        paths: {
	            echarts: '../cool/resource'
	        }
	    });
	    // 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
	    require(
	        [
	            'echarts',
	            'echarts/chart/pie',
	            'echarts/chart/bar',
	            'echarts/chart/line',
	            'echarts/chart/scatter'
	        ],
	    function (ec) {
	        var cid = '<s:property value="#request.widget.actionContent"/>';
	        var contextPath = '<%=request.getContextPath()%>';
	        $.ajax({
				  //type: "POST",
				  url: contextPath+'/portal/widget/getCustomizeReportData.action',
				  data:{id:cid},
				  success: function(datae){
				var datas = eval('(' + datae + ')');
				var title ="";
			  if("pie"==datas.sign){
	            var myChart = ec.init(document.getElementById('ec<%=id%>'));
	            myChart.setOption({
	            	title : {
	                    text: title,
	                    x:'center'
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
	                        data:datas.data
	                    }
	                ]
	            });
			  }
			  
			  if("scatter"==datas.sign){
		            var myChart = ec.init(document.getElementById('ec<%=id%>'));
		            myChart.setOption({
		            	title : {
		                    text: title,
		                    x:'center'
		                },
		                tooltip : {
		                    trigger: 'axis'
		                },
		                grid:{
		                	x:25,y:25,x2:15,y2:22
					    },
		                calculable : true,
		                xAxis : [
		                    {
		                    	type : 'value',
		                    }
		                ],
		                yAxis : [
		                    {
		                        type : 'value',
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
			  
			  if("area"==datas.sign){
		            var myChart = ec.init(document.getElementById('ec<%=id%>'));
		            myChart.setOption({
		            	title : {
		                    text: title,
		                    x:'center'
		                },
		                tooltip : {
		                    trigger: 'axis'
		                },
		                grid:{
		                	x:25,y:25,x2:15,y2:22
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
			  
			  if("line"==datas.sign){
		            var myChart = ec.init(document.getElementById('ec<%=id%>'));
		            myChart.setOption({
		            	title : {
		                    text: title,
		                    x:'center'
		                },
		                tooltip : {
		                    trigger: 'axis'
		                },
		                grid:{
		                	x:25,y:25,x2:15,y2:22
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
			  
			  if("bar"==datas.sign){
		            var myChart = ec.init(document.getElementById('ec<%=id%>'));
		            myChart.setOption({
		            	title : {
		                    text: title,
		                    x:'center'
		                },
		                tooltip : {
		                    trigger: 'axis'
		                },
		                grid:{
					    	x:40,y:25,x2:10,y2:22
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
		            });
				  }
			  
			  if("histogram"==datas.sign){
				  var myChart = ec.init(document.getElementById('ec<%=id%>'));
				  myChart.setOption({
					title : {
						text: title,
	                    x:'center'
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    grid:{
				    	x:25,y:25,x2:15,y2:22
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : datas.xAxis
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
			  
			}})
	    }
	);
}

$(document).ready(function(){
			setTimeout(initEchar,1000);
});
</script>
</html>
</o:MultiLanguage>
