<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>


<style>
	.restaurant_image{
		width: 40%;
	}
	.restaurant_info{
		margin-left: 30px;
		width: 50%
	}
	
	.form-title{
		width:40%;
		height:100%
	}
</style>



<div class="container">
	<h2 align="left">
	<div class="form-title">
	<input type="text" class="form-control" name="name" id="name" placeholder="이름">
	</div>
	</h2><br/>
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="restaurant_image">
				<div class="mb-3">
  				<input class="form-control" type="file" name="image" id="image">
  				<img src="/img/test.png">
				</div>
			</div>
      		<div class="restaurant_info">
				<table class="table table-borderless">
					
					<tr>
					<td><label for="address">주소</label></td>
					<td><input type="text" class="form-control" name="address" id="address"></td>
					</tr>
					
					<tr>
					<td><label for = "tel">전화번호</label></td>
					<td><input type="text" class="form-control" name="tel" id="tel"></td>
					</tr>
					
					<tr>
					<td><label for = "hours">운영시간</label></td>
					<td><input type="text" class="form-control" name="hours" id="hours"></td>
					</tr>
					
					<tr>
					<td><label for = "url">홈페이지</label></td>
					<td><input type="text" class="form-control" name="url" id="url"></td>
					</tr>
					
				</table>
				<div>

				</div>
			</div>
    	</div>  
  	</div>
	<hr>
  	<input type="button" class="btn btn-info" id="btnUpdate" value="update">

