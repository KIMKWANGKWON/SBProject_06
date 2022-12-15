<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h2>[]님의 즐겨찾기</h2>
  	<table class="table mt-5">
  		<thead align="center">
  			<tr>
  				<th>음식점</th>
  				<th>이름</th>
  				<th>전화번호</th>
  				<th>운영시간</th>
  				<th>상세정보</th>
  				<th></th>
  			</tr>
  		</thead>
   		<tbody align="center">
   			<c:forEach items="${favorites}" var="favorite">
    			<tr>
					<td><img alt="thum" src="${favorite.restaurant.thumImage }"></td>
       				<td><a href="/restaurant/view/${favorite.restaurant.id }">${favorite.restaurant.name }</a></td>
        			<td>${favorite.restaurant.tel }</td>
        			<td>${favorite.restaurant.hours }</td>
        			<td>${favorite.restaurant.description }</td>
        			<td><input type="button" class="btn btn-danger" value="delete"></td>
      			</tr>
      		</c:forEach>
    	</tbody>
  	</table>
</div>
