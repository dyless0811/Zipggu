<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="login" value="${loginNo != null}"></c:set>
<c:set var="admin" value="${loginGrade eq '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
	<html lang="ko">
    <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>zipggu</title>
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/zipggu.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/member.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
   
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
    
    <script>
    	//form이 전송되면 input[type=password]가 자동 암호화되도록 설정
    	$(function(){
    		$("form").submit(function(e){
    			//this == form
    			e.preventDefault();//form 기본 전송 이벤트 방지
    			
    			//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
    			$(this).find("input[type=password]").each(function(){
    				//this == 입력창
    				var origin = $(this).val();
    				var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
    				var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
    				$(this).val(encrypt);
    			});
    			
    			this.submit();//form 전송 지시
    		});
    	});
    </script>
    <script>
      $(function () {
        $(document).scroll(function () {
          var con = $("#remoCon");
          
          var position = $(window).scrollTop();
          
          if (position > 250) {
            con.fadeIn(400);
          } else if (position < 250) {
            con.fadeOut(400);
          }
        });
        
        $("#remoCon").click(function () {
          $("html, body").animate({ scrollTop: 0 }, 50);
        });
      });
    </script>
    
<!-- 팔로우 -->   
<script>

var me = '${loginNick}';

	$(document).ready(function() {

		$(".followBtn").click(function(e) {
			var memberNoValue = $(this).data("member-no");
			var memberNickValue = document.getElementById("followBtn_"+memberNoValue).value;
			var button = $(this);

			$.ajax({
				url : "${pageContext.request.contextPath}/follow/follow",
				type : "POST",
				data : {
					memberNo : memberNoValue
				},
				dataType : "text",
				success : function(resp) {
					console.log("팔로우성공", resp);
            		console.log("you", memberNickValue);
						
            	 	you= memberNickValue;
            		
            	 	var res = '팔로우성공';
            	 	
					 var Msg = me+","+you+","+res;

					 sock.send(Msg);

					$("#followBtn_" + memberNoValue).css('display', 'none');
					$("#unfollowBtn_" + memberNoValue).css('display', 'block');

				},
				error : function(e) {
					console.log("실패", e);
				}
			});
		});

		$(".unfollowBtn").click(function(e) {
			var memberNoValue = $(this).data("member-no");
			var memberNickValue = document.getElementById("unfollowBtn_"+memberNoValue).value;
			var button = $(this);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/follow/unfollow",
				type : "POST",
				data : {
					memberNo : memberNoValue
				},
				dataType : "text",
				success : function(resp) {
					console.log("언팔로우성공", resp);

            	 	you= memberNickValue;
            		
            	 	var res = '언팔로우성공';
            	 	
					 var Msg = me+","+you+","+res;

					 sock.send(Msg);
					
					$("#followBtn_" + memberNoValue).css('display', 'block');
					$("#unfollowBtn_" + memberNoValue).css('display', 'none');

				},
				error : function(e) {
					console.log("실패", e);
				}
			});
		});
	});



	$(document).ready(function() {

		$(".profileFollowBtn").click(function(e) {
			var memberNoValue = $(this).data("member-no");
	        var memberNickValue = document.getElementById("profileFollowBtn_${memberDto.memberNo}").value;
			var button = $(this);

			$.ajax({
				url : "${pageContext.request.contextPath}/follow/follow",
				type : "POST",
				data : {
					memberNo : memberNoValue
				},
				dataType : "text",
				success : function(resp) {
					console.log("팔로우성공", resp);
            		console.log("you", memberNickValue);
						
            	 	you= memberNickValue;
            	 	
            		var res = '팔로우성공';
            		
            		 var Msg = me+","+you+","+res;

					 sock.send(Msg);

					$("#profileFollowBtn_" + memberNoValue).css('display', 'none');
					$("#profileUnfollowBtn_" + memberNoValue).css('display', 'block');

				},
				error : function(e) {
					console.log("실패", e);
				}
			});
		});

		$(".profileUnfollowBtn").click(function(e) {
			var memberNoValue = $(this).data("member-no");
			var memberNickValue = document.getElementById("profileUnfollowBtn_${memberDto.memberNo}").value;
			var button = $(this);
			$.ajax({
				url : "${pageContext.request.contextPath}/follow/unfollow",
				type : "POST",
				data : {
					memberNo : memberNoValue
				},
				dataType : "text",
				success : function(resp) {
					console.log("언팔로우성공", resp);

            	 	you= memberNickValue;
            		
            	 	var res = '언팔로우성공';
            	 	
					 var Msg = me+","+you+","+res;

					 sock.send(Msg);
					
					$("#profileFollowBtn_" + memberNoValue).css('display', 'block');
					$("#profileUnfollowBtn_" + memberNoValue).css('display', 'none');

				},
				error : function(e) {
					console.log("실패", e);
				}
			});
		});
	});
</script>
 
    
    
 <!-- 웹소켓 -->
    <script>

    var socket = null;

	   $(document).ready(function (){
		   connectWs();
	   });
	   
    	   function connectWs(){
	   
    		var uri = "${pageContext.request.contextPath}/websocket";    	
    		   
    	   	sock = new SockJS(uri);

    	   	sock.onopen = function() {
    	        console.log('open111',111111111);
    	    
    	   	 };

    	    sock.onmessage = onMessage; 
    	   	 
    	   	function onMessage(evt){
    	   		
    	   	    var data = evt.data;
    	   	    
    	   	 console.log('evt1111',data);
    	   	 
    	   	 $(".toastFollow").fadeIn(400).delay(2200).fadeOut(400); //5 seconds
			 $(".toastFollow").text(data); 

    	   	};	
    	    	 
    	    	sock.onclose = function() {
    	    	    console.log('close1111');
    	    	    
    	   	 };    
    	   };
  
    </script>
    
  
    
    <style>
      #remoCon {
        position: fixed;
        
        width: 40px;
        
        height: 40px;
        
        right: 40px;
        
        bottom: 50px;
        
        display: none;
        
        color: #abb8c3;
      }
      
.toastFollow { 
	width: 400px;
	 height: 20px; 
	 height:auto;
	  position: fixed; 
	  left: 50%; 
	  margin-left:-125px; 
	  bottom: 100px; 
	  z-index: 9999; 
	  background-color: #35c5f0;
	  border-color: #35c5f0;
	  border: 1px solid #35c5f0;
	   color: #ffffff;
	   font-weight:bold;
	    font-family: Calibri; 
	   font-size: 15px; 
	   padding: 10px; 
	   text-align:center; 
	   border-radius: 2px;
		box-shadow: 0px 0px 24px -1px rgba(56, 56, 56, 1); 
}


      
    </style>
</head>
<body>

<div style="height: 100%;">
	      <svg id="remoCon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
  		<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
	  </svg>
    <header>
      <div class="navEmptySpace">
        <div class="head head-fixed">
          <div class="head-bar head-bar-white">
            <div class="navigation">
              <div class="nav-new">
                <div class="logo">
                  <a href="${root }">

                  	<div class="logo-img"></div>

                  </a>
                </div>
                <div class="menu">
                  <c:if test="${admin}">
                  <a href="${root}/admin">
                    <div class="item">관리자</div>
                  </a>
                  </c:if>
                  <a href="${root}/store">
                    <div class="item">스토어</div>
                  </a>
                  <a href="${root }/sns">
                    <div class="item">커뮤니티</div>
                  </a>
<%--                    <a href="${root }/member/memberList"> --%>
<!--                     <div class="item">회원목록</div> -->
<!--                   </a> -->
                  <div class="right">
                    <!-- <a href="/search"> -->
                    <div class="item sm-bar">
                      <div class="search-input-wrap">
                        <div class="input-round">
                          <div class="text">
                            <!-- 내 스타일 매거진, 상품, 사진 검색 -->
                            <form action="${root}/store/list" method="get">
                              <input
                                class="search-box"
                                type="text"
                                name="itemName"
                                placeholder="상품 검색"
                                autocomplete="off"
                              />
                            </form>
                          </div>
                          <div class="search-icon"></div>
                        </div>
                      </div>
                    </div>
                    <!-- </a> -->
                            <c:choose>
								<c:when test="${login}">
									<a href="${root }/cart/list">
                	                    <div class="item sm-bar cart-icon">
                	                    	<c:if test="${cartCount > 0}">
                	                    	<span id="count" class="cart-count"></span>
                	                    	</c:if>
					                       <img src="//cdn.ggumim.co.kr/resource/icons/ic_cart_black.png"
					                         style="
					                           width: 20px;
					                           height: 28px;
					                           vertical-align: top;
					                           margin-top: 26px;
					                         "
					                       />
					                     </div>
					               </a>
								</c:when>
								<c:otherwise>
									<a href="${root }/member/login">
					                    <div class="item sm-bar cart-icon">
					                       <img
					                        src="//cdn.ggumim.co.kr/resource/icons/ic_cart_black.png"
					                        style="
					                          width: 20px;
					                          height: 28px;
					                          vertical-align: top;
					                          margin-top: 26px;
					                         "
					                       />
					                     </div>
					               </a>
								</c:otherwise>
							</c:choose>

                    <c:choose>
                    <c:when test="${login}">
                    <!-- 회원일 때 -->
                    <div class="item sm-bar member">
                      <div class="profile-image-wrapper">
                     
                          	<c:choose>
								<c:when test="${loginProfileNo != 0}">
									<img src="${root}/member/profile?memberNo=${loginNo}" class="profile-image">
								</c:when>
								<c:otherwise>
									<img src="https://via.placeholder.com/120x120?text=User" class="profile-image">
								</c:otherwise>
							</c:choose>
							
                      </div>
                      <div class="nickname">${loginNick} </div>
                      <div
                        class="subnavigation subnavigation-menu"
                        style="right: 10px; top: 80px; z-index: 999"
                      >
                        <div class="member-profile-section">
                          <div class="profile-image">
                                               
                           	<c:choose>
								<c:when test="${loginProfileNo != 0}">
									<img src="${root}/member/profile?memberNo=${loginNo}" class="profile-image">
								</c:when>
								<c:otherwise>
									<img src="https://via.placeholder.com/120x120?text=User" class="profile-image">
								</c:otherwise>
							</c:choose>
							
                          </div>
                          <div class="profile-contents">
                            <div class="profile-nickname">
                              <a href="${root}/member/page?memberNo=${loginNo}">${loginNick}</a>
                            </div>
                            <div class="profile-grade">
                            <div style="font-size: 15px">${loginGrade}</div>
                            </div>
                          </div>
                        </div>
                        <ul>
                          <li>
                            <a href="${root}/member/page?memberNo=${loginNo}">마이페이지</a>
                          </li>
                          <li>
                            <a href="${root}/member/orders"> 주문정보 </a>
                          </li>
                          <li>
                            <a href="${root}/help/"> 고객센터 </a>
                          </li>
                          <li>
                            <a href="${root}/member/logout"> 로그아웃 </a>
                          </li>
                          <li class="ggumim-infomation">
                            <p class="num">1500-0000</p>
                            <p class="open">OPEN AM 10:00 - PM 5:00</p>
                            <p class="off">SAT, SUN, HOLIDAY OFF.</p>
                          </li>
                        </ul>
                      </div>
                    </div>
                   </c:when>
                   <c:otherwise>
                   <!-- 비회원일 때 -->
                   <a href="${root}/member/login">
                    <div class="item sm-bar">
                      <div class="login-btn">로그인/가입</div>
                    </div>
                  </a>
                    </c:otherwise>
                    </c:choose>
                    <a href="${root}/help/">
                      <div class="item sm-bar nonmember-order">고객센터</div>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
       <div class='toastFollow' style='display:none'></div>


      
    </header>

    <section>