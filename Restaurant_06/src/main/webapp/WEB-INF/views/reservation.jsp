<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../includes/gnb.jsp" %>
<style>
	.reservation_calednar{
		width: 40%
	}
	.reservation_info{
		margin-left: 30px;
		width: 50%
	}
</style>
<div class="container">
	<h2 align="left">예약하기</h2>
	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="reservation_calednar">
				<img class="img-fluid" src="resources/img/food1.jpg" alt="food">
			</div>
      		<div class="reservation_info">
				<div class="reservation_input">
					<div class="form-group">
      					<label for="title">제목:</label>
      					<input type="text" class="form-control" id="title" placeholder="Enter title" name="title">
    				</div>
				</div>
				<div>
					<input type="button" class="btn btn-info" id="btnReservation" value="예약하기">
					<input type="reset" class="btn btn-info" id="btnGoBack" value="취소">
				</div>
			</div>
    	</div>  
  	</div>
</div>