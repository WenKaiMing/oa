<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.km.util.Config"%>
<%@ include file="/portal/share/common/lib.jsp"%>
<%
	String contextPath = request.getContextPath();
	String active = request.getParameter("active");
	String messageId = request.getParameter("messageId");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>消息中心</title>
<link rel="stylesheet" href="<s:url value='/message/plugin/bootstrap/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/message/plugin/fonts/awesome/font-awesome.min.css'/>" />
<link rel="stylesheet" href="<s:url value='/message/css/message.css'/>" />



<script>
var contextPath = '<%=contextPath%>';
var previewEnabled = <%=Config.previewEnabled()%>;

var active = '<%=active%>';
var messageId = '<%=messageId%>';

var USER = {
	id:'<s:property value="#session.FRONT_USER.getId()" />',
	name:'<s:property value="#session.FRONT_USER.getName()" />',
	domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
};
</script>
</head>
<body>
<input type="hidden" id="contextPath" name="contextPath" value="<%=contextPath%>">
<section id="message-content" >
	<div id="loadingDivBack" style="display:none;position: fixed; z-index: 110; width: 100%; height: 100%; top: 0px; left: 0px; filter: alpha(opacity = 0.5); opacity: 0.5;">
		<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
			<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
		</div>
	</div>
    <aside class="message-menu">
        <div class="search clearfix">
            
        </div>
        <div class="list">
            <ul>
                <li class="msg-menu-item active"><a data-type="list">企业动态</a></li>
                <li class="msg-menu-item"><a data-type="remind">工作事项 <span class="badge pull-right" style="display:none"></span></a></li>
                <li class="msg-menu-item"><a data-type="comment">我回复的</a></li>
                <!-- <li class="msg-menu-item"><a data-type="at">提到我的</a></li> -->
            </ul>
        </div>
    </aside>
    <div id="message-center-panel" class="msg-main-panel" data-contype="list" style="display:none;">
        <div class="message-center">
            <div id="msg-write-panel">
            	<div class="msg-write-info clearfix">
            		<div class="pull-left"><img src="img/msg_write_text.png" /></div>
            		<div class="pull-right num" node-type="num">还可以输入<span>140</span>字</div>
            	</div>
                <div class="msg-textarea"><textarea id="msg-write-content" name="content"></textarea></div>
				<div class="msg-setting">
					<div class="msg-func clearfix">                    
				        <div class="pull-left">
				        	<div class="msg-func-item">
					        	<input id="msg-write-upload" name="msg-write-upload" type="hidden" value="" />
					            <span id="filePicker-write" class="func-upload">
					            	<i class="fa fa-plus-square-o func-attachement-icon"></i> 上传附件
					            </span>
				        	</div>
				        	<div class="msg-func-item">
				        		<span id="msg-write-face" class="func-face">
					            	<i class="fa fa-smile-o func-attachement-icon"></i> 表情
					            </span>
				        	</div>

				        </div>
				        <div id="new-notice-btn" class="func-notice pull-right">
				        	<div class="btn btn-default func-announcement-icon">
					        	<span>发公告</span>
					            <i class="fa fa-volume-up"></i>
				        	</div>
				        </div>
				    </div>
				    <div id="write-uploader-list" class="uploader-list msg-uploadlist">
				    	<div class="uploadlist-pic"><ul></ul></div>
				    	<div class="uploadlist-file"></div>
				    </div>
				</div>
				<div class="msg-submit clearfix">
				    <div class="dept pull-left">
				        <div class="dept-title">发送范围:</div>
				        <div class="dept-select-panel">
				            <div class="dept-input-panel">
				                <div class="dept-input">
				                	<input type="hidden" name="content.deptId" value="" id="deptHidden">
				                    <input type="text" name="d_ownerNames" value="" readonly="readonly" id="deptInput" title="" style="outline: none; width: 170px;">
				                </div>
				                <span class="icon-add-people text-center" onclick="selectDept('actionName',{textField:'deptInput',valueField:'deptHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择部门'},'')">
				                    <i class="fa fa-plus"></i>
				                </span>
				                <span class="icon-add-people text-center" onclick="clear1User()">
					        		<i class="fa fa-times"></i>
					        	</span>
				            </div>
				        </div>
				    </div>
				    <div class="func pull-right"> 
				        <button id="write-submit" class="btn btn-success">发布</button>
				    </div>
				</div>
            </div>
            <div id="msg-content-panel">
                <div role="tabpanel">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation"><a href="#message-all" role="tab" data-toggle="tab">全部</a></li>
                        <li role="presentation"><a href="#message-notice" role="tab" data-toggle="tab">公告</a></li>
                        <!-- <div class="input-group search-group pull-right">
			                <input id="startflow-search" name="search" type="text" class="form-control" placeholder="请输入搜索内容" data-list=".startflow-content" autocomplete="off" aria-describedby="basic-addon2">
			                <span class="input-group-addon" id="basic-addon2"><i class="fa fa-search"></i></span>
			            </div> -->
                    </ul>
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane" id="message-all">
                        	<div class="message-list-box"></div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="message-notice">
                        	<div class="message-list-box"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="remind-panel" class="msg-main-panel" data-contype="remind" style="display:none;">
    	<div role="tabpanel">
            <div class="remind-top clearfix">
                <div class="pull-left">
                    <div class="remind-icon text-center"><i class="fa fa-bell-o"></i></div>
                    <ul class="nav nav-tabs remind-tabs" role="tablist">
                    	<div class="remind-tabs-title">提醒</div>
                    	<li class="active" data-read="no">未读</li>
                    	<li class="" data-read="all">全部</li>
                    </ul>
                </div>
                
                <div class="btn-group pull-left notice-select-type" _name="level">
					<a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					类型 <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a _value="0">全部</a></li>
						<li><a _value="3">待办</a></li>
						<li><a _value="6">抄送</a></li>
						<li><a _value="4">催办</a></li>
						<li><a _value="2">回退</a></li>
						<li><a _value="5">超时</a></li>
						<li><a _value="1">已送出</a></li>
					</ul>
				</div>
                
                <div class="remind-btns pull-right">                
                    <div class="btn-group">
                        <button type="button" class="btn btn-info btn-read">当前页标记已读</button>
                    </div>
                </div>
            </div>
            <div class="tab-content remind-list-panel">
                <div role="tabpanel" class="tab-pane active"><ul></ul></div>
            </div>
        </div>
    </div>
    <div id="comment-panel" class="msg-main-panel" data-contype="comment" style="display:none;">
		<div role="tabpanel">
	    	<ul class="nav nav-tabs ireply-tabs" role="tablist">
	        	<li role="presentation" class="active" ><a type="mycomment" href="#message-comment" role="tab" data-toggle="tab">我回复的</a></li>
	        	<li role="presentation" ><a type="commentme" href="#message-commentme" role="tab" data-toggle="tab">回复我的</a></li>
	        </ul>
	        <div class="tab-content">
	            <div role="tabpanel" class="tab-pane active" id="message-comment">
	            	<div class="WB_feed WB_feed_comment ireply-content" node-type="comment_lists">
	            		<div class="ireply-content-list"></div>
	            	</div>
	            </div>
	            <div role="tabpanel" class="tab-pane" id="message-commentme">
	            	<div class="WB_feed WB_feed_comment ireply-me-content" node-type="comment_lists">
	            		<div class="ireply-me-content-list"></div>
	            	</div>
	            </div>
	        </div>
	    </div>
    </div>
    
    <div id="at-panel" class="msg-main-panel" data-contype="at" style="display:none;">
		<div role="tabpanel">
	    	<ul class="nav nav-tabs" role="tablist">
	        	<li class="active" role="presentation"><a href="#message-at" role="tab" data-toggle="tab">动态中提到我的</a></li>
	        	<li role="presentation"><a href="#message-at-comment" role="tab" data-toggle="tab">评论中提到我的</a></li>
	        </ul>
	        <div class="tab-content">
	            <div role="tabpanel" class="tab-pane active" id="message-at">
	            	<div class="WB_feed WB_feed_comment at-content" node-type="comment_lists"></div>
	            </div>
	            <div role="tabpanel" class="tab-pane" id="message-at-comment">
	            	<div class="WB_feed WB_feed_comment at-comment-content" node-type="comment_lists"></div>
	            </div>
	        </div>
	    </div>
    </div>
    
    <div id="notice-show-panel" class="msg-main-panel" style="display:none;"></div>
    <!-- Modal -->
	<div class="modal fade" id="new-notice" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
					<h4 class="modal-title text-center" id="myModalLabel">发公告</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-title text-right">标题：</div>
						<div class="col-con text-left"><input id="notice-title" name="notice-title" class="form-control" type="text" /></div>
					</div>
					<div class="row">
						<div class="col-title text-right">接收人：</div>
						<div class="col-con text-left">
							<div class="input-group">
								<input type="hidden" name="content.deptId2" value="" id="deptHidden2">
	                            <input type="text" class="form-control" name="d_ownerNames2" value="" readonly="readonly" id="deptInput2">
						    	<span class="input-group-btn">
						        	<button class="btn btn-default" type="button" onclick="selectDept('actionName',{textField:'deptInput2',valueField:'deptHidden2',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择部门'},'')">
						        		<i class="fa fa-plus"></i>
						        	</button>
						        	<button class="btn btn-default" type="button" onclick="clear2User()">
						        		<i class="fa fa-times"></i>
						        	</button>
						    	</span>
						    </div>
						</div>
					</div>
					<div class="row">
						<div class="col-title text-right">公告内容：</div>
						<div class="col-con text-left"><script id="notice-container" name="content" type="text/plain"></script></div>
					</div>
					<!-- <div class="row">
						<div class="col-title text-right"></div>
						<div class="col-con text-left">上传附件</div>
					</div> -->
					<div class="row notice-setting">
						<div class="col-title text-right">其他设置：</div>
						<div class="col-con text-left">
							<!-- <label for="comment"><input id="notice-comment" name="comment" type="checkbox" /> 允许评论</label> --> 
							<label for="sticky"><input id="notice-sticky" name="sticky" type="checkbox" /> 置顶</label>
						</div>
					</div>
				</div>
	      		<div class="modal-footer text-left">
	        		<button id="notice-submit" type="button" class="btn btn-primary">发布</button>
	        		<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      		</div>
	    	</div>
	  	</div>
	</div>
</section>


<script id="message-write-tpl" type="text/html">
<div class="msg-write-info clearfix">
            		<div class="pull-left"><img src="img/msg_write_text.png" /></div>
            		<div class="pull-right num" node-type="num">还可以输入<span>500</span>字</div>
            	</div>
                <div class="msg-textarea"><textarea id="msg-write-content" name="content"></textarea></div>
				<div class="msg-setting">
					<div class="msg-func clearfix">                    
				        <div class="pull-left">
				        	<input id="msg-write-upload" name="msg-write-upload" type="hidden" value="" />
				            <span id="filePicker-write" class="func-upload">
				            	<i class="fa fa-plus func-attachement-icon"></i> 上传附件
				            </span>
				        </div>
				        <div id="new-notice-btn" class="func-notice pull-right">
				        	<div class="btn btn-default func-announcement-icon">
					        	<span>发公告</span>
					            <i class="fa fa-volume-up"></i>
				        	</div>
				        </div>
				    </div>
				    <div id="write-uploader-list" class="uploader-list msg-uploadlist">
				    	<div class="uploadlist-pic"><ul></ul></div>
				    	<div class="uploadlist-file"></div>
				    </div>
				</div>
				<div class="msg-submit clearfix">
				    <div class="dept pull-left">
				        <div class="dept-title">发送范围:</div>
				        <div class="dept-select-panel">
				            <div class="dept-input-panel">
				                <div class="dept-input">
				                	<input type="hidden" name="content.deptId" value="" id="deptHidden">
				                    <input type="text" name="d_ownerNames" value="" readonly="readonly" id="deptInput" title="" style="outline: none; width: 170px;">
				                </div>
				                <span class="icon-add-people text-center" onclick="selectDept('actionName',{textField:'deptInput',valueField:'deptHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'选择部门'},'')">
				                    <i class="fa fa-plus"></i>
				                </span>
				                <span class="icon-add-people text-center" onclick="clear1User()">
					        		<i class="fa fa-times"></i>
					        	</span>
				            </div>
				        </div>
				    </div>
				    <div class="func pull-right"> 
				        <button id="write-submit" class="btn btn-success">发布</button>
				    </div>
				</div>
</script>

<script id="message-item" type="text/html">
{{if datas.length > 0}}
{{each datas as value}}
{{if value.type == "1" && value.sticky == true}}
<div class="msg-content-item notice" data-id="{{value.id}}" data-sender="{{value.sender}}" 
data-time="{{value.createTimeChange}}" data-dept="{{value.senderDept}}">
	{{if value.senderId == userid}}<div class="msg-btn-delete"><i class="fa fa-close"></i></div>{{/if}}
	<div class="notice-title"><i class="fa fa-star"></i> <a class="notice-show">{{value.title}}</a><span class="notice-sticky">顶</span></div>
	<div class="notice-con">{{#value.contentReplace}}</div>
	<div class="notice-info" ><a>{{value.sender}}</a> 发布于 {{value.createTimeChange}}</div>
</div>
{{/if}}
{{/each}}
{{each datas as value}}
{{if value.type == "0"}}
<div class="msg-content-item" data-id="{{value.id}}" {{if value.senderId == userid}}data-admin="true"{{/if}}>
	{{if value.senderId == userid}}<div class="msg-btn-delete"><i class="fa fa-close"></i></div>{{/if}}
	<div class="msg-con">
    	<div class="msg-info" data-sender="{{value.sender}}" data-senderid="{{value.senderId}}">
        	<div class="user-face">
			{{if value.avatar != ""}}
				<img src="{{value.avatar}}" title="{{value.sender}}" alt="{{value.sender}}" class="avatar">
			{{else}}
				<div class='noAvatar'>{{value.sender.substr(value.sender.length-2, 2)}}</div>
			{{/if}}
			</div>
            <div class="user-info"><div>{{value.sender}}</div><div>{{value.createTimeChange}}</div></div>
        </div>
        <div class="msg-txt">{{#value.contentReplace}}</div>
		{{if value.attachment != ""}}
			{{if value.attachment != ""}}
				<div class="msg-attachment-pic" data-view="viewer">
				<ul>
				{{each value.attachmentObj as attachmentArr i}}
					{{if attachmentArr.type == "image"}}
					<li class="msg-attachment-pic-item" data-id="{{attachmentArr.id}}" data-url="{{attachmentArr.url}}" data-extname="{{attachmentArr.extName}}"><img src="{{contextPath}}/{{attachmentArr.url}}"></li>
					{{/if}}
				{{/each}}
				</ul>
				</div>
				<div class="msg-attachment-file">
				{{each value.attachmentObj as attachmentArr i}}
					{{if attachmentArr.type == "file"}}
					<div class="msg-attachment-file-item" data-id="{{attachmentArr.id}}" data-url="{{attachmentArr.url}}" data-extname="{{attachmentArr.extName}}"><span class="icon-file icon-file-{{attachmentArr.extName}}"></span> {{attachmentArr.name}}</div>
					{{/if}}
				{{/each}}
				</div>
			{{/if}}
		{{/if}}
	</div>
	<div class="msg-handle"><i class="fa fa-comment"></i> 评论 {{value.commentCount}}</div>
	
	<div class="msg-comment-panel" data-id="{{value.id}}" style="display:none">
    	<div class="msg-comment-write">
        	<div class="msg-comment-textarea">
				<textarea></textarea>
				<input type="hidden" name="tocontent" value="{{#value.content}}"/>
				<input type="hidden" name="toCommentUser" value=""/>
				<input type="hidden" name="commentId" value=""/>
				<input type="hidden" name="touser" value="{{value.sender}}"/>
				<input type="hidden" name="touserid" value="{{value.senderId}}"/>
			</div>
            <div class="msg-comment-func clearfix">
            	<div class="pull-left">
					<!--<span class="func-upload"><i class="fa fa-smile-o func-icon"></i></span>
                    <span class="func-upload"><i class="fa fa-picture-o func-icon"></i></span>-->
                </div>
                <div class="func pull-right"> 
                    <div class="num" node-type="num">还可以输入<span>140</span>字</div>
                    <button class="btn btn-default msg-comment-submit">评论</button>
                </div>
			</div>
		</div>
        <div class="msg-comment-list"><ul></ul></div>
    </div>
</div>
{{else if value.sticky != true}}
<div class="msg-content-item notice" data-id="{{value.id}}" data-sender="{{value.sender}}" 
data-time="{{value.createTimeChange}}" data-dept="{{value.senderDept}}">
	{{if value.senderId == userid}}<div class="msg-btn-delete"><i class="fa fa-close"></i></div>{{/if}}
	<div class="notice-title"><i class="fa fa-star"></i> <a class="notice-show">{{value.title}}</a></div>
	<div class="notice-con">{{#value.content}}</div>
	<div class="notice-info" ><a>{{value.sender}}</a> 发布于 {{value.createTimeChange}}</div>
</div>
{{/if}}
{{/each}}
{{else}}
<div class="placeholder"><div class="placeholder-content"></div></div>
{{/if}}
</script>
<script id="message-comment-item" type="text/html">
{{each datas as value}}
<li class="comment-item" data-id="{{value.id}}" data-sender="{{value.sender}}" data-senderid="{{value.senderId}}">
<div class="comment-avatar"><img class="avatar" src="{{value.avatar}}"></div>
<div class="comment-sender">{{value.sender}}：</div>
<div class="comment-content"><span class="comment-text">{{value.content}}</span> <span class="comment-time">( {{value.createTimeChange}} )</span></div>
<div class="comment-edit"><a class="comment-reply">回复</a>{{owner}} {{if owner || value.owner}}<a class="comment-delete">删除</a>{{/if}}</div>
</li>
{{/each}}
</script>
<script id="message-comment-uppic-item" type="text/html">
{{each datas as value}}
<li class="pic-item"><img src="{{contextPath}}/{{value.url}}"></li>
{{/each}}
</script>
<script id="message-up-item" type="text/html">
{{each datas as value}}
{{if value.type == "image"}}
<li class="pic-item" data-name="{{value.name}}"><img src="{{contextPath}}/{{value.url}}"><i class="fa fa-times icon-delete" style="display: none;"></i></li>
{{else if value.type == "file"}}
<span class="file-item" data-name="{{value.name}}">
	<span class="icon-file icon-file-{{value.extName}}"></span>{{value.name}} <i class="fa fa-times icon-delete"></i>
</span>
{{/if}}
{{/each}}
</script>
<script id="notice-show" type="text/html">
<div class="notice-show-top"><button class="btn btn-default notice-show-close">返回</button></div>
<div class="notice-show-content">
	<div class="notice-info  text-center">
		<div class="notice-title">{{title}}</div>
		<div class="notice-other">
			<span>发布人: {{sender}} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 发布日期: {{time}}</span>
			<!--<span>接收人: {{dept}}</span>-->
		</div>
	</div>
	<div class="notice-content">{{#content}}</div>
</div>
</script>
<script id="remind-list-item" type="text/html">
{{if datas.length > 0}}
{{each datas as value}}
<li class="remind-list-item" data-read="{{if value.read}}true{{else}}false{{/if}}" data-id="{{value.id}}">
	<div class="remind-list-icon"><i class="fa fa-random notice-icon"></i>{{if !value.read}}<span class="notice-circle"></span>{{/if}}</div>
	<div class="remind-list-content">{{if value.subjectType != -1}}<a class="remind-item-text" data-url="{{contextPath}}/portal/dynaform/document/view.action?_docid={{value.linkParams._docid}}&_formid={{value.linkParams._formid}}&application={{value.linkParams.application}}&mode={{value.linkParams.mode}}&backurl={{value.linkParams.backurl}}" title="">{{#value.summary}}</a>{{else}}<span class="remind-item-text" title="">{{#value.summary}}</span>{{/if}}</div>
	<div class="remind-list-edit"><a class="remind-item-delete"><i class="fa fa-trash"></i> 删除</a></div>
	<div class="remind-list-time">{{value.createTimeChange}}</div>
</li>
{{/each}}
{{else}}
<div class="placeholder"><div class="placeholder-content"></div></div>
{{/if}}
</script>
<script id="facelist-panel-tpl" type="text/html">
<div id="facebox" style="top:{{top}};left{{left}}">
	<div class="content">
		<div class="facelist-close">
			<i class="fa fa-times facelist-ficon_close" aria-hidden="true"></i>
		</div>
		<div class="layer_faces">
			<div class="faces_list_box">
				<div node-type="list">
					<ul class="clearfix">
						{{each face as value}}
						<li action-type="select" title="{{value.title}}"><img src="img/face/{{value.file}}"></li>
						{{/each}}
					</ul>
				</div>			
			</div>
		</div>
		<div class="W_layer_arrow">
			<span class="W_arrow_bor W_arrow_bor_t" node-type="arrow">
				<i class="S_line3"></i>
				<em class="S_bg2_br"></em>
			</span>
		</div>
	</div>
</div>
</script>

<script id="ireply-panel-tpl" type="text/html">
{{if datas.length > 0}}
{{each datas as value}}
<div class="WB_cardwrap WB_feed_type S_bg2" node-type="feed_commentList_comment" >
	<div class="WB_feed_detail clearfix">
		<div class="WB_screen pull-right">
			<div class="screen_box" data-id="{{value.id}}" data-messageid="{{value.messageId}}" data-commentid="{{value.commentId}}">
				<a class="comment-delete"><i class="fa fa-close"></i></a>
	        </div>
	    </div>
	    <div class="WB_face pull-left">
	    	<div class="face">
				{{if value.avatar != ""}}
				<img src="{{value.avatar}}" title="{{value.sender}}" alt="{{value.sender}}" class="W_face_radius">
				{{else}}
				<div class='noAvatar'>{{value.sender.substr(value.sender.length-2, 2)}}</div>
				{{/if}}
			</div>
	   	</div>
		<div class="WB_detail">
			<div class="WB_info S_txt2"><a title="{{value.sender}}" class="W_fb S_txt1">{{value.sender}}</a></div>
		    <div class="WB_text">{{value.content}}</div>
		    <div class="WB_expand_media_box" style="display: none;"></div>
		    <div class="WB_feed_expand SW_fun">
		    	<div class="WB_expand S_bg1">
		        	<div class="WB_text S_txt2">{{if value.commentId != ""}}回复{{else}}评论{{/if}}{{value.toUser}}的{{if value.commentId != ""}}评论{{else}}动态{{/if}}：<a href="#" class="S_func1">{{#value.toContentReplace}}</a></div>
		        </div>
		    </div>
		    <div class="WB_from S_txt2">{{value.createTimeChange}}</div>
		</div>
	</div>
</div>
{{/each}}
{{else}}
<div class="placeholder"><div class="placeholder-content"></div></div>
{{/if}}
</script>

<script id="pagination-panel-tpl" type="text/html">
<div id='pagination-panel'>
	<div class='pagination-body'></div>
	<div class='pagination-other'>
		<div class='totalRowPanel'>总条数: {{rowCount}}</div>
	</div>
</div>
</script>

<script src="<s:url value='/message/plugin/jquery-1.11.3.min.js'/>"></script>
<script src="<s:url value='/message/plugin/template.js'/>"></script>
<script src="<s:url value='/message/plugin/bootstrap/bootstrap.min.js'/>"></script>
<script src="<s:url value='/message/plugin/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<script src="<s:url value='/message/plugin/artDialog/plugins/iframeTools.source.js'/>"></script>
<script src="<s:url value='/message/plugin/artDialog/obpm-jquery-bridge.js'/>"></script>
<script src="<s:url value='/message/plugin/jquery.nicescroll.js'/>"></script>

<link rel="stylesheet" href="<s:url value='/message/plugin/pagination/jquery.pagination.css'/>"/>
<script src="<s:url value='/message/plugin/pagination/jquery.pagination.js'/>"></script>

<script src="<s:url value='/script/json/json2.js'/>"></script>
<script src="<s:url value='/portal/share/script/cookie.js' />"></script>

<script src="<s:url value='/message/plugin/obpm.common.js'/>"></script> 

<script type="text/javascript" src="<s:url value='/message/plugin/ueditor/ueditor.config.js'/>"></script>
<script type="text/javascript" src="<s:url value='/message/plugin/ueditor/ueditor.all.min.js'/>"></script>
<script type="text/javascript" src="<s:url value='/message/plugin/ueditor/lang/zh-cn/zh-cn.js'/>"></script>

<link rel="stylesheet" href="<s:url value='/message/plugin/webuploader/webuploader.css'/>">
<script src="<s:url value='/message/plugin/webuploader/webuploader.js'/>"></script>

<link rel="stylesheet" href="<s:url value='/message/plugin/viewer/viewer.min.css'/>" />
<script src="<s:url value='/message/plugin/viewer/viewer.min.js'/>"></script>

<link rel="stylesheet" href="<s:url value='/portal/H5/resource/component/showMessage/sweetalert/sweetalert.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/H5/resource/component/showMessage/toastr/toastr.css'/>" />
<script src="<s:url value='/portal/H5/resource/component/showMessage/sweetalert/sweetalert.min.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/component/showMessage/toastr/toastr.min.js'/>"></script> 
<script src="<s:url value='/portal/H5/resource/component/showMessage/obpm.showMessage.js'/>"></script>

<script src="<s:url value='/message/core/message.core.js'/>"></script>
<script src="<s:url value='/message/core/message.service.js'/>"></script>
<script src="<s:url value='/message/core/message.util.js'/>"></script>


<script>
$(function(){
	Message.main.init(active);
	Common.Util.renderScroll($("#message-center-panel"),{});
	Common.Util.renderScroll($("#comment-panel"),{});
	Common.Util.renderScroll($("#remind-panel"),{});
	Common.Util.renderScroll($("#notice-show-panel"),{});
})

function selectDept(actionName, settings, roleid) {
	var url = contextPath + "/message/questionnaire/selectDept1.jsp";
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	var title = "选择部门";
	if(settings.title){title = settings.title;}
	
	OBPM.dialog.show({
		opener : window.top,
		width : 450,
		height : 350,
		url : url,
		args : {
			// p1:当前窗口对象
			"parentObj" : window,
			// p2:存放userid的容器id
			"targetid" : settings.valueField,
			// p3:存放username的容器id
			"receivername" : settings.textField,
			// p4:默认选中值, 格式为[userid1,userid2]
			"defValue": settings.defValue,
			//选择用户数
			"limitSum": settings.limitSum,
			//选择模式
			"selectMode":settings.selectMode,
			// 存放userEmail的容器id
			"receiverEmail" : settings.showUserEmail
		},
		title : title,
		maximized: false, // 是否支持最大化
		close : function(result) {
		}
	});
}

function clear1User(){
	$("#msg-write-panel").find("#deptHidden").val("");
	$("#msg-write-panel").find("#deptInput").val("");
}

function clear2User(){
	$("#new-notice").find("#deptHidden2").val("");
	$("#new-notice").find("#deptInput2").val("");
}

</script>
</body>
</html>
</o:MultiLanguage>