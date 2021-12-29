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


<h3>회원정보수정</h3>

<div class="container-400 container-center">

<form method="post" enctype="multipart/form-data">
    <div class="form-group">
        <fieldset>
          <label class="form-label mt-4" for="readOnlyInput">이메일</label>
          <input type="email" name="memberEmail"  class="form-control" id="readOnlyInput" type="text" value="${memberDto.memberEmail}" readonly="">
        </fieldset>
      </div>  

      <div class="form-group">
        <label class="col-form-label mt-4" for="inputDefault">별명</label>
        <input type="text" class="form-control" value="${memberDto.memberNickname}" id="inputDefault">
      </div>

      <fieldset class="form-group">
        <label class="mt-4">성별</label>
      </fieldset>
      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked="">
        <label class="btn btn-outline-primary" for="btnradio1">남자</label>
        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked="">
        <label class="btn btn-outline-primary" for="btnradio2">여자</label>
      </div>

      <div class="form-group">
        <label for="date" class="form-label mt-4">생년월일</label>
        <input type="date">
    </div>


	<div class="row float-container">


		<div class="float-item-left">
			
      <div class="row">
      	
        <label for="date" class="form-label mt-4">프로필 이미지 </label>
        <input type="file" name="attach" accept="image/*" class="form-input">
        <button type ="button">
        <c:choose>
            <c:when test="${memberProfileDto == null}">
            <img src="https://via.placeholder.com/300x300?text=User" width="100%" class="image image-border">
            </c:when>
            <c:otherwise>
            <img src="profile?memberProfileNo=${memberProfileDto.memberProfileNo}" width="100%" class="image image-border">
            </c:otherwise>
        </c:choose>
        </button>
        </div>
        
        </div>
    </div>
      <div class="form-group">
        <label for="exampleTextarea" class="form-label mt-4">한줄소개</label>
        <textarea class="form-control" id="exampleTextarea" rows="1"></textarea>
      </div>

      <div class="d-grid gap-2">
      <input type="submit" class="btn btn-lg btn-primary" value="회원 정보 수정">
      </div>
      
      </form>
</div>

<%-- 	<c:if test="${param.error != null}"> --%>
<!-- 	<div class="row center"> -->
<!-- 		<h4 class="error">입력하신 정보가 일치하지 않습니다</h4> -->
<!-- 	</div> -->
<%-- 	</c:if> --%>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>