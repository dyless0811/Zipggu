<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
	var page = 1;
	var size = 24;
	var url = new URL(location.href);
	var urlParams = url.searchParams;
	var categoryNo = 0;
	if(urlParams.get("categoryNo")){
		categoryNo = urlParams.get("categoryNo");
	}
	var itemName = urlParams.get("itemName");
	var result = $(".furniture-item-group-3")
	$(".more-btn").click(function(){
		loadData(page, size);
		page++;
	});
	
	$(".more-btn").click();
	
	function loadData(page, size){
		$.ajax({
			url : "${pageContext.request.contextPath}/store/data/list",
			type : "get",
			data : {
				page : page,
				size : size,
				categoryNo : categoryNo,
				itemName : itemName
			},
			dataType : "json",
			success:function(resp){
	
				//데이터가 sizeValue보다 적은 개수가 왔다면 더보기 버튼을 삭제
				if(resp.length < size){
					$(".more-btn").remove();
				}
				
				//데이터 출력
				for(var i=0; i < resp.length; i++){
					var clonedTemplate = $("#item-template").clone();
					var templateContent = $(clonedTemplate.html());
					templateContent.find("a").attr("href","${pageContext.request.contextPath}/store/detail/"+resp[i].itemNo);
					templateContent.find(".item-image").attr("style", "background-image: url('${pageContext.request.contextPath}/item/thumbnail?itemNo="+resp[i].itemNo+"')");
					templateContent.find(".name").text(resp[i].itemName);
					if(!resp[i].discountRate) {
						templateContent.find(".discount").remove();
						templateContent.find(".original-price").remove();
					} else {
						templateContent.find(".discount").text(resp[i].discountRate+"%");
						templateContent.find(".original-price").text(resp[i].discountRate/100*resp[i].itemPrice);
					}
					templateContent.find(".price").text(resp[i].itemPrice.toLocaleString()+"원");
					if(!resp[i].reviewCount) {
						templateContent.find(".review").remove();					
					} else {
						templateContent.find(".rate").text(resp[i].reviewRate);
						templateContent.find(".count").text(resp[i].reviewCount);
					}
					clonedTemplate.html(templateContent.prop('outerHTML'));
					result.append(clonedTemplate.html());
				}
			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
});
</script>
<div class="home-promotion">
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
	  <div class="carousel-indicators">
	    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
	    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
	  </div>
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="//cdn.ggumim.co.kr/original/20220110182901x6tgiEp4nl.png" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="//cdn.ggumim.co.kr/original/20220107162726J2Wc0hIG4S.png" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="//cdn.ggumim.co.kr/original/20211231153243B08RkoHK68.png" class="d-block w-100" alt="...">
	    </div>
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
</div>


<div class="container-zipggu store">
	<div class="commerce-title">
        <h2>실시간 베스트
            <a href="/furniture/more/c2/?type=hour" style="float: right; font-weight: 500; font-size: 16px; margin-top: 10px; cursor: pointer;">
                전체보기 &gt;
            </a>
        </h2>
    </div>
	
	<div class="furniture-item-group-3 preact-furniture-list">

	</div>
	<button type="button" class="btn btn-primary more-btn">더보기</button>
</div>

<template id="item-template">
	<div class="col-xs-6 col-md-3 item">
		<a href="#">
			<div class="item-image" style="background-image: url('http://placehold.it/500x500')">
			</div>
			<div class="item-desc">
				<div class="name">제품명</div>
          		<div class="price-info">
          			<span class="discount">할인율</span>
          			<span class="price">할인가</span>
          		</div>
          		<div class="original-price">
            		<span>정상가</span>
          		</div>
          		<div class="review">
            		<img
             	 		src="//cdn.ggumim.co.kr/storage/20201124131919ibuV8ryVUZ.png"
              			alt=""
            		/><span class="rate">별점</span>
            		<span class="count">(리뷰개수)</span>
          		</div>
          	</div>
		</a>
	</div>
</template>










<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


<%-- 
        <c:forEach var="storeVO" items="${storeVOList}">
        	<div class="col-xs-6 col-md-3 item">
      			<a href="${root}/store/detail/${storeVO.itemNo}">
      				<c:choose>
      					<c:when test="${storeVO.itemFile != null}">
      						<div class="item-image" style="background-image: url('')">
      						</div>
      					</c:when>
      					<c:otherwise>
        					<div class="item-image" style="background-image: url('data:image/png;base64,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');">
          					</div>
      					</c:otherwise>
      				</c:choose>
        			<div class="item-desc">
          				<div class="name">제품명</div>
          				<div class="price-info">
          					<c:if test="${storeVO.discountRate != null}">
            					<span class="discount">${storeVO.discountRate}</span>
            				</c:if>
            				<span class="price">가격<span class="price-unit">원</span></span>
          				</div>
          				<c:if test="${storeVO.discountRate != null}">
          					<div class="price-original">
            					<span> </span>
            					<span>41,900</span>
          					</div>
          				</c:if>
          				<c:if test="${storeVO.reviewCount > 1}">
          					<div class="review">
            					<img
             	 					src="//cdn.ggumim.co.kr/storage/20201124131919ibuV8ryVUZ.png"
              						alt=""
            					/><span class="rate">${storeVO.reviewRate}</span>
            					<span class="count">(${storeVO.reviewCount})</span>
          					</div>
          				</c:if>
        			</div>
      			</a>
    		</div>
        </c:forEach>
<template class="item-template">
	<div class="col-xs-6 col-md-3 item">
		<a href="${root}/store/detail/${storeVO.itemNo}">
			<div class="item-image" style="background-image: url('')">
			</div>
			<div class="item-desc">
				<div class="name">제품명</div>
          		<div class="price-info">
          			<span class="price">가격<span class="price-unit">원</span></span>
          		</div>
          		<div class="review">
            		<img
             	 		src="//cdn.ggumim.co.kr/storage/20201124131919ibuV8ryVUZ.png"
              			alt=""
            		/><span class="rate">${storeVO.reviewRate}</span>
            		<span class="count">(${storeVO.reviewCount})</span>
          		</div>
          	</div>
		</a>
	</div>
</template>
--%>