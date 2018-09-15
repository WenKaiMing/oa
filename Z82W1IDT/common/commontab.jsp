<%@ page pageEncoding="UTF-8"%><%@ taglib uri="/struts-tags" prefix="s"%>
<% 

String applicationid = request.getParameter("application");
if (applicationid == null) {
	applicationid = request.getParameter("id");
}


%>
	<script type="text/javascript">
	var openTab;
	var applicationid ='<%=applicationid %>';
function change(obj){
	document.getElementsByName("btnBasicInfo")[0].className = "btcaption";
	//document.getElementsByName("btnNavigator")[0].className = "btcaption";
	document.getElementsByName("btnUsual")[0].className = "btcaption";
	document.getElementsByName("btnLibs")[0].className = "btcaption";
	document.getElementsByName("btnTools")[0].className = "btcaption";
	document.getElementsByName('btnMltLng')[0].className = "btcaption";
	
	document.getElementById("sec_tab").style.display="none";
	document.getElementById("sec_tab1").style.display="none";
	document.getElementById("sec_tab2").style.display="none";
	document.getElementById("sec_tab3").style.display="none";
	document.getElementById("sec_tab4").style.display="none";
	document.getElementById("sec_tab5").style.display="none";
	var pagelines = parent.document.getElementById("pagelinesid").value;
	obj.style.display = "";//
	obj.className = "btcaption-selected";
	window.location.href="<s:url value='/core/deploy/application/edit.action'/>?id=<%=applicationid %>&mode=application" + '&' + pagelines;
}

function clickbtnMltLng(obj){
	window.location.href="<s:url value='/core/multilanguage/list.action'/>?mode=application&application=<%=applicationid%>&selected=&tab=4";
}

function clickbtnNavigator(obj){
	window.location.href="<s:url value='/core/deploy/application/navigator.jsp'/>?mode=application&application=<%=applicationid%>&selected=&tab=5";
}

function clickTab(obj) {

	document.getElementsByName("btnStyleLibs")[0].className = "btcaption";
	document.getElementsByName("btnValidateLibs")[0].className = "btcaption";
	document.getElementsByName("btnExcelConf")[0].className = "btcaption";
	document.getElementsByName("btnMacroLibs")[0].className = "btcaption";
	//document.getElementsByName("btnReminder")[0].className = "btcaption";
	document.getElementsByName("btnResource")[0].className = "btcaption";
	document.getElementsByName("btnRole")[0].className = "btcaption";
	//document.getElementsByName("btnHomepage")[0].className = "btcaption";
	document.getElementsByName("btnWidget")[0].className = "btcaption";
	document.getElementsByName("btnTask")[0].className = "btcaption";
	document.getElementsByName("btnDataSource")[0].className = "btcaption";
	document.getElementsByName("btnStateLabel")[0].className = "btcaption";
	document.getElementsByName("btnDeveloper")[0].className = "btcaption";
	//document.getElementsByName("btnResources")[0].className = "btcaption";
	document.getElementsByName("btnMetadataMgr")[0].className = "btcaption";//2.6新增
		
	var url = '';
	switch (obj.name){
		case "btnStyleLibs": url="<s:url value='/core/style/repository/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=2";break;
		case "btnValidateLibs": url="<s:url value='/core/validate/repository/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=2";break;
		case "btnExcelConf": url="<s:url value='/core/dynaform/dts/excelimport/list.action'/>?s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=3";break;
		case "btnMacroLibs": url="<s:url value='/core/macro/repository/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=2";break;
	   // case "btnReminder": url="<s:url value='/core/homepage/reminder/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
	    case "btnResource": url="<s:url value='/core/resource/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
	    case "btnRole": url="<s:url value='/core/role/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
	    //case "btnHomepage": url="<s:url value='/core/user/userDefinedList.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
	    case "btnTask": url="<s:url value='/core/task/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
	    case "btnDataSource": url="<s:url value='/core/dynaform/dts/datasource/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=3";break;
	    case "btnStateLabel": url="<s:url value='/core/workflow/statelabel/list.action'/>?mode=application&s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
		case "btnDeveloper": url="<s:url value='/core/deploy/application/listJoinedDeveloper.action'/>?id=<%=applicationid%>&mode=application&tab=3";break;
		//case "btnResources": url="<s:url value='/core/privilege/res/list.action'/>?s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1";break;
		//2.6新增
		case "btnMetadataMgr": url='<s:url value="/core/dynaform/dts/metadata/metadataManager.jsp"/>?id=<%=applicationid%>&mode=application&tab=3';break;
		case "btnWidget": url='<s:url value="/core/widget/list.action"/>?s_applicationid=<%=applicationid%>&application=<%=applicationid%>&tab=1';break;
		
	}
	url += "&selected=" + obj.name;
	window.location.href = url;

	obj.className = "btcaption-s-selected";
}

function changeTab(tid, obj) {
	document.getElementById("sec_tab").style.display="none";
	document.getElementsByName("btnBasicInfo")[0].className = "btcaption";
	//document.getElementsByName("btnNavigator")[0].className = "btcaption";
	document.getElementsByName("btnUsual")[0].className = "btcaption";
	document.getElementsByName("btnLibs")[0].className = "btcaption";
	document.getElementsByName("btnTools")[0].className = "btcaption";
	document.getElementsByName('btnMltLng')[0].className = "btcaption";
	var tab = document.getElementById(tid);
	if (openTab) {
		var oriTab = document.getElementById(openTab);
		oriTab.style.display = "none";
	} 
	openTab = tid;
	if (tab) {
		tab.style.display = "";
	}
	obj.className = "btcaption-selected";
}

</script>
<style>
#container {
	/*width: 100%;*/
	height: 25px;
	overflow: hidden;
}

.rollbox {
	/*width: 100%;*/
	width:600px;
	overflow: hidden;
	display: inline;
	height: 25px;
	float: left;
}

.listContent {
	float: left;
}

.nav-seperate img {
	/*height:20px;*/
}

</style>
<script>
function calculateWidth() {
	checkNeededMove();
	var frameWidth = document.body.clientWidth;
	document.getElementById("container").style.width = frameWidth-38;
	resetScrollLeft();
}

function checkNeededMove() {
	var content = document.getElementById("content");
	var clientWidth = document.body.clientWidth;
	
	if (content.offsetWidth < clientWidth) {
		document.getElementById("btnLeft").style.display = "none";
		document.getElementById("btnRight").style.display = "none";
	} else {
		document.getElementById("btnLeft").style.display = "";
		document.getElementById("btnRight").style.display = "";
	}
}

function resetScrollLeft() {
	document.getElementById("container").scrollLeft = 0;
}

function inittab() {
	var url = window.location.href;
	var tab = <%=request.getParameter("tab")%>;
	var selected = '<%=request.getParameter("selected")%>';
	
	if (tab == "4") {
		changeTab('sec_tab4', document.getElementsByName('btnMltLng')[0]);
	}else if (tab && selected) {
		if (tab == "1") {
			changeTab('sec_tab1', document.getElementsByName('btnUsual')[0]);
		}
		else if (tab == "2"){
			changeTab('sec_tab2', document.getElementsByName('btnLibs')[0]);
		}
		else if (tab == "3") {
			changeTab('sec_tab3', document.getElementsByName('btnTools')[0]);
		}
		document.getElementsByName(selected)[0].className = "btcaption-s-selected";
	}else if (tab == "5") {
		changeTab('sec_tab5', document.getElementsByName('btnNavigator')[0]);
	}
}

jQuery(function(){
	if(jQuery("#applicationframe",parent.document).attr("class") == "hasMenu"){
		jQuery("#applicationframe",parent.document).attr("class","");
		changeTab('sec_tab1', document.getElementsByName('btnUsual')[0]);
		document.getElementsByName("btnResource")[0].className = "btcaption-s-selected";
	}
	//jQuery("#container").width(345);
	jQuery(window).resize(function(){
		if(jQuery("#tab_table").width()<360||jQuery("#container").width()<360)
		{
			//jQuery("#tab_table").width(350);
			jQuery("#container").width(360);
		}
	});
})
</script>
	<table id="tab_table" border="0" cellspacing="0" cellpadding="0" style="width:100%">
		<tr style="height:20px;">
			<td align="left" valign="bottom" class="nav-td" style="width:10px;">
			&nbsp;
			</td>
			<!-- 
			<td align="left" valign="bottom" class="nav-td">
				<img id="btnLeft" style="display:none;cursor:pointer;" src="<s:url value='/resource/imgnew/goleft.gif' />" border="0" />
			</td>
			-->
			<td align="left" valign="bottom" class="nav-td" width="600px">

			<div id="container" style="width:510px">
			<div applicationid="rollbox" class="rollbox">
			<div id="content" width="600px">

			<div class="listContent"> 
				<input type="button" name="btnBasicInfo" class="btcaption-selected" onclick="change(this)" value="{*[cn.myapps.core.deploy.application.basic_info]*}" />
			</div>
			<!-- 
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnNavigator" class="btcaption" onClick="changeTab('sec_tab5', this);clickbtnNavigator(this)" value="{*[图形导航]*}"/>
			</div>
			 -->
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnUsual" class="btcaption" onClick="changeTab('sec_tab1', this)" value="{*[cn.myapps.core.deploy.application.general_tools]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnLibs" class="btcaption" onClick="changeTab('sec_tab2', this)" value="{*[Libraries]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnTools" class="btcaption" onClick="changeTab('sec_tab3', this)" value="{*[cn.myapps.core.validate.repository.advanced_tools]*}" />
			</div>
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			<div class="listContent">
				<input type="button" name="btnMltLng" class="btcaption" onClick="changeTab('sec_tab4', this);clickbtnMltLng(this)" value="{*[MultiLanguages]*}"/>
			</div>
			<!-- 
			<div class="listContent nav-seperate">
				<img src="<s:url value='/resource/imgv2/back/main/nav_seperate.gif' />" />
			</div>
			 -->
			</div>
			</div>
			</div>
			</td>
			<td align="left" valign="bottom" class="nav-td">
				<img id="btnRight" style="display:none;cursor:pointer;" src="<s:url value='/resource/imgnew/goright.gif' />" border="0" />
			</td>
		</tr>
		<tr id="sec_menu" style="height:27px;">
		<td colspan="3" style="padding-left:10px;" class="nav-s-td">
			<div id="sec_tab"></div>
			<div id="sec_tab1" style="display:none;">
				<div class="listContent">
					<input type="button" name="btnRole" class="btcaption" onClick="clickTab(this)" value="{*[Role]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnResource" class="btcaption" onClick="clickTab(this)" value="{*[cn.myapps.core.resource.menu]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<!--<div class="listContent">
					<input type="button" name="btnHomepage" class="btcaption" onClick="clickTab(this)" value="{*[HomePage]*}" />
				</div>
				-->
				<div class="listContent">
					<input type="button" name="btnWidget" class="btcaption" onClick="clickTab(this)" value="{*[cn.myapps.core.widget.name]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button"  name="btnTask" class="btcaption"   onclick="clickTab(this)" value="{*[Task]*}"/>
				</div>
				<!--  
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				
				<div class="listContent">
					<input type="button" name="btnReminder" class="btcaption" onclick="clickTab(this)" value="{*[Reminder]*}" />
				</div>
				-->
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnStateLabel" class="btcaption" onClick="clickTab(this)" value="{*[StateLabel]*}" />
				</div>
				<!--
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				 
				<div class="listContent">
					<input type="button" name="btnResources" class="btcaption" onClick="clickTab(this)" value="{*[Resources]*}" />
				</div>
				
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnOperation" class="btcaption" onClick="clickTab(this)" value="{*[Activity]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnLinks" class="btcaption" onClick="clickTab(this)" value="{*[Links]*}" />
				</div>
				-->
				 
			</div>
			<div id="sec_tab2" style="display:none;">
				<div class="listContent">
					<input type="button" name="btnMacroLibs" class="btcaption" onclick="clickTab(this)" value="{*[MacroLibs]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnStyleLibs" class="btcaption" onclick="clickTab(this)" value="{*[StyleLibs]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnValidateLibs" class="btcaption" onclick="clickTab(this)" value="{*[ValidateLibs]*}" />
				</div>
			</div>
			<div id="sec_tab3" style="display:none;">
				<div class="listContent">
					<input type="button" style="width: 47px;margin: 0 10px;" title="{*[Developer]*}" name="btnDeveloper" class="btcaption" onClick="clickTab(this)" value="{*[Developer]*}" />
				</div>
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" style="width: 95px;margin: 0 10px;" title="{*[cn.myapps.core.validate.repository.excelconf]*}" name="btnExcelConf" class="btcaption" onclick="clickTab(this)" value="{*[cn.myapps.core.validate.repository.excelconf]*}" />
				</div>
				<!-- 
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnComponent" class="btcaption" onClick="clickTab(this)" value="{*[Component]*}" />
				</div>
				 -->
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" style="width: 47px;margin: 0 10px;" title="{*[DataSource]*}" name="btnDataSource" class="btcaption" onClick="clickTab(this)" value="{*[DataSource]*}" />
				</div>
				<!-- 
				<div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" name="btnPage" class="btcaption" onclick="clickTab(this)" value="{*[Page]*}" />
				</div>
				 -->
				 <div class="listContent nav-seperate">
					<img src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent">
					<input type="button" style="width: 75px;margin: 0 10px;" title="{*[cn.myapps.core.validate.repository.metadatamanager]*}" name="btnMetadataMgr" class="btcaption" onClick="clickTab(this)" value="{*[cn.myapps.core.validate.repository.metadatamanager]*}" />
				</div>
			</div>
			<div id="sec_tab4" style="display:none;"></div>
			<div id="sec_tab5"  style="display:none;">{*[图形导航]*}</div>
		</td>
		</tr>
	</table>
