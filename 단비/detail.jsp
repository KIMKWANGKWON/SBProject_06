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
	
	.review_image{
		width: 40%
	}
#myform fieldset{
    display: inline-block;
    direction: ltr;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform .empty{
    font-size: 3em;
     color: transparent; 
     text-shadow: 0 0 0 #f0f0f0; 
}

#myform .full{
    font-size: 3em;
     text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}



</style>

<div class="container">
	<h2 align="left">${restaurant.name }
		<a href="javascript:like(this)"><span id="showLike">
			<c:if test="${findLike.id eq null }">
				<i class="fa-regular fa-star"></i>
			</c:if>
			<c:if test="${findLike.id ne null }">
				<i class="fa-solid fa-star"></i>
			</c:if>
		</span></a></h2>
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
						<td>${restaurant.openTime } ~ ${restaurant.closeTime}<br/>
							예약 마감 시간 : ${restaurant.rsvTime }</td>
					</tr>
					<tr>
						<td>홈페이지</td>
						<td>${restaurant.url }<td>
					</tr>
				</table>
				<div>
					<input type="button" class="btn btn-info" id="goReservation" value="예약하기">
				</div>
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

	<div class="container">
		<form method="post" id = "myform" enctype="multipart/form-data">
    	<div class="row" align="center">
      		<div class="review_list">
				<table class="table table-borderless">
			
					<tr align="center">
						<td>사진</td>
						<td>작성자</td>
						<td>리뷰 내용</td>
						<td>점수</td>
					</tr>
					
					<c:forEach items="${reviewList }" var = "review">
					<tr>
						<td>
						<div class="review_image">
						<img class="img-fluid" src="${review.thumImage }">
						</div>
						</td>
						<td>${review.user.id }</td>
						<td>${review.content }<td>
						<td>
						<div id="myform">
						
						<fieldset>
						<c:forEach begin="1" end="${review.rating}" step="1">
						<label for="rate1" class="full">⭐</label>
						</c:forEach>
						
						<c:forEach begin="${review.rating+1 }" end="5" step="1">
						<label for="rate1" class="empty">⭐</label>
						</c:forEach>
						</fieldset>
						
						</div>
						</td>
					</tr>
					</c:forEach>
				</table>
				
			</div> <!-- review_list --> 
  		</div>
	</form>

  	</div> <!-- comment Container -->
</div> <!-- comment -->
  		

<script src="/js/detail.js"></script>
<script>
$("fieldset > input:radio[value='${review.rating}']").attr("checked",true);

//좋아요
var like = function(input){
	<sec:authorize access="isAuthenticated()">
	var data = {
			user : {
				id : <sec:authentication property="principal.user.id"/>
			},
			restaurant : {
				id : ${restaurant.id}  //자기요소 바로 밑에 요소 가져옴 .value 그 값을 불러옴 ->아이디 식별이 안되니까
			} 
	}
	$.ajax({
		type:"post",
		url:"/user/like",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success:function(resp){
			alert("성공");
			if(resp==0) {
				$("#showLike").html("<i class='fa-regular fa-star'>")
			} else {
				$("#showLike").html("<i class='fa-solid fa-star'>")
			}
		}
	})
	return;
	</sec:authorize>
	alert("로그인이 필요한 서비스입니다.")
}//예약하기
$("#goReservation").click(function() {
	<sec:authorize access="isAuthenticated()">
	location.href="/user/reservationForm/${restaurant.id}"
	return;
	</sec:authorize>
	alert("로그인이 필요한 서비스입니다.");
})
//디폴트
show("menuResult")
</script>