<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<s:url value='/resource/css/helper.css'/>" type="text/css" />
<script src='<s:url value="/dwr/interface/HelpHelper.js"/>'></script>
<script type="text/javascript">

	/**
	 * init body layout
	 * */
	var doclayout;
	function initBodyLayOut(){
		doclayout=jQuery('body').layout({ 
			east:{
				initClosed:true,spacing_closed:10,
				applyDefaultStyles: true,
				togglerTip_open:"{*[Hide]*}{*[Help]*}",
				togglerTip_closed:"{*[Show]*}{*[Help]*}"
			}
		});
	}
	/*页面加载时显示的是当前页面的帮助主题*/
	function initHelpMsg(){
		toThisHelpPage('','');
		//initHelpIndexTree('');
		/*默认不显示帮助模块，而显示左侧的*/
		//doclayout.toggle("west");
	}

	jQuery(function(){
		var height=jQuery(".ui-layout-east").height();
		jQuery("#helper").css("height",(height-25));
		//jQuery("#helper").css("overflow","auto");
	});
	
	/**点击右侧help 的一项时 跳转到详细页面**/
	function showHelpContentJSP(title,url){
		/*底部页签切换*/
		jQuery("#toThisPage_Btn").removeClass("topic_select");
		jQuery("#mainIndex_Btn").addClass("topic_select");
		
		jQuery("#thisTitle").html(title+"{*[Help]*}:");
		jQuery('#mainIndex').css('display','none');
		jQuery('#helpFrame').css('display','');
		jQuery('#thisPageContent').css('display','');
		if(jQuery('#thisPageContent').css('height')=="auto"){
			jQuery('#thisPageContent').css('height',jQuery(document).height()-65);
		}else{
			jQuery('#thisPageContent').css('height',(jQuery("#helper").height()-jQuery("#helpcontenttitle").height()-20));
		}
		jQuery('#helpFrame').attr('src',contextPath+'/help/back/toc/'+url);
	}
	
	/*点击返回右侧帮助主索引*/
	function toHelpMainIndex(){
		jQuery('#thisPageContent').css('display','none');
		jQuery('#mainIndex').css('display','');
		jQuery('#mainIndex').css('height',(jQuery("#helper").height()-jQuery("#helpcontenttitle").height()-15));
		jQuery('#helpcontent').css('height',jQuery("#mainIndex").height()-2);
		jQuery("#helpcontent").css("overflow","auto");
		initHelpIndexTree('');
	}
	var thisHelpPageUrl="";//存放当前主题页面的url
	var title="";
	/*当前帮助主题*/
	function toThisHelpPage(helpid){
		if(helpid!=""){//thisHelpPageUrl为空时说明页面第一访问
			HelpHelper.getTipicHrefById(helpid,function(data){
				if(data){
					var obj=eval("("+data+")");
					thisHelpPageUrl=obj.href;
					title=obj.label;
					showHelpContentJSP(title,obj.href);
				}else{
					jQuery("#thisTitle").html("{*[Current]*}{*[Page]*}{*[Not]*}{*[Help]*}{*[Info]*}...");
				}
			});
		}else{
			showHelpContentJSP(title,thisHelpPageUrl);
		}	
	}	
	
	function doSearchHelp(parem){
		if(parem!=""){
			initHelpIndexTree(parem);
		}
	}
	/*初始化帮助主索引*/
	function initHelpIndexTree(parem){ 
		jQuery("#mainIndex_Btn").removeClass("topic_select");
		jQuery("#toThisPage_Btn").addClass("topic_select");
		HelpHelper.doHelpTreeIndex(parem,function(html){
			jQuery("#thisTitle").html("MyApps{*[Help]*}{*[catalog]*}");
			if(html){
				jQuery("#helpcontent").html(html);
			}else{
				jQuery("#helpcontent").html("<br>{*[Current]*}{*[Page]*}{*[Not]*}{*[Help]*}{*[Info]*}...");
			}
		});
	}
	
	
	/*点击触发这事件才能在页面上显示mouseover对应的高亮*/
	var flag="false";
	function startToGetTipsFromPageFieds(){
		if(flag=="true"){
			flag="false";
			return;		
		}
		jQuery(".justForHelp").each(function(){
				var timoutid;
				jQuery(this).mouseover(function(e){
					var helplistObj=jQuery(this);
					timoutid = setTimeout(function(){
						helplistObj.addClass('ontips');
					},300);
				}).mouseout(function(e){
					jQuery(this).removeClass('ontips');
					clearTimeout(timoutid);
				});
		});
		flag="true";
	}
	
	jQuery(function(){
		jQuery("#isCloseIndex").click(function(){
			if(jQuery("#helpcontent > a ul").attr("display")=="none"){
				jQuery("#helpcontent > a ul").attr("display","");
				jQuery(this).html("Close");
			}else{
				jQuery("#helpcontent a ul").attr("display","none");
				jQuery(this).html("Open");
			}		
		});
	});
	
	function closeHelp(){
		doclayout.toggle("east");
	}
	jQuery(window).resize(function(){
		var bodyH=document.body.clientHeight;
		jQuery("#helper").css("height",(bodyH-27));
		jQuery("#thisPageContent").css("height",(bodyH-60));
});
</script>
<div class="ui-layout-east" id="RHDiv">
	<div id="helper" class="helper">
		<div id="helpcontenttitle" class="HCtitle" style="height:20px;width:100%;">
			<div id="thisTitle" class="thisTitle"></div>
			<div id="closeHelpImg" class="closeHelpImg" style="padding-right: 5px;">
				<img onclick="closeHelp()" width="16px" height="16px" alt="{*[Close]*}{*[Help]*}" src="<s:url value='/resource/images/close01.gif' />">
			</div>
		</div>
		<div id="mainIndex" class="mainIndex">
			<!-- <div id="searchdiv" class="HSdiv">{*[Search]*}:<input type="text" style="width: 100px;height: 20px;" id="SHvalue" name="SHvalue" value=""><input onclick="doSearchHelp(jQuery('#SHvalue').attr('value'))" style="height: 20px;" type="button" value="GO"></div> -->
			<div id="helpcontent" class="HT" style="padding-top: 5px;"></div>
		</div>
		<div id="thisPageContent" class="thisPageContent" style="overflow:hidden;">
			<iframe width="100%" height="99%" src="" id="helpFrame" frameborder="0" name="helpFrame" style="border: 0px;display: none;"></iframe>
		</div>
	</div>
	<div id="page" class="right_help_page">
		<ul>
		<li>
		<a id="mainIndex_Btn" class="topic" title="{*[Relation]*}{*[Subject]*}" onclick="toThisHelpPage('')">{*[Relation]*}{*[Subject]*}</a>
		</li>
		<li>
		<a id="toThisPage_Btn" class="topic" title="{*[All]*}{*[Title]*}" onclick="toHelpMainIndex()">{*[All]*}{*[Subject]*}</a>
		</li>
		</ul>
	</div>
</div>

<script>
	/*if help menus sub menus click to open or close sub menus*/
	function isShowSubHelpMenus(obj){
		var subobj=obj.next("img").next("a").next("br").next("ul");
		if(subobj.css("display")=="none"){
			subobj.css("display","");
			obj.attr("src","../resource/imgnew/minus.gif");
			obj.next("img").attr("src","../resource/imgnew/toc_open.gif");
		}else{
			subobj.css("display","none");
			obj.attr("src","../resource/imgnew/plus.gif");
			obj.next("img").attr("src","../resource/imgnew/toc_closed.gif");
		}
	}
	
</script>
