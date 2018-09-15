<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/tags.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<title>JavaScript Debuger</title>
	<LINK title=Style href="css/style.css" type=text/css rel=stylesheet>
	<LINK title=Style href="css/style-ie.css" type=text/css rel=stylesheet>
	<link rel="stylesheet" href="<s:url value='/resource/css/style.jsp'/>" />
	<LINK href="css/SyntaxHighlighter.css" type=text/css rel=stylesheet></LINK>

	<script src='<s:url value="/dwr/interface/DebugGui.js"/>'></script>
	<script src='<s:url value="/dwr/engine.js"/>'></script>
	<script src='<s:url value="/dwr/util.js"/>'></script>

	<script>
var isDebugging = false; // 是否进入代码调试

function lock(b){
	document.getElementsByName('refresh')[0].disabled = b;
	document.getElementsByName('go')[0].disabled = b;
	document.getElementsByName('debug')[0].disabled = b;
	document.getElementsByName('currLine')[0].disabled = b;
	document.getElementsByName('code')[0].disabled = b;
	document.getElementsByName('StepOver')[0].disabled = b;
	document.getElementsByName('StepOut')[0].disabled = b;
	document.getElementsByName('StepInto')[0].disabled = b;
}

function setDebugModule(b) {
	//DebugGui.setDebugModule(b);
	DebugGui.setDebugModule(b ,function(frame){writeCode(frame);lock(false);});
}

function getDebugCookie() { 
  return documents.cookie;
}

function writeCode(frame) {
	if (frame) {
		var js = frame.source;
		var currLine = frame.lineNumber;
		var field = document.getElementsByName("code")[0];
		document.getElementsByName('currLine')[0].value = currLine;
		field.innerText = js;
		
		//alert(document.readyState);
		
		var editor = getSWF('SWFCodeEditor');

		if (editor){
			if (js) {
				editor.setText(js);
				editor.goLine(0);
			}
			if (currLine > 0) {
				isDebugging = true;
				editor.goLine(currLine-1);
			}
		}
		
		/*if (currLine < 0) {
			if (isDebugging) {
				parent.switchWindow('client'); // 切换回主窗口
				isDebugging = false;
			}
		}*/
	}
}

function getSWF(movieName) {
	if (navigator.appName.indexOf("Microsoft") != -1) {
		return window[movieName];
	} else {
		return document[movieName];
	}
} 

function evalExpr(expr) {
	if (expr) {
		lock(true);
		DebugGui.evalExpr(expr,function(s){alert(s);lock(false);});
	}
}

function go() {
	lock(true);
	DebugGui.actionPerformed("Go",function(frame){writeCode(frame);lock(false);});
}

function stepover() {
	lock(true);
	DebugGui.actionPerformed("Step Over",function(frame){writeCode(frame);lock(false);});
}

function stepinto() {
	lock(true);
	DebugGui.actionPerformed("Step Into",function(frame){writeCode(frame);lock(false);});
}

function stepout() {
	lock(true);
	DebugGui.actionPerformed("Step Out",function(frame){writeCode(frame);lock(false);});
}

function refresh(isInit) {
	lock(true);
	DebugGui.isDebugModule(function(debug){document.getElementsByName('debug')[0].checked = debug;});
	DebugGui.viewDebugFrameInfo("", function(frame){
		if (!isInit) {
			if (document.getElementsByName('debug')[0].checked) {
				writeCode(frame);
			}
		}
		
		lock(false);
	});
}

</script>
	<style>
button {
	border: 0px solid white;
	background-color: #dfe8f6;
	vertical-align: middle;
	height: 20px;
	line-height: 20px;
	cursor: pointer;
}
</style>
	</head>
	<body onload="refresh(true)" class="body-front">
	<table class="act_table" width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td>
			<!-- Button Refresh -->
			<span class='button-dis'>
			<a href="###" name='refresh' title='Refresh' onclick="refresh()" onmouseover='this.className="button-onchange"' onmouseout='this.className="button-dis"' >
			<span><img style='border:0px solid blue;vertical-align:middle;' src='<s:url value='/resource/imgv2/back/debugger/refresh.gif'/>' />&nbsp;{*[Refresh]*}</span></a>
			</span>
			<span style='vertical-align:middle'><img style='float:left; vertical-align:middle;' src='<s:url value="/resource/imgv2/front/main/act_seperate.gif" />'></span>
			
			<!-- Button Go -->
			<span class='button-dis'>
			<a href="###" name='go' title='Go' onclick="go()" onmouseover='this.className="button-onchange"' onmouseout='this.className="button-dis"' >
			<span><img style='border:0px solid blue;vertical-align:middle;' src='<s:url value='/resource/imgv2/back/debugger/go.gif'/>' />&nbsp;{*[cn.myapps.core.macro.debuger.go]*}</span></a>
			</span>
			<span style='vertical-align:middle'><img style='float:left; vertical-align:middle;' src='<s:url value="/resource/imgv2/front/main/act_seperate.gif" />'></span>
			
			<!-- Button StepOver -->
			<span class='button-dis'>
			<a href="###" name='StepOver' title='StepOver' onclick="stepover()" onmouseover='this.className="button-onchange"' onmouseout='this.className="button-dis"' >
			<span><img style='border:0px solid blue;vertical-align:middle;' src='<s:url value='/resource/imgv2/back/debugger/step_over.gif'/>' />&nbsp;{*[cn.myapps.core.macro.debuger.step_over]*}</span></a>
			</span>
			<span style='vertical-align:middle'><img style='float:left; vertical-align:middle;' src='<s:url value="/resource/imgv2/front/main/act_seperate.gif" />'></span>
			
			<!-- Button StepInto -->
			<span class='button-dis'>
			<a href="###" name='StepInto' title='StepInto' onclick="stepinto()" onmouseover='this.className="button-onchange"' onmouseout='this.className="button-dis"' >
			<span><img style='border:0px solid blue;vertical-align:middle;' src='<s:url value='/resource/imgv2/back/debugger/step_into.gif'/>' />&nbsp;{*[cn.myapps.core.macro.debuger.step_into]*}</span></a>
			</span>
			<span style='vertical-align:middle'><img style='float:left; vertical-align:middle;' src='<s:url value="/resource/imgv2/front/main/act_seperate.gif" />'></span>
			
			<!-- Button StepOut -->
			<span class='button-dis'>
			<a href="###" name='StepOut' title='StepOut' onclick="stepout()" onmouseover='this.className="button-onchange"' onmouseout='this.className="button-dis"' >
			<span><img style='border:0px solid blue;vertical-align:middle;' src='<s:url value='/resource/imgv2/back/debugger/step_out.gif'/>' />&nbsp;{*[cn.myapps.core.macro.debuger.step_out]*}</span></a>
			</span>
			<span style='vertical-align:middle'><img style='float:left; vertical-align:middle;' src='<s:url value="/resource/imgv2/front/main/act_seperate.gif" />'></span>
			
			<input type='checkbox' name='debug' value='true'
				onclick='setDebugModule(this.checked)' /> {*[Debug]*}</td>
		</tr>
		<tr>
			<td><b>{*[cn.myapps.core.macro.debuger.line_number]*}</b>&nbsp;：<input type='text' name='currLine' /></td>
		</tr>
	</table>

	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
		id="SWFCodeEditor" width="100%" height="58%"
		codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
		<param name="movie" value="SWFCodeEditor.swf" />
		<param name="quality" value="high" />
		<param name="bgcolor" value="#869ca7" />
		<param name="allowScriptAccess" value="sameDomain" />
		<embed src="SWFCodeEditor.swf" quality="high" bgcolor="#869ca7"
			width="100%" height="60%" name="SWFCodeEditor" align="middle"
			play="true" loop="false" quality="high"
			allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
			pluginspage="http://www.adobe.com/go/getflashplayer">
		</embed> </object>
	<p></p>
	<table width="100%" height="30%" cellpadding="0" cellspacing="0" border="0">
	<tr height="60%">
		<td>
			<textarea id='exprid' name='expr' style="width: 100%;height:100%"></textarea>
		</td>
	</tr>
	<tr>
		<td>
			<input type='button' name='Eval' value='Expression Eval' onclick='evalExpr(document.getElementById("exprid").value)' />
		</td>
	</tr>
		<tr style="display: none">
			<td>
			<DIV>代码
			<div id="code" class=JScript name="code"></div>
			</DIV>
			</td>
		</tr>
	</table>
	</body>
</o:MultiLanguage>
</html>