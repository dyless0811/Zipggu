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
		$(".category-ul").empty();
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
					var category = $("<li>")
					.append($("<div>")
						.addClass("cate")
						.append($("<a>")
							.attr("href","#")
							.text("전체카테고리")
						)
						.append($("<div>")
							.addClass("btn4-box")
							.attr("data-category-no", 0)
						)
					);
					ul.append(category);
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
					.addClass("btn4-box")
					.attr("data-category-no", categoryVO.categoryNo)
					.attr("data-category-name", categoryVO.categoryName)
				)		
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
				.attr("data-category-no", categoryVO.categoryNo)
				.attr("data-category-name", categoryVO.categoryName)
			)
		);

		ul.append(category);
	}
	
	$(document).on("click", "#add-submit-btn", function(e){
		e.preventDefault();
		var categoryName = $("input[name=categoryName]").val();
		var categorySuper = $("input[name=categorySuper]").val();
		if(!categoryName){
			alert("내용을 입력해주세요.");
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/data/category/add",
			type:"post",
			async: false,
			data:{
				categoryName : categoryName, 
				categorySuper : categorySuper
			},
			successe:function(){
				console.log("성공");
			},
			error:function(e){
				console.log(e, "실패");
			}
		});
		$(this).parent().remove();
		loadData();
		create_btn();
	})
	
	$(document).on("click", "#modify-submit-btn", function(e){
		e.preventDefault();
		var categoryName = $("input[name=categoryName]").val();
		var categoryNo = $("input[name=categoryNo]").val();
		if(!categoryName){
			alert("내용을 입력해주세요.");
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/data/category/modify",
			type:"post",
			async: false,
			data:{
				categoryName : categoryName, 
				categoryNo : categoryNo
			},
			successe:function(){
				console.log("성공");
			},
			error:function(e){
				console.log(e, "실패");
			}
		});
		$(this).parent().remove();
		loadData();
		create_btn();
	})
	
	$(document).on("click", "#delete-submit-btn", function(e){
		e.preventDefault();
		var categoryNo = $("input[name=categoryNo]").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath}/admin/data/category/delete",
			type:"post",
			async: false,
			data:{
				categoryNo : categoryNo
			},
			successe:function(){
				console.log("성공");
			},
			error:function(e){
				console.log(e, "실패");
			}
		});
		$(this).parent().remove();
		loadData();
		create_btn();
	})
	
	
	$(document).on("click", "#cancel-btn", function(e){
		e.preventDefault();
		$(this).parent().remove();
	});
	
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

            var categoryNo = $(this).parent().attr("data-category-no");
            $("<h3>").text("추가").appendTo(".send-form");
            $("<input type='text' name='categoryName' size='15' required>").appendTo(
              ".send-form"
            );
            $("<input type='hidden' name='categorySuper' value='"+categoryNo+"'>").appendTo(".send-form");
            $("<input id='add-submit-btn' type='submit' value='확인'>").appendTo(".send-form");
            $("<input id='cancel-btn' type='reset' value='취소'>").appendTo(".send-form");
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

            var categoryNo = $(this).parent().attr("data-category-no");
            var categoryName = $(this).parent().attr("data-category-name");
            $("<h3>").text("수정").appendTo(".send-form");
            $("<input type='text' name='categoryName' size='15' value="+categoryName+">").appendTo(
              ".send-form"
            );
            $("<input type='hidden' name='categoryNo' value='"+categoryNo+"'>").appendTo(".send-form");
            $("<input id='modify-submit-btn' type='submit' value='확인'>").appendTo(".send-form");
            $("<input id='cancel-btn' type='reset' value='취소'>").appendTo(".send-form");
          });
        $(".btn4-box").append(modifyBtn);

        //삭제
        var deleteBtn = $("<a>")
          .addClass("delete-btn")
          .append($("<i>").addClass("fas fa-trash-alt"))
          .attr("href", "javascript:void(0)")
          .click(function () {
              var rightContent = $(".right-content");
              rightContent.empty();
              var form = $("<form>")
                .attr("acton", "#")
                .attr("method", "post")
                .addClass("send-form");

              form.appendTo(rightContent);

              var categoryNo = $(this).parent().attr("data-category-no");
              var categoryName = $(this).parent().attr("data-category-name");
              $("<h3>").text("삭제").appendTo(".send-form");
              $("<span>").text(categoryName+"을 삭제하시겠습니까?").appendTo(
                ".send-form"
              );
              $("<input type='hidden' name='categoryNo' value='"+categoryNo+"'>").appendTo(".send-form");
              $("<input id='delete-submit-btn' type='submit' value='확인'>").appendTo(".send-form");
              $("<input id='cancel-btn' type='reset' value='취소'>").appendTo(".send-form");
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
 			  <li>
 			    <div class="cate">
                  <a href="#">전체카테고리</a>
                  <div class="btn4-box" data-category-no="0"></div>
                </div>
 			  </li>
 			</ul>
          </div>
        </div>
        <div class="float-div right">
          <div class="right-content"></div>
        </div>
      </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>