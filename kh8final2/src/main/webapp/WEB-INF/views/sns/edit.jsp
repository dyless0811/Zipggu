<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/inline/ckeditor.js"></script>
<style>

	.ck-editor__editable{
		min-height:300px;
	}
	
</style>
<script>
	var sel_files = [];

	$(document).ready(function(){
    	$("input[name=attach]").on("change", handleImgsFilesSelect);
	});

	function handleImgsFilesSelect(e) {

    	sel_files = [];
    	$("#result").empty();

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
            	$("#result").append(html);
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
</script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>게시글 수정 페이지</h1>

<div class="container-600 container-center">
	<div class="row mt-3">
		<form method="post" enctype="multipart/form-data">
			<div class="mt-3">
				<label>작성자 : 구현 해야함</label>
			</div>
			<div class="mt-3">
				<textarea name="snsDetail" id="editor">${snsDto.snsDetail }</textarea>
				<script>
					InlineEditor
						.create(document.querySelector('#editor'),{
							language: {ui: 'ko', content: 'ko'}
						})
						.catch(error => {
							console.error(error);
						});
				</script>
			</div>
			<div class="mt-4">
				<input type="file" name="attach" class="form-control" multiple>
			</div>
			<div class="mt-3">
				<input type="submit" value="등록" class="btn btn-primary">
			</div>
		</form>
	</div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>