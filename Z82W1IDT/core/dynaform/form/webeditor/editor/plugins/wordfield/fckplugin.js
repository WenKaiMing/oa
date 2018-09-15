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
 * Plugin to insert "wordfields" in the editor.
 */

// Register the related command.

function getUrl(){
	var url;
	var moduleid = parent.document.getElementById('moduleid').value;
	var applicationid = parent.document.getElementById('application').value;
	url = 'myapps_wordfield.jsp?';
	/*if (isTabFieldSelected()){
		url = 'dialog/wordfield.jsp?action=modify';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}
	else {
		url = 'dialog/wordfield.jsp?action=new';
		url += '&moduleid=' + moduleid + '&application='+applicationid;
	}*/
	url += '&moduleid=' + moduleid + '&application='+applicationid;
	//alert("URL----->"+url);
	return FCKPlugins.Items['wordfield'].Path+url;
}
FCKCommands.RegisterCommand( 'wordfield', new FCKDialogCommand( 'wordfield', FCKLang.wordfieldtitle, getUrl(), 600, 400 ) ) ;

// Create the "Plaholder" toolbar button.
var owordfieldItem = new FCKToolbarButton( 'wordfield', FCKLang.wordfield ) ;
owordfieldItem.IconPath = FCKPlugins.Items['wordfield'].Path + 'wordfield.gif' ;

FCKToolbarItems.RegisterItem( 'wordfield', owordfieldItem ) ;


// The object used for all wordfield operations.
var FCKwordfields = new Object() ;

// Add a new placeholder at the actual selection.
FCKwordfields.Add = function( name )
{
	var oSpan = FCK.InsertElement( 'IMG' ) ;
	this.SetupSpan( oSpan, name ) ;
}

FCKwordfields.SetupSpan = function( IMG, name )
{
	IMG.innerHTML = '[[ ' + name + ' ]]' ;

	IMG.style.backgroundColor = '#ffff00' ;
	IMG.style.color = '#000000' ;

	if ( FCKBrowserInfo.IsGecko )
		IMG.style.cursor = 'default' ;

	IMG._fckplaceholder = name ;
	IMG.contentEditable = false ;

	// To avoid it to be resized.
	IMG.onresizestart = function()
	{
		FCK.EditorWindow.event.returnValue = false ;
		return false ;
	}
}

// On Gecko we must do this trick so the user select all the IMG when clicking on it.
FCKwordfields._SetupClickListener = function()
{
	FCKwordfields._ClickListener = function( e )
	{
		if ( e.target.tagName == 'IMG' && e.target._fckplaceholder )
			FCKSelection.SelectNode( e.target ) ;
	}

	FCK.EditorDocument.addEventListener( 'click', FCKwordfields._ClickListener, true ) ;
}

// Open the wordfield dialog on double click.
FCKwordfields.OnDoubleClick = function( IMG )
{
	if ( IMG.tagName.toUpperCase() == 'IMG' 
		&& IMG.classname == "cn.myapps.core.dynaform.form.ejb.WordField" )
		FCKCommands.GetCommand( 'wordfield' ).Execute();
}

FCK.RegisterDoubleClickHandler( FCKwordfields.OnDoubleClick, 'IMG' ) ;

// Check if a Placholder name is already in use.
FCKwordfields.Exist = function( name )
{
	var aSpans = FCK.EditorDocument.getElementsByTagName( 'IMG' ) ;

	for ( var i = 0 ; i < aSpans.length ; i++ )
	{
		if ( aSpans[i]._fckplaceholder == name )
			return true ;
	}

	return false ;
}

if ( FCKBrowserInfo.IsIE )
{
	FCKwordfields.Redraw = function()
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
				oRange.pasteHTML( '<IMG style="color: #000000; background-color: #ffff00" contenteditable="false" _fckplaceholder="' + sName + '">' + aPlaholders[i] + '</IMG>' ) ;
			}
		}
	}
}
else
{
	FCKwordfields.Redraw = function()
	{
		if ( FCK.EditMode != FCK_EDITMODE_WYSIWYG )
			return ;

		var oInteractor = FCK.EditorDocument.createTreeWalker( FCK.EditorDocument.body, NodeFilter.SHOW_TEXT, FCKwordfields._AcceptNode, true ) ;

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

						var oSpan = FCK.EditorDocument.createElement( 'IMG' ) ;
						FCKwordfields.SetupSpan( oSpan, sName ) ;

						aNodes[n].parentNode.insertBefore( oSpan, aNodes[n] ) ;
					}
					else
						aNodes[n].parentNode.insertBefore( FCK.EditorDocument.createTextNode( aPieces[i] ) , aNodes[n] ) ;
				}
			}

			aNodes[n].parentNode.removeChild( aNodes[n] ) ;
		}

		FCKwordfields._SetupClickListener() ;
	}

	FCKwordfields._AcceptNode = function( node )
	{
		if ( /\[\[[^\[\]]+\]\]/.test( node.nodeValue ) )
			return NodeFilter.FILTER_ACCEPT ;
		else
			return NodeFilter.FILTER_SKIP ;
	}
}

FCK.Events.AttachEvent( 'OnAfterSetHTML', FCKwordfields.Redraw ) ;

// We must process the IMG tags to replace then with the real resulting value of the placeholder.
FCKXHtml.TagProcessors['IMG'] = function( node, htmlNode )
{
	if ( htmlNode._fckplaceholder )
		node = FCKXHtml.XML.createTextNode( '[[' + htmlNode._fckplaceholder + ']]' ) ;
	else
		FCKXHtml._AppendChildNodes( node, htmlNode, false ) ;

	return node ;
}
