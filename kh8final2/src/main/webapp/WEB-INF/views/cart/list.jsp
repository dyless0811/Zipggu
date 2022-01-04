<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<div class="container-zipggu">
		<c:forEach var="cartListVO" items="${cartListVO }">	
		<h5>${cartListVO.cartNo } / ${cartListVO.toString() }</h5>
		</c:forEach>
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>