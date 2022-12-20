<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container mt-3">
	<h3 align="center">음식점 목록 (<span id="cntSpan">${count}</span>)</h3>
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<th>Restaurant</th>
				<th>Owner</th>
				<th>Address</th>
				<th>Tel</th>
				<th>URL</th>
				<th>Regdate</th>
				<th>Enabled</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${restaurant}" var="rst">
			<tr align="center">
				<td><a href = "/admin/restaurantView/${rst.id}">${rst.name}</a></td>
				<td><a href = "/admin/memberView/${rst.owner.id}">${rst.owner.nickname}</a></td>
				<td>${rst.address }</td>
				<td>${rst.tel }</td>
				<td>${rst.url }</td>
				<td><fmt:formatDate value="${rst.regdate}" pattern="yyyy-MM-dd"/></td>
				<c:choose>
					<c:when test="${rst.enabled eq true }">
						<c:set var="str" value="게시 중"/>
					</c:when>
					<c:when test="${rst.enabled eq false }">
						<c:set var="str" value="게시 대기"/>
					</c:when>
				</c:choose>
				<td>${str }</td>
				<td><input type="button" class="btn btn-outline-danger btn-sm" value="Delete" onclick="rdel('${rst.id}')"></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<script>
	function rdel(id) {
		if(!confirm("정말 삭제하겟습니까?")) {
			return false;
		}
		$.ajax({
			type : "delete",
			url : "/admin/restaurantDelete/" + id
		})
		.done(function() {
			alert("삭제 성공")
			location.href = "/admin/restaurantList"
		})
		.fail(function() {
			alert("삭제 실패")
		})
	}
</script>