<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String taskid = request.getParameter("taskid");
if(taskid !=null && taskid.trim().length()>0){
	response.sendRedirect("index.jsp#/tpl_task-info/:"+taskid);
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>任务协作</title>

<link rel="stylesheet" href="style/weui.css">
<link rel="stylesheet" href="style/jquery-weui.css">

<link rel="stylesheet" href="../css/font-awesome.min.css" >
<link rel="stylesheet" href="script/upload/webuploader/webuploader.css" >
<link rel="stylesheet" href="style/global.css" >
<link rel="stylesheet" href="style/css.css">
<link rel="stylesheet" href="style/record.css">
<%--<link rel="stylesheet" href="style/animate.css">--%>

<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var application = '<%= request.getParameter("application")%>';
var isCloseDialog = '<%=request.getParameter("isCloseDialog")%>';
var title_uf = '';
var title_df = '{*[DepartmentField]*}';
var title_more = '{*[More]*}';
var title_addAuditor = '{*[cn.myapps.core.workflow.add_auditor]*}';
var title_upload = '{*[Upload]*}';
var title_map = '{*[map]*}';
var title_onlinetakephoto = '{*[OnLineTakePhotoField]*}';
var loadError = "{*[page.can.not.load.document]*}";//see ntkoofficecontrol.js
var checkBrowserSettings = '{*[page.check.browser.security.settings]*}';//see ntkoofficecontrol.js
</script>		
</head>

<body ontouchstart="">
<div class="page-load-mark">
	<div class="spinner">
		<div class="bounce1"></div>
		<div class="bounce2"></div>
		<div class="bounce3"></div>
	</div>
</div>

<div class="container js_container pm_animated" id="container"></div>

<div data-role="footer" class="copyright">
	<div class="divfooter divfooter-newTask active" id="newTask">
			<div class="pm_img"></div>
			<div class="pm_txt">新建</div>
	</div>
	<div class="divfooter divfooter-TaskList" id="TaskList">
			<div class="pm_img"></div>
			<div class="pm_txt">任务</div>
	</div>
	<div class="divfooter divfooter-Project" id="Project">
			<div class="pm_img"></div>
			<div class="pm_txt">项目</div>
	</div>
</div>

<%--<script type="text/html" id="tpl_home">
	<!--导航页面开始-->
	<div class="task-list page">
        <div id="task-big-List" class="task-list-box">
			<ul id="task-biglist-ul" ></ul>
		</div>
        <nav class="task-list-bar text-center">
			<ul>
				<li class="tab-item">
					<a class="weui_cell js_cell active" href="#/tpl_task-create" id="newTask">新建任务</a>
				</li>
				
				<li class="tab-item">
					<a class="weui_cell js_cell task-list-condition-type" href="#/tpl_task-list" id="TaskList">任务</a>
				</li>
				<li class="tab-item">
					<a class="weui_cell js_cell task-list-condition-type" href="#/tpl_project-list" id="Project">项目</a>
				</li>
			</ul>
		</nav>
    </div>
	<!--导航页面结束-->
</script>--%>

<script type="text/html" id="tpl_task-create">
    <!--新建任务开始-->
	<div id="taskCreate" class="page task-create">
	<form id="form-create-task" action="#">
		<div class="task-content weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="weui_cell_bd weui_cell_primary">
					<input type="hidden" name="content.id" id="form-create-task-id">
					<textarea class="task-content-textarea weui_textarea" name="content.name" id="form-create-task-name"
					placeholder="任务内容" maxlength="100"></textarea>
					<div class="weui_textarea_counter"><span id="textarea_counter">0</span>/100</div>
				</div>
			</div>
			<div class="task-content-bar text-center">
				<div class="task-content-btn btn-record btn-spack" _href="record_id" id="startRecord">
					<i class="fa fa-microphone"></i> 我要说话
				</div>
				<input type="hidden" id="form-create-task-Record">
				<input type="hidden" id="localId">
				<input type="hidden" id="serverId">
				<div id="sound-play-box" class="task-form-sound" style="display:none">
				<div class="record-box">
					<a class="btn-sound-play">
						<div class="sound-play-arrow"></div>
						<div id="playVoice" class="sound-play-box">
							<div class="sound-play-ico" style="visibility:visible;-webkit-animation:initial;background-postion-x:-48px 0px;"></div>
						</div>
					</a> 
					<span class="btn-sound-times"></span>
					<a class="btn-sound-delete"> <span class="icon icon-close"></span></a>

					<div class="sound-delete-box">
						<div class="header">提示</div>
						<div class="contenter">
							<p>确认删除当前？</p>
						</div>
						<div class="foot">
							<a class="btn pull-right  btn-link red btn-delete"
								data-ignore="push">删除</a> <a
								class="btn pull-right btn-link gay btn-cancel">取消</a>
						</div>
					</div>
				</div>
				</div>

				<div id="sound-button" style="display:none">
				<div class="bigrec-box">
					<div id="record_id" class="modal modal-iframe">
						<div class="record-play-box">
							<div class="record-play-ico">
								<div class="sound-box"></div>
							</div>
							<div class="sound-text">
								<p style="color:red;font-size: 12px;margin: 6px 0">(60s后自动停止录音并上传)</p>
								<p>正在录音</p>
								<p class="time-total">0</p>
							</div>
							<div class="btn-record-stop text-center">
								<span class="icon icon-stop" _href="record_id" id="stopRecord"></span>
								<p>停止</p>
							</div>
						</div>
					</div>

				</div>
				</div>


				

				<div class="task-content-btn">
					<a name="uploadAttachment" class="task-btn-modal-link" id="showActionSheet"><i class="fa fa-camera"></i> 附件上传</a>
				</div>

				<!--BEGIN actionSheet-->
            <div id="actionSheet_wrap">
                <div class="weui_mask_transition" id="mask"></div>
                <div class="weui_actionsheet" id="weui_actionsheet">
                    <div class="weui_actionsheet_menu">
                        <div id="filePicker" class="weui_actionsheet_cell task-content-btn-attachment">
							文件上传
						</div>
                        <div id="takephoto" class="weui_actionsheet_cell">
							拍照上传
						</div>
                    </div>
                    <div class="weui_actionsheet_action">
                        <div class="weui_actionsheet_cell" id="actionsheet_cancel">取消</div>
                    </div>
                </div>
            </div>
            <!--END actionSheet-->
			</div>
		</div>
		<input type="hidden" name="content.attachment" id="form-create-task-attachment">
		<%--<div class="task-attachment" >
			<ul id="fileList" class="task-attachment-ul"></ul>
			
		</div>--%>


		<div class="weui_cells_title">优先级</div>
		<div class="task-rank weui_cells weui_cells_checkbox">
	        <label class="task-rank-label fl weui_check_label" for="levela">
	            <div class="weui_cell_hd">
	                <input type="radio" class="weui_check"  id="levela" 
					name="content.level" title="很重要-很紧急" value="3" data-level="3">
	                <i class="task-rank-icon-red weui_icon_checked"></i>
	            </div>
	            <div id="levela" class="weui_cell_bd weui_cell_primary">
	                <p>重要紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="levelb">
	            <div class="weui_cell_hd">
	                <input type="radio" class="weui_check" id="levelb"
					name="content.level" title="很重要-不紧急" value="2" data-level="2">
	                <i class="task-rank-icon-yallow weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>重要不紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="levelc">
	            <div class="weui_cell_hd">
					<input type="radio" class="weui_check" id="levelc"
					name="content.level" title="不重要-很紧急" value="1" data-level="1">
	                <i class="task-rank-icon-blue weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>不重要紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="leveld">
	            <div class="weui_cell_hd">
					<input type="radio" class="weui_check" id="leveld"
					name="content.level" title="不重要不紧急" value="0" data-level="0" checked="checked">
	                <i class="task-rank-icon-green weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>不重要不紧急</p>
	            </div>
	        </label>
	    </div>
		
	    <div class="weui_cells_title">截止日期</div>
	    <div class="task-date weui_cells weui_cells_form">
		    <div class="weui_cell">

				<div class="weui_cell_hd">
				<i class="fa fa-calendar"></i></div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" name="content.endDate" type="text" placeholder="截止日期" style="padding-left:5px;">
				</div>

				<div  class="weui_cell_switch weui_cell_switch_remind">
					<div class="weui_cell_hd weui_cell_primary">提前一小时提醒</div>
					<div class="weui_cell_ft">
						<input class="weui_switch weui_switch_remind" type="checkbox">
					</div>
				</div>
            </div>
        </div>
		
		<div class="weui_cells_title">选择项目</div>
		<div class="weui_cells weui_cells_access">
			<a class="weui_cell selectproject" href="#/tpl_task-project">
				<div class="weui_cell_bd weui_cell_primary">
					<p>添加</p>
					<div class="wei_select_project">
						<img src="./images/t002.png" class="wei_select_project_img"/>
						<span class="wei_select_project_name">weioa365</span>
					</div>
					<input type="hidden" name="content.projectId"/>
					<input type="hidden" name="content.projectName"/>
				</div>
				<div class="weui_cell_ft">
				</div>
			</a>
			
		</div>
		
		
        <div class="weui_cells_title">添加执行人</div>
	    <div class="task-person weui_cells weui_cells_form">
			<div class="weui_cell">
				<span id="addExecutor" class="addExecutor td text-center" style="height:auto">
					<i class="task-iconfont task-btn-add" 
					
					title="选择用户">&#xeb02;</i>
				</span>
			</div>
		</div>
		
		<div class="weui_cells_title">任务标签</div>
		<div class="weui_cells weui_cells_access">
			<div class="weui_cell selecttag">
				<div class="weui_cell_primary">
					<p class="tagCont">添加</p>
					<input type="hidden" name="content.tags"/>
				</div>
				<a class="selecttagRight"  href="#/tpl_task-tag">
				</a>
			</div>
		</div>
		
		<div class="weui_cells_title" style="display:none;">任务备注</div>
		<div class="weui_cells weui_cells_form" style="display:none;">
			<div class="weui_cell">
				<div class="weui_cell_bd weui_cell_primary">
					<textarea class="weui_textarea" placeholder="添加备注" rows="3" name="content.remark"></textarea>
				</div>
			</div>
		</div>
		
		<div class="task-btn">
			<div class="spacing">
				<span class="task-btn-span">
					<button class="weui_btn weui_btn_primary" type="button" id="form-create-task-btn-submit" title="#taskEdit">创建</button>
				</span>
			</div>
	    </div>
	</div>
	</form>
	<div class="task-project task-select"><header class="bar bar-nav"><a class="close icon icon-close pull-right"></a><h1 class="title" style="margin-bottom:44px;">请选择项目</h1></header><div class="task-project-con"></div></div>
	<div class="task-tag task-select"><header class="bar bar-nav"><a class="close icon icon-close pull-right"></a><h1 class="title" style="margin-bottom:44px;">请选择标签</h1></header><div class="task-tag-con"></div></div>
	</div>
	<!--新建任务结束-->
</script>

<script type="text/html" id="tpl_task-edit">
    
</script>
<script type="text/html" id="tpl_task-info">

</script>

<script type="text/html" id="tpl_project-list">
    <!--项目查看开始-->
	<div class="page pm_projects_lists">
		<div class="searchbar">
			<div class="bd">
				<div class="weui_search_bar" id="search_bar">
					<form class="weui_search_outer">
						<div class="weui_search_inner">
							<i class="weui_icon_search"></i>
							<input type="search" class="weui_search_input" id="search_input" placeholder="搜索" required="">
							<a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
						</div>
						<label for="search_input" class="weui_search_text" id="search_text">
							<i class="weui_icon_search"></i>
							<span>搜索</span>
						</label>
					</form>
					<a href="javascript:" class="weui_search_cancel" id="search_cancel">取消</a>
				</div>

				<div class="weui_cell_switch project_switch_div">
            		<div class="weui_cell_hd weui_cell_primary project_switch_title">显示已关闭项目</div>
            		<div class="weui_cell_ft">
                		<input class="weui_switch project_switch" type="checkbox">
            		</div>
        		</div>

				<div class="pm_projects_box" id="" style="display: block;">
					<ul class="pm_projects_ul"></ul>
					<div class="nullbox" style="display:none;"><i class="task-iconfont">&#xeb10;</i><p>当前页没有任何内容</p></div>
				</div>
			</div>
			</div>
	</div>
	<!--项目查看结束-->
</script>
<script type="text/html" id="tpl_task-project">
    <!--选择项目开始-->
	<div class="page pm_projects_lists">
		<div class="searchbar">
			<div class="bd">
				<div class="weui_search_bar" id="search_bar">
					<form class="weui_search_outer">
						<div class="weui_search_inner">
							<i class="weui_icon_search"></i>
							<input type="search" class="weui_search_input" id="search_input" placeholder="搜索" required="">
							<a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
						</div>
						<label for="search_input" class="weui_search_text" id="search_text">
							<i class="weui_icon_search"></i>
							<span>搜索</span>
						</label>
					</form>
					<a href="javascript:" class="weui_search_cancel" id="search_cancel">取消</a>
				</div>
				<div class="pm_projects_box" id="" style="display: block;">
					<ul class="pm_projects_ul"></ul>
					<div class="nullbox" style="display:none;"><i class="task-iconfont">&#xeb10;</i><p>当前页没有任何内容</p></div>
				</div>
			</div>
			</div>
	</div>
	<!--选择项目结束-->
</script>
<script type="text/html" id="tpl_task-tag">
<!--选择标签开始-->
	<div class="page pm_tags_lists">
		<div class="searchbar">
			<div class="bd">
				<div class="weui_search_bar" id="search_bar">
					<form class="weui_search_outer">
						<div class="weui_search_inner">
							<i class="weui_icon_search"></i>
							<input type="search" class="weui_search_input" id="search_input" placeholder="搜索" required="">
							<a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
						</div>
						<label for="search_input" class="weui_search_text" id="search_text">
							<i class="weui_icon_search"></i>
							<span>搜索</span>
						</label>
					</form>
					<a href="javascript:" class="weui_search_cancel" id="search_cancel">取消</a>
				</div>
				<div class="pm_tags_box" id="" style="display: block;">
					<ul class="pm_tags_ul"></ul>
				</div>
			</div>
			</div>
	</div>
<!--选择标签结束-->
</script>
<script type="text/html" id="tpl_task-pic">
    <!--查看图片开始-->
	<div class="page task-pic">
		<div class="page-load-mark">
			<div class="spinner">
				<div class="bounce1"></div>
				<div class="bounce2"></div>
				<div class="bounce3"></div>
			</div>
		</div>
		<div class="task-attachment">
			<div class="task-attachment-view task-attachment-view-pic">
				<div class="task-attachment-view-content">
					<div class="lookImg"><img class="preview-item" src="{{imgUrl}}" /></div>
				</div>
				<div class="task-attachment-view-bar">
					<a class="task-attachment-view-btn task-attachment-view-close pull-left">退出预览</a>		  
					<a class="task-attachment-view-btn task-attachment-view-delect pull-right">删除</a>
				</div>
			</div>
		</div>
	</div>
	<input style="hidden" class="backhash" value="{{backhash}}" _id="{{id}}">
	<!--查看图片结束-->
</script>
<script type="text/html" id="template_task-pic"></script>
<script type="text/html" id="tpl_task-msg">
    <!--消息内容开始-->
	<div class="page">
		<div class="weui_msg">
			<div class="weui_icon_area"><i class="weui_icon_success weui_icon_msg"></i></div>
			<div class="weui_text_area">
				<h2 class="weui_msg_title"></h2>
				<p class="weui_msg_desc"><span class="jump-homepage">5</span>秒后返回首页</p>
			</div>
			
			<div class="weui_extra_area">
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a class="weui_btn weui_btn_default close-msg">返回首页</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!--消息内容结束-->
</script>


<script type="text/html" id="tpl_task-list">
    <!--我的任务开始-->
	<div class="page pageVisible">
		<div class="task-tab-box">
			<div class="search-panel">
				<div class="weui_search_bar" id="search_bar">
					<form class="weui_search_outer">
						<div class="weui_search_inner">
							<i class="weui_icon_search"></i>
							<input type="search" class="weui_search_input" id="search_input" placeholder="搜索" required="">
							<a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
						</div>
						<label for="search_input" class="weui_search_text" id="search_text">
							<i class="weui_icon_search"></i>
							<span>搜索</span>
						</label>
					</form>
					<a href="javascript:" class="weui_search_cancel" id="search_cancel">取消</a>
				</div>
				<div class="search-box-filter text-center">
					<div class="search-box-filter-item active" data-filter="all" _show="false">
						<i class="fa fa-exchange fa-left" aria-hidden="true"></i>全部 <i class="fa fa-caret-down fa-right" aria-hidden="true"></i>
					</div>
					<div class="search-box-filter-item" data-filter="filter" _show="false">
						<i class="fa fa-filter fa-left" aria-hidden="true"></i>筛选<i class="fa fa-caret-up fa-right" aria-hidden="true"></i> 
					</div>
				</div>
				<div class="search-panel-filter panel panel-cover">
					<form class="form-search-panel">
					<input type="hidden" name="projectId"/>
					<input type="hidden" name="status"/>
					<input type="hidden" name="dateRange"/>
					<input type="hidden" name="tag"/>
					<input type="hidden" name="executorId"/>
					
					<div class="content-block task-create">
						<div class="weui_cells_title">项目</div>
						<div class="panel-right-content panel-project"></div>
						<div class="weui_cells_title">紧急程度</div>
						<div class="task-rank panel-right-content weui_cells_checkbox">
							<label class="task-rank-label fl weui_check_label" for="levela">
								<div class="weui_cell_hd">
									<input type="radio" class="weui_check"  id="levela" 
									name="content.level" title="很重要-很紧急" value="3" data-level="3">
									<i class="task-rank-icon-red weui_icon_checked"></i>
								</div>
								<div id="levela" class="weui_cell_bd weui_cell_primary">
									<p>重要紧急</p>
								</div>
							</label>
							<label class="task-rank-label fl weui_check_label" for="levelb">
								<div class="weui_cell_hd">
									<input type="radio" class="weui_check" id="levelb"
									name="content.level" title="很重要-不紧急" value="2" data-level="2">
									<i class="task-rank-icon-yallow weui_icon_checked"></i>
								</div>
								<div class="weui_cell_bd weui_cell_primary">
									<p>重要不紧急</p>
								</div>
							</label>
							<label class="task-rank-label fl weui_check_label" for="levelc">
								<div class="weui_cell_hd">
									<input type="radio" class="weui_check" id="levelc"
									name="content.level" title="不重要-很紧急" value="1" data-level="1">
									<i class="task-rank-icon-blue weui_icon_checked"></i>
								</div>
								<div class="weui_cell_bd weui_cell_primary">
									<p>不重要紧急</p>
								</div>
							</label>
							<label class="task-rank-label fl weui_check_label" for="leveld">
								<div class="weui_cell_hd">
									<input type="radio" class="weui_check" id="leveld"
									name="content.level" title="不重要不紧急" value="0" data-level="0">
									<i class="task-rank-icon-green weui_icon_checked"></i>
								</div>
								<div class="weui_cell_bd weui_cell_primary">
									<p>不重要不紧急</p>
								</div>
							</label>
						</div>
						
						<div class="weui_cells_title">状态</div>
						<div class="panel-right-content panel-status">
							<span class="panel-right-status panel-right-status" data-status="0">新建</span>
							<span class="panel-right-status panel-right-status" data-status="2">处理中</span>
							<span class="panel-right-status panel-right-status" data-status="3">已解决</span>
							<span class="panel-right-status panel-right-status" data-status="1">已完成</span>
							<span class="panel-right-status panel-right-status" data-status="-1">作废</span>
						</div>
						
						<div class="weui_cells_title">时间</div>
						<div class="panel-right-content panel-date">
							<span class="panel-right-date panel-right-date" data-date="LastWeek">上周</span>
							<span class="panel-right-date panel-right-date" data-date="Today">今天</span>
							<span class="panel-right-date panel-right-date" data-date="ThisWeek">本周</span>
							<span class="panel-right-date panel-right-date" data-date="ThisMonth">本月</span>
						</div>
						
						<div class="weui_cells_title">标签</div>
						<div class="panel-right-content panel-tag">
						</div>
						
						<div class="weui_cells_title">添加执行人</div>
						<div class="task-person panel-right-content">
							<span id="addExecutor" class="addExecutor td text-center" style="height:auto">
								<i class="task-iconfont task-btn-add" title="选择用户">&#xeb02;</i>
							</span>
						</div>
					</div>
					</form>
					<div class="panel-right-btn">
						<a class="btn weui_btn_default panel-right-reset">清空筛选</a>
						<a class="btn weui_btn_primary panel-right-submit">确定<span></span></a>
					</div>
				</div>
				<div class="task-list-box-masks" style="z-index: 1; display: none;"></div>
			</div>
  			<div id="my1" class="task-tab-content active">
				<div class="task-tab-list-box">
					<ul id="task-list-ul" class="task-list-ul task-list-ul-my1 table-view"></ul>
				</div>
  			</div>
			<div class="nullbox" style="display:none;"><i class="task-iconfont">&#xeb10;</i><p>当前页没有任何内容</p></div>
		</div>
	</div>
	<!--我的任务结束-->
</script>

<script type="text/html" id="task-list-li">
    <!--任务列表的每一条li-->
	<li class="line-wrapper" data-id="{{id}}" data-name="{{taskName}}" title="task-info">
		<a class="task-my-box weui_cell" href="#/tpl_task-info/:{{id}}">
			<div class="weui_cell_hd">
				{{avatar}}
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<div class="task-my-top">
					<div class="task-my-con">
						<div class="task-my-title">{{name}}</div>
						{{if level == 3}}<i class="task-rank-icon-red weui_icon_checked"></i>{{/if}}
						{{if level == 2}}<i class="task-rank-icon-yallow weui_icon_checked"></i>{{/if}}
						{{if level == 1}}<i class="task-rank-icon-blue weui_icon_checked"></i>{{/if}}
						{{if level == 0}}<i class="task-rank-icon-green weui_icon_checked"></i>{{/if}}
					</div>
					<div class="task-my-status {{if status == 3 }}status-3 {{/if}} {{if status == 2}}status-2{{/if}} {{if status == 1 }}status-1{{/if}} {{if status == 0}}status-0{{/if}} {{if status == -1 }}status-fei{{/if}}" _value="{{if status == 3 }}3 {{/if}} {{if status == 2}}2{{/if}} {{if status == 1 }}1{{/if}} {{if status == 0}}0{{/if}} {{if status == -1 }}-1{{/if}}">
						{{if status == 3}} 已解决 {{/if}}
						{{if status == 2}} 处理中 {{/if}}
						{{if status == 1}} 已完成 {{/if}}
						{{if status == 0}} 新建  {{/if}}
				        {{if status == -1}} 作废  {{/if}}
					</div>
				</div>
				<div class="task-my-text">
					<div class="task-my-worker">{{executor}}</div>
					<div class="task-my-project">{{projectName}}</div>
					<div class="task-my-time text-right">{{startDate}}</div>
				</div>
			</div>
			<div class="line-btn-delete" id="task-delete-btn-complate" style="display:none"><button>删除</button></div>
		</a>
    </li>
	<!--任务列表的每一条li-->
</script>

<script type="text/html" id="project-list-li">
    <!--项目列表的每一条li-->
	{{each lis as project}}
	<li class="project-item" data-closed="{{if project.closed == false}}false{{else}}true{{/if}}">
		<a href="#/tpl_task-list/:{{project.id}}">
			<div  class="pm_projects_item_box weui_cell">
				<div class="weui_cell_hd">{{project.avatar}}</div>
				<div class="weui_cell_bd">
					<h4 class="pm_projects_item_title">{{project.name}}</h4>
					<p class="pm_projects_item_desc">
						<span>总任务：{{project.tasksTotal}}&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>已完成：{{project.finishedTasksNum}}&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<span>进度：{{project.schedule}}%&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</p>
				</div>
			</div>
		</a>
	</li>
	{{/each}}
	<!--项目列表的每一条li-->
</script>

<script type="text/html" id="task-info">
	    <!--任务查看开始-->
	<div class="page task-info">
		<div class="task-content weui_cells weui_cells_form">
			<div class="task-content-text">
				<div class="task-content-rank">
					{{if level == 3 }}
					<p class='task-content-rank-red'>很重要很紧急</p>
					{{/if}}
					{{if level == 2 }}
					<p class='task-content-rank-yallow'>很重要不紧急</p>
					{{/if}}
					{{if level == 1 }}
					<p class='task-content-rank-blue'>不重要很紧急</p>
					{{/if}}
					{{if level == 0 }}
					<p class='task-content-rank-green'>不重要不紧急</p>
					{{/if}}
				</div>
				<div class="task-content-title" style="padding-bottom:15px">{{name}}</div>
				<div id="sound-play-box" {{if ifVoice == false}}style="display:none"{{/if}} class="task-content-sound">
					<div class="record-box">
						<a class="btn-sound-play">
							<div class="sound-play-arrow"></div>
							<div id="playVoice" class="sound-play-box">
								{{if ifVoice == true}}
								{{each voice as voiceList}}
								<div style="width:{{voiceList.soundWith}};">
								<div class="sound-play-ico" style="visibility:visible;-webkit-animation:initial;background-postion-x:-48px 0px;"></div>
								<audio><source src="{{voiceList.voiceUrl}}" type="audio/mpeg" /></audio>
								</div>
								<span class="btn-sound-times" style="position:absolute;right:5px;top:8px;">{{voiceList.time}}</span>
								{{/each}}
								{{/if}}
								
							</div>
						</a> 
						<div id="curPlayTime" class="pm-edit-Record-time1"></div>
						<a class="btn-sound-space"></a>
					</div>
				</div>
			</div>
		</div>
		<div class="task-attachment">
			<ul class="task-attachment-ul">
				{{if ifFujian}}
				{{each fujian as fujianList}}
				<li class="task-attachment-li task-attachment-pic" {{if fujianList.fileUrl}}_url="{{fujianList.fileUrl}}" {{/if}}><img width='64px' src='{{fujianList.fileUrl}}'/></li> 
				{{/each}}
				{{/if}}
			</ul>
		</div>
		{{if remarks.length > 0}}
		<div class="task-remarks-title weui_cells_title">任务备注:</div>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="task-remark weui_cell_bd weui_cell_primary">
					{{each remarks as remarksList}}
					<p>{{remarksList.content}}</p>
					{{/each}}
				</div>
			</div>
		</div>
		{{/if}}
		<div class="task-status-title weui_cells_title">任务状态:</div>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="task-status weui_cell_bd weui_cell_primary">
					{{if status == 3 }}
					<p>已解决</p>
					{{/if}}
					{{if status == 2 }}
					<p>处理中</p>
					{{/if}}
					{{if status == 1 }}
					<p>已完成</p>
					{{/if}}
					{{if status == 0 }}
					<p>新建</p>
					{{/if}}
				</div>
			</div>
		</div>
		<div class="weui_cells weui_cells_form task-status-cell ">
			<div class="task-status-fl">
                <div class="weui_cell_hd">
				<i class="task-iconfont" style="color:#11bc00">&#xeb04;</i>
				</div>
                <div class="weui_cell_bd weui_cell_primary">
                    <div>开始日期</div>
                    <div class="task-time-start">{{startDate}}</div>
                </div>
            </div>
			<div class="task-status-center">
				{{if isdifferDays}}
					<span class="task-times-range">{{differDays}}天后结束</span>
				{{/if}}
				<div class="task-line"></div>
			</div>
			
            <div class="task-status-fr">
                <div class="weui_cell_hd">
				<i class="task-iconfont" style="color:#ff833b">&#xeb03;</i>
				</div>
                <div class="weui_cell_bd weui_cell_primary">
                    <div>截止日期</div>
                    <div class="task-time-finsh">{{endDate}}</div>
                </div>
            </div>
		</div>
		{{if projectName}}
		<div class="task-project-title weui_cells_title">任务项目:</div>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="task-info-project weui_cell_bd weui_cell_primary">{{projectName}}</div>
			</div>
		</div>
		{{/if}}
		{{if executor}}
		<div class="task-person-title weui_cells_title">执行人:</div>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell"><span class="executor td text-center">{{executor}}</span></div>
		</div>
		{{/if}}
		{{if tags.length > 0}}
		<div class="task-tag-title weui_cells_title">任务标签:</div>
		<div class="weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="task-info-tag weui_cell_bd weui_cell_primary">
				{{each tags as tagList}}
				<span style="margin-rignt:5px;">{{tagList.name}}</span>
				{{/each}}
				</div>
			</div>
		</div>
		{{/if}}
		<div class="task-news-title weui_cells_title">最新动态:</div>
		<div class="task-news weui_cells weui_cells_form">
			{{if isLogs}}
			{{each logs as logsList}}
				<div class="weui_cell new_activity">
					<div class="task-news-pic weui_cell_hd">{{logsList._avatar}}</div>
					<div class="task-news-text  weui_cell_primary">
						<div class="task-news-top">
							<div class="task-news-text1">{{logsList.userName}}</div>
							<div class="task-news-text2">{{logsList.operationDate}}</div>
						</div>
						<div class="trigger-task-news task-news-bottom">{{logsList.logTxt}}</div>
					</div>
				</div>
			{{/each}}
			{{/if}}
		</div>
		{{if isEdit}}
		<div class="task-btn">
			<div class="spacing">
				<span class="task-btn-span task-btn-edit">
					<a href="#/tpl_task-edit/:{{id}}" class="js_cell weui_btn weui_btn_primary" data-id="task-edit">修改任务</a>
				</span>
				<span class="task-btn-span task-btn-end">
					<a href="javascript:;" class="weui_btn weui_btn weui_btn_warn" id="task-edit-btn-complate">完成任务</a>
				</span>
			</div>
	    </div>
		{{/if}}
		<div style="height:44px"></div>
		{{if isEdit}}
		<div class="task-message">
			<div class="task-message-inner">
				<!--<a href="#" class="task-message-add"><i class="fa fa-camera"></i></a>-->
	        	<textarea name="remark" id="task-edit-popup-remark-content" placeholder="填写备注"></textarea>
	        	<a id="task-edit-popup-remark-btn-ok" class="task-message-send">确定</a>
			</div>
		</div>
		{{/if}}
	</div>
	<!--任务查看结束-->
</script>
<script type="text/html" id="task-edit">
	<!--编辑任务开始-->
	<div id="taskEdit" class="page task-edit task-create">
	<div class="page-load-mark">
		<div class="spinner">
			<div class="bounce1"></div>
			<div class="bounce2"></div>
			<div class="bounce3"></div>
		</div>
	</div>	
	<form id="form-edit-task" action="#" >
		<input type="hidden" name="content.id" id="form-edit-task-id" value="{{id}}">
		<input type="hidden" name="content.description" id="form-edit-task-description" value="{{description}}">
		<input type="hidden" name="content.startDate" id="form-edit-task-startdate" value="{{startDate}}">
		<input type="hidden" name="content.creator" id="form-edit-task-creator" value="{{creator}}">
		<input type="hidden" name="content.creatorId" id="form-edit-task-creatorid" value="{{creatorId}}">
		<input type="hidden" name="content.createDate" id="form-edit-task-creatordate" value="{{createDate}}">
		<input type="hidden" name="content.domainid" id="form-edit-task-domainid" value="{{domainid}}">
		<input type="hidden" name="content.remindMode" id="form-edit-task-remindmode" value="{{remindMode}}">
		<input type="hidden" name="content.attachment" id="form-edit-task-attachment" value='{{attachment}}'>
		
		<div class="task-content weui_cells weui_cells_form">
			<div class="weui_cell">
				<div class="weui_cell_bd weui_cell_primary">
					<textarea class="task-content-textarea weui_textarea" name="content.name" id="form-create-task-name"
					placeholder="任务内容" maxlength="100">{{name}}</textarea>
					<div class="weui_textarea_counter"><span id="textarea_counter_edit">0</span>/100</div>
				</div>
			</div>
			<div class="task-content-bar text-center">
				<div class="task-content-btn btn-record btn-spack" _href="record_id" id="startRecord" {{if ifVoice == true}}style="display:none"{{/if}}>
					<i class="fa fa-microphone"></i> 我要说话
				</div>
				<input type="hidden" id="form-edit-task-Record">
				<input type="hidden" id="localId">
				<input type="hidden" id="serverId">
				<div id="sound-play-box" {{if ifVoice == false}}style="display:none"{{/if}} class="task-form-sound">
				<div class="record-box">
					<a class="btn-sound-play">
						<div class="sound-play-arrow"></div>
						<div id="playVoice" class="sound-play-box">
								{{if ifVoice == true}}
								{{each voice as voiceList}}
								<div style="width:{{voiceList.soundWith}};">
								<div class="sound-play-ico" style="visibility:visible;-webkit-animation:initial;background-postion-x:-48px 0px;"></div>
								<audio><source src="{{voiceList.voiceUrl}}" type="audio/mpeg" /></audio>
								</div>
								<span class="btn-sound-times" style="position:absolute;right:5px;top:8px;">{{voiceList.time}}</span>
								{{/each}}
								{{/if}}
							</div>
					</a> 
					<a class="btn-sound-delete"> <span class="icon icon-close"></span></a>

					<div class="sound-delete-box">
						<div class="header">提示</div>
						<div class="contenter">
							<p>确认删除当前？</p>
						</div>
						<div class="foot">
							<a class="btn pull-right  btn-link red btn-delete"
								data-ignore="push">删除</a> <a
								class="btn pull-right btn-link gay btn-cancel">取消</a>
						</div>
					</div>
				</div>
				</div>

				<div id="sound-button" style="display:none">
				<div class="bigrec-box">
					<div id="record_id" class="modal modal-iframe">
						<div class="record-play-box">
							<div class="record-play-ico">
								<div class="sound-box"></div>
							</div>
							<div class="sound-text">
								<p style="color:red;font-size: 12px;margin: 6px 0">(60s后自动停止录音并上传)</p>
								<p>正在录音</p>
								<p class="time-total">0</p>
							</div>
							<div class="btn-record-stop text-center">
								<span class="icon icon-stop" _href="record_id" id="stopRecord"></span>
								<p>停止</p>
							</div>
						</div>
					</div>

				</div>
				</div>
				
				<div class="task-content-btn">
					<a name="uploadAttachment" class="task-btn-modal-link" id="showActionSheet"><i class="fa fa-camera"></i> 附件上传</a>
				</div>

				<!--BEGIN actionSheet-->
            <div id="actionSheet_wrap">
                <div class="weui_mask_transition" id="mask"></div>
                <div class="weui_actionsheet" id="weui_actionsheet">
                    <div class="weui_actionsheet_menu">
                        <div id="filePicker" class="weui_actionsheet_cell task-content-btn-attachment">
							文件上传
						</div>
                        <div id="takephoto" class="weui_actionsheet_cell">
							拍照上传
						</div>
                    </div>
                    <div class="weui_actionsheet_action">
                        <div class="weui_actionsheet_cell" id="actionsheet_cancel">取消</div>
                    </div>
                </div>
            </div>
            <!--END actionSheet-->
			</div>
		</div>
	
		<div class="task-attachment" >
			<ul class="task-attachment-ul" id="fileList">
				{{if ifFujian}}
				{{each fujian as fujianList}}
				<li class="task-attachment-li task-attachment-pic" {{if fujianList.fileUrl}}_id="{{fujianList.fileId}}" _url="{{fujianList.fileUrl}}" {{/if}}><img width='64px' src='{{fujianList.fileUrl}}'/></li> 
				{{/each}}
				{{/if}}
			</ul>
			<div class="task-attachment-view task-attachment-view-pic" style="display:none">
				<div class="task-attachment-view-content">
					<div class="lookImg"><img class="preview-item" src="" /></div>
				</div>
				<div class="task-attachment-view-bar">
					<a class="task-attachment-view-btn task-attachment-view-close pull-left">退出预览</a>		  
					<a class="task-attachment-view-btn task-attachment-view-delect pull-right">删除</a>
				</div>
			</div>
		</div>

		<div class="weui_cells_title">状态</div>
		<div class="weui_cells">
        	<div class="weui_cell weui_cell_select">
            	<div class="weui_cell_bd weui_cell_primary">
                	<select class="weui_select" name="content.status">
                    	<option {{if status == 0}} selected {{/if}} value="0">新建</option>
                    	<option {{if status == 2}} selected {{/if}} value="2">处理中</option>
                    	<option {{if status == 3}} selected {{/if}} value="3">已解决</option>
						<option {{if status == 1}} selected {{/if}} value="1">已完成</option>	
						<option {{if status == -1}} selected {{/if}} value="-1">作废</option>
                	</select>
            	</div>
        	</div>
    	</div>

		<div class="weui_cells_title">优先级</div>
		<div class="task-rank weui_cells weui_cells_checkbox">
	        <label class="task-rank-label fl weui_check_label" for="levela">
	            <div class="weui_cell_hd">
	                <input type="radio" class="weui_check"  id="levela" 
					name="content.level" title="很重要-很紧急" value="3" data-level="3" {{if level == 3}}checked="checked"{{/if}}>
	                <i class="task-rank-icon-red weui_icon_checked"></i>
	            </div>
	            <div id="levela" class="weui_cell_bd weui_cell_primary">
	                <p>重要紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="levelb">
	            <div class="weui_cell_hd">
	                <input type="radio" class="weui_check" id="levelb"
					name="content.level" title="很重要-不紧急" value="2" data-level="2" {{if level == 2}}checked="checked"{{/if}}>
	                <i class="task-rank-icon-yallow weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>重要不紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="levelc">
	            <div class="weui_cell_hd">
					<input type="radio" class="weui_check" id="levelc"
					name="content.level" title="不重要-很紧急" value="1" data-level="1" {{if level == 1}}checked="checked"{{/if}}>
	                <i class="task-rank-icon-blue weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>不重要紧急</p>
	            </div>
	        </label>
	        <label class="task-rank-label fl weui_check_label" for="leveld">
	            <div class="weui_cell_hd">
					<input type="radio" class="weui_check" id="leveld"
					name="content.level" title="不重要不紧急" value="0" data-level="0" {{if level == 0}}checked="checked"{{/if}}>
	                <i class="task-rank-icon-green weui_icon_checked"></i>
	            </div>
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>不重要不紧急</p>
	            </div>
	        </label>
	    </div>
		
	    <div class="weui_cells_title">截止日期</div>
	    <div class="task-date weui_cells weui_cells_form">
		    <div class="weui_cell">

				<div class="weui_cell_hd">
				<i class="fa fa-calendar"></i></div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" name="content.endDate" type="text" placeholder="截止日期" style="padding-left:5px;" value="{{endDate}}">
				</div>

				<div  class="weui_cell_switch weui_cell_switch_remind">
					<div class="weui_cell_hd weui_cell_primary">提前一小时提醒</div>
					<div class="weui_cell_ft">
						<input class="weui_switch weui_switch_remind" type="checkbox">
					</div>
				</div>
            </div>
        </div>
		
		<div class="weui_cells_title">选择项目</div>
		<div class="weui_cells weui_cells_access">
			<a class="weui_cell selectproject"  href="#/tpl_task-project">
				<div class="weui_cell_bd weui_cell_primary">
					{{if projectName}}
					<p class="selectproject_p">{{projectName}}</p>
					{{else}}
					<p class="selectproject_p">添加</p>
					{{/if}}
					<div class="wei_select_project">
						<img src="./images/t002.png" class="wei_select_project_img"/>
						<span class="wei_select_project_name">weioa365</span>
					</div>
					<input type="hidden" name="content.projectId" value="{{projectId}}"/>
					<input type="hidden" name="content.projectName" value="{{projectName}}"/>
				</div>
				<div class="weui_cell_ft">
				</div>
			</a>
		</div>
		
		
        <div class="weui_cells_title">添加执行人</div>
	    <div class="task-person weui_cells weui_cells_form">
			<div class="weui_cell">
				<span id="addExecutor" class="addExecutor td text-center" style="height:auto; {{if isExecutor == true}}display:none;{{/if}}">
					<i class="task-iconfont task-btn-add" 
					title="选择用户">&#xeb02;</i>
				</span>
				{{if isExecutor}}
				<span class="executor td text-center" onclick="clickRemoveSelect(this);">
					<div class="executor-pic"><div class="delete"><i class="fa fa-remove" aria-hidden="true"></i></div>{{_avatar}}</div>
					<div class="executor-name">{{executor}}</div>
					<input type="hidden" name="content.executor" id="form-edit-task-executer" value="{{executor}}">
					<input type="hidden" name="content.executorId" id="form-edit-task-executerid" value="{{executorId}}">
				</span>
				{{/if}}
			</div>
		</div>
		
		<div class="weui_cells_title">任务标签</div>
		<div class="weui_cells weui_cells_access">
			<div class="weui_cell selecttag">
				<div class="weui_cell_primary">
					<div class="selecttag_p tagCont">
					{{if tags.length}}
					{{each tags as tagList}}
					<div class="tag_div" tagname="{{tagList.name}}">
						<span class="eachTag">{{tagList.name}}</span>
						<i class="icon icon-close" style="font-size: 18px;color: red;"></i>
					</div>
					{{/each}}
					{{else}}
					<span>添加</span>
					{{/if}}
					</div>
					<input type="hidden" name="content.tags" value="{{tagsStri}}"/>
				</div>
				<a class="selecttagRight"  href="#/tpl_task-tag">
				</a>
			</div>
		</div>
		
		<div class="weui_cells_title" style="display:none;">任务备注</div>
		<div class="weui_cells weui_cells_form" style="display:none;">
			<div class="weui_cell">
				<div class="weui_cell_bd weui_cell_primary">
					<textarea class="weui_textarea" placeholder="添加备注" rows="3" name="content.remark"></textarea>
				</div>
			</div>
		</div>
	
		<div class="task-btn">
			<div class="spacing">
				<!--<span class="task-btn-span">
					<button class="weui_btn weui_btn_primary" id="task-edit-btn-remark" >备注</button>
				</span>-->
				<span class="task-btn-span">
					<button class="weui_btn weui_btn_primary" id="form-edit-task-btn-submit" type="button">保存</button>
				</span>
			</div>
	    </div>
		
		<div id="popu-wancheng" class="box-fix" style="display:none;z-index:1002;">
    		<center>
        		<div class="ps-fix">
        			<div style="height:50px;margin-top:20px"><h4>确认完成此任务？</h4></div>
            		<button class="btn">取消</button>
            		<button id="task-edit-popup-complate-btn-ok" class="btn">确认</button>
        		</div>
    		</center>
    	</div>
		
	</div>
	</form>
	</div>
	<!--编辑任务结束-->
</script>




<script src="script/jquery-2.1.4.js"></script>
<script src="script/jquery-weui.js"></script>
<script src="script/common.js"></script>
<script src="script/weixin.jsApi.js" ></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>

<script  src="../js/plugin/mmenu/js/jquery.mmenu.min.all.js" ></script>
<link rel="stylesheet" href="script/mobiscroll/css/mobiscroll.custom-2.14.4.min.css" >
<script src="script/mobiscroll/js/mobiscroll.custom-2.14.4.min.js" ></script>

<script  src="script/task.Pinchzoom.js" ></script>
<script  src="script/dialog.js" ></script>
<script  src="script/jquery-obpm-extend.js" ></script>
<script  src="script/obpm-jquery-bridge.js" ></script>
<script  src="../../script/json/json2.js" ></script>

<!-- 文件上传 -->
<script type="text/javascript" src="script/upload/jquery.ui.widget.js"></script>
<script type="text/javascript" src="script/upload/jquery.fileupload.js"></script>
<script type="text/javascript" src="script/upload/jquery.iframe-transport.js"></script>
<!-- 图片上传webuploader -->

<script type="text/javascript" src="script/upload/webuploader/webuploader.js"></script>
	
<script src="script/pm.utils.js"></script>
<script src="script/pm.core.js"></script>
<script src="script/pm.upload.js"></script>
<script src="script/pm.service.js"></script>

<script src="script/weui.router.js"></script>
<script src="script/pm.router.js"></script>	

<script src="./script/template.js"></script>
<script src="./script/jroll.min.js"></script>
<script src="./script/jroll-infinite.min.js"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script>

var HAS_SUBFORM = false;
var visit_from_weixin = '<s:property value="#session.visit_from_weixin"/>';

function onBridgeReady() {
	WeixinJSBridge.invoke('hideOptionMenu');
}

if (typeof WeixinJSBridge == "undefined") {
	if (document.addEventListener) {
		document.addEventListener('WeixinJSBridgeReady', onBridgeReady,
				false);
	} else if (document.attachEvent) {
		document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
		document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	}
} else {
	onBridgeReady();
}
var USER = {
	id : '<s:property value="#session.FRONT_USER.getId()" />',
	name : '<s:property value="#session.FRONT_USER.getName()" />',
	domainId : '<s:property value="#session.FRONT_USER.getDomainid()" />'
};

var ALBUM = false;
var stack = [];
var $container = $('.js_container');
var backUrl = "";
var u = navigator.userAgent;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
var mobiscrollMin;


var action = '<%=request.getParameter("action")%>';

if(action=="createTask"){
	window.location.hash="#/tpl_task-create";

}
if(action=="taskList"){
	window.location.hash="#/tpl_task-list";
}
if(action=="project"){
	window.location.hash="#/tpl_project-list";
}
if(window.location.hash == ""){
	window.location.href = '#/tpl_task-create';
}

$(function () {

	$.ajaxSetup({
		error : function(x, e) {
			Utils.showMessage("请求服务端发生异常,请稍后尝试！", "error");
			return false;
		}
	});
	
    var $container = $('.js_container');
    var hash = window.location.hash;
    
   
	setTimeout(function(){
		PM.Router.task();
	},500);
	
	
	template.config("escape",false);	//设置模板是否编码输出变量的 HTML 字符.
	
    PM.init(); //初始化
    window.addEventListener("hashchange", hidePopUpLayer);
});

</script>
</body>
</html>