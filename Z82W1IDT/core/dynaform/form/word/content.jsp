<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = DefaultProperty.getProperty("WEB_DOCPATH");
	String contentPath = request.getContextPath();
	path = contentPath + path;
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
	<link rel="stylesheet" href="../../dynaform/form/word/resource/wordfield.css" type="text/css">
	<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
	<script type="text/javascript" src="<s:url value='../../dynaform/form/word/OfficeContorlFunctions.js'/>"></script>
	</head>
	
	
	
	<body style="margin: 0;padding: 0;" onload="initDocument();">
		<input id="filename" type="hidden" value="<s:property value='#parameters.filename'/>" />
		<input id="type" type="hidden" value="<s:property value='#parameters._type'/>" />
		<input id="wordid" type="hidden" value="<s:property value='#parameters.id'/>" />
		<table border="0" width="100%">
			<tr align="left">
				<td width="20%"></td>
				<td width="50%"></td>
				<td class="line-position2" align="left">
					<button type="button" class="button-class">
						<img src="<s:url value="/resource/imgv2/front/act/act_4.gif"/>">{*[Save]*}
					</button>
				</td>
				<td class="line-position2" width="50" valign="top" align="left">
					<button type="button" class="button-class">
						<img src="<s:url value="/resource/imgv2/front/act/act_8.gif"/>">{*[Close]*}
					</button>
				</td>
			</tr>
		</table>
	  <b><font color="red">{*[page.only.support.ie]*}</font></b>
	  <!-- word控件显示 -->
      <div style="width:100%;">
        <!-- 套红、电子签章、模板操作 -->
        <div id="editmain_left" class="editmain_left" style="margin: 0;padding: 0;">
          <div class="funbutton">
            <ul class="ul">
              <li class="listtile">{*[secsign.function]*}:</li>
              <li class="listtile">
                <select id="secSignFileUrl">
                  <option value="" "selected" title="{*[please.select.server.secsign]*}">
                    {*[please.select.server.secsign]*}
                  </option>
                  <s:property escape="false" value="#request.SECList"/>
                </select>
              </li>
              <li onclick="">{*[apply.select.secsign]*}</li>
              <li onclick="">{*[apply.local.secsign]*}</li>
              <li onclick="">{*[autograph]*}</li>
              <li onclick="">{*[secsign.management]*}</li>
              <li onclick="">{*[upload.secsign]*}</li>
            </ul>
          </div>
              
          <div class="funbutton">
            <ul class="ul">
              <li class="listtile">{*[template.and.redhead.function]*}:</li>
              <li class="listtile">
                <select id="redHeadTemplateFile">
                  <option value="" "selected" title="{*[please.select.redhead]*}">
                    {*[please.select.redhead]*}
                  </option>
                  <s:property escape="false" value="#request.RHList"/>
                </select>
              </li>
              <li onclick="">{*[apply.select.redhead]*}</li>
              <li onclick="">{*[upload.redhead]*}</li>
              <li class="listtile">
                <select id="templateFile" style="max-width:150px;" >
                  <option value="" "selected" title="{*[please.select.template]*}">
                    {*[please.select.template]*}
                  </option>
                  <s:property escape="false" value="#request.TList"/>
                </select>
              </li>
              <li onclick="">{*[apply.select.template]*}</li>
              <li onclick="">{*[upload.template]*}</li>
            </ul>
          </div>
           
          <div class="funbutton">
            <ul class="ul">
              <li class="listtile">{*[trace.function]*}:</li>
              <li onclick="">{*[keep.trace]*}</li>
              <li onclick="">{*[cancel.trace]*}</li>
              <li onclick="">{*[show.trace]*}</li>
              <li onclick="">{*[hide.trace]*}</li>
              <li onclick="">{*[accept.modify]*}</li>
            </ul>
          </div>
        </div>
        
        <!-- Word文档 -->
        <div style="float:right;height:610px">
	      <script type="text/javascript" src="../../dynaform/form/word/ntkoofficecontrol.js"></script>
	     <div id=statusBar style="height:20px;width:100%;background-color:#c0c0c0;font-size:12px;"></div>
	    </div>
	  </div>
	
	</body>
</o:MultiLanguage>
</html>
