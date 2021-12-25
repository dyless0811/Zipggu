<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <script>
      $(function () {
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
        $("#item-submit").click(function () {
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
          console.log("submit!!");
          form.submit();
        });
      });
    </script>


    <div class="container-zipggu">
      <h1>상품 등록</h1>
      <hr />
      <form class="result-form" method="post" enctype="multipart/form-data">
        <label
          >카테고리
          <select name="categoryNo">
            <option value="3">패브릭소파</option>
          </select> </label
        ><br /><br />

        <label>
          상품명
          <input type="text" name="itemName" /> </label
        ><br /><br />

        <label>
          가격
          <input type="text" name="itemPrice" /> </label
        ><br /><br />

        <label>
          배송 타입
          <select name="itemShippingType">
            <option value="0">택배</option>
            <option value="1">착불</option>
          </select> </label
        ><br /><br />

        <label>
          이미지
          <input type="file" name="attach" />
        </label>
        <br /><br />
      </form>
      <button class="option-group-btn" type="button">옵션 분류 추가</button>
      <hr />
      <div class="option-list"></div>
      <button id="item-submit" type="button">등록</button>
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