<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .card{
      display: flex;
      background-color: rgba(169, 169, 169, 0.164);
      width:100%;
      padding:3%
      
    }
    .number{
      display: flex;
      width:30%;
      justify-content: center;
    }
    .member-img{
      border-radius: 50%;
      width:50px;
      height:50px;
    }
    .star-rating {
      display: flex;
      flex-direction: row-reverse;
      font-size: 1.5rem;
      line-height: 2.5rem;
      justify-content: space-around;
      padding: 0 0.2em;
      text-align: center;
      width: 5em;
    }

    
    .star-rating input {
      display: none;
    }
    

    .star-rating label {
      -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
      -webkit-text-stroke-width: 2.3px;
      -webkit-text-stroke-color: #2b2a29;
      cursor: pointer;
    }
    
    .star-rating :checked ~ label {
      -webkit-text-fill-color: gold;
    }
    
    .star-rating label:hover,
    .star-rating label:hover ~ label {
      -webkit-text-fill-color: #fff58c;
    }
    .nick img {
  		transition: all 0.2s linear;
	}
	.nick:hover img {
	  	transform: scale(1.0);
	}
	 .star-ratingUpdate {
      display: flex;
      flex-direction: row-reverse;
      font-size: 1.5rem;
      line-height: 2.5rem;
      justify-content: space-around;
      padding: 0 0.2em;
      text-align: center;
      width: 5em;
    }
    
    .star-ratingUpdate input {
      display: none;
    }
    
    .star-ratingUpdate label {
      -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
      -webkit-text-stroke-width: 2.3px;
      -webkit-text-stroke-color: #2b2a29;
      cursor: pointer;
    }
    
    .star-ratingUpdate :checked ~ label {
      -webkit-text-fill-color: gold;
    }
    
    .star-ratingUpdate label:hover,
    .star-ratingUpdate label:hover ~ label {
      -webkit-text-fill-color: #fff58c;
    }

    .star-ratingDetail #point, .star-ratingDetail #point ~ label {
      -webkit-text-fill-color: gold;
    }
    .star-ratingDetail {
      display: flex;
      flex-direction: row-reverse;
      font-size: 1.5rem;
      line-height: 2.5rem;
      justify-content: space-around;
      padding: 0 0.2em;
      text-align: center;
      width: 5em;
    }
    .star-ratingDetail label {
      -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
      -webkit-text-stroke-width: 2.3px;
      -webkit-text-stroke-color: #2b2a29;
    }
    
    .review-img{
    	width:380px;
    	height:100%;
    }
</style>
<script>
	$(function(){
		$(document).on("click", ".remove-btn", function(){
			$(this).parent().remove();	
		});
		
		$(".option-plus").on("click", function(e){
			
	   		var clonedTemplate = $("#option-template").clone();
	   		var templateContent = $(clonedTemplate.html());
	   		
			var check = false;
			//선택한 옵션 묶음 div
			var div = $("<div>");
			//선택한 옵션 번호 배열
			var options = [];
			$(".itemOptionNo").each(function(index, option){
				var optionVal = $(option).val();
				var optionName = $(option).find("option:selected").text();
				var optionRequired = $(option).data("required");
				if(optionRequired == 1 && optionVal == null){
					check = true;
					return false; //break
				} else if(optionVal == null){
					return true;  //continue
				}
				if(index == 0){
					var button = $("<button>").text("x").addClass("remove-btn").css("width","30px").css("margin-left","auto");
					templateContent.append(button);
					var quantity = "<input type='number' class='quantity' min='1' max='999' value='1'>"
					div.append(quantity);
				}
				div.append(" / ");
			   	var optionData = "<span data-option-no="+optionVal+">"+optionName+"</span>";
			   	div.append(optionData);
			   	$(option).find("option:eq(0)").prop("selected", true);
			   	//중복 옵션을 판단하기 위한 배열
				options.push(parseInt(optionVal));
			});
			if(checkOption(options)){
				alert("중복된 옵션입니다");
				return;
			}
			if(check){
				alert("옵션을 선택해주세요");
				return;
			}
			templateContent.append(div);
	   		clonedTemplate.html(templateContent.prop('outerHTML'));
	   		var selectedItems = $(".selected-items");
	   		selectedItems.append(clonedTemplate.html());
		});
	});
	
	function checkOption(options) {
		var isExist = false;
		$(".selected-item").each(function(index1, item){
			var existOptions = [];
			$(item).find("span").each(function(index2, option){
				existOptions.push($(option).data("option-no"));
			});
			if(JSON.stringify(existOptions) == JSON.stringify(options)) {
				isExist = true;
				return false;
			}
		});
		return isExist;
	}
	
	$(function(){
		$(".cart-btn").click(function(e){
	
			var check = false;
			var buyType = $(this).data("buy-type");
			
			console.log(check);
			console.log(buyType);
		
			$(".quantity").each(function(index, quantity){
				var quantityVal = $(".quantity").val();
				if(!quantityVal || quantityVal == 0){
					e.preventDefault();
					check = true;
											
					return false;  //break
			
				}
			});
			if(check){
				alert("수량을 입력해주세요");
				return;
			}
			var result = $(".result");
			$(".selected-item").each(function(index1, item){
				var quantityVal = $(item).find("input").val();
				var quantity = "<input type='hidden' name='optionList["+index1+"].quantity' value='"+quantityVal+"'>"
				result.append(quantity);
				$(item).find("span").each(function(index2, option){
					var optionVal = $(option).data("option-no");
					var option = "<input type='hidden' name='optionList["+index1+"].noList["+index2+"].itemOptionNo' value='"+optionVal+"'>"
					result.append(option);	
				});
			});
			
			console.log(result.find("input[type=hidden]"));
			
			if(result.find("input[type=hidden]").length == 0){
				
				console.log("111111111111111111");
				alert("상품 옵션을 선택하고 추가를 눌러주세요");
				return false;
			}
			
			$("input[name=buyType]").val(buyType);
			
			$(".cart").submit();
		});
	});
	

	
	
	

// 	if(index == 0){
// 		var quantity = "<input type='number' class='quantity' name='optionList["+count+"].quantity' min='1' max='999' value='1'>"
// 		templateContent.append(quantity);
// 	}
//    	var optionData = "<input type='text' name='optionList["+count+"].noList["+index+"].itemOptionNo' value='"+optionVal+"'>";
//    	templateContent.append(optionData);
//    	console.log(input);

  
	//select 선택시 나오는 태그
// 	 $(function(){
// 	      $(".itemOptionNo").on("input", function(){
	        
// 	        var selectedItem = $(this).val();

// 	          var form = $("<div class='card center container-center'>");
// 	            form.append("<input type='number' class='number' name='quantity'>")
// 	            form.append(selectedItem)
// 	            console.log(form);
// 	            var info = $(".result");
// 	            info.html(form);
// 	      });
// 	    });
  
</script>


<div class="container-zipggu mt-3">

      <div class="container container-left">
        <div class="row">
        
          <!--이미지 시작-->
          <div class="col-md-7">
            <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
              <div class="carousel-inner">

                <div class="carousel-item active">
                  <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${itemNo}" class="d-block w-100" alt="...">
                </div>
                
                <div class="carousel-item">
                  <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${itemNo}" class="d-block w-100" alt="...">
                </div>
                
              </div>

              <!--좌 우 버튼-->
              <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
          </div>

          <div class="col-md-5">
            <!-- 상품명 -->
            <div class="mt-1">
              <label>상품명</label>
              <p class="h5"><strong>${itemDto.itemName}</strong></p>
            </div>

            <!-- 가격 -->
            <div class="mt-3">
              <label>가격</label>
              <p><strong>${itemDto.getItemPricetoString()} 원</strong></p>
            </div>

            <div class="mt-5"></div>

            <!-- 상품 옵션 -->
            <div class="mt-2">
              <c:forEach var="map" items="${itemOptionGroupMap}" varStatus="status">
				<label>${status.count}번째 상품옵션</label>
				<select class="itemOptionNo form-select form-select-sm mb-3" aria-label=".form-select-lg example" data-required="${map.value[0].itemOptionRequired}">
					<option value="" disabled selected hidden>${map.key}</option>
					<c:forEach var="optionDto" items="${map.value}">
					<option value="${optionDto.itemOptionNo}" data-price="${optionDto.itemOptionPrice}">
						${optionDto.getOptionAndPrice()}
					</option>
					</c:forEach>
				</select>
			  </c:forEach>
            </div>
            
            <!-- 옵션 추가하는 버튼 -->
            <button class="option-plus btn btn-primary">추가</button>
			
			<!-- 선택된 옵션 index 숨겨서 보관 -->
            <div class="selected-items mt-3">
			</div>
			<form action="${root}/cart/insert" method="post" class="cart">
				<div class="mt-3">
					<input type="hidden" name="itemNo" value="${itemDto.itemNo}">
					<input type="hidden" name="buyType" value="">
					<div class="result"></div>
				</div>
			</form>
			
            <!-- 버튼 -->
            <div class="mt-3 position-relative">
              <div class="col-4">
                <button type="button" data-buy-type="cart" class="cart-btn btn btn-primary position-absolute bottom-40 start-0 w-50 p-2">장바구니</button>
              </div>
              <div class="col-4">
                <button type="button" data-buy-type="buy" class="cart-btn btn btn-secondary position-absolute bottom-40 end-0 w-50 p-2">구매하기</button>
              </div>
            </div>
          </div>
        </div>
      </div>

     
     <div class="container m-3"></div>
     <div class="container m-3"></div>

    
    <hr>
	<div class="center">
	<c:forEach var="itemFileDto" items="${itemFileDtoList}">
		<img src="${pageContext.request.contextPath}/item/image?itemFileNo=${itemFileDto.itemFileNo}" style="width:70%"><br><br><br>
	</c:forEach>
	</div>
	
	
      <hr class="featurette-divider">

      <!-- 상품 이미지 상세 이미지 마지막 -->

      
      <!--리뷰 시작-->
      <div class="center mt-5">
        <h2>상품 리뷰</h2>
      </div>
      <hr>

      <!--리뷰 쓰기 버튼-->
      <div class="center">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
          리뷰 작성
        </button>

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">

                <!--모달 제목-->
                <h5 class="modal-title" id="exampleModalCenteredScrollableTitle">리뷰 작성</h5>
				

              <!--모달 텍스트 적는 공간-->
                <!--모달 닫기 버튼-->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              
              <!-- review form 시작 -->
              <form action="${root }/review/insert" method="post" enctype="multipart/form-data">
				<div class="mt-3">
					<label class="form-label left">구매 내역</label>
					<select name="orderDetailNo" style="width: 90%;">
						<c:forEach var="orderList" items="${list }">
						<option value="${orderList.orderDetailNo }">${orderList.orderName }</option>
	                	
						</c:forEach>
					</select>
				</div>
              	<input type="hidden" name="itemNo" value="${itemDto.itemNo }"> 
                <!--리뷰 작성시 보낼 별점-->
                <div class="star-rating space-x-4 mx-auto mt-3">
                  <input type="radio" id="5-stars" name="reviewPoint" value="5" v-model="ratings" checked/>
                  <label for="5-stars" class="star pr-4">★</label>
                  <input type="radio" id="4-stars" name="reviewPoint" value="4" v-model="ratings"/>
                  <label for="4-stars" class="star">★</label>
                  <input type="radio" id="3-stars" name="reviewPoint" value="3" v-model="ratings"/>
                  <label for="3-stars" class="star">★</label>
                  <input type="radio" id="2-stars" name="reviewPoint" value="2" v-model="ratings"/>
                  <label for="2-stars" class="star">★</label>
                  <input type="radio" id="1-stars" name="reviewPoint" value="1" v-model="ratings" />
                  <label for="1-stars" class="star">★</label>
                </div>
                
                <!--리뷰 내용-->
                <div class="input-group ms-3 mt-5"  style="width: 90%;">
                  <span class="input-group-text">리뷰내용</span>
                  <textarea class="form-control" name="reviewDetail" aria-label="With textarea"></textarea>
                </div>

                <!--리뷰 첨부파일-->
                <div class="mb-3 ms-3 mt-3">
                  <label for="formFile" class="form-label left">첨부파일</label>
                  <input class="form-control" name="attach" type="file" id="formFile" style="width: 90%;">
                </div>


                <!--버튼-->
                <div class="modal-footer">
                  <input type="submit" value="등록" class="btn btn-primary">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div class="m-5"></div>

<c:forEach var="reviewListVO" items="${reviewListVO }">
	<hr>
      <div class="row mt-3">

        <!--작성 회원 프로필사진 및 닉네임-->
        <div class="nick col-auto me-auto">
            <img src="${root }/member/profile?memberNo=${reviewListVO.memberNo}" class="member-img d-block">
            <span>${reviewListVO.memberNickname }</span>
        </div>

        <!--별점 리뷰-->
          <div class="col-auto">
            <div class="star-ratingDetail space-x-4 mx-auto">
              <label for="5-stars" ${reviewListVO.reviewPoint == 5 ? "id='point'" : "" } class="star pr-4">★</label>
              <label for="4-stars" ${reviewListVO.reviewPoint == 4 ? "id='point'" : "" } class="star">★</label>
              <label for="3-stars" ${reviewListVO.reviewPoint == 3 ? "id='point'" : "" } class="star">★</label>
              <label for="2-stars" ${reviewListVO.reviewPoint == 2 ? "id='point'" : "" } class="star">★</label>
              <label for="1-stars" ${reviewListVO.reviewPoint == 1 ? "id='point'" : "" } class="star">★</label>
            </div>
          </div>
      </div>

      <!--리뷰 사진-->
      <div class="center mt-3">
        <img src="${pageContext.request.contextPath}/review/file?reviewNo=${reviewListVO.reviewNo}" class="review-img">
      </div>

      <!--리뷰 내용-->
      <div class="row mt-3">
        <!--나중에는 db에서 값을 불러오기때문에 pre로 변경-->
        <p>
          ${reviewListVO.reviewDetail }
        </p>
       </div>
        <div class="col-auto">
        	
	 			<c:if test="${loginNo == reviewListVO.memberNo }">
	        		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updatemodal${reviewListVO.orderDetailNo}">수정</button>
	        		<button type="button" class="btn btn-secondary"><a href="${root }/review/delete?reviewNo=${reviewListVO.reviewNo}&itemNo=${reviewListVO.itemNo}">삭제</a></button>
	        	</c:if>
       
        </div>
        
            <!-- 수정 Modal -->
        <div class="modal fade" id="updatemodal${reviewListVO.orderDetailNo}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="0" aria-labelledby="staticBackdropLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">

                <!--모달 제목-->
                <h5 class="modal-title" id="exampleModalCenteredScrollableTitle">리뷰 작성</h5>
				

              <!--모달 텍스트 적는 공간-->
                <!--모달 닫기 버튼-->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              
              <!-- review form 시작 -->
              <form action="${root }/review/edit" method="post" enctype="multipart/form-data">
				<div class="mt-3" style="text-align:center">
					<label class="form-label center">구매 내역 : </label>
					
					

						<input type="hidden" name="orderDetailNo" value="${reviewListVO.orderDetailNo }">
						<input type="hidden" name="reviewNo" value="${reviewListVO.reviewNo }">
						${reviewListVO.orderName }
	 
			
				</div>
              	<input type="hidden" name="itemNo" value="${itemDto.itemNo }"> 
                <!--리뷰 작성시 보낼 별점-->
                <div class="star-ratingUpdate space-x-4 mx-auto mt-3">
                  <input type="radio" id="5-starss-${reviewListVO.orderDetailNo}" name="reviewPoint" value="5" v-model="ratings" ${reviewListVO.reviewPoint == 5 ? "checked" : "" }/>
                  <label for="5-starss-${reviewListVO.orderDetailNo}" class="star pr-4">★</label>
                  <input type="radio" id="4-starss-${reviewListVO.orderDetailNo}" name="reviewPoint" value="4" v-model="ratings" ${reviewListVO.reviewPoint == 4 ? "checked" : "" }/>
                  <label for="4-starss-${reviewListVO.orderDetailNo}" class="star">★</label>
                  <input type="radio" id="3-starss-${reviewListVO.orderDetailNo}" name="reviewPoint" value="3" v-model="ratings" ${reviewListVO.reviewPoint == 3 ? "checked" : "" }/>
                  <label for="3-starss-${reviewListVO.orderDetailNo}" class="star">★</label>
                  <input type="radio" id="2-starss-${reviewListVO.orderDetailNo}" name="reviewPoint" value="2" v-model="ratings" ${reviewListVO.reviewPoint == 2 ? "checked" : "" }/>
                  <label for="2-starss-${reviewListVO.orderDetailNo}" class="star">★</label>
                  <input type="radio" id="1-starss-${reviewListVO.orderDetailNo}" name="reviewPoint" value="1" v-model="ratings" ${reviewListVO.reviewPoint == 1 ? "checked" : "" }/>
                  <label for="1-starss-${reviewListVO.orderDetailNo}" class="star">★</label>
                </div>
                
                <!--리뷰 내용-->
                <div class="input-group ms-3 mt-5"  style="width: 90%;">
                  <span class="input-group-text">리뷰 내용</span>
                  <textarea class="form-control" name="reviewDetail" aria-label="With textarea">${reviewListVO.reviewDetail }</textarea>
                </div>

                <!--리뷰 첨부파일-->
                <div class="mb-3 ms-3 mt-3">
                  <label for="formFile" class="form-label left">첨부파일</label>
                  <input class="form-control" name="attach" type="file" id="formFile" style="width: 90%;">
                </div>


                <!--버튼-->
                <div class="modal-footer">
                  <input type="submit" value="등록" class="btn btn-primary">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
              </form>
            </div>
          </div>
        </div>
</c:forEach>
      </div>
    <!-- /.container -->
    
    
  


<template id="option-template">
	<div class="selected-item card center container-center mt-3">
	</div>
</template>








<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>