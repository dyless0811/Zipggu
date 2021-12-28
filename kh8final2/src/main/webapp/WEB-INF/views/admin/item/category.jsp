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
<script>
$(function(){
	loadData();
	create_btn();
	
	function loadData(){
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/data/category/list",
			type : "get",
			data : {
			},
			async: false,
			dataType : "json",
			success:function(resp){
				console.log("성공", resp);
				
					var ul = $(".category-ul");
					draw_category(resp, ul);
				

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
				.attr("href","#")
				.text(categoryVO.categoryName)
			)
			.append($("<div>")
				.addClass("btn-box")
				.append($("<div>")
					.addClass("btn4-box"))
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
				.attr("href","#")
				.text(categoryVO.categoryName)
			)
			.append($("<div>")
				.addClass("btn4-box")
			)
		);

		ul.append(category);
	}
	
    function create_btn() {
        //추가 버튼
        var addBtn = $("<a>")
          .addClass("add-btn")
          .append($("<i>").addClass("fas fa-file"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            var rightContent = $(".right-content");
            rightContent.empty();
            var form = $("<form>")
              .attr("acton", "#")
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

        //수정 버튼
        var modifyBtn = $("<a>")
          .addClass("modify-btn")
          .append($("<i>").addClass("fas fa-tools"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            var rightContent = $(".right-content");
            rightContent.empty();
            var form = $("<form>")
              .attr("acton", "#")
              .attr("method", "post")
              .addClass("send-form");

            form.appendTo(rightContent);

            $("<h3>").text("수정").appendTo(".send-form");
            $("<input type='text' name='category' size='15'>").appendTo(
              ".send-form"
            );
            $("<input type='submit' value='확인'>").appendTo(".send-form");
            $("<input type='reset' value='취소'>").appendTo(".send-form");
          });
        $(".btn4-box").append(modifyBtn);

        //삭제
        var deleteBtn = $("<a>")
          .addClass("delete-btn")
          .append($("<i>").addClass("fas fa-trash-alt"))
          .attr("href", "javascript:void(0)")
          .click(function () {
            $(this).parent().next().toggle();
            $(this).children("i").toggleClass("fa-rotate-180");
          });
        $(".btn4-box").append(deleteBtn);

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


	<div class="container-zipggu">
      <div class="float-div">
        <div class="float-div left">
          <div class="cate-box">
 			<ul class="category-ul">
 			
 			</ul>
          </div>
        </div>
        <div class="float-div right">
          <div class="right-content"></div>
        </div>
      </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>