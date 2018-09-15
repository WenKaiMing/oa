<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>

	  
		<!-- end upload test  -->
    
	<div class="pm-page pm-page-task">
		<div class="pm-tool-bar" style="height: 53px;">
			<div id="header-datetime">
				<div class="pm-time" style="cursor:pointer;">  
					<input type="text" id="pm-task-tool-bar-search-current-date" size="10" readonly="readonly" style="border:1px solid #F2F2F2;font-size: inherit;color: #7E7E7E;background: #F2F2F2;cursor:pointer;" value="" />
				</div>
				<!-- 
				<div class="pm-time-btn" id="pm-time-btn">
					<div class="pm-time-pre-btn pm-time-btn-box" id="ng-pre-unit">
						<div class="pm-time-pre"></div>
					</div>
					<div class="pm-time-nxt-btn pm-time-btn-box" id="ng-next-unit">
						<div class="pm-time-nxt"></div>
					</div>
				</div>
				 -->
				<div class="pm-time-category">
					<div class="pm-time-category-item pm-time-today select" data-type="TODAY">日</div>
					<div class="pm-time-category-item pm-time-week" data-type="THISWEEK">周</div>
					<div class="pm-time-category-item pm-time-month" data-type="THISMONTH">月</div>
				</div>
			</div>
			
			
			
			<div class="pm-droplist pm-status"><span class="pm-droplist-icon" id="pm-task-status-text" data-status="-100">全部</span>
				<ul class="pm-droplist-option pm-status-option">
					<li class="pm-droplist-item pm-status-item" id="pm-status-all" data-type="-100">全部</li>
					<li class="pm-droplist-item pm-status-item" data-type="0">新建</li>
					<li class="pm-droplist-item pm-status-item" data-type="2">处理中</li>
					<li class="pm-droplist-item pm-status-item" data-type="3">已解决</li>
					<li class="pm-droplist-item pm-status-item" id="pm-status-complete" data-type="1">已完成</li>
					<li class="pm-droplist-item pm-status-item" data-type="-1">作废</li>
					
				</ul>
			</div>
			<div class="pm-droplist pm-show-style"><span class="pm-droplist-icon" id="pm-task-display-mode">列表</span>
				<ul class="pm-droplist-option pm-show-style-option">
					<li class="pm-droplist-item pm-task-display-mode-item" data-type="list">列表</li>
					<li class="pm-droplist-item pm-task-display-mode-item" data-type="calendar">日历</li>
				</ul>
			</div>
			<div class="pm-droplist pm-project"><span class="pm-droplist-icon" id="pm-task-project-text" data-status="-100">项目</span>
				<div class="pm-droplist-option pm-status-option">
					<ul>
						<li class="pm-droplist-item pm-pro-item" id="pm-pro-all" data-type="-100">全部</li>
						<li class="pm-droplist-item pm-pro-item" id="pm-pro-user" data-type="0">个人</li>
					</ul>
				</div>
			</div>
			<div class="clr"></div>
		</div>
		<!-- pm-tool-bar end -->
		<div class="pm-task-detail-outer"></div>
		<div class="pm-four-part pm-task-list">
			<div class="pm-four-part-item pm-proj-levela">
				<div class="pm-four-part-title pm-li">很重要-很紧急</div>
				<div class="pm-new-proj-btn pm-li"><a class="pm-new-proj">点击新建任务</a>
					<input type="text" class="pm-new-proj-ipt" placeholder="按Enter键完成输入" style="display: none" data-level="3" />
					<div class="pm-new-proj-div"></div>
				</div>
				<div class="pm-proj-list-wrap scroll-pane">
					<ul class="pm-proj-list" id="pm-proj-list3" data-level="3"></ul>
				</div>
			</div>
			<div class="pm-four-part-item pm-proj-levelb">
				<div class="pm-four-part-title pm-li">重要-不紧急</div>
				<div class="pm-new-proj-btn pm-li"><a class="pm-new-proj">点击新建任务</a>
					<input type="text" class="pm-new-proj-ipt" placeholder="按Enter键完成输入" style="display: none" data-level="2" />
					<div class="pm-new-proj-div"></div>
				</div>
				<div class="pm-proj-list-wrap scroll-pane">
					<ul class="pm-proj-list" id="pm-proj-list2" data-level="2"></ul>
				</div>
			</div>
			<div class="pm-four-part-item pm-proj-levelc">
				<div class="pm-four-part-title pm-li">不重要-紧急</div>
				<div class="pm-new-proj-btn pm-li"><a class="pm-new-proj">点击新建任务</a>
					<input type="text" class="pm-new-proj-ipt" placeholder="按Enter键完成输入" style="display: none" data-level="1" />
					<div class="pm-new-proj-div"></div>
				</div>
				<div class="pm-proj-list-wrap scroll-pane">
					<ul class="pm-proj-list" id="pm-proj-list1" data-level="1"></ul>
				</div>
			</div>
			<div class="pm-four-part-item pm-proj-leveld">
				<div class="pm-four-part-title pm-li">不重要-不紧急</div>
				<div class="pm-new-proj-btn pm-li"><a class="pm-new-proj">点击新建任务</a>
					<input type="text" class="pm-new-proj-ipt" placeholder="按Enter键完成输入" style="display: none" data-level="0" />
					<div class="pm-new-proj-div"></div>
				</div>
				<div class="pm-proj-list-wrap scroll-pane">
					<ul class="pm-proj-list" id="pm-proj-list0" data-level="0"></ul>
				</div>
			</div>
		</div>
		<!-- pm-four-part end-->
		<!-- 日历视图 -->
		<div class="pm-task-calendar-view pm-task-list" id="pm-task-calendar-view" style="display:none;min-width: 600px;margin: 5px auto;padding: 0 5px;font-size: 14px;"></div>
		<!-- 添加项-->
		<script id="tmplFourPartLi" type="text/x-jquery-tmpl">
					<li class="pm-proj-item pm-li" data-id="${id}">
						<div class="pm-checkbox"></div>
						<div class="pm-proj-name">${name}</div>
						<div class="pm-proj-time"><span class="pm-proj-time">${startDate}</span>
						</div>
					</li>
					</script>
		<!-- 未完成和完成项-->
		<script id="tmplFourPartLi2" type="text/x-jquery-tmpl">
					{%if status!=1 && status!=-1%}
					<li class="pm-proj-item pm-li incomplete" data-id="${id}" data-level="${level}" data-proid="${projectId}">
						<div class="pm-checkbox"></div>
						<div class="pm-proj-nt"><div class="pm-proj-name">${name}</div>
						<div class="pm-proj-time"><span class="pm-proj-date">${endDate}</span>
						</div></div>
					</li>
					{%else%}
					<li class="pm-proj-item pm-li complete" data-id="${id}" data-proid="${projectId}">
						<div class="pm-checkbox pm-checkbox-select"></div>
						<div class="pm-proj-nt"><div class="pm-proj-name pm-proj-over">${name}</div>
						<div class="pm-proj-time"><span class="pm-proj-date">${endDate}</span>
						</div></div>
					</li>
					{%/if%}
					</script>
		<!-- pm-time-mode end -->
		<script id="tmplTaskDetail" type="text/x-jquery-tmpl">
		<div class="pm-task-detail-box detail-scroll-pane" style="display:none;">
			<!--初始化的时候设定高度，添加自定义滚动条 -->
			<div class="pm-task-detail">
				<div class="pm-task-close">
					<div id="pm-task-status-selector" style="text-align: center;">
						<div class="dx-task-close-btn" style="position: absolute;left: 0px;">
							<i class="fa fa-chevron-right" ></i>
						</div>
						<a class="task-detail-stage">
							<span>{%if status ==0%}新建{%/if%}{%if status ==2%}处理中{%/if%}{%if status ==1%}已完成{%/if%}{%if status ==3%}已解决{%/if%}{%if status ==-1%}作废{%/if%}</span>
							<i class="fa fa-chevron-down"></i>
						</a>
						<div class="pm-task-status-list">
							<ul>
								<li><a class="pm-task-status-item {%if status ==0%} select{%/if%}" _value="0">新建 <i class="fa fa-check"></i></a></li>
								<li><a class="pm-task-status-item {%if status ==2%} select{%/if%}" _value="2">处理中 <i class="fa fa-check"></i></a></li>
								<li><a class="pm-task-status-item {%if status ==3%} select{%/if%}" _value="3">已解决 <i class="fa fa-check"></i></a></li>		
								<li><a class="pm-task-status-item {%if status ==1%} select{%/if%}" _value="1">已完成 <i class="fa fa-check"></i></a></li>
								<li><a class="pm-task-status-item {%if status ==-1%} select{%/if%}" _value="-1">作废 <i class="fa fa-check"></i></a></li>
							</ul>
						</div>
					</div>
					<div class="pm-tas-title-menu">
						{%if PM.cache.openType == 0%}
						<a class="pm-act-item pm-create-task-cancel">
							<div class="pm-menu-fa-box-create cancel">取消</div>
						</a>
						<a class="pm-act-item pm-create-task">
							<div class="pm-menu-fa-box-create save">保存</div>
						</a>
						{%else%}
						<a class="pm-act-item pm-delete-task" data-target="#W_deleteTask">
							<div class="pm-menu-fa-box"><i class="fa fa-trash"></i></div>
						</a>
						{%/if%}
					</div>
				</div>

				<div class="pm-task-basic">
					<ul class="pm-task-basic-list">
						<li class="pm-task-basic-item pm-name" id="pm-task-name" data-id="${id}" data-name="${name}">
							<div class="pm-task-name-box">
								<div class="pm-task-name {%if status ==1%} pm-task-finished{%/if%}" {%if PM.cache.memberIdentity !=2%}contenteditable="true"{%/if%} placeholder="一句话描述你的任务">${name}</div>
								</div>
						</li>
					</ul>
				</div>

				<div class="pm-task-detail-scroll">
				<div class="pm-task-basic">
					<ul class="pm-task-basic-list">
						<li class="pm-task-detail-handler-wrap">
							<div class="task-detail-handler-set">

								<div id="pm-task-executor" class="task-detail-handler on-flex pm-task-basic-item"> 
									<h6 class="task-info-title">执行者</h6>   
									<a id="pm-task-executor-btn" class="task-detail-executor pm-task-modify-btn"> 
									<!--<div class="task-detail-handler-icon avatar img-24 img-circle" style="background-image: url(https://striker.teambition.com/thumbnail/42/37/a0ce4b4bfdeea76dfb37280b827d.jpg/w/200/h/200)"></div>-->
									<span>${executor}</span>
									
									</a>   
									<div class="pm-task-select-executor" style="display:none">
										<div class="pm-task-sousuo">
											<a class="executor-search-btn"><img alt="search" src="images/search-pro.png"></a>
											<div class="executor-search-input on-search-active"> 
												<input name="search-task-executor" class="nav-search-input" type="text" placeholder="请输入姓名关键字"> 
											</div>
										</div>
										<ul></ul>
										<p class="zhanwei" style="display:none;">请先设置项目</p>
									</div>
								</div> 

								<div class="task-detail-handler on-flex pm-task-modify-item pm-task-modify-time-item"> 
									<h6 class="task-info-title">开始日期</h6> 
									<div class="task-detail-handler-body task-detail-due-date dirty pm-edit-time-set">   
										<a class="task-datepicker pm-modify-time pm-modify-time-start"> 
											<i class="fa fa-calendar"></i>
											<span><input type="text" readonly="readonly" class="pm-task-time pm-task-date-input start-date" value="${startDate}" data-type="startDate" />
											<span class="clear" style="display:none"></span></span> 
										</a>   
									</div> 
								</div> 

								<div class="task-detail-handler on-flex pm-task-modify-item pm-task-modify-time-item"> 
									<h6 class="task-info-title">截止日期</h6> 
									<div class="task-detail-handler-body task-detail-due-date dirty pm-edit-time-set">   
										<a class="task-datepicker pm-modify-time pm-modify-time-end"> 
											<i class="fa fa-calendar"></i>
											<span><input type="text" readonly="readonly" class="pm-task-time pm-task-date-input end-date" value="${endDate}" data-type="endDate" />
											<span class="clear" style="display:none"></span></span> 
										</a>   
									</div> 
								</div> 

								<div class="task-detail-handler repeat-menu-wrap pm-task-basic-item"> 
									<h6 class="task-info-title">优先级</h6>  
									<a id="pm-task-level-btn" class="task-detail-priority dirty"> 
									{%if level==3%}<i class="fa fa-circle-o level3"></i><span class="priority-title">很重要-很紧急</span> {%/if%}
									{%if level==2%}<i class="fa fa-circle-o level2"></i><span class="priority-title">很重要-不紧急</span> {%/if%}
									{%if level==1%}<i class="fa fa-circle-o level1"></i><span class="priority-title">不重要-很紧急</span> {%/if%}
									{%if level==0%}<i class="fa fa-circle-o level0"></i><span class="priority-title">不重要-不紧急</span> {%/if%} 
									<div class="pm-task-select-box pm-task-level-box" style="display:none"></div>
									</a>  
								</div> 

								<!--<div id="pm-task-remind" class="task-detail-handler repeat-menu-wrap pm-task-basic-item"> 
									<h6 class="task-info-title">重复</h6>  
									<a id="pm-task-remind-btn"  class="task-detail-repeat dirty"> 
										<i class="fa fa-history"></i>
										<span class="repeat-title pm-task-modify-btn">${$item.getRemindText()}</span>
										<div class="pm-task-select-box pm-task-remind-box" style="display:none"></div>
									</a>  
								</div>-->
							</div>
						</li>

{%if PM.cache.openType == 0%}
<div class="createMore">
	<div><i class="fa fa-ellipsis-h" aria-hidden="true"></i>更多</div>
	<div class="line"></div>
</div>
{%/if%}
<div class="task-detail-infos-wrap" style="{%if PM.cache.openType == 0%}display:none;{%/if%}">
	<div class="detail-infos-view">
		<div class="pm-task-remark on-top">
			<i class="fa fa-file-text-o"></i>
			<a class="pm-task-remark-title">添加备注</a>
			<ul class="pm-task-remark-list">
				{%each(i, media) remarks%}
				<li class="pm-task-remark-item pm-name">
					<div class="pm-task-remark-box">
						<div class="pm-task-remark-content-box">
							<div class="pm-task-remark-content">${media.content}</div>
							<div class="pm-modify-btn">
								<ul class="pm-act-list">
									<li class="pm-act-item pm-edit-remark-task" data-id="${media.id}">编辑</li>
									<li class="pm-act-item pm-delet-remark-task" data-id="${media.id}">删除</li>
								</ul>
							</div>
							<div class="clr"></div>
						</div>
						<div class="pm-task-remark-time-box">
							<span class="pm-task-remark-data">${media.createRemarkUser}:   ${media.createDate}</span><span class="pm-task-remark-time"></span>
						</div>
					</div>
				</li>
				{%/each%}
			</ul>
	
			<div class="pm-task-remark-item pm-task-new-remark">
				<div class="pm-task-remark-box">
					<div class="pm-new-task-remark-btn">点击添加备注</div>
				</div>
			</div>
		</div>
		
		<!-- pm-task-remark end -->

		{%if PM.cache.openType == 1%}
		<div class="pm-task-son">
			<i class="fa fa-square-o"></i>
			<a class="pm-task-son-title">子任务</a>
			<ul class="pm-task-son-list">
			{%each(i, media) subTask %}
				<li class="pm-task-son-item pm-name">
					<div class="pm-task-son-box">
						<div class="pm-task-son-selector {%if media.status==1%}pm-task-son-hasselect{%/if%}" data-id="${media.id}"></div>
						<div class="pm-task-son-name">${media.name}</div>
						<div class="pm-modify-btn">
							<ul class="pm-act-list">
								<li class="pm-act-item pm-edit-son-task" data-id="${media.id}">编辑</li>
								<li class="pm-act-item pm-delet-son-task" data-id="${media.id}"  data-target="#W_deletesubTask">删除</li>
							</ul>
						</div>
						<div class="clearfix"></div>
					</div>
				</li>
			{%/each%}
			</ul>
			<div class="pm-task-son-item pm-new-task-son">
				<div class="pm-task-son-box">
					<div class="pm-new-task-son-btn">点击添加子任务</div>
				</div>
			</div>
		</div>
		{%/if%}
		<!-- pm-task-son end -->


		<div id="pm-task-proj-set" class="detail-infos-link-view">
			<div class="link-add-wrap child-tree pm-task-modify-item">
				<i class="fa fa-folder-o"></i>
				<a id="pm-task-proj-set-btn" class="add-link-handler" {%if projectId %} style="display:none;" {%/if%}> 设置项目 </a>
				<div class="pm-task-select-box pm-proj-item-select" style="display:none"></div>
				{%if projectId %}
				<div class="pm-new-proj-tag">
					<div class="pm-proj-tag">${projectName}</div>
					<div class="pm-close-proj-tag" data-project-id="${projectId}"></div>
				</div>
				{%/if%}
			</div>
		</div>


		<div id="pm-task-tag" class="detail-infos-link-view">
			<div id="pm-task-tag-set-btn" class="link-add-wrap child-tree pm-task-modify-item">
				<i class="fa fa-tags"></i>
				{%each(i,tag) tags%}
				<div class="pm-new-tag-tag removeable" data-tag-name="${tag.name}">
					<div class="pm-new-tag">${tag.name}</div>
					<div class="pm-close-tag-tag" data-tag-name="${tag.name}">×</div>
				</div>
				{%/each%}
				
				<div class="tagTips" {%if tags.length == 0 %}style="display:block"{%/if%}>添加标签</div>
				
				<a class="add-link-handler pm-task-modify-btn pm-task-set-btn pm-task-tag-set-btn"><i class="fa fa-plus-circle"></i></a>
				<div class="pm-task-select-box pm-tag-item-select" id="pm-tag-item-select" style="display:none"></div>
				
			</div>
		</div>

		<div class="detail-infos-tag-view">
			<div class="tag-add-wrap" _value> 
				<i class="fa fa-paperclip" style="line-height:30px;"></i>
				<a class="add-tag-handler clearfix">
					<span {%if PM.cache.memberIdentity !=2%}id="pasteImg"{%/if%} class="pasteImg">粘贴截图</span>
					{%if PM.cache.memberIdentity ==2%}<span class="pasteImg">添加附件</span>{%/if%}
					{%if PM.cache.memberIdentity !=2%}<input type="file" name="file_upload" id="file_upload" multiple="true"  style="float:left;"/>{%/if%}
				</a>
				<div style="clear:both"></div>
				<div id="attach_block" data-view="viewer"></div>
				<div style="clear:both"></div>
				<div id="attach_block_other"></div>
				
				<!--<a class="task_btn_cancel" href="javascript:$('#file_upload').uploadify('cancel','*')">取消</a>
				<a class="task_btn_upload" href="javascript:$('#file_upload').uploadify('upload','*')">开始上传</a>-->
				<div style="clear:both"></div>
			</div>


		</div>
		<div class="pm-task-followers  on-bottom">
						<!--
						<div class="pm-task-followers-title"><i class="fa fa-users"></i> 关注者
							<span class="pm-task-modify-btn pm-task-set-btn" id="pm-task-add-follower-btn">
								<button class="button_right">添加关注人</button>
							</span>
						</div>
						<div class="pm-task-select-follower" style="display:none;">
							
							<ul></ul>
							<p class="zhanwei" style="display:none;">请先设置项目关注人</p>
						</div>
						<div calss="followers-wrapper">
							<ul class="followers-list" id="followers-list">
								<li class="" >
										<div class="pm-task-modify-item clearfix" style="height:auto">
											{%each(i,follower) followers%}
											<div class="pm-task-follower-tag" data-follow-id="${follower.userId}">
												<div class="pm-task-follower">${follower.userName}</div>
												<div class="pm-close-follower-tag" data-follower-id="${follower.userId}" data-follower-name="${follower.userName}">
													×	
												</div>
											</div>
											{%/each%}

										</div>
								</li>
							</ul>
						</div>-->
						<div class="pm-task-followers-title   link-add-wrap">
							<i class="fa fa-star-o"></i> 
							{%each(i,follower) followers%}
								<div class="pm-task-follower-tag removeable" data-follow-id="${follower.userId}">
									<div class="pm-task-follower">${follower.userName}</div>
									<div class="pm-close-follower-tag" data-follower-id="${follower.userId}" data-follower-name="${follower.userName}">
										×
									</div>
								</div>
							{%/each%}
							<div class="followerTips" {%if followers.length == 0 %}style="display:block"{%/if%}>添加关注人</div>
							<a class="add-link-handler pm-task-set-btn" id="pm-task-add-follower-btn"><i class="fa fa-plus-circle"></i></a>
						</div>
						<div class="pm-task-select-follower" style="display:none;">
							
							<ul></ul>
							<p class="zhanwei" style="display:none;">请先设置项目关注人</p>
						</div>
					</div>
	</div>
</div>








					</ul>
				</div>
				
				
				<!-- pm-task-basic end -->
				{%if PM.cache.openType == 1%}	
				<div class="pm-task-other">
					
					
					
					<!-- pm-task-logs end -->
					
					<div class="pm-task-logs">
						<div class="pm-task-logs-title"><i class="fa fa-list"></i> 动态<i class="fa fa-chevron-down down-up"></i></div>
						<div class="logs-wrapper" style="display:none;">
							<ul class="logs-list">
								{%each(i, log) logs%}
								<li class="logs-item" data-id="${log.id}">
									<div style="overflow:hidden;">
									<span class="icon {%if log.operationType==100%}icon-create-task{%/if%} log-type-icon pull-left muted"></span>
									<time class="time-stamp muted pull-right" datetime="${log.operationDate}">${log.operationDate}</time>
									</div>	
									<div class="logs-body-coyness readable muted">
										<span class="actor">${log.userName}</span>
										<span class="logTxt">${log.logTxt}</span>
										{%if log.operationType==200%}
										<ul class="subtask-list">
											<li>${log.summary}</li>
										</ul>
										{%/if%}
									</div>
								</li>
							{%/each%}
							</ul>
						</div>
					<div>
					
					<!-- pm-task-logs end -->					


				</div>
				{%/if%}
				<!-- pm-task-other end -->
				</div>
			</div>
			<!-- pm-task-detail end -->

		</div>
		<div style="height:15px"></div>
		
		<!-- pm-task-detail-box end -->
	</script>
		<!-- 任务详情   任务名称框 -->
		<script id="tmplTaskNameBox" type="text/x-jquery-tmpl">
		<div class="pm-task-name-box">
			<div class="pm-task-done-selector"></div>
			<div class="pm-task-name">${name}</div>
			<div class="clr"></div>
		</div>
	</script>
		<!-- 任务详情   任务名称  编辑框 -->
		<script id="tmplTaskNameEdit" type="text/x-jquery-tmpl">
		<div class="pm-task-edit-box">
			<textarea class="pm-task-edit-ipt" id="pm-task-edit-name-ipt">${name}</textarea>
			<div class="pm-task-edit-btn-box">
				<div class="pm-task-edit-btn pm-task-edit-ok pm-task-ok" id="pm-task-edit-name-ok">保存</div>
				<div class="pm-task-edit-btn pm-task-edit-cancle pm-task-cancle" id="pm-task-edit-name-cancle">取消</div>
			</div>
		</div>
	</script>
	<!-- 优先级列表  -->
		<script id="tmplTaskLevelSelectPanel" type="text/x-jquery-tmpl">
		<div class="pm-item-select-content">
			<div class="pm-item-select-content-arrow"></div>
			<div id="pm-task-level" class="pm-task-basic-item pm-item-level-box">
				<ul class="pm-item-select-list">
					<li class="pm-item-select-item pm-modify-task-level" id="levela" data-level="3"><i class="fa fa-circle-o level3"></i> 很重要-很紧急</li>
					<li class="pm-item-select-item pm-modify-task-level" id="levelb" data-level="2"><i class="fa fa-circle-o level2"></i> 很重要-不紧急</li>
					<li class="pm-item-select-item pm-modify-task-level" id="levelc" data-level="1"><i class="fa fa-circle-o level1"></i> 不重要-很紧急</li>
					<li class="pm-item-select-item pm-modify-task-level" id="leveld" data-level="0"><i class="fa fa-circle-o level0"></i> 不重要-不紧急</li>
				</ul>
			</div>
		</div>




	</script>
		<!-- 任务详情   提醒模式列表  -->
		<script id="tmplTaskRemindSelectPanel" type="text/x-jquery-tmpl">
		<div class="pm-item-select-content">
			<div class="pm-item-select-content-arrow"></div>
			<div class="pm-item-remind-box">
				<ul class="pm-item-select-list">
					<li class="pm-item-select-item pm-item-remind-item" data-value="0">不提醒</li>
					<li class="pm-item-select-item pm-item-remind-item" data-value="1">每天提醒</li>
					<li class="pm-item-select-item pm-item-remind-item" data-value="2">每周提醒</li>
					<li class="pm-item-select-item pm-item-remind-item" data-value="3">每两周提醒</li>
					<li class="pm-item-select-item pm-item-remind-item" data-value="4">每月提醒</li>
				</ul>
			</div>
		</div>
	</script>
		<!--新建子任务  编辑子任务 表单-->
		<script id="tmplAddSubTask" type="text/x-jquery-tmpl">
		<div class="pm-task-edit-box">
			<textarea class="pm-task-edit-ipt pm-task-son-edit-ipt" {%if id%}data-id=${id}{%/if%}>{%if name%}${name}{%/if%}</textarea>
			
		</div>
	</script>
					<!-- 子任务列表item-->
	<script id="tmplSubTaskItem" type="text/x-jquery-tmpl">
		<li class="pm-task-son-item pm-name">
			<div class="pm-task-son-box">
				<div class="pm-task-son-selector" data-id="${id}"></div>
				<div class="pm-task-son-name">${name}</div>
				<div class="pm-modify-btn">
					<ul class="pm-act-list">
						<li class="pm-act-item pm-edit-son-task" data-id="${id}">编辑</li>
						<li class="pm-act-item pm-delet-son-task" data-id="${id}" data-target="#W_deletesubTask">删除</li>
					</ul>
				</div>
				<div class="clr"></div>
			</div>
		</li>
	</script>
					<!--新建备注  边界备注表单-->
					<script id="tmplAddRemark" type="text/x-jquery-tmpl">
		<div class="pm-task-edit-box">
			<textarea class="pm-task-edit-ipt pm-task-remark-edit-ipt" {%if id%}data-id=${id}{%/if%}>{%if content%}${content}{%/if%}</textarea>
		</div>
	</script>
		<!--备注列表项 模板-->
		<script id="tmplRemarkListItem" type="text/x-jquery-tmpl">
		<li class="pm-task-remark-item pm-name">
			<div class="pm-task-remark-box">
				<div class="pm-task-remark-content-box">
					<div class="pm-task-remark-content">${content}</div>
					<div class="pm-modify-btn">
						<ul class="pm-act-list">
							<li class="pm-act-item pm-edit-remark-task" data-id="${id}">编辑</li>
							<li class="pm-act-item pm-delet-remark-task" data-id="${id}">删除</li>
						</ul>
					</div>
					<div class="clr"></div>
				</div>
				<div class="pm-task-remark-time-box">${createRemarkUser}:   <span class="pm-task-remark-data">${createDate}</span><span class="pm-task-remark-time">${time}</span>
				</div>
			</div>
		</li>
	</script>
	<!--标签选择面板 -->
	<script id="tmplTagSelectPanel" type="text/x-jquery-tmpl">
		<div class="popover-content thin-scroll">
			<!--<div class="menu-input add-form">
				<input class="add-input form-control" placeholder="添加标签">
				<button class="btn btn-link pm-task-new-tag">添加</button>
			</div>-->
			<ul class="list-unstyled thin-scroll with-input" id="pm-task-select-tag-list">
				{%each(i,tag) tags%}
				<li class="menu-item tag-item " data-id="${tag.id}" data-name="${tag.name}" title="${tag.name}">
					<a> <span class="tag-label tag-label-gray"></span>  <span class="tag-name">${tag.name}</span> 
					</a>
				</li>
				{%/each%}
			</ul>
		</div>
	</script>
	
	<!--标签选择面板的标签项-->
	<script id="tmplTagSelectItem" type="text/x-jquery-tmpl">
	<li class="menu-item tag-item " data-id="${id}" data-name="${name}">
		<a> <span class="tag-label tag-label-gray"></span>  <span class="tag-name">${name}</span> 
		</a>
	</li>
	</script>
	<!--任务标签项-->
	<script id="tmplTaskTagItem" type="text/x-jquery-tmpl">
	<div class="pm-new-tag-tag removeable" data-tag-name="${name}">
		<div class="pm-new-tag">${name}</div>
		<div class="pm-close-tag-tag" data-tag-name="${name}">×</div>
	</div>
	</script>
	<!--所属项目选择面板 -->
	<script id="tmplProjectSelectPanel" type="text/x-jquery-tmpl">
		<div class="popover-content thin-scroll">
			<ul class="list-unstyled thin-scroll with-input" id="pm-task-select-project-list">
				{%each(i,project) projects%}
				<li class="menu-item project-item " data-id="${project.id}" data-name="${project.name}" title="${project.name}">
					
					<a> <span class="tag-label tag-label-gray"></span> 
						<span class="project-name">${project.name}</span> 
					</a>
				</li>
				{%/each%}
			</ul>
		</div>
	</script>
	<!--任务所属项目-->
	<script id="tmplTaskProjectItem" type="text/x-jquery-tmpl">
	<div class="pm-new-proj-tag">
		<div class="pm-proj-tag">${projectName}</div>
		<div class="pm-close-proj-tag" data-project-id="${projectId}"></div>
	</div>
	</script>
	<!--任务关注者-->
	<script id="tmplTaskFollowerItem" type="text/x-jquery-tmpl">
	<div class="pm-task-follower-tag removeable" data-follow-id="${userId}">
	<div class="pm-task-follower">${userName}</div>
	<div class="pm-close-follower-tag" data-follower-id="${userId}" data-follower-name="${userName}">x</div>
	</div>
	</script>
	<!-- 弹窗---新建任务（日历视图） -->
	<div id="W_AddTask" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">新建任务</span><a href="javascript:void(0);" class="pull-right close-popup">X</a>
		</div>
		<div class="popup-co">
			<label for="">任务名称</label>
			<input type="text" placeholder="输入任务名称" />
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_AddTask" class="btn btn-primary">创建</button>
			</div>
		</div>
	</div>
	</div>
	<!-- 弹窗---删除任务（任务面板） -->
	<div id="W_deleteTask" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">删除任务</span><a href="javascript:void(0);" class="pull-right close-popup">X</a></div>
		<div class="popup-co">
			<div style="margin:20px auto;text-align:center;font-size: 16px;">确定删除此任务吗？</div>
			
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_deleteTask" class="btn btn-danger">删除</button>
			</div>
		</div>
	</div>
	<!-- 弹窗---删除子任务 -->
	<div id="W_deletesubTask" class="popup">
		<div class="popup-title clearfix"><span class="pull-left">删除任务</span><a href="javascript:void(0);" class="pull-right close-popup">X</a></div>
		<div class="popup-co">
			<div style="margin:20px auto;text-align:center;font-size: 16px;">确定删除此子任务吗？</div>
			<div class="subItem" style="display:none;"></div>
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_deletesubTask" class="btn btn-danger">删除</button>
			</div>
		</div>
	</div>