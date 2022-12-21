<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h2>[<sec:authentication property="principal.user.nickname"/>]님의 즐겨찾기</h2>
  	<table class="table mt-5">
  		<thead align="center">
  			<tr>
  				<th>음식점</th>
  				<th>이름</th>
  				<th>전화번호</th>
  				<th>운영시간</th>
<!--   				<th>상세정보</th> -->
  				<th></th>
  			</tr>
  		</thead>
   		<tbody align="center">
   			<c:forEach items="${favorites.content}" var="favorite">
    			<tr>
					<td><img alt="thum" src="${favorite.restaurant.thumImage }"></td>
       				<td><a href="/restaurant/view/${favorite.restaurant.id }">${favorite.restaurant.name }</a></td>
        			<td>${favorite.restaurant.tel }</td>
        			<td>${favorite.restaurant.openTime } : ${favorite.restaurant.closeTime }
        				예약 마감 시간 : ${favorite.restaurant.rsvTime }</td>
<%--         			<td>${favorite.restaurant.description }</td> --%>
        			<td><input type="button" class="btn btn-danger" onclick="dislike('${favorite.id}')" value="delete"></td>
      			</tr>
      		</c:forEach>
    	</tbody>
  	</table>
  	<div class="d-flex justify-content-between">
  	<ul class="pagination mt-3">
  	<c:if test="${favorites.first==false }">
  		<li class="page-item"><a class="page-link" href="?page=${favorites.number-1 }">이전</a></li>
  	</c:if>
  	
  	<c:if test="${favorites.last==false }">
  		<li class="page-item"><a class="page-link" href="?page=${favorites.number+1 }">다음</a></li>
  	</c:if>
  	</ul>
  	</div>
</div>

<script>
function dislike(id){
	$.ajax({
		type:"delete",
		url:"/user/dislike/"+id
	})
	.done(function(resp){
		location.href="/user/favorites/<sec:authentication property='principal.user.id'/>";
	})
	.fail(function(e){
		alert("좋아요 삭제 실패")
	})
}
</script>