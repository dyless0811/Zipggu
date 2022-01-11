<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageMember" value="${memberDto.memberNo}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(document).ready(function() {

		$(".profileFollowBtn").click(function(e) {
			var memberNoValue = $(this).data("member-no");
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



<style>

a:link {
	color: #424242;
	text-decoration: none;
}

a:visited {
	color: #424242;
	text-decoration: none;
}

.container-1200 {
    width: 1200px;
}

.profileUnfollowBtn {
	margin: 0px 0px 7px;
	display: block;
	font-size: 13px;
	font-weight: 400;
	line-height: 19px;
	color: rgb(130, 140, 148);
	user-select: none;
	display: inline-block;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	border: 1px solid transparent;
	background: none;
	font-weight: 700;
	text-decoration: none;
	text-align: center;
	transition: color .1s, background-color .1s, border-color .1s;
	border-radius: 4px;
	cursor: pointer;
	width: 140px;
	padding: 9px 10px;
	font-size: 15px;
	background-color: #fff;
	border-color: #dbdbdb;
	color: #757575;
}

.profile2FollowBtn {
	margin: 0px 0px 7px;
	display: block;
	font-size: 13px;
	font-weight: 400;
	line-height: 19px;
	color: rgb(130, 140, 148);
	user-select: none;
	display: inline-block;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	border: 1px solid transparent;
	background: none;
	font-weight: 700;
	text-decoration: none;
	text-align: center;
	transition: color .1s, background-color .1s, border-color .1s;
	border-radius: 4px;
	cursor: pointer;
	width: 140px;
	padding: 9px 10px;
	font-size: 15px;
	border-color: #09addb;
	background-color: #09addb;
	color: #fff;
}


.profileFollowBtn {
	margin: 0px 0px 7px;
	display: block;
	font-size: 13px;
	font-weight: 400;
	line-height: 19px;
	color: rgb(130, 140, 148);
	user-select: none;
	display: inline-block;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	border: 1px solid transparent;
	background: none;
	font-weight: 700;
	text-decoration: none;
	text-align: center;
	transition: color .1s, background-color .1s, border-color .1s;
	border-radius: 4px;
	cursor: pointer;
	width: 140px;
	padding: 9px 10px;
	font-size: 15px;
	border-color: #09addb;
	background-color: #09addb;
	color: #fff;
}

.introduceContainer {
    margin: 24px 0px;
    text-align: center;
    color: rgb(66, 66, 66);
    font-size: 15px;
    line-height: 1.4;
    font-weight: 400;
    word-break: break-word;
    text-align: left;
}
.figure-img{
	display: inline-block;
	width:50px;
	height:50px;
	overflow: hidden;
    object-fit: cover;
    border-radius: 5px;
}
.follower-img{
	border-radius:50%;
	width:8%;
	height:8%;
}
.d-flex{
	width: 700px;
	border:1px solid rgb(218, 220, 224);
}

.page-navigation__item>a.active, .page-navigation__item>a:not(.active):hover {
    color: #35c5f0;
}
.page-navigation__item>a {
    display: inline-block;
    padding: 0 10px;
    font-weight: 700;
    position: relative;
    height: 60px;
    line-height: 60px;
    transition: color .15s ease;
    font-size: 15px;
}

.page-navigation__item {
    display: inline-block;
}

ul{
margin-bottom: 0px;
}

</style>
<script>
	
$(function(){
	var page = 1;
	var size = 4;
	var pageMember = ${pageMember};
	
	
	console.log("로그인No = ", pageMember);
			
	var result = $("#result-pageMember")
	console.log("팔로워 목록?????????????????");
	$(".pageMember-more-btn").click(function(){
		loadmyList(page, size, pageMember);
		page++;
	});
			
	
	$(".pageMember-more-btn").click();
	
});
	function loadmyList(page, size, pageMember){
		
		
		console.log("로그인No ============== ", pageMember);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/sns/data/mylist",
			type : "get",
			data : {
				page : page,
				size : size,
				pageMember : pageMember
			},
			dataType : "json",
			success:function(resp){
				
				console.log("팔로워 목록 성공", resp);
				
				if(resp.length < size){
					$(".pageMember-more-btn").remove();
				}
				
				console.log(resp);
				
				if(resp.length > 0){
					for(var i=0; i<resp.length; i++){
						var result = $("#pageMember")
						var clonedTemplate = $(".pageMember-template").clone();
						var templateContent = $(clonedTemplate.html());
						templateContent.find("#b").attr("href", "${pageContext.request.contextPath}/sns/detail?snsNo="+resp[i].snsNo);
						templateContent.find(".figure-img").attr("src", "${pageContext.request.contextPath}/sns/thumnail?snsNo="+resp[i].snsNo);
						//templateContent.find(".profile-image").attr("src", "${pageContext.request.contextPath}/member/profile?memberNo="+resp[i].memberNo);
						templateContent.find(".member-page").attr("href", "${pageContext.request.contextPath}/member/page?memberNo=" + resp[i].memberNo);
						clonedTemplate.html(templateContent.prop('outerHTML'));
						result.append(clonedTemplate.html());
					}
				}
				
				else{
					var result = $("#pageMember")
					result.append("<div class='m-5'><h3>게시글이 없습니다</h3>");
					
					
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
</script>


<div class="layout-container">

	<div class="menu-container">
	<c:if test="${memberDto.memberNo == loginNo}">
		<nav class="menu-nav">
			<ul style="transform: translateX(0px);">
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/page?memberNo=${loginNo}" class="active">프로필</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/orders">나의 쇼핑</a></li>
				<li class="page-item"><a href="#">나의 리뷰</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/profileEdit" >설정</a></li>
			</ul>
		</nav>
	</c:if>
		<nav class="menu-nav">
		<ul style="transform: translateX(0px);">
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/page?memberNo=${loginNo}" class="active">모두보기</a></li>
			<li class="page-navigation__item"><a href="#">사진</a></li>
		</ul>
	</nav>
	</div>

	<div class="container-1000 container-center">

		<div class="float-container">


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
									<img src="profile?memberNo=${memberProfileDto.memberNo}" width="100%" height="100%" class="profileImage">
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
								
								
								
								
					<c:choose>
						<c:when test="${loginEmail == null}">
								<c:if test="${memberDto.memberNo != loginNo}">
									<div style="display: inline-block">
										<button type="button" class="profile2FollowBtn" onClick="location.href='${pageContext.request.contextPath}/member/login'">팔로우</button>
									</div>
								</c:if>
						</c:when>	
															
						<c:otherwise>
							<c:if test="${memberDto.memberNo != loginNo}">
									<div style="display: inline-block">
										<c:choose>
											<c:when test="${followCheck != 0}">
												<button class="profileUnfollowBtn" id="profileUnfollowBtn_${memberDto.memberNo}" data-member-no="${memberDto.memberNo}">
													<svg width="16" height="16" viewBox="0 0 16 16"
														preserveAspectRatio="xMidYMid meet"
														class="css-1wvdp85-StatsFollowIcon e1iro1t90">
													<path fill="#BDBDBD"
															d="M6.185 10.247L13.264 2.95 14.699 4.343 6.256 13.046 1.3 8.432 2.663 6.968z">
													</path>
												</svg>
													팔로잉
												</button>
												<button class="profileFollowBtn"  id="profileFollowBtn_${memberDto.memberNo}" data-member-no="${memberDto.memberNo}" style="display: none">
													팔로우</button>
											</c:when>
											<c:otherwise>
												<button class="profileUnfollowBtn" style="display: none"  id="profileUnfollowBtn_${memberDto.memberNo}" data-member-no="${memberDto.memberNo}">
													<svg width="16" height="16" viewBox="0 0 16 16"
														preserveAspectRatio="xMidYMid meet"
														class="css-1wvdp85-StatsFollowIcon e1iro1t90">
													<path fill="#BDBDBD"
															d="M6.185 10.247L13.264 2.95 14.699 4.343 6.256 13.046 1.3 8.432 2.663 6.968z">
													</path>
												</svg>
													팔로잉
												</button>
												<button class="profileFollowBtn"  id="profileFollowBtn_${memberDto.memberNo}" data-member-no="${memberDto.memberNo}">팔로우</button>
											</c:otherwise>
										</c:choose>
									</div>
								</c:if>

						</c:otherwise>
					</c:choose>






								<c:if test="${memberDto.memberNo == loginNo}">
									<div>
										<a href="${pageContext.request.contextPath}/member/profileEdit" class="a-border">설정</a>
									</div>
								</c:if>
							</div>
						</div>

					</div>

					<div class="introduceContainer">
							<p style="text-align: center;">${memberDto.memberIntroduce}</p>
					</div>

				</div>




			</div>

			<div class="main-right">

				<div class="div-right">
				
				<span>내가 쓴 게시물</span>
				<div class="d-flex flex-wrap">

		        		<div id="pageMember"></div>
		        		<button type="button" class="btn btn-primary pageMember-more-btn">더보기</button>
			   
				</div>
				<span>팔로워 게시물</span>
				<div class="itemBox">

				</div>
				
				</div>
			</div>


		</div>

	</div>

</div>


<template class="pageMember-template">
	
			
           <figure class="figure m-2">
            	<a href="detail?snsNo=${snsDto.	snsNo }" id="b">
                	<img src="http://placeimg.com/150/150/animals" class="figure-img img-fluid rounded border border-3" alt="...">
                	<figcaption class="figure-caption text-center"><span class="member-nick"></span></figcaption>
                </a>
            </figure>


        
</template>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>