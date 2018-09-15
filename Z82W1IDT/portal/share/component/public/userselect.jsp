<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
	String applicationid=request.getParameter("application");
	String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/myapp.css" />
    <link rel="stylesheet" href="css/selectUser.css" />
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.css">
<![endif]-->
    <!--[if lte IE 7]>
   <link rel="stylesheet" type="text/css" href="css/ie.css">
   <link rel="stylesheet" type="text/css" href="css/myapp-ie.css" />
   <link rel="stylesheet" type="text/css" href="css/selectUser-ie.css" />
<![endif]-->
    <!--[if lt IE 9]> 
   <script src="js/html5shiv.min.js"></script>
<![endif]-->
</head>

<body>
    <div id="right">
        <div id="message-body" class="crm_right">
            <div class="searchDiv">
                <div role="tabpanel">
                    <ul class="nav-tabs" role="tablist">
                        <!-- <li role="presentation" ><a href="#system" aria-controls="system" role="tab" data-toggle="tab">通讯录</a></li> -->
                        <li role="presentation" class="active"><a href="#user" aria-controls="user" role="tab" data-toggle="tab">部门</a></li>
                        <li role="presentation"><a href="#vote" aria-controls="vote" role="tab" data-toggle="tab">查询</a></li>
                        <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">在线用户</a></li>
                        <li role="presentation"><a href="#vote2" aria-controls="vote2" role="tab" data-toggle="tab">常用联系人</a></li>
                        <div class="clearfix"></div>
                    </ul>
                    <div class="tab-box">
                        <div class="tab-content">
                            <!-- <div role="tabpanel" class="active" id="system">
                                <div class="crossULdivleft">
                                    <div id="lefthead" class="list_head">通讯录：</div>
                                    <div id="leftcontent1" class="leftContent">
                                        <div id="all" class="list_div"><img class="selectImg_right" src="images/right_2.gif">全部联系人</div>
                                        <div class="list_div"><img class="selectImg_right" src="images/right_2.gif">销售部</div>
                                    </div>
                                </div>
                            </div> -->
                            <div role="tabpanel" class="active" id="user">
                                <div class="tab-left-box">
                                <div class="crossULdivleft">
                                
                                    <div id="lefthead" class="list_head">部门列表：</div>
                                    <div id="leftcontent" class="leftContent jstree jstree-3 jstree-default jstree-focused">
                                    <!-- 
                                        <ul>
                                            <li class="jstree-last jstree-open">
                                                <ins class="jstree-icon">&nbsp;</ins>
                                                <a href="#" class="">
                                                    <ins class="jstree-icon">&nbsp;</ins>总部</a>
                                                <ul style="">
                                                    <li class="jstree-closed">
                                                        <ins class="jstree-icon">&nbsp;</ins>
                                                        <a href="#" class="">
                                                            <ins class="jstree-icon">&nbsp;</ins>销售部</a>
                                                    </li>
                                                    <li class="jstree-closed">
                                                        <ins class="jstree-icon">&nbsp;</ins>
                                                        <a href="#" class="">
                                                            <ins class="jstree-icon">&nbsp;</ins>资讯部</a>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                       -->
                                    </div>
                                </div>
                                <div class="crossULdivright">
                                    <div class="crossULdivright_lef">
                                        <div id="addAll" class="list_head">
                                            <input class="list_div_click" type="checkbox">联系人
                                        </div>
                                        <div id="rightcontent_userlist" class="rightContent_lef">
                                            <nav><span class="page">共0页</span>
                                                <ul class="pagination pagination-sm">
                                                    <li>
                                                        <a href="#" aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>
                                                    <li><a href="#">1</a></li>
                                                    <li>
                                                        <a href="#" aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                    
                                </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div role="tabpanel" id="messages">
                                <div class="crossULdivleft">
                                    <div id="lefthead" class="list_head">当前在线用户：(<span id="online-user-count" style="color:#d32222">5</span>)</div>
                                    <div id="online-users" class="leftContent">
                                    </div>
                                </div>
                            </div>
                          <div role="tabpanel" id="vote">
                                <div class="crossULdivleft">
                                    <div id="lefthead" class="list_head">查询：</div>
                                    <div id="leftcontent" class="leftContent">
                                        <div class="input-group">
                                            <table width="100%">
                                                <tr>
                                                    <td width="64%">
                                                        <input type="text" class="form-control" id="sm_name" placeholder="输入用户名搜索">
                                                    </td>
                                                    <td>
                                                       <div class="input-group-btn">
                                                           <button type="button" id="btn-search" class="btn"></button>
                                                       </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="search-list" id="search-list">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" id="vote2">
                                <div class="crossULdivleft">
                                    <div id="lefthead" class="list_head">常用联系人：</div>
                                    <div id="favoriteContacts" class="leftContent">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content-right">
                        <div class="crossULdivright_rig">
                            <div id="righttitle" class="list_head">
                            	    已选择用户
                            </div>
                            <div id="selectedUserDiv" class="selectedUserDiv">
                            </div>
                            <div class="list_div" style="text-align:center;padding:10px 0px">
                                <button id="deleteAll" class="btn btn-default" type="button">
                                    <span class="glyphicon" aria-hidden="true">&#xe178;</span> 移除所有
                                </button>
                            </div>
                        </div></div>
                        <div class="clearfix"></div>
                        <div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <script src="js/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
           	<script src="<s:url value='/dwr/engine.js'/>"></script>
			<script src="<s:url value='/dwr/util.js'/>"></script>
			<script src='<s:url value="/pm/js/plugin/artDialog/jquery.artDialog.js?skin=default"/>'></script>
			<script src='<s:url value="/pm/js/plugin/artDialog/jquery.artDialog.js"/>'></script>
			<script src='<s:url value="/pm/js/plugin/artDialog/artDialog.js"/>'></script>
			<script src='<s:url value="/pm/js/plugin/artDialog/plugins/iframeTools.source.js"/>'></script>
			<script src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
			<script src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
			<script src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
			<script src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
			<script src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
			<script src="js/component.userselect.js"></script>
            <!--[if lte IE 6]>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
<![endif]-->
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var domainid='<%=domainid%>'; 
</script>
</body>

</html>
