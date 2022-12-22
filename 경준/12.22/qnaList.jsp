<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file ="../include/header.jsp" %>

<div class="container">
	<h2 align="center">Q&A목록(${count })</h2>
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<th>Id</th>
				<th>Title</th>
				<th>Nickname</th>
				<th>Regdate</th>
				<th>Reply</th>
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
				</tr>
			</c:forEach>
		</tbody>	
	</table>
	<!-- Page -->
	<ul class="pagination justify-content-center">
		<fmt:formatNumber type="number" maxFractionDigits="0" groupingUsed="false" value="${((qna.pageable.pageNumber) / 3 - ((qna.pageable.pageNumber) / 3) % 1)}" var="start"/>

		    <li class="page-item <c:if test="${qna.pageable.pageNumber < 3 }">disabled</c:if>">
		    <a class="page-link" href="/inquiry/qnaList?page=${start * 3 - 3}">Previous</a></li>
		    <c:forEach 
		    begin="${start * 3 }" 
		    end="${start * 3 + 2 }" var="page">
		    <c:if test="${page+1 <= qna.totalPages }">
		    <li class="page-item <c:if test="${qna.pageable.pageNumber eq page }">active</c:if>"><a class="page-link" 
		    href="/inquiry/qnaList?page=${page}">${page+1}</a></li>
		    </c:if>
		    </c:forEach>
		    <li class="page-item <c:if test="${start * 3 + 3 >= qna.totalPages }">disabled</c:if>"><a class="page-link" 
		    href="/inquiry/qnaList?page=${start * 3 + 3}">Next</a></li>
	</ul>
		 
	<!-- Search -->	 
	<div class="d-flex justify-content-center mt-5 mr-auto">
		<div>
			<form class="form-inline" action="/inquiry/qnaList" method="get">
				<select name="field" class="form-control mr-sm-1">
					<option value="title">제목</option>
				</select>
				<input type="text" name="word" class="form-control" placeholder="search">
				<button class="btn btn-info">검색</button>
			</form>
		</div>
	</div>
</div>
