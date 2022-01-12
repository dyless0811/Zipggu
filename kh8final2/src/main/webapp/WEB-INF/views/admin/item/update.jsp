<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>


	.thumbnail_wrap {
        border: 2px solid #A8A8A8;
        margin-top: 30px;
        margin-bottom: 30px;
        padding-top: 10px;
        padding-bottom: 10px;
        width: 200px;
    }
    
	.imgs_wrap {
        border: 2px solid #A8A8A8;
        margin-top: 30px;
        margin-bottom: 30px;
        padding-top: 10px;
        padding-bottom: 10px;
    }
    .imgs_wrap img, .thumbnail_wrap img {
        max-width: 150px;
        margin-left: 10px;
 	    margin-right: 10px;
    }
	.ck-editor__editable{
		min-height:300px;
	}
</style>


    <script>
      $(function () {
    	  $(".exist-detail-remove-btn").click(function(){
      		itemOptionRemove($(this).parent().data("option-no"));
      		$(this).parent().remove();
      	  });
    	  
    	  $(".exist-group-remove-btn").click(function(){
    		var itemNo = $("input[name=itemNo]").val();
    		var itemOptionGroup = $(this).parent().data("option-group");
    		itemOptionGroupRemove(itemNo, itemOptionGroup);
    		$(this).parent().remove();
    	  });
    	  
    	  $(".exist-detail-update-btn").click(function(){
    		alert("수정 완료");
    		var itemOptionNo = $(this).parent().data("option-no");
    		var itemOptionDetail = $(this).prev().prev().find("input").val();
    		var itemOptionPrice = $(this).prev().find("input").val();
    		itemOptionUpdate(itemOptionNo, itemOptionDetail, itemOptionPrice);
    	  });

    	  $(".exist-group-update-btn").click(function(){
    		alert("수정 완료");
    		var itemNo = $("input[name=itemName]").data("item-no");
    		var itemOptionGroup = $(this).parent().data("option-group");
    		var changeGroup = $(this).prev().find("input").val();
    		itemOptionGroupUpdate(itemNo, itemOptionGroup, changeGroup);
    	  });

    	  $(".exist-option-insert-btn").click(function(){
    		var itemNo = $("input[name=itemName]").data("item-no");
    		var itemOptionGroup = $(this).parent().data("option-group");
    		var itemOptionDetail = $(this).prev().prev().find("input").val();
    		var itemOptionPrice = $(this).prev().find("input").val();
    		var itemOptionRequired = $(this).parent().data("option-required");
    		itemOptionInsert(itemNo, itemOptionGroup, itemOptionDetail, itemOptionPrice, itemOptionRequired);
    	  });
    	  
    	  
    	  
    	  $(".exist-remove-btn").click(function(){
    		 $(this).parent().remove(); 
    	  });
    	  
    	  //파일 미리보기, 파일 배열 저장, 파일 부분 삭제
          var fileList = [];

          function refreshView() {
            $("#result").empty();
            $.each(fileList, function (idx, file) {
              // ---------------------------------------
              var div = $("<div style='width:300px'>");
              var reader = new FileReader();
              reader.readAsDataURL(file);
              reader.onload = function (e) {
                var html =
                  '<img style="width:100%" src="' +
                  e.target.result +
                  "\" data-file='" +
                  file.name +
                  "'>";
                div.append(html);
              };
              var btn = $("<button>").text("x");
              btn.click(function () {
                fileList.splice(idx, 1);
                refreshView();
              });
              div.text(file.name).append(btn);
              $("#result").append(div);
              // ----------------------------------------
            });
          }

          $("input[name=attach]").on("input", function () {
            if (this.files.length == 0) {
              return;
            }
            fileList.push(this.files[0]);
            refreshView();
            
            $(this).val("");
          });  
    	  
    	  
    	// 카테고리 선택
    	$(".category-select").change(function(){
    	  var depth = $(this).data("depth");
    	  var categoryNo = $(this).val();
    	  var categoryName = $(this).find("option:selected").text();
    	  $.ajax({
    		  url : "${pageContext.request.contextPath}/admin/data/category/child",
    		  type : "post",
    		  data : {
    			  categorySuper : categoryNo
    		  },
    		  success : function(resp) {
    			console.log("성공", resp);
    			if(resp.length == 0) {
    				$("input[name=categoryNo]").val($(this).find("option:selected").text());
    				$(".category-select[data-depth="+(depth+1)+"]").attr("disabled", true).empty();
    				$(".category-select[data-depth="+(depth+2)+"]").attr("disabled", true).empty();
    				if(categoryNo != 0) {
    					$("input[name=categoryNo]").val(categoryNo);
						$("input[name=categoryName]").val(categoryName);
    				} else {
        				$("input[name=categoryNo]").val("");
    					$("input[name=categoryName]").val("");
        			}
    				return;
    			}
    			$("input[name=categoryNo]").val("");
				$("input[name=categoryName]").val("");
    			
				var targetTag = $(".category-select[data-depth="+(depth+1)+"]");
				$(".category-select[data-depth="+(depth+2)+"]").attr("disabled", true).empty();
				targetTag.removeAttr("disabled")
				targetTag.empty();
    				$("<option>").val(0).text("하위 카테고리").appendTo(targetTag);
    			for (let categoryDto of resp) {
    				$("<option>").val(categoryDto.categoryNo).text(categoryDto.categoryName).appendTo(targetTag);
				}
    		  },
    		  error : function(e) {
    			  console.log("실패", e);
    		  }
    	  });
    	});
    	  
        // 옵션 분류 추가 버튼
        $(".option-group-btn").click(function () {
          var template = $("#option-template").html();

          $(".option-list").append(template);
        });
        // 옵션 내용 추가 버튼
        $(document).on("click", ".option-detail-btn", function () {
          var tempalte = $("#option-detail-template").html();
          $(this).siblings(".option-detail-list").append(tempalte);
        });
        // 삭제 버튼
        $(document).on("click", ".remove-btn", function () {
          $(this).parent().remove();
        });
        // 등록 버튼
        $("#item-submit").click(function (e) {
        	e.preventDefault();
          var option_index = 0;
          var form = $(".result-form");
          // 분류만 추가하고 내용을 추가하지 않은 상태를 검사
          var is_empty_option = false;
          $(".option").each(function () {
            is_empty_option = !$(this).find(".option-detail-list").text();
            if (is_empty_option) return false;
          });
          // 내용이 비어있는 상태를 검사
          var is_empty_value = false;
          $(".option-detail").each(function () {
            var itemOptionGroup = $(this)
              .parent()
              .parent()
              .find("input[name=itemOptionGroup]")
              .val();
            var itemOptionDetail = $(this)
              .find("input[name=itemOptionDetail]")
              .val();
            var itemOptionPrice = $(this)
              .find("input[name=itemOptionPrice]")
              .val();
            var itemOptionRequired = $(this)
              .parent()
              .parent()
              .find("input[name=itemOptionRequired]")
              .prop("checked")
              ? 1
              : 0;
            is_empty_value =
              !itemOptionGroup || !itemOptionDetail || !itemOptionPrice;

            if (is_empty_value) return false;
			
            $(
              "<input type='hidden' name='optionList[" +
                option_index +
                "].itemOptionGroup'>"
            )
              .val(itemOptionGroup)
              .appendTo(form);

            $(
              "<input type='hidden' name='optionList[" +
                option_index +
                "].itemOptionDetail'>"
            )
              .val(itemOptionDetail)
              .appendTo(form);
            $(
              "<input type='hidden' name='optionList[" +
                option_index +
                "].itemOptionPrice'>"
            )
              .val(itemOptionPrice)
              .appendTo(form);
            $(
              "<input type='hidden' name='optionList[" +
                option_index +
                "].itemOptionRequired'>"
            )
              .val(itemOptionRequired)
              .appendTo(form);

            console.log(option_index++, "번 옵션 추가");
          });
          if (is_empty_value) {
            alert("옵션을 채워주세요");
            return;
          } else if (is_empty_option) {
            alert("사용하지 않는 옵션을 지워주세요");
            return;
          }
          
          var formData = new FormData($(".result-form")[0]);
          var fileIndex = fileList.length;
          for (var i = 0; i < fileIndex; i++) {  
        	 console.log("fileIndex = ", fileIndex);
			formData.append("attach", fileList[i]);		
		  }
          $("input[name=remainingImg]").each(function(index, fileNo){
        	formData.append("remainingFile["+index+"]", $(fileNo).val());  
          });
          
         $.ajax({
        	url: "${pageContext.request.contextPath}/admin/item/update",
        	type: "post",
        	data: formData,
        	enctype: "multipart/form-data",
        	async: false,
        	contentType: false,
       	 	processData: false,
       	 	success: function(resp) {
        		 console.log("성공", resp);
        		 location.href = "${pageContext.request.contextPath}/store/detail/"+resp;
        	 },
       	 	error: function(e) {
        		 console.log("실패", e);
        	}
          });
        });
        
        $("#item-delete-btn").click(function(e){
        	if(!confirm("정말 삭제하시겠습니까?")){
	        	e.preventDefault();        		
        	}
        });
        
        var sel_files = [];
      	$("input[name=thumbnail]").on("change", handleImgsFilesSelect);
      });
      
      //이미지 미리보기
      function handleImgsFilesSelect(e) {
		
   	    sel_files = [];
		var inputFile = $(this);
   	    var result = inputFile.parent().next().find("div");
   	 	result.empty();

   	    var files = e.target.files;
   	    var filesArr = Array.prototype.slice.call(files);

   	    var index = 0;
   	    filesArr.forEach(function(f){
   	        if(!f.type.match("image.*")){
   	            alert("확장자는 이미지 확장자만 가능합니다.");
   	            return;
   	        }

   	        sel_files.push(f);

   	        var reader = new FileReader();
   	        reader.onload = function(e) {
   	            var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove'></a>";
   	            result.append(html);
   	            index++;

   	          }
   	          reader.readAsDataURL(f);
   	        });
    	}

    	function deleteImageAction(index){
    	  console.log("index : " + index);
    	  sel_files.splice();
    		

    		  
    	  var img_id = "#img_id_" + index;
    	  var del = $(img_id).remove();



    	  if(del){
    		  $("input[name=attach]").val("");
    		  $("#result").empty();
    	  }

    	  console.log(sel_files);
    	}
    	
    	function itemOptionRemove(itemOptionNo) {
    		$.ajax({
    			url: "${pageContext.request.contextPath}/admin/item/update/optionRemove",
    			type: "post",
    			data: {
    				itemOptionNo : itemOptionNo
    			},
    			success: function(resp){
    				console.log("성공",resp);
    			},
    			error: function(e){
    				console.log("실패",e)
    			}
    		});
    	}
    	function itemOptionGroupRemove(itemNo, itemOptionGroup) {
    		$.ajax({
    			url: "${pageContext.request.contextPath}/admin/item/update/optionGroupRemove",
    			type: "post",
    			data: {
    				itemNo : itemNo,
    				itemOptionGroup : itemOptionGroup
    			},
    			success: function(resp){
    				console.log("성공",resp);
    			},
    			error: function(e){
    				console.log("실패",e)
    			}
    		})
    	}
    	function itemOptionUpdate(itemOptionNo, itemOptionDetail, itemOptionPrice) {
      		$.ajax({
    			url: "${pageContext.request.contextPath}/admin/item/update/optionUpdate",
    			type: "post",
    			data: {
    				itemOptionNo : itemOptionNo,
    				itemOptionDetail : itemOptionDetail,
    				itemOptionPrice : itemOptionPrice
    			},
    			success: function(resp){
    				console.log("성공",resp);
    			},
    			error: function(e){
    				console.log("실패",e)
    			}
    		})
    	}
    	function itemOptionGroupUpdate(itemNo, itemOptionGroup, changeGroup) {
      		$.ajax({
    			url: "${pageContext.request.contextPath}/admin/item/update/optionGroupUpdate",
    			type: "post",
    			data: {
    				itemNo : itemNo,
    				itemOptionGroup : itemOptionGroup,
    				changeGroup : changeGroup
    			},
    			success: function(resp){
    				console.log("성공",resp);
    			},
    			error: function(e){
    				console.log("실패",e)
    			}
    		})
    	}
    	function itemOptionInsert(itemNo, itemOptionGroup, itemOptionDetail, itemOptionPrice, itemOptionRequired) {
      		$.ajax({
    			url: "${pageContext.request.contextPath}/admin/item/update/optionInsert",
    			type: "post",
    			data: {
    				itemNo : itemNo,
    				itemOptionGroup : itemOptionGroup,
    				itemOptionDetail : itemOptionDetail,
    				itemOptionPrice : itemOptionPrice,
    				itemOptionRequired : itemOptionRequired
    			},
    			success: function(resp){
    				console.log("성공",resp);
    				location.reload();
    			},
    			error: function(e){
    				console.log("실패",e)
    			}
    		})
    	}
    </script>


    <div class="container-zipggu">
      <h1>상품 수정</h1>
      <hr />
      <form class="result-form" method="post" enctype="multipart/form-data">
      <div class="row">
        <div class="category-select-box">
          <div class="row">
    		<div class="col-md-3">
    		  <select class="form-select category-select" data-depth="1" required>
    		  	<option selected value="0")>카테고리</option>
            	<c:forEach var="categoryVO" items="${categoryVOList}">
             	  <option value="${categoryVO.categoryNo}">${categoryVO.categoryName}</option>
            	</c:forEach>
          	  </select>
    		</div>
    	    <div class="col-md-3">
    	      <select class="form-select category-select" data-depth="2" disabled>
          	  </select>
    	    </div>
    	    <div class="col-md-3">
    	      <select class="form-select category-select" data-depth="3" disabled>
          	  </select>
    	    </div>
    	    <div class="col-md-3">
    	      <input type="hidden" name="categoryNo" value="${itemDto.categoryNo}">
    	      <input class="form-control" type="text" name="categoryName" value="" readonly>
    	    </div>
  		  </div>
	    </div>
	  </div>
	  <div class="row">
		<div class="mb-3">
  			<label for="itemFormControlInput1" class="form-label">상품명</label>
  			<input type="text" name="itemName" class="form-control" id="itemFormControlInput1" value="${itemDto.itemName}">
  			<input type="hidden" name="itemNo" value="${itemDto.itemNo}">
		</div>
	  </div>
	  
	  <div class="row">
		<div class="col mb-3">
  		  <label for="itemFormControlInput2" class="form-label">가격</label>
  		  <input type="text" name="itemPrice" class="form-control" id="itemFormControlInput2" value="${itemDto.itemPrice}">
		</div>
		<div class="col mb-3">
		  <label for="itemFormControlInput3" class="form-label">배송 타입</label>
  		  <select class="form-select" name="itemShippingType" id="itemFormControlInput3">
  			<option value="0" ${itemDto.itemShippingType == 0 ? "selected" : ""}>택배</option>
            <option value="1" ${itemDto.itemShippingType == 1 ? "selected" : ""}>착불</option>
          </select>
		</div>
	  </div>


        <label>
          썸네일
          <input type="file" name="thumbnail" accept="image/*" class="form-control">
        </label>
        <div class="thumbnail_wrap">
				<div id="thumbnail-result">
					<input type="hidden" name="remainingThumbnail" value="Y">
					<button type="button" class="exist-remove-btn">x</button>
					<img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${itemDto.itemNo}" style="width:300px">
				</div>
		</div>
      <label>
        <div class="btn btn-primary">파일 추가</div>
          <input type="file" name="attach" accept="image/*" class="form-control" hidden>
      </label>
        <div class="imgs_wrap">
				<div id="exist-result">
					<c:forEach var="itemFileDto" items="${itemFileDtoList}">
						<div>						
							<input type="hidden" name="remainingImg" value="${itemFileDto.itemFileNo}">
							${itemFileDto.itemFileUploadname}
							<button type="button" class="exist-remove-btn">x</button>
							<img src="${pageContext.request.contextPath}/item/image?itemFileNo=${itemFileDto.itemFileNo}">
						</div>
					</c:forEach>
				</div>
				<div id="result"></div>
		</div>
      </form>
        <br /><br />
      <button class="option-group-btn" type="button">옵션 분류 추가</button>
      <hr />
      <div class="exist-option-list">
      <c:forEach var="map" items="${itemOptionGroupMap}" varStatus="status">
      	<div class="option" data-option-group="${map.key}" data-option-required="${map.value[0].itemOptionRequired}">
    	  <label>
      		옵션 분류
      		<input name="existItemOptionGroup" type="text" value="${map.key}"/>
   		  </label>
    	  <button type="button" class="exist-group-update-btn">수정</button>
    	  <button type="button" class="exist-group-remove-btn">삭제</button>
    	  <br /><br />
   		   <label>
      		옵션 내용
      		<input name="itemOptionDetail" type="text" value=""/>
    	  </label>
    	  <label>
			옵션 가격
      		<input name="itemOptionPrice" type="text" value=""/>
      	  </label>
    	  <button type="button" class="exist-option-insert-btn">추가</button> <br><br>      	  
    	  <div class="option-detail-list">
    	  	<c:forEach var="optionDto" items="${map.value}">
    	  	  <div class="exist-option-detail" data-option-no="${optionDto.itemOptionNo}">
    		    <label>
      		           옵션 내용
      			  <input name="itemOptionDetail" type="text" value="${optionDto.itemOptionDetail}"/>
    			</label>
    			<label>
				    옵션 가격
      			  <input name="itemOptionPrice" type="text" value="${optionDto.itemOptionPrice}"/>
      			</label>
      			<button type="button" class="exist-detail-update-btn">수정</button>
      			<button type="button" class="exist-detail-remove-btn">삭제</button><br><br>
  			  </div>
    	  	</c:forEach>
    	  </div>
    	  <hr />
  		</div>
  	  </c:forEach>
      </div>
      <div class="option-list"></div>
      <a href="" id="item-submit" class="btn btn-primary text-light">등록</a>
      <a href="${pageContext.request.contextPath}/admin/item" class="btn btn-secondary text-light">취소</a>
      <a href="${pageContext.request.contextPath}/admin/item/delete?itemNo=${itemDto.itemNo}" id="item-delete-btn" class="btn btn-danger text-light">삭제</a>
    </div>
    
    <!--옵션-->
<template id="option-template">
  <div class="option">
    <label>
      옵션 분류
      <input name="itemOptionGroup" type="text" />
    </label>
    <label>
      필수 옵션 여부
      <input name="itemOptionRequired" type="checkbox" />
    </label>

    <button type="button" class="option-detail-btn">옵션 내용 추가</button>
    <button type="button" class="remove-btn">삭제</button>
    <br /><br />
    <div class="option-detail-list"></div>
    <hr />
  </div>
</template>
<!--세부옵션-->
<template id="option-detail-template">
  <div class="option-detail">
    <label>
      옵션 내용
      <input name="itemOptionDetail" type="text" />
    </label>

    <label>
      옵션 가격
      <input name="itemOptionPrice" type="text" /> </label
    ><button type="button" class="remove-btn">삭제</button><br /><br />
  </div>
</template>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>