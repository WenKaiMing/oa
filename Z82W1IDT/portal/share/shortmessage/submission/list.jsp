<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/lib.jsp"%>
<%@ include file="/portal/share/common/js_baseH5_msg.jsp"%>
<!DOCTYPE html>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>{*[ShortMessage]*}</title>

    <script type="text/javascript" src="<s:url value='/portal/H5/resource/script/bootstrap.min.js'/>"></script>
    <!--[if lte IE 6]>
  <script type="text/javascript" src="<s:url value='/portal/H5/resource/script/bootstrap-ie.js' />"></script>
<![endif]-->



	<script src="<s:url value='/portal/share/script/jquery-ui/jquery-ui.js'/>"></script>
	<!-- 兼容ie6半透明 -->
	<script src="<s:url value='/portal/share/script/iepngfix_tilebg.js' />"></script>
	<script src="<s:url value="/portal/share/script/list.js"/>"></script>
	<script>
	$(function(){
		var SMS = {};
		var contextPath = '<%=request.getContextPath()%>';
		var submissionPath = contextPath + "/portal/shortmessage/submission";
		
		SMS['doRender']=function(result){//根据JSON数据进行页面的渲染
			//处理翻页
			$("#_pagelines").val(result.linesPerPage);
			$("#pageCount").val(result.pageCount);
			$(".page_info").show();

		    if(result.pageNo < result.pageCount) {
				if(result.pageNo == 1) {
					$(".first,.previous").hide();
					$(".next,.end").show();
				} else {
					$(".first,.previous,.next,.end").show();
				}
			} else if(result.pageNo == result.pageCount) {
				if(result.pageNo == 1) {
					$(".page_info").hide();
				} else {
					$(".first,.previous").show();
					$(".next,.end").hide();
				}
			} else {
				$(".page_info").hide();
			}
		    $(".current_page_no").text(result.pageNo);
			$(".total_page_no").text(result.pageCount);
			$(".total_entries").text(result.rowCount);
			
			var datas = result.datas;
			var html = "";	
			jQuery.each(datas, function(index, element){
			html += "<table id='mail_content' class='mail_content'><tbody><tr class='listDataTr' >" + "<td class='listDataTrFirstTd'><input name='_selects' value=" + element.id + " type='checkbox'/></td>" + "<td class='listDataTrTd' style='text-align:left' >" + "<span class='column column1 mobile'><img src='" + contextPath + "/portal/share/shortmessage/submission/images/mobile.gif'/></span> " + "<span class='column column2 receiver' style='color:#0066cc'>" + element.receiverName + "(" + element.receiver + ")</span> " + "<span class='column column3 content' title='" + element.content + "'>" + element.content.substring(0, 60) + "</span> " + " <span class='column column4 sendDate'>" + element.sendDate +"</span> " + "<span class='column column5 status' style='color:#0066cc'>" + (!element.failure ? '已发送' : '发送失败')+ "</span>" + "</td></tr></tbody></table>"

			});
			jQuery("#sms_msg_list").html(html);
			
		};
		
		SMS['doQueryList']=function(url, pageNo){//通过AJAX获取JSON数据
			$.ajax({
				url: url,
				type:"post",
				datatype:"jason",
				data: {
					"_currpage":pageNo,
					"_pagelines": $("#_pagelines").val(),
					"_receiverName" : $("#_receiverName").val(),
					"_content" : $("#_content").val()
					},
				success:function(result){
					SMS.doRender(result);
				},				
				
				error:function(data,status){
					alert("failling to get JSON...");
				}
			});	
		};
		SMS.doQueryList(submissionPath + "/queryList.action", 1);
		

		//绑定新建按钮操作事件
		jQuery(".createMsg").bind('click',function(){
			OBPM.dialog.show({
				width : 600,
				height :350,
				url : "<s:url value="/portal/share/shortmessage/submission/content.jsp"/>" ,
				args : {},
				title : '{*[New]*}',
				close : function(result) {
					SMS.doQueryList(submissionPath + "/queryList.action", 1);
				}
			});		
		});
		
		
		//绑定删除按钮
		$(".delBtn,.delAllBtn").click(function(){
			var $this = $(this);
			
			if ($(this).hasClass("delAllBtn")){//整页删除
				$("input[name='_selects']").attr("checked", true); 
			} else {//单条删除
				if($("input[name=_selects]:checked").size() <= 0){
					alert("{*[select_one_at_least]*}");
					return;
				}
			}
			if(window.confirm('{*[cn.myapps.core.message.confirm.delete]*}')) {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url: $this.attr("_href"),
			        data:$('#formId').serialize(),// 你的formid
			        async: false,
			        error: function(request) {
			            alert("Connection error");
			        },
			        success: function(data) {
			        	SMS.doRender(data);
			        }
			    });
				
			}else {
				$("input[name='_selects']").attr("checked", false); 
			}		
		});
		
		//绑定查询按钮事件
		jQuery(".query-button").click(function(){
			SMS.doQueryList(submissionPath + "/queryList.action", 1);
		});
		
		//绑定重置按钮事件
		jQuery(".reset-button").click(function(){
			$("#_receiverName").val("");
			$("#_content").val("");
		});
		
		 //绑定翻页事件
		$(".first").unbind("click").bind("click", function(){
			SMS.doQueryList(submissionPath + "/queryList.action", 1);
		});
		$(".previous").unbind("click").bind("click", function(){
			SMS.doQueryList(submissionPath + "/queryList.action", parseInt($("#currPageNo").text())-1);
		});
		$(".next").unbind("click").bind("click", function(){
			SMS.doQueryList(submissionPath + "/queryList.action", parseInt($("#currPageNo").text())+1);
		});
		$(".end").unbind("click").bind("click", function(){
			SMS.doQueryList(submissionPath + "/queryList.action", $("#pageCount").val());
		});		
		
		$(".query-button,.reset-button,.createMsg,.delBtn,.delAllBtn").button();
		
		
		$(".sms_dataTable").height($(window).height()-$(".searchDiv").outerHeight()-31);
	});
	
	function selectUsers(_receiver, _receiverName) {
		var settings = {
			"showUserTelephone":_receiver,
			'textField' : _receiverName
		};
		showUserSelectNoFlow("", settings,"");
	}
	</script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/portal/H5/resource/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/portal/H5/resource/css/myapp.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/portal/H5/resource/css/message.css" />
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/portal/H5/resource/css/bootstrap-ie6.css">
<![endif]-->
    <!--[if lte IE 7]>
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/portal/H5/resource/css/ie.css">
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/portal/H5/resource/css/myapp-ie.css" />
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/portal/H5/resource/css/message-ie.css" />
<![endif]-->
    <!--[if lt IE 9]> 
   <script src="<%=request.getContextPath()%>/portal/H5/resource/script/html5shiv.min.js"></script>
<![endif]-->

<script src="<s:url value='/portal/share/component/dialog/dialog.js' />"></script>
	</head>
	<body style="overflow-x:hidden;margin:0px;" class="body-front">
	    

    <div id="right container">
		<s:form id='formId' name="formList" action="list" method="post" theme="simple">
			<input type="hidden" name="_currpage" id="_currpage" val=""/>
			<input type="hidden" name="_pagelines" id="_pagelines" val="10"/>
			<input type="hidden" id="pageCount" value="0"/>




        <div id="message-body" class="crm_right" style="margin:0px 15px 0 14px;">
            <div class="searchDiv" style="border-top:0px">
                <form class="form-group" role="form">
                    <table style="width:100%">
                        <tr valign="top">
                            <td>
                            	<a class="btn btn-primary createMsg" href="###" >{*[New]*}</a>				
								<a class="btn btn-danger delBtn" _href='<s:url action="delete"/>'>{*[Delete]*}</a>
								<a class="btn btn-warning delAllBtn" _href='<s:url action="delete"/>'>{*[Empty]*}</a>
                            </td>
                            <td width="150">
                                <div class="input-group">
                                    <input type="text" name="_receiverName" id="_receiverName" value="" class="form-control" placeholder="{*[Receiver]*}" />
                                    <input type="hidden" name="_receiver" id="_receiver" value=""/>
                                    <span class="input-group-btn">
                                    	<button class="btn btn-default" type="button" onclick="selectUsers('_receiver', '_receiverName');" title="{*[Choose]*}{*[User]*}">{*[Choose]*}</button>
                                	</span>
                                </div>
                            </td>
                            <td width="150">
                                <div class="input-group">
                                    <input type="text" name="_content" id="_content" class="form-control" placeholder="{*[Content]*}">
                                    <div class="input-group-btn">
                                    	<a class="query-button btn btn-default ">查询</a>
                                	</div>
                                </div>
                            </td>
                            <td width="50">
                                <a class="btn btn-default reset-button" href="###">重置</a>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="sms_dataTable" style="border-bottom:0px">
                <div id="sms_msg_list"></div>
                <div id="bottom_page_info" class="page_info">
					<div style="vertical:middle;padding-top:5px;padding-bottom:5px;">
						<span>&nbsp;共</span>
						<span class="total_page_no"></span>
						<span>页</span>
						<a class="first page_button" href="###"><<</a>
						<a class="previous page_button"  href="###"><</a>
						<span  id="currPageNo" class="current_page_no page_button page_no_button"></span>
						<a class="next page_button" href="###">></a>
						<a class="end page_button"  href="###">>></a>
					</div>	
				</div>
            </div>
        </div>
        <div class="clearfix"></div>
        </s:form>
    </div>






	</body>
</o:MultiLanguage>
</html>

