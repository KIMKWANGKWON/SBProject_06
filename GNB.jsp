<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

</style>
<div class="gnb">
<nav class="navbar navbar-expand-sm mb-3">
  <a class="navbar-brand mr-auto" href="/root">
<!--     <img src="bird.jpg" alt="Logo" style="width:40px;"> -->
    <b>루트</b>
  </a>
  <!-- Links -->
  <div id="defNav">
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="#">식당 목록</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">커뮤니티</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">기타 및 문의	</a>
    </li>
    </ul>
   </div>
   <!-- 비회원 -->
   <div id="userNav">
   <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="/user/join">회원가입</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="modal" data-backdrop="static" data-target="#myModal">로그인</a>
    </li>
    <li>
      <div class="dropdown"> <!--  내 정보 -->
    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
      내 정보
    </button>
    <div class="dropdown-menu">
      <h5 class="dropdown-header">마이페이지</h5>
      <a class="dropdown-item" href="#">Link 1</a>
      <a class="dropdown-item" href="#">Link 2</a>
      <a class="dropdown-item" href="#">Link 3</a>
      <h5 class="dropdown-header">식당 관리</h5> <!-- 사업자라면 -->
      <a class="dropdown-item" href="/owner/restaurantList">내 식당 보기</a>
    </div>
  </div>
    </li>
  </ul>
  </div>
</nav>
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
          <button type="button" class="btn btn-info" id="btnLogin" data-dismiss="modal">Login</button>
        </div>
        
      </div>
    </div>
 </div>
 <script>
$("#btnLogin").click(function() {
	if($("#username").val()=="") {
		alert("ID를 입력하세요!")
		return false;
	}
	if($("#pass").val()=="") {
		alert("비밀번호를 입력하세요!")
		return false;
	}
})
</script>