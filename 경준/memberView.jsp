<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>
<div class="container">
	<h2 align="center">${member.nickname }님의 회원정보</h2><br><br><br>
	<div class="form-group">
		<label for="userid">ID :</label>
		<input type="text" id="userid" name="userid" class="form-control" value="${member.username }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="nickname">Nickname :</label>
		<input type="text" id="nickname" name="nickname" class="form-control" value="${member.nickname }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="tel">Tel :</label>
		<input type="text" id="tel" name="tel" class="form-control" value="${member.tel }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="address">Address :</label>
		<input type="text" id="address" name="address" class="form-control" value="${member.address }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="regdate">Regdate :</label>
		<input type="text" id="regdate" name="regdate" class="form-control" value="<fmt:formatDate value="${member.regdate}" pattern="yyyy-MM-dd"/>" readonly="readonly">
	</div>
	<div class="form-group">
		<div align="center">
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="ROLE_ADMIN" disabled>Admin
   				</label>
   			</div>
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="ROLE_OWNER" disabled>Owner
  				</label>
   			</div>
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="ROLE_USER" disabled>User
  				</label>
   			</div>
		</div>
	</div>
	<script>
		$("input:radio[value=${member.role}]").attr("checked",true);
	</script>
	<div align="center">
		<button type="button" class="btn btn-info" id="btnBack">뒤로가기</button>
	</div>
</div>

<script>
	$("#btnBack").click(function() {
		history.back();
	})
</script>