var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}

var config;
try{
	config = dialogArguments.config;
}
catch(e){
}


function BaseTrim(str){
	  lIdx=0;rIdx=str.length;
	  if (BaseTrim.arguments.length==2)
	    act=BaseTrim.arguments[1].toLowerCase()
	  else
	    act="all"
      for(var i=0;i<str.length;i++){
	  	thelStr=str.substring(lIdx,lIdx+1)
		therStr=str.substring(rIdx,rIdx-1)
        if ((act=="all" || act=="left") && thelStr==" "){
			lIdx++
        }
        if ((act=="all" || act=="right") && therStr==" "){
			rIdx--
        }
      }
	  str=str.slice(lIdx,rIdx)
      return str
}

function BaseAlert(theText,notice){
	alert(notice);
	theText.focus();
	theText.select();
    	return false;
}

function IsColor(color){
	var temp=color;
	if (temp=="") return true;
	if (temp.length!=7) return false;
	return (temp.search(/\#[a-fA-F0-9]{6}/) != -1);
}

function IsDigit(){
  return ((event.keyCode >= 48) && (event.keyCode <= 57));
}

function SelectColor(what){
	var dEL = document.all("d_"+what);
	var sEL = document.all("s_"+what);
	var url = "selcolor.jsp?color="+encodeURIComponent(dEL.value);
	var arr = showModalDialog(url,window,"dialogWidth:280px;dialogHeight:300px;help:no;scroll:no;status:no");
	if (arr) {
		dEL.value=arr;
		sEL.style.backgroundColor=arr;
	}
}

function SelectImage(){
	showModalDialog("backimage.jsp?action=other",window,"dialogWidth:350px;dialogHeight:210px;help:no;scroll:no;status:no");
}

function SearchSelectValue(o_Select, s_Value){
	for (var i=0;i<o_Select.length;i++){
		if (o_Select.options[i].value == s_Value){
			o_Select.selectedIndex = i;
			return true;
		}
	}
	return false;
}

function ToInt(str){
	str=BaseTrim(str);
	if (str!=""){
		var sTemp=parseFloat(str);
		if (isNaN(sTemp)){
			str="";
		}else{
			str=sTemp;
		}
	}
	return str;
}

function IsURL(url){
	var sTemp;
	var b=true;
	sTemp=url.substring(0,7);
	sTemp=sTemp.toUpperCase();
	if ((sTemp!="HTTP://")||(url.length<10)){
		b=false;
	}
	return b;
}

function IsExt(url, opt){
	var sTemp;
	var b=false;
	var s=opt.toUpperCase().split("|");
	for (var i=0;i<s.length ;i++ ){
		sTemp=url.substr(url.length-s[i].length-1);
		sTemp=sTemp.toUpperCase();
		s[i]="."+s[i];
		if (s[i]==sTemp){
			b=true;
			break;
		}
	}
	return b;
}

function GetHttpUrl(url){
	if (url.substring(0,1)=="/"){
		return (document.location.protocol + '//' + document.location.host + url);
	}
	var sURL=document.URL;
	return sURL.substring(0,sURL.lastIndexOf("/dialog/")+1)+url;
}




function GetAppUrl(){
   var sURL=document.URL;
   var intlocation = sURL.indexOf("//");
   sURL = sURL.substring(intlocation+2);
   var  intloca1 = sURL.indexOf('/');
   sURL = sURL.substring(intloca1+1);
  var intloca2 = sURL.indexOf('/');
   sURL = sURL.substring(0,intloca2);
   sURL = '/'+sURL;
  	return sURL;


}

function GetUploadUrl(appname)
{

  var sURL = document.URL;
  var intlocation = sURL.indexOf(appname);
  sURL = sURL.substring(0,intlocation)+appname+'/uploads/resource/';
   return sURL;
  
}

function resize() {
	//alert("document.body.scrollHeight----> " + document.body.scrollHeight);
	//alert("window.dialogHeight----> " + window.dialogHeight);
	
	window.dialogHeight = (document.body.scrollHeight + 30) + 'px';
	
	//alert("document.body.scrollWidth----> " + document.body.scrollWidth);
	//alert("window.dialogWidth----> " + window.dialogWidth);
	window.dialogWidth = (document.body.scrollWidth + 25) + 'px';
}

function HTMLEncode(text) {
	var textold;
	do {
		textold = text;
		
		text = text.replace(/&/g, "@amp;") ;
		text = text.replace(/"/g, "@quot;") ;
		text = text.replace(/</g, "@lt;") ;
		text = text.replace(/>/g, "@gt;") ;
		text = text.replace(/'/g, "@#146;") ;
		text = text.replace(/\ /g,"@nbsp;");
		text = text.replace(/\r/g,'&#10;');
		text = text.replace(/\n/g,'&#13;');
	} while (textold != text);

	return text;
}

function HTMLDencode(text) {
	var textold;
	do {
		textold = text;
		
		text = text.replace("@amp;", "&");
		text = text.replace('@quot;', '"');
		text = text.replace("@lt;", "<");
		text = text.replace("@gt;", ">");
		text = text.replace("@#146;", "'");
		text = text.replace("@nbsp;", " ");
		text = text.replace("&nbsp;", " ");
		text = text.replace("&#10;", "\r");
		text = text.replace("&#13;", "\n");
	} while (textold != text);
	return text;
}