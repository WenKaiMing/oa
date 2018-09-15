<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.km_name]*}</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<style>
.search_div {float: left;}
.search_box {float: left;}
.search_type {text-align: center;}
.operate {width: 100%;}
.upload {margin: 0 40px;}
.search_box {margin: 10px 20px;}
</style>
</head>
<body>
	<div di="container" class="container">
		<div id="km_header" class="km_header">
			<div id="logo" class="logo">
				<a href="#">
					<img src="/obpm/km/disk/images/km2_logo.gif"></img>
				</a>
			</div>
			<div id="welcome"></div>
		</div>
		<div id="content">
			<div id="mainLeft" class="mainLeft">
				<div class="control">
					<div id="operate" class="operate">
						<div class="upload">
							<div class="upload_left"></div>
							<div class="upload_center">
								<a href="#" id="fileUpload">
									<img src="/obpm/km/disk/images/upload_icon.gif">{*[cn.myapps.km.disk.want_to_upload]*}</img>
								</a>
							</div>
							<div class="upload_right"></div>
						</div>
						<div class="upload">
							<div class="upload_left"></div>
							<div class="upload_center">
								<a href="#" id="fileUpload">
									<img src="/obpm/km/disk/images/upload_icon.gif"/>{*[cn.myapps.km.disk.my_disk]*}
								</a>
							</div>
							<div class="upload_right"></div>
						</div>
						<div class="upload">
							<div class="upload_left"></div>
							<div class="upload_center">
								<a href="#" id="fileUpload">
									<img src="/obpm/km/disk/images/upload_icon.gif"/>{*[cn.myapps.km.disk.knowledge_map]*}
								</a>
							</div>
							<div class="upload_right"></div>
						</div>
						<div class="upload">
							<div class="upload_left"></div>
							<div class="upload_center">
								<a href="#" id="fileUpload">
									<img src="/obpm/km/disk/images/upload_icon.gif"/>{*[cn.myapps.km.disk.help_for_use]*}
								</a>
							</div>
							<div class="upload_right"></div>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div id="search" class="search_div">
					<div class="search_box">
						<div class="search_type">{*[cn.myapps.km.disk.all_categories]*}</div>
						<input class="search_input" type="text"/>
						<img class="search_img" alt src="/obpm/km/disk/images/select.gif"/>
					</div>
					<div class="search_box">
						<div class="search_type">{*[cn.myapps.km.disk.full_text]*}</div>
						<input class="search_input" type="text"/>
						<img class="search_img" alt src="/obpm/km/disk/images/select.gif"/>
					</div>
					<div class="search_box">
						<input class="search_input2" type="text"/>
						<img class="search_img2" alt src="/obpm/km/disk/images/magnifier.gif"/>
					</div>
				</div>
			</div>
			<div id="mainRight" class="mainRight"></div>
</body>
</o:MultiLanguage></html>