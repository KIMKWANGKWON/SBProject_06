<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>


<style>
#myform fieldset{
    display: inline-block;
    direction: ltr;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform .empty{
    font-size: 1em;
     color: transparent; 
     text-shadow: 0 0 0 #f0f0f0; 
}

#myform .full{
    font-size: 1em;
     text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

.fa-star {
	color :red;
}


</style>

<div class="container">
	<div class="jumbotron"></div>
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
    		<div class="col-lg-6">
      		<div class="restaurant_image">
				<img class="img-fluid" src="${restaurant.thumImage }" alt="food" width="100%">
			</div>
			</div>
			<div class="col-lg-6">
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
						<td>${restaurant.openTime } - ${restaurant.closeTime}</td>
					</tr>
					<tr>
						<td>예약마감</td>
						<td>${restaurant.rsvTime }</td>
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
  	<table class='table table-hover'>
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
      		<div class="review_list">
				<table class="table table-hover">
			
					<tr align="center">
						<th width="40%">사진</th>
						<th>작성자</th>
						<th>평점</th>
						<th>리뷰</th>
						<sec:authorize access="hasRole('ROLE_OWNER')">
						<c:if test="${restaurant.owner.id eq sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.id}">
						<th></th>
						</c:if>
						</sec:authorize>
					</tr>
					
					<c:forEach items="${reviewList }" var = "review">
					<tr align="center">
						<td>
						<div class="review_image">
						<img class="img-fluid" src="${review.thumImage }">
						</div>
						</td>
						<td>${review.user.nickname }</td>
						
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
						<td>${review.content }</td>
						
						<sec:authorize access="hasRole('ROLE_OWNER')">

 						<c:if test="${restaurant.owner.id eq sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.id}">
						<td><button type="button" class="btn btn-info" data-toggle="collapse" data-target="#demo${review.id }">
						답글</button></td>
						</c:if>
						</sec:authorize>
					</tr>
					
					<tr>
						<td></td>
						<td colspan="4">
    					${review.comment.msg }
  						</td>
  					</tr>
  					<sec:authorize access="hasRole('ROLE_OWNER')">
  					<c:if test="${review.comment.id eq null }">
					<tr><td></td>
						<td colspan="3"><div id="demo${review.id }" class="collapse">
    					<textarea id="msg" class=form-control>사장님 댓글</textarea>
  						</div></td>
  						<td><div id="demo${review.id }" class="collapse">
  						<input type="button" class="btn btn-primary" onclick="javascript:commentInsert('${review.id}')" value="입력"></div></td>
  					</tr>
  					</c:if>
  					</sec:authorize>
					</c:forEach>
				</table>
				
			</div> <!-- review_list --> 

  		</div> <!-- comment Container -->
	</div> <!-- comment -->
</div>

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

function commentInsert(id) {
	if($("#msg").val()=="") {
		alert("답글을 입력하세요")
		return;
	}
	var data = {
		"msg" : $("#msg").val()
	}
	$.ajax({
		type : "post",
		url : "/user/commentInsert/" + id,
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data)
	})
	.done(function() {
		
		alert("good")
	})
	.fail(function() {
		alert("오류")
	})
}
	
//디폴트
show("menuResult")
</script>