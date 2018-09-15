document.write("<OBJECT id=\"dlgHelper\" CLASSID=\"clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b\" width=\"0px\" height=\"0px\"></OBJECT>");
var ocolorPopup = window.createPopup();
var ecolorPopup=null;
function colordialoghidden(){
	ocolorPopup.hide();
}

function colordialogmouseout(obj){
    obj.style.borderColor="";
    obj.bgColor="";
}

function colordialogmouseover(obj){
    obj.style.borderColor="#0A66EE";
    obj.bgColor="#EEEEEE";
}

function colordialogmousedown(color){
    ecolorPopup.value=color;
    //document.body.bgColor=color;
    ocolorPopup.hide();
}

function colordialogmore(){
	//var dlgHelper = document.getElementById("dlgHelper");
    var ssColor=dlgHelper.ChooseColorDlg();  //.chooseColorDlg(ecolorPopup.value);
    ssColor = ssColor.toString(16);
    if (ssColor.length < 6) {
        var sTempString = "000000".substring(0,6-ssColor.length);
        ssColor = sTempString.concat(sColor);
    }
    ecolorPopup.value="#"+ssColor.toUpperCase();
    //document.body.bgColor="#"+sColor.toUpperCase();
    ocolorPopup.hide();
}

function colordialog(){
    var e=event.srcElement;
    e.onkeyup=colordialog;
    ecolorPopup=e;
    var ocbody;
    var oPopBody = ocolorPopup.document.body;
    var colorlist=new Array(40);
    oPopBody.style.backgroundColor = "#f9f8f7";
    oPopBody.style.border = "solid #999999 1px";
    oPopBody.style.fontSize = "12px";

    colorlist[0]="#000000";    colorlist[1]="#993300";    colorlist[2]="#333300";    colorlist[3]="#003300";
    colorlist[4]="#003366";    colorlist[5]="#000080";    colorlist[6]="#333399";    colorlist[7]="#333333";

    colorlist[8]="#800000";    colorlist[9]="#FF6600";    colorlist[10]="#808000";   colorlist[11]="#008000";
    colorlist[12]="#008080";   colorlist[13]="#0000FF";   colorlist[14]="#666699";   colorlist[15]="#808080";

    colorlist[16]="#FF0000";   colorlist[17]="#FF9900";   colorlist[18]="#99CC00";   colorlist[19]="#339966";
    colorlist[20]="#33CCCC";   colorlist[21]="#3366FF";   colorlist[22]="#800080";   colorlist[23]="#999999";

    colorlist[24]="#FF00FF";   colorlist[25]="#FFCC00";   colorlist[26]="#FFFF00";   colorlist[27]="#00FF00";
    colorlist[28]="#00FFFF";   colorlist[29]="#00CCFF";   colorlist[30]="#993366";	 colorlist[31]="#CCCCCC";

    colorlist[32]="#FF99CC";   colorlist[33]="#FFCC99";   colorlist[34]="#FFFF99";   colorlist[35]="#CCFFCC";
    colorlist[36]="#CCFFFF";   colorlist[37]="#99CCFF";   colorlist[38]="#CC99FF";   colorlist[39]="#FFFFFF";

    ocbody = "";
    ocbody += "<table CELLPADDING=0 CELLSPACING=3>";
    ocbody += "<tr height=\"20\" width=\"18\"><td align=\"center\"><table style=\"border:1px solid #808080;\" width=\"12\" height=\"12\" bgcolor=\""+e.value+"\"><tr><td></td></tr></table></td><td bgcolor=\"eeeeee\" colspan=\"7\" style=\"font-size:12px;\" align=\"center\">当前颜色</td></tr>";
    for(var i=0;i<colorlist.length;i++){
        if(i%8==0)
            ocbody += "<tr>";
        ocbody += "<td width=\"14\" height=\"13\" style=\"border:1px solid;\" onMouseOut=\"parent.colordialogmouseout(this);\" onMouseOver=\"parent.colordialogmouseover(this);\" onMouseDown=\"parent.colordialogmousedown('"+colorlist[i]+"')\" align=\"center\" valign=\"middle\"><table style=\"border:1px solid #808080;\" width=\"10\" height=\"10\" bgcolor=\""+colorlist[i]+"\"><tr><td></td></tr></table></td>";
        if(i%8==7)
            ocbody += "</tr>";
    }
    //ocbody += "<tr><td align=\"center\" height=\"10\" colspan=\"8\" onMouseOut=\"parent.colordialogmouseout(this);\" onMouseOver=\"parent.colordialogmouseover(this);\" style=\"border:1px solid;font-size:12px;cursor:default;\" onMouseDown=\"parent.colordialogmore()\">其它颜色</td></tr>";
    ocbody += "</table>";

    oPopBody.innerHTML=ocbody;
    ocolorPopup.show(e.offsetLeft-2, e.offsetTop+e.offsetHeight-3, 153, 146, document.getElementById('fontColor'));
}