<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>
    
<div class="container">
	<h2 align="center">수정</h2><br><br><br>
	<div class="form-group">
		<label for="userid">ID :</label>
		<input type="text" id="userid" name="userid" class="form-control" value="${user.id }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="nickname">Nickname :</label>
		<input type="text" id="nickname" name="nickname" class="form-control" value="${user.nickname }">
	</div>
	<div class="form-group">
		<label for="password">PWD :</label> 
		<input type="password" id="pwd" name="pwd" class="form-control" value="${user.password }" >
	</div>
		<div class="form-group">
		<label for="password">PWD Check :</label> 
		<input type="password" id="pwd_check" name="pwd_check" class="form-control" value="${user.password}" placeholder="Enter Password_check">
	</div>
	
	<div align="right">
		<button type="button" class="btn btn-info" id="btnUpdate">수정하기</button><br/><br/>
		<button type="button" class="btn btn-danger" id="btnDelete">탈퇴하기</button>
	</div>
</div>

<script>
$("#btnUpdate").click(function(){
	if($("#nickname").val()==""){
		alert("닉네임을 입력하세요");
		$("#nickname").focus();
		return false;
	}
	if($("#pwd").val()==""){
		alert("비밀번호를 입력하세요");
		$("#pwd").focus();
		return false;
	}
	if($("#pwd").val()!=$("#pwd_check").val()){
		alert("비밀번호가 일치하지 않습니다");
		$("#pwd_check").focus();
		return false;
	}
	data={
			"id":$("#userid").val(),
			"nickname":$("#nickname").val(),
			"password":$("#pwd").val()
	}
	$.ajax({
		type:"put",
		url:"/user/update",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data)
	})
	.done(function(resp){
		if(resp=="success"){
			alert("회원정보가 변경되었습니다")
			location.href="/user/view/1";
		}
	})
	.fail(function(e){
		alert("회원정보 변경에 실패하였습니다")
	})
})//수정

$("#btnDelete").click(function(){
	if(!confirm("탈퇴하면 복구하실 수 없습니다. 그래도 탈퇴하시겠습니까?")){
		return false;
	}
	$.ajax({
		type:"delete",
		url:"/user/delete/${id}",
		success:function(resp){
			if(resp=="success"){
				alert("탈퇴 완료되었습니다")
				location.href="/"
			}
		},
		error:function(e){
			alert("탈퇴에 실패하였습니다. 관리자에게 문의해주세요.")
		}
	})
})//삭제

</script>