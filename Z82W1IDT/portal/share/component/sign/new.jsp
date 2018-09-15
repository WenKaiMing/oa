<%@page import="cn.myapps.util.sequence.Sequence"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="cn.myapps.core.email.util.Constants"%>
<%
	String id = Sequence.getSequence();
%>
<html><o:MultiLanguage>
<head>
<title></title>
<link rel="stylesheet" href="<s:url value='/portal/share/css/setting-up.css'/>" type="text/css" />
<style type="text/css">
	.flowname select,.miaoshu textarea,.agentsname input,.agentsname .orgAdd{
		padding: 6px 12px;
	    margin-bottom: 0;
	    font-size: 14px;
	    font-weight: 400;
	    line-height: 1.42857143;
	    white-space: nowrap;
	    vertical-align: middle;
	    -ms-touch-action: manipulation;
	    touch-action: manipulation;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px
	}
	.agentsname .orgAdd{
		padding: 8px 12px;}
</style>
<!--引入CSS-->
<link rel="stylesheet" type="text/css" href="<s:url value='/portal/share/component/sign/webuploader/webuploader.css'/>" />
<!--引入JS-->
<script type="text/javascript" src="<s:url value='/portal/share/component/sign/webuploader/webuploader.js'/>" ></script>
</head>
<body id="application_info_generalTools_links_info" style="margin:0px;padding:0px;">
	<table class="act_table" cellspacing="0" cellpadding="0" style="width:100%;display:none;">
		<tr>								
			<td style="width:100%">
				<div class="exitbtn">
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="applyicon" onClick="doSave();">
							{*[Save]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>
				<div class="button-cmd">
					<div class="btn_left"></div>
					<div class="btn_mid">
						<a class="exiticon" onClick="doExit();">
							{*[Exit]*}
						</a>
					</div>
					<div class="btn_right"></div>
				</div>					
				</div>							
			</td>				
		</tr>
	</table>
	<div id="contentMainDiv" class="contentMainDiv" style="margin-top:25px;">
		<s:form action="save" method="post" validate="true"
			theme="simple" name="workflowConent" >
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="img" value="">
			<table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
			  <tr>
			    <td width="20%" align="right"><span style="color: red;">*</span>{*[印章名称]*}：</td>
			    <td class="flowname">&nbsp;<input type="text" width="250px" name="name" value=""></td>
			  </tr>
			  <tr>
			    <td width="20%" align="right"><span style="color: red;">*</span>{*[印章密码]*}：</td>
			    <td class="flowname">&nbsp;<input type="password" width="250px" name="password" value=""></td>
			  </tr>
			  <tr>
			    <td width="20%" align="right"><span style="color: red;">*</span>{*[上传印章]*}：</td>
			    <td >
			    	<div id="uploader-demo">
					    <!--用来存放item-->
					    <div id="fileList" class="uploader-list"></div>
					    <div id="filePicker">选择图片</div>
					</div>
				</td>
			  </tr>
			  <tr>
			    <td align="right">{*[Description]*}：</td>
			    <td class="miaoshu">&nbsp;<s:textarea name="desc" cssStyle="width:250px" rows="3" wrap="true" theme="simple"/></td>
			  </tr>
			</table>
		</s:form>
	</div>
	<div class="button-cmd" style="text-align: center;">
		<a class="applyicon yingyong" onClick="doSave();">{*[Save]*}</a>
	</div>
	<script type="text/javascript" language="javascript">
	var contextPath = '<%=request.getContextPath()%>';
	var id = '<%=id%>';
	function onFlowChange(obj) {
		var pindex  =  obj.selectedIndex;
		document.getElementsByName("content.flowName")[0].value = obj.options[pindex].text;
	}
	
	function doExit(){
		OBPM.dialog.doExit();
	}
	
	function doSave(){
		var name = $("input[name='name']").val();
		var password = $("input[name='password']").val();
		var img = $("input[name='img']").val();
		if(name.length==0){
			alert("印章名称不能为空！");
		}else if(password.length==0){
			alert("印章密码不能为空！");
		}else if(img.length==0){
			alert("必须上传印章图片！");
		}
		var sign={
				id:$("input[name='id']").val(),
				name:name,
				password:password,
				img:img,
				desc:$("textarea[name='desc']").val()
		};
		OBPM.dialog.doReturn(sign);
	}
	
	$(document).ready(function(){
		// 初始化Web Uploader
		var uploader = WebUploader.create({

		    // 选完文件后，是否自动上传。
		    auto: true,
		    fileNumLimit: 1,

		    // swf文件路径
		    swf: contextPath + '/portal/share/component/sign/webuploader/Uploader.swf',

		    // 文件接收服务端。
		    server: contextPath + '/portal/share/component/sign/upload?uuid='+id,

		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick: '#filePicker',
		    compress: false,

		    // 只允许选择图片文件。
		    accept: {
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }
		});
		// 当有文件添加进来的时候
		uploader.on( 'fileQueued', function( file ) {
			var $list = $("#fileList");
		    var $li = $(
		            '<div id="' + file.id + '" class="file-item thumbnail">' +
		                '<img>' +
		            '</div>'
		            ),
		        $img = $li.find('img');


		    // $list为容器jQuery实例
		    $list.append( $li );

		    // 创建缩略图
		    // 如果为非图片文件，可以不用调用此方法。
		    // thumbnailWidth x thumbnailHeight 为 100 x 100
		    var thumbnailWidth = 100;
		    var thumbnailHeight = 100;
		    uploader.makeThumb( file, function( error, src ) {
		        if ( error ) {
		            $img.replaceWith('<span>不能预览</span>');
		            return;
		        }

		        $img.attr( 'src', src );
		    }, thumbnailWidth, thumbnailHeight );
		});
		// 文件上传过程中创建进度条实时显示。
		uploader.on( 'uploadProgress', function( file, percentage ) {
		    var $li = $( '#'+file.id ),
		        $percent = $li.find('.progress span');

		    // 避免重复创建
		    if ( !$percent.length ) {
		        $percent = $('<p class="progress"><span></span></p>')
		                .appendTo( $li )
		                .find('span');
		    }

		    $percent.css( 'width', percentage * 100 + '%' );
		});

		// 文件上传成功，给item添加成功class, 用样式标记上传成功。
		uploader.on( 'uploadSuccess', function( file,resopnse) {
			$("input[name='img']").val(resopnse.path);
			$("#filePicker").hide();
		    $( '#'+file.id ).addClass('upload-state-done');
		});

		// 文件上传失败，显示上传出错。
		uploader.on( 'uploadError', function( file ) {
		    var $li = $( '#'+file.id ),
		        $error = $li.find('div.error');

		    // 避免重复创建
		    if ( !$error.length ) {
		        $error = $('<div class="error"></div>').appendTo( $li );
		    }

		    $error.text('上传失败');
		});

		// 完成上传完了，成功或者失败，先删除进度条。
		uploader.on( 'uploadComplete', function( file ) {
		    $( '#'+file.id ).find('.progress').remove();
		});
	});
	
	</script>
</body>
</o:MultiLanguage></html>
