<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.float-container > .float-item-left:nth-child(1) {
		width:50%;	
		padding:0.5rem;
	}
	.float-container > .float-item-left:nth-child(2) {
		width:75%;
		padding:0.5rem;
	}
</style>


<h3>프로필 사진 등록</h3>

<div class="container-400 container-center">



	<div class="row float-container">


		<div class="float-item-left">
			
      <div class="row">
      	
        <label for="date" class="form-label mt-4">프로필 이미지 </label>
        
<!--         <button type ="button"> -->
        <c:choose>
            <c:when test="${memberProfileDto == null}">
            <img src="https://via.placeholder.com/300x300?text=User" width="100%" class="image image-border">
            </c:when>
            <c:otherwise>
            <img src="profile?memberProfileNo=${memberProfileDto.memberProfileNo}" width="100%" class="image image-border">
            <a href="delete?memberProfileNo=${memberProfileDto.memberProfileNo}">삭제</a>
            </c:otherwise>
        </c:choose>
<!--         </button> -->
        </div>
        
        </div>
        

    </div>

      <div class="d-grid gap-2">

      </div>
      

</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>