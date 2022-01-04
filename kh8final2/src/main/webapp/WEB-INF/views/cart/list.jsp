<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

$(function(){
	$(".buy-btn").click(function(){
		//하나도 체크되지 않은 경우는 중지
		if($("input[name=cartNo]:checked").length == 0) return;
		//form을 임시로 만들어서 body에 추가(전송용)
		
		var form = $("<form>").attr("action", "${root}/zipggu/payment/list").attr("method", "get").addClass("send-form");
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
			}
		});

			form.submit();
	});
});
	
	
	$(function(){
		$(".delete").on("click", function(){
			
			var cartNo = $("input[name=cartNo]").val();
		
			var cart = $(this).parent();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/cart/delete?cartNo="+cartNo,
				type:"delete",
				dataType:"text",
				success:function(resp){
					console.log("삭제제발!", resp);
					cart.remove();
					
					console.log(cart);
					
				},
				error:function(e){}
			});
			
		});
	});
    
	
</script>

<div class="container-zipggu">

<hr>
<c:forEach var="cartListVO" items="${cartListVO }">	
	<div class="cart">
		<input type="checkbox" name="cartNo" value="${cartListVO.cartNo }">
		<input type="text" name="quantity" value="${cartListVO.quantity }">
		<h5>
			카트NO : ${cartListVO.cartNo } / 멤버NO : ${cartListVO.memberNo } / 아이템NO : ${cartListVO.itemNo } / 
			${cartListVO.itemName } / 수량 : ${cartListVO.quantity } / ${cartListVO.itemPrice }
		</h5> 
		<div>
			<h5 style="color:blue">
				<c:forEach var="optionList" items="${cartListVO.optionList }">
					옵션 : ${optionList.itemOptionNo } / ${optionList.itemOptionGroup } / ${optionList.itemOptionDetail } / ${optionList.itemOptionPrice }
				</c:forEach>
			</h5>
		</div>
		<button class="delete">x</button>
		<hr>
	</div>
</c:forEach>
<button class="buy-btn">구매</button>

	
</div>
<br><br>
	
	<div class="result"></div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>