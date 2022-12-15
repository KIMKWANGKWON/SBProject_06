<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="include/gnb.jsp" %><br/><br/>

<style>
#popup_open_btn{
        width:110px;
  		margin-left: 1000px;
        display:block;
    }

#btnSelect{
        width:110px;
        magin-left : 100px;
    }
    
#my_modal {
                display: none;
                width: 1000px;
                height: 800px;
                padding: 20px 60px;
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 3px;
            }

#my_modal .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            
</style>

<div class="container">
<h1>[]에 대한 검색결과</h1><br/>

 <!-- 모달창 -->
 <div id="my_modal">
           <h3>필터</h3><br/>
           
           <h5>음식 종류</h5><br/>
           <button type="button" style="background-color: #FFB6C1; border-color: #FFB6C1" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id="btnSelect">
            한식
            </button>
            <div class="dropdown-menu">
            <label><input type="checkbox" name="food" value="01"> 1 </label>
            <label><input type="checkbox" name="food" value="02"> 2 </label>
            <label><input type="checkbox" name="food" value="03"> 3 </label>
            </div>
            
            <button type="button" style="background-color: #FFB6C1; border-color: #FFB6C1" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id="btnSelect">
            양식
            </button>
            <div class="dropdown-menu">
            <label><input type="checkbox" name="food" value="01"> 1 </label>
            <label><input type="checkbox" name="food" value="02"> 2 </label>
            <label><input type="checkbox" name="food" value="03"> 3 </label>
            </div>
            
      		
      		<button type="button" style="background-color: #FFB6C1; border-color: #FFB6C1" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id="btnSelect">
            중식
            </button>
            <div class="dropdown-menu">
            <label><input type="checkbox" name="food" value="01"> 1 </label>
            <label><input type="checkbox" name="food" value="02"> 2 </label>
            <label><input type="checkbox" name="food" value="03"> 3 </label>
            </div>
            
            <button type="button" style="background-color: #FFB6C1; border-color: #FFB6C1" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" id="btnSelect">
            일식
            </button>
            <div class="dropdown-menu">
            <label><input type="checkbox" name="food" value="01"> 1 </label>
            <label><input type="checkbox" name="food" value="02"> 2 </label>
            <label><input type="checkbox" name="food" value="03"> 3 </label>
            </div><br/>
      		<hr style="border:1px color= silver;" width="auto">
      		
      		<h5>가격</h5><br/>
      		<label><input type="checkbox" name="food" value="r"> 저렴한 음식 </label>
      		<label><input type="checkbox" name="food" value="m"> 중간급 </label>
      		<label><input type="checkbox" name="food" value="h"> 고급 정찬 </label>
      		<hr style="border:1px color= silver;" width="auto">
      		
      		<h5>식단 제한</h5><br/>
      		<label><input type="checkbox" name="food" value="f"> 채식주의 식단 </label>
      		<label><input type="checkbox" name="food" value="h"> 할랄 </label>
      		<label><input type="checkbox" name="food" value="c"> 코셔 </label>
      		<label><input type="checkbox" name="food" value="g"> 글루텐 프리 </label>
      <a class="modal_close_btn">X</a>
 </div>
 
<button type="button" style="background-color: #48D1CC; border-color: #48D1CC" class="btn btn-primary" id="popup_open_btn">설정</button>	

  <hr style="border:1px color= silver;" width="auto"> <!-- 선 -->
  <div class="container">
  <h1>File Image</h1><br/>
  <div class="row">
  <c:forEach items="${file }" var="fboard">
  <div class="card" style="width:400px">
    <img class="card-img-top" src="/resources/img/${fboard.fileimage }" alt="Card image" style="width:100% height:200">
    <div class="card-body">
      <h4 class="card-title">title:${fboard.title }</h4>
      <p class="card-text">writer:${fboard.writer }</p>
      <p class="card-text">content:${fboard.content }</p>
      <!-- <a href="#" class="btn btn-primary">detail</a> -->
      </div>
    </div>
    </c:forEach>
  </div> 
  <br>
</div>
  </div>


<script>
function modal(id) {
    var zIndex = 9999;
    var modal = document.getElementById(id);

  // 모달 div 뒤에 희끄무레한 레이어
    var bg = document.createElement('div');
    bg.setStyle({
        position: 'fixed',
        zIndex: zIndex,
        left: '0px',
        top: '0px',
        width: '100%',
        height: '100%',
        overflow: 'auto',
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
        bg.remove();
        modal.style.display = 'none';
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
    });
}

// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
    for (var k in styles) this.style[k] = styles[k];
    return this;
};

document.getElementById('popup_open_btn').addEventListener('click', function() {
    // 모달창 띄우기
    modal('my_modal');
});
</script>
   


