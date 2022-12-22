<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<link rel="stylesheet" href="/css/mypage.css"/>
<div class="row">
<%@ include file="mypageLeftNav.jsp" %>
	<div class="col-8">	
	<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 즐겨찾기</h2>
  	<table class="table table-hover">
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

  	
  	<ul class="pagination justify-content-center">
	<fmt:formatNumber type="number" maxFractionDigits="0"  value="${((favorites.pageable.pageNumber) / 3 - ((favorites.pageable.pageNumber) / 3) % 1)}" var="start"/>
    <c:if test="${favorites.pageable.pageNumber >= 3 }">
    <li class="page-item"><a class="page-link" 
    href="/user/favorites/<sec:authentication property="principal.user.id"/>?page=${start * 3 - 3}">Previous</a></li>
    </c:if>
    <c:forEach 
    begin="${start * 3 }" 
    end="${start * 3 + 2 }" var="page">
    <c:if test="${page+1 <= favorites.totalPages }">
    <li class="page-item"><a class="page-link" 
    href="/user/favorites/<sec:authentication property="principal.user.id"/>?page=${page}">${page+1}</a></li>
    </c:if>
    </c:forEach>
    <c:if test="${start * 3 + 3 < favorites.totalPages}">
    <li class="page-item"><a class="page-link" 
    href="/user/favorites/<sec:authentication property="principal.user.id"/>?page=${start * 3 + 3}">Next</a></li>
  	</c:if>
 </ul>
 </div>
 <div class="col-2"></div>	
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