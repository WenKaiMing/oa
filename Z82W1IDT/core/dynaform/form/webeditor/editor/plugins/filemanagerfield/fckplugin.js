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
 * Plugin to insert "imageuploadfields" in the editor.
 */

// Register the related command.

function getUrl(){
	var url;
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	url = 'myapps_filemanager.jsp';
	url += '?moduleid=' + moduleid + '&application='+applicationid;
	return FCKPlugins.Items['filemanagerfield'].Path + url;
}
FCKCommands.RegisterCommand( 'filemanagerfield', new FCKDialogCommand( 'FileManagerField', FCKLang.FileManagerFieldDlgTitle, getUrl(), 600, 350 ) ) ;

// Create the "Plaholder" toolbar button.
var oimageuploadfieldItem = new FCKToolbarButton( 'filemanagerfield', FCKLang.FileManagerField ) ;
oimageuploadfieldItem.IconPath = FCKPlugins.Items['filemanagerfield'].Path + 'img.png' ;

FCKToolbarItems.RegisterItem( 'filemanagerfield', oimageuploadfieldItem ) ;


// The object used for all imageuploadfield operations.
var FCKfilemanagerfields = new Object() ;

// Add a new placeholder at the actual selection.
FCKfilemanagerfields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'img' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKfilemanagerfields.SetupSpan = function( img, name )
{
	img.innerHTML = '[[ ' + name + ' ]]' ;

	img.style.backgroundColor = '#ffff00' ;
	img.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		img.style.cursor = 'default' ;

	img._fckplaceholder = name ;
	img.contentEditable = false ;

	// To avoid it to be resized.
	img.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the img when clicking on it.
FCKfilemanagerfields._SetupClickListener = function()
{
	FCKfilemanagerfields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'img' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKfilemanagerfields._ClickListener, true ) ;
}

// Open the imageuploadfield dialog on double click.
FCKfilemanagerfields.OnDoubleClick = function( img )
{
	if ( img.tagName.toUpperCase() == 'IMG' 
			&& img.classname == 'cn.myapps.core.dynaform.form.ejb.FileManagerField' )
		FCKCommands.GetCommand( 'filemanagerfield' ).Execute() ;
}

FCK.RegisterDoubleClickHandler( FCKfilemanagerfields.OnDoubleClick, 'img' ) ;

// Check if a Placholder name is already in use.
FCKfilemanagerfields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'img' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKfilemanagerfields.Redraw = function()
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
				oRange.pasteHTML( '<img style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</img>' ) ;
			}
		}
	}
}
else
{
	FCKfilemanagerfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKfilemanagerfields._AcceptNode, true ) ;

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

						var oSpan = FCK.EditorDocument.createElement( 'img' ) ;
						FCKfilemanagerfields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKfilemanagerfields._SetupClickListener() ;
	}

	FCKfilemanagerfields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKfilemanagerfields.Redraw ) ;

// We must process the img tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['img'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
