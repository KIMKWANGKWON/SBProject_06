<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>

<style>
.review_image{
	width: 30%
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
    font-size: 1.2em;
     color: transparent; 
     text-shadow: 0 0 0 #f0f0f0; 
}

#myform .full{
    font-size: 1.2em;
     text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}

</style>

<link rel="stylesheet" href="/css/mypage.css"/>

<div class="row">
<%@ include file="mypageLeftNav.jsp" %>
	<div class=col-8>
		<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 후기</h2>
			<div class="review_list">
				<table class="table table-hover">
			
					<tr align="center">
						<th>사진</th>
						<th>작성자</th>
						<th>리뷰 내용</th>
						<th>점수</th>
						<th></th>
					</tr>
					
					<c:forEach items="${uPage.content }" var = "review">
					<tr align="center">
						<td>
						<div class="review_image">
						<img class="img-fluid" src="${review.thumImage }">
						</div>
						</td>
						<td>${review.user.nickname }</td>
						<td>${review.content }</td>
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
						<td><button type="button" class="btn btn-danger" onclick="reviewDelete('${review.id}')"><i class="fa-solid fa-trash"></i></button></td>
					</tr>
					</c:forEach>
				</table>
				
			</div> <!-- review_list --> 
  		
	
	<ul class="pagination justify-content-center">
	<fmt:formatNumber type="number" maxFractionDigits="0"  value="${((uPage.pageable.pageNumber) / 3 - ((uPage.pageable.pageNumber) / 3) % 1)}" var="start"/>
    <c:if test="${uPage.pageable.pageNumber >= 3 }">
    <li class="page-item"><a class="page-link" 
    href="/user/userReview/<sec:authentication property="principal.user.id"/>?page=${start * 3 - 3}">Previous</a></li>
    </c:if>
    <c:forEach 
    begin="${start * 3 }" 
    end="${start * 3 + 2 }" var="page">
    <c:if test="${page+1 <= uPage.totalPages }">
    <li class="page-item"><a class="page-link" 
    href="/user/userReview/<sec:authentication property="principal.user.id"/>?page=${page}">${page+1}</a></li>
    </c:if>
    </c:forEach>
    <c:if test="${start * 3 + 3 < uPage.totalPages}">
    <li class="page-item"><a class="page-link" 
    href="/user/userReview/<sec:authentication property="principal.user.id"/>?page=${start * 3 + 3}">Next</a></li>
  	</c:if>
  </ul>
  </div>
  <div class="col-2"></div>	
</div> <!-- comment Container -->
  	
<script>
var reviewDelete = function(id){
	if(!confirm("리뷰를 삭제하시면 재작성이 불가합니다. 삭제하시겠습니까?")){
		return false;
	}
	$.ajax({
		type:"delete",
		url:"/user/reviewDelete/" + id,
		success:function(resp){
			if(resp=="success"){
				alert("삭제되었습니다")
				location.href="/user/userReview/<sec:authentication property='principal.user.id'/>"
			}
		},
		error:function(e){
			alert("내부 문제로 인해 리뷰 삭제가 불가능합니다")
		}
	})
}
</script>