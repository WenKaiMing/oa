dp.sh.Brushes.Bsh = function()
{
	var keywords	= 'case'+ 'do'+ 'done'+ 'elif'+ 'else'+ 'esac'+ 'fi'+ 'for'+ 'function'+
			'if'+ 'in'+ 'select'+ 'then'+ 'until'+ 'while'+ 'time'+
			'source'+ 'alias'+ 'bg'+ 'bind'+ 'break'+ 'builtin'+ 'cd'+ 'command'+
			'compgen'+ 'complete'+ 'continue'+ 'declare'+ 'typeset'+ 'dirs'+
			'disown'+ 'echo'+ 'enable'+ 'eval'+ 'exec'+ 'exit'+ 'export'+ 'fc'+
			'fg'+ 'getopts'+ 'hash'+ 'help'+ 'history'+ 'jobs'+ 'kill'+ 'let'+
			'local'+ 'logout'+ 'popd'+ 'printf'+ 'pushd'+ 'pwd'+ 'read'+ 'readonly'+
			'return'+ 'set'+ 'shift'+ 'shopt'+ 'suspend'+ 'test'+ 'times'+ 'trap'+
			'type'+ 'ulimit'+ 'umask'+ 'unalias'+ 'unset'+ 'wait';

	this.regexList = [
		{ regex: dp.sh.RegexLib.SingleLineCComments,				css: 'comment' },			// one line comments
		{ regex: dp.sh.RegexLib.MultiLineCComments,					css: 'comment' },			// multiline comments
		{ regex: dp.sh.RegexLib.DoubleQuotedString,					css: 'string' },			// double quoted strings
		{ regex: dp.sh.RegexLib.SingleQuotedString,					css: 'string' },			// single quoted strings
		{ regex: new RegExp(this.GetKeywords(keywords), 'gm'),		css: 'keyword' }			// keyword
		];

	this.CssClass = 'dp-c';
}

dp.sh.Brushes.Bsh.prototype	= new dp.sh.Highlighter();
dp.sh.Brushes.Bsh.Aliases	= ['bash,shell'];
