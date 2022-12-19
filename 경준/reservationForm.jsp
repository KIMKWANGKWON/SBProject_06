<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- date time picker -->


<div class="container" style="position:relative;">
	<h2 align="center">${restaurant.name } 예약하기</h2>
	<div class="row" align="center">
		<div class="col-lg-6">					<!-- 썸네일 -->
			<img src="${restaurant.thumImage }">
		</div>
		<div class="col-lg-6">					<!--  -->
			<div id="datepicker"></div>
  		</div>
  	</div>
  	<div class="mt-3" align="center">
  		<div class="card" style="width:100%">	<!-- 예약정보 -->
  			<div class="row" align="center">
  			<div class="col-lg-8">
				<div class="card-body" align="left">
					<div class="row">
					<div class="col-lg-6">
						<label for="name">예약자</label>
      					<input type="text" id="name" value='<sec:authentication property="principal.user.nickname"/>' name="name" class="form-control"><br>
      					<label for="peopleCnt">예약자 수</label>
      					<input type="text" id="peopleCnt" name="peopleCnt" class="form-control">
      				</div>
      				<div class="col-lg-6">
						<label for="rsvDate">예약날짜</label>
      					<input type="text" id="rsvDate" name="rsvDate" class="form-control" readonly="readonly"><br>
      					<label for="rsvTime">예약시간</label>
      					<input type="text" id="rsvTime" name="rsvTime" class="form-control timepicker" readonly="readonly">
      				</div>
      				</div>
    			</div>
  			</div>
  			<div class="col-lg-4">
  				<div class="card-body" align="left">
  					<label for="msg">요구사항</label>
     				<textarea class="form-control" rows="6" id="msg" name="msg"></textarea>
     			</div>
     		</div>
     		</div>
     	</div>
  	</div>
  	<div align="center" class="mt-5">
		<button type="button" class="btn btn-info" id="btnReservation">Reservation</button>
	</div>
</div>

<script>
//DateTimePicker
$("#btnReservation").click(function() {
	if($("#peopleCnt").val()=="") {
		alert("예약자 수를 입력하세요!")
		return false;
	}
	if($("#rsvDate").val()=="") {
		alert("예약날짜를 입력하세요!")
		return false;
	}
	var dataParam = {
		"peopleCnt" : $("#peopleCnt").val(),
		"rsvDate" : $("#rsvDate").val(),
		"rsvTime" : $("#rsvTime").val(),
		"msg" : $("#msg").val()
	}
	$.ajax({
		type : "post",
		url : "/user/reservation/${restaurant.id}",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(dataParam)
	})
	.done(function(resp) {
		if(resp=="success") {
			alert("예약 성공!")
			location.href="/user/reservationList/<sec:authentication property='principal.user.id'/>"
		} 
	})
	.fail(function(e) {
		alert("오류 : " + e)
	})
})

/* 설정 */	
	const config = {
		dateFormat: 'yy-mm-dd',
		showOn : "button",
		buttonText:"날짜 선택",
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    yearSuffix: '년',
	    altField : "#rsvDate",
	    altFormat : "yy-mm-dd",
	    minDate : 0
	}

	/* 캘린더 */
	$(function() {
		$("#datepicker").datepicker(config);
	});
	
	$(document).ready(function(){
    	$('input.timepicker').timepicker({});
	});
	
	$('.timepicker').timepicker({
    	timeFormat: 'HH:mm',
    	interval: 30,
//    	minTime: '${restaurant.openTime}',
    	maxTime: '${restaurant.rsvTime}',
    	defaultTime: '${restaurant.openTime}',
    	startTime: '${restaurant.openTime}',
    	dynamic: false,
    	dropdown: true,
    	scrollbar: true
	});
</script>