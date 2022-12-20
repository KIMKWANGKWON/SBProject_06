<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file ="../include/header.jsp" %>

<div class="container">
	<h3 align="center">${qna.user.nickname}의 Q&A</h3>
	<table class="table table-borderless">
		<tr>
			<td width="10%">번호</td>
			<td width="40%"><input type="hidden" name="id" id="id" value="${qna.id}">${qna.id}</td>
			<td width="10%"></td>
			<td></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${qna.user.nickname}</td>
			<td>작성일</td>
			<td><fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><input type="text" class="form-control" name="title" value="${qna.title}" readonly="readonly"></td>
		</tr>
		<tr>	
			<td>내용</td>
			<td colspan="3"><textarea class="form-control" rows="10" name="msg" readonly="readonly">${qna.msg}</textarea></td>
		</tr>
	</table>
	<hr>
	<table class="table table-borderless">
		<tr>
			<td width="10%">답글</td>
			<td><textarea class="form-control" rows="3" cols="50" id="msg" readonly="readonly">${qna.response.msg }</textarea></td>
		</tr>
	</table>
	<hr>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<c:if test="${qna.response eq null }">
	<table class="table table-borderless">
		<tr>
			<td width="10%">답글쓰기</td>
			<td><textarea class="form-control" rows="3" cols="50" id="writeMsg"></textarea></td>
		</tr>
	</table>
	<div align="center">
		<button type="button" class="btn btn-secondary btn-sm" id="btnResponse">답글쓰기</button><hr>
	</div>
	</c:if>
	</sec:authorize>
	

	
</div>  

<script>
$("#btnResponse").click(function() {
	if($("#writeMsg").val()=="") {
		alert("답글을 입력하세요")
		return;
	}
	var data = {
		"inquiry_id" : $("#id").val(),
		"msg" : $("#writeMsg").val()
	}
	$.ajax({
		type : "post",
		url : "/inquiry/responseInsert/" + $("#id").val(),
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data)
	})
	.done(function() {
		alert("답글 추가 성공")
		location.href = "/inquiry/qnaList"
	})
	.fail(function() {
		alert("오류")
	})
})


</script>
