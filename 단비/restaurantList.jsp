<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<div class="row">
<div class="col-2"></div>
<div class="col-8">
	<h2>내 식당 관리</h2>
	<a href="/owner/register">식당 추가</a>
	<hr/>
	<div class="table-responsive">
	    <table class="table table-bordered">
	      <thead>
	        <tr>
	          <th>#</th>
	          <th>대표 사진</th>
	          <th>식당명</th>
	          <th>주소</th>
	          <th>전화번호</th>
	          <th>운영시간</th>
	          <th>옵션</th>
	        </tr>
	      </thead>
	      <tbody>
	      <c:forEach items="${restaurantList }" var="restaurant">
	        <tr>
	          <td>1</td>
	          <td><img class="thumImg" src="${restaurant.thumImage }"/></td>
	          <td><a href="/restaurant/view/${restaurant.id }">${restaurant.name }</a></td>
	          <td>${restaurant.address }</td>
	          <td>${restaurant.tel }</td>
	          <td>${restaurant.openTime } : ${restaurant.closeTime }<br/>
	          	  예약 마감 시간 : ${restaurant.rsvTime }</td>
	          <td>
	          	<button type="button" 
	          	onclick="location.href='/owner/update/${restaurant.id}'">정보 수정</button>
	          	<button type="button" onclick="rClose('${restaurant.id}')">폐업하기</button>
	          	<button type="button" onclick="enable(this,1)" data-id="${restaurant.id }">개시하기</button>
	          	<button type="button" onclick="enable(this,0)" data-id="${restaurant.id }">개시안하기</button>
	          </td>
	        </tr>
	      </c:forEach>
	      </tbody>
	    </table>
	  </div>
</div>
<div class="col-2"></div>
</div>
<script>
var enable = function(btn,enabled){
	$.ajax({
		type : "PUT",
		url : "/owner/setEnable",
		data : {
			"id" : btn.dataset.id,
			"enabled" : enabled
		}
// 		contentType : "application/json;charset=utf-8"
	})
	.done(function(resp){
		if(enabled == 1){
			alert("개시했습니다.")
		} else{
			alert("개시하지 않습니다.")
		}
	})
	.fail(function(e){
		alert("Error : " + e);
	})
} 

var rClose = function (id){
	$.ajax({
		type:"delete",
		url:"/owner/close/"+id
	})
	.done(function(resp){
		location.href="/owner/restaurantList/<sec:authentication property="principal.user.id"/>";
	})
	.fail(function(e){
		alert("가게 삭제 실패")
	})
}

</script>
<%@ include file="../include/footer.jsp"%>