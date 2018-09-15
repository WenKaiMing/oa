<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="pm-page pm-page-project">
	<div class="cell-content-part project-setting-project">
		<div class="title skin-h5">
			<h3>项目</h3>
			<a class="cell-btn-blue J_AddProject" href="javascript:void(0);" data-target="#W_AddProject"><span>+</span>新建项目</a>
			<div class="search-input on-search-active"> 
				<input id="search-projectName" name="search" class="nav-search-input" type="text" placeholder="输入项目名按回车查询" data-list=".startflow-content" autocomplete="off" aria-describedby="basic-addon2"> 
				<div class="btn-group open-closePro" style="position: absolute;right: -210px;top: 0px;width: 132px;">
					<div class="closePro_checkbox">
						<div class="closePro_checkbox_div"><i class="iconfont-h5 checkbox_i">&#xe055;</i></div>
						<span class="close_show" style="padding: 0px;font-size: 14px;margin-left: 25px;">显示已关闭项目</span>
					</div>
					
			    </div>  
			</div>
		</div>
		<div class="content">
			<ul class="cell-box-list-project J_BoxList clearfix"></ul>
		</div>
	</div>
	<!-- 项目条目 模板 -->
	<script id="tmplProjectItem" type="text/x-jquery-tmpl">
						<li class="task-item {%if closed==true%}project-close-bg{%/if%}" data-id="${id}" data-closed="${closed}" data-name="${name}" data-creator-id="${creatorId}" data-manager-id="${managerId}">
							<div class="task-item-ear"></div>
							<div class="task-title {%if closed==true%}project-close-title{%/if%}">${name}</div>
							<div class="meta-data"><span class="task-count">${tasksTotal}<br/>总任务</span><span>${finishedTasksNum}<br/>已完成</span><span>${$item.getTaskFinishedPercent()}%<br/>进度</span>
							</div>
							{%if managerId==USER.id%}
								<i class="icon-dp-menu"></i>
								<div class="task-menu"><i class="icon-triangle"></i><a class="A_EditProject" href="javascript:void(0);">编辑项目</a><a class="A_DeleteProject" href="javascript:void(0);">删除项目</a>
								{%if closed==false%}
									<a class="A_CloseProject" href="javascript:void(0);">关闭项目</a>
								{%else%}
									<a class="A_CloseProject" href="javascript:void(0);">打开项目</a>
								{%/if%}
								</div>
							{%/if%}
						</li>
					</script>
	<!-- 成员列表 模板 -->
	<script id="tmplMemberItem" type="text/x-jquery-tmpl">
	{%each members%}
		{%if memberType != 2 %}
			{%if memberType == 1%}
			<li class="member-item" data-user-name="${userName}" data-user-id="${userId}" data-memberType="${memberType}" data-manager="${manager}">
				<div class="_img"><i class="fa fa-user"></i></div>
				<div class="member-title _text is_manager">
					${userName}																										
				</div>
				<div style="clear:both;"></div>
			</li>
			{%/if%}
		{%/if%}
	{%/each%}
	{%each members%}
		{%if memberType != 2 %}
			{%if memberType == 0 %}
			<li class="member-item" data-user-name="${userName}" data-user-id="${userId}" data-memberType="${memberType}" data-manager="${manager}">
				<div class="member-title _text">
					${userName}																										
				</div>
				<div style="clear:both;"></div>
				<i class="icon-dp-menu" ></i>
				<div class="Setmembers _act" style="display:none;">
					<button class="_SetManager">
						<a class="A_SetManager">设为管理员</a>
					</button>
					<button class="A_DeleteMember">
						<a>删除</a>
					</button>
				</div>
				<div style="clear:both;"></div>
			</li>
			{%/if%}
		{%/if%}
	{%/each%}
	<li class="last-item"><button id="B_addMembers" class="btn" memberType="0"><i class="fa fa-plus-circle"></i></button></li>
	</script>
	<!-- 关注人列表 模板 -->
	<script id="tmplAttentionItem" type="text/x-jquery-tmpl">
						{%each members%}
						{%if memberType == 2 %}
						<li class="member-item" data-user-name="${userName}" data-user-id="${userId}" data-memberType="${memberType}" data-manager="${manager}">
							<div class="member-title _text {%if manager%}is_manager{%/if%}">
								${userName}																										
							</div>
							<div style="clear:both;"></div>
							<i class="icon-dp-menu" ></i>
							<div class="Setmembers _act" style="display:none;">
								
								<button class="A_DeleteMember">
									<a>删除</a>
								</button>
							</div>
							<div style="clear:both;"></div>
						</li>
						{%/if%}
						{%/each%}
						<li class="last-item"><button id="B_addAttention" class="btn" memberType="2"><i class="fa fa-plus-circle"></i></button></li>
					</script>
	<!-- 标签列表 模板 -->
	<script id="tmplProjectTagItem" type="text/x-jquery-tmpl">
		{%each tags%}
		<li class="tag-wrap removeable"> 
			<span class="tag label"> 
				<span class="tag-name">${name}</span> 
			</span>  
			<a class="remove-tag-handler" tag-id="${id}">×</a>  
		</li>  
		{%/each%}
		<li class="navigation-view">
			<div class="nav-search"> 
				<input class="add-input" type="search" placeholder="添加标签">
				<button class="link-add-handler" id="sureToAddTag">添加</button>
				<a id="closeTags">×</a>
			</div>
			<button id="B_addtags" class="btn" ><i class="fa fa-plus-circle"></i></button>
		</li>	
	</script>
	<!-- 弹窗---新建项目 -->
	<div id="W_AddProject" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">新建项目</span><a href="javascript:void(0);" class="pull-right close-popup">×</a>
		</div>
		<div class="popup-co">
			<label for="">项目名称</label>
			<input type="text" placeholder="输入项目名称" maxlength="100"/>
			<p class="overstep">已达到最大限制字数100</p>
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_AddProject" class="btn btn-primary">创建</button>
			</div>
		</div>
	</div>
	<!-- 弹窗---编辑项目 -->
	<div id="W_EditProject" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">编辑项目</span><a href="javascript:void(0);" class="pull-right close-popup">×</a>
		</div>
		<div class="popup-co">
			<div class="popup-content">
				<div class="contentLeft">
					<div class="pBaseInfo selectDiv" _class="content-base">基本信息</div>
					<div class="pBaseAlarm" _class="content-alarm">消息提醒</div>
					<div class="pAddMember" _class="content-members">项目成员</div>
					<div class="pAddAttention" _class="content-attention">关注人员</div>
					<div class="pAddTag" _class="content-tag">标签</div>
				</div>
				<div class="contentRight" id="contentRight">
					<div class="content-base active" _class="pBaseInfo">
						<fieldset>
							<legend>基本信息</legend>
							<table>
								<tr>
									
									<td valign="top">
										<div style="margin:10px 0;">
											项目名称：
											<input type="hidden" id="_currname"/>
											<input type="text" name="name" placeholder="输入项目名称" />
											<input type="hidden" id="_selectMembers"/>
											<input type="hidden" id="_selectAttention"/>
											<input type="hidden" id="memerType" value=""/>
										</div>
										
									</td>
								</tr>
								
							</table>
						</fieldset>
					</div>
					<div class="content-alarm" _class="pBaseAlarm">
						<fieldset>
							<legend>消息提醒</legend>
						<table>
							<tr>
								<td valign="top">
									<div>
										<input id="setProjectMsg" type="checkbox" name="setProjectMsg" style="width:15px;height:15px" />
										<label for="" style="float:left;line-height:21px;">消息提醒</label>
									</div>
								</td>
							</tr>
							
						</table>
						
						</fieldset>
					</div>
					<div class="content-members" _class="pAddMember">
						<fieldset>
							<legend>项目成员</legend>
						<table>
							<tr>
								
								<td valign="top">
									<!-- 项目成员列表 -->
									<div>
										<ul class="cell-box-list-members clearfix cell-box-list-members-clearfix">						
										</ul>
									</div>
								</td>
							</tr>
						</table>
						</fieldset>
					</div>
					<div class="content-attention" _class="pAddAttention">
						<fieldset>
							<legend>关注人员</legend>
						<table>
							<tr>
								
								<td valign="top">
									<!-- 项目成员列表 -->
									<div>
										<ul class="cell-box-list-attention clearfix cell-box-list-attention-clearfix">						
										</ul>
									</div>
								</td>
							</tr>
							
						</table>
						
						</fieldset>
					</div>
					<div class="content-tag" _class="pAddTag" style="min-height:402px;">
						<fieldset>
							<legend>标签</legend>
						<table>
							<tr>
								
								<td valign="top">
									<!-- 标签列表 -->
									<div>
										<ul class="cell-box-list-project-tag clearfix cell-box-list-attention-clearfix">
																
										</ul>
									</div>
								</td>
							</tr>
							
						</table>
						</fieldset>
						<!-- <div class="btn-wrap">
							<button class="btn btn-cancel">取消</button>
							<button id="B_EditProject" class="btn btn-primary">保存</button>				
						</div> -->
					</div>
				</div>
				
			</div>
			
		</div>
	</div>
	<!-- 弹窗---删除项目 -->
	<div id="W_DeleteProject" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">删除项目</span><a href="javascript:void(0);" class="pull-right close-popup">×</a>
		</div>
		<div class="popup-co">
			<div class="warn-tip"><i class="icon-warn"></i>项目删除后不可恢复，您确定要删除项目？</div>
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_DeleteProjectAll" class="btn btn-warning">删除项目及内容</button>
			</div>
		</div>
	</div>
	<!-- 弹窗---关闭项目 -->
	<div id="W_CloseProject" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">关闭项目</span><a href="javascript:void(0);" class="pull-right close-popup">×</a>
		</div>
		<div class="popup-co">
			<div class="warn-tip"><i class="icon-warn"></i>您确定要关闭项目“<span id="ProjectName" style="word-break: break-all;"></span>”？</div>
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_CloseProjectAll" class="btn btn-warning">关闭项目</button>
			</div>
		</div>
	</div>
</div>