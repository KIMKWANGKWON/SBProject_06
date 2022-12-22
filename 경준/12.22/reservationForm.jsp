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
  			<div class="col-lg-7">
				<div class="card-body" align="left">
					<div class="row">
					<div class="col-lg-5">
						<table class="table table-borderless">
							<tr><td><h1>reservation</h1></td></tr>
							<tr><td><h3>${restaurant.name }</h3></td></tr>
							<tr><td><h6>${restaurant.tel }</h6></td></tr>
      					</table>
      				</div>
      				<div class="col-lg-7">
      					<table class="table table-borderless">
      						<tr>
      							<td>예약자</td>
      							<td width="60%"><input type="text" id="name" value='<sec:authentication property="principal.user.nickname"/>' name="name" class="form-control" readonly="readonly"></td>
      						</tr>
      						<tr>
      							<td>예약자수</td>
      							<td><input type="text" id="peopleCnt" name="peopleCnt" class="form-control"></td>
      						</tr>
      						<tr>
      							<td>예약날짜</td>
      							<td><input type="text" id="rsvDate" name="rsvDate" class="form-control" readonly="readonly"></td>
      						</tr>
      						<tr>
      							<td>예약시간</td>
      							<td><input type="text" id="rsvTime" name="rsvTime" class="form-control timepicker" readonly="readonly"></td>
      						</tr>
      					</table>
      					
      				</div>
      				</div>
    			</div>
  			</div>
  			<div class="col-lg-5">
  				<div class="card-body" align="left">
  					<table class="table table-borderless">
  						<tr>
  							<td>요구사항</td>
  							<td rowspan="7"><textarea class="form-control" rows="7" id="msg" name="msg"></textarea></td>
  						</tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
						<tr><td></td></tr>
     				</table>
  					
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
   		minTime: '${restaurant.openTime}',
    	maxTime: '${restaurant.rsvTime}',
    	defaultTime: '${restaurant.openTime}',
    	startTime: '${restaurant.openTime}',
    	dynamic: false,
    	dropdown: true,
    	scrollbar: true
	});
</script>