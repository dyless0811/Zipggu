<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-zipggu">
	<h1>아이템 디테일</h1>
	
	itemNo = ${itemDto.itemNo} <br>
	categoryNo = ${itemDto.categoryNo} <br>
	itemName = ${itemDto.itemName} <br>
	itemPrice = ${itemDto.itemPrice} <br>
	itemShippingType = ${itemDto.itemShippingType} <br>
	
	<c:forEach var="map" items="${itemOptionGroupMap}" varStatus="status">
		${status.count}번째 옵션그룹
		<select>
			<option value="" disabled selected hidden>${map.key}</option>
			<c:forEach var="optionDto" items="${map.value}">
				<option>${optionDto.itemOptionDetail}</option>
			</c:forEach>
		</select>
		<br>
	</c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>