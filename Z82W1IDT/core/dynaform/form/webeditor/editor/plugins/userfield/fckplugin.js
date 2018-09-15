/*
 * FCKeditor - The text editor for Internet - http://www.fckeditor.net
 * Copyright (C) 2003-2010 Frederico Caldeira Knabben
 *
 * == BEGIN LICENSE ==
 *
 * Licensed under the terms of any of the following licenses at your
 * choice:
 *
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 *
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 *
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * == END LICENSE ==
 *
 * Plugin to insert "userfields" in the editor.
 */

// Register the related command.

function getUrl(){
	var url;
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	var formid = parent.document.forms[0].elements['content.id'].value;
	url = 'myapps_userfield.jsp?';
	/*if (isuserfieldSelected()){
		url = 'dialog/userfield.jsp?action=modify';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}
	else {
		url = 'dialog/userfield.jsp?action=new';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}*/
	url += '&moduleid=' + moduleid + '&application='+applicationid + '&formid='+formid;
	//alert("URL----->"+url);
	return FCKPlugins.Items['userfield'].Path+url;
}
FCKCommands.RegisterCommand( 'userfield', new FCKDialogCommand( 'userfield', FCKLang.userfieldtitle, getUrl(), 600, 400 ) ) ;

// Create the "Plaholder" toolbar button.
var ouserfieldItem = new FCKToolbarButton( 'userfield', FCKLang.userfield ) ;
ouserfieldItem.IconPath = FCKPlugins.Items['userfield'].Path + 'userfield.gif' ;

FCKToolbarItems.RegisterItem( 'userfield', ouserfieldItem ) ;


// The object used for all userfield operations.
var FCKuserfields = new Object() ;

// Add a new placeholder at the actual selection.
FCKuserfields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'SELECT' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKuserfields.SetupSpan = function( SELECT, name )
{
	SELECT.innerHTML = '[[ ' + name + ' ]]' ;

	SELECT.style.backgroundColor = '#ffff00' ;
	SELECT.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		SELECT.style.cursor = 'default' ;

	SELECT._fckplaceholder = name ;
	SELECT.contentEditable = false ;

	// To avoid it to be resized.
	SELECT.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the SELECT when clicking on it.
FCKuserfields._SetupClickListener = function()
{
	FCKuserfields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'SELECT' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKuserfields._ClickListener, true ) ;
}

// Open the userfield dialog on double click.
FCKuserfields.OnDoubleClick = function( SELECT )
{
	if ( SELECT.classname=="cn.myapps.core.dynaform.form.ejb.UserField" ){
		FCKCommands.GetCommand( 'userfield' ).Execute() ;
	}
}

FCK.RegisterDoubleClickHandler( FCKuserfields.OnDoubleClick, 'SELECT' ) ;

// Check if a Placholder name is already in use.
FCKuserfields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'SELECT' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKuserfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var aPlaholders = FCK.EditorDocument.body.innerText.match( /\[\[[^\[\]]+\]\]/g ) ;
		if ( !aPlaholders )
			return ;

		var oRange = FCK.EditorDocument.body.createTextRange() ;

		for ( var i = 0 ; i < aPlaholders.length ; i++ )
		{
			if ( oRange.findText( aPlaholders[i] ) )
			{
				var sName = aPlaholders[i].match( /\[\[\s*([^\]]*?)\s*\]\]/ )[1] ;
				oRange.pasteHTML( '<SELECT style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</SELECT>' ) ;
			}
		}
	}
}
else
{
	FCKuserfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKuserfields._AcceptNode, true ) ;

		var	aNodes = new Array() ;

		while ( ( oNode = oInteractor.nextNode() ) )
		{
			aNodes[ aNodes.length ] = oNode ;
		}

		for ( var n = 0 ; n < aNodes.length ; n++ )
		{
			var aPieces = aNodes[n].nodeValue.split( /(\[\[[^\[\]]+\]\])/g ) ;

			for ( var i = 0 ; i < aPieces.length ; i++ )
			{
				if ( aPieces[i].length > 0 )
				{
					if ( aPieces[i].indexOf( '[[' ) == 0 )
					{
						var sName = aPieces[i].match( /\[\[\s*([^\]]*?)\s*\]\]/ )[1] ;

						var oSpan = FCK.EditorDocument.createElement( 'SELECT' ) ;
						FCKuserfields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKuserfields._SetupClickListener() ;
	}

	FCKuserfields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKuserfields.Redraw ) ;

// We must process the SELECT tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['SELECT'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
