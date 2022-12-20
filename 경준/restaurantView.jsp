<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h2 align="left">${restaurant.name }의 상세보기</h2>
	<input type="hidden" value="${restaurant.id }">
      		<div class="restaurant_image">
				<img class="img-fluid" src="${restaurant.thumImage }" alt="food">
			</div>
				<table class="table table-borderless">
					<tr>
						<td width=10%>Owner</td>
						<td width=40%>${restaurant.owner.nickname }</td>
						<td width=10%>BusinessNum</td>
						<td>${restaurant.businessNum }</td>
					</tr>
					<tr>
						<td width=10%>Tel</td>
						<td width=40%>${restaurant.tel }</td>
						<td width=10%>Regdate</td>
						<td><fmt:formatDate value="${restaurant.regdate}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<td>Hours</td>
						<td>${restaurant.openTime } ~ ${restaurant.closeTime}<br/>
						<td>Last Rsv</td>
						<td>${restaurant.rsvTime }</td>
					</tr>
					<tr>
						<td>Address</td>
						<td colspan="3">${restaurant.address }<td>
					</tr>
					<tr>
						<td>URL</td>
						<td colspan="3">${restaurant.url }<td>
					</tr>
					<tr>
						<td>Description</td>
						<td><textarea class="form-control" readonly="readonly">${restaurant.description }</textarea></td>
					</tr>
				</table>
				
	<div align="center">
		<button type="button" class="btn btn-info" id="btnBack">뒤로가기</button>
	</div>
</div>

<script>
	$("#btnBack").click(function() {
		history.back();
	})
</script>
