<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>GNB</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
#userNav::before {
    content: '';
    position: absolute;
    display: block;
/*     left: -1px; */
    top: 6px;
    bottom: 6px;
    border-right: 1px solid
/*     #d2d5d9 */
</style>
<body>
<div class="container">
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
</body>
</html>
