<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
		<select data-required="${map.value[0].itemOptionRequired}">
			<option value="" disabled selected hidden>${map.key}</option>
			<c:forEach var="optionDto" items="${map.value}">
				<option value="${optionDto.itemOptionNo}" data-price="${optionDto.itemOptionPrice}">${optionDto.itemOptionDetail}</option>
			</c:forEach>
		</select>
		<br>
	</c:forEach>
	<button class="btn btn-primary">장바구니</button>
	<button class="btn btn-primary">구매하기</button>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>