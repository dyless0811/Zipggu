<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageMember" value="${memberDto.memberNo}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
    //.find-address-btn이 눌리면(태그 종류 무관) 무조건 주소 검색창 출력
    $(".find-address-btn").click(function(e){
        e.preventDefault();//a태그일 경우를 대비
        findAddress();
    });

    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
               
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다
                // (주의) jQuery로 처리하려면 jQuery CDN이 이 코드보다 위에 있어야 한다.

                document.querySelector("input[name=addresseePostCode]").value = data.zonecode;
                //$("input[name=postcode]").val(data.zonecode);
                document.querySelector("input[name=addresseeAddress]").value = addr;
                //$("input[name=basicAddress]").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("input[name=addresseeAddressDetail]").focus();
                //$("input[name=extraAddress]").focus();
            }
        }).open();
    }
});


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
<script>
// 배송지 관리
$(function(){
	var select = $("#delivery");
	var deliveryNo = "";
	var memberNo = "${loginNo}";
	var deliveryTitle = $("#deliveryTitle");
	var addresseeName = $("input[name=addresseeName]");
	var addresseePhone = $("input[name=addresseePhone]");
	var addresseePostCode = $("input[name=addresseePostCode]");
	var addresseeAddress = $("input[name=addresseeAddress]"); 
	var addresseeAddressDetail = $("input[name=addresseeAddressDetail]");
	
	getListDelivery();
	
	$("#delivery-insert-btn").click(function(){
		var deliveryNo = insertDelivery();
		console.log("추가 클릭 시 리턴 값 = ",deliveryNo)
		getListDelivery(deliveryNo);
	});
	
	$("#delivery-update-btn").click(function(){
		var deliveryNo = updateDelivery();
		console.log("수정 클릭 시 리턴 값 = ",deliveryNo)
		getListDelivery(deliveryNo);
	});
	
	$("#delivery-delete-btn").click(function(){
		var deliveryNo = select.val();
		deleteDelivery(deliveryNo);
		clearDelivery();
		getListDelivery();
	})
	
	select.change(function(){
		if($(this).val() == 0) {
			clearDelivery();
		} else {
			getDelivery($(this).val());						
		}
	});
	
	function clearDelivery() {
		deliveryTitle.val("");
		addresseeName.val("");
		addresseePhone.val("");
		addresseePostCode.val("");
		addresseeAddress.val("");
		addresseeAddressDetail.val("");
	}
	
	function insertDelivery() {
		var data;
		$.ajax({
			url: "${pageContext.request.contextPath}/delivery/data",
			type: "post",
			async: false,
			data: {
				memberNo : parseInt(memberNo),
				deliveryTitle : deliveryTitle.val(),
				deliveryName : addresseeName.val(),
				deliveryPhone : addresseePhone.val(),
				deliveryPostcode : addresseePostCode.val(),
				deliveryAddress : addresseeAddress.val(),
				deliveryAddressDetail : addresseeAddressDetail.val()
			},
			success: function(resp){
				console.log("성공", resp);
				//resp = deliveryNo
				data = resp;
				alert("추가되었습니다");
			},
			error: function(e){
				console.log("실패", e);
			}
		});
		return data;
	}

	function getDelivery(deliveryNo) {
		$.ajax({
			url: "${pageContext.request.contextPath}/delivery/data",
			type: "get",
			data: {
				deliveryNo: deliveryNo
			},
			success: function(resp){
				console.log("성공", resp);
				deliveryTitle.val(resp.deliveryTitle);
				addresseeName.val(resp.deliveryName);
				addresseePhone.val(resp.deliveryPhone);
				addresseePostCode.val(resp.deliveryPostcode);
				addresseeAddress.val(resp.deliveryAddress);
				addresseeAddressDetail.val(resp.deliveryAddressDetail);
			},
			error: function(e){
				console.log("실패", e);
			}
		});
	}
	
	function getListDelivery(deliveryNo) {
		$.ajax({
			url: "${pageContext.request.contextPath}/delivery/data/listByMemberNo",
			type: "get",
			data: {
				memberNo : parseInt(memberNo)
			},
			success: function(resp){
				console.log("성공", resp);
				select.empty();
				
				var defaultOption = $("<option>")
							.val("")
							.attr("hidden", true)
							.attr("disabled", true)
							.text("배송지 선택");
				if(deliveryNo == undefined) {
					defaultOption.attr("selected", true);
				}
					
				select.append(defaultOption);
				
				for (var deliveryDto of resp) {
					var option = $("<option>")
								.val(deliveryDto.deliveryNo)
								.text(deliveryDto.deliveryTitle);
					if(deliveryNo == deliveryDto.deliveryNo) {
						option.attr("selected", true);
					}
					select.append(option);		
				}
				
				select.append(
					$("<option>")
					.val("0")
					.text("새로운 배송지")
				)
			},
			error: function(e){
				console.log("실패", e);
			}
		});
	}
	
	function updateDelivery() {		
		var data;
		$.ajax({
			url: "${pageContext.request.contextPath}/delivery/data/update",
			type: "post",
			async: false,
			data: {
				deliveryNo: select.val(),
				memberNo: parseInt(memberNo),
				deliveryTitle: deliveryTitle.val(),
				deliveryName: addresseeName.val(),
				deliveryPhone: addresseePhone.val(),
				deliveryPostcode: addresseePostCode.val(),
				deliveryAddress: addresseeAddress.val(),
				deliveryAddressDetail: addresseeAddressDetail.val()
			},
			success: function(resp){
				console.log("성공", resp);
				//resp = deliveryNo
				data = resp
				alert("수정되었습니다");
			},
			error: function(e){
				console.log("실패", e);
			}
		});
		return data;
	}
	
	function deleteDelivery(deliveryNo) {
		$.ajax({
			url: "${pageContext.request.contextPath}/delivery/data/delete",
			type: "post",
			data: {
				deliveryNo: parseInt(deliveryNo)
			},
			success: function(resp){
				console.log("성공", resp);
				alert("삭제되었습니다");
			},
			error: function(e){
				console.log("실패", e);
			}
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
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/orders">주문 내역</a></li>
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/delivery" class="active">배송지 관리</a></li>
		</ul>
	</nav>
	</div>
	
	
	<div class="container-zipggu" >
	
		            <div class="row mt-4 ms-2">
                <h3>배송지</h3>
            </div>
			<div class="row">
				<div class="col-3">
					<select id="delivery" class="form-select">
						
					</select>
				</div>
				<div class="col-2">
					<input id="deliveryTitle" type="text" class="form-control" placeholder="배송지명">
				</div>
				<div class="col-3">
					<button type="button" id="delivery-insert-btn" class="btn btn-primary">추가</button>
					<button type="button" id="delivery-update-btn" class="btn btn-primary">수정</button>
					<button type="button" id="delivery-delete-btn" class="btn btn-warning">삭제</button>
				</div>
				<div class="col-4">
				</div>
			</div>

                
                    
                    <!--수취인 이름-->
                    <div>
                        <label for="validationCustom01" class="form-label">수령인</label>
                        <input type="text" name="addresseeName" class="form-control" id="validationCustom01" required>
                    </div>
                    
                    <!--휴대폰 번호-->
                    <div>
                        <label for="validationCustom02" class="form-label">휴대폰</label>
                        <input type="text" name="addresseePhone" class="form-control" id="validationCustom02" required>
                    </div>

                    <!--우편번호-->
                    <div>
                        <label for="validationCustomUsername" class="form-label">우편번호</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="addresseePostCode" id="validationCustomUsername" aria-describedby="inputGroupPrepend" required placeholder="우편번호" readonly required>  
                            <input type="button" value="우편번호 찾기" class="find-address-btn btn btn-secondary">                
                        </div>
                    </div>

                     <!--주소-->
                     <div>
                        <label for="validationCustom02" class="form-label">주소지</label>
                        <input type="text" class="form-control" name="addresseeAddress" id="validationCustom02" required placeholder="주소" readonly>
                    </div>
                    
                       <!--상세 주소-->
                    <div>
                        <label for="validationCustom02" class="form-label">상세주소</label>
                        <input type="text" class="form-control"  name="addresseeAddressDetail" id="validationCustom02" required placeholder="상세주소">
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