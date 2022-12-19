<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/css/mypage.css"/>
<div class="row">
	<div class="col-2">
	<div class="list-group list-group-flush" 
	style="margin-top : 120px; margin-left : 40px;">
	  <a href="/user/view/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 정보 상세보기</a>
	  <a href="/user/update/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 정보 수정</a>
	  <a href="#" class="list-group-item list-group-item-action">Third item</a>
	</div>
	</div>
	<div class="col-8">
		<h2 style="margin-top: 50px;">마이페이지</h2>
		<hr/>
		<div class="row">
			<div class="col-4">
				<div style="margin-left: 30px;
							margin-top : 30px;">
				<img src="/img/test.png"/>
				</div>
			</div>
			<div class="col-8">
				<dl>
					<dt>닉네임</dt>
					<dd>${user.nickname }</dd>
				</dl>
				<dl>
					<dt>주소</dt>
					<dd>${user.address }</dd>
				</dl>
				<dl>
					<dt>전화번호</dt>
					<dd>${user.tel }</dd>
				</dl>
				<dl>
					<dt>가입날짜</dt>
					<dd><fmt:formatDate value="${user.regdate }" pattern="yyyy-MM-dd"/></dd>
				</dl>
			</div>
		</div>
		<div>
		<hr/>
		<h4>현재 예약 현황</h4>
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
				<c:if test="${rsv.id eq null }">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				</c:if>
				<c:if test="${rsv.id ne null }">
				<tr>
					<td><img src="${rsv.restaurant.thumImage}"></td>
					<td>${rsv.restaurant.name}</td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${rsv.rsvDateTime}" pattern="HH:mm"/></td>
					<td><a href="/user/reservationUpdate/${rsv.id}"><button type="button" class="btn btn-primary" id="updateRsv">예약 변경</button></a></td>
					<td><button type="button" class="btn btn-info" data-toggle="collapse" data-target="#demo${rsv.id }">예약내용 상세보기</button></td>
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
				</c:if>
		</tbody>
			</table>
		</div>
	</div>
	<div class="col-2"></div>
</div>
<%@ include file="../include/footer.jsp"%>