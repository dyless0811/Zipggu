<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
//Example starter JavaScript for disabling form submissions if there are invalid fields
$(function () {
'use strict'

// Fetch all the forms we want to apply custom Bootstrap validation styles to
var forms = document.querySelectorAll('.needs-validation')

// Loop over them and prevent submission
Array.prototype.slice.call(forms)
    .forEach(function (form) {
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
        }

        form.classList.add('was-validated')
    }, false)
    })
});
</script>

<h1>결제 페이지</h1>

<c:forEach var="orderList" items="${orderList }">
	<h5>${orderList.toString() }</h5>
</c:forEach>


<h3>배송주소</h3>



<h1>디자인 시작</h1>

<div class="container-zipggu">
        <div class="p-5 mb-4 bg-light border rounded-3">
            
            <!--주문상품 보여줄 곳-->
            <div class="accordion accordion-flush" id="accordionFlushExample">
                <div class="accordion-item">
                    <!--주문상품 개수 출력-->
                    <h2 class="accordion-header" id="flush-headingOne">
                    
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                            주문상품 2개
                        </button>

                    </h2>

                    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">


                        <!--주문상품 내역 (반복문 시작)-->
                        <div class="accordion-body">
                            <div class="row mt-2">

                                <!--상품 썸네일-->
                                <div class="col-auto">
                                    <img src="http://placeimg.com/100/100/animals" class="d-block w-100" alt="...">
                                </div>

                                <!--상품 옵션 및 수량-->
                                <div class="item-detail col-auto me-auto">

                                    <!-- 상품명 -->
                                    <div class="row m-1">
                                        <div class="col-auto me-auto">
                                            <span style="font-size: 15px;"><strong>클린 싱크대 음식물 쓰레기 거름망</strong></span>
                                        </div>
                                    </div>
                
                                    <!--옵션-->
                                    <div class="row m-1">
                                        <div class="col-auto me-auto">
                                            <span style="font-size: 12px; color: dimgray;"><strong>딥그린 / 1개</strong></span>
                                        </div>
                                    </div>
                
                                    <!--상품금액-->
                                    <div class="row m-1">
                                        <div class="col-auto me-auto">
                                            <span style="font-size: 15px;"><strong>1,000,000,000</strong></span>
                                        </div>
                                    </div>
                
                                </div>
                                
                            </div>
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
                            <input type="text" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend" required>                  
                            <button type="button" class="btn btn-secondary">우편번호찾기</button>
                        </div>
                    </div>

                     <!--주소-->
                     <div>
                        <label for="validationCustom02" class="form-label">주소지</label>
                        <input type="text" class="form-control" id="validationCustom02" required>
                    </div>
                    
                       <!--상세 주소-->
                    <div>
                        <label for="validationCustom02" class="form-label">상세주소</label>
                        <input type="text" class="form-control" id="validationCustom02" required>
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
                    <span style="color: black;"><strong>9,999,995,000 원</strong></span>
                </div>
            </div>
            
            <!--배송비-->
            <div class="row">
                <div class="col-auto me-auto">
                    <span style="color: dimgray;"><strong>배송비</strong></span>
                </div>
        
                
                <div class="col-auto">
                    <span style="color: black;"><strong>5,000 원</strong></span>
                </div>
            </div>

            <!--총 결제 금액-->
            <div class="row">
                <div class="col-auto me-auto">
                    <span style="color: dimgray;"><strong>총 결제금액</strong></span>
                </div>
        
                
                <div class="col-auto">
                    <span style="color: black;"><strong>5,000 원</strong></span>
                </div>
            </div>
            
            <div class="row mt-4"></div>

            <hr>

            <div class="row mt-4 ms-3">
                <h3>결제</h3>
            </div>

            <div class="row">
                <button><img src="./kakaopay.jpg" width="100%" height=""></button>
            </div>

            <hr>

            <div class="row">

            </div>










            
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>