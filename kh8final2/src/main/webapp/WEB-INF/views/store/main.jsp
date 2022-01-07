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
					templateContent.find(".price").text(resp[i].itemPrice+"원");
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
    <div class="star-monday-list monday-slick slick-initialized slick-slider slick-dotted" style=""><button class="slick-prev slick-arrow" aria-label="Previous" type="button" style="">Previous</button><div class="slick-list draggable"><div class="slick-track" style="opacity: 1; width: 13000px; transform: translate3d(-4000px, 0px, 0px);"><div class="slick-slide slick-cloned" data-slick-index="-1" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/1291" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/202112171457583CoG3ReM19.png" style="width: 100%;">
            </a></div></div><div class="slick-slide" data-slick-index="0" aria-hidden="true" role="tabpanel" id="slick-slide00" style="width: 1000px;" aria-describedby="slick-slide-control00" tabindex="-1"><div><a href="/promotion/view/346" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211223165233MGRnGRTRgD.png" style="width: 100%;">
            </a></div></div><div class="slick-slide" data-slick-index="1" aria-hidden="true" role="tabpanel" id="slick-slide01" style="width: 1000px;" aria-describedby="slick-slide-control01" tabindex="-1"><div><a href="/promotion/view/987" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211223142301mkO5gb09LW.png" style="width: 100%;">
            </a></div></div><div class="slick-slide" data-slick-index="2" aria-hidden="true" role="tabpanel" id="slick-slide02" style="width: 1000px;" aria-describedby="slick-slide-control02" tabindex="-1"><div><a href="/promotion/view/1292" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211217180649R2B6jWyCUc.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-current slick-active" data-slick-index="3" aria-hidden="false" role="tabpanel" id="slick-slide03" style="width: 1000px;" aria-describedby="slick-slide-control03"><div><a href="/promotion/view/1290" style="width: 100%; display: inline-block;" tabindex="0">
                <img src="//cdn.ggumim.co.kr/original/20211211163639KO4vIIxFBs.png" style="width: 100%;">
            </a></div></div><div class="slick-slide" data-slick-index="4" aria-hidden="true" role="tabpanel" id="slick-slide04" style="width: 1000px;" aria-describedby="slick-slide-control04" tabindex="-1"><div><a href="/promotion/view/1285" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211211161556JA4Nu06WbE.png" style="width: 100%;">
            </a></div></div><div class="slick-slide" data-slick-index="5" aria-hidden="true" role="tabpanel" id="slick-slide05" style="width: 1000px;" aria-describedby="slick-slide-control05" tabindex="-1"><div><a href="/promotion/view/1291" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/202112171457583CoG3ReM19.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="6" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/346" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211223165233MGRnGRTRgD.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="7" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/987" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211223142301mkO5gb09LW.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="8" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/1292" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211217180649R2B6jWyCUc.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="9" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/1290" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211211163639KO4vIIxFBs.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="10" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/1285" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/20211211161556JA4Nu06WbE.png" style="width: 100%;">
            </a></div></div><div class="slick-slide slick-cloned" data-slick-index="11" id="" aria-hidden="true" tabindex="-1" style="width: 1000px;"><div><a href="/promotion/view/1291" style="width: 100%; display: inline-block;" tabindex="-1">
                <img src="//cdn.ggumim.co.kr/original/202112171457583CoG3ReM19.png" style="width: 100%;">
            </a></div></div></div></div><button class="slick-next slick-arrow" aria-label="Next" type="button" style="">Next</button><ul class="slick-dots" style="" role="tablist"><li class="" role="presentation"><button type="button" role="tab" id="slick-slide-control00" aria-controls="slick-slide00" aria-label="1 of 6" tabindex="-1">1</button></li><li role="presentation" class=""><button type="button" role="tab" id="slick-slide-control01" aria-controls="slick-slide01" aria-label="2 of 6" tabindex="-1">2</button></li><li role="presentation" class=""><button type="button" role="tab" id="slick-slide-control02" aria-controls="slick-slide02" aria-label="3 of 6" tabindex="-1">3</button></li><li role="presentation" class="slick-active"><button type="button" role="tab" id="slick-slide-control03" aria-controls="slick-slide03" aria-label="4 of 6" tabindex="0" aria-selected="true">4</button></li><li role="presentation" class=""><button type="button" role="tab" id="slick-slide-control04" aria-controls="slick-slide04" aria-label="5 of 6" tabindex="-1">5</button></li><li role="presentation" class=""><button type="button" role="tab" id="slick-slide-control05" aria-controls="slick-slide05" aria-label="6 of 6" tabindex="-1">6</button></li></ul></div>
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







    <div class="container-zipggu">
        <div class="row">

            <!--카테고리 시작-->
            <div class="col-2">
                <div class="accordion accordion-flush" id="accordionFlushExample">
                    <div class="accordion-item">

                        <!--큰 카테고리 제목-->
                        <h2 class="accordion-header" id="flush-headingOne">
                            <!--큰 카테고리 (반복 시작)-->
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                            침대
                            </button>
                        </h2>

                        <!--작은 카테고리-->
                        <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                            <!--작은 카테고리 제목-->
                            <div class="accordion-body">싱글침대</div>
                        </div>

                        
                    </div>
                </div>
            </div>


            <!--상품 내용 시작-->
            <div class="col-9">
                
                <form class="d-flex">
                    <input class="form-control me-sm-2" type="text" placeholder="Search">
                    <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
                  </form>

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
        </div>

        
    </div>
    </div>














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