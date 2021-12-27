<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<div class="container-zipggu">
      <div class="float-div">
        <div class="float-div left">
          <div class="cate-box">
            <input type="checkbox" id="testColor" />
            <label for="testColor">Test Color</label>
            <ul>
              <li>
                <div class="cate-parent">
                  <a href="#">침대/매트릭스</a>
                  <div class="btn-box"><div class="btn4-box"></div></div>
                </div>
                <ul class="cate-child">
                  <li>
                    <div class="cate-parent">
                      <a href="#">침대</a>
                      <div class="btn-box"><div class="btn4-box"></div></div>
                    </div>
                    <ul class="cate-child">
                      <li>
                        <div class="cate">
                          <a href="#">일반침대</a>
                          <div class="btn4-box"></div>
                        </div>
                      </li>
                      <li><a href="#">수납침대</a></li>
                      <li><a href="#">LED침대</a></li>
                      <li><a href="#">깔판/저상형침대</a></li>
                      <li><a href="#">2층/벙커침대</a></li>
                      <li><a href="#">모션베드</a></li>
                      <li><a href="#">패밀리침대</a></li>
                      <li><a href="#">돌침대/흙침대</a></li>
                    </ul>
                  </li>
                  <li>
                    <div class="cate-parent"><a href="#">매트릭스</a></div>
                    <ul class="cate-child">
                      <li><a href="#">스프링</a></li>
                      <li><a href="#">메모리폼</a></li>
                      <li><a href="#">라텍스</a></li>
                      <li><a href="#">토퍼</a></li>
                    </ul>
                  </li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">소파</a></div>
                <ul class="cate-child">
                  <li><a href="#">가죽소파</a></li>
                  <li><a href="#">패브릭소파</a></li>
                  <li><a href="#">신소재소파</a></li>
                  <li><a href="#">좌식소파</a></li>
                  <li><a href="#">소파베드</a></li>
                  <li><a href="#">리클라이너소파</a></li>
                  <li><a href="#">빈백</a></li>
                  <li><a href="#">소파스툴</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">테이블</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">화장대/거울</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">드레스룸</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent">
                  <a href="#">거실장/서랍장/선반</a>
                  <div class="btn-box"><div class="btn3-box"></div></div>
                </div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">식탁/주방수납</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">책상/책장</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">의자</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
              <li>
                <div class="cate-parent"><a href="#">유아/아동가구</a></div>
                <ul class="cate-child">
                  <li><a href="#">HTML</a></li>
                  <li><a href="#">Python</a></li>
                  <li><a href="#">Java</a></li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
        <div class="float-div right">
          <div class="right-content"></div>
        </div>
      </div>
    </div>


    <script>
      $(document).ready(function () {
        var modifyBtn = $("<a>")
          .addClass("modify-btn")
          .append($("<i>").addClass("fas fa-tools"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn4-box").append(modifyBtn);
        var deleteBtn = $("<a>")
          .addClass("delete-btn")
          .append($("<i>").addClass("fas fa-trash-alt"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn4-box").append(deleteBtn);

        // 추가 버튼
        var addBtn = $("<a>")
          .addClass("add-btn")
          .append($("<i>").addClass("fas fa-plus-square"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            var rightContent = $(".right-content");
            var form = $("<form>")
              .attr("action", "#")
              .attr("method", "post")
              .addClass("send-form");

            form.appendTo(rightContent);

            $("<h3>").text("추가").appendTo(".send-form");
            $("<input type='text' name='category' size='15'>").appendTo(
              ".send-form"
            );
            $("<input type='submit' value='확인'>").appendTo(".send-form");
            $("<input type='reset' value='취소'>").appendTo(".send-form");
          });
        $(".btn4-box").append(addBtn);
        var removeBtn = $("<a>")
          .addClass("remove-btn")
          .append($("<i>").addClass("fas fa-minus-square"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn4-box").append(removeBtn);
        var cateBtn = $("<a>")
          .addClass("cate-btn")
          .append($("<i>").addClass("fas fa-caret-down"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn-box").append(cateBtn);
      });
    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>