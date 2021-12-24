<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form method="post">

<div class="container-400 container-center">
	<div class="row center">
		<h2>회원정보수정</h2>
	</div>
	<div class="row">
		<label>이메일</label>
		<input type="text" name="memberEmail" value="${memberDto.memberEmail}" readonly class="form-input">
	</div>
	<div class="row">
		<label>별명</label>
		<input type="text" name="memberNickname" value="${memberDto.memberNickname}" class="form-input">
	</div>
<!-- 	<div class="row"> -->
<!-- 		<label>성별</label> -->
<%-- 		<input type="date" name="memberGender" value="${memberDto.memberGender}" class="form-input"> --%>
<!-- 	</div> -->
<!-- 	<div class="row"> -->
<!-- 		<label>생년월일</label> -->
<%-- 		<input type="email" name="memberBirth" value="${memberDto.memberBirth}" class="form-input"> --%>
<!-- 	</div>		 -->
<!-- 		<div class="row"> -->
<!-- 		<label>한줄 소개</label> -->
<%-- 		<input type="tel" name="memberInt" value="${memberDto.memberPhone}" class="form-input"> --%>
<!-- 	</div>	 -->
	<div class="row">
		<input type="submit" value="회원 정보 수정" class="form-btn">
	</div>

	<c:if test="${param.error != null}">
	<div class="row center">
		<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
</div>
</form>

<%if(request.getParameter("error") != null){ %>
	<h4><font color="red">입력하신 정보가 일치하지 않습니다</font></h4>
<%} %>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>