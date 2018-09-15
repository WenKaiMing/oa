<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.department.ejb.DepartmentVO"%>
<%@ page import="cn.myapps.util.property.DefaultProperty"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = DefaultProperty.getProperty("WEB_DOCPATH");
	String contextPath = request.getContextPath();
	path = contextPath + path;
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String departmentId = user.getDefaultDepartment();
	String departmentName = "";
	if(!"".equals(departmentId)){
		departmentName = user.getDepartmentById(departmentId).getName();
	} else {
		departmentName = "";
		for(DepartmentVO depart:user.getDepartments()){
			departmentId = depart.getId();
			departmentName = depart.getName();
			break;
		}
	}
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
	<link rel="stylesheet" href='<s:url value="/portal/share/css/wordfield.css"/>' type="text/css">
	<script type="text/javascript" src='<s:url value="/portal/share/script/json/json2.js"/>'></script>
	<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/WordFieldHelper.js"/>'></script>
	<script type="text/javascript" src='<s:url value="/portal/share/component/wordField/OfficeContorlFunctions.js"/>'></script>
	<script type="text/javascript">
	var contextPath = '<%=contextPath%>';
	var userName = '<s:property value="#session.FRONT_USER.name" />';
	var userId = '<s:property value="#session.FRONT_USER.id" />';
	var departmentId = '<%=departmentId%>';
	var departmentName = '<%=departmentName%>';
	var signature =  '<s:property value="#parameters.signature"/>';
	var _opentype = '<s:property value="#parameters._opentype"/>';
	var saveable = '<s:property value="#parameters.saveable"/>';
	var isEdit = 2;
	function init_signature(){
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
        var editmain_mid=document.getElementById("editmain_mid");
        var mid = document.body.clientWidth;
        if(!saveable || _opentype == "1"){
			jQuery("#actionTr").css("display","none");
        }
        if(isEdit==1){//isEdit为1表示只读状态
			jQuery("#actionTr").css("display","none");
			jQuery("#editmain_left").css("display","none");
        	mid -= jQuery("#editmain_right").width();
        	$(".sendopinion").hide();
        }else{
        	mid -= jQuery("#editmain_left").width();
        	mid -= jQuery("#editmain_right").width();
        }
        //editmain_mid.style.width = mid;
	}

	function init_documenet(){
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
	    rz_resize();
	    window.onresize=rz_resize;
		Documentinit(isEdit, isFile, path, _opentype);
		initOpinion();
	}

	function createOrUpdateWordFieldIsEdit(){
		var value =  '<s:property value="#parameters.filename"/>';
		WordFieldHelper.doCreateOrUpdateWordFieldIsEdit(value);
	}
	
	jQuery(document).ready(function(){

		OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
		//判断浏览器的类型
		var browser = getBrowser();
		if(OFFICE_CONTROL_OBJ != null && typeof(OFFICE_CONTROL_OBJ) == "object" && browser.indexOf("ie") >= 0){
			setTimeout(function(){
				init_documenet();
				init_signature();
				if(signature.indexOf("3") < 0){
					SetReviewMode(true);
				} else {
					SetReviewMode(false);
				}
			}, 1000);
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
		<table border="0" width="100%" id="actionTr">
			<tr align="left">
				<td width="50%"></td>
				<td width="50%"></td>
				<td class="line-position2">
					<button type="button" class="button-class" style="width:60px;" onClick="doSave()" id="wordsave">
					<img style="vertical-align:middle;" src="<s:url value="/resource/imgv2/front/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td class="line-position2">
					<button type="button" class="button-class" style="width:60px;padding:0;" onClick="doReturn();">
					<img style="vertical-align:middle;" src="<s:url value="/resource/imgv2/front/act/act_8.gif"/>">{*[Close]*}</button>
				</td>
			</tr>
		</table>
	      <input id="filename" type="hidden" value="<%=request.getParameter("filename")%>" />
		  <input id="type" type="hidden" value="<%=request.getParameter("_type")%>" />
		  <input id="wordid" type="hidden" value="<%=request.getParameter("id")%>" />
		  <input id="fieldname" type="hidden" value="<%=request.getParameter("fieldname")%>" />
		  <input id="content.versions" type="hidden" value="<%=request.getParameter("content.versions")%>" />
		  <input id="formname" type="hidden" value="<s:property value='#request.formname'/>"/>
		  <input id="_docid" type="hidden" value="<%=request.getParameter("_docid")%>" />
		  <input id="application" type="hidden" value="<%=request.getParameter("application")%>" />
		  <script type="text/javascript">
		  if(getBrowser().indexOf("ie") < 0){
			  document.write('<b><font color="red"><small>{*[page.only.support.ie]*}</small></font></b>');
		  }
		  </script>
	  <!-- word控件显示 -->
      <div style="width:100%;">
        <!-- 套红、电子签章、模板操作 -->
        <div id="editmain_left" class="editmain_left" style="margin: 0;padding: 0;">
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
              
          <div class="funbutton" id ="2">
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
           
          <div class="funbutton"  id ="3">
            <ul class="ul">
              <li class="listtile">{*[trace.function]*}:</li>
              <li onclick="setShowRevisions(true);">{*[show.trace]*}</li>
              <li onclick="setShowRevisions(false);">{*[hide.trace]*}</li>
            </ul>
          </div>
        </div>
        
        <!-- Word文档 -->
        <div id="editmain_mid" style="float: left;height:610px;white-space:nowrap;">
	      <script type="text/javascript" src='<s:url value="/portal/share/component/wordField/OfficeControl/ntkoofficecontrol.js"/>'></script>
	      <div id=statusBar style="height:20px;width:100%;background-color:#c0c0c0;font-size:12px;"></div>
	      <script language="JScript" for=TANGER_OCX event="OnDocumentClosed()">
	          setFileOpenedOrClosed(false);
	      </script>
	      <script language="JScript" for="TANGER_OCX" event="OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)">
	      if(OFFICE_CONTROL_OBJ != null){  
		      OFFICE_CONTROL_OBJ.ActiveDocument.saved=true;//saved属性用来判断文档是否被修改过,文档打开的时候设置成ture,当文档被修改,自动被设置为false,该属性由office提供.
			    //获取文档控件中打开的文档的文档类型
			    fileType = "Word.Document";
			    fileTypeSimple = "word";
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
	    <!-- 添加意见栏 -->
	    <div id="editmain_right" class="editmain_right">
	    	<!-- FIXME 下面这个div需要改 -->
		    <div id="opinion" class="opinion">
		    	<div style="margin: 0 auto;">历史意见</div>
		    	<div id="content-1">
		    	
		    		<div class="comments">
						
					</div>
		    	</div>
		    	<div class="sendopinion">
					<textarea id="content-2" rows="8" cols="" placeholder="请输入意见"></textarea>
					<!-- 下面触发事件改用回车 -->
					<input type="button" onclick="javascript:updateWordField()" value="确定" class="sure"/>
		    	</div>
		    </div>
	    </div>
	  </div>
	</form>
	</body>
</o:MultiLanguage>
</html>
