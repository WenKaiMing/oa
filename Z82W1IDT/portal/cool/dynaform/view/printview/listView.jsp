<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>

<%
   	// 初始化HtmlBean
	ViewHtmlBean htmlBean = new ViewHtmlBean();
    htmlBean.setHttpRequest(request);
    htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
    request.setAttribute("htmlBean", htmlBean);
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
a{text-decoration: none;}
.front-table-header{
font-size:18px;
}
.front-font-viewdata{
	font-family:Arial,Vendera;
	color:black;
	font-size:15px;
	z-index:100;
}
.front-table-full-width{
	border:0 none;
	border-collapse:collapse;
	border-spacing:0;
	width:100%;
}

</style>
<!-- 
<link rel="stylesheet"
	href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
-->
	<%@include file="/portal/share/common/js_base.jsp" %>
	<%@include file="/portal/share/common/js_component.jsp" %>
	<jsp:include page='../../../resource/document/style.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script type="text/javascript">
var contextPath = '<%= request.getContextPath()%>';
var operation = '<s:property value="%{#parameters.operation}" />';
var isedit = '';
var enbled='';
</script>

<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script>
	function ev_onload() {
		/* 子文档为编辑模式时才显示activity */
		isedit = document.getElementById("isedit") ? document.getElementById("isedit").value : '';
		if (isedit != 'null' && isedit != '') {
			if (isedit == 'true' || isedit) {
				activityTable.style.display = '';
			} else {
				activityTable.style.display = 'none';
			}
		} else {
			activityTable.style.display = '';
		}
		enbled = document.getElementById("isenbled") ? document.getElementById("isenbled").value : '';
		if (enbled != 'null' && enbled != '') {
			activityTable.style.display = 'none';
		}
	}
	function e_onload(){
		dy_lock();
		ev_onload();
		var checkboxs = document.getElementsByName("_selects");
		<s:iterator value="_selects">
			for (var i=0; i<checkboxs.length; i++) {
				var checkedId = '<s:property />';
				if (checkboxs[i].value == checkedId) {
					checkboxs[i].checked = true;
				}
			}
		</s:iterator>
		
		var funName = '<s:property value="%{#request.message.typeName}" />';
		var url = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}"><s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';
		url = URLDecode(url);
		var msg = document.getElementsByName("message")[0].value;
		if (msg) {
			try{
				eval("do" + funName + "(msg , url);");
			} catch(ex) {
			}
		}
		dy_unlock();
		ev_reloadParent();
		adjustViewLayout();
	}
	function adjustViewLayout(){
		var bodyH=jQuery("body").height();
		jQuery("#container").height(bodyH);
		jQuery("#container").width(jQuery("body").width());
		var activityTableH=jQuery("#activityTable").height();
		var searchFormTableH;
		if(jQuery("#searchFormTable").attr("id")=="searchFormTable"){
			searchFormTableH=jQuery("#searchFormTable").height()+18;/*20px is the padding height*/
		}else{
			searchFormTableH=0;
		}
		var pageTableH=jQuery("#pageTable").height();
		jQuery("#dataTable").height(bodyH-activityTableH-searchFormTableH-pageTableH);
	}
	function doPrint() {
		window.print();
	}
</script>
<title>detail</title>
</head>
<body class="body-front front-scroll-hidden front-bgcolor1" style="height:100%;">
<!-- 遮挡层 -->
<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
	<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
		<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
	</div>
</div>
<s:form id="formList" name="formList" action="displayView" method="post" theme="simple">
<table width="100%" border="1" cellspacing="0" cellpadding="0" id="oLayer">
		<tr valign='top'>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="5">
				<tr>
					<td class="line-position" width="100%">&nbsp;</td>
					
					<td align="right"><input id="button_act" type="button"
						class="button-document" alt="print" value="{*[Print]*}"
						onclick="doPrint()" /></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
<!-- 电子签章 -->
<div id="install" style="display:none">
     <a id="hreftest2" href="<s:url value='/portal/share/component/signature/iSignatureHTML.zip'/>"><font color="red"><b>&nbsp;&nbsp;&nbsp;点击下载金格iSignature电子签章HTML版软件</b></font></a> 
</div>
<%
    if(htmlBean.isSignatureExist()) {
%>
	<%@include file="/portal/share/dynaform/view/batchSignatureObject.jsp"%>
<%
    }
%>
	
	<%@include file="/common/list.jsp"%>
	<s:url id="backURL" action="displayView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="treedocid" value="#parameters.treedocid" />
		<s:param name="isinner" value="#parameters.isinner" />
		<s:param name="_resourceid" value="#parameters._resourceid" />
	</s:url>
	
	<!-- 一些供javascript使用的参数 document.getElementById来获取 -->
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<s:hidden name="isenbled" value="%{#parameters.isenbled}" />
	
	<!-- 当前视图对应的菜单编号 -->
	<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
	
	<!-- 电子签章参数 -->
	<s:hidden name="signatureExist" id="signatureExist"
	value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
	<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
	<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" ></s:hidden>
	<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" ></s:hidden>
	<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" ></s:hidden>
	<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" ></s:hidden>
	<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}"></s:hidden>
	
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
	<s:hidden name="_isdiv" value="%{#parameters.isDiv}" />
	<input type="hidden" name="divid" value="{#parameters.divid}" />
	<s:hidden name="currentDate" value="%{#parameters.currentDate}" />
	<s:hidden name="viewEvent" value="%{#parameters.viewEvent}" />
	<s:hidden name="content.openType" />
	<!-- 父表单ID参数 -->
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<!-- 树形视图参数 -->
	<s:hidden id="treedocid" name="treedocid" value="%{#parameters.treedocid}" />
	<!-- 内嵌视图参数 -->
	<s:hidden id="isinner" name="isinner" value="%{#parameters.isinner}" />
	<div id="container" class="front-boder front-visibility-hidden front-scroll-hidden"  style="width:100%;">
	<!-- 是否显示查询表单 -->
	<s:if test="#request.htmlBean.showSearchForm">
	<!-- 要在BackURL传递的参数放在 searchFormTable -->
	<div id="searchFormTable" class="front-scroll-hidden front-bgcolor2" style="width100%;padding: 10px;">
		<table class="front-table-full-width">
			<tr>
				<td>
				<!-- 输出查询表单HTML  -->
				<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
				</td>
				
				<!-- 是否显示查询表单按钮  -->
				<s:if test="#request.htmlBean.showSearchFormButton">
				<td style="width:150px;">
					<table>
						<tr>
							<td >
								<span class="button-cmd"><a href="#"><span><img align="middle" src="<o:Url value='/resource/imgv2/front/main/query.gif' />">{*[Query]*}</span></a></span>
							</td>
						</tr>
					</table>
				</td>
				</s:if>
			</tr>
		</table>
	</div>
	</s:if>
	
	<!-- 数据表格 -->
	<div id="dataTable" class="front-scroll-auto front-border-top front-bgcolor2" style="width:100%;">
		<table class="front-font-viewdata front-table-full-width">
		<!-- 列头(table-header) -->
		<tr class="front-table-header table-tr">
		<!-- 判断此列是否隐藏, top<Column> -->
			<s:iterator value="content.columns" status="colstatus" id="columnVO">
			<s:if test="visible && !#request.htmlBean.isHiddenColumn(top)">
				<s:if test="width != \"0\"">
					<td  class="column-head" width='<s:property value="width"/>'>
					<s:if test="#columnVO.type=='COLUMN_TYPE_FIELD'">
						<s:if test="_sortCol!=null">
							<s:if test="_sortCol!='' && _sortCol==fieldName">
								<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
									<s:if test="_sortStatus=='ASC'">
										<img border="0" src='<o:Url value="/resource/imgv2/front/main/up.gif"/>'/>
									</s:if>
									<s:elseif test="_sortStatus=='DESC'">
										<img border="0" src='<o:Url value="/resource/imgv2/front/main/down.gif"/>'/>
									</s:elseif>
									<s:else>
										<!-- 可排序图标 -->
									</s:else>
								</a>
							</s:if>
							<s:else>
								<s:if test="#columnVO.isOrderByField!=null && #columnVO.isOrderByField!='' && #columnVO.isOrderByField=='true' ">
									<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
									</a>
								</s:if>
								<s:else>
									{*[<s:property value="name" />]*}<!-- 不勾选排序 -->
								</s:else>
							</s:else>
						</s:if>
						<s:else>
							<s:if test="#columnVO.isOrderByField!=null && #columnVO.isOrderByField!='' && #columnVO.isOrderByField=='true' ">
								<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
									<s:if test="#columnVO.orderType=='ASC'">
										<img border="0" src='<o:Url value="/resource/imgv2/front/main/up.gif"/>'/>
									</s:if>
									<s:else>
										<img border="0" src='<o:Url value="/resource/imgv2/front/main/down.gif"/>'/>
									</s:else>
								</a>
							</s:if>
							<s:else>
								{*[<s:property value="name" />]*}<!-- 不勾选排序 -->
							</s:else>
						</s:else>
					</s:if>
					<s:else>
						{*[<s:property value="name" />]*}<!-- 脚本不需要排序 -->
					</s:else>
					</td>
				</s:if>
				<s:else>
					<td class="column-head" style="display:none;"><s:property value="name" /></td>
				</s:else>
			</s:if>
		</s:iterator>
		</tr>
		<!-- 列头结束(end of table-header) -->
		
		<!-- data iterator -->
		<s:iterator value="datas.datas" status="rowStatus">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
			<s:set name="doc" id="doc" scope="page" />
			<!-- 输出文档行HTML，top<Document> -->
			<%
			out.println(htmlBean.toRowHtml((Document)pageContext.getAttribute("doc")));
			%>
			</tr>
		</s:iterator>
		
		<!-- 字段值汇总 -->
		<s:if test="content.sum">
			<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
					<td class="table-td">
						&nbsp;
					</td>
				<s:iterator value="content.columns" status="rowStatus">
					<s:if test="visible && !isHiddenColumn(#request.htmlBean.runner)">
						<td class="column-td">
							<s:if test="isSum() || isTotal()" >
								<s:property value="name" />:
							</s:if>
							<s:if test="isSum()">
								<s:property value="getSumByDatas(datas, #request.htmlBean.runner, #session.FRONT_USER)" />&nbsp;
							</s:if>
							<s:if test="isTotal()">
								<s:property value="getSumTotal(#session.FRONT_USER, #session.FRONT_USER.domainid)" />&nbsp;
							</s:if>
						</td>
					</s:if>
				</s:iterator>
			</tr>
		</s:if>
		</table>
	</div>
</div>
</s:form>
</body>

<script lanaguage="javaScript">
	
	function viewDoc(docid, formid ,signatureExist) {

	}
</script>

<script>
adjustDataIteratorSize();
</script>
</o:MultiLanguage>
</html>
