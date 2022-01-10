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
</head>
<body>

<div style="height: 100%;">

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
                   <a href="${root }/member/memberList">
                    <div class="item">회원목록</div>
                  </a>
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
                    <a href="${root }/cart/list">
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
                              <div>등급</div>
                              <div>회원등급</div>
                            </div>
                            <div class="profile-point">
                              <div>포인트</div>
                              <div>회원포인트 원</div>
                            </div>
                          </div>
                          <div class="membership-tooltip-wrap">
                            <div class="membership-tooltip">
                              <div class="membership-title">
                                등급별 포인트 적립 안내
                              </div>
                              <div class="membership-family">
                                FAMILY 등급 : 포인트 1% 적립
                              </div>
                              <div class="membership-vip">
                                VIP 등급 : 포인트 3% 적립
                              </div>
                              <div class="membership-detail" onclick="location.href='/member/membership'">
                                자세히 보기
                              </div>
                            </div>
                          </div>
                        </div>
                        <ul>
                          <li>
                            <a href="${root}/member/page?memberNo=${loginNo}">마이페이지</a>
                          </li>                        
                          <li>
                            <a href="/member/noti/3194863"> 알림 </a>
                            <div class="notice-count">0</div>
                          </li>
                          <li>
                            <a href="/member/view/3194863"> 보관함 </a>
                            <div class="notice-count hide">0</div>
                          </li>
                          <li>
                            <a href="/member/my_order/3194863"> 주문정보 </a>
                            <div class="notice-count">0</div>
                          </li>
                          <li>
                            <a href="/help/"> 고객센터 </a>
                          </li>
                          <li>
                            <a href="${root}/member/logout"> 로그아웃 </a>
                          </li>
                          <li class="ggumim-infomation">
                            <p class="num">1522-7966</p>
                            <p class="kakao">카카오플러스 친추 '집꾸미기'</p>
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
                  <a href="/member/order_nonmember/">
                    <div class="item sm-bar nonmember-order">
                      비회원 주문조회
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
    </header>

    <section>
