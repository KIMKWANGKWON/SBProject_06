<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Root</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="/css/root.css"/>
<body>
<header>
<%@ include file="include/gnb.jsp" %>
<span></span>
<div class="header_body">
	<h4>
	쓰고 싶은 말
	</h4>
	<h2>식욕을 자극할만한 문구</h2>
	<div style="display : flex">
		<form style="position : relative">
			<input type="text" placeholder="Search Restaurant" 
			class="searchBtn form-control form-control-lg"
			style="width : 40vw; height : 6vh; margin-bottom: 10px">
			<button class="btn_search fa-2x"></button>
		</form>
	</div>
	<a>카테고리</a>
</div>
</header>
<div class="row">
<div class="col-2"></div>
<div class="col-8">

<div class="clearfix">
	<div class="art">
	<h4>최근에 등록된 식당</h4>
		<div class="art_imgs">
			<img class="left_img" src="/img/test.png"/>
			<img class="left_img" src="/img/test.png"/>
			<img class="left_img" src="/img/test.png"/>
		</div>
	</div>
	<div class="art art_right">
	<h4>현재 인기있는 식당</h4>
		<div class="art_imgs">
			<img class="right_img" src="/img/test.png"/>
			<img class="right_img" src="/img/test.png"/>
			<img class="right_img" src="/img/test.png"/>
		</div>
	</div>
	<div class="art">
	<h4>따로 넣을만한 항목</h4>
		<div class="art_imgs">
			<img class="left_img" src="/img/test.png"/>
			<img class="left_img" src="/img/test.png"/>
			<img class="left_img" src="/img/test.png"/>
		</div>
	</div>
</div>

<div class="any_content">
	<h2>관심을 끌만한 컨텐츠</h2>
</div>

<%@ include file="include/footer.jsp" %>

</div>
<div class="col-2" style=""></div>
</div>
</body>
</html>