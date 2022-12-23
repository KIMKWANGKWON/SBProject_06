<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  	<script src="https://code.jquery.com/jquery-3.6.2.js"></script>

</head>
<body>
<button type="button" id="getRestAPI">레스토랑 오픈API 가져오기</button><br/>
<button type="button" id="getThumImgAPI">레스토랑 이미지 가져오기</button><br/>
<button type="button" id="getMenuAPI">메뉴 오픈API 가져오기</button><br/>
<button type="button" id="getMenuImgAPI">메뉴 이미지 가져오기</button><br/>
<a href="/restaurant/view/1">테스트</a><br/>
<a href="/root">루트</a>
</body>
<script>
$("#getThumImgAPI").click(function(){
	getThumImgAPI(1);
})
var getThumImgAPI = function(pageNo){
	$.ajax({
		type : "GET",
		url : "https://busan-food.openapi.redtable.global/api/rstr/img?serviceKey=auc1Uy8p1eqdVhKEbHpqJf1wW8PSoDzwBA6iB8rWFZ0FWtJrrHuM98Y7MQ0Rm7C1&pageNo=" + pageNo
	})
	.done(function(resp){
		var dataArray = [];
		$.each(resp.body,function(index,val){
			var dataParam = {
					businessNum : val.RSTR_ID,
					thumImage : val.RSTR_IMG_URL
				}
			dataArray.push(dataParam);
			})
			$.ajax({
				type : "POST",
				url : "/test/rstrImgInsert",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(dataArray),
			})
			.done(function(){
				getThumImgAPI(pageNo + 1);
			})
		})
	}
$("#getMenuImgAPI").click(function(){
	menuImgTest();
})
var menuImgTest = function() {
	$.ajax({
		type : "GET",
		url : "https://busan-food.openapi.redtable.global/api/food/img?serviceKey=auc1Uy8p1eqdVhKEbHpqJf1wW8PSoDzwBA6iB8rWFZ0FWtJrrHuM98Y7MQ0Rm7C1"
	})
	.done(function(resp){
		$.each(resp.body,function(index,val){
			var dataParam = {
					id : val.MENU_ID,
					img : val.FOOD_IMG_URL
				}
			$.ajax({
				type : "POST",
				url : "/test/menuInsert",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(dataParam),
			})
			.done(function(){
				
			})
		})
	})
}
$("#getMenuAPI").click(function(){
	menuTest(1);
})
var menuTest = function(pageNo) {
	if(pageNo >= 183) {
		return;
	}
	$.ajax({
		type : "GET",
		url : "https://busan-food.openapi.redtable.global/api/menu-dscrn/korean?serviceKey=auc1Uy8p1eqdVhKEbHpqJf1wW8PSoDzwBA6iB8rWFZ0FWtJrrHuM98Y7MQ0Rm7C1&pageNo=" + pageNo
	})
	.done(function(resp){
		var dataArray = [];
		$.each(resp.body,function(index,val){
			var descriptionInfo = "분류 : " + val.MENU_CTGRY_LCLAS_NM + "<br/>"; 
			if(val.MENU_CTGRY_SCLAS_NM != "" || val.MENU_CTGRY_SCLAS_NM != null){
				descriptionInfo += "세부분류 : " + val.MENU_CTGRY_SCLAS_NM + "<br/>";
			}
			if(val.MENU_DSCRN != "" || val.MENU_DSCRN != null){
				descriptionInfo += "주재료명 : " + val.MENU_DSCRN
			}
			var dataParam = {
					id : val.MENU_ID,
					name : val.MENU_NM,
					price : val.MENU_PRICE,
					description : descriptionInfo,
					restaurant : {
						businessNum : val.RSTR_ID
					}
				}
			dataArray.push(dataParam);
		})
			$.ajax({
				type : "POST",
				url : "/test/menuInsert",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(dataArray),
			})
			.done(function(){
				
			})
		menuTest(pageNo + 1);
	})
}
$("#getRestAPI").click(function(){
	rstrTest(1);
})
var rstrTest = function(pageNo){
	if(pageNo >= 52) {
		return;
	}
	$.ajax({
		type : "GET",
		url : "https://busan-food.openapi.redtable.global/api/rstr?serviceKey=auc1Uy8p1eqdVhKEbHpqJf1wW8PSoDzwBA6iB8rWFZ0FWtJrrHuM98Y7MQ0Rm7C1&pageNo=" + pageNo
		
	})
	.done(function(resp){
		var dataArray = [];
		$.each(resp.body,function(index,val){
			if(val.BSNS_STATM_BZCND_NM == null) val.BSNS_STATM_BZCND_NM = "";
			else val.BSNS_STATM_BZCND_NM = "<br/>#" + val.BSNS_STATM_BZCND_NM;
			val.BSNS_STATM_BZCND_NM = val.BSNS_STATM_BZCND_NM.replace(/\//gi,"#");
			var dataParam = {
					"name" : val.RSTR_NM,
					"businessNum" : val.RSTR_ID,
					"address" : val.RSTR_RDNMADR,
					"tel" : val.RSTR_TELNO,
					"url" : "localhost:8888",
					"description" : val.RSTR_INTRCN_CONT + val.BSNS_STATM_BZCND_NM,
					"owner" : {
						id : <sec:authentication property="principal.user.id"/>
					}
			}
			dataArray.push(dataParam);
// 			alert(JSON.stringify(dataParam));
			})
			$.ajax({
			type : "post",
			url : "/test/rstrInsert",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(dataArray)
	})
		})
	rstrTest(pageNo + 1);
}

</script>
</html>