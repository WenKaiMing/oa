<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/phone/resource/common/include_css.jsp" %>
<%@ include file="/portal/phone/resource/common/include_js.jsp" %>
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
	<link rel="stylesheet" href="<s:url value='/portal/share/css/main.css' />" type="text/css">
	<link rel="stylesheet" href="../../share/css/wordfield.css" type="text/css">
	<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/WordFieldHelper.js"/>'></script>
	<script type="text/javascript" src="../../share/component/wordField/OfficeContorlFunctions.js"></script>
	<script type="text/javascript">
	var userName = '<s:property value="#session.FRONT_USER.name" />';
	function init_signature(){
		//var isSignature = '<s:property value="#parameters.isSignature"/>';
		var signature =  '<s:property value="#parameters.signature"/>';
		for(var i = 0; i<signature.length;i++){
			var sgt = signature.charAt(i);
		var list_sgt = document.getElementById(sgt).getElementsByTagName("li");
			if(signature){
				for(var k in list_sgt){
					list_sgt[k].disabled = "true";
				}
			}
		}
	}
	

	function init_documenet(){
		var isEdit = '<s:property value="#parameters._isEdit"/>';
		var isFile = '<s:property value="#request.isFile"/>';
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
			window.setInterval("createOrUpdateWordFieldIsEdit()",1*60*60000);
		}
		Documentinit(isEdit, isFile, path);
	}

	function createOrUpdateWordFieldIsEdit(){
		var value =  '<s:property value="#parameters.filename"/>';
		WordFieldHelper.doCreateOrUpdateWordFieldIsEdit(value);
	}

	jQuery(document).ready(function(){
		OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
		if(OFFICE_CONTROL_OBJ != null && isIE){
			init_documenet();
			init_signature();
			ReAssignData();
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
	
	
	
	<body style="margin: 0;padding: 0;">
	<s:bean name="cn.myapps.util.UsbKeyUtil" id="UsbKeyUtil"></s:bean>
	  <form id="wordFrom" method="post" enctype="multipart/form-data" action='<s:url action ="uploadword.action" namespace="/portal/upload"/>'>
	  <div id="msg_isEdit" style="color:red"></div>
	      <input id="filename" type="hidden" value="<%=request.getParameter("filename")%>" />
		  <input id="type" type="hidden" value="<%=request.getParameter("_type")%>" />
		  <input id="wordid" type="hidden" value="<%=request.getParameter("id")%>" />
		  <input id="fieldname" type="hidden" value="<%=request.getParameter("fieldname")%>" />
		  <input id="content.versions" type="hidden" value="<%=request.getParameter("content.versions")%>" />
		  <input id="formname" type="hidden" value="<s:property value='#request.formname'/>"/>
		  <input id="_docid" type="hidden" value="<%=request.getParameter("_docid")%>" />
		  <input id="application" type="hidden" value="<%=request.getParameter("application")%>" />
	  <b><font color="red"><small>{*[page.only.support.ie]*}</small></font></b>
	  <!-- word控件显示 -->
      <div style="width:100%;">
        <!-- 套红、电子签章、模板操作 -->
        <div id="editmain_left" class="editmain_left" style="margin: 0;padding: 0;">
          <div class="funbutton">
            <ul class="ul" id="1">
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
              
          <div class="funbutton">
            <ul class="ul" id ="2">
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
           
          <div class="funbutton">
            <ul class="ul" id ="3">
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
        <div id="editmain_right" style="float:left;height:610px;white-space:nowrap;">
	      <script type="text/javascript" src="../../../script/word/ntkoofficecontrol.js"></script>
	      <div id=statusBar style="height:20px;width:100%;background-color:#c0c0c0;font-size:12px;"></div>
	      <script language="JScript" for=TANGER_OCX event="OnDocumentClosed()">
	          setFileOpenedOrClosed(false);
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
	      <script type="text/javascript">
	          var editmain_left=document.getElementById("editmain_left");
	          var editmain_right=document.getElementById("editmain_right");
              function rz_resize(){
                  editmain_right.style.width = document.body.clientWidth - editmain_left.clientWidth - 30;
           	  }
              rz_resize();
              window.onresize=rz_resize;
          </script>
	  </div>
	</form>
	</body>
</o:MultiLanguage>
</html>
