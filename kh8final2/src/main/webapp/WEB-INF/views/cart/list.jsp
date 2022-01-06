<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .pay{
        color: dimgray;
        margin-top: 20px;
        font-size: 14px;
        font-weight: bold;
    }
    .item-detail{
        border: 1px;
        background-color: #EAECEE;
        width: 40rem;
        height: 7rem;
        margin-top: auto;
        margin-bottom: auto;
        margin-right: 0 !important;
        margin-left: auto;
        padding:0;
    }
    .qty .count {
        color: #000;
        display: inline-block;
        vertical-align: top;
        font-size: 15px;
        font-weight: 700;
        line-height: 30px;
        
        min-width: 35px;
        text-align: center;
    }
    .qty .plus {
        cursor: pointer;
        display: inline-block;
        vertical-align: top;
        color: white;
        width: 30px;
        height: 30px;
        font: 80px;
        font-weight: bold;
        text-align: center;
        border-radius: 0%;
    }
    .qty .minus {
        cursor: pointer;
        display: inline-block;
        vertical-align: top;
        color: white;
        width: 30px;
        height: 30px;
        font: 80px;
        font-weight: bold;
        text-align: center;
        border-radius: 0%;
        background-clip: padding-box;
    }
    .minus:hover{
        background-color: #717fe0 !important;
    }
    .plus:hover{
        background-color: #717fe0 !important;
    }
    /*Prevent text selection*/
    input{  
        border: 0;
        width: 2%;
    }
    nput::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    input:disabled{
        background-color:white;
    }
</style>

<script>

//체크박스 선택하여 구매하기
$(function(){
	$(".buy-btn").click(function(){
		//하나도 체크되지 않은 경우는 중지
		if($("input[name=cartNo]:checked").length == 0) return;
		//form을 임시로 만들어서 body에 추가(전송용)
		
		var form = $("<form>").attr("action", "${root}/zipggu/payment/list").attr("method", "post").addClass("send-form");
		$(".result").append(form);
		
		//모든 div를 돌면서 내부에 존재하는 checkbox와 수량을 조사한 뒤 체크된 항목에 대해서 번호와 수량을 별도의 form에 첨부
		var count = 0;
		$(".cart").each(function(){
			//this==현재 반복중인 div
			var checkbox = $(this).find("input[name=cartNo]");
			var number = $(this).find("input[name=quantity]");
			console.log(checkbox,number);
			
			if(checkbox.prop("checked")){//체크박스가 체크된 경우
				//체크박스의 value가 상품번호이고 입력창의 숫자가 상품수량이므로 이 둘을 각각 별도의 form에 추가
				var no = checkbox.val();
				var quantity = number.val();
				
				$("<input type='hidden' name='list["+count+"].cartNo'>").val(no).appendTo(".send-form");
				$("<input type='hidden' name='list["+count+"].quantity'>").val(quantity).appendTo(".send-form");
				
				count++;
				
				console.log(no);
				console.log(quantity);
				console.log(count);
				
			}
		});
			$("<input type='hidden' name='shipping' value='4000'>").appendTo(".send-form");
			form.submit();
	});
});
	
	//장바구니 삭제 ajax
	$(function(){
		$(".delete").on("click", function(){
			//this == .delete 클래스의 버튼
			
			//input name=cartNo의 값을 변수에 저장
			var cartNo = $("input[name=cartNo]").val();
		
			//삭제후 페이지에서 삭제를 위해 버튼 앞의 div를 변수에 저장
			var cart = $(this).parent().parent().parent().parent().parent();
			
			//ajax...
			$.ajax({
				url:"${pageContext.request.contextPath}/cart/delete?cartNo="+cartNo,
				type:"delete",
				dataType:"text",
				success:function(resp){
					//성공이라면 콘솔에 찍어준다.
					console.log("삭제제발!", resp);
					//위에 저장한 변수로 삭제된 아이템 지우기.
					cart.remove();
					
					//console.log(cart);
					
				},
				error:function(e){}
			});
			
		});
	});
    
	//체크박스 전체 선택
	 $(function(){

         $(".check-all").on("input", function(){
            
             console.log(1);

             var isChecked = $(this).prop("checked");
             console.log(isChecked);
             $("input[type=checkbox]").prop("checked", isChecked);
         });
     });

	 //체크박스 선택하여 구매하기
     $(function(){
     	$(".ea").on("input", function(){
     		
     		
     		var ea = $("input[name=cartNo]:checked").length;
     		$("#answer-length").text(ea);
     		calcTotalPrice();
     	});
     });
	 
	 //수량 버튼
     $(function(){
		$('.count').prop('disabled', true);
		
		$(document).on('click','.plus',function(){
			var count = $(this).siblings('.count');
			count.val(parseInt(count.val()) + 1 );
			calcItemPrice($(this));
			calcTotalPrice();
    	});
		
     	$(document).on('click','.minus',function(){
			var count = $(this).siblings('.count');
     		count.val(parseInt(count.val()) - 1 );
 			if (count.val() == 0) {
 				count.val(1);
			}
 			calcItemPrice($(this));
 			calcTotalPrice();
		});
	});
	
	 function calcItemPrice(button){
		 var priceTag = button.parent().next().find(".itemPrice");
		 
		 var quantity = button.siblings('.count').val();
		 var price = quantity * priceTag.data("item-price");
		 
		 var value = (price).toLocaleString(undefined);
		 priceTag.text(value);
	 }
	 function calcTotalPrice(){
		 var totalPrice = 0;
		 var shipping = 0;
		 $(".cart input:checked").each(function(){
			var count = $(this).parent().parent().next().find(".count").val();
			var price = $(this).parent().parent().next().find(".itemPrice").data("item-price");
			totalPrice += price * count;
		 });
		 
		 if(0 < totalPrice && totalPrice < 50000){
			 shipping = 3000;
		 }
		 
		 $("#shipping").text((shipping).toLocaleString(undefined));
		 $("#totalPrice").text((totalPrice).toLocaleString(undefined));
		 $("#orderTotalPrice").text((shipping+totalPrice).toLocaleString(undefined));
	 }
	 

</script>

<div class="container-zipggu">

<!-- <hr> -->

<%-- <c:forEach var="cartListVO" items="${cartListVO }">	 --%>
<!-- 	<div class="cart"> -->
<%-- 		<input type="checkbox" name="cartNo" value="${cartListVO.cartNo }"> --%>
<%-- 		<input type="text" name="quantity" value="${cartListVO.quantity }"> --%>
<!-- 		<h5> -->
<%-- 			카트NO : ${cartListVO.cartNo } / 멤버NO : ${cartListVO.memberNo } / 아이템NO : ${cartListVO.itemNo } /  --%>
<%-- 			${cartListVO.itemName } / 수량 : ${cartListVO.quantity } / ${cartListVO.itemPrice } --%>
<!-- 		</h5>  -->
<!-- 		<div> -->
<!-- 			<h5 style="color:blue"> -->
<%-- 				<c:forEach var="optionList" items="${cartListVO.optionList }"> --%>
<%-- 					옵션 : ${optionList.itemOptionNo } / ${optionList.itemOptionGroup } / ${optionList.itemOptionDetail } / ${optionList.itemOptionPrice } --%>
<%-- 				</c:forEach> --%>
<!-- 			</h5> -->
<!-- 		</div> -->
<!-- 		<button class="delete">x</button> -->
<!-- 		<hr> -->
<!-- 	</div> -->
<%-- </c:forEach> --%>

<!-- <button class="buy-btn">구매</button> -->

	
<!-- </div> -->
<!-- <br><br> -->
	
	
	
	
	
	
	
	
<!-- <hr> -->

<!-- <h1>장바구니 디자인 추가 부분</h1> -->


<div class="container-zipggu">
	
        <div class="p-5 mb-4 bg-light border rounded-3">

            <div class="row mb-4">

                <!--선택된 총 상품개수-->
                <p class="h4 p-3 mb-2"><strong><span id="answer-length">0</span>개 상품을 선택하셨어요</strong></p>

                <!--총 상품 금액 + 배송비-->
                <p class="h5"><strong>예상 결제 금액은 <span id="orderTotalPrice">0</span>원 입니다</strong></p>
            </div>

            <div class="row pay">

                <!--선택된 총 상품 금액-->
                <p>총 상품 금액  :  <span id="totalPrice">0</span> 원</p>

                <!--배송비-->
                <p>총 배송비  :  <span id="shipping">0</span> 원</p>

            </div>
            
            
            <div class="row mt-5">

                <!--모두선택 체크박스-->
                <div class="col-auto me-auto">
                    <input type="checkbox" class="check-all ea form-check-input" ><span>모두선택</span>
                </div>

                <!--모두삭제 버튼-->
                <div class="col-auto">
                    <button class="btn btn-secondary">모두삭제</button>
                </div>
            </div>
            
            <!--장바구니에 추가한 상품목록 시작-->
			<c:forEach var="cartListVO" items="${cartListVO }">
            <div class="cart ">
            <hr>
            
	            <!--상품명-->
	            <div class="row mt-4 mb-4">
	                <p class="h4">${cartListVO.itemName }</p>
	                <span style='display:none;'>${cartListVO.itemPrice }</span>
	            </div>
	            <div class="row">
	
	                <!--체크박스-->
	                <div class="col-auto me-auto">
	                	<input type="checkbox" class="check-item ea form-check-input" name="cartNo" value="${cartListVO.cartNo }">
	                </div>
	            </div>
	
	    
	            <div class="row mb-4">
	
	            
	                <!--상품 썸네일-->
	                <div class="col-auto">
	                    <img src="http://placeimg.com/150/150/animals" class="d-block w-100" alt="...">
	                </div>
	                <!--상품 옵션 및 수량-->
	                <div class="item-detail col-auto me-auto">
	                
	                    <div class="row m-3">
	                        <!-- 옵션 -->
	                        <div class="col-auto me-auto">
	                        
		                	<!-- 옵션 반복문 시작 -->
		                	옵션 :
							<c:forEach var="optionList" items="${cartListVO.optionList }" varStatus="status">
	                            	<span>${status.index != 0 ? "/" : ""} ${optionList.itemOptionGroup}: ${optionList.itemOptionDetail}</span>
	                            	<span style='display:none'>${optionList.itemOptionPrice }</span>
							 </c:forEach>
	                        </div>
	                        
	                        <!--삭제 버튼-->
	                        <div class="col-auto">
	                            <button type="button" class="delete btn-close" aria-label="Close"></button>
	                        </div>
	                        
	                    </div>
	
	                    <div class="row m-3">
	                        <div class="qty col-auto me-auto">
	                            <span class="minus bg-dark">-</span>
	                            <input type="text" class="count" name="quantity" value="${cartListVO.quantity}">
	                            <span class="plus bg-dark">+</span>
	                        </div>
	
	                        <!--상품금액-->
	                        <div class="col-auto">
	                            <p class="h5"><strong><span class="itemPrice" data-item-price="${cartListVO.getTotalPrice()}">${cartListVO.getTotalPriceToString()}</span>원</strong></p>
	                        </div>
	                    </div>
	
	                </div>
	                
	            </div>
			</div>
			</c:forEach>

		    <c:if test="${cartListVO.size() == 0 }">
		    	<div class="center">
		    		<h1>장바구니에 상품이 없습니다</h1>
				</div>
			</c:if>
	
            <hr>
            <div class="row mt-5">
                <button class="buy-btn btn btn-secondary btn-lg">구매하러가기</button>
            </div>

        </div>
    </div>
    
   	<div class="result"></div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>