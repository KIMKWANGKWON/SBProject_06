<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %><br/><br/>

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
                height: 880px;
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
            
.likeContainer {
	padding : 0px 350px;
	color : red;
}
.btn_search{
  font-weight : 900;
  font-family: "Font Awesome 5 Free";
  background-color : transparent;	
  border : none;
  cursor : pointer;
  position : absolute;
  right : 10px;
  top : 40%;
  transform : translatey(-50%);
}

/* 기존 체크박스 안보이게 */
#my_modal input[type=checkbox] {
	display: none;
}

/* 위치 설정 */
#my_modal input[type=checkbox] + label > span{
  vertical-align: middle;
  padding-left: 5px;
 }

/* 필터 체크하기 전 */
#my_modal input[type=checkbox] + label:before{
  content:"";
  display:inline-block;
  width:22px;
  height:22px;
  border:2px solid #F47C7C;
  border-radius: 4px;
  vertical-align:middle;
  cursor:pointer;
  }
  
/* 필터 체크 후 */  
#my_modal input[type=checkbox]:checked + label:before{
  content:"";
  background-color:#F47C7C;
  border-color:#F47C7C;
  background-image: url('/checkImg/check_btn.png');
  background-size:10px;
  background-repeat: no-repeat;
  background-position: 50%;
  }
</style>

<div class="container">
	<div style="display : flex">
		<form action="/restaurant/list" style="position : relative">
			<input type="text" id="keywords" name="keywords" placeholder="Search Restaurant" 
			class="form-control form-control-lg" 
			style="width : 40vw; height : 6vh; margin-bottom: 10px">
			<button type="submit" id="searchBtn" class="btn_search fa-solid fa-magnifying-glass"></button>
		</form>
	</div>
<h1>[${param.keywords }]에 대한 검색결과(${rPage.totalElements})</h1><br/>
 <h4>
 <a href="/restaurant/list?keywords=${param.keywords }&order=popular">조회수 많은 순</a>
 <a href="/restaurant/list?keywords=${param.keywords }&order=recent">최근 등록 순</a>
 </h4>
<button type="button" style="background-color: #48D1CC; border-color: #48D1CC" class="btn btn-primary" id="popup_open_btn">추천 검색어</button>	

  <hr style="border:1px color= silver;" width="auto"> <!-- 선 -->
  <div class="container">
<!--   <h1>File Image</h1><br/> -->
  <div class="row">
  <c:forEach items="${rPage.content}" var="restaurant">
  <div class="card" style="width:400px">
  <div onclick="location.href='/restaurant/view/${restaurant.id}'">
    <img class="card-img-top" src="${restaurant.thumImage }" alt="Card image" style="width:100% height:200">
    <div class="card-body">
      <h4 class="card-title">${restaurant.name }</h4>
      <p class="card-text">운영시간 : ${restaurant.openTime } : ${restaurant.closeTime }<br/></p>
      <p class="card-text">주소 : ${restaurant.address }</p>
      <!-- <a href="#" class="btn btn-primary">detail</a> -->
      </div>
	</div>
    <div class="likeContainer">
      <h2>
    <a onclick="javascript:like(this)" data-param="${restaurant.id }"><span id="showLike">
	<c:choose>
	
		<c:when test="${fMap[restaurant.id] != null}"><i class="fa-solid fa-star"></i>
		</c:when>	
		<c:when test="${fMap[restaurant.id] == null}"><i class="fa-regular fa-star"></i>
		</c:when>
	</c:choose>
	</span></a></h2>
      </div>
    </div>
<%--     <input type="button" class="btn btn-secondary" onclick="like(this)" value="좋아요">
    <input type="hidden" value="${restaurant.id }"/> --%>
    
    </c:forEach>
    
  </div>
  <br>
    <ul class="pagination justify-content-center">
    <c:if test="${rPage.pageable.pageNumber + 1 > 3 }">
    <li class="page-item"><a class="page-link" 
    href="/restaurant/list?keywords=${param.keywords }&order=${param.order }&page=${rPage.pageable.pageNumber - 2}">Previous</a></li>
    </c:if>
    <c:forEach 
    begin="${(((rPage.pageable.pageNumber) / 3) - ((rPage.pageable.pageNumber) / 3) % 1) * 3}" 
    end="${(((rPage.pageable.pageNumber) / 3) - ((rPage.pageable.pageNumber) / 3) % 1) * 3 + 2}" var="page">
    <li class="page-item"><a class="page-link" 
    href="/restaurant/list?keywords=${param.keywords }&order=${param.order }&page=${page+1}">${page+1}</a></li>
    </c:forEach>
    <c:if test="${rPage.pageable.pageNumber + 1 < rPage.totalPages}">
    <li class="page-item"><a class="page-link" 
    href="/restaurant/list?keywords=${param.keywords }&order=${param.order }&page=<fmt:formatNumber type="number" maxFractionDigits="0"  value="${(((param.page-1) / 3) - ((param.page-1) / 3) % 1) * 3 + 4}" />">Next</a></li>
  	</c:if>
  </ul>
</div>
  </div>
<!-- 모달창 -->
 <div id="my_modal">

           
           <h3>추천 검색어</h3><br/>
            <table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:8px; text-align:justify">
            한식
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn1" value='찜'/><label for="check_btn1"><span>찜&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn2" value='탕'/><label for="check_btn2"><span>탕&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn3" value='고기'/><label for="check_btn3"><span>고기&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn4" value='치킨'/><label for="check_btn4"><span>치킨&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
            
           <table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:8px; text-align:justify">
            중식
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn5" value='짜장면'/><label for="check_btn5"><span>짜장면&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn6" value='짬뽕'/><label for="check_btn6"><span>짬뽕&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn7" value='탕수육'/><label for="check_btn7"><span>탕수육&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn8" value='마라탕'/><label for="check_btn8"><span>마라탕&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
            
           <table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            일식
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn9" value='회'/><label for="check_btn9"><span>회&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn10" value='초밥'/><label for="check_btn10"><span>초밥&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn11" value='라멘'/><label for="check_btn11"><span>라멘&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            양식
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn12" value='파스타'/><label for="check_btn12"><span>파스타&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn13" value='피자'/><label for="check_btn13"><span>피자&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn14" value='돈까스'/><label for="check_btn14"><span>돈까스&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            분식
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn15" value='떡볶이'/><label for="check_btn15"><span>떡볶이&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn16" value='김밥'/><label for="check_btn16"><span>김밥&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn17" value='국수'/><label for="check_btn17"><span>국수&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn18" value='닭강정'/><label for="check_btn18"><span>닭강정&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            카페, 디저트
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn19" value='아이스크림'/><label for="check_btn19"><span>아이스크림&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn20" value='빵'/><label for="check_btn20"><span>빵&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn21" value='커피'/><label for="check_btn21"><span>커피&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn22" value='라떼'/><label for="check_btn22"><span>라떼&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn23" value='와플'/><label for="check_btn23"><span>와플&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn24" value='팥빙수'/><label for="check_btn24"><span>팥빙수&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
      		
      		<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            패스트푸드
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn25" value='햄버거'/><label for="check_btn25"><span>햄버거&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn26" value='타코야끼'/><label for="check_btn26"><span>타코야끼&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn27" value='샌드위치'/><label for="check_btn27"><span>샌드위치&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn28" value='토스트'/><label for="check_btn28"><span>토스트&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn29" value='샐러드'/><label for="check_btn29"><span>샐러드&nbsp;&nbsp;</span></label>
				
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            식단제한
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn30" value='채식'/><label for="check_btn30"><span>채식&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn31" value='할랄'/><label for="check_btn31"><span>할랄&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn32" value='코셔'/><label for="check_btn32"><span>코셔&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn33" value='글루텐프리'/><label for="check_btn33"><span>글루텐프리&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			<table>
            <tr>
            <td style="width:100px; border-right:2px solid silver; padding-right:5px; text-align:justify">
            기타
            </td>
            <td style="padding-left:50px">
            	<input type='checkbox' name='food' id="check_btn34" value='인도'/><label for="check_btn34"><span>인도&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn35" value='태국'/><label for="check_btn35"><span>태국&nbsp;&nbsp;</span></label>
				<input type='checkbox' name='food' id="check_btn36" value='멕시코'/><label for="check_btn36"><span>멕시코&nbsp;&nbsp;</span></label>
			</td>
			
			</tr>
			</table>
			<hr style="border:1px color= silver;" width="auto">
			
			
			
			<div>가장 많이 검색한 키워드</div><br/>
				<p>
					<input type='checkbox' name='food' id="check_btn37" value='#한식'/><label for="check_btn37"><span>한식&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn38" value='#커피숍'/><label for="check_btn38"><span>커피숍&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn39" value='#호프'/><label for="check_btn39"><span>호프&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn40" value='#통닭'/><label for="check_btn40"><span>통닭&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn41" value='#기타'/><label for="check_btn41"><span>기타&nbsp;&nbsp;</span></label>
				</p>	
				<p>	
					<input type='checkbox' name='food' id="check_btn42" value='#분식'/><label for="check_btn42"><span>분식&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn43" value='#경양식'/><label for="check_btn43"><span>경양식&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn44" value='#식육(숯불고기)'/><label for="check_btn44"><span>식육(숯불고기)&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn45" value='#중국식'/><label for="check_btn45"><span>중국식&nbsp;&nbsp;</span></label>
					<input type='checkbox' name='food' id="check_btn46" value='#일반조리판매'/><label for="check_btn46"><span>일반조리판매</span></label>
				</p>
			
			
      		
      		<div align="center">
      		<a class="modal_close_btn1"><button onclick='getCheckboxValue()' class="btn btn-info">&nbsp;&nbsp;<i class="fa-solid fa-magnifying-glass"></i>&nbsp;&nbsp;</button></a>
			<div id='result'></div>
			</div>
			
      	<a class="modal_close_btn"><button type="button" class="close" data-dismiss="modal">&times;</button></a>
 </div>

<script>
//좋아요
var like = function(input){
	<sec:authorize access="isAuthenticated()">
	var data = {
			user : {
				id : <sec:authentication property="principal.user.id"/>
			},
			restaurant : {
				id : input.dataset.param  //자기요소 바로 밑에 요소 가져옴 .value 그 값을 불러옴 ->아이디 식별이 안되니까
			} 
	}
	$.ajax({
		type:"post",
		url:"/user/like",
		data : JSON.stringify(data),
		contentType : "application/json;charset=utf-8",
		success:function(resp){
				if(resp==0){
					input.querySelector('span i').className="fa-regular fa-star"
				} else{
					input.querySelector('span i').className="fa-solid fa-star"
				}
		}
	})
	return;
	</sec:authorize>
	alert("로그인이 필요한 서비스입니다.")
}



function getCheckboxValue()  {
	  // 선택된 목록 가져오기
	  const query = 'input[name="food"]:checked';
	  const selectedEls = 
	      document.querySelectorAll(query);
	  
	  // 선택된 목록에서 value 찾기
	  let result = '';
	  selectedEls.forEach((el) => {
	    result += el.value + ' ';
	  });
	  
	  // 출력
	  $('#keywords').val(result)
	}



//모달
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
    
    // checkbox 선택 후 닫기 버튼 처리
    modal.querySelector('.modal_close_btn1').addEventListener('click', function() {
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
   