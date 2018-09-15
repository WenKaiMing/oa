<%@ include file="/portal/share/common/lib.jsp"%>
<%@include file="commonAttachment.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<!DOCTYPE html>
<html>
	<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>

	<link rel="stylesheet" href="../../portal/H5/resource/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../portal/H5/resource/css/myapp.css" />
    <link rel="stylesheet" href="../../portal/H5/resource/css/message.css" />
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="../../portal/H5/resource/css/bootstrap-ie6.css">
<![endif]-->
    <!--[if lte IE 7]>
   <link rel="stylesheet" type="text/css" href="../../portal/H5/resource/css/ie.css">
   <link rel="stylesheet" type="text/css" href="../../portal/H5/resource/css/myapp-ie.css" />
   <link rel="stylesheet" type="text/css" href="../../portal/H5/resource/css/message-ie.css" />
<![endif]-->
    <!--[if lt IE 9]> 
   <script src="../../portal/H5/resource/script/html5shiv.min.js"></script>
<![endif]-->

	<script src="../../portal/H5/resource/script/jquery.min.js"></script>
    <script src="../../portal/H5/resource/script/bootstrap.min.js"></script>




	<!-- 兼容ie6半透明 -->
	<script src='<s:url value='/portal/share/script/iepngfix_tilebg.js' />'></script>
	<script src='<s:url value="/portal/share/script/jquery-ui/jquery-ui.js"/>'></script>
	
	<!-- 弹出层插件--start -->
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/interface/PersonalMessageHelper.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>
	<script>
	
	var contextPath = '<%=request.getContextPath()%>';
	var sysMsgListUrl = contextPath+"/portal/personalmessage/list.action?messageType=0";
	var usrMsgListUrl = contextPath+"/portal/personalmessage/list.action?messageType=1";
	var announcementMsgListUrl = contextPath+"/portal/personalmessage/list.action?messageType=2";
	var voteMsgListUrl = contextPath+"/portal/personalmessage/list.action?messageType=3";
	var newUsrMsgUrl = "<s:url value="/portal/share/personalmessage/content.jsp"/>";
	var newAnnouncementMsgUrl = "<s:url value="/portal/share/personalmessage/announcementContent.jsp"/>";
	var newVoteMsgUrl = "<s:url value="/portal/share/personalmessage/voteContent.jsp"/>";
	var replyMsgUrl = "<s:url value="/portal/share/personalmessage/reply.jsp"/>";
	var searchListUrl = contextPath+"/portal/personalmessage/searchInbox.action";
	var voteTitle = '投票';
	
	$(function(){
		//通过ajax获取Json数据	
		function _getJSONData(tabId,pageNo, url) {
			$.ajax({
				url: url,
				type:"post",
				datatype:"jason",
				data: {
					"_search":$("#sch_input_bar").val(),
					"_currpage":pageNo,
					"_pagelines": $("#_pagelines").val(),
					"keyword": $("#sch_input_bar").val()					
					},
				success:function(result){
					_render(result, tabId);
				},				
				
				error:function(data,status){
					alert("failling to get JSON...");
				}
			});	
		}
		
		//构建附件链接元素
		function _buildAttachmentLinks(msgIds, msgNames) {
			var links = "";
			var ids = [];
			var names = [];
			if(msgIds != null && msgIds.indexOf(";") != -1) {
				ids = msgIds.split(";");
			} else {
				ids.push(msgIds);
			}
			if(msgNames != null && msgNames.indexOf(";") != -1) {
				names = msgNames.split(";");
			} else {
				ids.push(msgNames);
			}
			for(var i = 0; i < ids.length; i++) {
				if(ids[i] != null && ids[i].length > 0) {
					links += "<img style='vertical-align:middle' src='../share/personalmessage/images/attachment.png' onclick=downloadAttachment('" + ids[i] + "') title='" + names[i] + "'/>";
				}
			}
			return links;
		}
		
		//Ajax结果返回后，进行渲染
		function _render(result, tabId) {
			//处理翻页
			if(result.pageCount != 0){
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
				}
			} else {
				$("#bottom_page_info").hide();
			}
			
		    //绑定查询栏
		    $("#sch_input_bar").unbind("keypress").bind("keypress",function(e){ 
				var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
				if(keyCode == 13) {
					$("#sch_image_bar").trigger("click");
					return false;
				}
			});		
				
			$("#sch_image_bar").unbind("click").bind("click",function(){
				_getJSONData($(".active").attr("tabid"),1,searchListUrl);
			});
	    
		    //绑定翻页事件
			var tabId = $(".active").attr("tabid");
			$(".first").unbind("click").bind("click", function(){
				_getJSONData(tabId, 1, searchListUrl);
			});
			$(".previous").unbind("click").bind("click", function(){
				_getJSONData(tabId, parseInt($("#currPageNo").text())-1, searchListUrl);	
			});
			$(".next").unbind("click").bind("click", function(){
				_getJSONData(tabId, parseInt($("#currPageNo").text())+1, searchListUrl);	
			});
			$(".end").unbind("click").bind("click", function(){
				_getJSONData(tabId, $("#pageCount").val(), searchListUrl);	
			});		
			
			$(".current_page_no").text(result.pageNo);
			$(".total_page_no").text(result.pageCount);
			$(".total_entries").text(result.rowCount);
			
			var datas = result.datas;
			var html = "";	
			var op;
			if(tabId == '#sys_msg_tab'){//系统消息
				$.each(datas, function(index, element){
					var content = element.body.content.replace(/<[^>]+>/g,'');
					var readClass = element.read? "":"unread";
					html += "<li class='"+readClass+"' msgId='" + element.id + "'>" 
						+ "<input name='_selects' value='" + element.id + "' type='checkbox'>" 
						+ "<span class='title'><i class='glyphicon glyphicon-volume-up'></i> 系统通知：</span>" 
						+ "<span class='text'>" + (content.length>50?content.substring(0,50)+"...":content) + "</span>"
						+ "<span class='time'>" + element.sendDate + "</span></li>";

				});
				
				searchListUrl = sysMsgListUrl;
				$("#sys_msg_text").html(html);
			} 
			else if(tabId == "#usr_msg_tab") {//用户消息
				jQuery.each(datas, function(index, element){
					var content = element.body.content;
					var sendDate = element.sendDate;
					var name = element.senderName;
					var attid = element.attachmentIds;
					var attName = element.attachmentNames;
					var readClass = element.read? "":"unread";
					html += "<li class='"+readClass+"' msgId='" + element.id + "'><table><tr>" 
						+ "<td width='15'><input name='_selects' value='" + element.id + "' type='checkbox' /></td>" 
						+ "<td width='55'><span class='title'><img src='../share/personalmessage/images/face.png' /></span></td>" 
						+ "<td><span class='text'>" + name + "<br />对你说：" + content.replace(/<[^>]+>/g,'').substring(0,120) + "</span>" 
						+ "<span class='s_attachment' style='padding-left:10px;'>" +  _buildAttachmentLinks(attid, attName) + "</span></td>" 
						+ "<td width='180'><span class='time'>" + sendDate + "<br />"						
						+ "<a class='replyMsg' style='color:#0066cc' href='#newMsg'>回复</a></span></td></tr></table></li>";

				});
				
				searchListUrl = usrMsgListUrl;
				//绑定【回复】事件
				$("#usr_msg_text").html(html).find(".replyMsg").unbind("click").bind("click", function(){
					showDialog2();
				});
				
			} else  if(tabId == '#announcement_msg_tab') {//公告
				jQuery.each(datas, function(index, element){
					var content = element.body.content;
					var sendDate = element.sendDate;
					var attid = element.attachmentIds;
					var attName = element.attachmentNames;
					var readClass = element.read? "":"unread";
					html += "<li class='announcement_msg_item msg_item " + readClass + "' msgId='" + element.id + "'>" + "<input name='_selects' value=" + element.id + " type='checkbox' />" + "<span class='title'><img src='../share/personalmessage/images/face.png' /> 公告：</span>" + "<span class='text'>" + content.replace(/<[^>]+>/g,'').substring(0,120) + "</span>" + "<span class='s_attachment' style='padding-left:10px;'>" + _buildAttachmentLinks(attid, attName) + "</span>" + "<span class='time'>" + sendDate + "</span></li>";
				});
//				html = getAnnouncementMsgs(datas, "../share/personalmessage/images/head.gif");
				searchListUrl = announcementMsgListUrl;

				$("#announcement_msg_text").html(html).find(".msg_item>span").unbind("click").bind("click", function(){
					var announcement_msg_url = contextPath + "/portal/personalmessage/redirect.action?messageType=2&id=" + $(this).attr("msgId");
					$("#navTest").attr("href", announcement_msg_url);
					parent.parent.addTab($(this).attr("id"), "公告", announcement_msg_url);
				});
			}
			//清除消息中的调查功能
			/*else if(tabId = '#vote_msg_tab') {
				jQuery.each(datas, function(index, element){
					var content = element.body.content;
					var sendDate = element.sendDate;
					var attid = element.attachmentIds;
					var attName = element.attachmentNames;
					html += "<li class='vote_msg_item msg_item' msgId='" + element.id + "'>" + "<input name='_selects' value=" + element.id + " type='checkbox' />" + "<span class='title'><img src='../share/personalmessage/images/face.png' /> 投票：</span>" + "<span class='text'>" + content.replace(/<[^>]+>/g,'').substring(0,120) + "</span>" + "<span class='s_attachment' style='padding-left:10px;'>" + _buildAttachmentLinks(attid, attName) + "</span>" + "<span class='time'>" + sendDate + "</span></li>";
				});
				searchListUrl = voteMsgListUrl;
				$("#vote_msg_text").html(html).find(".vote_msg_item").unbind("click").bind("click", function(){
					var vote_msg_url = contextPath + "/portal/personalmessage/redirect.action?messageType=3&id=" + $(this).attr("msgId");
					OBPM.dialog.show({
						width : 800,
						height :400,
						url : vote_msg_url,
						args : {},
						title : voteTitle,
						close : function(result) {
						}
					});			
				});
			}*/
		}
		
		//tab的切换效果
		$(".tabs").unbind("click").bind("click",function(){
			$(".tabs").each(function(){
				$(this).removeClass("active");
			});
			
			$(this).addClass("active");
			var tabId = $(this).attr("tabid");
			if(tabId == '#sys_msg_tab') {
				_getJSONData(tabId, 1, sysMsgListUrl);	
			} else if(tabId == '#usr_msg_tab') {
				_getJSONData(tabId, 1, usrMsgListUrl);	
			} else if(tabId == '#announcement_msg_tab') {
				_getJSONData(tabId, 1, announcementMsgListUrl);	
			}
			$(".tabContent").hide();
			$(tabId).show();						
		});	
		
		//绑定用户信息新建按钮
		$(".addUsrMsg").unbind("click").bind("click",function(){
			showDialog();
		});
		//绑定公告新建按钮
		$(".addAnnouncementMsg").unbind("click").bind("click",function(){
			showDialog3();
		});	
		//绑定标记已读按钮
		$(".setReaded").unbind("click").bind("click",function(){
			var $this = $(this);
			var $divBox = $this.parents(".tabContent[role='tabpanel']");
			$divBox.find(".dataTable li").each(function(){
				var $select = $(this).find("input[type='checkbox']");
				if($select.is(':checked')){
					var id = $(this).attr("msgId");
					$.get("readMessage.action",{"id":id},function(){
						$(this).removeClass("unread");
					});
				}
			});
		});
		
		//绑定删除按钮
		$(".delBtn,.delAllBtn").click(function(){
			var $this = $(this);
			var tabs = $(".tabs.active").text();
			if ($(this).hasClass("delAllBtn")){//整页删除
				if(tabs=="系统消息"){   //判断是哪个tab
					$("#sys_msg_text input[name='_selects']").attr("checked", true);
				}
				if(tabs=="用户消息"){
					$("#usr_msg_text input[name='_selects']").attr("checked", true);
				}
				if(tabs=="公告"){
					$("#announcement_msg_text input[name='_selects']").attr("checked", true);
				}
				if(tabs=="投票"){
					$("#vote_msg_text input[name='_selects']").attr("checked", true);
				}
			}
			else {//单条删除
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
			        data:$('#subNewMsg').serialize(),// 你的formid
			        async: false,
			        error: function(request) {
			            alert("Connection error");
			        },
			        success: function(data) {
			        	_render(data, $(".active").attr("tabid"));
			        }
			    });
				
			}else {
				$("input[name='_selects']").attr("checked", false); 
			}		
		});
		$("li a:first").trigger("click");
		
		//jquery-ui-button
		$(".delBtn,.delAllBtn,.addUsrMsg,.addAnnouncementMsg,.addVoteMsg").button();

		$("#message-body").on("mouseover",".unread",function(e){//注册鼠标经过标记已读事件
			var $this = $(this);
			var id = $this.attr("msgId");
			$.get("readMessage.action",{"id":id},function(){
				$this.removeClass("unread");
			});
		});
	});
	
	function showDialog() {
		OBPM.dialog.show({
			width : 600,
			height :415,
			url : newUsrMsgUrl,
			args : {},
			title : '{*[New]*}',
			close : function(result) {
				var $actTabID = $(".nav-tabs").find("a.active").attr("tabid");
				$("a[tabid='"+$actTabID+"']").trigger("click");
			}
		});				
	}

	function showDialog2() {
		OBPM.dialog.show({
			width : 600,
			height :415,
			url : replyMsgUrl,
			args : {},
			title : '{*[New]*}',
			close : function(result) {
				var $actTabID = $(".nav-tabs").find("a.active").attr("tabid");
				$("a[tabid='"+$actTabID+"']").trigger("click");
			}
		});				
	}

	function showDialog3() {
		OBPM.dialog.show({
			width : 600,
			height :440,
			url : newAnnouncementMsgUrl,
			args : {},
			title : '{*[New]*}',
			close : function(result) {
				var $actTabID = $(".nav-tabs").find("a.active").attr("tabid");
				$("a[tabid='"+$actTabID+"']").trigger("click");
			}
		});				
	}
	
	function showDialog4() {
		OBPM.dialog.show({
			width : 650,
			height :550,
			url : newVoteMsgUrl,
			args : {},
			title : '{*[New]*}',
			close : function(result) {
				var $actTabID = $(".nav-tabs").find("a.active").attr("tabid");
				$("a[tabid='"+$actTabID+"']").trigger("click");
			}
		});				
	}
	</script>
	</head>
	<body style="overflow-x: hidden;">
		<s:form id="subNewMsg" name="formList" method="post" theme="simple" action="">
			<%@include file="/common/basic.jsp" %>
			<div id="right">
        <div id="message-body" class="crm_right" style="margin: 3px 15px 0 14px;">
        	<%@include file="/portal/share/common/msg.jsp"%>
				<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
					<%@include file="/portal/share/common/msgbox/msg.jsp"%>
				</s:if>		
				<input type="hidden" id="_pagelines" value="10"/>
				<input type="hidden" id="pageCount" value="0"/>

            <div class="searchDiv" style="border-top: 0px;border-bottom: 0px; padding: 0px 10px; height: 100%;">
                <div role="tabpanel">
                    <ul class="nav-tabs" role="tablist">
                        <li role="presentation">
                        	<a class="tabs" href="###" tabid="#sys_msg_tab">{*[cn.myapps.core.personalmessage.system_message]*}</a>
                        </li>
                        <li role="presentation">
                        	<a class="tabs" href="###" tabid="#usr_msg_tab">{*[cn.myapps.core.personalmessage.user_message]*}</a>
                        </li>
                        <li role="presentation">
                        	<a class="tabs" href="###" tabid="#announcement_msg_tab">{*[cn.myapps.core.personalmessage.announcement]*}</a>
                        </li>
                        <div class="clearfix"></div>
                    </ul>
                    <div class="tab-content">

                    	<div id="input_ search_bar" class="search_bar">
                    		<div class="input-group">
                    			<input id="sch_input_bar" type="text" class="form-control" placeholder="用户消息搜索">
                    			<img id="sch_image_bar" class="sch_image_bar" src="../share/personalmessage/images/search_btn.png" />
                    		</div>
                    	</div>






                        <div role="tabpanel" class="tabContent" id="sys_msg_tab">
                            <div class="form-group">
                                <table style="width:100%">
                                    <tr valign="top">
                                        <td>
                                        	<a id="sys_msg_remove" class="btn btn-danger delBtn" _href='<s:url action="delete"/>?messageType=0'>{*[Delete]*}</a>
											<a id="sys_msg_removeall" class="btn btn-warning delAllBtn" _href='<s:url action="delete"/>?messageType=0' >{*[Empty]*}</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="dataTable">
                                <ul>
									<div id="sys_msg_text"></div>
                                </ul>
                            </div>
                        </div>

                        <div role="tabpanel" class="tabContent" id="usr_msg_tab">
                            <div class="form-group">
                                <table style="width:100%">
                                    <tr valign="top">
                                        <td>
                                        	<a class="btn btn-primary addUsrMsg" href="#newMsg" >{*[New]*}</a>
											<a class="btn btn-danger delBtn" _href='<s:url action="delete"/>?messageType=1'>{*[Delete]*}</a>
											<a class="btn btn-warning delAllBtn" _href='<s:url action="delete"/>?messageType=1'>{*[Empty]*}</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="dataTable">
                                <ul>
                                	<div id="usr_msg_text"></div>
                                </ul>
                            </div>
                        </div>
                        <div role="tabpanel" class="tabContent" id="announcement_msg_tab">
                            <div class="form-group">
                                <table style="width:100%">
                                    <tr valign="top">
                                        <td>
                                        	<a class="btn btn-primary addAnnouncementMsg" href="#newMsg" >{*[New]*}</a>
                                        	<a class="btn btn-danger delBtn" _href='<s:url action="delete"/>?messageType=2'>{*[Delete]*}</a>
                                        	<a class="btn btn-warning delAllBtn" _href='<s:url action="delete"/>?messageType=2'>{*[Empty]*}</a>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="dataTable">
                                <ul>
                                	<div id="announcement_msg_text"></div>	
                                </ul>
                            </div>
                        </div>
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
            </div>
        </div>
        <div class="clearfix"></div>
    </div>


		</s:form>
	</body>
</o:MultiLanguage>