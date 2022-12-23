<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Root</title>
<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="/css/root.css"/>

<style>
/* top */
a.top {
  position: fixed;
  left: 92%;
  bottom: 50px;
  display: none;
}
</style>

</head>

<body>
<header class="up">
<div id="gnb" style="width:100vw" class="fixed-top">
<%@ include file="include/GNB.jsp" %>
<div class="shadow" style="position:fixed;top:0px;width:100vw;height:71px;"></div>
</div>
<span></span>
<div class="header_body">
	<h4>쓰고 싶은 말</h4>
   	<h2>식욕을 자극할만한 문구</h2>
   	<div style="display : flex">
    	<form action="/restaurant/list" style="position : relative">
			<input type="text" id="keywords" name="keywords" placeholder="Search Restaurant"
			class="searchBtn form-control form-control-lg"
			style="width : 40vw; height : 6vh; margin-bottom: 10px">
        	<button class="btn_search fa-2x" style="color : #212121 !important;"></button>
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
      		<div class="d-flex mb-3">
      		<c:forEach items="${recentList }" var="recent" varStatus="st">
      			<div class="order-${st.count }">
         			<img class="left_img" src="${recent.thumImage }"
         			onclick="location.href='/restaurant/view/${recent.id}'"/>
         			<div align="center">${recent.name }</div>
      			</div>
      		</c:forEach>
      		</div>
   		</div>
   
		<div class="art art_right">
   			<h4>현재 인기있는 식당</h4>
   			<div class="d-flex mb-3">
   			<div class="ml-auto"></div>
   			<c:forEach items="${popularList }" var="popular" varStatus="st">
      			<div class="order-${st.count }">
         			<img class="right_img" src="${popular.thumImage }"
         			onclick="location.href='/restaurant/view/${popular.id}'"/>
         			<div align="center">${popular.name }</div>
      			</div>
   			</c:forEach>
   			</div>
   		</div>
   
   		<div class="art">
   			<h4>따로 등록할 식당</h4>
      		<div class="d-flex mb-3">
      		<c:forEach items="${recentList }" var="recent" varStatus="st">
      			<div class="order-${st.count }">
         			<img class="left_img" src="${recent.thumImage }"
         			onclick="location.href='/restaurant/view/${recent.id}'"/>
         			<div align="center">${recent.name }</div>
      			</div>
      		</c:forEach>
      		</div>
   		</div>
   
</div>

<div class="any_content">
   <h2><button type="button" id="goAnywhere">아무 식당 가기</button></h2>
</div>
<script>
$("#goAnywhere").click(function(){
	var randomId = Math.floor(Math.random() * ${rstrCount}) + 1;
	location.href="/restaurant/view/"+randomId;
})
</script>


<%@ include file="include/footer.jsp" %>

</div>
<div class="col-2">
 <h1><a href="#" class="top"><i class="fa-solid fa-arrow-up"></i></a></h1>
</div>
</div>
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


</body>

<script>
function checkVisible( element, check = 'above' ) {
    const viewportHeight = $(window).height(); // Viewport Height
    const scrolltop = $(window).scrollTop(); // Scroll Top
    const y = $(element).offset().top;
    const elementHeight = $(element).height();   
    
    // 반드시 요소가 화면에 보여야 할경우
    if (check == "visible") 
    	return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
        
    // 화면에 안보여도 요소가 위에만 있으면 (페이지를 로드할때 스크롤이 밑으로 내려가 요소를 지나쳐 버릴경우)
    if (check == "above") 
    	return ((y < (viewportHeight + scrolltop)));
}

// 리소스가 로드 되면 함수 실행을 멈출지 말지 정하는 변수
let isVisible = false;

// 이벤트에 등록할 함수
const func = function () {
    if ( !isVisible && checkVisible('.row') ) {
    	$( 'html, body' ).animate( { scrollTop : $(".row").offset().top }, 400 );
    	
        isVisible = true;
    }
    
    // 만일 리소스가 로드가 되면 더이상 이벤트 스크립트가 있을 필요가 없으니 삭제
    isVisible && window.removeEventListener('scroll', func);
}

// 스크롤 이벤트 등록
window.addEventListener('scroll', func);
const sFollower = function(){
	if($(window).scrollTop() < $(".row").offset().top){
		$("header").attr("class","up");
// 		$("#gnb").css("box-shadow","none");
		$("#gnb").css("height","0");
		$(".shadow").attr("class","noShadow");
	} else{
		$("header").attr("class","down");
		$("#gnb").css("height",$("nav").height()+13);
		$(".noShadow").attr("class","shadow");
// 		$("#gnb").css("box-shadow","0px 0px 10px 5px gray");
	}
}
window.addEventListener('scroll', sFollower);

// 어느정도 스크롤 시 top 링크 보임
$( window ).scroll( function() {
   if ( $( this ).scrollTop() > 200 ) {
      $( '.top' ).fadeIn();
   } else {
      $( '.top' ).fadeOut();
   }
} );

//top클릭 시 스르륵 올라감
$( '.top' ).click( function() {
   $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
   return false;
} );

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
</html>