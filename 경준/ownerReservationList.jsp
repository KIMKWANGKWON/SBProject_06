<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h3 align="center">내 식당 예약현황(${count })</h3>
	<table class="table table-hover">
		<thead align="center">
			<tr>
				<th>음식점</th>
				<th>이름</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>예약자수</th>
				<th>요구사항</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach items="${rsv}" var="rsv">
				<tr>
					<td>${rsv.restaurant.name}</td>
					<td>${rsv.user.nickname }</td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/></td>
					<td>${rsv.peopleCnt }</td>
					<td>${rsv.msg }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>