<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>
  
<script>
	$(function() {

		$(".followBtn").click(function(e) {
				
			var memberNoValue = $(this).data("member-no");
			
				$.ajax({
							url : "${pageContext.request.contextPath}/follow/follow",
							type : "POST",
							data : {
								memberNo : memberNoValue
							},
							dataType :"text",
							success : function(resp) {
									console.log("팔로우성공", resp);

							},
							error:function(e){
								console.log("실패", e);
							}
						});
					})

				$(".unfollowBtn").click(function(e) {
					
					var memberNoValue = $(this).data("member-no");
					
				$.ajax({
							url : "${pageContext.request.contextPath}/follow/unfollow",
							type : "POST",
							data : {
								memberNo : memberNoValue
							},
							dataType :"text",
							success : function(resp) {
									console.log("언팔로우성공", resp);

							},
							error:function(e){
								console.log("실패", e);
							}
						});
				});

	});
</script>

<style>
.mContainer {
	width: 100%;
	max-width: 1000px;
	margin: 0px auto;
	box-sizing: border-box;
}

.mRow {
	display: flex;
	flex-wrap: wrap;
	box-sizing: border-box;
}

.layoutProfile {
	width: 25%;
}

.mCol {
	width: 8%;
}

.rCol {
	width: 65%;
}

.rDiv {
	margin: 40px auto 60px;
	width: 100%;
	max-width: 400px;
}

.itemContainer {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 0px;
	color: rgb(41, 41, 41);
}

.hTitle {
	margin: 0px 0px 30px;
	font-size: 18px;
	line-height: 24px;
	font-weight: bold;
	color: rgb(47, 52, 56);
}

.divItemContainer {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 0;
	color: #292929;
}

.itemLinkPlaceholder {
	flex: 0 1 auto;
	min-width: 0;
	display: flex;
	align-items: center;
	transition: .1s opacity;
}

.itemImageContainer {
	position: relative;
	width: 40px;
	height: 40px;
	border-radius: 100%;
	background-color: #f5f5f5;
	margin-right: 10px;
	overflow: hidden;
}

.profileItemImage {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 100%;
	transform: translate(-50%, -50%);
}

.itemNickname {
	color: #2f3438;
	line-height: 20px;
	font-size: 14px;
	font-weight: bold;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.itemIntroduce {
	margin: 1px 0 0;
	color: #828c94;
	line-height: 20px;
	font-size: 12px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

button {
	padding: 5px 7px 6px;
	font-size: 15px;
	line-height: 19px;
	background-color: #fff;
	border-color: #dbdbdb;
	color: #757575;
	user-select: none;
	padding: 0;
	background: none;
	transition: color .1s, background-color .1s, border-color .1s;
	border-radius: 4px;
	cursor: pointer;
}

.itemFollow {
	margin-left: 10px;
	padding-left: 8px;
	padding-right: 8px;
	font-size: 14px;
	white-space: nowrap;
	font-weight: normal;
}

.SitemContent {
	flex: 1 0 0px;
	min-width: 0;
}

.followBtn {
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff;
    padding: 5px 7px;
}

.unfollowBtn {
    background-color: #fff;
    border-color: #dbdbdb;
    color: #757575;
    padding: 5px 7px;
}

</style>

<div class="layout-container">

	<div class="menu-container">
	<c:if test="${memberDto.memberNo == loginNo}">
		<nav class="menu-nav">
			<ul style="transform: translateX(0px);">
				<li class="page-item"><a href="#">프로필</a></li>
				<li class="page-item"><a href="#">나의 쇼핑</a></li>
				<li class="page-item"><a href="#">나의 리뷰</a></li>
				<li class="page-item"><a href="#">설정</a></li>
			</ul>
		</nav>
	</c:if>
		<nav class="menu-nav">
			<ul style="transform: translateX(0px);">
				<li class="page-item"><a href="#"></a></li>
				<li class="page-item"><a href="#"></a></li>
				<li class="page-item"><a href="#"></a></li>
				<li class="page-item"><a href="#"></a></li>
			</ul>
		</nav>
	</div>


	<div class="mContainer">
		<div class="mRow">
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
									<img src="${pageContext.request.contextPath}/member/profile?memberNo=${memberProfileDto.memberNo}" width="100%"
										height="100%" class="profileImage">
								</c:otherwise>
							</c:choose>
						</div>


						<div class="profileContent">
							<div class="nickname"> ${memberDto.memberNickname}</div>

							<div class="statsContainer">

								<dl class="statsAttributeList">
									<dd class="statsAttributeLabel">팔로워</dd>
								<a href="${pageContext.request.contextPath}/follow/followerList?memberNo=${memberDto.memberNo}">
									<dt class="statsAttributeValue">${followingCount}</dt>
								</a>		
									<dd class="statsAttributeLabel">팔로잉</dd>
								<a href="${pageContext.request.contextPath}/follow/followingList?memberNo=${memberDto.memberNo}">
									<dt class="statsAttributeValue">${followerCount}</dt>
								</a>		
								</dl>
								
								<c:if test="${memberDto.memberNo == loginNo}">
								<div><a href="${pageContext.request.contextPath}/member/profileEdit" class="a-border">설정</a></div>
								</c:if>
							</div>
						</div>

					</div>

				</div>

			</div>
			<div class="mCol"></div>
			<div class="rCol">
				<div class="rDiv">
					<h1 class="hTitle">팔로잉</h1>
					
					<c:forEach var="followVO" items="${followingF4f}">
						<div>
			
							<div class="divItemContainer">
								<a href="${pageContext.request.contextPath}/member/page?memberNo=${followVO.followingUser}" class="itemLinkPlaceholder">
									<div class="itemImageContainer">
										<c:choose>
											<c:when test="${followVO.memberProfileNo == 0}">
												<img src="https://via.placeholder.com/120x120?text=User"
													class="profileImage">
											</c:when>
											<c:otherwise>
												<img src="${pageContext.request.contextPath}/member/profile?memberNo=${followVO.followingUser}"
													width="100%" height="100%" class="profileImage">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="SitemContent">
										<div class="itemNickname">${followVO.memberNickname}</div>
										<div class="itemIntroduce">${followVO.memberIntroduce}</div>
									</div>
								</a>
								<div>
					
									<c:choose>
											<c:when test="${followVO.f4f == N}"> 
												<button class="followBtn" id="follow-btn" data-member-no="${followVO.followingUser}">팔로우</button>
											</c:when>
											<c:otherwise>
												<button class="unfollowBtn" id="unfollow-btn"  data-member-no="${followVO.followingUser}">팔로잉</button>
											</c:otherwise>
									</c:choose>
									
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>