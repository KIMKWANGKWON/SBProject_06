<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file ="../include/header.jsp" %>

<div class="row">
	<%@ include file="mypageLeftNav.jsp" %>
	<div class="col-8">
		<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 Q&A</h2>
	
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
					<td><button type="button" class="btn btn-danger" onclick="deleteQna('${qna.id }')"><i class="fa-solid fa-trash"></i></button></td>
				</tr>
			</c:forEach>
		</tbody>	
	</table>

	
	<div class="d-flex justify-content-center mt-5 mr-auto">
		<ul class="pagination justify-content-center">
			<fmt:formatNumber type="number" maxFractionDigits="0" groupingUsed="false" value="${((qna.pageable.pageNumber) / 3 - ((qna.pageable.pageNumber) / 3) % 1)}" var="start"/>

		    <li class="page-item <c:if test="${qna.pageable.pageNumber < 3 }">disabled</c:if>"><a class="page-link" 
		    href="/inquiry/myQna/<sec:authentication property="principal.user.id"/>?page=${start * 3 - 3}">Previous</a></li>
		    <c:forEach 
		    begin="${start * 3 }" 
		    end="${start * 3 + 2 }" var="page">
		    <c:if test="${page+1 <= qna.totalPages }">
		    <li class="page-item <c:if test="${qna.pageable.pageNumber eq page }">active</c:if>"><a class="page-link" 
		    href="/inquiry/myQna/<sec:authentication property="principal.user.id"/>?page=${page}">${page+1}</a></li>
		    </c:if>
		    </c:forEach>
		    <li class="page-item <c:if test="${start * 3 + 3 >= qna.totalPages }">disabled</c:if>"><a class="page-link" 
		    href="/inquiry/myQna/<sec:authentication property="principal.user.id"/>?page=${start * 3 + 3}">Next</a></li>
		 </ul>
	</div>
		</div>

	<div class="col-2"></div>
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