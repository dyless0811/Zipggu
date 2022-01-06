<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h1>결제 페이지</h1>

<c:forEach var="order" items="${orderList }">
	<h5>${order.toString() }</h5>
</c:forEach>


<h3>배송주소</h3>
<div>
	배송지 고르는 곳(회원만 보임)
	<c:if test="${loginNo != null}">
		<select>
			<option>회원배송지1</option>
			<option>회원배송지2</option>
		</select>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>