<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file ="../include/header.jsp" %>

<div class="container">
	<h1 align="center"><sec:authentication property="principal.user.nickname"/>님의 Q&A</h1>
	<div class="mt-5">
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답글</th>
				<th></th>
			</tr>
		</thead>
	 	<tbody>		
			<c:forEach items="${qna.content}" var="qna">
				<tr align="center">
					<td>${qna.id}</td>
					<td><a href="/inquiry/qnaView/${qna.id}">${qna.title}</a></td>
					<td>${qna.user.nickname}</td>
					<td><fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd"/></td>
					<c:if test="${qna.reply eq 0 }">
					<td><i class="fa-solid fa-x"></i></td>
					</c:if>
					<c:if test="${qna.reply eq 1 }">
					<td><i class="fa-solid fa-o"></i></td>
					</c:if>
					<td><a href="javascript:deleteQna('${qna.id }')">Delete</a></td>
				</tr>
			</c:forEach>
		</tbody>	
	</table>
	</div>
	
	<div class="d-flex justify-content-center mt-5 mr-auto">
		<ul class="pagination">
			<c:if test="${qna.first==false}">
				<li class="page-item"><a class="page-link" href="?page=${qna.number-1}">이전</a>
			</c:if>
			<c:if test="${qna.last==false}">
				<li class="page-item"><a class="page-link" href="?page=${qna.number+1}">다음</a>
			</c:if>
		</ul>
	</div>
	
</div>

<script>
function deleteQna(id) {
	
	$.ajax({
		type : "delete",
		url : "/inquiry/deleteQna/" + id
	})
	.done(function() {
		alert("Q&A 삭제 완료")
		location.href="/inquiry/myQna/<sec:authentication property='principal.user.id'/>"
	})
	.fail(function() {
		alert("오류")
	})
}
</script>