<%@page import="cn.myapps.core.widget.ejb.PageWidget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="runqianReport4" prefix="report"%>
<%@page import="com.runqian.report4.usermodel.Context"%>
<%@page import="cn.myapps.base.action.ParamsTable"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.core.links.ejb.LinkProcess"%>
<%@page import="cn.myapps.core.links.ejb.LinkVO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.myapps.util.json.JsonUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="cn.myapps.core.widget.ejb.*"%>

<%
	
	//获取当前用户
	WebUser webUser = ((WebUser) request.getSession().getAttribute("FRONT_USER"));
	String _widgetId = request.getParameter("_widgetId");
	String applicationId = "";
	String _viewId ="";
	String reportFileName ="";//报表文件名
	
	PageWidgetProcess widgetProcess = (PageWidgetProcess)ProcessFactory.createProcess(PageWidgetProcess.class);
	PageWidget widget = (PageWidget)widgetProcess.doView(_widgetId);
	if(widget == null) return;
	
	String actionContent = widget.getActionContent();
	reportFileName = actionContent.substring(actionContent.indexOf("=")+1, actionContent.indexOf("&_viewid"));
	_viewId = actionContent.substring(actionContent.lastIndexOf("=")+1);
	
	ParamsTable params = ParamsTable.convertHTTP(request);
	params.setParameter("reportFileName",reportFileName);
	params.setParameter("_viewid",_viewId);
	
	//调用输出html
	//初始化HtmlBean
	ViewProcess viewprocess = (ViewProcess) ProcessFactory.createProcess(ViewProcess.class);
	View view = (View) viewprocess.doView(_viewId);
	request.setAttribute("currentDocument",view.getSearchForm() ==null?null:view.getSearchForm().createDocument(params, webUser));
	
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
	htmlBean.setWebUser(webUser);
	request.setAttribute("htmlBean", htmlBean);
	Context context = new Context();
	//利用context，可以传递参数和宏，可以指定数据源、数据库连接工厂等，详见2.1.1.2中的介绍
	context.setParamValue("webUser", webUser);
	context.setParamValue("params", params);
	context.setParamValue("view",view);
	request.setAttribute("myAppsContext", context);
	
	////////参考润乾报表V4.5应用开发手册--HTML模式发布报表--详细说明
	String name = "myAppsReport";//报表名称
	
	String scale = "1.0";//报表缩放比例  1.0
	
	String funcBarLocation = "top";//功能条的位置 top  top,bottom,both
	
	String separator = "";//各按钮间的分隔符
	
	String generateParamForm = "no";//是否生成缺省报表参数及宏输入表单 no
	
	String funcBarFontFace = "宋体";//功能条字体  宋体
	
	String funcBarFontSize = "13px";//功能条字体大小 13px


	String funcBarFontColor = "black";//功能条字体颜色  black


	String functionBarColor = "";//功能条背景颜色   无颜色


	String needSaveAsExcel = "no";//需要显示将报表存为Excel功能按钮？ no


	String needSaveAsPdf = "no";//需要显示将报表存为Pdf？ no
	
	String needSaveAsWord = "no";//需要显示将报表存为word？ no


	String needSaveAsText = "no";//需要显示将报表存为文本？ no


	String needPrint = "no";//显示打印按钮  no


	String printLabel = "打印";//打印按钮外观  打印
	
	String needDirectPrint = "no";//显示直接打印报表Applet按钮 no


	String directPrintImgLabel = "打印";//直接打印按钮外观定义  打印


	String needPrintPrompt = "no";//打印报表是提示确认 no


	String needSelectPrinter = "no";//直接打印报表可选择打印机 no


	String savePrintSetup = "no";//是否将客户端电脑打印设置发送服务器保存，以备下次使用 no 


	String printButtonWidth = "40";//打印的Applet按钮的宽度 40


	String printButtonHeight = "16";//打印的Applet按钮的高度16


	String printedRaq = "";//被打印的报表文件名，用于打印与显示的报表不是同一张是的情况  无


	String excelLabel = "存为Excel";//存为Excel按钮外观定义 存为Excel


	String pdfLabel = "存为PDF";//存为PDF按钮外观定义 存为PDF


	String wordLabel = "存为Word";//存为Word按钮外观定义 存为Word


	String textLabel = "存为Text";//存为text按钮外观定义 存为Text


	String excelUsePaperSize = "no";//存为Excel时，yes按报表设计时纸张尺寸，no采用TAG标签指定width,height no


	String saveAsName = "myAppsReport";//报表保存文件名


	String excelPageStyle = "";//存为Excel的分页方式，不指定此属性值，则系统弹出对话框让用户选 无


	String pdfExportStyle = "";//存为PDF时，导出的文件分页方式及导出类型，导出类型分为图形方式及text方式  无


	String userFuncBarElements = "";//用户自定义功能条中功能元素  无


	String needScroll = "no";//是否固定上表头和右表头固定表头后，页面报表不分页，分页方式设置无效 no


	String useCache = "yes";//显示此报表时是否从缓存系统中获取已经计算好的报表 yes


	String timeout = "-1";//从缓存系统中获取多少分钟内产生的报表，如果没有此时间内的报表，则产生一个新报表 -1


	String width = "";//报表分页宽度  px


	String height = "";//报表分页高度  px


	String columns = "";//报表分栏数 整数


	String needPageMark = "yes";//是否显示报表页数及分页功能 yes


	String pageMarkLabel = "第{currPage}页 共{totalPage}页";//报表页数显示按钮外观定义  第{currPage}页 共{totalPage}页


	String firstPageLabel = "最前页";//翻到第一页功能按钮样式 最前页


	String prevPageLabel = "上一页";//翻到前一页功能按钮样式 上一页


	String nextPageLabel = "下一页";//翻到下一页功能按钮样式 下一页


	String lastPageLabel = "最后页";//翻到最一页功能按钮样式 最后页


	String displayNoLinkPageMark = "no";//是否显示无超链接的页码表示 no


	String submit = "提交";//提交按钮外观定义 提交


	String submitTarget = "_self";//提交结果窗口名 _self


	String needOfflineInput = "no";//是否可以离线填报 no


	String offline = "保存到本机";//离线保存按钮定义 保存到本机


	String inputListener = "";//保存数据前后的java监听器类 


	String needImportExcel = "no";//是否可从Excel文件上载数据来填报 no


	String importExcelLabel = "从Excel导入";//导入Excel文件按钮定义 从Excel导入


	String importExcelAppend = "yes";//行式报表填报中是否采用追加行的方式导入Excel文件中数据区行 yes


	String usePaperSizePrint = "";//


	String backAndRefresh = "yes";//提交数据以后，是否返回录入页面并刷新页面 yes


	String selectText = "no";//单元格获取焦点时，是否选择单元格内容 no


	String promptAfterSave = "yes";//是否弹出提示数据已保存 yes


	String autoCalcOnlyOnSubmit = "no";//只在提交数据时执行自动计算 no


	String scrollWidth = "600";//固定表头报表显示宽度 600


	String scrollHeight = "400";//固定表头报表显示高度 400


	String scrollBorder = "";//固定表头报表边框 无


	String appletJarName = "myAppsReportApplet";//用于报表打印applet文件名  runqianReportApplet


	String useJinit = "";//


	String exceptionPage = "";//显示报表异常信息JSP页面  无


	String inputExceptionPage = "";//显示填报报表保存数据时异常信息的JSP页面 无


	String keyRepeatError = "no";//插入新记录时，逐渐重复是否报错 no


	String saveDataByListener = "no";//是否由用户写的填报监听器来保存数据 no


	String insertRowLabel ="插入";//插入行按钮外观定义  插入


	String appendRowLabel = "添加";//添加行按钮外观定义 添加


	String deleteRowLabel = "删除";//删除行按钮外观定义 删除


	String paperType = "";//纸张类型  报表设计纸张类型


	String paperWidth = "";//纸张宽度 


	String paperHeight = "";//纸张高度


	String leftMargin ="";//左边距


	String rightMargin = "";//右边距


	String topMargin = "";//上边距


	String bottomMargin = "";//下边距


	String needLinkStyle = "yes";//单元格有超链接属性时，是否用设计的字体属性显示 yes


	String validOnSubmit = "yes";//是否在提交时进行有效验证 yes


	String generateCellId = "";//


	String calculateListener = "";//


	String serverPagedPrint = "";//


	String needPagedScroll = "";//
	
	//从菜单链接中获取参数
	Collection<Object> qs = JsonUtil.toCollection("[]", JSONObject.class);
	Iterator<Object> iterator = qs.iterator();
	while (iterator.hasNext()) {
		JSONObject object = JSONObject.fromObject(iterator.next());
		if(object.get("paramKey").equals("name")){
			name = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("scale")){
			scale = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("funcBarLocation")){
			funcBarLocation = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("separator")){
			separator = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("generateParamForm")){
			generateParamForm = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("funcBarFontFace")){
			funcBarFontFace = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("funcBarFontSize")){
			funcBarFontSize = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("funcBarFontColor")){
			funcBarFontColor = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("functionBarColor")){
			functionBarColor = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needSaveAsExcel")){
			needSaveAsExcel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needSaveAsPdf")){
			needSaveAsPdf = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needSaveAsWord")){
			needSaveAsWord = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needSaveAsText")){
			needSaveAsText = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needPrint")){
			needPrint = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("printLabel")){
			printLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needDirectPrint")){
			needDirectPrint = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("directPrintImgLabel")){
			directPrintImgLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needPrintPrompt")){
			needPrintPrompt = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needSelectPrinter")){
			needSelectPrinter = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("savePrintSetup")){
			savePrintSetup = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("printButtonWidth")){
			printButtonWidth = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("printButtonHeight")){
			printButtonHeight = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("printedRaq")){
			printedRaq = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("excelLabel")){
			excelLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("pdfLabel")){
			pdfLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("wordLabel")){
			wordLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("textLabel")){
			textLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("excelUsePaperSize")){
			excelUsePaperSize = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("saveAsName")){
			saveAsName = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("excelPageStyle")){
			excelPageStyle = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("pdfExportStyle")){
			pdfExportStyle = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("userFuncBarElements")){
			userFuncBarElements = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needScroll")){
			needScroll = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("useCache")){
			useCache = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("timeout")){
			timeout = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("width")){
			width = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("height")){
			height = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("columns")){
			columns = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needPageMark")){
			needPageMark = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("pageMarkLabel")){
			pageMarkLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("firstPageLabel")){
			firstPageLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("prevPageLabel")){
			prevPageLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("nextPageLabel")){
			nextPageLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("lastPageLabel")){
			lastPageLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("displayNoLinkPageMark")){
			displayNoLinkPageMark = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("submit")){
			submit = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("submitTarget")){
			submitTarget = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needOfflineInput")){
			needOfflineInput = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("offline")){
			offline = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("inputListener")){
			inputListener = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needImportExcel")){
			needImportExcel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("importExcelLabel")){
			importExcelLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("importExcelAppend")){
			importExcelAppend = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("usePaperSizePrint")){
			usePaperSizePrint = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("backAndRefresh")){
			backAndRefresh = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("selectText")){
			selectText = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("promptAfterSave")){
			promptAfterSave = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("autoCalcOnlyOnSubmit")){
			autoCalcOnlyOnSubmit = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("scrollWidth")){
			scrollWidth = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("scrollHeight")){
			scrollHeight = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("scrollBorder")){
			scrollBorder = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("appletJarName")){
			appletJarName = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("useJinit")){
			useJinit = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("exceptionPage")){
			exceptionPage = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("inputExceptionPage")){
			inputExceptionPage = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("keyRepeatError")){
			keyRepeatError = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("saveDataByListener")){
			saveDataByListener = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("insertRowLabel")){
			insertRowLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("appendRowLabel")){
			appendRowLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("deleteRowLabel")){
			deleteRowLabel = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("paperType")){
			paperType = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("paperWidth")){
			paperWidth = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("paperHeight")){
			paperHeight = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("leftMargin")){
			leftMargin = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("rightMargin")){
			rightMargin = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("topMargin")){
			topMargin = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("bottomMargin")){
			bottomMargin = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needLinkStyle")){
			needLinkStyle = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("validOnSubmit")){
			validOnSubmit = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("generateCellId")){
			generateCellId = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("calculateListener")){
			calculateListener = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("serverPagedPrint")){
			serverPagedPrint = (String)object.get("paramValue");
		}
		else if(object.get("paramKey").equals("needPagedScroll")){
			needPagedScroll = (String)object.get("paramValue");
		}
	}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="cn.myapps.core.dynaform.view.ejb.ViewProcess"%>
<%@page import="cn.myapps.core.dynaform.view.ejb.View"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<script src='<s:url value="/portal/default/dwz/obpm.ui.js"/>'></script>
<script src='<s:url value="/portal/share/script/document/document.js"/>'></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	//表单控件jquery重构
	jqRefactor();
});
/**
 * 清空字段内容
 */
function ev_resetAll() {
	var elements = document.forms[0].elements;

	for (var i = 0; i < elements.length; i++) {
		if(jQuery(elements[i]).attr('fieldType')=='UserField'){
			elements[i].value = "";
		}
		// alert(elements[i].id + ": "+elements[i].type + " resetable-->" +
		// elements[i].resetable);
		if (elements[i].type == 'text' || elements[i].resetable) {
			elements[i].value = "";
		} else if (elements[i].type == 'select-one') {
			// 还原至第一个选项
			if (elements[i].options.length >= 1) {
				elements[i].options[0].selected = true;
			}
		}
	}
	/*
	for (var i = 0; i < arrObject.length; i++) {
		arrObject[i].save("");
	}
	*/
}
</script>
<link rel="stylesheet"
		href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
<title>Insert title here</title>
</head>
<body>
<div style="wdith:100%;display: block;height:100%;overflow: auto;">
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
	<tr>
		<td><!-- 是否显示查询表单 -->
		<div id="dspview_divid">
		<o:MultiLanguage>
		<s:form id="formList" name="formList" action="content4homepage.jsp" method="post" theme="simple">
		 <s:if
			test="#request.htmlBean.showSearchForm">
			<!-- 输出查询表单HTML -->
			<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false" />
			<input type="hidden" name="divid" value="<%=request.getParameter("divid")%>" />
			<s:hidden name="_viewid" value="<%=_viewId %>" />
			<s:hidden name="_submitType" value="searchForm" />
			<s:hidden name="_linkid" value="%{#parameters._linkid}" />
			<s:hidden name="reportFileName" value="<%=reportFileName %>" />
			<s:hidden name="application" value="<%=widget.getApplicationid() %>" />
		</s:if>
		</s:form>
		</o:MultiLanguage>
		</div>
		</td>

		<td style="width: 150px;"><!-- 是否显示查询表单按钮 --> 
		<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
		
		<s:if test="#request.htmlBean.showSearchFormButton">
			<table>
				<tr>
					<td nowrap="nowrap"><span class="button-cmd"><a
						href="###"
						onClick="document.forms[0].submit();"><span><img
						align="middle" border="0"
						src="<s:url value='/resource/imgv2/front/main/query.gif' />">{*[Query]*}</span></a></span>
					</td>
				</tr>
				<tr>
					<td nowrap="nowrap"><span class="button-cmd"><a href="###" onClick=ev_resetAll();><span><img
						align="middle" border="0"
						src="<s:url value='/resource/imgv2/front/main/reset.gif' />">{*[Reset]*}</span></a></span>
					</td>
				</tr>
			</table>
		</s:if>
		
		</o:MultiLanguage>
		</td>
	</tr>
	<tr>
		<td>
			<br/><br/>
			<report:html 
			name="<%=name %>" 
			srcType="file"
			reportFileName="<%=reportFileName %>"
			contextName="myAppsContext" 
			saveAsName="<%=saveAsName %>" 
			scale="<%=scale %>"
			
			needSaveAsExcel="<%=needSaveAsExcel %>"
			needSaveAsPdf="<%=needSaveAsPdf %>"
			needSaveAsWord="<%=needSaveAsWord %>"
			needSaveAsText="<%=needSaveAsText %>"
			needPrint="<%=needPrint %>"
			needDirectPrint="<%=needDirectPrint %>"
			/>
			<!-- 
			funcBarLocation="<%=funcBarLocation %>"
			generateParamForm="<%=generateParamForm %>"
			funcBarFontFace="<%=funcBarFontFace %>"
			funcBarFontSize="<%=funcBarFontSize %>"
			funcBarFontColor="<%=funcBarFontColor %>"
			functionBarColor="<%=functionBarColor %>"
			directPrintImgLabel="<%=directPrintImgLabel %>"
			needPrintPrompt="<%=needPrintPrompt %>"
			needSelectPrinter="<%=needSelectPrinter %>"
			savePrintSetup="<%=savePrintSetup %>"
			printButtonWidth="<%=printButtonWidth %>"
			printButtonHeight="<%=printButtonHeight %>"
			printedRaq="<%=printedRaq %>"
			excelLabel="<%=excelLabel %>"
			pdfLabel="<%=pdfLabel %>"
			wordLabel="<%=wordLabel %>"
			textLabel="<%=textLabel %>"
			excelUsePaperSize="<%=excelUsePaperSize %>"
			userFuncBarElements="<%=userFuncBarElements %>"
			needScroll="<%=needScroll %>"
			useCache="<%=useCache %>"
			timeout="<%=timeout %>"
			needPageMark="<%=needPageMark %>"
			pageMarkLabel="<%=pageMarkLabel %>"
			firstPageLabel="<%=firstPageLabel %>"
			prevPageLabel="<%=prevPageLabel %>"
			nextPageLabel="<%=nextPageLabel %>"
			lastPageLabel="<%=lastPageLabel %>"
			displayNoLinkPageMark="<%=displayNoLinkPageMark %>"
			submit="<%=submit %>"
			submitTarget="<%=submitTarget %>"
			needOfflineInput="<%=needOfflineInput %>"
			offline="<%=offline %>"
			needImportExcel="<%=needImportExcel %>"
			importExcelLabel="<%=importExcelLabel %>"
			importExcelAppend="<%=importExcelAppend %>"
			backAndRefresh="<%=backAndRefresh %>"
			selectText="<%=selectText %>"
			promptAfterSave="<%=promptAfterSave %>"
			autoCalcOnlyOnSubmit="<%=autoCalcOnlyOnSubmit %>"
			appletJarName="<%=appletJarName %>"
			keyRepeatError="<%=keyRepeatError %>"
			saveDataByListener="<%=saveDataByListener %>"
			insertRowLabel="<%=insertRowLabel %>"
			appendRowLabel="<%=appendRowLabel %>"
			deleteRowLabel="<%=deleteRowLabel %>"
			needLinkStyle="<%=needLinkStyle %>"
			validOnSubmit="<%=validOnSubmit %>"
			excelPageStyle="<%=excelPageStyle %>"
			pdfExportStyle="<%=pdfExportStyle %>"
			width="<%=width %>"
			height="<%=height %>"
			columns="<%=columns %>"
			inputListener="<%=inputListener %>"
			usePaperSizePrint="<%=usePaperSizePrint %>"
			scrollWidth="<%=scrollWidth %>"
			scrollHeight="<%=scrollHeight %>"
			scrollBorder="<%=scrollBorder %>"
			useJinit="<%=useJinit %>"
			exceptionPage="<%=exceptionPage %>"
			inputExceptionPage="<%=inputExceptionPage %>"
			generateCellId="<%=generateCellId %>"
			calculateListener="<%=calculateListener %>"
			serverPagedPrint="<%=serverPagedPrint %>"
			needPagedScroll="<%=needPagedScroll %>"
			paperType="<%=paperType %>"
			paperWidth="<%=paperWidth %>"
			paperHeight="<%=paperHeight %>"
			leftMargin="<%=leftMargin %>"
			rightMargin="<%=rightMargin %>"
			topMargin="<%=topMargin %>"
			bottomMargin="<%=bottomMargin %>"
			 -->
		</td>
	</tr>
</table>
</div>
</body>
</html>