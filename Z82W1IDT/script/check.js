var fields = new Array();
var errorstr = new Array();
errorstr[11] = '格式不正确';
errorstr[12] = '月份超出范围';
errorstr[13] = '字符串过长';
errorstr[14] = '不是数字';
errorstr[15] = '数值过大';
errorstr[16] = '数值过小';

function checkval(ckdoc) //ckdoc应该是一个window对象
{

  //这里对fields中定义的变量进行检查
  var i;
  var iscorrect = true;
  var isitemcorrect = 1;
  var elvalue = null;
  var alertstr = "";

  for(i=0;i<fields.length;i++)
  {
    isitemcorrect = true;
    fields[i].val = "";

    if(fields[i] != null && fields[i].name != null)
    {
      if(ckdoc.document.getElementById(fields[i].name) == null)
        continue;
      elvalue = ckdoc.document.getElementById(fields[i].name).value;
    }
    else
      continue;

    if(elvalue == null || elvalue == "")
    {
      if(fields[i].defaultval != null && fields[i].defaultval != "")
        elvalue = ckdoc.document.getElementById(fields[i].name).value = fields[i].defaultval;
      if(fields[i].isnull)
        continue;
      else
      {
        alertstr += '请输入“' + fields[i].cnname + '”!\n';
        iscorrect = false;
        continue;
      }
    }

    switch(fields[i].type)
    {
      case 'c'  :
        isitemcorrect = ischar(elvalue,fields[i].len1);
        break;
      case 'i'  :
        isitemcorrect = isint(elvalue,fields[i].len1);
        if(isitemcorrect == 1)
          isitemcorrect = compval(elvalue,fields[i]);
        break;
      case 'l'  :
        isitemcorrect = islong(elvalue,fields[i].len1);
        if(isitemcorrect == 1)
          isitemcorrect = compval(elvalue,fields[i]);
        break;
      case 'd'  :
        isitemcorrect = isdouble(elvalue,fields[i].len1,fields[i].len2);
        if(isitemcorrect == 1)
          isitemcorrect = compval(elvalue,fields[i]);
        break;
      case 'f'  :
        isitemcorrect = isfloat(elvalue,fields[i].len1,fields[i].len2);
        if(isitemcorrect == 1)
          isitemcorrect = compval(elvalue,fields[i]);
        break;
      case 't'  :
        isitemcorrect = validatedate(elvalue);
        break;
      case 'dt'  :
        isitemcorrect = validatedatetime(elvalue);
				break;
			case 'tt'  :
				isitemcorrect = validatetime(elvalue);
				break;
			case 'm'  :
				isitemcorrect = ismail(elvalue,fields[i].len1);
				break;
			default	  :
				isitemcorrect = 0;
    }
    if(isitemcorrect != 1)
    {
      alertstr += '输入项“' + fields[i].cnname + '”' + errorstr[isitemcorrect] + '\n';
      iscorrect = false;
    }
    else
      fields[i].val = elvalue;
  }
  if(!iscorrect)
    alert(alertstr);

  fields = new Array();
  return iscorrect;
}

function addfield(name,cnname,type,isnull,len1,len2,defaultval,minval,maxval)
{
  var len = fields.length;
  fields[len] = new Object;
  fields[len].name = name;
  fields[len].cnname = cnname;
  fields[len].isnull = isnull;		//是否可以为空值 boolean
  fields[len].type = type;  			//类型可以分别为：'c','f','d','i','l','t','m',其中'm'类型为电子邮件地址
  fields[len].len1= len1;   			//对于类型为'c','i','t'，只使用len1,'f'和'd'使用len1和len2
  fields[len].len2 = len2;
  fields[len].defaultval = defaultval;//暂时没有用处，置为空
  fields[len].minval	= minval;		//本值只用于数值型
  fields[len].maxval	= maxval;		//本值只用于数值型
}

function validatedate( strValue )
{
  /*
  strValue must be as:  yyyy/mm/dd or yyyy-mm-dd or yyyy.mm.dd
  */
  var objRegExp = /^\d{4}(\-|\/|\.)\d{1,2}(\-|\/|\.)\d{1,2}$/;
  if(!objRegExp.test(strValue))
  {
    return 11;
  }
  else{
    var strSeparator = strValue.substring(4,5);
    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
        '08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31};
    var intDay = eval(arrayDate[2]);
    var intMonth = eval(arrayDate[1]);
    if(intMonth > 12 || intMonth <= 0) return 12;
    if(arrayDate[1].length < 2) arrayDate[1] = '0' + arrayDate[1];

    //check if month value and day value agree
    if(arrayLookup[arrayDate[1]] != null ) {
      if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
        return 1; //found in lookup table, good date
    }
    //check for February
    if(intMonth == 2)
    {
      var intYear = parseInt(arrayDate[0]);
      if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
        return 1;
    }

  }
  return 11;
}

function validatetime( strValue )
{
  /*
  strValue must be as:  hh:mm
  */
  var arrayTime = strValue.split(":")
  if (arrayTime.length==2)
  {
    strHour=arrayTime[0];
    strMinute=arrayTime[1];
    strSecond=arrayTime[2];
    if((parseInt(strHour)>=0 && parseInt(strHour)<=24) && (parseInt(strMinute)>=0 && parseInt(strMinute)<=60))
      return 1;
    return 11;
  }
  return 11;
}

function validatedatetime( strValue )
{
  arrayValue = strValue.split(" ");
  if(arrayValue.length==2)
  {
    var rv = validatedate(arrayValue[0]);
    if(rv == 1)
      rv = validatetime(arrayValue[1]);
    return rv;
  }
  return 11;
}

function isSpace(val) {
  return isEmpty(removeSpace(val));
}

function isEmpty(val) {
	if (val == "") {
    return true;
  } else {
    return false;
  }
}

function ischar(val,len)
{
  if(getUniCodeLength(val)<=len) return 1;
  return 13;
}

function isint(val,len)
{
  if(isNaN(val)) return 14;
  if(val.length<=len) return 1;
  return 15;
}

function islong(val,len)
{
  //与isint一致
  return isint(val,len);
}

function isdouble(val,len1,len2)
{
  if(isNaN(val)) return 14;
  if(val.indexOf(".")<0)
  {
    if(val.length<=len1) return 1;
    return 15;
  }
  if(val.substring(0,val.indexOf(".")).length <= len1 && val.length-val.indexOf('.')-1 <= len2)
    return 1;
  return 16;
}

function isfloat(val,len1,len2)
{
  //与isfloat一致
  return isdouble(val,len1,len2);
}

function ismail(val,len)
{
  var i=0 ;
  var slength=val.length;
  if (val.length>len)
    return 13;
  if(val.charAt(0)=="@")
    return 11;
  while((i<slength)&&(val.charAt(i)!="@"))
    i++;
  if (i>=slength)
    return 11;
  else i+=2;
  while((i<slength)&&(val.charAt(i)!="."))
    i++;
  if(i>=slength-1)
    return 11;
  return 1;
}

//验证EMAIL
function  checkmail(mail)
{
  var  strr;
  re=/(\w+@\w+\.\w+)(\.{0,1}\w*)(\.{0,1}\w*)/i;
  re.exec(mail);
  if  (RegExp.$3!=""&&RegExp.$3!="."&&RegExp.$2!=".")  strr=RegExp.$1+RegExp.$2+RegExp.$3
    else
      if  (RegExp.$2!=""&&RegExp.$2!=".")  strr=RegExp.$1+RegExp.$2
        else    strr=RegExp.$1
          if  (strr!=mail)  {alert("请填写正确的邮件地址");return false}
  return  true;
}

function compval(val1,val2)
{
  if(val2 == null || val2 == '')
    return 1;
  var val11 = parseFloat(val1);
  if(val2.maxval != null && val2.maxval != '')
    if(val11 - val2.maxval > 0.00001)
      return 16;
  if(val2.minval != null && val2.minval != '')
    if(val11 - val2.minval < -0.00001)
      return 16;
  return 1;
}

function setfieldminmaxval(fieldname,minval,maxval)
{
  if(fieldname == null || fieldname == '')
    return;
  var i;
  for(i=0;i<fields.length;i++)
  {
    if(fields[i].name != fieldname)
      continue;
    fields[i].minval = minval;
    fields[i].maxval = maxval;
    break;
  }
}

function compareval(val1,val2,msg)
{
  var temp1 = '';
  var temp2 = '';

  if (document.getElementById(val1) !=null)
    temp1 = document.getElementById(val1).value;
  if (document.all(val2) !=null)
    temp2 = document.getElementById(val2).value;

  if(temp1 == null || temp1 == '' || temp2 == null || temp2 == '')
    return true;

  var retval = (parseFloat(temp2) > parseFloat(temp1));
  if (!retval && msg != null && msg != '')
    alert(msg);
  return retval;
}

function setfieldval(pfield,pval)
{
  if( document.getElementById(pfield) != null && pval != null & pval != '' )
    document.getElementById(pfield).value = pval;
}

var regexpcn = /(%u[A-F0-9]{4})/gi;
var regexp = /(%[A-F0-9]{2})/gi;
var regval = null;
function getUniCodeLength(unicodeval)
{
  if(unicodeval == null) return 0;
  regval = escape(unicodeval);
  regval = regval.replace(regexpcn,"aa");
  regval = regval.replace(regexp,"a");
  return regval.length;
}

//设置列表默认值
function setselectvalue(obj,val) {
  if(obj==null||obj.type!="select-one") return;

  for(var i=0;i<=obj.options.length;i++) {
    if(obj.options[i].value==val) {
      obj.options[i].selected=true;
      break;
    } else {
      obj.options[i].selected=false;
    }
  }
}

//判断是否包含中文
function checkIsChinese(str)
{
    //如果值为空，通过校验
    if (str == "")
        return true;

    var pattern = /^([\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
    if (pattern.test(str))
        return true;
    else
        return false;
}
