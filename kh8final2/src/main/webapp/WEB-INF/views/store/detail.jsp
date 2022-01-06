<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<div class="container-zipggu">
	<h1>아이템 디테일</h1>
	
	thumbnail = <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${itemNo}" style="max-width:300px"><Br>
	
	itemNo = ${itemDto.itemNo} <br>
	categoryNo = ${itemDto.categoryNo} <br>
	itemName = ${itemDto.itemName} <br>
	itemPrice = ${itemDto.itemPrice} <br>
	itemShippingType = ${itemDto.itemShippingType} <br>
	
	image = 
	<c:forEach var="itemFileDto" items="${itemFileDtoList}">
		<img src="${pageContext.request.contextPath}/item/image?itemFileNo=${itemFileDto.itemFileNo}" style="max-width:300px"><br>
	</c:forEach>
	

	<button class="option-plus btn btn-primary">추가</button>
	<br><br>
	<button class="cart-btn btn btn-primary" data-buy-type="cart">장바구니 추가</button>
	<button class="cart-btn btn btn-primary" data-buy-type="payment">구매하기</button>
</div>


<template id="option-template">
	<div class="selected-item card center container-center">
	</div>
</template>








<hr>
<h1>상세페이지 디자인 추가 구역</h1>

<div class="container-ziqggu mt-3">

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
            <div class="mt-3">
              <label>상품명</label>
              <p class="h4"><strong>◆인기절정◆누적판매 3만set 돌파! LED 수납3종 침대 SS/Q/K 3colors</strong></p>
            </div>

            <!-- 가격 -->
            <div class="mt-5">
              <label>가격</label>
              <p><strong>100,000,000,000 원</strong></p>
            </div>

            <div class="mt-5"></div>

            <!-- 상품 옵션 -->
            <div class="mt-5">
              <c:forEach var="map" items="${itemOptionGroupMap}" varStatus="status">
				<label>${status.count}번째 상품옵션</label>
				<select class="itemOptionNo form-select form-select-sm mb-3" aria-label=".form-select-lg example" data-required="${map.value[0].itemOptionRequired}">
					<option value="" disabled selected hidden>${map.key}</option>
					<c:forEach var="optionDto" items="${map.value}">
					<option value="${optionDto.itemOptionNo}" data-price="${optionDto.itemOptionPrice}">${optionDto.itemOptionDetail}</option>
					</c:forEach>
				</select>
			  </c:forEach>
            </div>
            <button class="option-plus btn btn-primary">추가</button>

            <div class="selected-items">
			</div>
			<form action="${root }/zipggu/cart/insert" method="post" class="cart">
				<div>
					<input type="hidden" name="itemNo" value="${itemDto.itemNo}">
					<div class="result"></div>
				</div>
			</form>
            <!-- 버튼 -->
            <div class="mt-5 position-relative">
              <div class="col-4">
                <button type="button" class="cart-btn btn btn-primary position-absolute bottom-40 start-0 w-50 p-2">장바구니</button>
              </div>
              <div class="col-4">
                <button type="button" class="btn btn-secondary position-absolute bottom-40 end-0 w-50 p-2">구매하기</button>
              </div>
            </div>
          </div>
        </div>
      </div>

     

      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It’ll blow your mind.</span>
          </h2>
          <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose
            here.
          </p>
        </div>
        <div class="col-md-5">

          <img src="http://placeimg.com/500/500/tech" class="d-block w-100" alt="...">

        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7 order-md-2">
          <h2 class="featurette-heading">Oh yeah, it’s that good. <span class="text-muted">See for yourself.</span></h2>
          <p class="lead">Another featurette? Of course. More placeholder content here to give you an idea of how this
            layout would work with some actual real-world content in place.</p>
        </div>
        <div class="col-md-5 order-md-1">

          <img src="http://placeimg.com/500/500/tech" class="d-block w-100" alt="...">

        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">And lastly, this one. <span class="text-muted">Checkmate.</span></h2>
          <p class="lead">And yes, this is the last block of representative placeholder content. Again, not really
            intended to be actually read, simply here to give you a better view of what this would look like with some
            actual content. Your content.</p>
        </div>
        <div class="col-md-5">

          <img src="http://placeimg.com/500/500/tech" class="d-block w-100" alt="...">

        </div>
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

                

                <!--모달 닫기 버튼-->
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <!--모달 텍스트 적는 공간-->
              <form>

                <!--리뷰 작성시 보낼 별점-->
                <div class="star-rating space-x-4 mx-auto mt-3">
                  <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
                  <label for="5-stars" class="star pr-4">★</label>
                  <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
                  <label for="4-stars" class="star">★</label>
                  <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
                  <label for="3-stars" class="star">★</label>
                  <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
                  <label for="2-stars" class="star">★</label>
                  <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                  <label for="1-star" class="star">★</label>
                </div>
                
                <!--리뷰 내용-->
                <div class="input-group ms-3 mt-5"  style="width: 90%;">
                  <span class="input-group-text">리뷰내용</span>
                  <textarea class="form-control" aria-label="With textarea"></textarea>
                </div>

                <!--리뷰 첨부파일-->
                <div class="mb-3 ms-3 mt-3">
                  <label for="formFile" class="form-label left">첨부파일</label>
                  <input class="form-control" type="file" id="formFile" style="width: 90%;">
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
      <!--모달 스크립트-->
      <script>
        var myModal = document.getElementById('myModal')
        var myInput = document.getElementById('myInput')

        myModal.addEventListener('shown.bs.modal', function () {
          myInput.focus()
        })
      </script>

      <div class="m-5"></div>

      <div class="row">

        <!--작성 회원 프로필사진 및 닉네임-->
        <div class="col-auto me-auto">
            <img src="http://placeimg.com/500/500/people" class="member-img d-block w-100">
            <span>닉네임</span>
        </div>

        <!--별점 리뷰-->
          <div class="col-auto">
            <div class="star-rating space-x-4 mx-auto">
              <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"/>
              <label for="5-stars" class="star pr-4">★</label>
              <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"/>
              <label for="4-stars" class="star">★</label>
              <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"/>
              <label for="3-stars" class="star">★</label>
              <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"/>
              <label for="2-stars" class="star">★</label>
              <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
              <label for="1-star" class="star">★</label>
            </div>
          </div>
      </div>

      <!--리뷰 사진-->
      <div class="center mt-3">
        <img src="http://placeimg.com/500/500/people" class="review-img">
      </div>

      <!--리뷰 내용-->
      <div class="row mt-3">
        <!--나중에는 db에서 값을 불러오기때문에 pre로 변경-->
        <p>
          선물로 사줬는데 바퀴도 잘 굴러가고 유용하게 쓰인다고 합니다. 
          그런데 트렁크에 너무 딱 맞아서, 넣고 문이 안 닫힌다고 하더라고요 
          차마다 다르겠지만 구매 전에 사이즈 확인하세요! ㅎㅎ
        </p>
      </div>

    </div><!-- /.container -->













<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>