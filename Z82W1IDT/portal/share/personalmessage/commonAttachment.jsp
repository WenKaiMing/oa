<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/interface/PersonalMessageHelper.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script>
function downloadAttachment(id){
		if(checkIsExist(id)){
			var url = contextPath+"/portal/personalmessage/attachment/download.action";
			if(id){
				url += '?attachmentid='+encodeURIComponent(id);
			}
			document.forms[0].action = url;
			document.forms[0].submit();
		}
	}

	function checkIsExist(id){
		var temp = true;
		DWREngine.setAsync(false);
		PersonalMessageHelper.checkIsExist(id, function(res){
			if(res != 'true'){
				alert("{*[file.not.exist]*}{*[OR]*}{*[deleted]*}!");
				temp = false;
			}
		});
		DWREngine.setAsync(true);
		return temp;
	}


	function openAttachmentDialog(ids, names) {
		function showDialog() {
			OBPM.dialog.show({
				width : 600,
				height :415,
				url : attachmentUrl,
				args : {"attachmentIds":ids, "attachmentNames": names},
				title : '{*[Attachment]*}',
				close : function(result) {
					
				}
			});				
		}
	}

	//构建附件链接元素
	function getAttachmentLinks(msgIds, msgNames) {
		var links = "";
		var ids = [];
		var names = [];
		if(msgIds != null && msgIds.indexOf(";") != -1) {
			ids = msgIds.split(";");
		} else {
			ids.push(msgIds);
		}
		if(msgNames != null && msgNames.indexOf(";") != -1) {
			names = msgNames.split(";");
		} else {
			ids.push(msgNames);
		}
		for(var i = 0; i < ids.length; i++) {
			if(ids[i] != null && ids[i].length > 0) {
				links += "<span style='cursor: pointer;' onclick=downloadAttachment('" + ids[i] + "') title='" + names[i] + "'><img style='vertical-align:middle' src='../share/personalmessage/images/attachment.png' />"+names[i]+"</span>";
			}
		}
		return links;
	}
	</script>