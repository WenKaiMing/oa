<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<!DOCTYPE html>
<html lang="cn" class="app fadeInUp animated">

<head>
    <meta charset="utf-8" />
    <title>微OA365，爱工作365天</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta content="微OA365 微信企业号 微信办公 移动OA 微信打卡 微信审批 移动协作平台 " name="Keywords" />
    <meta content="微OA365,让工作更简单、高效" name="Description" />
    <link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../resource/css/animate.min.css" rel="stylesheet" />
    <link href="../resource/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../resource/css/style.min.css" rel="stylesheet" />
    <link href="../resource/css/iconfont.css" rel="stylesheet" />
    <!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
</head>

<body>
    <section class="vbox">
        <header class="header bg-white b-b clearfix">
            <p>
                我的应用
                <small></small>
                <small class="m-l-xs"></small>
                            </p>
        </header>
        <section class="scrollable wrapper w-f">
            <section class="panel panel-default ">
                <div class="row m-l-none m-r-none bg-light lter">
                 <s:iterator value="datas.datas" status="index" id="app">
                     <div class="app-item">
                        <a href="../role/list.action?applicationId=<s:property value="id" />">
                            <img class="app-item-img" alt="微OA365" src="../resource/images/mac_app_store.png" />
                        </a>
                        <div class="app-item-name js_entity_view">
                        		<s:property value="name" />
                       <a class="pull-right text-muted btn-remove-app" data-id="<s:property value="id" />" title="删除"><i class="fa fa-trash-o"></i></a>
                         </div>                            
                    </div>
                  </s:iterator>
                        <div class="app-item-add" title="添加应用">
                            <i class="fa fa-plus"></i>
                        </div>
                    </a>
                </div>
            </section>
        </section>
    </section>
    
     <!-- Modal -->
	<div class="modal fade" id="applist-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加应用</h4>
	      </div>
	      <div class="modal-body" style="height: 420px;padding: 0;">
	       <iframe id="modal-iframe" name=modal-iframe" src="" frameborder="0" height="100%" width="100%" style="height: 100%; width: 100%; border: 0px;">
	        	
	        </iframe>
	      </div>
	      <div class="modal-footer">
	        <button type="button" id="modal-btn-close" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" id="modal-btn-save" class="btn btn-primary">添加</button>
	      </div>
	    </div>
	  </div>
	</div>
    
    
    <script type="text/javascript" src="../resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="../resource/js/plugins/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="../resource/js/core.app.js"></script>
    <script type="text/javascript">
	    var contextPath = '<%=request.getContextPath()%>';
		var USER = {
				id:'<s:property value="#session.FRONT_USER.getId()" />',
				name:'<s:property value="#session.FRONT_USER.getName()" />',
				domainId:'<s:property value="#session.FRONT_USER.getDomainid()" />'
					};
		$(function () {
			Application.init();
		});
    </script>
</body>
</html>
</o:MultiLanguage>