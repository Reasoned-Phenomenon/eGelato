//버튼 css
$(function() {
	$("button").addClass("btn cur-p btn-dark");
	var e = document.forms;
	for (i = 0; i < e.length; i++) {
		for (j = 0; j < e[i].elements.length; j++) {
			if (e[i].elements[j].readOnly) e[i].elements[j].style.backgroundColor = "rgb(230 230 230)";
		}
	}
})
