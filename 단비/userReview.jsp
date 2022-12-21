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
					
					<c:forEach items="${userReview }" var = "review">
					<tr>
						<td>
						<div class="review_image">
						<img class="img-fluid" src="${review.thumImage }">
						</div>
						</td>
						<td>${review.user.nickname }</td>
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
						<td><button type="button" class="btn btn-danger" onclick="reviewDelete('${review.id}')">삭제</button></td>
					</tr>
					</c:forEach>
				</table>
				
			</div> <!-- review_list --> 
  		</div>
	</form>

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