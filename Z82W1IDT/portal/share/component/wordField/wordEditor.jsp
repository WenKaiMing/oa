<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.constans.Environment"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%@ page import="java.io.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.km.base.contans.Web"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = DefaultProperty.getProperty("WEB_DOCPATH");
	String contentPath = request.getContextPath();
	path = contentPath + path;
	String _isEdit = request.getParameter("_isEdit");
	WebUser user = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	/*
	String fileName = request.getParameter("_docid");
	String isFile=  "" ;
	if(request.getAttribute("isFile")!=null){
		isFile = (String)request.getAttribute("isFile");
	}
	String opentype  =request.getParameter("_opentype");
	String displayType = request.getParameter("_displayType");
	String _fieldname = request.getParameter("_fieldname");
	String _isEdit = request.getParameter("_isEdit");
	*/
%>


<%@page import="cn.myapps.core.user.action.WebUser"%><html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
	<link rel="stylesheet" href="../../share/css/wordfield.css" type="text/css">
	<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/WordFieldHelper.js"/>'></script>
	<script type="text/javascript" src="../../share/component/wordField/OfficeContorlFunctions.js"></script>
	<script type="text/javascript">
	var userName = '<s:property value="#session.FRONT_USER.name" />';
	var isEdit = 2;
	function init_signature(){
		var isSignature = '<s:property value="#parameters.isSignature"/>';
		var signature =  '<s:property value="#parameters.signature"/>';
		for(var i = 0; i<signature.length;i++){
			var sgt = signature.charAt(i);
			var sgtObj = document.getElementById(sgt);
			var list_sgt = '';
			if(sgtObj)
				list_sgt = sgtObj.getElementsByTagName("li");
			if(list_sgt){
				sgtObj.style.display="none";
				for(var k in list_sgt){
					list_sgt[k].disabled = "true";
				}
			}
		}
	}

    function rz_resize(){
        var editmain_right=document.getElementById("editmain_right");
        var rightW = document.body.clientWidth-30;
        if(isEdit==1){
			jQuery("#actionTr").css("display","none");
			jQuery("#editmain_left").css("display","none");
        }else{
        	rightW -= jQuery("#editmain_left").width();
        }
        editmain_right.style.width = rightW;
	}
    
	function init_documenet(){
		//var isEdit = '<s:property value="#parameters._isEdit"/>';
		var _displayType = '<s:property value="#parameters._displayType"/>';
		var isFile = '<s:property value="#request.isFile"/>';
		var _opentype = '<s:property value="#parameters._opentype"/>';
		var path = '<%=path%>';
		var value =  '<s:property value="#parameters.filename"/>';
		var isOnlyRead =  '<s:property value="#parameters.isOnlyRead"/>';
		if(isOnlyRead==null||isOnlyRead==""){
			isOnlyRead = true;
		}
		if(isOnlyRead && (isOnlyRead == 'true' || isOnlyRead == true)){
			isEdit = 1;//ReadOnly
		}else{
			DWREngine.setAsync(false);
			WordFieldHelper.checkWordFieldIsEdit(value,function(result){
				if(result && result != null){
					var msg = '*提示:文档正在被['+result+']编辑中!请您稍后再打开!';
					alert(msg);
					document.getElementById("msg_isEdit").innerHTML = msg;
					isEdit = 1;//ReadOnly
				}
			});
			//每分钟执行一次更新word文档占用对象
			window.setInterval("createOrUpdateWordFieldIsEdit()",1*60*1000);
		}
	    rz_resize();
	    window.onresize=rz_resize;
		Documentinit(isEdit, isFile, path, _opentype, _displayType);
	}

	function createOrUpdateWordFieldIsEdit(){
		var value =  '<s:property value="#parameters.filename"/>';
		WordFieldHelper.doCreateOrUpdateWordFieldIsEdit(value);
	}

	jQuery(document).ready(function(){
		OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")>=0 || navigator.userAgent.toUpperCase().match(/TRIDENT/) != null?true:false;
		if(OFFICE_CONTROL_OBJ != null && isIE){
			init_documenet();
		    init_signature();
		}else{
			var wordsave = document.getElementById("wordsave");
			if(wordsave != null){
				wordsave.disable = "true";
			}
		}
	});

	function signtool(){
		var url = '<s:url value="/portal/share/component/wordField/ntkosigntool/signtool.jsp"/>';
		OBPM.dialog.show({
			width: 760,
			height: 480,
			url: url,
			args: {},
			title: '{*[core.usbkey.ekey.signtool.title]*}',
			close: function(result) {
				
			}
		});
	}
	</script>
	
	</head>

	<body>
	<s:bean name="cn.myapps.util.UsbKeyUtil" id="UsbKeyUtil"></s:bean>
	<input id="fieldname" type="hidden" value="<s:property value='#parameters._fieldname'/>" />

	<FORM id="wordFrom" method="post" enctype="multipart/form-data"
		action='<s:url action ="uploadword.action"  namespace="/portal/upload"/>'>
	<div id="msg_isEdit" style="color:red"></div>
	<table border="0" width="100%" id="actionTr">
		<tr align="left">
			<td width="50%"></td>
			<td width="50%"></td>
			<td class="line-position2">
			<s:if test="#parameters.saveable"><!-- 预览不能保存 -->
			  <button type="button" class="button-class" style="width:60px;" onClick="doSave()" id="wordsave">
			</s:if>
			<s:else>
			  <button type="button" class="button-class" style="width:60px;" onClick="" id="wordsave"  style="display:none">
			</s:else>
			<img style="vertical-align:middle;" src="<s:url value="/resource/imgv2/front/act/act_4.gif"/>">{*[Save]*}</button>
			</td>
			<td class="line-position2">
			<button type="button" class="button-class" style="width:60px;padding:0;" onClick="doReturn();"><img
				style="vertical-align:middle;" src="<s:url value="/resource/imgv2/front/act/act_8.gif"/>">{*[Close]*}</button>
			</td>
		</tr>
	</table>
	<input id="_docid" type="hidden" value="<s:property value='#parameters._docid'/>"/>
	<input id="formname" type="hidden" value="<s:property value='#request.formname'/>"/>
	<input id="type" type="hidden" value="<s:property value='#parameters._type'/>"/>
	<input id="filename" type="hidden" value="<s:property value='#parameters.filename'/>"/>
	<input id="content.versions" type="hidden" value="<s:property value='#parameters.versions'/>"/>
	<input id="application" type="hidden" value="<s:property value='#parameters.application'/>"/>
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	  <b><font color="red">{*[page.only.support.ie]*}</font></b>
	  <!-- word控件内容 -->
      <div style="width:100%;">
        <!-- 套红、电子签章、模板操作 -->
        <div id="editmain_left" class="editmain_left" style="height:610px;overflow:hidden;margin: 0;padding: 0;">
          <div class="funbutton" id="1">
            <ul class="ul">
              <li class="listtile">{*[secsign.function]*}:</li>
              <s:if test="#UsbKeyUtil.isNtkoUsbKeyEnable()">
               <li onclick="signtool()">{*[core.usbkey.ekey.signtool.title]*}</li>
              </s:if>
              <li class="listtile">
                <select id="secSignFileUrl">
                  <option value="" "selected" title="{*[please.select.server.secsign]*}">
                    {*[please.select.server.secsign]*}
                  </option>
                  <s:property escape="false" value="#request.SECList"/>
                </select>
              </li>
              <li onclick="addServerSecSign()">{*[apply.select.secsign]*}</li>
              <li onclick="addLocalSecSign()">{*[apply.local.secsign]*}</li>
              <li onclick="addHandSecSign()">{*[autograph]*}</li>
              <li onclick="editSec()">{*[secsign.management]*}</li>
              <li onclick="upload(0)">{*[upload.secsign]*}</li>
            </ul>
          </div>
              
          <div class="funbutton" id="2">
            <ul class="ul" >
              <li class="listtile">{*[template.and.redhead.function]*}:</li>
              <li class="listtile">
                <select id="redHeadTemplateFile">
                  <option value="" "selected" title="{*[please.select.redhead]*}">
                    {*[please.select.redhead]*}
                  </option>
                  <s:property escape="false" value="#request.RHList"/>
                </select>
              </li>
              <li onclick="insertRedHeadFromUrl()">{*[apply.select.redhead]*}</li>
              <li onclick="upload(1)">{*[upload.redhead]*}</li>
              <li class="listtile">
                <select id="templateFile" style="max-width:150px;" >
                  <option value="" "selected" title="{*[please.select.template]*}">
                    {*[please.select.template]*}
                  </option>
                  <s:property escape="false" value="#request.TList"/>
                </select>
              </li>
              <li onclick="openTemplateFileFromUrl()">{*[apply.select.template]*}</li>
              <li onclick="upload(2)">{*[upload.template]*}</li>
            </ul>
          </div>
           
          <div class="funbutton" id="3">
            <ul class="ul" >
              <li class="listtile">{*[trace.function]*}:</li>
              <li onclick="SetReviewMode(true);">{*[keep.trace]*}</li>
              <li onclick="SetReviewMode(false);">{*[cancel.trace]*}</li>
              <li onclick="setShowRevisions(true);">{*[show.trace]*}</li>
              <li onclick="setShowRevisions(false);">{*[hide.trace]*}</li>
              <li onclick="OFFICE_CONTROL_OBJ.ActiveDocument.AcceptAllRevisions();">{*[accept.modify]*}</li>
            </ul>
          </div>
        </div>
        
        <!-- Word文档 -->
        <div id="editmain_right" style="float:right;height:610px;">
	 	<script type="text/javascript" src="../../../script/word/ntkoofficecontrol.js"></script>
	      <div id="statusBar" style="height:20px;width:100%;background-color:#c0c0c0;font-size:12px;"></div>
	      <script language="JScript" for=TANGER_OCX event="OnDocumentClosed()">
	      	  	try{
	      	  	 	setFileOpenedOrClosed(false);
		      	}catch(e){
		      	}
	        
	      </script>
	      <script language="JScript" for="TANGER_OCX" event="OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)">
	      if(OFFICE_CONTROL_OBJ != null){   
		      OFFICE_CONTROL_OBJ.ActiveDocument.saved=true;//saved属性用来判断文档是否被修改过,文档打开的时候设置成ture,当文档被修改,自动被设置为false,该属性由office提供.
			    //获取文档控件中打开的文档的文档类型
			    fileType = "Word.Document";
			    fileTypeSimple = "wrod";
			    setFileOpenedOrClosed(true);
	      }
	      </script>
	      <script language="JScript" for=TANGER_OCX event="OnFileCommand(TANGER_OCX_str,TANGER_OCX_obj)">
	        if (TANGER_OCX_str == 3) {
			   alert("不能保存！");
			   CancelLastCommand = true;
		    }
	      </script>
	      
	    </div>
	  </div>
	
	</FORM>
	</body>
</o:MultiLanguage>
</html>
