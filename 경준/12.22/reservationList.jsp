<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>
<jsp:useBean id="now" class="java.util.Date" />
<link rel="stylesheet" href="/css/mypage.css"/>
<div class="row">
<%@ include file="mypageLeftNav.jsp" %>
	<div class="col-8">
	<h2 align="center"><sec:authentication property="principal.user.nickname"/>님의 예약현황</h2>
<table class="table table-hover">
		<thead align="center">
			<tr>
				<th>음식점</th>
				<th>이름</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>예약확인</th>
				<th>예약변경</th>
				<th>후기작성</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach items="${reservations.content}" var="rsv">
				<tr>
					<td><img src="${rsv.restaurant.thumImage}"></td>
					<td>${rsv.restaurant.name}</td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/></td>
					<td><button type="button" class="btn btn-info" data-toggle="collapse" data-target="#demo${rsv.id }"><i class="fa-solid fa-magnifying-glass"></i></button></td>
					<c:if test="${rsv.rsvDateTime >= now}">
					<td><a href="/user/reservationUpdate/${rsv.id}"><button type="button" class="btn btn-primary" id="updateRsv"><i class="fa-solid fa-pen"></i></button></a></td>
					<td></td>
					</c:if>
					<c:if test="${rsv.rsvDateTime < now}">
					<td></td>
					<td><a href="/user/review/${rsv.restaurant.id}"><button type="button" class="btn btn-danger" id="review"><i class="fa-solid fa-comments"></i></button></a>
					</c:if>
				</tr>
				<tr>
				<td colspan="7">  
    			<div id="demo${rsv.id }" class="collapse">
    				<div id="card" class="card" style="width:100%">	<!-- 예약정보 -->
  						<div class="row" align="center">
  						<div class="col-lg-7">
							<div class="card-body" align="left">
								<div class="row">
								<div class="col-lg-7">
									<table class="table table-borderless">
										<tr><td><h1>reservation</h1></td></tr>
										<tr><td><h3>${rsv.restaurant.name }</h3></td></tr>
										<tr><td><h6>${rsv.restaurant.tel }</h6></td></tr>
      								</table>
      							</div>
      							<div class="col-lg-5">
      								<table class="table table-borderless">
      									<tr>
      										<td>예약자</td>
      										<td>${rsv.user.nickname }</td>
      									</tr>
      									<tr>
      										<td>예약자수</td>
      										<td>${rsv.peopleCnt }</td>
      									</tr>
      									<tr>
      										<td>예약날짜</td>
      										<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/></td>
      									</tr>
      									<tr>
      										<td>예약시간</td>
      										<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/></td>
      									</tr>
      								</table>
								</div>
      							</div>
    						</div>
  						</div>
  						<div class="col-lg-5">
  							<div class="card-body" align="left">
  								<table class="table table-borderless">
  									<tr>
  										<td rowspan="7"width="30%">요구사항</td>
  										<td rowspan="7">${rsv.msg }</td>
  									</tr>
									<tr></tr>
									<tr></tr>
									<tr></tr>
									<tr></tr>
									<tr></tr>
									<tr></tr>
     							</table>
     						</div>
     					</div>
     					</div>
     				</div>
    			</div>
    			</td>
  				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="d-flex justify-content-center mt-5 mr-auto">
		<c:set value="${reservations }" var="pageImpl"/>
		<c:url value="/user/reservationList/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.user.id}" var="url">
		</c:url>

		<%@include file="../include/pagination.jsp" %>
	</div>
	</div>
	<div class="col-2"></div>
</div>