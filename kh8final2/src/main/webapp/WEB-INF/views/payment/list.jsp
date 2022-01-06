<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>


//form 스크립트
$(function () {
	'use strict'

	var forms = document.querySelectorAll('.needs-validation')

	Array.prototype.slice.call(forms).forEach(function (form) {
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
    	    event.preventDefault()
        	event.stopPropagation()
        }

        form.classList.add('was-validated')
    	}, false)
    })
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

                document.querySelector("input[name=postcode]").value = data.zonecode;
                //$("input[name=postcode]").val(data.zonecode);
                document.querySelector("input[name=basicAddress]").value = addr;
                //$("input[name=basicAddress]").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("input[name=extraAddress]").focus();
                //$("input[name=extraAddress]").focus();
            }
        }).open();
    }
});
</script>

<h1>결제 페이지</h1>


<h3>배송주소</h3>
<div>
	배송지 고르는 곳(회원만 보임)
	<c:if test="${loginNo != null}">
		<select>
			<option>회원배송지1</option>
			<option>회원배송지2</option>
		</select>
	</c:if>
</div>


<h1>디자인 시작</h1>

 <div class="container-zipggu">
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
							<c:forEach var="order" items="${orderList}">
                            <div class="row mt-2">

                                <!--상품 썸네일-->
                                <div class="col-auto">
                                    <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${order.itemNo}" class="d-block w-100" alt="...">
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
                                            <span style="font-size: 15px;"><strong>${order.getTotalPriceToString()}</strong></span>
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


                <form class="row g-3 needs-validation" novalidate>
                    
                    <!--수취인 이름-->
                    <div>
                        <label for="validationCustom01" class="form-label">수령인</label>
                        <input type="text" class="form-control" id="validationCustom01" required>
                    </div>
                    
                    <!--휴대폰 번호-->
                    <div>
                        <label for="validationCustom02" class="form-label">휴대폰</label>
                        <input type="text" class="form-control" id="validationCustom02" required>
                    </div>

                    <!--우편번호-->
                    <div>
                        <label for="validationCustomUsername" class="form-label">우편번호</label>
                        <div class="input-group has-validation">
                            <input type="text" class="form-control" name="postcode" id="validationCustomUsername" aria-describedby="inputGroupPrepend" required>  
                            <input type="button" value="우편번호 찾기" class="find-address-btn btn btn-secondary">                
                        </div>
                    </div>

                     <!--주소-->
                     <div>
                        <label for="validationCustom02" class="form-label">주소지</label>
                        <input type="text" class="form-control" name="basicAddress" id="validationCustom02" required placeholder="주소">
                    </div>
                    
                       <!--상세 주소-->
                    <div>
                        <label for="validationCustom02" class="form-label">상세주소</label>
                        <input type="text" class="form-control"  name="extraAddress" id="validationCustom02" required placeholder="상세주소">
                    </div>

                  </form>

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
                <button><img src="${pageContext.request.contextPath}/resources/image/kakaopay.jpg" width="100%" height=""></button>
            </div>

            <hr>

            <div class="row">

            </div>










            
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>