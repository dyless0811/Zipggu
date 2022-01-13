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
<script>
	var page = 1;
	var size = 10;
	var order = "order_no";
	var sort = "desc";
	var preOrder = "";
	var preSort = "asc";
	$(function(){		
		
		
		$(".more-btn").click(function(){
			loadList(page, size);
			page++;
		});
		$(".more-btn").click();
		
		$("#search-btn").click(function(){
			$("tbody").empty();
			page = 1;
			loadList(page, size);
		});

		$("#reset-btn").click(function(){
			$("tbody").empty();
			resetForm();
			page = 1;
			loadList(page, size);
		});
		
		$(document).on("click",".item-row", function(){
			var orderNo = $(this).find(".order-no").text();
			location.href="${pageContext.request.contextPath}/member/order/detail/"+orderNo
		})
		
		$(document).on("click",".menu-row th a",function(e){
			$("tbody").empty();
			e.preventDefault();
			order = $(this).parent().data("order");
			sort = setSort(order);
			preOrder = order;
			page = 1;
			loadList(page, size);
		});
		
		function loadList(page, size) {
			disableForm();
			var formData = $("form").serializeArray();
			formData.push({name: 'page', value: page});
			formData.push({name: 'size', value: size});
			formData.push({name: 'order', value: order});
			formData.push({name: 'sort', value: sort});
			$.ajax({
				url: "${pageContext.request.contextPath}/member/order/list",
				type: "post",
				data: formData,
				success: function(resp){
					console.log("성공",resp);
					
					if(resp.length < size){
						$(".more-btn").hide();
					}
					
					for (var orderListVO of resp) {
						var result = $("<tr class='item-row' style='cursor:pointer'>");
						result.append($("<td>").addClass("order-no").text(orderListVO.orderNo));
						result.append($("<td>").text(orderListVO.orderName));
						result.append($("<td>").text(orderListVO.totalAmount));
						result.append($("<td>").text(orderListVO.memberNickname));
						var dateTime = new Date(Number(orderListVO.orderDate));
						result.append($("<td>").text(dateTime.toLocaleString()));
						result.append($("<td>").text(orderListVO.orderStatus));
						$("tbody").append(result);
					}
				},
				error: function(e){
					console.log("실패",e);
				}
			});
			activeForm();
		}
		function setOrder(order) {
			preOrder = order;
			return order;
		}
		function setSort(order) {
			if(preOrder == order) {
				if(preSort == "asc") {
					preSort = "desc";
					return "desc";
				} else {
					preSort = "asc";
					return "asc";
				}
			}
			preSort = "asc";
			return "asc";
		}
		
		function resetForm() {
			$("input").each(function(){
				$(this).val("");
			});
		}
		function disableForm() {
			$("input").each(function(){
				if($(this).val() == "") {
					$(this).attr("disabled","disabled");
				}
			});
		}
		function activeForm() {
			$("input").each(function(){
				$(this).removeAttr("disabled");
			});
		}
	});
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
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/page?memberNo=${loginNo}" class="active">모두보기</a></li>
		</ul>
	</nav>
	</div>

	<div class="container-zipggu" >

				<h2 class="mb-5">주문 내역</h2>

					<form action="" method="get">
					  <button id="search-btn" type="button" class="btn btn-primary">검색</button>
					  <button id="reset-btn" type="button" class="btn btn-primary">초기화</button>
					  <table class="table table-hover">
					  	<thead>
					  	  <tr class="menu-row">
					  		<th data-order="order_no"><a href="">주문번호</a></th>
					  		<th data-order="order_name"><a href="">주문명</a></th>
					  		<th data-order="total_amount"><a href="">결제금액</a></th>
					  		<th data-order="member_nickname"><a href="">고객명</a></th>
					  		<th data-order="order_date" width="25%"><a href="">결제시각</a></th>
					  		<th data-order="order_status"><a href="">결제상태</a></th>
					  	  </tr>  	  
					 	  <tr>
					  		<th><input type="text" name="orderNo" value="${param.orderNo}" class="form-control"></th>
					  		<th><input type="text" name="orderName" value="${param.orderName}" class="form-control"></th>
					  		<th></th>
					  		<th><input type="text" name="memberNickname" value="${param.memberNickname}" class="form-control"></th>
					  		<th>
					  		  <div class="input-group">
					  			<input type="date" name="minDate" value="${param.minDate}" class="form-control">
					  			<span class="input-group-text">~</span>
					  			<input type="date" name="maxDate" value="${param.maxDate}" class="form-control">
					  		  </div>
					  		</th>
					  		<th><input type="text" name="orderStatus" value="${param.orderStatus}" class="form-control"></th>
					  	  </tr>
					  	  
					  	</thead>
					  	<tbody>
					
					  	</tbody>
					  </table>
					</form>
					<button class="more-btn btn btn-primary">더보기</button>
									
				
				
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