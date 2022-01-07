<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-zipggu">

	<div class="row center">
		<h2>접근 권한이 없습니다.</h2>
	</div>
	<div class="row">
		<img src="${pageContext.request.contextPath }/resources/image/error/403.jpg" width="100%">		
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>