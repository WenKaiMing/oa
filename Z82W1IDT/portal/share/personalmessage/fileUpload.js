
var upload;
var colIndex = 0;
//总上传量
var sunUploadSize =0;
//已上传数量
var alreadyUpload = 0;
//待上传数
var waitUpload = 0;
//剩余上传数
var residueUpload = 0;
//上传大小
var mamaximumSize = 0;
//删除文件数
var deleteNumber = 0;

var debug = "";
//返回值选择文件
var value = "";

//判断是否包含成功上传文件
var isSuccess = false;

var fileMaxText = "";
var fileZeroText = "";
var fileResidueText = "";
var fileReadyText = "";
var fileLimitText = "";
var fileSuccessText = "";
var fileExceedText =  "";
var fileMessageText = "";
var cancel = "";
var stopped = "";
var unit = "";

var keys = new Array();
var values = new Array();



//滚动条操作
function barRuning(id,per){
	
	var $bar = jQuery("#"+id+"_bar");
	$bar.css("width",per+"%");
		 
	var $cell = jQuery("#"+id+"_per");
	$cell.html(per + "%");
}

//构建每一条数据
function createTable(file,message){
	//用表格显示
//	
	var trhtml = "<tr id='"+file.id+"'>";
	trhtml +="<td nowrap='nowrap' style='padding-top:8px;'>"+file.name+"</td>";
	if(message == null || message == ""){
		trhtml +="<td id='"+file.id+"_per' nowrap='nowrap' rowSpan='3' style='border-bottom:1px #a8abae dashed;'>0%</td>";
		trhtml +="<td nowrap='nowrap' rowSpan='3'  style='border-bottom:1px #a8abae dashed;'><img id=\""+file.id+"_cancel\" src=\"images/upload_cancel.png\" onclick=\"cancelFile(\'"+file.id+"\')\" /><img id=\""+file.id+"_delete\" src=\"images/upload_delete.png\" onclick=\"deleteFile(\'"+file.id+"\')\" style=\"display:none;\" /></td>";
	}else{
		trhtml +="<td id='"+file.id+"_per' nowrap='nowrap' rowSpan='3' style='border-bottom:1px #a8abae dashed;'>&nbsp;</td>";
		trhtml +="<td nowrap='nowrap' rowSpan='3'  style='border-bottom:1px #a8abae dashed;'>&nbsp;</td>";
	}
	trhtml +="</tr>"; 
	var $row;
	if(jQuery("#infoTable tr").length > 0 && colIndex != 0){
		$row = jQuery("#infoTable tr").eq(colIndex++);
		$row.after(trhtml);
	}else if(jQuery("#infoTable tr").length > 0 && colIndex == 0){
		$row = jQuery("#infoTable tr").eq(0);
		$row.before(trhtml);
	}else{
		jQuery("#infoTable").append(trhtml);
	}
	
	//进度条
	var rowbar = "<tr id='"+file.id+"_barRow'><td><div class='graph'><span id='"+file.id+"_bar' class='green' style='width:0%'></span></div></td></tr>";
	jQuery("#infoTable tr").eq(colIndex++).after(rowbar);
	
	//状态栏
	var result = "";
	if(message!=null&&message!=""){
		result = "<font color='red'>"+message+"</font>";
	}else{
		result = fileReadyText+"("+calculated(file.size)+")";
	}
	var rowStatic = "<tr id='"+file.id+"_static'><td style='border-bottom:1px #a8abae dashed;padding-bottom:8px;'>"+result+"</td></tr>";
	jQuery("#infoTable tr").eq(colIndex++).after(rowStatic);
	
	jQuery("#promptDiv").css("display","none");
}

//隐藏上传按钮
function hiddenUpload(){
	if(residueUpload == 0){
		var $swf_upload_button = jQuery("#swf_upload_button");
		$swf_upload_button.css("display","none");
		upload.setButtonDimensions ( 0, 20);
	}
}

//显示上传按钮
function showUpload(){
	var $swf_upload_button = jQuery("#swf_upload_button");
	$swf_upload_button.css("display","");
	upload.setButtonDimensions ( 80, 20);
}

//取消上传
function cancelFile(id){
	changeNotice();
	showUpload();

	updateState(id,"<font color='red'>"+stopped+"</font>");

	upload.cancelUpload(id,true);
	upload.startUpload();
	
	var $img = jQuery("#"+id+"_cancel");
	$img.css("display","none");

	var $bar = jQuery("#"+id+"_bar");
	$bar.css("background-color","red");
}

//清空上传
function deleteFile(id){
	var $row = jQuery("#"+id);
	$row.remove();
	var $staticRow = jQuery("#"+id+"_static");
	$staticRow.remove();
	var $barRow = jQuery("#"+id+"_barRow");
	$barRow.remove();
	
	var index = keys.indexOf(id);
	keys.splice(index,1);
	values.splice(index,1);
	
	residueUpload ++;
	deleteNumber ++;
	colIndex =0;
	upload.setFileQueueLimit(sunUploadSize+deleteNumber);
	upload.setFileUploadLimit(sunUploadSize+deleteNumber);
	
	if(jQuery("#infoTable tr").length == 0){
		jQuery("#promptDiv").css("display","");
	}
	
	showUpload();
	changeNotice();
	if(residueUpload == sunUploadSize){
		hiddenResultButton();
	}
}

//计算大小单位
function calculated(size){
	var number;
	var result = "";
	if(size < 1024){
		number = size;
		result += number + "B";
	}else if(size <(1024 *1024)){
		number = size/1024;
		number = (Math.round(number * 10))/10;
		result = number + "KB";
	}else if(size < (1024 * 1024 * 1024)){
		number = size/(1024 *1024);
		number = (Math.round(number * 10))/10;
		result = number + "MB";
	}else{
		number = size/(1024*1024*1024);
		number = (Math.round(number * 10))/10;
		result = number + "GB";
	}
	return result;
}

//更新文件状态
function updateState(id,result){
	var $staticRow = jQuery("#" + id+ "_static").find("td");
	var $cell = $staticRow.eq(0);
	$cell.html(result);
}

//修改提示
function changeNotice(){
	var $swf_upload_notice = jQuery("#swf_upload_notice");
	$swf_upload_notice.html("<font color='black'>"+fileMaxText+":</font><font color='red'>"+sunUploadSize+"</font><font color='black'>"+unit+" "+fileResidueText+":</font><font color='blue'>"+residueUpload+"</font><font color='black'>"+unit+","+fileLimitText+":</font><font color=red>"+calculated(mamaximumSize)+"</font>");
}

//隐藏完成取消按钮
function hiddenResultButton(){
	var $swf_upload_OK = jQuery("#swf_upload_OK");
	$swf_upload_OK.css("display","none");
	var $swf_upload_Cancel = jQuery("#swf_upload_Cancel");
	$swf_upload_Cancel.css("display","none");
}

//现实完成按钮
function showResultButton(){
	var $swf_upload_OK = jQuery("#swf_upload_OK");
	$swf_upload_OK.css("display","");
	var $swf_upload_Cancel = jQuery("#swf_upload_Cancel");
	$swf_upload_Cancel.css("display","");
}

//完成操作
function returnResult(){
	value = "";
	for(var obj in values) { // 这个是关键
		if(value != ""){
			value +=";"+ values[obj];
		}else{
			value += values[obj];
		}
	}
	OBPM.dialog.doReturn(decodeURIComponent(value));
}

//取消操作
function cancelResult() {
	OBPM.dialog.doExit();
}

//现实清空按钮
function showDelete(id){
	var $imgdelete = jQuery("#"+id+"_delete");
	$imgdelete.css("display","");
}

function fileDialogStart(file){
}

//遍历文件
function fileQueued(file){
	waitUpload++;
	if(residueUpload >0){
		changeNotice();
		hiddenUpload();
		hiddenResultButton();
		createTable(file,"");
	}
	residueUpload --;
}

//文件选择窗口关闭时触发
function fileDialogComplete(numFilesSelected, numFilesQueued, numFilesInQueue){
	if(residueUpload <0){
		var errorName = fileExceedText+":"+(0-residueUpload);
		residueUpload = 0;
		alert(errorName);
	}
	if(waitUpload >0 ){
		hiddenResultButton();
		upload.startUpload();
	}
}

//百分比计算
function percentage(complete,total){
	var per = Math.floor((complete/total)*100);
	return per;
}

//选择文件异常
function fileQueueError(file, errorCode, message){
	try {
		var result = "";
		var errorName = "";
		if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
			errorName = "You have attempted to queue too many files.";
		}

		if (errorName !== "") {
			alert(errorName);
			return;
		}
		
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			result = fileZeroText;
			break;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			result = fileMessageText;
			break;
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			errorName = fileExceedText+":"+residueUpload;
			alert(errorName);
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		default:
			alert(message);
			break;
		}
		createTable(file,result);

	} catch (ex) {
		this.debug(ex);
	}
}

//上传过程中触发
function uploadProgress(file,complete,total){
	 var per = percentage(complete,total);
	 
	 updateState(file.id,calculated(complete) + "/" + calculated(total));

	barRuning(file.id,per);
}

//单个文件上传成功后调用
function uploadSuccess(file, serverData){
	waitUpload--;
	alreadyUpload ++;
	
	keys.push(file.id);
	values.push(serverData);
	
	barRuning(file.id,"100");
	updateState(file.id,"<font color='green'>"+fileSuccessText+"</font>");
	
	var $img = jQuery("#"+file.id+"_cancel");
	$img.css("display","none");
	 
	var $cell = jQuery("#"+file.id + "_per");
	$cell.html("&nbsp;");
	
	var $deleteImg = jQuery("#"+file.id+"_delete");
	$deleteImg.css("display","");
}

//文件上传完后调用
function uploadComplete(file){
	if(waitUpload == 0){
		if(alreadyUpload > 0){
			showResultButton();
		}else{
			//showResultButton();
			colIndex= 0;
		}
	}else{
		upload.startUpload();
	}
	
	if(residueUpload == 0){
		hiddenUpload();
	}
}

//上传异常时触发
function uploadError(file, errorCode, message) {
	waitUpload --;
	residueUpload ++;
	changeNotice();
	var $img = jQuery("#"+file.id+"_cancel");
	$img.css("display","none");
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			try {
				updateState(file.id,"<font color='red'>"+cancel+"</font>");
			}
			catch (ex1) {
				this.debug(ex1);
			}
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			try {
				updateState(fiel.id, "<font color='red'>"+stopped+"</font>");
			}
			catch (ex2) {
				this.debug(ex2);
			}
			break;
		default:
			alert(message);
			break;
		}
	} catch (ex3) {
		this.debug(ex3);
	}
}