<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:bean name="cn.myapps.core.security.action.LoginHelper" id="lh" />
<!DOCTYPE html>
<html>
<head>
<title>Office Anywhere 2013 增强版 网络智能办公系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="stylesheet" type="text/css" href="resource/login/login.css"/>
<link rel="shortcut icon" href="/resource/login/teemlink.ico" />

<script type="text/javascript">
function CheckForm()
{
   return true;
}

</script>
</head>
<body onload="javascript:document.form1.username.focus();" scroll="auto">

<s:form name="form1" method="post" action="/portal/login/login.action" autocomplete="off" onsubmit="return CheckForm();" theme="simple">
<div id="logo">
   <div id="form">
      <div class="left">
         <div class="user">
         <input type="hidden" name="domainName"  value="<s:property value='#lh.getDomainNameList().get(0)'/>">
        <input type="text" class="text" name="username" maxlength="20" onmouseover="this.focus()" onfocus="this.select()" value=""></div>
         <div class="pwd">
           <input type="password" class="text" name="password" onmouseover="this.focus()" onfocus="this.select()" value="" />
        </div>
		       <div class="right">
         <input type="submit" class="submit" title="登录" value="" />
      </div>
      </div>
   </div>
   </div>
</div>

</s:form>
<div align="center" class="msg">
   <div></div>
   <div></div>
   <div></div>
   <div>
<script language="JavaScript">
var allEmements=document.getElementsByTagName("*");
for(var i=0;i<allEmements.length;i++)
{
   if(allEmements[i].tagName && allEmements[i].tagName.toLowerCase()=="iframe")
   {
      document.write("<div align='center' style='color:red;'><br><br><h2>OA提示：</h2><br><br>您的电脑可能感染了病毒或木马程序，请联系OA软件开发商寻求解决办法或下载360安全卫士查杀。<br>病毒网址（请勿访问）：<b><u>"+allEmements[i].src+"</u></b></div>");
      allEmements[i].src="";
   }
}
</script></div>
</div>
</body>
</html>