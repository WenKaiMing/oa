<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>插入表情</title>
<style>
#magicface{}
#magicface td{ height:29px; width:29px; background-color:#F8F8F8; text-align:center;}
#magicface td onmouseover{background-Color:#FFcccc;} 
#nav td{font-size:12px;}
.mf_nowchose{ height:30px; background-color:#DFDFDF;border:1px solid #B5B5B5; border-left:none;}
.mf_other{ height:30px;border-left:1px solid #B5B5B5; }
.mf_otherdiv{ height:30px; width:30px;border:1px solid #FFF; border-right-color:#D6D6D6; border-bottom-color:#D6D6D6; background-color:#F8F8F8;padding-top:10px;cursor:hand;}
.mf_otherdiv2{ height:30px; width:30px;border:1px solid #B5B5B5; border-left:none; border-top:none;}
.mf_link{ font-size:12px; color:#000000; text-decoration:none;}
.mf_link:hover{ font-size:12px; color:#000000; text-decoration:underline;}

</style>
<script language=javascript src="script/samedomain.js"></script>
<SCRIPT language="JavaScript">
<!--
var contextPath = '<%=request.getContextPath()%>';
var faceTips = new Array();
faceTips[faceTips.length] = "微笑";
faceTips[faceTips.length] = "开怀笑";
faceTips[faceTips.length] = "哭泣" ;
faceTips[faceTips.length] = "失望" ;
faceTips[faceTips.length] = "困了" ;
faceTips[faceTips.length] = "好好笑" ;
faceTips[faceTips.length] = "啵" ;
faceTips[faceTips.length] = "电到了" ;
faceTips[faceTips.length] = "汗" ;
faceTips[faceTips.length] = "流口水了" ;
faceTips[faceTips.length] = "真困啊" ;
faceTips[faceTips.length] = "我吐" ;
faceTips[faceTips.length] = "眨眼" ;
faceTips[faceTips.length] = "？？？" ;
faceTips[faceTips.length] = "嘘" ;
faceTips[faceTips.length] = "砸死你" ;
faceTips[faceTips.length] = "不说" ;
faceTips[faceTips.length] = "坏" ;
faceTips[faceTips.length] = "色迷迷" ;
faceTips[faceTips.length] = "教训" ;
faceTips[faceTips.length] = "可爱" ;
faceTips[faceTips.length] = "YEAH" ;
faceTips[faceTips.length] = "崩溃" ;
faceTips[faceTips.length] = "惊讶" ;
faceTips[faceTips.length] = "鄙视" ;
faceTips[faceTips.length] = "开心" ;
faceTips[faceTips.length] = "仰慕你" ;
faceTips[faceTips.length] = "晕" ;
faceTips[faceTips.length] = "挖鼻孔" ;
faceTips[faceTips.length] = "撒娇" ;
faceTips[faceTips.length] = "鼓掌" ;
faceTips[faceTips.length] = "害羞" ;
faceTips[faceTips.length] = "老大" ;
faceTips[faceTips.length] = "欠揍" ;
faceTips[faceTips.length] = "吐舌笑脸" ;
faceTips[faceTips.length] = "飞吻" ;
faceTips[faceTips.length] = "工作忙" ;
faceTips[faceTips.length] = "大哭" ;
faceTips[faceTips.length] = "偷偷笑" ;
faceTips[faceTips.length] = "送花给你" ;
faceTips[faceTips.length] = "来，亲一个" ;
faceTips[faceTips.length] = "拍桌子" ;
faceTips[faceTips.length] = "拜拜" ;
faceTips[faceTips.length] = "得意的笑" ;
faceTips[faceTips.length] = "生气" ;
faceTips[faceTips.length] = "怕怕" ;
faceTips[faceTips.length] = "尴尬" ;
faceTips[faceTips.length] = "难过" ;
faceTips[faceTips.length] = "我是男生" ;
faceTips[faceTips.length] = "我是女生" ;
faceTips[faceTips.length] = "玫瑰" ;
faceTips[faceTips.length] = "好爱你" ;
faceTips[faceTips.length] = "心碎了" ;
faceTips[faceTips.length] = "亲亲" ;
faceTips[faceTips.length] = "NO" ;
faceTips[faceTips.length] = "YES" ;
faceTips[faceTips.length] = "握个手" ;
faceTips[faceTips.length] = "到点了" ;
faceTips[faceTips.length] = "音乐" ;
faceTips[faceTips.length] = "CALL我" ;
faceTips[faceTips.length] = "带血的刀" ;
faceTips[faceTips.length] = "炸弹" ;
faceTips[faceTips.length] = "有了" ;
faceTips[faceTips.length] = "好晚了" ;
faceTips[faceTips.length] = "吸血蝙蝠" ;
faceTips[faceTips.length] = "便便" ;
faceTips[faceTips.length] = "干一杯" ;
faceTips[faceTips.length] = "抽烟" ;
faceTips[faceTips.length] = "打电话" ;
faceTips[faceTips.length] = "家" ;
faceTips[faceTips.length] = "车子" ;
faceTips[faceTips.length] = "礼物" ;
faceTips[faceTips.length] = "金钱" ;
faceTips[faceTips.length] = "太阳" ;
faceTips[faceTips.length] = "下雨" ;
faceTips[faceTips.length] = "猪猪" ;
faceTips[faceTips.length] = "小猫" ;
faceTips[faceTips.length] = "小狗" ;
faceTips[faceTips.length] = "骨头" ;
faceTips[faceTips.length] = "喝水" ;
faceTips[faceTips.length] = "汉堡" ;
faceTips[faceTips.length] = "包子" ;
faceTips[faceTips.length] = "西瓜" ;
faceTips[faceTips.length] = "约会" ;
var baozTips = new Array();
baozTips[0] = "";
baozTips[1] = "";
baozTips[2] = "";
baozTips[3] = "";
baozTips[4] = "";
baozTips[5] = "";
baozTips[6] = "";
baozTips[7] = "";
baozTips[8] = "";
baozTips[9] = "";
baozTips[10] = "";
baozTips[11] = "";
baozTips[12] = "";
baozTips[13] = "";
baozTips[14] = "";
baozTips[15] = "";
baozTips[16] = "";
baozTips[17] = "";
baozTips[18] = "";
baozTips[19] = "";
baozTips[20] = "";
baozTips[21] = "";
baozTips[22] = "";
baozTips[23] = "";
baozTips[24] = "";
baozTips[25] = "";
baozTips[26] = "";
baozTips[27] = "";
baozTips[28] = "";
baozTips[29] = "";
baozTips[30] = "";
baozTips[31] = "";
baozTips[32] = "";
baozTips[33] = "";
baozTips[34] = "";
baozTips[35] = "";
baozTips[36] = "";
baozTips[37] = "";
baozTips[38] = "";
baozTips[39] = "";
baozTips[40] = "";
baozTips[41] = "";
baozTips[42] = "";
baozTips[43] = "";
baozTips[44] = "";
baozTips[45] = "";
baozTips[46] = "";
baozTips[47] = "";
baozTips[48] = "";
baozTips[49] = "";
baozTips[50] = "";
baozTips[51] = "";
baozTips[52] = "";
baozTips[53] = "";
baozTips[54] = "";
baozTips[55] = "";
baozTips[56] = "";
baozTips[57] = "";
baozTips[58] = "";
baozTips[59] = "";
baozTips[60] = "";
baozTips[61] = "";
baozTips[62] = "";
baozTips[63] = "";
baozTips[64] = "";
baozTips[65] = "";
baozTips[66] = "";
baozTips[67] = "";
baozTips[68] = "";
baozTips[69] = "";
baozTips[70] = "";
baozTips[71] = "";
baozTips[72] = "";
baozTips[73] = "";
baozTips[74] = "";
baozTips[75] = "";
baozTips[76] = "";
baozTips[77] = "";
baozTips[78] = "";
baozTips[79] = "";
baozTips[80] = "";
baozTips[81] = "";
baozTips[82] = "";
baozTips[83] = "";
var popoTips = new Array();
popoTips[0]="";
popoTips[1]="";
popoTips[2]="";
popoTips[3]="";
popoTips[4]="";
popoTips[5]="";
popoTips[6]="";
popoTips[7]="";
popoTips[8]="";
popoTips[9]="";
popoTips[10]="";
popoTips[11]="";
popoTips[12]="";
popoTips[13]="";
popoTips[14]="";
popoTips[15]="";
popoTips[16]="";
popoTips[17]="";
popoTips[18]="";
popoTips[19]="";
popoTips[20]="";
popoTips[21]="";
popoTips[22]="";
popoTips[23]="";
var bearTips = new Array();
bearTips[0]="";
bearTips[1]="";
bearTips[2]="";
bearTips[3]="";
bearTips[4]="";
bearTips[5]="";
bearTips[6]="";
bearTips[7]="";
bearTips[8]="";
bearTips[9]="";
bearTips[10]="";
bearTips[11]="";
bearTips[12]="";
bearTips[13]="";
bearTips[14]="";
bearTips[15]="";
bearTips[16]="";
bearTips[17]="";
bearTips[18]="";
bearTips[19]="";
bearTips[20]="";
bearTips[21]="";
bearTips[22]="";
bearTips[23]="";
bearTips[24]="";
bearTips[25]="";
bearTips[26]="";
bearTips[27]="";
bearTips[28]="";
bearTips[29]="";
bearTips[30]="";
function p(count, name, path, pageCount){
	this.count = count;
	this.name = name;
	this.path = path;
	this.pageCount = Math.ceil(count/(row*col))-1;
}
var current = new Object();
var filePath = contextPath + "/portal/share/component/htmlEditor/pictures/";
var preWidth = 54;
var start = "face";
var row = 6;
var col = 10;
var tips = new Object();
tips["face"] = faceTips;
tips["baoz"] = baozTips;
tips["popo"] = popoTips;
tips["bear"] = bearTips;
var all = [
	(new p(84,	"泡泡",	"face")),
	(new p(84,	"包子",	"baoz")),
	(new p(24,	"球球",	"popo")),
	(new p(31,	"小熊",	"bear"))
];
window.onload = function(){
	fSetNav();
	current.type = start;
	current.page = 0;
	change(start);
};
function fSetNav(){
	var nav = jQuery("#nav");
	for(var i=0;i<all.length;i++){
		var tr = nav.insertRow(nav.rows.length-2);
		var td = tr.insertCell(-1);
		td.id = all[i].path;
		td.height = "31";
		td.vAlign = "middle";
		td.className = "mf_other";
		td.innerHTML = '<div class="mf_otherdiv2"><div class="mf_otherdiv" onclick="go(\''+all[i].path  +'\')">'+ all[i].name +'</div></div>';
	}
}
function go(type){
	current.type = type;
	current.page = 0;
	change(type);
}
function change(type){
	fChangeTag(type);
	fFillPic(type);
	fGetPage(type);
}
function fGetPage(type){
	var page = jQuery("#page");
	var obj = fGetTypeObj(type);
	page.html((current.page+1) + '/'+ (obj.pageCount+1) +((current.page != 0)?' &nbsp;<a href="#" class="mf_link" onclick="prePage()">上页</a>':'') + ((current.page != obj.pageCount)?'&nbsp;<a href="#" class="mf_link" onclick="nextPage()">下页</a>':''));
}
function nextPage(){
	var obj = fGetTypeObj(current.type);
	if(current.page != obj.pageCount){
		current.page ++;
	}
	change(current.type);
}
function prePage(){
	var obj = fGetTypeObj(current.type);
	if(current.page != 0){
		current.page --;
	}
	change(current.type);
}
function fFillPic(type){
	var count = fGetCurrentPageCount(type,current.page);
	var countStart = current.page * row * col;
	var content = jQuery("#content");
	var n = 0;
	for(var i=content.find("tr").length-1;i>-1;i--){
		content.deleteRow(i);
	}
	for(var i=0;i<row;i++){
		if(n == count) break;
		var tr = content.insertRow(-1);
		for(var j=0;j<col;j++){
			if(n == count) break;
			var td = tr.insertCell(-1);
			td.innerHTML = '<div style=" width:27px; height:22px; padding-top:5px;text-align:center;" onmouseover="fMouseOver(this,'+ n +')" onmouseout="fMouseOut(this,'+ n +')"><a href="#"><img src="'+ filePath + type + "/" + (countStart + n) +'.gif" width="19" height="19" title="'+ tips[type][countStart + n] +'" border="0" onclick="MouseClick(this.src);"></a></div>';
			n ++;
		}
	}
}
function fMouseOver(obj,n){
	obj.style.border='1px solid #000000';
	var preview = jQuery("#preview");
	var countStart = current.page * row * col;
	preview.html('<table width="60" height="60" bgcolor="white"><tr><td align="center" valign="middle"><img src='+ filePath + current.type + "/" + (countStart + n) +'.gif></td></tr></table>');
	var pos = obj.parentNode.cellIndex;
	var x = f_GetX(jQuery("#content"));
	var y = f_GetY(jQuery("#content"));
	if(Math.round(pos/col)){
		preview.css("left",x + "px");
	}else{
		preview.css("left",(x + jQuery("#content").width() - preview.width()) + "px");
	}
	preview.css("top",y + "px");
}
function fMouseOut(obj,n){
	obj.style.border='';
	var preview = jQuery("#preview");
	preview.html("");
}
function fChangeTag(type){
	for(var i=0;i<all.length;i++){
		var td = jQuery("#"+ all[i].path);
		if(all[i].path == type){
			td.attr("class","mf_nowchose");
			td.html(all[i].name);
		}else{
			td.height(31);
			td.css("vAlign","middle");
			td.attr("class","mf_other");
			td.html('<div class="mf_otherdiv2"><div class="mf_otherdiv" onclick="go(\''+all[i].path  +'\')">'+ all[i].name +'</div></div>');
		}
	}
}
function fGetCurrentPageCount(type,page){
	for(var i=0;i<all.length;i++){
		if(all[i].path == type){
			var count = all[i].count;
			var pageCount = all[i].pageCount;
			if(page == pageCount){
				return count%(row*col);
			}else{
				return row*col;
			}
		}
	}
}
function fGetTypeObj(type){
	for(var i=0;i<all.length;i++){
		if(all[i].path == type){
			return all[i];
		}
	}
}
function $(id){
	return document.getElementById(id);
}
function f_GetX(e)
{
	var l=e.offsetLeft;
	while(e=e.offsetParent){				
		l+=e.offsetLeft;
	}
	return l;
}
function f_GetY(e)
{
	var t=e.offsetTop;
	while(e=e.offsetParent){
		t+=e.offsetTop;
	}
	return t;
}
function MouseClick( src )
{	
	if (src != null){
		//var index = src.lastIndexOf("/");
		//var file = src.substring(index);
		//src = src.replace(file, "/preview" + file);
		window.parent.format("InsertImage", src);
	}
	var div = window.parent.document.getElementById("dvPortrait");
	div.style.display = "none";
	// div.parentNode.removeChild(div);
    // window.returnValue = src;
    // window.close();
}
//-->
</SCRIPT>
</head>

<body>
<table width="350" height="210" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="308" height="200" valign="top" bgcolor="#DFDFDF" id="magicface" style="border:1px solid #B5B5B5; border-right:none; padding:3px;"><div style="height:182px;"><table width="301" border="0" cellspacing="1" cellpadding="0" id="content">
    </table></div>
	<div style="background-color:#DFDFDF;line-height:10px; height:0px; text-align:right; width:290px; font-size:12px; padding:6px 10px 0px 0px;" id="page"></div></td>
    <td width="42" valign="top"><table width="100%" height="200"  border="0" cellpadding="0" cellspacing="0" id="nav">
      <tr>
        <td style="border-left:1px solid #B5B5B5; line-height:5px; ">&nbsp;</td>
      </tr>
      <tr>
        <td height="83"  style="border-left:1px solid #B5B5B5; line-height:83px; ">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
<div id="preview" style="position:absolute;z-index:9"></div>
</body>
</html>