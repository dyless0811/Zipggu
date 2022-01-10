<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
      <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"
      rel="stylesheet"
    />
        <style>
      .container-zipggu {
        width: 1000px;
        margin: auto;
      }
      .float-div {
        width: 100%;
        height: 500px;
        border: 1px solid #003458;
      }
      .float-div.left {
        overflow: scroll;
        width: 40%;
        float: left;
        box-sizing: border-box;
        background: whitesmoke;
      }
      .float-div.right {
        width: 60%;
        float: right;
        box-sizing: border-box;
        background: #ece6cc;
      }
      .right-content {
        width: 70%;
        margin: auto;
      }
      .cate-box {
        max-width: 100%;
        border: 1px solid lightgray;
        padding: 20px;
      }
      .cate-box ul {
        padding-left: 25px;
      }
      .cate-box li {
        margin: 8px 0;
      }
      .cate-box a {
        color: gray;
      }
      .cate-box i {
        color: royalblue;
      }
      .cate-parent,
      .cate,
      .btn-box {
        display: flex;
        justify-content: space-between;
      }
      .cate-child {
        display: none;
      }
      .modify-btn,
      .delete-btn,
      .cate-btn,
      .add-btn,
      .remove-btn {
        padding: 0 5px;
      }
      .cate-parent.color {
        background: pink;
      }
      .cate-btn.color {
        background: hotpink;
      }
    </style>
<script>
$(function(){
	var result = $(".furniture-item-group-3")

	var page = 1;
	var size = 24;
	var url = new URL(location.href);
	var urlParams = url.searchParams;
	var categoryNo = 0;
	if(urlParams.get("categoryNo")){
		categoryNo = urlParams.get("categoryNo");
	}
	var categoryList = [];
	
	
	var itemName = urlParams.get("itemName");
	
	$(document).on("click",".categoryBtn",function(){
		var categoryNo = $(this).data("category-no");
		if(categoryNo == 0) {
			urlParams.delete("categoryNo");
		} else {
			urlParams.set("categoryNo", categoryNo);		
		}
		location.href=url.href;
	});
	
	$(".searchForm").keypress(function(event){
		if(event.keyCode == 13){
			urlParams.set("itemName", $(this).val());
			location.href=url.href;
		}
	});
	
// 	$(".searchBtn").click(function(){
// 		urlParams.set("itemName", $(".searchForm").val());
// 		location.href=url.href;
// 	});
	
	$(".more-btn").click(function(){
		
		loadItem(page, size);
		page++;
	});
	
	loadData();
	create_btn();
	
	$(".more-btn").click();
	
	function loadItem(page, size){
		$.ajax({
			url : "${pageContext.request.contextPath}/store/data/list",
			type : "get",
			data : {
				page : page,
				size : size,
				categoryNo : categoryNo,
				categoryList : categoryList,
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


	
	function loadData(){
		$(".category-ul").empty();
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/data/category/list",
			type : "post",
			data : {
			},
			async: false,
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
					var ul = $(".category-ul");
					var category = $("<li>")
					.append($("<div>")
						.addClass("cate")
						.append($("<a>")
							.addClass("categoryBtn")
							.attr("data-category-no", 0)
							.attr("href","#")
							.text("전체카테고리")
						)
					);
					
					ul.append(category);
					draw_category(resp, ul);
					
					if(categoryNo != 0) {
						$(".categoryBtn[data-category-no="+categoryNo+"]").parent().parent().find(".categoryBtn").each(function(){
							categoryList.push($(this).data("category-no"));
						})						
					}
				

			},
			error:function(e){
				console.log("실패", e);
			}
		});
	}
	
	function draw_category(list, ul) {
		for (let categoryVO of list) {
			if(categoryVO.list != null && categoryVO.list.length > 0) {
				draw_category(categoryVO.list, draw_parent(categoryVO, ul));			
			} else {
				draw_child(categoryVO, ul);		
			}
		}
	}
	
	function draw_parent(categoryVO, ul) {
		var category = $("<li>")
		.append($("<div>")
			.addClass("cate-parent")
			.append($("<a>")
				.addClass("categoryBtn")
				.attr("data-category-no", categoryVO.categoryNo)
				.attr("data-category-name", categoryVO.categoryName)
				.attr("href","#")
				.text(categoryVO.categoryName)
			)
			.append($("<div>")
				.addClass("btn-box")
			)
		)
		.append($("<ul>")
			.addClass("cate-child")
			.addClass("cate-no-"+categoryVO.categoryNo)
		);
		
		ul.append(category);
		
		ul = $(".cate-no-"+categoryVO.categoryNo);
		
		return ul;
	}
	
	function draw_child(categoryVO, ul) {
		var category = $("<li>")
		.append($("<div>")
			.addClass("cate")
			.append($("<a>")
				.addClass("categoryBtn")
				.attr("data-category-no", categoryVO.categoryNo)
				.attr("data-category-name", categoryVO.categoryName)
				.attr("href","#")
				.text(categoryVO.categoryName)
			)
		);

		ul.append(category);
	}
    function create_btn() {
        //화살표
        var cateBtn = $("<a>")
          .addClass("cate-btn")
          .append($("<i>").addClass("fas fa-caret-down"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn-box").append(cateBtn);
    }
});    	
	
	

</script>
   <div class="container mt-5">
        <div class="row">
            <!--카테고리 시작-->
            <div class="col-3">
	                <div class="cate-box">
	 			<ul class="category-ul">
	 			  <li>
	 			    <div class="cate">
	                  <a href="#">전체카테고리</a>
	                  <div class="btn4-box" data-category-no="0"></div>
	                </div>
	 			  </li>
	 			</ul>
	          </div>
            </div>


            <!--상품 내용 시작-->
            <div class="col-9">

                <div class="d-flex">
                    <input class="form-control me-sm-2 searchForm" type="text" placeholder="검색어를 입력해 주세요." value="${param.itemName}">
                </div>

                <div class="commerce-title">
	             	<h2>
			        	<span>
			        		<c:choose>
			        			<c:when test="${param.itemName == null}">
			        				상품 목록
			        			</c:when>
			        			<c:otherwise>
			        				'${param.itemName}' 검색 결과
			        			</c:otherwise>
			        		</c:choose>
			        	</span>
			            <a href="${pageContext.request.contextPath}/store/list" style="float: right; font-weight: 500; font-size: 16px; margin-top: 10px; cursor: pointer;">
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