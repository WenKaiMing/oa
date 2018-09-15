<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<title></title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/dtree.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script>
	jQuery(document).ready(function(){
		setTimeout(function(){
			adjustUserSetupPageLayout();
		},1);
		//点击皮肤设置弹出此页面时直接显示该选项卡
	});
	
	jQuery(window).resize(function(){
		adjustUserSetupPageLayout();
	});
	
	function adjustUserSetupPageLayout(){
		jQuery("#contentRight").width(jQuery("#contentTable").width()-jQuery("#contentLeft").width()-7);
		if(jQuery.browser.msie){
			jQuery("#container").height(jQuery("body").height()-15);
			jQuery("#contentTable").height(jQuery("body").height()-2);
			jQuery("#contentLeft").height(jQuery("#contentTable").height());
			jQuery("#contentRight").height(jQuery("#contentTable").height());
		}
		else if(jQuery.browser.mozilla){
			jQuery("#contentTable").height(jQuery("body").height()-40);
			jQuery("#contentLeft").height(jQuery("#contentTable").height()-5);
			jQuery("#contentRight").height(jQuery("#contentLeft").height()-5);
		}else{
			jQuery("#contentTable").height(jQuery("body").height()-2);
			jQuery("#contentLeft").height(jQuery("#contentTable").height()-5);
			jQuery("#contentRight").height(jQuery("#contentLeft").height()-5);
		}
	}
	
	jQuery(function(){
		jQuery(".leftmenulist").click(function(){
			jQuery(".showcontent").attr("class","hidecontent");
			jQuery(".selleftmenulist").removeClass("selleftmenulist");
			jQuery(this).addClass("selleftmenulist");
			jQuery("#"+jQuery(this).attr("id")+"_div").attr("class","showcontent");

			if(jQuery(this).attr("id")=='share'){
				jQuery("#shareframe").attr("src",contextPath+"/km/logs/queryBy.action?operationtype=SHARE");
			}

			if(jQuery(this).attr("id")=='download'){
				jQuery("#downloadframe").attr("src",contextPath+"/km/logs/queryBy.action?operationtype=DOWNLOAD");
			}

			if(jQuery(this).attr("id")=='recommend'){
				jQuery("#recommendframe").attr("src",contextPath+"/km/logs/queryBy.action?operationtype=RECOMMEND");
			}
			if(jQuery(this).attr("id")=='favorite'){
				jQuery("#favoriteframe").attr("src",contextPath+"/km/logs/queryBy.action?operationtype=FAVORITE");
			}
			if(jQuery(this).attr("id")=='view'){
				jQuery("#viewframe").attr("src",contextPath+"/km/logs/queryBy.action?operationtype=VIEW");
			}
		});
		
		//设置默认值
		var isUserdefinedVal = jQuery("#personUserDefined1").attr("checked");
		if(!isUserdefinedVal){
			jQuery("#personUserDefined0").attr("checked","true");
		}

		//设置默认选中页签 
		var tabDiv = '<%=request.getParameter("tab")%>';
		if(jQuery("#"+tabDiv)){
			jQuery("#"+tabDiv).click();
		}
		
	});
	
</script>
</head>
<body id="usersetup" class="body-front" style="margin:0px;overflow: hidden;">
<div id="container" >
<s:form name="formItem" action="savePersonal" method="post" validate="true" theme="simple">
	<div id="contentTable" style="position:relative;clear:both;overflow: hidden;background-color: #FBFBF9;height:100%;">
		<div id="contentLeft" class="contentleft" style="position:absolute;">
			<div id="share" class="leftmenulist">{*[cn.myapps.km.logs.my_share]*}</div>
			<div id="recommend" class="leftmenulist">{*[cn.myapps.km.logs.my_recommend]*}</div>
			<div id="favorite" class="leftmenulist"> {*[cn.myapps.km.logs.my_favorite]*}</div>
			<div id="view" class="leftmenulist"> {*[cn.myapps.km.logs.read]*}</div>
			<div id="download" class="leftmenulist"> {*[cn.myapps.km.disk.download]*}</div>
		</div>
		<div id="contentRight" class="contentRight" style="position:absolute;margin-left:125px;overflow: hidden; overflow-x: hidden;">
     		
			<div id="share_div" class="hidecontent">
				<iframe name="shareframe" id="shareframe" width="100%" height="100%" frameborder="0" src=''></iframe>
			</div>
			
			<div id="recommend_div" class="hidecontent" style="overflow: auto;">
				<iframe name="recommendframe" id="recommendframe" width="100%" height="100%" frameborder="0" src=""></iframe>
			</div>
			
			<div id="favorite_div" class="hidecontent" style="overflow: auto;">
				<iframe name="favoriteframe" id="favoriteframe" width="100%" height="100%" frameborder="0" src=""></iframe>
					
			</div>
			<div id="view_div" class="hidecontent" style="overflow: auto;">
					<iframe name="viewframe" id="viewframe" width="100%" height="100%" frameborder="0" src=""></iframe>
			</div>
			<div id="download_div" class="hidecontent" style="overflow: auto;">
				<iframe name="downloadframe" id="downloadframe" width="100%" height="100%" frameborder="0" src=""></iframe>
		</div>
		</div>
			
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
