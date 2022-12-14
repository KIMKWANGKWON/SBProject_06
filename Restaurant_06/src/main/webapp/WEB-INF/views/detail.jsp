<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../includes/gnb.jsp" %>
<script src="../js/details.js"></script>

<style>
	.restaurant_image{
		width: 40%
	}
	.restaurant_info{
		margin-left: 30px;
		width: 50%
	}
</style>
<div class="container">
	<h2 align="left">${restaurant.name }</h2>
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="restaurant_image">
				<img class="img-fluid" src="resources/img/${restaurant.themImage }" alt="food">
			</div>
      		<div class="restaurant_info">
				<table class="table table-borderless">
					<tr>
						<td>주소</td>
						<td>${restaurant.address }<td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>${restaurant.tel }</td>
					</tr>
					<tr>
						<td>운영시간</td>
						<td>${restaurant.hours }</td>
					</tr>
					<tr>
						<td>홈페이지</td>
						<td>${restaurant.url }<td>
					</tr>
				</table>
				<div>
					<input type="button" class="btn btn-info" id="btnReservation" value="예약하기">
				</div>
			</div>
    	</div>  
  	</div>
	<hr>
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="col-md"><a href="">Menu</a></div>
      		<div class="col-md"><a href="">Restaurant</a></div>
      		<div class="col-md"><a href="">Comment</a></div>
    	</div>  
  	</div>
  	<hr>
  	<div id="menuResult">
  	</div>
  	<div id="restaurantResult">
  	</div>
  	<div id="commentResult">
  	</div>
</div>

<script>
menu();
</script>
