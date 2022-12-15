<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h2 align="center">회원가입</h2><br><br><br>
	<div class="form-group">
		<label for="userid">ID :</label>
		<input type="text" id="userid" name="userid" class="form-control" placeholder="Enter User ID">
	</div>
	<div class="form-group">
		<label for="nickname">Nickname :</label>
		<input type="text" id="nickname" name="nickname" class="form-control" placeholder="Enter Nickname">
	</div>
	<div class="form-group">
		<label for="password">PWD :</label> 
		<input type="password" id="pwd" name="pwd" class="form-control" placeholder="Enter Password">
	</div>
	<div class="form-group">
		<label for="password">PWD Check :</label> 
		<input type="password" id="pwd_check" name="pwd_check" class="form-control" placeholder="Enter Password_check">
	</div>
	<div class="form-group">
		<div align="center">
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="0" checked>Admin
   				</label>
   			</div>
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="1">Owner
  				</label>
   			</div>
   			<div class="form-check-inline">
   				<label class="form-check-label">
       				<input type="radio" class="form-check-input" id="role" name="role" value="2">User
  				</label>
   			</div>
		</div>
	</div>
	<div align="center">
		<button type="button" class="btn btn-info" id="btnJoin">Join</button>
	</div>
</div>

<script>
$("#btnJoin").click(function() {
	if($("#userid").val()=="") {
		alert("ID를 입력하세요!")
		return false;
	}
	if($("#nickname").val()=="") {
		alert("Nickname을 입력하세요!")
		return false;
	}
	if($("#pwd").val()=="") {
		alert("비밀번호를 입력하세요!")
		return false;
	}
	if($("#pwd_check").val()=="") {
		alert("비밀번호확인을 입력하세요!")
		return false;
	}
	if($("#pwd").val()!=$("#pwd_check").val()) {
		alert("비밀번호가 다릅니다!")
		return false;
	}
	var dataParam = {
		"username" : $("#userid").val(),
		"password" : $("#pwd").val(),
		"nickname" : $("#nickname").val(),
		"role" : $('input:radio[name=role]:checked').val()
	}
	$.ajax({
		type : "post",
		url : "/user/join",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(dataParam)
	})
	.done(function(resp) {
		if(resp=="success") {
			alert("회원가입 성공!")
			location.href="/"
		} else if(resp=="fail") {
			alert("아이디 중복")
			$("#userid").val("")
			$("#pwd").val("")
			$("#pwd_check").val("")
			$("#nickname").val("")
		}
	})
	.fail(function(e) {
		alert("오류 : " + e)
	})
})
</script>