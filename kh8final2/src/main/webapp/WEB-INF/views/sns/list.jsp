<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	
</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


  <div class="container-fluid">
        <div class="row py-lg-5 text-center">
            <div class="col-lg-6 col-md-8 mx-auto">
            <h1 class="fw-light"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">앨범 예</font></font></h1>
            <p class="lead text-muted"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">아래 앨범에 대한 간략한 설명(내용, 제작자 등). </font><font style="vertical-align: inherit;">짧고 귀엽게 유지하되 너무 짧지 않도록 하여 사람들이 이 앨범을 완전히 건너뛰지 않도록 합니다.</font></font></p>
            </div>
        </div>

   	  	
				<a href="write" class="btn btn-outline-secondary">등록</a>

        <div class="album py-5">
            <div class="container">
              <div class="row row-cols-1 row-cols-sm-1 row-cols-md-3 g-3">
        		<c:forEach var="snsDto" items="${list }">
                <div class="col">
                  <div class="card shadow-sm">
                  	<a href="detail?snsNo=${snsDto.snsNo }">
                    	<img src="thumnail?snsNo=${snsDto.snsNo}" class="bd-placeholder-img card-img-top" width="100%" height="225" >
                    </a>
                    <div class="card-body">
                      <p class="card-text">${snsDto.snsDetail }...</p>
                      <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                          <button type="button" class="btn btn-sm btn-outline-secondary">♡</button>
                          &nbsp;&nbsp;
                          <button type="button" class="btn btn-sm btn-outline-secondary">댓글</button>
                        </div>
                        <small class="text-muted">${loginNick }</small>
                      </div>
                    </div>
                  </div>
                </div>
          		</c:forEach>
              </div>
            </div>
          </div>
    </div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>