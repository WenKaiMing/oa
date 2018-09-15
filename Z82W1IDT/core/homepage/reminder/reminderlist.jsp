<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#session.FRONT_USER.domainid" />
</s:bean>
<html>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#session.FRONT_USER.domainid" />
</s:bean>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<%
	String applicationid =(String)request.getParameter("application");
	String userid = (String)request.getParameter("editPersonalId");
%>
<head>
<title>{*[All_Reminder]*}</title>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>"	type="text/css">
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/dtree.js"/>'></script>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>"	type="text/css">
<script>
	jQuery(document).ready(function(){
		setTemplateStyle();
		getTemplateElementValue();
	});
	
	//设置表格中td及div大小
	function setSizeTempTable(){	
		jQuery("#tempTable").height(jQuery("body").height()* 0.6);
		jQuery("#tempTable").width(jQuery("body").width() * 0.5);
		var tdOneHeight = jQuery("body").height() * 0.3;
		var tdOneWidth = jQuery("body").width() * 0.18;
		
		var tdSizeObj = jQuery("#tempTable td");
		for(var i=0; i<tdSizeObj.length; i++){
			if(tdSizeObj[i].colSpan != ""){
				tdSizeObj[i].width = tdSizeObj[i].colSpan * tdOneWidth;
			}else{
				tdSizeObj[i].width = tdOneWidth;		
			}
			
			if(tdSizeObj[i].rowSpan != ""){
				tdSizeObj[i].height = tdSizeObj[i].rowSpan * tdOneHeight;
			}else{
				tdSizeObj[i].height = tdOneHeight;
			}
			jQuery("#" + tdSizeObj[i].id + " .eleParentDiv").height(tdSizeObj[i].height-18);
			
		}
	}
	
	function doSave(){
		setRemindItem();
		formItem.submit();
	}
	
	
	//--jack--选择模板
	function showSelectTemplate() {
		var templateStyle = jQuery("#templateStyle").attr("value");
		var url = contextPath+ "/core/homepage/reminder/selectTemplate.action?templateStyle=" + templateStyle;
		OBPM.dialog.show({
					opener:window.parent.parent,
					width: 1100,
					height: 500,
					url: url,
					//args: {"templateStyle":templateStyle},
					title: '{*[Select.Template]*}',
					close: function(rtn) {
						if(rtn == null || rtn == ""){
							alert("未选择模板，返回值为空值");
						}else{
							alert(rtn);
							jQuery("#templateStyle").attr("value",rtn);
							setTemplateStyle();
							//把原模板中的元素重新添加到新模板中
							getTemplateElementValue();
							//对新模板和元素分配数据重新储存
							setTemplateElementValue();
						}
					}
			});
	}
	
	//--jack--构建并显示表格
	function setTemplateStyle(){
		var templateStyle = jQuery("#templateStyle").attr("value");
		if(templateStyle == null || templateStyle == ""){
			templateStyle = "td1|td2|td3|td4|td5|td6";
			jQuery("#templateStyle").val("td1|td2|td3|td4|td5|td6");
		}
		var templateHtml ='<table id="tempTable" border="1px" style="width: 80%; height: 80%; table-layout: fixed;"><tr>';
		templateHtml = parseTemplateStyle(templateHtml,templateStyle);
		templateHtml += '</tr></table>';
		jQuery("#templateDiv").html(templateHtml);
		//设置表格
		setSizeTempTable();
		//为td加载添加元素控件
		addModuleOfTd();
	}
	
	//--jack--设置单元格布局
	function parseTemplateStyle(templateHtml,tempSty){
		var templateArray = tempSty.split("|");
		//设置换行标志
		var turnLine = false;
		for(var i=0; i<templateArray.length; i++){
			//添加换行标志--开始
			if(turnLine == false && templateArray[i].substr(2,1)>=4){
				turnLine = true;
				templateHtml += '</tr><tr>';
			}
			//添加换行标志--结束
			//根据id结构设置td格式--开始
			if(templateArray[i].match("-")){
				var templateTdArray = templateArray[i].split("-");
				templateHtml += "<td style='overflow-y: auto;' id='" + templateArray[i] + "' ";
				for(var j=1; j<templateTdArray.length; j++){
					//根据横列和数量标志判断合并横或纵及要合并的单元格数量--开始
					if(templateTdArray[j].substr(0,1) == "x"){
						templateHtml += "colspan='" + templateTdArray[j].substr(1,1) + "' ";
					}else{
						templateHtml += "rowspan='" + templateTdArray[j].substr(1,1) + "' ";
					}
					//根据横列和数量标志判断合并横或纵及要合并的单元格数量--结束
				}
				templateHtml += "><div class='eleParentDiv'>&nbsp;</div></td>";
			}else{
				templateHtml += "<td height='90px' id='" + templateArray[i] + "'><div class='eleParentDiv'>&nbsp;</div></td>";
			}
			//根据id结构设置td格式--结束
		}
		return templateHtml;
	}
	
	//增加图形控件到td中,以触发添加提醒事件
	function addModuleOfTd(){
		var ModuleOfTdHtml = "<div class='addModuleDiv'><img title='{*[Add.Reminder.Element]*}' onclick='showAddElementWindow(this)' src='<s:url value='/portal/default/resource/imgv2/front/grid/add.gif'/>'/></div>";
		jQuery("#templateDiv table td").prepend(ModuleOfTdHtml);
	}
	
	//--jack--弹出选择元素的窗口
	function showAddElementWindow(obj){
		//var url = contextPath+ "/portal/homepage/reminder/addReminderList.action&application=<%=applicationid%>";
		var url = contextPath+ "/core/homepage/reminder/addreminder.action?application=<%=applicationid%>";
		//alert(url);
		var generalPage = jQuery("#generalPage").attr("value");
		var tdOfId = obj.parentNode.parentNode.id;
		
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 800,
			height: 500,
			url: url,
			args: {},
			title: '{*[Add]*}{*[Reminder]*}',
			close: function(rtn) {
				if(rtn == null || rtn == ""){
					alert("未选择元素，返回值为空值");
				}else{
					var rtns = rtn.split("'");
					addElementToTd(tdOfId,rtns[0],rtns[1]);
					setTemplateElementValue();
				}
			}
		});
	}

	//--jack--把元素加入对应td中
	function addElementToTd(tdOfId,tempEleId,tempEleTitle){
		var tempEleIds = tempEleId.split("|");
		if(tempEleTitle != null && tempEleTitle != ""){
			var tempEleTitles = tempEleTitle.split("|");
		}
		if(tempEleIds.length == 1 && tempEleIds[0] == ""){
				return;
		}
		var elementDivHtml = "";
		if(jQuery("#" + tdOfId + " .eleParentDiv").length != 0){
			for(var i=0; i<tempEleIds.length; i++){
				elementDivHtml += "<div class='elementOfTd' id='" + tempEleIds[i] + "'><div style='float: left;'>" + tempEleTitles[i] + "</div>";
				elementDivHtml += "<div style='float: right;' onclick='doDeleteEle(this)'><img title='{*[Delete.Reminder.Element]*}' src='<s:url value='/portal/default/resource/imgv2/front/grid/delete.gif'/>'/></div></div>";
			}
			jQuery("#" + tdOfId + " .eleParentDiv").append(elementDivHtml);
		}else{
			for(var i=0; i<tempEleIds.length; i++){
				//elementDivHtml += "<div class='elementOfTd' id='" + jQuery("#templateDiv table td").attr("id") + "'><div style='float: left;'>" + tempEleTitles[i] + "</div>";
				elementDivHtml += "<div class='elementOfTd' id='" + tempEleIds[i] + "'><div style='float: left;'>" + tempEleTitles[i] + "</div>";
				elementDivHtml += "<div style='float: right;' onclick='doDeleteEle(this)'><img src='<s:url value='/portal/default/resource/imgv2/front/grid/delete.gif'/>'/></div></div>";
			}
			jQuery("#templateDiv table td .eleParentDiv").first().append(elementDivHtml);
		}
	
	}
	
	//--jack--设置json数据
	function setTemplateElementValue(){
		var elementValue = "{";
		var tdObjs = jQuery("#templateDiv table td");
				
		for(var i=0; i<tdObjs.length; i++){
			if(i!=0){
				elementValue += ",";
			}
			elementValue += "'" + tdObjs[i].id + "':";
			var tdDivObjs = jQuery("#" + tdObjs[i].id + " .elementOfTd");
			var tdDivObjsId = "'";
			var tdDivObjsTitle = "'";
			
			if(tdDivObjs.length != 0){
				tdDivObjsId += tdDivObjs[0].id;
				tdDivObjsTitle += tdDivObjs[0].innerText;
				
				for(var j=1; j<tdDivObjs.length; j++){
					tdDivObjsId += "|" + tdDivObjs[j].id;
					tdDivObjsTitle += "|" + tdDivObjs[j].innerText;
				}
			}
			tdDivObjsId += "'";
			tdDivObjsTitle += "'";
			elementValue += tdDivObjsId + ";" + tdDivObjsTitle;
		}
		elementValue += "}";
		jQuery("#templateElement").val(elementValue);
		doSubmit();
	}
	
	//--jack--解释json数据
	function getTemplateElementValue(){
		var templateElement = jQuery("#templateElement").attr("value");
		if(templateElement == null || templateElement == ""){
			templateElement = "{'td1':'','td2':'','td3':'','td4':'','td5':'','td6':''}";
		}
		templateElement = templateElement.slice(1,-1);
		var templateElementSubs = templateElement.split(",");
		if(templateElementSubs.length == 0){
			return;
		}
		for(var i=0; i<templateElementSubs.length; i++){
			var templateElementSubsSubs = templateElementSubs[i].split(":");
			if(templateElementSubsSubs.length == 0){
				return;
			}
			var templateTdId = templateElementSubsSubs[0].slice(1,-1);
			var templateTdElements = templateElementSubsSubs[1].split(";");
			if(templateTdElements[0] != null){
				var templateTdElementId = templateTdElements[0].slice(1,-1);
			}else{
				return;
			}
			if(templateTdElements[1] != null){
				var templateTdElementTitle = templateTdElements[1].slice(1,-1);
			}
			addElementToTd(templateTdId,templateTdElementId,templateTdElementTitle);
		}
		
	}
	
	//--jack--删除td中的元素
	//并重新把json值存入templateStyle中
	function doDeleteEle(Obj){
		Obj.parentNode.outerHTML = "";
		setTemplateElementValue();
	}
	
	function showParams(){
		var userid = jQuery("#editPersonalId").val();
		var applicationid = jQuery("#application").val();
		alert("templateStyle ==> " + jQuery("#templateStyle").val() + " templateElement ==> " + jQuery("#templateElement").val());
		alert(" userid ==> " + userid + " appid ==> " + applicationid);
	}
	
	function doSubmit(){
		document.forms[0].submit();
	}

</script>
</head>
<body>
<s:form name="formItem" action="saveElement" method="post" validate="true" theme="simple">
	<s:hidden name="templateStyle" id="templateStyle" />
	<s:hidden name="templateElement" id="templateElement" />
	<input type="hidden" id="application" name="application" value='<s:property value="#parameters.application"/>' />
	<input type="hidden" id="editPersonalId" name="editPersonalId" value='<s:property value="#parameters.editPersonalId"/>' />
	<div id="tempDivParent" style="border: 1px solid #dfe8f6; width: 90%; height: 300px; margin-right:10px; text-align: center;">
		<div style="background-color: #dfe8f6;">
			<table width="100%">
				<tr>
					<td>{*[Select.Template.For.Homepage.Reminder]*}：</td>
					<td align="right">
						<span title="{*[Select.Other.Template]*}" onclick="showSelectTemplate()" style="cursor: hand;">{*[Select.Other.Template]*}</span>
					</td>
				</tr>
			</table>
		</div>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div onclick="showParams()">显示参数
			<!-- button type="submit" class="button-image" onClick="submit();">
				<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
			</button> -->
		</div>
		<!-- button onclick="doSubmit()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button> -->
		<div id="templateDiv" class="templateDiv" style="padding: 10px;">
		</div>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>