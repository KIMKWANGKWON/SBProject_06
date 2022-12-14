$("#btnReservation").click(function() {
	location.href="reservation"
})
	
var menu = function() {
	$.ajax({
		type : "get",
		url : ""
	})
	.done(function(resp) {
		var str = "<table class='table table-borderless'>"
			str += "<thead>"
			str += "<tr align='center'>"
			str += "<th>메뉴</th>"
			str += "<th>이름</th>"
			str += "<th>가격</th>"
			str += "<th>기타</th>"
			str += "</tr>"
			str += "<tbody>"
		$.each(resp, function(key, val) {
			str += "<tr align='center'>"
			str += "<td></td>"
			str += "<td></td>"
			str += "<td></td>"
			str += "<td></td>"	
			str += "</tr>"
		})
		str += "</tbody>"
		str += "</table>"
		$("#menuResult").html(str);
/*		$("#restaurantResult").hide();
		$("#commentResult").hide();		*/
	})
}

var restaurant = function() {
	$.ajax({
		type : "get",
		url : ""
	})
	.done(function(resp) {
		$("#detailResult").html(resp);
		
	})
}