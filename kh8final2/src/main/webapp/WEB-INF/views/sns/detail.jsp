<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h1 class="center">게시글 상세페이지</h1>

	
	<div class="container">
	  <div class="row mt-3">
	    <div class="col">
	    </div>
	    <div class="col-7">
	     <div class="card mb-3">
	     
	     	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		        <div class="carousel-indicators">
		          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
		          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
		        </div>
		        
		        
		        <div class="carousel-inner">
		       		<c:forEach var="snsFileDto" items="${fileList }" varStatus="i">
		       			<c:choose>
		       				<c:when test="${i.index == 0}">
		       					<div class="carousel-item active">
		           					<img src="file?snsFileNo=${snsFileDto.snsFileNo }" class="d-block w-100" alt="...">
	         					</div>
		       				</c:when>
		       				<c:otherwise>
		       					<div class="carousel-item">
           							<img src="file?snsFileNo=${snsFileDto.snsFileNo }" class="d-block w-100" alt="...">
          						</div>
		       				</c:otherwise>
		       			</c:choose>
					</c:forEach>
		        </div>
	          			
		        
		        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		          <span class="visually-hidden">Previous</span>
		        </button>
		        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		          <span class="carousel-control-next-icon" aria-hidden="true"></span>
		          <span class="visually-hidden">Next</span>
		        </button>
	      </div>

			
			<!-- 버튼 -->	
        	<div class="card-body">
          		<button type="button" class="btn btn-sm btn-outline-secondary">
                    <!-- 좋아요 아이콘 -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
			  		<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
					</svg>
                </button>
                 &nbsp;&nbsp;
                <button type="button" class="btn btn-sm btn-outline-secondary">
                <!-- 댓글 아이콘 -->
                   	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
	 				<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
	  				<path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"></path>
					</svg>
                </button>
                 &nbsp;&nbsp;
                <!-- 수정 아이콘 -->
                <button type="button" class="btn btn-sm btn-outline-secondary">
					<a href="edit?snsNo=${snsDto.snsNo }">수정</a>
				</button>
                 &nbsp;&nbsp;
                <!-- 삭제 아이콘 -->
                <button type="button" class="btn btn-sm btn-outline-secondary">
					<a href="delete?snsNo=${snsDto.snsNo }">삭제</a>
				</button>
                <!-- 내용 -->
          		<pre class="card-text mt-3">${snsDto.snsDetail }</pre>
          		<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
        	</div>
    	</div>
	    </div>
	    <div class="col">
	    </div>
	  </div>
	</div>
		
	
	


<div>
	

</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>