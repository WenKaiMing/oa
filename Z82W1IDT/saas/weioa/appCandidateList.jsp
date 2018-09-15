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
    <meta content="微OA365,让工作更简单、高效，爱工作365天。" name="Description" />
    <link href="../resource/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../resource/css/animate.min.css" rel="stylesheet" />
    <link href="../resource/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../resource/css/style.min.css" rel="stylesheet" />
    <link href="../resource/css/iconfont.css" rel="stylesheet" />
    <!--[if lt IE 9]><script src="../resource/js/inie8.min.js"></script><![endif]-->
</head>

<body>
     <section class="vbox">
     <section class="scrollable wrapper w-f">
     <%@include file="/common/msg.jsp"%>
         <section class="panel panel-default  ">
             <div class="table-responsive">
             	<form action="">
                 <table class="table table-hover m-b-none entity-view" >
                     <thead>
                         <tr>
                             <th class="with-checkbox">
                             </th>
                             <th>软件名称</th>
                             <th>描述</th>
                         </tr>
                     </thead>
                     <tbody>
                      <s:iterator value="datas.datas" status="index" id="app">
                            <tr data-id="<s:property value="id"/>">
                              <td>
                                  <input type="checkbox" name="_selects" value="<s:property value="id"/>">
                              </td>
                              <td ><s:property value="name" /></td>
                              <td ><s:property value="description" /></td>
                          </tr>
                    	</s:iterator> 
                     </tbody>
                 </table>
                 </form>
             </div>
         </section>
     </section>
 </section>
    
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