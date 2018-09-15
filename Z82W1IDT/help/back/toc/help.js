/**init**/

jQuery(function(){
	//initHelpLinkToPage();
});


function initHelpLinkToPage(){
	jQuery(".justForHelp").each(function(){
			var timoutid;
			var tempclassName;
			jQuery(this).mouseover(function(e){
				var helplistObj=jQuery(this);
				var parentObj=window.parent;
				tempclassName=parentObj.document.getElementById(helplistObj.attr("id")).className;
				timoutid = setTimeout(function(){
					helplistObj.addClass('selectHelp');
					if(helplistObj.attr("id")){
						parentObj.document.getElementById(helplistObj.attr("id")).className="ontips "+tempclassName;
					}
				},300);
			}).mouseout(function(e){
				jQuery(this).removeClass('selectHelp');
				if(jQuery(this).attr("id")){
					window.parent.document.getElementById(jQuery(this).attr("id")).className=tempclassName;
				}
				clearTimeout(timoutid);
			});
	});
}

function helpLinkToPage(){
	var link="[";
	jQuery(".justForHelp").each(function(){
		link+='{"id":"'+jQuery(this).attr("id")+'","title":"'+jQuery(this).attr("title")+'","href":"'+jQuery(this).attr("href")+'","target":"'+jQuery(this).attr("target")+'","desc":"'+jQuery(this).attr("desc")+'","parentid":"'+jQuery(this).attr("pid")+'"},';
		//link+='{"id":"'+jQuery(this).attr("id")+'","title":"'+jQuery(this).attr("title")+'","href":"'+jQuery(this).attr("href")+'","target":"'+jQuery(this).attr("target")+'","onclick":"'+jQuery(this).attr("onclick")+'","desc":"'+jQuery(this).attr("desc")+'","parentid":"'+jQuery(this).attr("pid")+'"},';
	});
	link=link.substring(0,link.length-1);
	link+="]";
	if(link=="[]" || link.length==2){
		jQuery("#helpcontent").html("<br>此页面暂无帮助信息！");
		return;
	}
	jQuery.ajax({
			url:contextPath+"/core/helper/getHelpMsg.action",
			type:"post",
			datatype:"jason",
			data:{"link":link},
			success:function(data){
					jQuery("#helpcontenttitle").html("<span style='font-size:12px;color:red;'>"+jQuery(document).attr("title")+"</span>帮助：");
					if(data){
						jQuery("#helpcontent").html(jQuery("#helpcontent").html()+data);
					}else{
						jQuery("#helpcontent").html("<br>此页面暂无帮助信息！");
					}
				},
			error:function(data,status){
					alert("failling to visited...");
				}
	});	
	jQuery(".justForHelp").each(function(){
			var timoutid;
			jQuery(this).mouseover(function(e){
				var helplistObj=jQuery("#helplist_"+jQuery(this).attr("id"));
				timoutid = setTimeout(function(){
					helplistObj.addClass('selectHelp');
					//showHelpTipsMsg(jQuery(this).attr("id"),e);
				},800);
			}).mouseout(function(e){
				jQuery("#helplist_"+jQuery(this).attr("id")).removeClass('selectHelp');
				//showHelpTipsMsg(jQuery(this).attr("id"),e);
				clearTimeout(timoutid);
			});
	});
}