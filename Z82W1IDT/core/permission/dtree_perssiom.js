/*--------------------------------------------------|
| dTree 2.05 | www.destroydrop.com/javascript/tree/ |
|---------------------------------------------------|
| Copyright (c) 2002-2003 Geir Landr                |
|                                                   |
| This script can be used freely as long as all     |
| copyright messages are intact.                    |
|                                                   |
| Updated: 17.04.2003                               |
|--------------------------------------------------*/

// Node object
function Node(id, pid, name, url, title, target, icon, iconOpen, open, checked,
		page, extCheckboxOnclick) {
	this.id = id;
	this.pid = pid;
	this.name = name;
	this.url = url;
	this.title = title;
	this.target = target;
	this.icon = icon;
	this.iconOpen = iconOpen;
	this.checked = checked;
	this.page = page;
	this.extCheckboxOnclick = extCheckboxOnclick;
	this._io = open || false;
	this._is = false;
	this._ls = false;
	this._hc = false;
	this._ai = 0;
	this._p;
};

// Tree object
function dTree(objName, targetID, selectItemName) {
	this.config = {
		target : null,
		folderLinks : true,
		useSelection : true,
		useCookies : false,
		useLines : true,
		useIcons : true,
		useStatusText : false,
		closeSameLevel : false,
		inOrder : false,
		multiSelect : false,
		selectChild : false
	}
	this.icon = {
		root : '',
		folder : '',
		folderOpen : '',
		node : '',
		empty : '',
		line : '',
		join : '',
		joinBottom : '',
		plus : '',
		plusBottom : '',
		minus : '',
		minusBottom : '',
		nlPlus : '',
		nlMinus : ''
	};

	this.icon.root = '../../resource/images/dtree/base.gif';
	this.icon.folder =  '../../resource/images/dtree/folder.gif';
	this.icon.folderOpen = '../../resource/images/dtree/folderopen.gif';
	this.icon.node = '../../resource/images/dtree/page.gif';
	this.icon.empty = '../../resource/images/dtree/empty.gif';
	this.icon.line = '../../resource/images/dtree/line.gif';
	this.icon.join = '../../resource/images/dtree/join.gif';
	this.icon.joinBottom = '../../resource/images/dtree/joinbottom.gif';
	this.icon.plus = '../../resource/images/dtree/plus.gif';
	this.icon.plusBottom = '../../resource/images/dtree/plusbottom.gif';
	this.icon.minus = '../../resource/images/dtree/minus.gif';
	this.icon.minusBottom = '../../resource/images/dtree/minusbottom.gif';
	this.icon.nlPlus = '../../resource/images/dtree/nolines_plus.gif';
	this.icon.nlMinus = '../../resource/images/dtree/nolines_minus.gif'

	this.obj = objName;
	this.aNodes = [];
	this.aIndent = [];
	this.root = new Node(-1);
	this.selectedNode = null;
	this.selectedFound = false;
	this.completed = false;
	this.loadeds = {};
	this.aNodesData = []; // This array save the original data all the time.
	this.targetID = targetID || 'dtree';
	this.selectItemName = selectItemName ? selectItemName: "_selectitem";//checkbox name
};

// Adds a new node to the node array
dTree.prototype.add = function(id, pid, name, url, title, target, icon,
		iconOpen, open, checked, page, extCheckboxOnclick) {
	this.aNodes[this.aNodes.length] = new Node(id, pid, name, url, title,
			target, icon, iconOpen, open, checked, page, extCheckboxOnclick);
};

// Open/close all nodes
dTree.prototype.openAll = function() {
	this.oAll(true);
};
dTree.prototype.closeAll = function() {
	this.oAll(false);
};

// Outputs the tree to the page
dTree.prototype.toString = function() {
	var str = '<div class="dtree">\n';
	if (document.getElementById) {
		if (this.config.useCookies)
			this.selectedNode = this.getSelected();
		str += this.addNode(this.root);
	} else
		str += 'Browser not supported.';
	str += '</div>';
	if (!this.selectedFound)
		this.selectedNode = null;
	this.completed = true;
	return str;
};

// Creates the tree structure
dTree.prototype.addNode = function(pNode) {
	var str = '';
	var n = 0;
	if (this.config.inOrder)
		n = pNode._ai;
	for (n; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == pNode.id) {
			var cn = this.aNodes[n];
			cn._p = pNode;
			cn._ai = n;
			this.setCS(cn);
			if (!cn.target && this.config.target)
				cn.target = this.config.target;
			if (cn._hc && !cn._io && this.config.useCookies)
				cn._io = this.isOpen(cn.id);
			if (!this.config.folderLinks && cn._hc)
				cn.url = null;
			if (this.config.useSelection && cn.id == this.selectedNode
					&& !this.selectedFound) {
				cn._is = true;
				this.selectedNode = n;
				this.selectedFound = true;
			}
			str += this.node(cn, n);
			if (cn._ls)
				break;
		}
	}
	return str;
};

/*
dTree.prototype.updateCheckStatus = function(nId, obj) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].id == nId) {
			// alert("Checked ID: " + nId);
			this.aNodes[n].checked = obj.checked ? "checked" : "";
			break;
		}
	}
}*/

dTree.prototype.updateCheckStatus = function(nId, obj) {	
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].id == nId) {			
			this.aNodes[n].checked = obj.checked ? "checked" : "";			
			break;
		}
	}	
	if('root'==nId){		
		var aa = document.getElementsByName(this.selectItemName);
		if(this.selectChild){
			for(var i=0;i<aa.length;i++){
				aa[i].checked = obj.checked;
			}
		}
	}else{
		var sub = document.getElementsByName(this.selectItemName);
		if(sub){
			var snumber=0;	
			//alert(sub[0].checked);
			for(var i=0;i<sub.length;i++){
				if(sub[i].checked) snumber++;			
			}
			//var root = document.getElementsByName("TEMPALL"+this.selectItemName);
			var root=document.getElementById("TEMPALL_id");
			if(root){				
				if(snumber==sub.length){			
					root.checked=true;
				}else{
					root.checked=false;
				}
			}			
		}
	}
}

// Creates the node icon, url and text
dTree.prototype.node = function(node, nodeId) {
	var str = '<div class="dTreeNode">' + this.indent(node, nodeId);
	if (this.config.multiSelect) {
		if (!this.config.selectChild || !node._hc) {
			var temp_item=('root'==node.id)?("TEMPALL"+this.selectItemName):this.selectItemName;
			var temp_id=('root'==node.id)?("TEMPALL_id"):"";
			//str += '<input type="checkbox" name="'+this.selectItemName+'" class="checkbox" value="'
			str += '<input type="checkbox" id="'+temp_id+'" name="'+temp_item+'" class="checkbox" value="'
					+ node.title + '"' 
					+ ' text="' + node.name + '"'
					+ ' onClick="'
					+ this.obj
					+ '.updateCheckStatus(\'' + node.id + '\', this);'
					+ node.extCheckboxOnclick + '"';
			// alert("Node Checked(" + node.id + ")->" + node.checked);
			if (node.checked)
				str += node.checked;
			str += '>'; // to do
		}
	}
	if (this.config.useIcons) {
		if (!node.icon)
			node.icon = (this.root.id == node.pid)
					? this.icon.root
					: ((node._hc) ? this.icon.folder : this.icon.node);
		if (!node.iconOpen)
			node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
		if (this.root.id == node.pid) {
			node.icon = this.icon.root;
			node.iconOpen = this.icon.root;
		}
		str += '<img id="i' + this.obj + nodeId + '" src="'
				+ ((node._io) ? node.iconOpen : node.icon) + '" alt="" />';
	}
	if (this.config.multiSelect) {
		if (node._hc)
			str += '<a href="###" onclick="' + this.obj + '.o(' + nodeId + ')" class="node">';
	} else if (node.url) {
		if (!this.config.selectChild || !node._hc) {
			str += '<a id="s'
					+ this.obj
					+ nodeId
					+ '" class="'
					+ ((this.config.useSelection) ? ((node._is
							? 'nodeSel'
							: 'node')) : 'node');
			var index = node.url.toLowerCase().indexOf("javascript");
			if (index != -1){
				str += '" href="###" onclick="'+ node.url.substring(index + "javascript:".length) + '"';
			}else {
				str += '" href="' + node.url + '"';
			}
			if (node.title)
				str += ' title="' + node.title + '"';
			if (node.target)
				str += ' target="' + node.target + '"';
			if (this.config.useStatusText)
				str += ' onmouseover="window.status=\''
						+ node.name
						+ '\';return true;" onmouseout="window.status=\'\';return true;" ';
			if (this.config.useSelection
					&& ((node._hc && this.config.folderLinks) || !node._hc))
				str += ' onclick="javascript: ' + this.obj + '.s(' + nodeId
						+ ');"';
			str += '>';
		} else {
			str += '<a href="###" onclick="' + this.obj + '.o(' + nodeId + ')" class="node">';
		}
	} else if ((!this.config.folderLinks || !node.url) && node._hc)
		str += '<a href="###" onclick="' + this.obj + '.o(' + nodeId + ')" class="node">';
	str += '<span>' + node.name + '</span>';
	if (node.url || ((!this.config.folderLinks || !node.url) && node._hc))
		str += '</a>';
	str += '</div>';
	if (node._hc) {
		str += '<div id="d' + this.obj + nodeId
				+ '" class="clip" style="display:'
				+ ((this.root.id == node.pid || node._io) ? 'block' : 'none')
				+ ';">';
		str += this.addNode(node);
		str += '</div>';
	}
	this.aIndent.pop();
	return str;
};

// Adds the empty and line icons
dTree.prototype.indent = function(node, nodeId) {
	var str = '';
	for (var n = 0; n < this.aIndent.length; n++)
		str += '<img src="'
				+ ((this.aIndent[n] == 1 && this.config.useLines)
						? this.icon.line
						: this.icon.empty) + '" alt="" />';
	(node._ls) ? this.aIndent.push(0) : this.aIndent.push(1);
	if (node._hc) {
		str += '<a href="###" onclick="' + this.obj + '.o(' + nodeId + ')"><img id="j' + this.obj + nodeId + '" src="';
		if (!this.config.useLines)
			str += (node._io) ? this.icon.nlMinus : this.icon.nlPlus;
		else
			str += ((node._io) ? ((node._ls && this.config.useLines)
					? this.icon.minusBottom
					: this.icon.minus) : ((node._ls && this.config.useLines)
					? this.icon.plusBottom
					: this.icon.plus));
		str += '" alt="" /></a>';
	} else
		str += '<img src="'
				+ ((this.config.useLines) ? ((node._ls)
						? this.icon.joinBottom
						: this.icon.join) : this.icon.empty) + '" alt="" />';
	return str;
};

// Checks if a node has any children and if it is the last sibling
dTree.prototype.setCS = function(node) {
	var lastId;
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id || node.page) // 瀛樺湪瀛愯妭鐐?
			node._hc = true;
		// if (this.aNodes[n].pid == node.id)
		// node._hc = true;
		if (this.aNodes[n].pid == node.pid)
			lastId = this.aNodes[n].id;
	}
	if (lastId == node.id)
		node._ls = true;
};

// Returns the selected node
dTree.prototype.getSelected = function() {
	var sn = this.getCookie('cs' + this.obj);
	return (sn) ? sn : null;
};

// Highlights the selected node
dTree.prototype.s = function(id) {
	if (!this.config.useSelection)
		return;
	var cn = this.aNodes[id];
	if (cn._hc && !this.config.folderLinks)
		return;
	if (this.selectedNode != id) {
		if (this.selectedNode || this.selectedNode == 0) {
			eOld = document.getElementById("s" + this.obj + this.selectedNode);
			eOld.className = "node";
		}
		eNew = document.getElementById("s" + this.obj + id);
		eNew.className = "nodeSel";
		this.selectedNode = id;
		if (this.config.useCookies)
			this.setCookie('cs' + this.obj, cn.id);
	}
};

// Toggle Open or close
dTree.prototype.o = function(id) {
	var cn = this.aNodes[id];

	if (cn.page && !this.loadeds[cn.id]) {
		this.getChildren(id, cn.page, cn.id);
	}
	this.nodeStatus(!cn._io, id, cn._ls);
	cn._io = !cn._io;
	if (this.config.closeSameLevel)
		this.closeLevel(cn);
	if (this.config.useCookies)
		this.updateCookie();
};

// Open or close all nodes
dTree.prototype.oAll = function(status) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n]._hc) {
			this.nodeStatus(status, n, this.aNodes[n]._ls)
			this.aNodes[n]._io = status;
		}
	}
	if (this.config.useCookies)
		this.updateCookie();
};

/**
 * Ajax鑾峰彇瀛愯妭鐐?
 * 
 * @param {}
 *            id
 * @param {}
 *            page
 * @param {}
 *            pid
 */
dTree.prototype.getChildren = function(id, page, pid) {

	var ajax = null;

	if (window.ActiveXObject) {

		try {

			ajax = new ActiveXObject("Microsoft.XMLHTTP");

		} catch (e) {

			alert("鍒涘缓Microsoft.XMLHTTP瀵硅薄澶辫触,AJAX涓嶈兘姝ｅ父杩愯.璇锋鏌ユ偍鐨勬祻瑙堝櫒璁剧疆.");
		}

	} else {

		if (window.XMLHttpRequest) {

			try {

				ajax = new XMLHttpRequest();

			} catch (e) {

				alert("鍒涘缓XMLHttpRequest瀵硅薄澶辫触,AJAX涓嶈兘姝ｅ父杩愯.璇锋鏌ユ偍鐨勬祻瑙堝櫒璁剧疆.");
			}

		}
	}

	// following is just for xiaosilent's Sales Management System.
	// Server gives me a message like this :
	// id1,name1,childCount1|id2,name2,childCount2|...
	// var url ="/servlet/category?action=getChildren&parentID=" + pid +"&type="
	// + this.type;

	var url = "";

	if (page) {
		url = page;
		if (pid) {
			url += (page.indexOf("?") != -1 ? "&" : "?") + "pid=" + pid;
		}
	}

	// use this to get this dTree object in the following function.
	var tree = this;

	ajax.onreadystatechange = function() {

		if (ajax.readyState == 4 && ajax.status == 200) {
			if (ajax.responseText == "false") {
				return;
			}
			var json = ajax.responseText;

			var nodes = eval(json);
			for (var i = 0; i < nodes.length; i++) {
				var node = nodes[i];
				var nodeURL = node.url ? contextPath + node.url : "";

				// id, pid, name, url, title, target, icon, iconOpen, open,
				// checked, page
				tree.add(node.id, node.pid, node.name, nodeURL, node.title,
						node.target, node.icon, node.iconOpen, node.open,
						node.checked, node.page);
			}

			tree.loadeds[pid] = node;

			tree.show();
			//tree.openTo(id);
		}

	};

	ajax.open("POST", url, false);
	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(null);
}

// Opens the tree to a specific node
dTree.prototype.openTo = function(nId, bSelect, bFirst) {
	if (!bFirst) {
		for (var n = 0; n < this.aNodes.length; n++) {
			if (this.aNodes[n].id == nId || this.aNodes[n].title == nId) {
				nId = n;
				break;
			}
		}
	}
	var cn = this.aNodes[nId];
	if (cn != null) {
		if (cn.pid == this.root.id || !cn._p)
			return;
		cn._io = true;
		cn._is = bSelect;

		if (cn.page && !this.loadeds[cn.id]) {
			this.getChildren(nId, cn.page, cn.id);
		}
		
		if (this.completed && cn._hc)
			this.nodeStatus(true, cn._ai, cn._ls);
		if (this.completed && bSelect)
			this.s(cn._ai);
		else if (bSelect)
			this._sn = cn._ai;
		this.openTo(cn._p._ai, false, true);
	}
};

// Closes all nodes on the same level as certain node
dTree.prototype.closeLevel = function(node) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.pid && this.aNodes[n].id != node.id
				&& this.aNodes[n]._hc) {
			this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

// Closes all children of a node
dTree.prototype.closeAllChildren = function(node) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id && this.aNodes[n]._hc) {
			if (this.aNodes[n]._io)
				this.nodeStatus(false, n, this.aNodes[n]._ls);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

// Change the status of a node(open or closed)
dTree.prototype.nodeStatus = function(status, id, bottom) {
	eDiv = document.getElementById('d' + this.obj + id);
	eJoin = document.getElementById('j' + this.obj + id);
	if (this.config.useIcons) {
		eIcon = document.getElementById('i' + this.obj + id);
		eIcon.src = (status) ? this.aNodes[id].iconOpen : this.aNodes[id].icon;
	}
	eJoin.src = (this.config.useLines) ? ((status) ? ((bottom)
			? this.icon.minusBottom
			: this.icon.minus) : ((bottom)
			? this.icon.plusBottom
			: this.icon.plus)) : ((status)
			? this.icon.nlMinus
			: this.icon.nlPlus);
	eDiv.style.display = (status) ? 'block' : 'none';
};

// [Cookie] Clears a cookie
dTree.prototype.clearCookie = function() {
	var now = new Date();
	var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
	this.setCookie('co' + this.obj, 'cookieValue', yesterday);
	this.setCookie('cs' + this.obj, 'cookieValue', yesterday);
};

// [Cookie] Sets value in a cookie
dTree.prototype.setCookie = function(cookieName, cookieValue, expires, path,
		domain, secure) {
	document.cookie = escape(cookieName) + '=' + escape(cookieValue)
			+ (expires ? '; expires=' + expires.toGMTString() : '')
			+ (path ? '; path=' + path : '')
			+ (domain ? '; domain=' + domain : '') + (secure ? '; secure' : '');
};

// [Cookie] Gets a value from a cookie
dTree.prototype.getCookie = function(cookieName) {
	var cookieValue = '';
	var posName = document.cookie.indexOf(escape(cookieName) + '=');
	if (posName != -1) {
		var posValue = posName + (escape(cookieName) + '=').length;
		var endPos = document.cookie.indexOf(';', posValue);
		if (endPos != -1)
			cookieValue = unescape(document.cookie.substring(posValue, endPos));
		else
			cookieValue = unescape(document.cookie.substring(posValue));
	}
	return (cookieValue);
};

// [Cookie] Returns ids of open nodes as a string
dTree.prototype.updateCookie = function() {
	var str = '';
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n]._io) {
			if (str)
				str += '.';
			str += this.aNodes[n].id;
		}
	}
	this.setCookie('co' + this.obj, str);
};

// [Cookie] Checks if a node id is in a cookie
dTree.prototype.isOpen = function(id) {
	var aOpen = this.getCookie('co' + this.obj).split('.');
	for (var n = 0; n < aOpen.length; n++)
		if (aOpen[n] == id)
			return true;
	return false;
};

// If Push and pop is not implemented by the browser
if (!Array.prototype.push) {
	Array.prototype.push = function array_push() {
		for (var i = 0; i < arguments.length; i++)
			this[this.length] = arguments[i];
		return this.length;
	}
};
if (!Array.prototype.pop) {
	Array.prototype.pop = function array_pop() {
		lastElement = this[this.length - 1];
		this.length = Math.max(this.length - 1, 0);
		return lastElement;
	}
};

dTree.prototype.show = function() {
	// Renew the two array to save original data.
	this.rewriteHTML();
}

dTree.prototype.rewriteHTML = function() {

	var str = '';

	// Added by xiaosilent.
	var targetDIV;
	targetDIV = document.getElementById(this.targetID);

	if (!targetDIV) {

		alert('dTree can\'t find your specified container to show your tree.\n\n Please check your code!');

		return;
	}

	if (this.config.useCookies)
		this.selectedNode = this.getSelected();

	var str = '<div class="dtree">\n';
	str += this.addNode(this.root);
	str += '</div>';

	// Disabled by xiaosilent.
	// str += '</div>';

	if (!this.selectedFound)
		this.selectedNode = null;

	this.completed = true;

	// Disabled and added by xiaosilent.
	// return str;
	targetDIV.innerHTML = str;

};