<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>게시글 상세페이지</h1>

<div>
	${memberNick }
</div>



<div>
	${snsDto }
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>