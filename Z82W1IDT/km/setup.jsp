<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.km.util.Config"%>
<%
String action = request.getParameter("action");
if("refresh".equals(action)){
	Config.refresh();
}
if("init".equals(action)){
	if(Config.previewEnabled()){
		response.sendRedirect(request.getContextPath()+ "/km/kmindex.jsp");
		return;
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="myapps" prefix="o"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.installation_wizard]*}</title>
<style type="text/css">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, input, textarea, p, blockquote, th, td {
	margin:0;
	padding:0;
}
table {
	border-collapse:collapse;
	border-spacing:0;
}

.large{font-size: 1em}
p.large .fpType{font-size: 1.3em}

fieldset, img {
	border:0;
}
address, caption, code, dfn, em, strong, th, var {
	font-style:normal;
	font-weight:normal;
}
ol, ul {
	list-style:none;
}

#fp-whoisusing {
	height:48px;clear:both;background-color:#444444;font-size:12px;color:#888888
}

.col1, .col2 {width: 30%;text-align:left}
.col1{float: left;}
.col2{float: right;}
.col1 img, .col2 img{
  margin: 0 10px 0 0;
}

caption, th {
	text-align:left;
}
h1, h2, h3, h4, h5, h6 {
	font-size:100%;
	font-weight:normal;
}
q:before, q:after {
	content:'';
}
abbr, acronym {
	border:0;
}
body {
	background-color:white;
	font-family:Lucida Grande, Lucida, Helvetica, sans-serif;
	color:#666;
	font-size:14px;
	line-height:1.5;
}
html, body {
	height:100%;
}
#body_proxy {
	padding-bottom:1px;
	margin-bottom:-1px;
}
h1, h2, h3, h4, h5, h6 {
	color:#333;
}
a {
	text-decoration:none;
	outline:none;
	color:#4d6291;
}
a:hover {
	background-color:#e9f3fa;
}
#errorExplanation {
	color:red;
}
h1, h2, h3, h4, h5, h6, table {
	margin-bottom:.7em;
}
p {
	margin-bottom:.7em;
}
h1 {
	font-size:26px;
}
h2 {
	font-size:20px;
}
h3 {
	font-size:18px;
}
h4 {
	font-size:14px;
}
h5 {
	font-size:12px;
}
table th {
	font-weight:bold;
}
table td, table th {
	padding:10px;
	border:1px solid #ddd;
}
ol li {
	list-style-type:decimal;
}
ol li ol li {
	list-style-type:lower-alpha;
}
ol li ol li ol li {
	list-style-type:lower-roman;
}
ul li {
	
}
ol li, ul li {
}
em {
	font-style:italic;
}
strong {
	font-weight:bold;
}

#flashContent { display:none; }

blockquote {
	font-family:Georgia, Times, serif;
	font-style:italic;
}
dt {
	font-weight:bold;
}
ul.menu, ol.menu {
	margin-right:-10px;
}
ul.menu li, ol.menu li {
	list-style-type:none;
	list-style-position:outside;
	margin:0;
	padding:0;
	margin-right:10px;
	display:inline-block;
	zoom:1;
*display:inline;
}
.horiz_bttns {
	margin:30px 0;
	margin-right:-10px;
	text-align:right;
}
.horiz_bttns li {
	list-style-type:none;
	list-style-position:outside;
	margin:0;
	padding:0;
	margin-right:10px;
	display:inline-block;
	zoom:1;
*display:inline;
}
.horiz_bttns li {
	display:inline-block;
	zoom:1;
*display:inline;
	vertical-align:top;
}
.horiz_bttns li input {
	display:inherit;
}
.n_button.tiny, .horiz_bttns.tiny .n_button, .overlay .horiz_bttns.small .n_button {
	height:24px;
	display:inline-block;
	zoom:1;
*display:inline;
	cursor:pointer;
	background:none;
	white-space:nowrap;
}

.hoverlink a {
	text-decoration: none;
}

.hoverlink:hover {
	background-color:#efefef;		
	display:block;
}

.psmall{
	font-size: 13px;
}

blockquote{margin: 10px 40px 10px 60px; color: #555}

pre, blockquote {
overflow: auto;
padding: 0 10px;
margin: 20px 30px;
line-height: 1.8em;
background-color: #f5f5f5;
border: 1px solid #e0e0e0;
font-family:Courier New;
font-style:normal;
font-size:12px;
}

pre:hover, blockquote:hover {
background-color: #f0f0f0;
border: 1px solid #d0d0d0;
}

.n_button.tiny, .horiz_bttns.tiny .n_button, .l_sidebar .overlay .horiz_bttns.small .n_button {
	height:24px;
	display:inline-block;
	zoom:1;
*display:inline;
	cursor:pointer;
	background:none;
	white-space:nowrap;
}
.n_button.tiny span, .n_button.tiny em, .horiz_bttns.tiny .n_button span, .horiz_bttns.tiny .n_button em, .l_sidebar .overlay .horiz_bttns.small .n_button span, .l_sidebar .overlay .horiz_bttns.small .n_button em {
	display:inline-block;
	zoom:1;
*display:inline;
	background:transparent url(../images/std_btn_24.png) no-repeat 0 0;
}
.n_button.tiny span, .horiz_bttns.tiny .n_button span, .l_sidebar .overlay .horiz_bttns.small .n_button span {
	height:24px;
	width:10px;
	margin-left:-3px;
}
.n_button.tiny em, .horiz_bttns.tiny .n_button em, .l_sidebar .overlay .horiz_bttns.small .n_button em {
	background-position:right 0;
	background-position:right 0;
	height:23px;
	color:inherit;
	font-style:normal;
	font-size:12px;
	line-height:23px;
	padding:0 10px 2px 0;
	letter-spacing:0;
	text-transform:uppercase;
	vertical-align:top;
	margin-right:-3px;
}
.n_button.tiny:hover span, .n_button.tiny:focus span, .horiz_bttns.tiny .n_button:hover span, .horiz_bttns.tiny .n_button:focus span, .l_sidebar .overlay .horiz_bttns.small .n_button:hover span, .l_sidebar .overlay .horiz_bttns.small .n_button:focus span {
	background-position:left -25px;
}
.n_button.tiny:hover em, .n_button.tiny:focus em, .horiz_bttns.tiny .n_button:hover em, .horiz_bttns.tiny .n_button:focus em, .l_sidebar .overlay .horiz_bttns.small .n_button:hover em, .l_sidebar .overlay .horiz_bttns.small .n_button:focus em {
	background-position:right -25px;
}
.n_button.tiny:active span, .n_button.tiny.disabled span, .horiz_bttns.tiny .n_button:active span, .horiz_bttns.tiny .n_button.disabled span, .l_sidebar .overlay .horiz_bttns.small .n_button:active span, .l_sidebar .overlay .horiz_bttns.small .n_button.disabled span {
	background-position:left -50px;
}
.n_button.tiny:active em, .n_button.tiny.disabled em, .horiz_bttns.tiny .n_button:active em, .horiz_bttns.tiny .n_button.disabled em, .l_sidebar .overlay .horiz_bttns.small .n_button:active em, .l_sidebar .overlay .horiz_bttns.small .n_button.disabled em {
	background-position:right -50px;
}
.n_button.tiny.main span, .n_button.tiny.main em, .horiz_bttns.tiny .n_button.main span, .horiz_bttns.tiny .n_button.main em, .l_sidebar .overlay .horiz_bttns.small .n_button.main span, .l_sidebar .overlay .horiz_bttns.small .n_button.main em {
	background-image:url(../images/std_btn_24_blue.png);
}

.n_button.small, .horiz_bttns.small .n_button {
	height:30px;
	display:inline-block;
	zoom:1;
*display:inline;
	cursor:pointer;
	background:none;
	white-space:nowrap;
}
.n_button.small span, .n_button.small em, .horiz_bttns.small .n_button span, .horiz_bttns.small .n_button em {
	display:inline-block;
	zoom:1;
}
.n_button.small span, .horiz_bttns.small .n_button span {
	height:30px;
	width:20px;
	margin-left:-3px;
}
.n_button.small em, .horiz_bttns.small .n_button em {
	background-position:right 0;
	background-position:right 0;
	height:28px;
	color:inherit;
	font-style:normal;
	font-size:16px;
	line-height:28px;
	padding:0 20px 2px 0;
	letter-spacing:1px;
	text-transform:uppercase;
	vertical-align:top;
	margin-right:-3px;
}
.n_button.small:hover span, .n_button.small:focus span, .horiz_bttns.small .n_button:hover span, .horiz_bttns.small .n_button:focus span {
	background-position:left -31px;
}
.n_button.small:hover em, .n_button.small:focus em, .horiz_bttns.small .n_button:hover em, .horiz_bttns.small .n_button:focus em {
	background-position:right -31px;
}
.n_button.small:active span, .n_button.small.disabled span, .horiz_bttns.small .n_button:active span, .horiz_bttns.small .n_button.disabled span {
	background-position:left -62px;
}
.n_button.small:active em, .n_button.small.disabled em, .horiz_bttns.small .n_button:active em, .horiz_bttns.small .n_button.disabled em {
	background-position:right -62px;
}
.n_button.small.main span, .n_button.small.main em, .horiz_bttns.small .n_button.main span, .horiz_bttns.small .n_button.main em {
	background-image:url(../images/bg_button_.png);
}
.n_button.medium, .n_button, .horiz_bttns.medium .n_button {
	height:50px;
	display:inline-block;
	zoom:1;
*display:inline;
	cursor:pointer;
	background:none;
	white-space:nowrap;
}
.n_button.medium span, .n_button.medium em, .n_button span, .n_button em, .horiz_bttns.medium .n_button span, .horiz_bttns.medium .n_button em {
	display:inline-block;
	zoom:1;
*display:inline;
}
.n_button.medium span, .n_button span, .horiz_bttns.medium .n_button span {
	height:50px;
	width:25px;
	margin-left:-3px;
}
.n_button.medium em, .n_button em, .horiz_bttns.medium .n_button em {
	background-position:right 0;
	background-position:right 0;
	height:48px;
	color:inherit;
	font-style:normal;
	font-size:20px;
	line-height:48px;
	padding:0 25px 2px 0;
	letter-spacing:1px;
	text-transform:uppercase;
	vertical-align:top;
	margin-right:-3px;
}
.n_button.medium:hover span, .n_button.medium:focus span, .n_button:hover span, .n_button:focus span, .horiz_bttns.medium .n_button:hover span, .horiz_bttns.medium .n_button:focus span {
	background-position:left -51px;
}
.n_button.medium:hover em, .n_button.medium:focus em, .n_button:hover em, .n_button:focus em, .horiz_bttns.medium .n_button:hover em, .horiz_bttns.medium .n_button:focus em {
	background-position:right -51px;
}
.n_button.medium:active span, .n_button.medium.disabled span, .n_button:active span, .n_button.disabled span, .horiz_bttns.medium .n_button:active span, .horiz_bttns.medium .n_button.disabled span {
	background-position:left -102px;
}
.n_button.medium:active em, .n_button.medium.disabled em, .n_button:active em, .n_button.disabled em, .horiz_bttns.medium .n_button:active em, .horiz_bttns.medium .n_button.disabled em {
	background-position:right -102px;
}
.n_button.big, .horiz_bttns.big .n_button {
	height:70px;
	display:inline-block;
	zoom:1;
*display:inline;
	cursor:pointer;
	background:none;
	white-space:nowrap;
}
.n_button.big span, .n_button.big em, .horiz_bttns.big .n_button span, .horiz_bttns.big .n_button em {
	display:inline-block;
	zoom:1;
*display:inline;
}
.n_button.big span, .horiz_bttns.big .n_button span {
	height:70px;
	width:30px;
	margin-left:-3px;
}
.n_button.big em, .horiz_bttns.big .n_button em {
	background-position:right 0;
	background-position:right 0;
	height:68px;
	color:inherit;
	font-style:normal;
	font-size:30px;
	line-height:68px;
	padding:0 30px 2px 0;
	letter-spacing:1px;
	text-transform:uppercase;
	vertical-align:top;
	margin-right:-3px;
}
.n_button.big:hover span, .n_button.big:focus span, .horiz_bttns.big .n_button:hover span, .horiz_bttns.big .n_button:focus span {
	background-position:left -71px;
}
.n_button.big:hover em, .n_button.big:focus em, .horiz_bttns.big .n_button:hover em, .horiz_bttns.big .n_button:focus em {
	background-position:right -71px;
}
.n_button.big:active span, .n_button.big.disabled span, .horiz_bttns.big .n_button:active span, .horiz_bttns.big .n_button.disabled span {
	background-position:left -142px;
}
.n_button.big:active em, .n_button.big.disabled em, .horiz_bttns.big .n_button:active em, .horiz_bttns.big .n_button.disabled em {
	background-position:right -142px;
}
.n_button {
	color:#09c;
	text-shadow:0 1px 0 #fff;
}
.n_button:hover, .n_button:focus {
	color:#036;
}
.n_button.disabled, .n_button:active {
	color:#ccc;
}
form .n_button {
	color:#999;
	text-shadow:0 1px 0 #fff;
}
form .n_button:hover, form .n_button:focus {
	color:#666;
}
form .n_button.disabled, form .n_button:active {
	color:#ccc;
}
.n_button.main {
	color:white;
	text-shadow:0 -1px 0 #666;
}
.n_button.main:hover, .n_button.main:focus {
	color:white;
}
.n_button.main.disabled, .n_button.main:active {
	color:#069;
}
.n_button.main.disabled, .n_button.main:active {
	text-shadow:0 1px 0 #ccc;
	color:#6d88ce;
}
input, textarea {
	border:none;
	background:white;
	resize:none;
	font-family:inherit;
}
input:focus, textarea:focus {
	outline:none;
}
input[type=text], input[type=password], input[type=email], textarea {
	-webkit-border-radius:0;
	-webkit-appearance:none;
}
input[type=submit], input[type=button], button {
	border:none;
	cursor:pointer;
	overflow:hidden;
	outline-style:none;
	margin:0;
	padding:0;
}
input[disabled], input[disabled]:hover {
	cursor:default;
}
button {
	padding-left:1em!important;
	padding-right:1em!important;
	margin-left:-1em!important;
	margin-right:-1em!important;
}
form.devaldi .cover {
	display:none;
}
form.devaldi label {
	font-size:14px;
	font-weight:bold;
	color:#333;
	float:left;
	text-transform:none;
	padding:0;
}
form.devaldi fieldset {
	padding:0;
}
form.devaldi fieldset label {
	float:none;
	font-weight:normal;
	color:#666;
	margin-left:5px;
	margin-right:10px;
}
form.devaldi fieldset .fieldWithErrors {
	display:inline;
}
form.devaldi .text, form.devaldi .textarea, form.devaldi .select {
	clear:left;
	position:relative;
	width:auto;
	background:white;
	color:#ccc;
}
form.devaldi .text .placeholder, form.devaldi .textarea .placeholder, form.devaldi .select .placeholder {
	font-size:inherit;
	font-style:italic;
	color:#ccc;
	position:absolute;
	top:0;
	bottom:0;
	left:0;
	right:0;
	width:auto;
	height:auto;
	z-index:1;
}
form.devaldi .text .effects, form.devaldi .textarea .effects, form.devaldi .select .effects {
	position:absolute;
	top:0;
	bottom:0;
	left:0;
	right:0;
	width:auto;
	height:auto;
	z-index:-1;
	border:1px solid #ccc;
}
form.devaldi .text .loader, form.devaldi .textarea .loader, form.devaldi .select .loader {
	display:none;
}
form.devaldi .text, form.devaldi .textarea {
	overflow:hidden;
	z-index:0;
}
form.devaldi input[type=text], form.devaldi input[type=password], form.devaldi input[type=email], form.devaldi textarea {
	margin:0;
	width:100%;
}
form.devaldi input[type=text]:focus, form.devaldi input[type=password]:focus, form.devaldi input[type=email]:focus, form.devaldi textarea:focus {
	background:transparent;
}
form.devaldi input[type=text]:focus+.effects, form.devaldi input[type=password]:focus+.effects, form.devaldi input[type=email]:focus+.effects, form.devaldi textarea:focus+.effects {
	-moz-box-shadow:inset 0 0 5px rgba(0, 0, 0, 0.5);
	-webkit-box-shadow:inset 0 0 5px rgba(0, 0, 0, 0.5);
	box-shadow:inset 0 0 5px rgba(0, 0, 0, 0.5);
	border:1px solid #999;
}
form.devaldi input[type=text]::-webkit-input-placeholder, form.devaldi input[type=password]::-webkit-input-placeholder, form.devaldi input[type=email]::-webkit-input-placeholder, form.devaldi textarea::-webkit-input-placeholder {
font-size:inherit;
font-style:italic;
color:#ccc;
}
form.devaldi .text.disabled, form.devaldi .textarea.disabled, form.devaldi .disabled .text, form.devaldi .disabled .textarea {
	background:#eee;
}
form.devaldi .text.disabled input[type=text], form.devaldi .text.disabled input[type=password], form.devaldi .text.disabled input[type=email], form.devaldi .text.disabled textarea, form.devaldi .textarea.disabled input[type=text], form.devaldi .textarea.disabled input[type=password], form.devaldi .textarea.disabled input[type=email], form.devaldi .textarea.disabled textarea, form.devaldi .disabled .text input[type=text], form.devaldi .disabled .text input[type=password], form.devaldi .disabled .text input[type=email], form.devaldi .disabled .text textarea, form.devaldi .disabled .textarea input[type=text], form.devaldi .disabled .textarea input[type=password], form.devaldi .disabled .textarea input[type=email], form.devaldi .disabled .textarea textarea {
	background:#eee;
}
form.devaldi .text.loading .loader, form.devaldi .textarea.loading .loader, form.devaldi .loading .text .loader, form.devaldi .loading .textarea .loader {
	display:block;
}
form.devaldi button {
	text-indent:0;
	background:transparent;
	width:auto;
	display:inline-block;
	zoom:1;
*display:inline;
	height:30px;
	overflow:visible;
}
form.devaldi button:focus {
	outline:none;
}
form.devaldi button::-moz-focus-inner {
border:0;
}
form.devaldi .formError {
	display:inline-block;
	zoom:1;
*display:inline;
	font-family:Georgia, Times, serif;
	font-style:italic;
	color:red;
	margin-left:8px;
}
form.devaldi .select {
	position:relative;
	z-index:1;
	cursor:pointer;
	outline:none;
}
form.devaldi .select select {
	display:none;
}
form.devaldi .select .button {
	float:right;
}
form.devaldi .select .selected {
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow:hidden;
	color:#000;
}
form.devaldi .select .selected.null {
	font-size:inherit;
	font-style:italic;
	color:#ccc;
}
form.devaldi .select>ul {
	font-size:12px;
	overflow-y:auto;
	background:white;
	-moz-box-shadow:0 2px 6px rgba(0, 0, 0, 0.5);
	-webkit-box-shadow:0 2px 6px rgba(0, 0, 0, 0.5);
	box-shadow:0 2px 6px rgba(0, 0, 0, 0.5);
	border-width:1px;
	border-style:solid;
	border-color:#fff #ccc #999;
	border-top-width:0;
	display:none;
	max-height:180px;
	margin:0;
}
form.devaldi .select>ul h3 {
	font-size:12px;
	line-height:22px;
	padding:0 8px;
	margin:0;
	font-weight:bold;
	color:#333;
}
form.devaldi .select>ul h3:first-child {
	margin-top:1px;
}
form.devaldi .select>ul li {
	list-style-type:none;
	list-style-position:outside;
	margin:0;
	padding:0;
	line-height:18px;
	padding:0 8px;
	min-height:14px;
	color:#666;
}
form.devaldi .select>ul li a {
	color:#666;
	background:transparent;
	display:block;
}
form.devaldi .select>ul li:hover, form.devaldi .select>ul li.highlighted {
	color:#333;
	background-color:#b5d5fe;
}
form.devaldi .select>ul li:hover a, form.devaldi .select>ul li.highlighted a {
	color:#333;
}
form.devaldi .select>ul li.active {
	color:#333;
	background:#ccc;
}
form.devaldi .select>ul li.active a {
	color:#333;
}
form.devaldi .select>ul li[data-value=""] {
	font-size:inherit;
	font-style:italic;
	color:#ccc;
}
form.devaldi .select li.optgroup {
	padding:0;
}
form.devaldi .select li.optgroup:hover, form.devaldi .select li.optgroup.active {
	background:transparent;
}
form.devaldi .select li.optgroup ul {
	margin:0!important;
}
form.devaldi .select li.optgroup li {
	padding-left:16px;
}
form.devaldi .select div.flag {
	float:right;
	width:14px;
	height:14px;
	visibility:hidden;
}
form.devaldi .select div.flag.true {
	visibility:visible;
}
form.devaldi .combobox {
	position:relative;
	z-index:1;
	clear:both;
	height:30px;
}
form.devaldi .combobox .text {
	position:absolute;
	top:0;
	bottom:0;
	left:0;
	right:0;
	width:auto;
	height:auto;
	z-index:2;
}
form.devaldi .combobox .select>ul {
	height:171px;
}
form.devaldi label, form.devaldi .formError {
	font-size:12px;
	line-height:18px;
	margin-bottom:1px;
	margin-top:5px;
}
form.devaldi fieldset {
	margin-top:10px;
}
form.devaldi fieldset label {
	font-size:10px;
}
form.devaldi .text, form.devaldi .textarea, form.devaldi input[type=text], form.devaldi input[type=password], form.devaldi input[type=email], form.devaldi textarea, form.devaldi .select {
	font-size:12px;
	line-height:16px;
}
form.devaldi .text {
	height:26px;
	border:none;
	padding:0 8px;
}
form.devaldi .text input[type=text], form.devaldi .text input[type=password], form.devaldi .text input[type=email] {
	height:16px;
	margin:5px 0;
}
form.devaldi .text .placeholder {
	margin:5px 8px;
}
form.devaldi .text .loader {
	position:absolute;
	top:5px;
	bottom:auto;
	left:auto;
	right:8px;
	width:16px;
	height:16px;
}
form.devaldi .textarea {
	height:50px;
	border:none;
	padding:0 8px;
}
form.devaldi .textarea textarea {
	height:40px;
	margin:5px 0;
}
form.devaldi .textarea .placeholder {
	margin:5px 8px;
}
form.devaldi .textarea .loader {
	position:absolute;
	top:5px;
	bottom:auto;
	left:auto;
	right:8px;
	width:16px;
	height:16px;
}
form.devaldi .select, form.devaldi .combobox {
	height:26px;
}
form.devaldi .select .selected {
	height:26px;
	line-height:26px;
	padding:0 8px;
}
form.devaldi .select .button {
	text-indent:-1337px;
	overflow:hidden;
	height:26px;
	background-position:left 0;
	width:22px;
}
form.devaldi .select .button:hover, form.devaldi .select .button:focus {
	background-position:left -27px;
}
form.devaldi .select .button:active, form.devaldi .select .button.disabled {
	background-position:left -54px;
}
form.devaldi .select .button.clicked {
	height:26px;
	background-position:right 0;
}
form.devaldi .select .button.clicked:hover, form.devaldi .select .button.clicked:focus {
	background-position:right -27px;
}
form.devaldi .select .button.clicked:active, form.devaldi .select .button.clicked.disabled {
	background-position:right -54px;
}
form.devaldi .combobox .text {
	right:22px;
}
blockquote.fancy_quote {
	font-family:Georgia, Times, serif;
	font-size:16px;
	font-style:italic;
	color:#333;
}
.headerx {
	height:80px;
	background:transparent url(../images/bg_head.png) repeat-x 0 0;
}
.headerx .logo {
	float:left;
	margin-left:25px;
	margin-top:7px;
}
.headerx h1 {
	float:right;
	margin-right:24px;
	margin-top:20px;
	margin-bottom:0;
	height:30px;
	font-size:13px;
	line-height:15px;
	font-weight:bold;
	color:black;
	color:#39c;
	background:transparent url(../images/bg_heae.png) no-repeat center bottom;
}
.headerx h1.replaced {
	background:none;
	width:200px;
}
.headerx h1.replaced img {
	float:right;
	padding-bottom:15px;
	margin:0;
	background:transparent url(../images/bg_heae.png) no-repeat center bottom;
}
.section_app, .section_error {
	background:#eee;
}
.section_app #underlay, .section_error #underlay {
	position:absolute;
	left:0;
	right:0;
	top:auto;
	z-index:-1;
	background:#eee;
	display:none;
}
.section_app #content, .section_error #content {
	margin-left:auto;
	margin-right:auto;
	width:960px;
}
.section_app, .section_error, .section_app #header, .section_error #header, .section_app #underlay, .section_error #underlay, .section_app #content, .section_error #content, .section_app #footer, .section_error #footer {
	min-width:960px;
}
.section_app #header #header_content, .section_error #header #header_content {
	width:940px;
	margin:0 auto;
}
.section_app #header .logo, .section_error #header .logo {
	margin-left:-5px;
}
.section_app #header #nav, .section_error #header #nav {
	float:right;
	margin:0;
}
.section_app #header #nav li, .section_error #header #nav li {
	list-style-type:none;
	list-style-position:outside;
	margin:0;
	padding:0;
	float:left;
	margin-left:36px;
}
.section_app #header #nav li a, .section_error #header #nav li a {
	margin-top:50px;
	margin-bottom:0;
	height:30px;
	font-size:13px;
	line-height:15px;
	font-weight:bold;
	color:black;
	display:block;
	text-indent:-1337px;
	overflow:hidden;
	height:15px;
	background-position:left 0;
}
.section_app #header #nav li a:hover, .section_error #header #nav li a:hover, .section_app #header #nav li a:focus, .section_error #header #nav li a:focus {
	background-position:left -16px;
}
.section_app #header #nav li a.clicked, .section_error #header #nav li a.clicked {
	height:15px;
	background-position:right 0;
}
.section_app #header #nav li a.clicked:hover, .section_error #header #nav li a.clicked:hover, .section_app #header #nav li a.clicked:focus, .section_error #header #nav li a.clicked:focus {
	background-position:right -16px;
}
.section_app #header #nav li .login, .section_error #header #nav li .login {
	background:transparent url(../images/button_hdr_.png) no-repeat 0 0;
	width:35px;
}
.section_app #header #nav li .home, .section_error #header #nav li .home {
	background:transparent url(../images/button_hdr_home.png) no-repeat 0 0;
	width:40px;
}

.section_app #header #nav li .admin, .section_error #header #nav li .admin {
	background:transparent url(../images/button_hdr_publisher.png) no-repeat 0 0;
	width:66px;
}

.section_app #header #nav li .about, .section_error #header #nav li .about {
	background:transparent url(../images/button_hdr_about.png) no-repeat 0 0;
	width:44px;
}

.section_app #header #nav li .plugins, .section_error #header #nav li .plugins {
	background:transparent url(../images/button_hdr_plugins.png) no-repeat 0 0;
	width:49px;
}

.section_app #header #nav li .download, .section_error #header #nav li .download {
	background:transparent url(../images/button_hdr_download.png) no-repeat 0 0;
	width:68px;
}

.section_app #header #nav li .demo, .section_error #header #nav li .demo {
	background:transparent url(../images/button_hdr_demo.png) no-repeat 0 0;
	width:66px;
}

.section_app #header #nav li .docs, .section_error #header #nav li .docs {
	background:transparent url(../images/button_hdr_docs.png) no-repeat 0 0;
	width:40px;
}

.section_app #header #nav li.current, .section_error #header #nav li.current {
	padding-bottom:10px;
	background:transparent url(../images/bg_heae.png) no-repeat center bottom;
}
.section_app #header #nav li.current a, .section_error #header #nav li.current a {
	background-position:0 -16px;
}
.section_app #header.no_current .logo, .section_error #header.no_current .logo {
	padding-bottom:13px;
	background:transparent url(../images/bg_heae.png) no-repeat center bottom;
}
.section_app #content, .section_error #content {
	min-height:0;
}
.section_app #content:after, .section_error #content:after {
	clear:both;
	content:" ";
	display:block;
	visibility:hidden;
	height:0;
	font-size:0;
}
.section_app #content, .section_error #content {
	margin-top:30px;
}
.section_app #content>h1, .section_error #content>h1 {
	margin:4px 0 4px 10px;
}
.section_app #side_panel, .section_error #side_panel {
	float:left;
}
.section_app #side_panel .aside, .section_error #side_panel .aside {
	margin:20px 10px;
}
.section_app #main.editable, .section_error #main.editable {
	margin-right:120px;
}
.section_app .primary, .section_error .primary {
	-moz-box-shadow:0 2px 4px rgba(0, 0, 0, 0.25);
	-webkit-box-shadow:0 2px 4px rgba(0, 0, 0, 0.25);
	box-shadow:0 2px 4px rgba(0, 0, 0, 0.25);
	border-width:1px;
	border-style:solid;
	border-color:#fff #ccc #999;
	padding:60px 60px 36px;
	position:relative;
}
.section_app .primary #tab_decoration, .section_error .primary #tab_decoration {
	position:absolute;
	top:-2px;
	bottom:auto;
	left:auto;
	right:-2px;
	width:auto;
	height:auto;
	margin:0;
}
.section_app .primary .tab, .section_error .primary .tab {
	background:transparent;
	border:none;
	padding:0;
}
#overlays {
	width:100%;
	height:100%;
	position:fixed;
	top:0;
	left:0;
	display:none;
	z-index:1338;
}
.section_auth form#login {
	margin-left:auto;
	margin-right:auto;
}
.section_auth form#login h2 {
	margin:16px auto 0;
	width:49px;
	font-size:18px;
}
.section_auth form#login fieldset {
	float:left;
}
.section_auth form#login fieldset {
	margin-top:20px;
}
.section_auth #links {
	position:absolute;
	top:auto;
	bottom:24px;
	left:auto;
	right:30px;
	width:auto;
	height:auto;
	margin:0;
}
.section_auth #links li {
	list-style-type:none;
	list-style-position:outside;
	margin:0;
	padding:0;
	text-align:right;
	font-size:10px;
}
.section_auth #links a:hover {
	color:#333;
	background:transparent;
}
.section_auth #links .join {
	color:#666;
}
.section_auth #links .forgot {
	color:#999;
}
.section_auth #no_cookies {
	display:none;
}
.section_auth #no_cookies>img {
	float:left;
}
.section_auth #no_cookies p, .section_auth #no_cookies h2 {
	margin-left:120px;
}
.section_users.section_auth #content, .section_users.v_password_reset_request_new #content, .section_users.v_password_reset_request_create #content, .section_users.v_password_reset_new #content, .section_users.v_password_reset_create #content {
	margin-top:60px;
}
.section_users.section_auth #lock, .section_users.v_password_reset_request_new #lock, .section_users.v_password_reset_request_create #lock, .section_users.v_password_reset_new #lock, .section_users.v_password_reset_create #lock {
	float:left;
	margin-right:40px;
	margin-bottom:-20px;
}
.section_users.section_auth .right_column, .section_users.v_password_reset_request_new .right_column, .section_users.v_password_reset_request_create .right_column, .section_users.v_password_reset_new .right_column, .section_users.v_password_reset_create .right_column {
	float:left;
	width:260px;
	margin-top:60px;
}
.section_users.section_auth .left_column, .section_users.v_password_reset_request_new .left_column, .section_users.v_password_reset_request_create .left_column, .section_users.v_password_reset_new .left_column, .section_users.v_password_reset_create .left_column {
	float:right;
	width:260px;
	margin-top:60px;
}
.section_users.section_auth h2, .section_users.v_password_reset_request_new h2, .section_users.v_password_reset_request_create h2, .section_users.v_password_reset_new h2, .section_users.v_password_reset_create h2 {
	margin-bottom:10px;
}
.section_users.section_auth #enterprise, .section_users.v_password_reset_request_new #enterprise, .section_users.v_password_reset_request_create #enterprise, .section_users.v_password_reset_new #enterprise, .section_users.v_password_reset_create #enterprise {
	float:right;
	margin-left:40px;
	margin-bottom:-30px;
}
.section_users.section_auth #enterprise+.right_column, .section_users.v_password_reset_request_new #enterprise+.right_column, .section_users.v_password_reset_request_create #enterprise+.right_column, .section_users.v_password_reset_new #enterprise+.right_column, .section_users.v_password_reset_create #enterprise+.right_column {
	float:right;
}
.section_users.section_auth #enterprise+.left_column, .section_users.v_password_reset_request_new #enterprise+.left_column, .section_users.v_password_reset_request_create #enterprise+.left_column, .section_users.v_password_reset_new #enterprise+.left_column, .section_users.v_password_reset_create #enterprise+.left_column {
	float:left;
}
.section_users.section_auth #content {
	position:relative;
}
.section_users.section_auth #no_cookies {
	position:absolute;
	top:70px;
	right:0;
	height:270px;
	width:420px;
	background-color:#EEE;
}
.section_users.section_auth #no_cookies .horiz_bttns {
	display:none;
}
.section_users.section_auth #login h2 {
	width:189px;
}
.section_users.section_auth #login fieldset {
	margin-top:0;
}
.section_users.section_auth #links {
	position:relative;
	top:-104px;
	bottom:auto;
	left:auto;
	right:auto;
	width:auto;
	height:auto;
}
.section_users.section_auth .horiz_bttns {
	margin-top:5px;
}
.clearfix:after {
	content:".";
	display:block;
	height:0;
	clear:both;
	visibility:hidden;
	line-height:0;
	font-size:0;
}
.clearfix {
	display:inline-block;
}
html[xmlns] .clearfix {
	display:block;
}
* html .clearfix {
	height:1%;
}
#global_footer {
	text-align:center;
	padding-top:24px;
	margin:0 auto;
	width:970px;
	position:relative;
}
#footer {
	width:100%;
}
#footer_midbar {
	background-color:#888888;
	height:14px;
}



#global_footer #media-resources_box li {
	color:#fff;
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	font-weight:bold;
	margin-bottom:11px;
	padding-top:0;
}
#global_footer ul {
	float:left;
	color:white;
	list-style:none;
	margin-left:2.5em;
}
#global_footer li {
	font-family:Arial, Helvetica, sans-serif;
	font-size:11px;
	padding-top:8px;
	padding-left:15px;
	text-align:left;
	margin:0;
	color:#fda58a;
}
#global_footer a, #global_footer a:visited, #global_footer a:hover {
	color:#FFC2AF;
	text-decoration:none;
	font-weight:normal;
}
#global_footer h4, #global_footer h4 a, #global_footer h4 a:visited, #global_footer h4 a:hover, #global_footer #media-resources_box a {
	font-family:Arial, Helvetica, sans-serif;
	font-weight:bold;
	font-size:12px;
	text-align:left;
	color:#fff;
	margin:0;
	padding:0;
}
#copyright_statement {
	font-size:11px;
	color:#333;
	padding-top:1.0em;
	text-align:left;
	clear:both;
	width:970px;
	margin:0 auto;
}
#footer_disclaimer {
	font-size:11px;
	color:#333;
	margin:7px auto 0;
	width:970px;
}
a.footer_link, a.footer_link:link, a.footer_link:visited, a.footer_link:active, a.footer_link:hover {
	color:#FFC2AF;
	padding-left:1em;
}
body.footer_small #container {
	padding-bottom:85px;
}
#footer {
	position:relative;
	clear:both;
	margin-top:0px;
	background-color:#3b3b3a;
}
body.footer_small #footer {
	height:85px;
	margin-top:-85px;
}
#footer .logo {
	background-image:url(../images/footer_logo.gif);
	background-repeat:no-repeat;
}
p.footer {
	padding-left:8px;
	padding-right:8px;
	font-family:Georgia;
	font-size:11px;
}
#company_content_container {
	width:100%;
	overflow:hidden;
	background-color:#e77046;
	height:130px;
}
#logo_box {
	margin-right:16px;
	width:130px;
	height:100px;
	background-image:url(../images/footer_logo.gif);
	background-repeat:no-repeat;
	background-position:top left;
	text-indent:-9999px;
	float:left;
}

ul#process {
	background:#bbb;
	list-style:none;
	float:left;
	display:block;
	width:100%;
	margin:20px 0 0 0;
	border-radius:3px; 
	-webkit-border-radius:3px;
	-moz-border-radius:3px; 
}

ul#process.end {background:#76b41c;}

ul#process li {
	background:transparent url(../images/bg_process_default.gif) top right no-repeat;
	text-shadow: #FFF 0px 0px 2px;
	float:left;
	height:24px;
	line-height:24px;
	padding:0 20px 0 6px;
}

ul#process li.last {
	background:none;
}

ul#process li.first {
	padding-left:15px;
	border-top-left-radius:3px;
	border-bottom-left-radius:3px; 
	-webkit-border-top-left-radius: 3px;
	-webkit-border-bottom-left-radius: 3px;
	-moz-border-radius-topleft: 3px;  
	-moz-border-radius-bottomleft: 3px;
}

ul#process li.active {
	color:#fff;
	text-shadow:#eee 0px 0px 1px;
	background:#d7bfa3 url(../images/bg_process_active.gif) top right no-repeat;
	padding-right:20px;   
} 

ul#process li.prevactive {
	color:#fff;
	text-shadow:#ccc 0px 0px 6px;
	background:#d7a66d url(../images/bg_process_prevactive.gif) top right no-repeat;
}   

ul#process li.complete {
	color:#fff;
	text-shadow:#3a5810 0px 0px 2px;
	background:#d7a66d url(../images/bg_process_complete.gif) top right no-repeat;
}

ul#process li.complete span, ul#process li.prevactive span {background:transparent url(../images/icon_check_process_12px.gif) 0 50% no-repeat;}

ul#process li span {display:block;}

ul#process li.complete span, ul#process li.prevactive span {padding-left:18px;}

ul#process.end  li.active {background:none;}

table.sortable {width:630px;margin:0 0 24px 0;border-collapse:collapse;}
table.sortable th {padding:6px 10px;text-align:center;color:#555;border-right:1px solid #CCC;background:#DEDEDE;font-size:13px;font-weight:bold;} 
table.sortable td {padding:10px;text-align:center;border:1px solid #ccc;background:#efefef;font-size:12px;vertical-align:middle;}
table.sortable th.title, table.sortable td.title {text-align:left;}
table.sortable td.title {vertical-align:top;}

table.sortable td.fail, table.sortable td.warn, table.sortable td.pass {color:#fff;}
table.sortable td.fail { background: #b4001c !important; }
table.sortable td.warn { background: #A7AF35 !important; }
table.sortable td.pass { background: #9dc16a !important; }

table.selectable_sortable {width:630px;margin:0 0 24px 0;border-collapse:collapse;}
table.selectable_sortable th {padding:6px 10px;text-align:center;color:#555;border-right:1px solid #CCC;background:#DEDEDE;font-size:13px;font-weight:bold;} 
table.selectable_sortable td {padding:10px;text-align:center;border:1px solid #ccc;font-size:12px;vertical-align:middle;}
table.selectable_sortable th.title, table.selectable_sortable td.title {text-align:left;}
table.selectable_sortable td.title {vertical-align:top;}

table.selectable_sortable td.fail, table.selectable_sortable td.warn, table.selectable_sortable td.pass {color:#fff;}
table.selectable_sortable td.fail { background: #b4001c !important; }
table.selectable_sortable td.warn { background: #A7AF35 !important; }
table.selectable_sortable td.pass { background: #9dc16a !important; }
.page{ margin:5px;}
.curr_page{ margin:5px; font-weight:bold;}
.hover { background-color: #106166; color: #fff; cursor:pointer; }


 .selectedRow {
      background-color: #dcdcdc;
      cursor: pointer;
}

.unselectedRow {
	background-color: #efefef;
    cursor: pointer;
}

.checkedRow{
	background-color: #ededed;
    cursor: pointer;	
}
   
h4.warn {
	background:transparent url(../images/icon_warn.png) 0 50% no-repeat;
	height:24px;
	line-height:24px;
	padding-left:32px;
	margin-bottom:8px;
}

ul.list {
	font-size:12px;
	list-style:disc;
	margin-bottom:15px;
	margin-left:25px;
	width:90%;
}

ul.list li {
	padding-left:14px;
	line-height:1.5;
	padding-bottom:10px;
	margin-bottom:20px;
}

</style>
</head>
<body>
	<div id="body_proxy" class="section_users section_auth section_app" style="min-height:85%;">
		<div id="underlay"></div>
		<div id="content" style="margin-top:0px;">
	<div style="width:690px;clear:both;padding: 20px 10px 20px 10px;">
		<ul id="process" style="margin-bottom:10px;">

			<li class="first active"><span>{*[cn.myapps.km.necessary_components_installed]*}</span></li>

		</ul>
	</div>
	<div style="clear:both;background-color:#fff;padding: 20px 10px 20px 30px;border:0px;-webkit-box-shadow: rgba(0, 0, 0, 0.246094) 0px 4px 8px 0px;min-width:650px;float:left;width:650px;margin-left:10px;margin-bottom:50px;">

		<script type="text/javascript">
			function updatepdf2jsonpath(){
				$('#bttn_final').hide();
				$('#bttn_updatepath_pdf2json').show();
			}
			function updatepdf2swfpath(){
				$('#bttn_final').hide();
				$('#bttn_updatepath_pdf2swf').show();				
			}
		</script>
		<h3>{*[cn.myapps.km.server_components_necessary]*}</h3>
		<table width="100%" cellspacing="0" cellpadding="0" class="sortable">
			<tr>
				<th class="title">{*[cn.myapps.km.components_name]*}</th>
				<th class="tr">{*[cn.myapps.km.install_state]*}</th>
			</tr>
			<tr><td class="title">{*[cn.myapps.km.wps_office]*}</td> <%if(Config.previewEnabled()){ %><td class="pass">Yes</td><%} else {%><td class="fail">No</td> <%} %></tr>
			<tr><td class="title">SWFTools</td><%if(Config.pdf2swfEnabled()){ %><td class="pass">Yes</td><%} else {%><td class="fail">No</td> <%} %></tr>
		</table>

		<h4 class="warn">{*[cn.myapps.km.installed_tip]*}</h4>
		<ul class="list" style="margin-top:30px">
			<li>{*[cn.myapps.km.install_wps_office]*} <a href='http://www.wps.cn' target="_blank">www.wps.cn</a>{*[cn.myapps.km.wps_office_tip]*}</li>
			<li>{*[cn.myapps.km.install_swf_tools]*} <a href='http://www.swftools.org/swftools-0.9.0.exe' target="_blank">swftools.org</a>{*[cn.myapps.km.swf_tools_tip]*}<br/><br/>{*[cn.myapps.km.install_success_tip]*}</li>
			<li>{*[cn.myapps.km.install_help]*}</li>
		</ul>			

		<div style="margin-top:10px;float:right;display:block" id="bttn_final">
			<%if(Config.previewEnabled()) {%>
				<button class="" type="submit" onclick="location.href='setup.jsp?action=init'"><span></span><em style="min-width:150px">{*[cn.myapps.km.enter_the_system]*} </em></button>&nbsp;<br/>
			<%}else {%>
				<button class="" type="submit" onclick="location.href='setup.jsp?action=refresh'"><span></span><em style="min-width:150px">{*[cn.myapps.km.re-tested]*} </em></button>&nbsp;<br/>
			<%}%>
			
		</div>

	</div>
	</DIV>
</DIV>
</BODY>
</o:MultiLanguage></html>