<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
    
<div class="container">
	<h2 align="center">상세보기</h2><br><br><br>
	<div class="form-group">
		<label for="userid">ID :</label>
		<input type="text" id="userid" name="userid" class="form-control" value="${user.id }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="nickname">Nickname :</label>
		<input type="text" id="nickname" name="nickname" class="form-control" value="${user.nickname }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="password">PWD :</label> 
		<input type="password" id="pwd" name="pwd" class="form-control" value="${user.password }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="role">Role :</label>
		<input type="text" id="role" name="role" class="form-control" value="${user.role }" readonly="readonly">
	</div>
	
	<div align="right">
		<button type="button" class="btn btn-info" id="btnUpdateForm">수정폼</button>
	</div>
</div>

 
<script>
$("#btnUpdateForm").click(function(){
	if(!confirm("수정폼으로 이동"))
		return false;
	location.href="/user/update/${id}"
});
</script>  