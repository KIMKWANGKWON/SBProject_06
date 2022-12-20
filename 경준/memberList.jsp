<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container mt-3">
	<h3 align="center">회원 목록 (<span id="cntSpan">${count}</span>)</h3>
	<table class="table table-hover">
		<thead>
			<tr align="center">
				<th>User ID</th>
				<th>Nickname</th>
				<th>Tel</th>
				<th>Address</th>
				<th>Regdate</th>
				<th>Role</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${member}" var="member">
			<c:choose>
				<c:when test="${member.role eq 'ROLE_ADMIN'}">
					<c:set var="str" value="관리자"/>
				</c:when>
				<c:when test="${member.role eq 'ROLE_OWNER'}">
					<c:set var="str" value="사업자"/>
				</c:when>
				<c:when test="${member.role eq 'ROLE_USER'}">
					<c:set var="str" value="일반회원"/>
				</c:when>
			</c:choose>
			<tr align="center">
				<td><a href = "/admin/memberView/${member.id}">${member.username}</a></td>
				<td>${member.nickname}</td>
				<td>${member.tel }</td>
				<td>${member.address }</td>
				<td><fmt:formatDate value="${member.regdate}" pattern="yyyy-MM-dd"/></td>
				<td>${str }</td>
				<td><input type="button" class="btn btn-outline-danger btn-sm" value="Delete" onclick="mdel('${member.id}','${str }')"></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<script>
	function mdel(id, str) {
		if(str=="관리자") {
			alert("관리자는 삭제할 수 없습니다")
			return
		}
		if(!confirm("정말 삭제하겟습니까?")) {
			return false;
		}
		$.ajax({
			type : "delete",
			url : "/admin/memberDelete/" + id
		})
		.done(function() {
			alert("삭제 성공")
			location.href = "/admin/memberList"	
		})
		.fail(function() {
			alert("삭제 실패")
		})
	}
</script>
