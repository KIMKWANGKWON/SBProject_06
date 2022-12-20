<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h3 align="center">[<sec:authentication property="principal.user.nickname"/>]님의 예약현황</h3>
	<table class="table table-hover">
		<thead align="center">
			<tr>
				<th>음식점</th>
				<th>이름</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>예약변경</th>
				<th></th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach items="${reservations}" var="rsv">
				<tr>
					<td><img src="${rsv.restaurant.thumImage}"></td>
					<td>${rsv.restaurant.name}</td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/></td>
					<td><a href="/user/reservationUpdate/${rsv.id}"><button type="button" class="btn btn-primary" id="updateRsv">예약 변경</button></a></td>
					<td><button type="button" class="btn btn-info" data-toggle="collapse" data-target="#demo${rsv.id }">예약내용 상세보기</button></td>
					<td><a href="/user/review/${rsv.restaurant.id}"><button type="button" class="btn btn-danger" id="review"></button></a>
				</tr>
				<tr>
				<td colspan="6">  
  				<div id="demo${rsv.id }" class="collapse">
    				<div class="card" style="width:100%">	<!-- 예약정보 -->
  						<div class="row" align="center">
  						<div class="col-lg-8">
							<div class="card-body" align="left">
								<div class="row">
								<div class="col-lg-6">
									<label for="name">예약자</label>
      								<input type="text" name="name" class="form-control" value="${rsv.user.nickname }" readonly="readonly"><br>
      								<label for="peopleCnt">예약자 수</label>
      								<input type="text" name="peopleCnt" class="form-control" value="${rsv.peopleCnt }" readonly="readonly">
      							</div>
      							<div class="col-lg-6">
									<label for="rsvDate">예약날짜</label>
      								<input type="text" name="rsvDate" class="form-control" value="<fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/>" readonly="readonly"><br>
      								<label for="rsvTime">예약시간</label>
      								<input type="text" name="rsvTime" class="form-control" value="<fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/>" readonly="readonly">
      							</div>
      							</div>
    						</div>
  						</div>
  						<div class="col-lg-4">
  							<div class="card-body" align="left">
  								<label for="msg">요구사항</label>
     							<textarea class="form-control" rows="6" name="msg" readonly="readonly">${rsv.msg }</textarea>
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
</div>