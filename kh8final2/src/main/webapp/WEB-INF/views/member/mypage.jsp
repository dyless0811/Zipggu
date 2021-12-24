<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 출력 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.layout-container {
    position: relative;
    padding: 0px 0px 40px;
}

.menu-container {
    position: relative;
   	width: 100%;
    margin: 0 auto;
}

.menu-nav {
    border-bottom: 1px solid #ededed;
    width: 100%;
    overflow: hidden;
    overflow: visible;
    font-size: 18px;
}

.menu-nav>ul {
    text-align: center;
    white-space: nowrap;
}

.page-item {
    display: inline-block;
}

 
.page-item>a.active, .page-item>a:not(.active):hover {
    color: #35c5f0;
}
.page-item>a {
    display: block;
    padding: 0 10px;
    font-weight: 700;
    position: relative;
    height: 60px;
    line-height: 60px;
    transition: color .15s ease;
    text-decoration: none;
}

a:link { 
 color: #424242;
 text-decoration: none;
}

a:visited {
 color: #424242;
 text-decoration: none;
}

li{
  margin: 0 10px;
}

.nickname {
    margin: 0px 0px 3px;
    font-weight: bold;
    margin: 0px 0px 10px;
    font-size: 26px;
    line-height: 1.2;
    color: rgb(41, 41, 41);
    overflow-wrap: break-word;
    word-break: break-all;
    text-align: center;
}


.layoutProfile {
    width: 269px;
}

.profileBox {
    position: relative;
    padding: 30px 25px 18px;
    border-radius: 4px;
    border: 1px solid rgb(218, 220, 224);
    box-shadow: rgb(63 71 77 / 6%) 0px 2px 4px 0px;
}
    
.profileHeader {
    position: relative;
    min-height: 84px;
    box-sizing: border-box;
    padding-left: 104px;
    margin: 0 0 20px;
    padding: 0px;
}

.profileImageContainer {
    top: 0px;
    left: 0px;
    width: 120px;
    height: 120px;
    margin: 0px auto 24px;	
    border-radius: 100%;
    background-color: rgb(237, 237, 237);
    overflow: hidden;
    position: relative;
    margin: 0 auto 24px;
}

.profileImage {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 100%;
    transform: translate(-50%, -50%);
}

.profileContent {
    text-align: center;
}

.statsContainer {
    text-align: center;
}

.statsAttributeList {
    margin: 0px 0px 7px;
    display: block;
    font-size: 13px;
    font-weight: 400;
    line-height: 19px;
    color: rgb(130, 140, 148);
    margin: 0px 0px 13px;
}

.statsAttributeLabel {
    display: inline-block;
    margin-right: 5px;
}

.statsAttributeValue {
    display: inline-block;
    margin-right: 5px;
    font-weight: bold;
    color: rgb(82, 91, 97);
}

.statsAttributeValue:not(:last-child)::after {
    content: "";
    display: inline-block;
    width: 1px;
    height: 9px;
    margin-left: 10px;
    background-color: rgb(218, 220, 224);
}

.a-border {
	line-height: 19px;
    padding-left: 16px;
    padding-right: 16px;
    padding-top: 5px;
    padding-bottom: 5px;
    margin-right: 6px;
    font-size: 12px;
    display: inline-block;
    box-sizing: border-box;
    border: 1px solid transparent;
    background: none;
    font-weight: 700;
    text-align: center;
    transition: color .1s,background-color .1s,border-color .1s;
    border-radius: 4px;
    cursor: pointer;
    background-color: #fff;
    border-color: #dbdbdb;
}



	.float-container > .float-item-left:nth-child(1) {
		width:25%;	
		padding:0.5rem;
	}
	.float-container > .float-item-left:nth-child(2) {
		width:75%;
		padding:0.5rem;
	}
	
	.link-btn {
		width:100%;
	}
</style>

<!-- 이 페이지를 2단으로 구현 -->

<div class="layout-container">

	<div class="menu-container">
	        <nav class="menu-nav">
            <ul style="transform: translateX(0px);">
		            	<li class="page-item"><a href="#">프로필</a></li>
	            		<li class="page-item"><a href="#">나의 쇼핑</a></li>
		            	<li class="page-item"><a href="#">나의 리뷰</a></li>
		            	<li class="page-item"><a href="#">설정</a></li>
            </ul>
        </nav>
	</div>

<div class="container-900 container-center">

	<div class="row float-container">

		<!-- 1단 -->
		
		<div class="layoutProfile">
		<div class="profileBox">
		
		<div class="profileHeader">
			<!-- 회원 프로필 이미지 -->
			<div class="profileImageContainer">
				<c:choose>
					<c:when test="${memberProfileDto == null}">
					<img src="https://via.placeholder.com/120x120?text=User" class="profileImage">
					</c:when>
					<c:otherwise>
					<img src="profile?memberProfileNo=${memberProfileDto.memberProfileNo}" width="100%" class="profileImage">
					</c:otherwise>
				</c:choose>
			</div>
			
			
			<div class="profileContent">
			<div class="nickname">${memberDto.memberNickname}</div>
			
			<div class="statsContainer">
			
				<dl class="statsAttributeList">
					<dd class="statsAttributeLabel">팔로워</dd>
					<dt class="statsAttributeValue">0</dt>
					<dd class="statsAttributeLabel">팔로잉</dd>
					<dt class="statsAttributeValue">6</dt>
				</dl>
				<a href="edit" class="a-border">설정</a>
			</div>
			</div>
			
		</div>


			


		</div>
		</div>




<!-- 		<!-- 2단 -->
<!-- 		<div class=""> -->

<!-- 			<!-- 회원 정보 출력 -->
<!-- 			<div class="row"> -->
<!-- 				<h2>회원 상세 정보</h2> -->
<!-- 			</div> -->
<!-- 			<div class="row"> -->
<!-- 				<table class="table table-stripe"> -->
<!-- 					<tbody> -->

<!-- 						<tr> -->
<!-- 							<th>닉네임</th> -->
<%-- 							<td>${memberDto.memberNickname}</td> --%>
<!-- 						</tr> -->

<!-- 						<tr> -->
<!-- 							<th>이메일</th> -->
<%-- 							<td>${memberDto.memberEmail}</td> --%>
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<th>가입일시</th> -->
<%-- 							<td>${memberDto.memberJoin}</td> --%>
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<th>포인트</th> -->
<%-- 							<td>${memberDto.memberPoint}</td> --%>
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<th>등급</th> -->
<%-- 							<td>${memberDto.memberGrade}</td> --%>
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->

			<!-- 포인트 내역 출력 -->
<!-- 			<div class="row"> -->
<!-- 				<h2>포인트 상세 내역</h2> -->
<!-- 			</div> -->

<!-- 			<div class="row"> -->
<!-- 				<table class="table table-border table-hover"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th>일시</th> -->
<!-- 							<th>금액</th> -->
<!-- 							<th>메모</th> -->
<!-- 							<th>cancel</th> -->
<!-- 							<th>취소</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<%-- 						<c:forEach var="historyDto" items="${historyList}"> --%>
<!-- 						<tr> -->
<%-- 							<td>${historyDto.historyTime}</td> --%>
<%-- 							<td class="right">${historyDto.historyAmount}</td> --%>
<%-- 							<td class="left">${historyDto.historyMemo}</td> --%>
<%-- 							<td>${historyDto.cancel}</td> --%>
<!-- 							<td> -->
<%-- 								<c:if test="${historyDto.available()}"> --%>
<%-- 								<a href="${pageContext.request.contextPath}/point/cancel?historyNo=${historyDto.historyNo}">취소</a> --%>
<%-- 								</c:if> --%>
<!-- 							</td> -->
<!-- 						</tr> -->
<%-- 						</c:forEach> --%>
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->

			<!-- 내가 작성한 게시글 출력 -->
<!-- 			<div class="row"> -->
<!-- 				<h2>내가 작성한 게시글</h2> -->
<!-- 			</div> -->
<!-- 			<div class="row"> -->
<!-- 				<table class="table table-border table-hover"> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th>번호</th> -->
<!-- 							<th width="50%">제목</th> -->
<!-- 							<th>작성일</th> -->
<!-- 							<th>조회수</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<%-- 						<c:forEach var="boardDto" items="${myBoardList}"> --%>
<!-- 						<tr> -->
<%-- 							<td>${boardDto.boardNo}</td> --%>
<!-- 							<td class="left"> -->

<%-- 								
<%-- 									게시글의 제목을 출력하기 전에 차수에 따라 띄어쓰기를 진행한다 --%>
<%-- 									띄어쓰기는 HTML 특수문자인 &nbsp; 을 사용한다. --%>
<%-- 									답변글에는 reply icon을 추가로 출력한다.  --%>
<%-- 								--%>
<%-- 								<c:if test="${boardDto.hasDepth()}"> --%>
<%-- 									<c:forEach var="i" begin="1" end="${boardDto.boardDepth}" step="1"> --%>
<!-- 										&nbsp;&nbsp;&nbsp;&nbsp; -->
<%-- 									</c:forEach> --%>

<%-- 									<img src="${pageContext.request.contextPath}/resources/image/reply.png" width="15" height="15"> --%>
<%-- 								</c:if> --%>

<%-- 								<a href="${pageContext.request.contextPath}/board/detail?boardNo=${boardDto.boardNo}"> --%>
<%-- 									${boardDto.boardTitle} --%>
<!-- 								</a> -->

<!-- 								제목 뒤에 댓글 개수를 출력한다 -->
<%-- 								<c:if test="${boardDto.isReplyExist()}"> --%>
<%-- 									[${boardDto.boardReply}] --%>
<%-- 								</c:if> --%>
<!-- 							</td> -->
<%-- 							<td>${boardDto.boardTime}</td> --%>
<%-- 							<td>${boardDto.boardRead}</td> --%>
<!-- 						</tr> -->
<%-- 						</c:forEach> --%>
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
		</div>
	</div>
</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>