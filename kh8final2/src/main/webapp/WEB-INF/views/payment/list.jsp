<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h1>결제 페이지</h1>

<c:forEach var="orderList" items="${orderList }">
	<h5>${orderList.toString() }</h5>
</c:forEach>


<h3>배송주소</h3>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>