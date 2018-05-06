

$(document).ready(function(){


		$('#cancelButton').click(function(){
			self.location.href = "news/news_query.do";
		});
		$('#applyButton').click(function(){
			var actionName = $('select[name="dropdown"]').val();
			if("D" == actionName) {
				actionDels('news/news_dels.do');
			} else {
				alert("没有选择对应操作");
			}
		});
});
function setParent(value) {
		opener.document.getElementById('uuid').value = value;
		window.opener = null;
		window.close();
}