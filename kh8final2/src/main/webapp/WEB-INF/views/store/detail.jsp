<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(document).on("click", ".remove-btn", function(){
			$(this).parent().remove();	
		});
		
		$(".option-plus").on("click", function(e){
			
	   		var clonedTemplate = $("#option-template").clone();
	   		var templateContent = $(clonedTemplate.html());
	   		
			var check = false;
			$(".itemOptionNo").each(function(index, option){
				var optionVal = $(option).val();
				var optionName = $(option).find("option:selected").text();
				var optionRequired = $(option).data("required");
				if(optionRequired == 1 && optionVal == null){
					check = true;
					return false; //break
				} else if(optionVal == null){
					return true;  //continue
				}
				if(index == 0){
					var button = $("<button>").text("x").addClass("remove-btn");
					templateContent.append(button);
					var quantity = "<input type='number' class='quantity' min='1' max='999' value='1'>"
					templateContent.append(quantity);
				}
				templateContent.append(" / ");
			   	var optionData = "<span data-option-no="+optionVal+">"+optionName+"</span>";
			   	templateContent.append(optionData);
			   	$(option).find("option:eq(0)").prop("selected", true);

			});
			if(check){
				alert("옵션을 선택해주세요");
				return;
			}

	   		clonedTemplate.html(templateContent.prop('outerHTML'));
	   		var selectedItems = $(".selected-items");
	   		selectedItems.append(clonedTemplate.html());
		});
	});
	
	$(function(){
		$(".cart-btn").click(function(e){
			var check = false;
			
			$(".quantity").each(function(index, quantity){
				var quantityVal = $(".quantity").val();
				if(!quantityVal || quantityVal == 0){
					e.preventDefault();
					check = true;
					return false;  //break
				}
			});
			if(check){
				alert("수량을 입력해주세요");
				return;
			}
			var result = $(".result");
			$(".selected-item").each(function(index1, item){
				var quantityVal = $(item).find("input").val();
				var quantity = "<input type='hidden' name='optionList["+index1+"].quantity' value='"+quantityVal+"'>"
				result.append(quantity);
				$(item).find("span").each(function(index2, option){
					var optionVal = $(option).data("option-no");
					var option = "<input type='hidden' name='optionList["+index1+"].noList["+index2+"].itemOptionNo' value='"+optionVal+"'>"
					result.append(option);
				});
			});
			$(".cart").submit();
		});
	});
	
// 	if(index == 0){
// 		var quantity = "<input type='number' class='quantity' name='optionList["+count+"].quantity' min='1' max='999' value='1'>"
// 		templateContent.append(quantity);
// 	}
//    	var optionData = "<input type='text' name='optionList["+count+"].noList["+index+"].itemOptionNo' value='"+optionVal+"'>";
//    	templateContent.append(optionData);
//    	console.log(input);
	
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
	<button class="cart-btn btn btn-primary" data-buy-type="cart">장바구니 추가</button>
	<button class="cart-btn btn btn-primary" data-buy-type="payment">구매하기</button>
</div>
<div class="selected-items">

</div>
<form action="${root }/zipggu/cart/insert" method="post" class="cart">
	<div>
		<input type="hidden" name="itemNo" value="${itemDto.itemNo }">
		<div class="result"></div>
	</div>
</form>

<template id="option-template">
	<div class="selected-item">
		
	</div>
</template>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>