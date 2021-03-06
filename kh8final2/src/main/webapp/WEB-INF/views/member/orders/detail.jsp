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
	var pageMember = "${pageMember}";
	
	
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

<div class="layout-container" >

	<div class="menu-container">
	<c:if test="${memberDto.memberNo == loginNo}">
		<nav class="menu-nav">
			<ul style="transform: translateX(0px);">
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/page?memberNo=${loginNo}">프로필</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/orders" class="active">나의 쇼핑</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/profileEdit" >설정</a></li>
			</ul>
		</nav>
	</c:if>
		<nav class="menu-nav">
		<ul style="transform: translateX(0px);">
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/orders" class="active">주문 내역</a></li>
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/delivery">배송지 관리</a></li>
		</ul>
	</nav>
	</div>

	<div class="container-zipggu" >
		<div class="accordion-body">
		<c:forEach var="order" items="${orderDetailList}" varStatus="status">
	         <div class="row mt-2">
	
	             <!--상품 썸네일-->
	             <div class="col-auto">
	               <a href="${pageContext.request.contextPath}/store/detail/${order.itemNo}">  
	                 <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${order.itemNo}" class="d-block w-100" style="width:150px;height:150px" alt="...">
	               </a>
	             </div>
	
	             <!--상품 옵션 및 수량-->
	             <div class="item-detail col-auto me-auto">
	
	                 <!-- 상품명 -->
	                 <div class="row m-1">
	                     <div class="col-auto me-auto">
	                         <span style="font-size: 15px;"><strong>${order.orderItemName}  ${order.orderQuantity}개</strong></span>
	                     </div>
	                 </div>
	
	                 <!--옵션-->
	                 <div class="row m-1">
	                     <div class="col-auto me-auto">
	                         <span style="font-size: 12px; color: dimgray;">
	                         	<c:forEach var="option" items="${order.optionList}" varStatus="status">
	                         	<strong>${status.index != 0 ? "/" : ""} ${option.itemOptionGroup}: ${option.itemOptionDetail} </strong>
	                         	</c:forEach>
	                         </span>
	                     </div>
	                 </div>
	
	                 <!--상품금액-->
	                 <div class="row m-1">
	                     <div class="col-auto me-auto">
	                         <strong><span style="font-size: 15px;">${order.getTotalPriceToString()}</span>원</strong>
	                     </div>
	                 </div>
	                 
	              <c:choose> 
	                 <c:when test="${order.orderDetailStatus != '취소'}">
						<a class="btn btn-primary" href="${pageContext.request.contextPath}/payment/cancel_part?orderNo=${order.orderNo}&orderDetailNo=${order.orderDetailNo}&type=member">해당항목 취소</a>
					</c:when>
					<c:otherwise>
						<span class="btn btn-secondary">취소됨</span>
					</c:otherwise>
				  </c:choose>	
	             </div>
	         </div>
	         </c:forEach>
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