<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="container">
	<h1 align="center"><i class="fa-solid fa-font-case">Q&A</i></h1>
	<div class="mt-5">
	<form action="/inquiry/writeQna" method="post">
    	<div class="form-group">
      		<label for="writer">글쓴이:</label>
      		<input type="text" class="form-control" value="<sec:authentication property="principal.user.nickname"/>" readonly="readonly">
    	</div>
    	<div class="form-group">
      		<label for="title">제목:</label>
      		<input type="text" class="form-control" id="title" name="title">
    	</div>
      	<div class="form-group">
      		<label for="msg">내용</label>
     		<textarea class="form-control" rows="10" id="msg" name="msg"></textarea>
    	</div>
    	<div class="form-group text-center">
      		<button type="submit" class="btn btn-info">글쓰기</button>
     	</div> 
  	</form>
  	</div>
</div> 