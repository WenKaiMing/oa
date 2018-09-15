<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="pm-page pm-page-taskTable">
	<div class="cell-content-part project-setting-project">
		<div class="title pro-task">
			<h3></h3>
			<div class="task-pro">
				<button type="button" class="pro-name btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span></span>
				<i class="fa fa-chevron-down"></i>
				</button>
				
				<div class="dropdown-menu project-list">
					<ul></ul>
				</div>
			</div>
			<a class="cell-btn-blue newTaskInPro" href="javascript:void(0);" data-target="#W_ProAddTask">
						<span>+新建任务</span>
					</a> 
			<div class="search-input on-search-active"> 
				<input name="search-task-projectName" class="nav-search-input" type="text" placeholder="请输入关键字，按回车键搜索"> 
			</div>			
		</div>
		<!-- 高级搜索开始 -->
		<div class="search-advance">
			<div class="skin-dwz" style="display:none;">
				<div class="search-advance-li">
					<label>优先级</label>
					<select name="search-task-level" multiple="multiple" size="1">
						<option value=""></option>
						<option value="3">很重要-很紧急</option>
						<option value="2">很重要-不紧急</option>
						<option value="1">不重要-很紧急</option>
						<option value="0">不重要-不紧急</option>
					</select>
				</div>
				<div class="search-advance-li">
					<label>创建人</label>
					<select name="search-task-creater" multiple="multiple" size="1">
					</select>
				</div>
				<div class="search-advance-li">
					<label>执行人</label>
					<select name="search-task-executor" multiple="multiple" size="1">
					</select>
				</div>
				<div class="search-advance-li">
					<label>日期范围</label>
					<select name="search-task-endDate">
						<option value=""></option>
						<option value="LastMonth">上月</option>
						<option value="LastWeek">上周</option>
						<option value="LastDay">昨天</option>
						<option value="Today">今天</option>
						<option value="NextDay">明天</option>
						<option value="ThisWeek">本周</option>
						<option value="NextWeek">下周</option>
						<option value="ThisMonth">本月</option>
						<option value="NextMonth">下月</option>
					</select>
				</div>
				<div class="search-advance-li">
					<label>标签</label>
					<select name="search-task-tags"  multiple="multiple" size="1"></select>
				</div>
				<div class="search-advance-li">
					<label>状态</label>
					<select name="search-task-status" multiple="multiple" size="1">
						<option value="-100"></option>
						<option value="0">新建</option>
						<option value="2">处理中</option>
						<option value="3">已解决</option>
						<option value="1">已完成</option>
						<option value="-1">作废</option>
					</select>
				</div>
				<div class="search-advance-li">
					<label>过期</label>
					<select name="search-task-overdue">
						<option value=""></option>
						<option value="OVERDUE">过期</option>
					</select>
				</div>
				<button class="search-submit" style="display:none;">查询</button>
				<button class="search-reset" style="display:none;">重置</button>
			</div>
			<div class="skin-h5">
				<div class="btn-group search-dropdown-level" _name="level">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					优先级 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li>
							<a _value="3">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title"><i class="fa fa-circle-o level3"></i> 很重要-很紧急</div>
							</a>
						</li>
						<li>
							<a _value="2">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title"><i class="fa fa-circle-o level2"></i> 很重要-不紧急</div>
							</a>
						</li>
						<li>
							<a _value="1">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title"><i class="fa fa-circle-o level1"></i> 不重要-很紧急</div>
							</a>
						</li>
						<li>
							<a _value="0">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title"><i class="fa fa-circle-o level0"></i> 不重要-不紧急</div>
							</a>
						</li>
					</ul>
				</div>
				<div class="btn-group search-dropdown-creater" _name="creater">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					创建人 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" style="width:500px;">
					</ul>
				</div>
				<div class="btn-group search-dropdown-executor" _name="executor">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					执行人 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" style="width:500px;">
					</ul>
				</div>
				<div class="btn-group search-dropdown-endDate" _name="endDate">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					日期范围 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu endDate">					
						<li><a _value="">&nbsp;</a></li>
						<li><a _value="LastMonth">上月</a></li>
						<li><a _value="LastWeek">上周</a></li>
						<li><a _value="LastDay">昨天</a></li>
						<li><a _value="Today">今天</a></li>
						<li><a _value="NextDay">明天</a></li>
						<li><a _value="ThisWeek">本周</a></li>
						<li><a _value="NextWeek">下周</a></li>
						<li><a _value="ThisMonth">本月</a></li>
						<li><a _value="NextMonth">下月</a></li>
					</ul>
				</div>
				<div class="btn-group search-dropdown-tags" _name="tags">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					标签 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" style="width:500px;">
					</ul>
				</div>
				<div class="btn-group search-dropdown-status" _name="status">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					状态 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li>
							<a _value="0">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title">新建</div>
							</a>
						</li>
						<li>
							<a _value="2">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title">处理中</div>
							</a>
						</li>
						<li>
							<a _value="3">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title">已解决</div>
							</a>
						</li>
						<li>
							<a _value="1">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title">已完成</div>
							</a>
						</li>
						<li>
							<a _value="-1">
								<div class="checkbox_new">
					                <i class="iconfont-h5 checkbox_i">&#xe055;</i>
					            </div>
								<div class="checkbox_title">作废</div>
							</a>
						</li>
					</ul>
				</div>
				<div class="btn-group search-dropdown-submit">
					<button class="btn btn-default">查询</button>
				</div>
				<div class="btn-group search-dropdown-reset">
					<button class="btn btn-default">重置</button>
				</div>
				<div class="btn-group search-dropdown-export pull-right">
					<button class="btn btn-default">导出</button>
			    </div>
				<div class="btn-group search-dropdown-import pull-right">
					<button class="btn btn-default importTaskPro" data-target="#W_ProImportTask">导入</button>
			    </div>
				<div class="btn-group search-boot-switch">
					<span class="overdue">过期</span>
					<div style="width:75px;cursor: pointer;">
				    	<label>
							<input type="checkbox" class="ios-switch green" /><div>
				                <div>
				                </div>
				            </div>
				        </label>
			        </div>
			    </div>
			</div>
		</div>
		<!-- 高级搜索结束 -->
		<div class="pm-task-detail-outer"></div>
		<div class="head-table">
			<table class="pm-task-table" id="pm-follow-task-head-table" style="table-layout: fixed;">
				  <colgroup>
				    <col style="width:94px;"></col>
				    <col></col>
				    <col style="width:160px;"></col>
				    <col style="width:130px;"></col>
				    <col style="width:130px;"></col>
				  </colgroup>
					<tr class="head">
					    <td _orderName="STATUSORDER" class="pm-list-order" width="64px"><span>状态</span></td>
						<td _orderName="NAME" class="pm-list-order"><span>任务名称</span></td>
						<td _orderName="LEVELS" class="pm-list-order" width="130px"><span>优先级</span></td>
						<!-- <td >执行人</td>
						<td >开始日期</td>
						<td >完成日期</td> -->
						<td _orderName="TAGS" class="pm-list-order" width="100px" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;"><span>标签</span></td>
						<td width="100px">进度</td>
						<!-- <td>项目成员</td>
						<td >操作</td> -->
					</tr>
				</table>
		</div>
		<div class="content">
			<div class="pm-task-list-all">
				<table class="pm-task-table" id="pm-follow-task-table" style="table-layout: fixed;">
					<colgroup>
					    <col style="width:94px;"></col>
					    <col></col>
					    <col style="width:160px;"></col>
					    <col style="width:130px;"></col>
					    <col style="width:130px;"></col>
					</colgroup>
					<tbody class="tbody" id="pm-task-table-body2"></tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 弹窗---是否取消新建任务-->
	<div id="W_ProAddTask" class="popup">
		<div class="popup-title clearfix"><span>新建任务</span><a href="javascript:void(0);" class="pull-right close-popup">×</a>
		</div>
		<div class="popup-co">
			<div class="popup-body">任务未保存，是否保存？</div>
			<div class="btn-wrap">
				<button id="B_ProAddTask_delete" class="btn btn-default">放弃</button>
				<button id="B_ProAddTask_save" class="btn btn-primary">保存</button>
			</div>
		</div>
	</div>
	<!-- 弹窗---任务导入-->
	<div id="W_ProImportTask" class="popup">
		<div class="popup-title clearfix" style="position: fixed;width: 430px;z-index: 2;"><span class="pull-left">任务导入</span><a href="javascript:void(0);" class="pull-right close-popup">X</a>
		</div>
		<div class="popup-title clearfix"><span class="pull-left">任务导入</span><a href="javascript:void(0);" class="pull-right close-popup">X</a>
		</div>
		<div class="popup-co">
			<table>
				<tr>
				    <td width="128px" align="right">任务导入模板：</td>
					<td><a href="<s:url value='/pm/resource/template.xls'/>" class="btn btn-primary btn-download">点击下载</a></td>
				</tr>
				<tr>
				    <td width="128px" align="right"><span style="color: red;">*</span>上传任务文件：</td>
				    <td >
				    	<input type="hidden" value class="excel-path" />
				    	<div id="uploader-demo">
						    <div id="filePicker">选择文件</div>
						</div>
				    	<div class="pull-left import-info"></div>
					</td>
				</tr>
			</table>
			<div class="btn-wrap">
				<button class="btn btn-cancel">取消</button>
				<button id="B_ProImportTask" class="btn btn-primary">导入</button>
			</div>
			<div class="import-error-info"></div>
		</div>
	</div>
</div>

<script id="tmplTaskTableListItem2" type="text/x-jquery-tmpl">
		<tr class="row" data-id="${id}">
			<td class="project-status"><span class="label 
				{%if status == 0%}label-status0{%/if%}
				{%if status == 1%}label-status1{%/if%}
				{%if status == 2%}label-status2{%/if%}
				{%if status == 3%}label-status3{%/if%}
				{%if status == -1%}label-status-1{%/if%}">
				{%if status == 0%}新建{%/if%}
				{%if status == 1%}已完成{%/if%}
				{%if status == 2%}处理中{%/if%}
				{%if status == 3%}已解决{%/if%}
				{%if status == -1%}作废{%/if%}</span></td>
			<td class="project-title">
				<div class="project_task_name" style="line-height: 34px;" title="${name}"><a>${name}</a></div>
				<div style="line-height: 20px;margin-bottom: 10px;"><span class="executor">负责人&nbsp;${executor}</span> <span class="startDate">${startDate}</span><span>——</span><span class="endDate">${endDate}</span></div>
				{%if $item.ifOverdue() ==true%}<div class="projecr_task_guoqi"><img src="./images/guoqi.png"/></div>{%/if%}
			</td>
			<td class="project-level">{{html $item.getLevelText()}}</td>
			<!--<td >${name}</td>
			<td >{{html $item.getLevelText()}}</td>
			<td >${executor}</td>
			<td >${startDate}</td>
			<td >${endDate}</td>-->
			<td class="project-tag">{{each tags}}<p>  ${$value.name}</p>{{/each}}</td>
			<td class="project-completion">
				<div class="progress-title">当前进度：{%if status ==1%}100%{%else%}0%{%/if%}</div>
				<div class="progress progress-mini">
                     <div style="width: {%if status ==1%}100%{%else%}0%{%/if%};" class="progress-bar"></div>
                </div>
			</td>
			<!--<td class="project-people">
                <a><img alt="image" class="img-circle" src="images/a1.jpg"></a>
            </td>
			<td >
			<td >${endDate}</td>
			<td >{%if status ==1%}完成 {%else%}未完成{%/if%}</td>
			<!-- <td >
				<span class="pm-task-modify-btn pm-task-set-btn" id="pm-task-unfollow-btn" data-id="${id}" {%if !hasFollow%} style="display:none;" {%/if%}>
				<button>取消关注</button></span>
				<span class="pm-task-modify-btn pm-task-set-btn" id="pm-task-follow-btn" data-id="${id}" {%if hasFollow%} style="display:none;" {%/if%}>
				<button>关注</button></span>
			</td>
			<td class="project-actions">
                <a class="btn btn-white btn-sm" style="display:none;"><i class="fa fa-folder"></i> 查看 </a>
                <a class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> 编辑 </a>-->
            </td>
			</td>
		</tr>
		
</script>  
