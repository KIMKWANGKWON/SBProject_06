<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="../include/header.jsp" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<style>
	.restaurant_image {
		width: 40%;
	}
	.restaurant_info {
		margin-left: 30px;
		width: 50%
	}
	
	.form-title {
		width:40%;
		height:100%
	}
</style>

<input type="hidden" id="id" value="${restaurant.id }"/>

<div class="container">
	
	<div class="form-title">
		<h2 align="left">
			<input type="text" class="form-control" value=${restaurant.name } name="name" id="name" placeholder="이름">
		</h2><br/>
	</div>
	
	
  	<div class="container-fluid">
    	<div class="row" align="center">
      		<div class="restaurant_image">
				<div class="mb-3">
  					<input class="form-control files" onchange="readURL(this);"	type="file" name="image" id="image">
  					<img id="preview" src="${restaurant.thumImage }" alt="썸네일">
				</div>
			</div>
      		<div class="restaurant_info"><!-- 테이블 -->
				<table class="table table-borderless">
					<tr>
						<td><label for="address">주소</label></td>
						<td><input type="text" class="form-control" value="${restaurant.address }" name="address" id="address"></td>
					</tr>
					
					<tr>
						<td><label for = "tel">전화번호</label></td>
						<td><input type="text" class="form-control" value="${restaurant.tel }" name="tel" id="tel"></td>
					</tr>
					
					<tr>
						<td><label for = "hours">운영시간</label></td>
						<td><label for = "openTime">오픈시간</label>
							<input type="text" class="form-control timepicker" value="${restaurant.openTime }" name="openTime" id="openTime">
							<label for = "closeTime">마감시간</label>
							<input type="text" class="form-control timepicker" value="${restaurant.closeTime }" name="closeTime" id="closeTime">
							<label for = "rsvTime">예약마감시간</label>
							<input type="text" class="form-control timepicker" value="${restaurant.rsvTime }" name="rsvTime" id="rsvTime"></td>
					</tr>
					
					<tr>
						<td><label for = "url">홈페이지</label></td>
						<td><input type="text" class="form-control" value="${restaurant.url }" name="url" id="url"></td>
					</tr>
					
				</table>
			</div><!-- 테이블 -->

		</div><!-- 로우 -->
	</div><!-- 컨테이너 -->

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
					<th><h2><a href="javascript:addMenu()"><i class="fa-regular fa-square-plus"></i></a></h2></th>
				</tr>
			</thead>
			
			<tbody>
       			<c:forEach items="${restaurant.menuList}" var="menu">
  				<tr class="menus" align='center'>	
	  				<td><input class="form-control files" onchange="readURL(this)" type="file" name="menu_image">
	  					<img src="${menu.img }" alt="메뉴이미지"></td>
	  				<td><input type="hidden" name="menu_id" value="${menu.id }"/>
	  					<input type="text" class="form-control" name="menu_name" value="${menu.name }" placeholder="메뉴 이름"/></td>
	  				<td><input type="text" class="form-control" name="menu_price" value="${menu.price }" placeholder="가격"/></td>
	  				<td><input type="text" class="form-control" name="menu_description" value="${menu.description }" placeholder="설명"/></td>
	  				<td><button type="button" class="btn btn-danger btn-sm" onclick="mDel(this)">ㅡ</button></td>
  				</tr>
  				</c:forEach>
  			</tbody>
  		</table>
 	</div>

  	<div id="replyResult">
	  	<div id="descriptionResult">
  			<h4><textarea id="description" name="description">${restaurant.description }</textarea></h4>
  		</div>
  		<div id="commentResult">
  		</div>
	</div>
	<div align="center">
		<input type="button" class="btn btn-info" id="btnUpdate" value="update">
	</div>
</div>

<script src="/js/detail.js"></script>
<script>
	var mDel = function(btn){
		if(confirm("메뉴를 정말 삭제할까요?")){
			btn.parentNode.parentNode.remove();
		}
	}
	
	var addMenu = function(){ //메뉴추가
		var html = '<tr class="menus" align="center">';
		html += '<td>';
		html += '<input type="file" onchange="readURL(this)"'
		html += 'class="form-control files" name="menu_img">'
		html += '<img src="${menu.img }" alt="메뉴이미지">'
		html += '</td>';
		html += '<td>'
		html +=	'<input type="hidden" name="menu_id"/>'
		html += '<input type="text" class="form-control" name="menu_name" placeholder="메뉴 이름"></td>'
		html +=	'<td><input type="text" class="form-control" name="menu_price" placeholder="가격"></td>'
		html +=	'<td><input type="text" class="form-control" name="menu_description" placeholder="설명"></td>'
		html +=	'<td><button type="button" class="btn btn-danger btn-sm" onclick="mDel(this)">ㅡ</button></td>'
		html +=	'</tr>';
		$("#menuResult > table > tbody").append(html);
	}
	
	show("menuResult") //디폴트
	function readURL(input) {  //이미지 실시간 업로드
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      input.nextElementSibling.src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		      input.nextElementSibling.src = "";
		  }
	}
	$("#btnUpdate").click(function(){
		save();
	});
	var save = function(){
			// 넘길 데이터를 담아준다. 
			var formData = new FormData(); //ajax로 보낼 비어있는 폼데이터!
			var menuList = [];
			for (var i = 0; i < $(".menus").length; i++) {
				var menu = {
					"id" : $("input[name=menu_id]").eq(i).val(),
					"name" : $("input[name=menu_name]").eq(i).val(),
					"price" : $("input[name=menu_price]").eq(i).val(),
					"description" : $("input[name=menu_description]").eq(i).val(),
					"restaurant" : {
						"id" : $("#id").val()
					}
				}
				menuList.push(menu); //메뉴리스트에 메뉴를 추가함!
				}
			var res_data = {   
				"id" : $("#id").val(),
			    "name"    : $("#name").val(),
			    "address"     : $("#address").val(),
			    "tel"  :  $("#tel").val(),
			    "openTime"    : $("#openTime").val(),
			    "closeTime"    : $("#closeTime").val(),
			    "rsvTime"    : $("#rsvTime").val(),
			    "description"    : $("#description").val(),
			    "url"    : $("#url").val(),
			    "enabled" : $("#enabled").val(),
			    "menuList" : menuList
			}
			// input class 값 
			var fileInput = $('.files');
			// fileInput 개수를 구한다.
			for (var i = 0; i < fileInput.length; i++) {
				if (fileInput[i].files.length > 0) { //요소에 파일이 하나라도 있다면
					for (var j = 0; j < fileInput[i].files.length; j++) {						
						// formData에 'file'이라는 키값으로 fileInput 값을 append 시킨다.  
						formData.append('file', $('.files')[i].files[j]);
					}
				} else {
						formData.append('file', new File(["empty"],"empty"));
				}
			}
			// 'restaurant'라는 이름으로 위에서 담은 data를 formData에 append한다. type은 json  
			formData.append('restaurant', new Blob([ JSON.stringify(res_data) ], {type : "application/json"}));

			// ajax 처리 부분 * 
			$.ajax({
				  type : "PUT",
			      url: '/owner/update',
			      data: formData,
			      contentType: false,               // * 중요 *
			      processData: false,               // * 중요 *
			      enctype : 'multipart/form-data',  // * 중요 *
			      success: function(data) {
					alert(data);
			      }
			});
	};
	$(document).ready(function(){
    	$('input.timepicker').timepicker({});
	});
	
	$('.timepicker').timepicker({
    	timeFormat: 'HH:mm',
    	interval: 30,
   		minTime: '0',
    	maxTime: '23:30',
    	
    	startTime: '0',
    	dynamic: false,
    	dropdown: true,
    	scrollbar: true
	});
	
// 	$("#btnMenu").click(function(){
// 		var form = $("#img").get(0).files[0];
// 		var data={
// 				"name":$("#name").val(),
// 				"price":$("#price").val(),
// 				"description":$("#description").val()
// 		}
// 		var formData = new FormData();
// 		$.ajax({
// 			type:"PUT",
// 			url:"/menu/update",
// 			contentType:"multipart/form-data;charset=utf-8",
// 			data:JSON.stringify(data, formData),
// 			success:function(resp){
// 				alert("메뉴가 저장되었습니다")
// 				init();
// 			},
// 			error:function(e){
// 				alert("메뉴 저장에 실패하였습니다"+e)
// 			}
// 		})
// 	})
show("menuResult")
</script>