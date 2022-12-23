<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  	<title>06</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<!-- dateTimepicker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<!-- FontAwesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
</head>
<link rel="stylesheet" href="/css/header.css"/>
<header class="fixed-top">
<%@ include file="GNB.jsp"%>
<div class="shadow" style="position:fixed;top:0px;width:100vw;height:71px;"></div>
</header>
<body>
<!-- 로그인 모달 -->
<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Login</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          <input type="text" id="username" name="username" class="form-control" placeholder="Enter ID"><br>
          <input type="password" id="password" name="password" class="form-control" placeholder="Enter Password">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <span id="loginErrMsg"></span><button type="button" class="btn btn-info" id="btnLogin">Login</button>
        </div>
      </div>
    </div>
 </div>
  <script>
 //로그인모달 유효성검사
var uLogin = function() {
	if($("#username").val()=="") {
		alert("ID를 입력하세요!")
		return false;
	}
	if($("#pass").val()=="") {
		alert("비밀번호를 입력하세요!")
		return false;
	}
	$.ajax({
		type : "post",
		url : "/user/login",
		data : {
			username : $("#username").val(),
			password : $("#password").val()
		}
	})
	.done(function(resp){
		if(resp == "success"){
			location.reload();
			return;
		}
		$("#loginErrMsg").text(resp);
	})
	.fail(function(e){
		
	})
}
$("#username").on("keyup",function(key){
    if(key.keyCode==13) {
        $("#password").focus();
    }
});
$("#password").on("keyup",function(key){
    if(key.keyCode==13) {
        uLogin();
    }
});
$("#btnLogin").click(uLogin);
</script>
