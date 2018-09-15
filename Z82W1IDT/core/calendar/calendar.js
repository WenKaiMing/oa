
var gdCtrl = new Object();
var goSelectTag = new Array();
var gcGray = "#808080";
var gcToggle = "#FB8664";
var gcBG = "#e5e6ec";
var previousObject = null;

var gdCurDate = new Date();
var giYear = gdCurDate.getFullYear();
var giMonth = gdCurDate.getMonth()+1;
var giDay = gdCurDate.getDate();

function getNowDate()
{
   var nn=new Date();
   year1=nn.getYear();
   mon1=nn.getMonth()+1;
   date1=nn.getDate();
   var monstr1;
   var datestr1
   if(mon1<10) 
    monstr1="0"+mon1;
   else
    monstr1=""+mon1;
     
   if(date1<10) 
     datestr1="0"+date1;
   else
     datestr1=""+date1;
   return year1+"-"+monstr1+"-"+datestr1;
}

function fSetDate(iYear, iMonth, iDay){
var VicPopCal = document.getElementById('VicPopCal');
  VicPopCal.style.visibility = "hidden";
  if ((iYear == 0) && (iMonth == 0) && (iDay == 0)){
   gdCtrl.value = "";
  }else{
   iMonth = iMonth + 100 + "";
   iMonth = iMonth.substring(1);
iDay = iDay + 100 + "";
  iDay = iDay.substring(1);
   if(gdCtrl.tagName == "INPUT"){
      gdCtrl.value = iYear+"-"+iMonth+"-"+iDay;
   }else{
      gdCtrl.innerText = iYear+"-"+iMonth+"-"+iDay;
   }
  }

  for (i in goSelectTag)
   goSelectTag[i].style.visibility = "visible";
  goSelectTag.length = 0;
  
  window.returnValue=gdCtrl.value;
  //window.close();


}


function fPrevMonth(){
var tbSelYear = document.getElementById('tbSelYear');
var tbSelMonth = document.getElementById('tbSelMonth');
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;
  
  if (--iMon<1) {
   iMon = 12;
   iYear--;
  }
  
  fSetYearMon(iYear, iMon);
}

function fNextMonth(){
var tbSelMonth = document.getElementById('tbSelMonth');
var tbSelYear = document.getElementById('tbSelYear');
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;
  
  if (++iMon>12) {
   iMon = 1;
   iYear++;
  }
  
  fSetYearMon(iYear, iMon);
}


function HiddenDiv()
{
var VicPopCal = document.getElementById('VicPopCal');
var i;
  VicPopCal.style.visibility = "hidden";
  //for (i in goSelectTag)
  // goSelectTag[i].style.visibility = "visible";
  //goSelectTag.length = 0;

}


function Point(iX, iY){
this.x = iX;
this.y = iY;
}

function fGetXY(aTag){
  var oTmp = aTag;
  var pt = new Point(0,0);
  do {
   pt.x += oTmp.offsetLeft;
   pt.y += oTmp.offsetTop;
   oTmp = oTmp.offsetParent;
  } while(oTmp.tagName!="BODY");
  
  return pt;
}

// Main: popCtrl is the widget beyond which you want this calendar to appear;

// dateCtrl is the widget into which you want to put the selected date.

// i.e.: <input type="text" name="dc" style="text-align:center" readonly><INPUT type="button" value="V" >

function fPopCalendar(popCtrl, dateCtrl,strDate){
var VicPopCal = document.getElementById('VicPopCal');

var ifrmcld = document.getElementById('ifrmcld');
  if (popCtrl == previousObject){
    if (VicPopCal.style.visibility == "visible"){
    HiddenDiv();
    return true;
   }
   
  }

  previousObject = popCtrl;
  gdCtrl = dateCtrl;
  //fInitialDate(strDate);
  
  //fSetYearMon(giYear, giMonth); 
  
  var point = fGetXY(popCtrl);
  with (VicPopCal.style) {
   left = point.x;
top = point.y+popCtrl.offsetHeight;
//width = VicPopCal.offsetWidth;
width = 210; //

//height = VicPopCal.offsetHeight;
height = 160;
//fToggleTags(point); 
visibility = 'visible';
  }
  with (ifrmcld.style) {
  	left = point.x;
top = point.y+popCtrl.offsetHeight;
width = 210;
height = "92%";
  }
  //��firefox����������px,��������쳣

  VicPopCal.style.left = point.x + "px";
  VicPopCal.style.top = point.y + popCtrl.offsetHeight + "px";
}




with (document) {
write("<Div id='VicPopCal' style='POSITION:absolute;VISIBILITY:hidden;border:0px ridge;z-index:100;'>");
write("<iframe id='ifrmcld' src=\"/core/calendar/view.action\"  style='overflow: auto; height: 98%; width: 100%' frameborder=\"0\" border=\"0\" scrolling=\"no\"></iframe>");

write("<B style='cursor:pointer' onclick='HiddenDiv()' onMouseOver='this.style.color=gcToggle' onMouseOut='this.style.color=0'>�ر�</B>");
write("</Div>");
}