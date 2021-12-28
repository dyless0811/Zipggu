<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

	textarea{
		resize: none;
	}
	
</style>
<script>
	
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
				<textarea name="snsDetail" rows="5" class="form-control">${snsDto.snsDetail }</textarea>
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