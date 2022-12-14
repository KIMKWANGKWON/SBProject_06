<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/* 가로줄 */
#userNav::before {
    content: '';
    position: absolute;
    display: block;
/*     left: -1px; */
    top: 6px;
    bottom: 6px;
    border-right: 1px solid white
/*     #d2d5d9 */
}
.gnb {
	width:80vw;
 	height:20vh;
	position : absolute;
	top : 50%;
	left : 50%;
	transform:translate(-50%, -170%);
}
.nav-link {
	color : white;
}
</style>
<div class="gnb">
<nav class="navbar navbar-expand-sm mb-3">
  <a class="navbar-brand mr-auto" href="#">
<!--     <img src="bird.jpg" alt="Logo" style="width:40px;"> -->
    <b>메인</b>
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
      <a class="nav-link" href="#">회원가입</a>
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
      <a class="dropdown-item" href="#">내 식당 보기</a>
    </div>
  </div>
    </li>
  </ul>
  </div>
</nav>
</div>

<div class="modal fade" id="myModal"> <!-- 로그인 모달 -->
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          Modal body..
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>