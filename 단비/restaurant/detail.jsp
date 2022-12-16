<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>

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
	<input type="hidden" value="${restaurant.id }">
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="restaurant_image">
				<img class="img-fluid" src="${restaurant.thumImage }" alt="food">
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
					<input type="button" class="btn btn-info" id="goReservation" value="예약하기"><br/>
					<input type="button" class="btn btn-secondary" id="like" value="좋아요">
				</div>
			</div>
    	</div>  
  	</div>
	<hr>
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="col-md"><button onclick="javascript:show('menuResult')" class="btn btn-link">Menu</button></div>
      		<div class="col-md"><button onclick="javascript:show('descriptionResult')" class="btn btn-link">가게 정보</button></div>
      		<div class="col-md"><button onclick="javascript:show('commentResult')" class="btn btn-link">후기</button></div>
    	</div>  
  	</div>
  	<hr>
  	<div id="menuResult">
  	<table class='table table-borderless'>
			<thead>
				<tr align='center'>
				<th>메뉴</th>
				<th>이름</th>
				<th>가격</th>
				<th>기타</th>
				</tr>
			</thead>
			<tbody>
  	<c:forEach items="${restaurant.menuList}" var="menu">
  		<tr align='center'>
	  		<td><img src="${menu.img }" alt="메뉴이미지"></td>
	  		<td>${menu.name }</td>
	  		<td>${menu.price }</td>
	  		<td>${menu.description }</td>
  		</tr>
  	</c:forEach>
  	</tbody>
  	</table>
  	</div>
  	<div id="descriptionResult">
  	<h4>${restaurant.description }</h4>
  	</div>
  	<div id="commentResult">
  	</div>
</div>
<script src="/js/detail.js"></script>
<script>
$("#goReservation").click(function() {
	location.href="/user/reservationForm/${restaurant.id}"
})
show("menuResult") //디폴트

$("#like").click(function(){
	var data = {
			user : {
				id : 1
			},
			restaurant : {
				id : ${restaurant.id}
			} 
	}
	$.ajax({
		type:"post",
		url:"/user/like",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success:function(resp){
			if(resp=="success"){
				
			}
		}
	})
})
</script>