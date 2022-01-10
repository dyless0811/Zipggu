<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-zipggu">

	<div class="row center">
		<h2>일시적인 서버 오류가 발생했습니다.</h2>
	</div>
	<div class="row">
		<img src="${pageContext.request.contextPath }/resources/image/403.png" width="100%">		
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>