<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/mypage.css"/>
	<div class="col-2">
	<div class="list-group list-group-flush" 
	style="margin-top : 120px; margin-left : 40px;">
		<h4><a href="/user/mypage/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">마이페이지</a></h4>
		<a href="/user/view/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 정보 상세보기</a>
	  	<a href="/user/reservationList/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 예약 현황</a>
	  	<a href="/user/favorites/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 즐겨찾기 목록</a>
	  	<a href="/user/userReview/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 후기 목록</a>
		<a href="/inquiry/myQna/<sec:authentication property="principal.user.id"/>" class="list-group-item list-group-item-action">내 Q&A 목록</a>
	</div>
	</div>