<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="cn.myapps.km.disk.ejb.NDisk"%>
<%@page import="cn.myapps.km.disk.ejb.NDiskProcess"%>
<%@page import="cn.myapps.km.disk.ejb.NDiskProcessBean"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.Collection" %>
<%@ page import="cn.myapps.km.org.ejb.NUser" %>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	NUser diskUser = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isPublicDiskAdmin = diskUser.isPublicDiskAdmin();
	NDiskProcess nDiskprocess = new NDiskProcessBean();
	NDisk diskOfMine = nDiskprocess.getNDiskByUser(webUser.getId());
	NDisk diskOfPublic = nDiskprocess.getPublicDisk(webUser.getDomainid());
	String diskIdOfMine = diskOfMine.getId();
	String dirIdOfMine = diskOfMine.getnDirId();
	String diskIdOfPublic = diskOfPublic.getId();
	String dirIdOfPublic = diskOfPublic.getnDirId();
	
	String userName = webUser.getName();
	String contextPath = request.getContextPath();
	
	boolean kmDisable = diskUser.getKmRoles().isEmpty();
%>
<!DOCTYPE html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>知识管理</title>
<link rel="stylesheet" href="css/weui.min.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/global.css"/>
<link rel="stylesheet" href="js/webuploader/webuploader.css" >
<link rel="resource" type="application/l10n" href="./js/pdf/web/locale/locale.properties">
</head>
<body ontouchstart>
<div class="weui-mask" id="iosMask" style="display: none"></div>
<!-- <div class="weui-actionsheet" id="upload-actionsheet">
    <div class="weui-actionsheet__menu">
        <div id="takephoto"  class="weui-actionsheet__cell">拍照</div> -->
        <div id="filePicker"  class="weui-actionsheet__cell" style="display:none">相册</div>
    <!-- </div>
    <div class="weui-actionsheet__action">
        <div class="weui-actionsheet__cell" id="actionsheetCancel">取消</div>
    </div>
</div> -->
<div class="js_dialog" id="createFolderDialog" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd">
        	<input class="weui-input" type="text" placeholder="新建文件夹">
        </div>
        <div class="weui-dialog__ft">
            <a class="weui-dialog__btn weui-dialog__btn_default" data-active="cancel">取消</a>
            <a class="weui-dialog__btn weui-dialog__btn_primary" data-active="submit">确定</a>
        </div>
    </div>
</div>
<div class="js_dialog" id="renameDialog" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd">
        	<input class="weui-input" type="text">
        </div>
        <div class="weui-dialog__ft">
            <a class="weui-dialog__btn weui-dialog__btn_default" data-active="cancel">取消</a>
            <a class="weui-dialog__btn weui-dialog__btn_primary" data-active="submit">确定</a>
        </div>
    </div>
</div>
<div class="js_dialog" id="deleteDialog" style="display: none;">
    <div class="weui-mask"></div>
    <div class="weui-dialog">
        <div class="weui-dialog__hd"><strong class="weui-dialog__title">删除</strong></div>
        <div class="weui-dialog__bd">删除后将无法恢复</div>
        <div class="weui-dialog__ft">
            <a class="weui-dialog__btn weui-dialog__btn_default" data-active="cancel">取消</a>
            <a class="weui-dialog__btn weui-dialog__btn_primary" data-active="submit">确定</a>
        </div>
    </div>
</div>
<div id="toast" style="display: none;">
    <div class="weui-mask_transparent"></div>
    <div class="weui-toast">
        <i class=""></i>
        <p class="weui-toast__content"></p>
    </div>
</div>
<div id="loadingToast" style="display:none;">
    <div class="weui-mask_transparent"></div>
    <div class="weui-toast">
        <i class="weui-loading weui-icon_toast"></i>
        <p class="weui-toast__content">数据加载中</p>
    </div>
</div>
<div id="container" class="container km"></div>
<%@include file="./template.jsp" %>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/jquery.i18n.properties.min.js"></script>
<script src="js/backbone.route.js"></script>
<script src="js/template.js"></script>
<script src="js/webuploader/webuploader.js"></script>
<script src="js/km.core.js"></script>
<script src="js/km.upload.js"></script>
<script src="js/km.util.js"></script>
<script src="js/km.service.js"></script>
<script src="js/km.router.js"></script>
<script  src="../../script/json/json2.js" ></script>
<script>
var contextPath = "<%=contextPath%>";
var userName = "<%=userName%>";
var u = navigator.userAgent;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
//我的网盘ID
var diskIdOfMine = "<%=diskIdOfMine%>";
//我的网盘目录ID
var dirIdOfMine = "<%=dirIdOfMine%>";
//公共网盘ID
var diskIdOfPublic = "<%=diskIdOfPublic%>";
//公共网盘目录ID
var dirIdOfPublic = "<%=dirIdOfPublic%>";

var kmDisable = <%=kmDisable%>;

var isPublicDiskAdmin = <%=isPublicDiskAdmin%>;

if(location.hash == ""){
	location.hash = "#list/my/1";
}

$(function(){
	//初始化国际化插件
	$.i18n.properties({
	    name:'JS', 
	    path:'js/i18n/', 
	    mode:'map',
	    checkAvailableLanguages: true
	});
	if(kmDisable){
		$('body').html(template('atp-kmdisable',{}));
	}else{
		KM.Core.bindEven();
		KM.Router.init();
		KM.Util.androidInputBugFix();
		KM.Upload.webUploader();
	}
	KM.Util.cache.nDirId = dirIdOfMine;
})
</script>
</body>
</o:MultiLanguage>
</html>