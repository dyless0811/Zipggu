<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.getSession().removeAttribute("loginId"); %>
<% request.getSession().setAttribute("loginId", "master"); %>
<% request.getSession().setAttribute("loginGrade", "관리자"); %>

<c:set var="login" value="${loginId != null}"></c:set>
<c:set var="admin" value="${loginGrade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>    

<!DOCTYPE html>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>zipggu</title>
    <link rel="stylesheet" type="text/css" href="${root}/resources/css/zipggu.css">
</head>
<body>
    <header>
      <div class="navEmptySpace">
        <div class="head head-fixed">
          <div class="head-bar head-bar-white">
            <div class="navigation">
              <div class="nav-new">
                <div class="logo">
                  <a href="/">
                    <div class="logo-img"></div>
                  </a>
                </div>
                <div class="menu">
                  <div class="category-menu">
                    <div class="title">
                      <div class="icon"></div>
                      <div class="text">카테고리</div>
                    </div>
                    <div class="menu-deps"></div>
                  </div>
                  <a href="/furniture">
                    <div class="item">스토어</div>
                  </a>
                  <a href="/star">
                    <div class="item">컨텐츠</div>
                  </a>
                  <a href="/story">
                    <div class="item"><a href="sns/list">커뮤니티</a></div>
                  </a>
                  <div class="right">
                    <!-- <a href="/search"> -->
                    <div class="item sm-bar">
                      <div class="search-input-wrap">
                        <div class="input-round">
                          <div class="text">
                            <!-- 내 스타일 매거진, 상품, 사진 검색 -->
                            <form action="#" method="get">
                              <input
                                class="search-box"
                                type="text"
                                name="q"
                                placeholder="내 스타일 매거진, 상품, 사진 검색"
                                autocomplete="off"
                              />
                            </form>
                          </div>
                          <div class="search-icon"></div>
                        </div>
                      </div>
                    </div>
                    <!-- </a> -->
                    <a href="/commerce/cart">
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
                        <img
                          class="profile-image"
                          src="//cdn.ggumim.co.kr/cache/member/profile/180/20211214183232nBczBjRmtf.jpg"
                        />
                      </div>
                      <div class="nickname">${loginId}</div>
                      <div
                        class="subnavigation subnavigation-menu"
                        style="right: 10px; top: 80px; z-index: 999"
                      >
                        <div class="member-profile-section">
                          <div class="profile-image">
                            <img
                              src="//cdn.ggumim.co.kr/cache/member/profile/180/20211214183232nBczBjRmtf.jpg"
                              alt="멤버 프로필 이미지"
                            />
                          </div>
                          <div class="profile-contents">
                            <div class="profile-nickname">
                              <a href="/member/setting/3194863"> ${loginId} </a>
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
                              <div
                                class="membership-detail"
                                onclick="location.href='/member/membership'"
                              >
                                자세히 보기
                              </div>
                            </div>
                          </div>
                        </div>
                        <ul>
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
                            <a href="/logout/"> 로그아웃 </a>
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
                   <a href="/login">
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
                    <a href="/help/">
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
</body>
</html>