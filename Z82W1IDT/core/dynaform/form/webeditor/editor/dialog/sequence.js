
function getFieldId()
{
  var fieldid = '';
  	DWREngine.setAsync(false);
  	if (oActiveEl==null || oActiveEl==undefined){
  		Sequence.getSequence(function(id) {
  			fieldid = id;
  		});
  	}else{
  		fieldid=oActiveEl.id;
  	}
  	//alert(fieldid);
	return fieldid;
}
