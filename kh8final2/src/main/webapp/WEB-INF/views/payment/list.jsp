<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>


//form 스크립트
$(function () {
	$("#order-submit").click(function(){
		var isEmpty = false;
		$("input[name]").not("input[class=search-box]").each(function(){
			if($(this).val() == ""){
				isEmpty = true;
				console.log($(this));
				return false;
			}
		});
		if(isEmpty) {
			alert("빈칸!!!!!");
			return;
		}
		$(".order-form").submit();
		console.log($(".order-form"))
	});
});


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



 <div class="container-zipggu">
 	<form class="row g-3 order-form" action="confirm" method="post">
        <div class="p-5 mb-4 bg-light border rounded-3">
            
            <!--주문상품 보여줄 곳-->
            <div class="accordion accordion-flush" id="accordionFlushExample">
                <div class="accordion-item">
                    <!--주문상품 개수 출력-->
                    <h2 class="accordion-header" id="flush-headingOne">
                    
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                            주문상품 ${orderList.size()}개
                        </button>

                    </h2>

                    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">

						
                        <!--주문상품 내역 (반복문 시작)-->
						
                        <div class="accordion-body">
                        	<input type="hidden" name="shipping" value="${shipping}">
							<c:forEach var="order" items="${orderList}" varStatus="status">
							<input type="hidden" name="list[${status.index}].cartNo" value="${order.cartNo}">
							<input type="hidden" name="list[${status.index}].quantity" value="${order.quantity}">
                            <div class="row mt-2">
								
                                <!--상품 썸네일-->
                                <div class="col-auto">
                                    <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${order.itemNo}" class="d-block w-100" style="width:150px;height:150px" alt="...">
                                </div>

                                <!--상품 옵션 및 수량-->
                                <div class="item-detail col-auto me-auto">

                                    <!-- 상품명 -->
                                    <div class="row m-1">
                                        <div class="col-auto me-auto">
                                            <span style="font-size: 15px;"><strong>${order.itemName}  ${order.quantity}개</strong></span>
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
                                            <strong><span style="font-size: 15px;">${order.getSumPriceToString()}</span>원</strong>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <hr>

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

                  

                  <div class="row mt-4"></div>

            <hr>

            <!--결제금액 출력 하는 곳-->
            <div class="row mt-4 ms-2">
                <h3>결제 금액</h3>
            </div>

            <!--총 상품 금액-->
            <div class="row mt-3">
                <div class="col-auto me-auto">
                    <span style="color: dimgray;"><strong>총 상품 금액</strong></span>
                </div>
        
                
                <div class="col-auto">
                    <span style="color: black;"><strong>${totalPrice} 원</strong></span>
                </div>
            </div>
            
            <!--배송비-->
            <div class="row">
                <div class="col-auto me-auto">
                    <span style="color: dimgray;"><strong>배송비</strong></span>
                </div>
        
                
                <div class="col-auto">
                    <span style="color: black;"><strong>${shipping} 원</strong></span>
                </div>
            </div>

            <!--총 결제 금액-->
            <div class="row">
                <div class="col-auto me-auto">
                    <span style="color: dimgray;"><strong>총 결제금액</strong></span>
                </div>
        
                
                <div class="col-auto">
                    <span style="color: black;"><strong>${totalAmount} 원</strong></span>
                </div>
            </div>
            
            <div class="row mt-4"></div>

            <hr>

            <div class="row mt-4 ms-3">
                <h3>결제</h3>
            </div>

            <div class="row">
                <button type="button" id="order-submit"><img src="${pageContext.request.contextPath}/resources/image/kakaopay.jpg" width="100%" height=""></button>
            </div>

            <hr>

            <div class="row">

            </div>

        </div>
        </form>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>