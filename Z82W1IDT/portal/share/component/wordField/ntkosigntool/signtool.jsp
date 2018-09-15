<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>{*[core.usbkey.ekey.signtool.title]*}</title>

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style type="text/css">
body {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 13px;
    line-height: 18px;
    color: #333;
}

a {
    color: #0088cc;
    text-decoration: none;
}

a:hover {
    color: #005580;
    text-decoration: underline;
}

.well {
    height: 100%;
    padding: 19px;
    margin-bottom: 20px;
    background-color: whiteSmoke;
    border: 1px solid #EEE;
    border: 1px solid rgba(0, 0, 0, 0.05);
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
    -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
}

.esp-display {
    height: 184px;
    width: 284px;
    padding: 2px;
    margin-bottom: 20px;
    background-color: whiteSmoke;
    border: 1px solid #EEE;
    border: 1px solid rgba(0, 0, 0, 0.05);
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
    -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
}

.modal {
    position: fixed;
    /*top: 50%;*/
    /*left: 50%;*/
    z-index: 1050;
    overflow: auto;
    width: 100%;
    margin: 0;
    background-color: white;
    /*border: 1px solid #999;*/
    /*border: 1px solid rgba(0, 0, 0, 0.3);*/
    -webkit-border-radius: 6px;
    -moz-border-radius: 6px;
    border-radius: 6px;
    -webkit-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
    box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);
    -webkit-background-clip: padding-box;
    -moz-background-clip: padding-box;
    background-clip: padding-box;
}

.modal-header {
    padding: 5px;
    border-bottom: 1px solid #EEE;
}

.modal-body {
    overflow-y: auto;
    height: 100%;
    padding: 15px;
}

.modal-footer {
    padding: 14px 15px 15px;
    margin-bottom: 0;
    text-align: right;
    background-color: whiteSmoke;
    border-top: 1px solid #DDD;
    -webkit-border-radius: 0 0 6px 6px;
    -moz-border-radius: 0 0 6px 6px;
    border-radius: 0 0 6px 6px;
    -webkit-box-shadow: inset 0 1px 0 white;
    -moz-box-shadow: inset 0 1px 0 #ffffff;
    box-shadow: inset 0 1px 0 white;
}

.btn {
    display: inline-block;
    padding: 4px 10px 4px;
    margin-bottom: 0;
    font-size: 13px;
    line-height: 18px;
    color: #333;
    text-align: center;
    text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
    vertical-align: middle;
    background-color: whiteSmoke;
    background-image: -moz-linear-gradient(top, white, #E6E6E6);
    background-image: -ms-linear-gradient(top, white, #E6E6E6);
    background-image: -webkit-gradient(linear, 0 0, 0 100%, from(white), to(#E6E6E6));
    background-image: -webkit-linear-gradient(top, white, #E6E6E6);
    background-image: -o-linear-gradient(top, white, #E6E6E6);
    background-image: linear-gradient(top, white, #E6E6E6);
    background-repeat: repeat-x;
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr = '#ffffff', endColorstr = '#e6e6e6', GradientType = 0);
    border-color: #E6E6E6 #E6E6E6 #BFBFBF;
    border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
    filter: progid:dximagetransform.microsoft.gradient(enabled = false);
    border: 1px solid #CCC;
    border-bottom-color: #B3B3B3;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
    -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
    cursor: pointer;
}

.grid_1 {
    width: 60px;
}

.grid_2 {
    width: 140px;
}

.grid_3 {
    width: 220px;
}

.grid_4 {
    width: 300px;
}

.grid_5 {
    width: 320px;
}

.grid_6 {
    width: 360px;
}

.grid_7 {
    width: 360px;
}

.grid_8 {
    width: 620px;
}

.grid_9 {
    width: 700px;
}

.grid_10 {
    width: 780px;
}

.grid_11 {
    width: 860px;
}

.grid_12 {
    width: 98%;
}

.column {
    margin: 0px;
    overflow: hidden;
    float: left;
    display: inline;
}

.row {
    width: 100%;
    margin: 0 auto;
    overflow: hidden;
}

.row .row {
    margin: 0px;
    width: auto;
    display: inline-block;
}

.column-title {
    border-bottom: 1px solid #2e8b57;
    margin-bottom: 15px;
    font-weight: bold;
}

.input-row {
    padding: 2px;
}

.esp-info {
    padding: 2px;
}
</style>
<script language="JavaScript">

//检查用户输入。参数IsNewSign标志是新建还是修改印章。新建的时候需要
//检查用户是否选择了印章原始文件。
function CheckInput(IsNewSign) {
    var signname = document.all("SignName").value;
    if (( signname == '') || ( undefined == typeof(signname))) {
        alert('请输入印章名称');
        return false;
    }

    var signuser = document.all("SignUser").value;
    if (( signuser == '') || ( undefined == typeof(signuser))) {
        alert('请输入印章使用人');
        return false;
    }

    var password = document.all("Password").value;
    if (( password == '') || ( undefined == typeof(password))) {
        alert('请输入印章口令');
        return false;
    }
    if ((password.length < 6) || (password.length > 32)) {
        alert('印章口令必须是6-32位.');
        return false;
    }
    if (IsNewSign == true) //如果是创建印章，需要用户选择原始印章文件
    {
        var signfile = document.all("SignFile").value;
        if (( signfile == '') || ( undefined == typeof(signfile))) {
            alert('请选择用来创建印章的原始文件(bmp,gif,jpg,png.');
            return false;
        }
        if ((-1 == signfile.toUpperCase().lastIndexOf("BMP")) &&
                (-1 == signfile.toUpperCase().lastIndexOf("GIF")) &&
                (-1 == signfile.toUpperCase().lastIndexOf("PNG")) &&
                (-1 == signfile.toUpperCase().lastIndexOf("JPG"))) {
            alert('请选择一个正确的印章原始文件(bmp,gif,jpg.');
            return false;
        }
    }
    ntkosignctl.SignName = document.all("SignName").value;
    if (0 != ntkosignctl.StatusCode) {
        alert("设置印章名称错误");
        return false;
    }
    ntkosignctl.SignUser = document.all("SignUser").value;
    if (0 != ntkosignctl.StatusCode) {
        alert("设置印章使用者错误");
        return false;
    }
    ntkosignctl.Password = document.all("Password").value;
    if (0 != ntkosignctl.StatusCode) {
        alert("设置印章口令错误");
        return false;
    }
    return true;
}
//生成新印章文件
function CreateNew() {
    if (!CheckInput(true))return;
    ntkosignctl.CreateNew(
            document.all("SignName").value,
            document.all("SignUser").value,
            document.all("Password").value,
            document.all("SignFile").value
    );
    if (0 != ntkosignctl.StatusCode) {
        alert("创建印章文件错误.");
        return;
    }
    ShowSignInfo();
    alert("创建印章成功.您现在可以插入EKEY,并点击'保存印章到EKEY'将创建的印章保存到EKEY.");
}
//对话框方式生成新的印章文件
function CreateNewWithDialog() {
    ntkosignctl.CreateNew();
    if (0 != ntkosignctl.StatusCode) {
        alert("创建印章文件错误.");
        return;
    }
    //正确，显示印章信息
    ShowSignInfo();
    alert("创建印章成功.您现在可以插入EKEY,并点击'保存印章到EKEY'将创建的印章保存到EKEY.");
}

function SaveToEkey() {
    if (!CheckInput(false))return;
    var ifCont = window.confirm("请插入EKEY到您的计算机.然后继续。");
    if (!ifCont)return;
    var index = ntkosignctl.SaveToEkey();
    if (0 == ntkosignctl.StatusCode) {
        document.all("EkeyFreeSize").innerHTML = ntkosignctl.EkeyFreeSize + "字节";
        alert("保存印章到EKEY成功!保存位置:" + index);
    }
    else {
        alert("保存印章到EKEY失败！！");
    }
}

function SaveToLocal() {
    if (!CheckInput(false))return;
    ntkosignctl.SaveToLocal('', true);
    if (0 == ntkosignctl.StatusCode) {
        alert("保存印章到本地文件成功!");
    }
    else {
        alert("保存印章到本地文件失败！！");
    }
}

function ResetEkeySigns() {
    ntkosignctl.ResetEkeySigns();
    if (0 == ntkosignctl.StatusCode) {
        document.all("EkeyFreeSize").innerHTML = ntkosignctl.EkeyFreeSize + "字节";
        alert("重设EKEY所有印章成功!");
    }
    else {
        alert("用户取消,或者重设EKEY所有印章失败!");
    }
}
function EnableEkeyButtons(isEnabled) {
    document.all("OpenFromEkey").disabled = !isEnabled;
    document.all("DeleteFromEkey").disabled = !isEnabled;
    document.all("ResetEkey").disabled = !isEnabled;
    document.all("EkeyFreeSize").innerHTML = isEnabled ? (ntkosignctl.EkeyFreeSize + "字节") : "未知";
    document.all("EkeySN").innerHTML = isEnabled ? (ntkosignctl.EkeySN) : "未知";
    document.all("ChangeEkeyAP").disabled = !isEnabled;
    document.all("ChangeEkeyUP").disabled = !isEnabled;
    document.all("SaveToEkey").disabled = !isEnabled;
}

var ntkosignctl;
function init() {
    ntkosignctl = document.getElementById("ntkosignctl");
    ntkosignctl.IsShowStatus = false;
    if (ntkosignctl.IsEkeyConnected) {
        EnableEkeyButtons(true);
    }

    initKeyType();
}

function initKeyType() {
    curEkeyType = ntkosignctl.EkeyType;
    //alert("curekeytype=" + curEkeyType);
    selectObj = document.all("EkeyTypeSelector");
    for (i = 0; i < selectObj.options.length; i++) {
        if (selectObj.options[i].value == curEkeyType) {
            selectObj.options[i].selected = true;
            break;
        }
    }
}

function changeEkeyType(ekeyType) {
    ntkosignctl.EkeyType = ekeyType;
    EnableEkeyButtons(ntkosignctl.IsEkeyConnected);
}

function OpenFromLocal() {
    ntkosignctl.OpenFromLocal('', true);
    ShowSignInfo();
}
function OpenFromEkey(pass) {
    var ifCont = window.confirm("请插入EKEY到您的计算机.然后继续。");
    if (!ifCont)return;
    ntkosignctl.OpenFromEkey(pass);
    if (0 != ntkosignctl.StatusCode) {
        alert("从EKEY打开印章错误.");
        return;
    }
    //正确，显示印章信息
    ShowSignInfo();
    alert("从EKEY打开印章成功！您现在可以修改印章的相关信息并重新保存到EKEY.此时选择印章原始文件无效.");
}
//如果成功状态，显示当前印章信息
function ShowSignInfo() {
    document.all("SignName").value = ntkosignctl.SignName;
    document.all("SignUser").value = ntkosignctl.SignUser;
    document.all("Password").value = ntkosignctl.Password;
    document.all("SignSN").innerHTML = ntkosignctl.SignSN;
    document.all("SignWidth").innerHTML = ntkosignctl.SignWidth;
    document.all("SignHeight").innerHTML = ntkosignctl.SignHeight;
    document.all("SaveToLocal").removeAttribute("disabled");
    if (ntkosignctl.IsEkeyConnected) {
        document.all("SaveToEkey").removeAttribute("disabled");
    }
}
function ChangeEkeyPin() {
    var flags = document.all("forWho");
    var oldpass = document.all("oldPassword").value;
    var newpass1 = document.all("newPassword1").value;
    var newpass2 = document.all("newPassword2").value;
    if ((newpass1.length < 4) || (newpass1.length > 16)) {
        alert('EKEY访问口令必须是4-16位.');
        return;
    }
    if (newpass1 != newpass2) {
        alert('两次新口令不符合，请重新输入.');
        return;
    }
    var isAdmin = true;
    if (flags[0].checked) {
        isAdmin = false;
    }
    else {
        isAdmin = true;
    }
    ntkosignctl.ChangeEkeyPassword(oldpass, newpass1, isAdmin);
    if (0 == ntkosignctl.StatusCode) {
        if (isAdmin) {
            alert("改变EKEY管理员口令成功!");
        }
        else {
            alert("改变EKEY用户口令成功!");
        }
    }
    else {
        if (isAdmin) {
            alert("改变EKEY管理员口令失败!");
        }
        else {
            alert("改变EKEY用户口令失败!");
        }
    }
}
function ResetEkeyUserPin() {
    var adminPassword = document.all("adminPassword").value;
    var newUserPassword1 = document.all("newUserPassword1").value;
    var newUserPassword2 = document.all("newUserPassword2").value;
    if ((newUserPassword1.length < 4) || (newUserPassword1.length > 16)) {
        alert('EKEY访问口令必须是4-16位.');
        return;
    }
    if (newUserPassword1 != newUserPassword2) {
        alert('两次新口令不符合，请重新输入.');
        return;
    }
    ntkosignctl.ResetEkeyUserPassword(adminPassword, newUserPassword1);
    if (0 == ntkosignctl.StatusCode) {
        alert("重设EKEY用户口令成功!");
    }
    else {
        alert("重设EKEY用户口令失败!");
    }
}
function c0() {
    document.getElementById("rs_act").style.display = "";
    document.getElementById("n_act").style.display = "none";
    document.getElementById("ap_act").style.display = "none";
    document.getElementById("up_act").style.display = "none";
}
function c1() {
    document.getElementById("rs_act").style.display = "none";
    document.getElementById("n_act").style.display = "none";
    document.getElementById("ap_act").style.display = "";
    document.getElementById("up_act").style.display = "none";
}
function c2() {
    document.getElementById("rs_act").style.display = "none";
    document.getElementById("n_act").style.display = "none";
    document.getElementById("ap_act").style.display = "none";
    document.getElementById("up_act").style.display = "";
}
function cr() {
    document.getElementById("rs_act").style.display = "none";
    document.getElementById("n_act").style.display = "";
    document.getElementById("ap_act").style.display = "none";
    document.getElementById("up_act").style.display = "none";
}
</script>

</head>
<body onload="init()">
    <div class="row">
        <div class="column grid_12">
            <div id="displayEsp" class="modal"
                 style="position: relative;top: auto; left: auto; margin: 0 auto; z-index: 1; width: 100%;">
                <div class="modal-body">
                    <div class="row" style="padding: 5px">
                        <div class="column grid_5">
                            <div class="esp-display" style="padding: 5px">
                                <script type="text/javascript" src="ntkoGenOcxObj.js"></script>
                                <script language="JScript" for="ntkosignctl" event="OnEkeyInserted()">
                                    EnableEkeyButtons(true);
                                </script>
                                <script language="JScript" for="ntkosignctl" event="OnEkeyRemoved()">
                                    EnableEkeyButtons(false);
                                </script>
                            </div>
                            <div class="esp-info" style="display:none">印章信息:<span id="SignWidth">0</span>/<span id="SignHeight">0</span>
                            </div>
                            <div class="esp-info" style="display:none">印章 SN:<span id="SignSN">未知</span></div>
                            <div class="esp-info" style="display:none">EKEY SN :<span id="EkeySN">未知</span></div>
                            <div class="esp-info" style="display:none">EKEY容量 :<span id="EkeyFreeSize">0byte</span></div>
                            <div class="esp-info" style="display:none">
                                EKEY类型 :<select id="EkeyTypeSelector"
                                                onchange="changeEkeyType(this.options[this.options.selectedIndex].value)">
                                <option value="1">HT_EKEY</option>
                                <option value="2">M&W_EKEY</option>
                                <option value="4">FT_EKEY</option>
                                <option value="6">九思泰达EKEY</option>
                                <option value="7">FT2K_EKEY</option>
                                <option value="8">HUADA_EKEY</option>
                            </select>
                            </div>
                        </div>
                        <div class="column grid_7">
                            <div class="row" id="n_act">
                                <div class="column grid_6" style="padding: 5px">
                                    <div class="column-title">
                                        {*[core.usbkey.ekey.lable.create_sign]*}
                                    </div>
									<div style="display:none;">
										<span style="color: #ff0000;">注意：创建新印章时,以下所有信息必须输入。</span><br/>

										<div class="input-row">印 章 名 称 ：&nbsp;<input id="SignName" value="测试印章Sign01"
																					 checked="checked"></div>
										<div class="input-row">印 章 用 户 ：&nbsp;<input id="SignUser" value="测试用户User01"></div>
										<div class="input-row">印 章 口 令 ：&nbsp;<input id="Password" value=""></div>
										<div class="input-row">请选择印章源文件(请选择bmp,gif,或者jpg)：<br>
											<input type=file id="SignFile">
										</div>
									</div>                                                            
                                    <button class="button" onClick="CreateNewWithDialog();">{*[core.usbkey.ekey.lable.create_sign]*}</button>
                                </div>
                                <div class="column grid_6" style="padding: 5px">
                                    <div class="column-title">
                                        {*[core.usbkey.ekey.lable.change_sign]*}
                                    </div>
                                    <!--<button class="button" onClick="OpenFromLocal()" tabindex="7">打开本地印章</button>-->
                                    <button id="OpenFromEkey" class="button" onClick="OpenFromEkey('');">{*[core.usbkey.ekey.btn.lable.open_sign]*}
                                    </button>
                                    <button id="DeleteFromEkey" onClick="ntkosignctl.DeleteFromEkey();">{*[core.usbkey.ekey.btn.lable.delete_sign]*}
                                    </button>
                                </div>
                                <div class="column grid_6" style="padding: 5px">
                                    <div class="column-title">
                                        {*[core.usbkey.ekey.lable.save_sign]*}
                                    </div>
                                    <button id="SaveToLocal" style="display:none;" onClick="SaveToLocal()" disabled>保存印章到本地</button>
                                    <button id="SaveToEkey" onClick="SaveToEkey()" disabled>保存印章到EKEY</button>
                                </div>
                                 <div class="column grid_6" style="padding: 5px">
                                    <div class="column-title">
                                        {*[core.usbkey.tip.driver_download]*}			
                                    </div>
                                    <span>{*[core.usbkey.ekey.driver_download.tip]*}</span><br>
                                    <a href="../../../security/usbkey/NTKOEKEYUser_4.0.exe" target="_blank">{*[core.usbkey.ekey.driver_download.link.ekey]*}</a> &nbsp;&nbsp;
                                    <a href="NTKOSetup4EKEY.exe" target="_blank">{*[core.usbkey.ekey.driver_download.link.office_plugin]*}</a>
                                </div>
                                <div class="column grid_6" style="padding: 15px;display: none;">
                                    <div class="column-title">
                                        数据恢复
                                    </div>
                                    <button id="ResetEkey" class="button" onClick="c0()">初始化EKEY印章</button>
                                    <button id="ChangeEkeyAP" class="button" onClick="c1()">修改管理员密码</button>
                                    <button id="ChangeEkeyUP" class="button" onClick="c2()">修改用户密码</button>
                                </div>
                            </div>
                            <div class="row" id="rs_act" style="display: none;">
                                <div class="column grid_12" style="padding: 15px">
                                    <div class="column-title">
                                        重置EKEY印章
                                    </div>
                                    <p style="color: red;">警告：一个危险的操作即将执行，请确认是否需要重置EKEY!</p>
                                    <a id="process_reset" href="javascript:cr()">返回</a>&nbsp;&nbsp;&nbsp;<a
                                        href="javascript:ResetEkeySigns()">继续执行</a>
                                </div>
                            </div>
                            <div class="row" id="ap_act" style="display: none;">
                                <div class="column grid_12" style="padding: 15px">
                                    <div class="column-title">
                                        EKEY口令管理
                                    </div>
                                    <span id="ap_act_info"
                                          style="color:red;">&nbsp;</span>
                                    <script type="text/javascript">
                                        function showAlert(show) {
                                            document.getElementById('ap_act_info').innerHTML = show ? "注意:请务必牢记管理员访问口令!如果丢失只能报废EKEY!" : "&nbsp;";
                                        }
                                    </script>
                                    <div class="input-row">旧口令：<input type="password" id="oldPassword" value=""></div>
                                    <div class="input-row">新口令：<input type="password" id="newPassword1" value=""></div>
                                    <div class="input-row">请确认：<input type="password" id="newPassword2" value=""></div>
                                    <div class="input-row">口令源：<input type="radio" name="forWho" class="radio" value="0"
                                                                      checked="checked"
                                                                      onchange="showAlert(false)">用户
                                        <input type="radio" name="forWho" class="radio" value="1"
                                               onchange="showAlert(true)">管理员
                                    </div>
                                    <div class="input-row">
                                        <button id="ChangeEkeyPin" onClick="ChangeEkeyPin()">
                                            修改EKEY口令
                                        </button>
                                    </div>
                                    <br/><br/>
                                    <a href="javascript:cr()">返回</a>
                                </div>
                            </div>
                            <div class="row" id="up_act" style="display: none;">
                                <div class="column grid_12" style="padding: 15px">
                                    <div class="column-title">
                                        使用管理员口令解锁EKEY用户口令
                                    </div>
                                    <div class="input-row">管理员口令：<input type="password" id="adminPassword" value="">
                                    </div>
                                    <div class="input-row">用户新口令：<input type="password" id="newUserPassword1" value="">
                                    </div>
                                    <div class="input-row">确认新口令：<input type="password" id="newUserPassword2" value="">
                                    </div>
                                    <div class="input-row">
                                        <button id="ResetEkeyUserPin" onClick="ResetEkeyUserPin()">
                                            重置EKEY用户口令
                                        </button>
                                    </div>
                                    <br/><br/>
                                    <a href="javascript:cr()">返回</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="text-align: center;padding: 10px 5px 5px;">&nbsp;</div>
</div>
</div>
</body>
</html>
</o:MultiLanguage>