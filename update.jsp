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
      		<div class="restaurant_info"><!-- 테이블 -->
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
				<div><!-- 테이블 -->

				</div><!-- 로우 -->
			</div><!-- 컨테이너 -->
    	</div>
  	</div>
	<hr>
	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="col-md"><button onclick="javascript:show('menuResult')" class="btn btn-link">Menu</button></div>
      		<div class="col-md"><button onclick="javascript:show('descriptionResult')" class="btn btn-link">가게 정보</button></div>
      		<div class="col-md"><button onclick="javascript:show('commentResult')" class="btn btn-link">후기</button></div>
    	</div>  
  	</div>
  	<hr>
  	<div id="menuResult">
  	<table class='table table-borderless'>
			<thead>
				<tr align='center'>
				<th>메뉴</th>
				<th>이름</th>
				<th>가격</th>
				<th>기타</th>
				</tr>
			</thead>
			
	<tbody>
    
    <tr align="center">
    
    <td><input type="file" class="form-control" id="img" name="img"></td>
    
	<td><input type="text" class="form-control" name="name" id="name" placeholder="메뉴 이름"></td>

	<td><input type="text" class="form-control" name="price" id="price" placeholder="가격"></td>
	
	<td><input type="text" class="form-control" name="description" id="description" placeholder="설명">
	
	</tr>
			
  	</tbody>
  	</table>
  	<button type="button" id="btnMenu">+</button><!-- 메뉴입력 -->
  	</div>

  	<div id="replyResult">
  	
  	<div id="descriptionResult">
  	<h4>${restaurant.description }</h4>
  	</div>
  	<div id="commentResult">
  	</div>
	</div>
	<script src="/js/detail.js"></script>
	<script>
	show("menuResult") //디폴트
	
	var init = function(){
		$.ajax({
			type:"get",
			url:"/menu/list"+$("#id").val()
		})
		.done(function(resp){
			var str = "<table class='table table-hover'>"
			$.each(resp, function(key, val){
				str+="<tr>"
				str+="<td>"++"</td>"
				str+="<td>"+val.menu.name+"</td>"
				str+="<td>"+val.price+"</td>"
				str+="<td>"+val.description+"</td>"
				str+="</tr>"
			})
			str+="</table>"
			$("#replyresult").html(str);
		})
	}
	
	
	$("#btnMenu").click(function(){
		var form = $("#img").get(0).files[0];
		var data={
				"name":$("#name").val(),
				"price":$("#price").val(),
				"description":$("#description").val()
		}
		var formData = new FormData();
		$.ajax({
			type:"PUT",
			url:"/menu/update",
			contentType:"multipart/form-data;charset=utf-8",
			data:JSON.stringify(data, formData),
			success:function(resp){
				alert("메뉴가 저장되었습니다")
				init();
			},
			error:function(e){
				alert("메뉴 저장에 실패하였습니다"+e)
			}
		})
	})
	
	</script>
  	<input type="button" class="btn btn-info" id="btnUpdate" value="update">
