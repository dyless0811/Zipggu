<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(".option-plus").on("click", function(e){
			
						
	        var list = [];
	   		var clonedTemplate = $("#option-template").clone();
	   		var templateContent = $(clonedTemplate.html());
	   		
	        var count = 0;
			var check = false;
			$(".itemOptionNo[data-required=1]").each(function(index, data){				
				console.log($(data).val());
				
				var data = $(data).val();
				
				if(data == null){
					
					check = true;
					return;
				}
				else{
					
			   		var input = ("<input type='text' name='optionList["+count+"].noList["+index+"].itemOptionNo' value='"+data+"'>");
			   		templateContent.append(input);
			   		console.log(input);
				}
			
			});
				if(check){
				return;
				
					
				}
				count++;

		   		clonedTemplate.html(templateContent.prop('outerHTML'));
		   		var result = $(".result");
		   		result.append(clonedTemplate.html());
		});
		
	});
	$(function(){
		$("#cart-btn").click(function(e){
			
			var quantity = $("#quantity").val();
			if(!quantity){
				
				e.preventDefault();
			}
			else{
				
				$(".cart").submit();
			}
			
		});
	});
	
	
	
</script>

<div class="container-zipggu">
	<h1>아이템 디테일</h1>
	
	thumbnail = <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${itemNo}" style="max-width:300px"><Br>
	
	itemNo = ${itemDto.itemNo} <br>
	categoryNo = ${itemDto.categoryNo} <br>
	itemName = ${itemDto.itemName} <br>
	itemPrice = ${itemDto.itemPrice} <br>
	itemShippingType = ${itemDto.itemShippingType} <br>
	
	image = 
	<c:forEach var="itemFileDto" items="${itemFileDtoList}">
		<img src="${pageContext.request.contextPath}/item/image?itemFileNo=${itemFileDto.itemFileNo}" style="max-width:300px"><br>
	</c:forEach>
	
	<c:forEach var="map" items="${itemOptionGroupMap}" varStatus="status">
		${status.count}번째 옵션그룹
		<select class="itemOptionNo" data-required="${map.value[0].itemOptionRequired}">
			<option value="" disabled selected hidden>${map.key}</option>
			<c:forEach var="optionDto" items="${map.value}">
				<option value="${optionDto.itemOptionNo}" data-price="${optionDto.itemOptionPrice}">${optionDto.itemOptionDetail}</option>
			</c:forEach>
		</select>
		<br>
	</c:forEach>
	<button class="option-plus btn btn-primary">추가</button>
	<br><br>
	<button id="cart-btn" class="btn btn-primary">장바구니</button>
	<button class="btn btn-primary">구매하기</button>
</div>

<form action="${root }/zipggu/cart/insert" method="post" class="cart">
	<div>
		<input type="hidden" name="itemNo" value="${itemDto.itemNo }">
		<div class="result"></div>
	</div>
</form>

<template id="option-template">
	<div>
		수량 : <input type="number" id="quantity" name="optionList[0].quantity" min="1" max="999" value="1">
	</div>
</template>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>