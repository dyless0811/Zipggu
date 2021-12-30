<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
a:link {
	color: #424242;
	text-decoration: none;
}

a:visited {
	color: #424242;
	text-decoration: none;
}

li {
	margin: 0 10px;
}

.container-1200 {
    width: 1200px;
}


</style>


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

	<div class="container-1200 container-center">

		<div class="float-container">


			<div class="layoutProfile">
				<div class="profileBox">

					<div class="profileHeader">
						<!-- 회원 프로필 이미지 -->
						<div class="profileImageContainer"> 
							<c:choose>
								<c:when test="${memberProfileDto == null}">
									<img src="https://via.placeholder.com/120x120?text=User"
										class="profileImage">
								</c:when>
								<c:otherwise>
									<img
										src="profile?memberNo=${memberProfileDto.memberNo}" width="100%" height="100%" class="profileImage">
								</c:otherwise>
							</c:choose>
						</div>


						

						<div class="profileContent">
							<div class="nickname"> ${memberDto.memberNickname}</div>

							<div class="statsContainer">

								<dl class="statsAttributeList">
									<dd class="statsAttributeLabel">팔로워</dd>
									<dt class="statsAttributeValue">0</dt>
									<dd class="statsAttributeLabel">팔로잉</dd>
									<dt class="statsAttributeValue">6</dt>
								</dl>
								<a href="profileEdit" class="a-border">설정</a>

							</div>
						</div>

					</div>

				</div>




			</div>

			<div class="main-right">

				<div class="div-right">
				<span>자리만잡아두기1</span>
				<div class="itemBox">

				</div>
				<span>자리만잡아두기2</span>
				<div class="itemBox">

				</div>
				
				</div>
			</div>


		</div>

	</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>