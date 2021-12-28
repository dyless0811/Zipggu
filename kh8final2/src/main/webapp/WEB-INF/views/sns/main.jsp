<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		var page = 1;
		var size = 18;
		var result = $("#result")
		
		$(".more-btn").click(function(){
			loadData(page, size);
			page++;
		});
		
		$(".more-btn").click();
		
		function loadData(page, size){
			$.ajax({
				url : "${pageContext.request.contextPath}/sns/data/list",
				type : "get",
				data : {
					page : page,
					size : size
				},
				dataType : "json",
				success:function(resp){
					console.log("성공", resp);
					if(resp.length < size){
						$(".more-btn").remove();
					}
					
					for(var i=0; i<resp.length; i++){
						var result = $("#result")
						var clonedTemplate = $("#sns-template").clone();
						var templateContent = $(clonedTemplate.html());
						templateContent.find("a").attr("href", "${pageContext.request.contextPath}/sns/detail?snsNo="+resp[i].snsNo);
						templateContent.find("#thumnail").attr("src", "${pageContext.request.contextPath}/sns/thumnail?snsNo="+resp[i].snsNo);
						var str = resp[i].snsDetail;
						templateContent.find(".card-text").text(str.substr(-10));
						templateContent.find("#nickname").text("작성자 : " + resp[i].memberNickname);
						var timestamp = resp[i].snsDate;
						var date = new Date(resp[i].snsDate);

						templateContent.find("#date").text(date.toLocaleString());
// 						templateContent.find("#like").text(resp[i].snsLike);//좋아요개수
						templateContent.find("#reply").text(resp[i].snsReplyCount);
						templateContent.find()
						clonedTemplate.html(templateContent.prop('outerHTML'));
						result.append(clonedTemplate.html());
						
						
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	});
</script>

<div class="container-fluid">
	<div class="row py-lg-5 text-center">
   		<div class="col-lg-6 col-md-8 mx-auto">
        	<h1 class="fw-light">
        		<font style="vertical-align: inherit;">
        		<font style="vertical-align: inherit;">
        			앨범 예
        		</font>
        		</font>
        	</h1>
           	<p class="lead text-muted">
           		<font style="vertical-align: inherit;">
           		<font style="vertical-align: inherit;">
           			아래 앨범에 대한 간략한 설명(내용, 제작자 등). 
           		</font>
           		<font style="vertical-align: inherit;">
           			짧고 귀엽게 유지하되 너무 짧지 않도록 하여 사람들이 이 앨범을 완전히 건너뛰지 않도록 합니다.
           		</font>
           		</font>
           	</p>
        </div>
    </div>

   	<div class="container text-end">
		<a href="sns/write" class="btn btn-outline-secondary">등록</a>
	</div>
	
	<div class="album py-5">
		<div class="container">
           <div class="row row-cols-1 row-cols-sm-4 row-cols-sm-4 g-3" id="result"> 	
           </div>	
		</div>
	</div>
	
    <button type="button" class="btn btn-primary more-btn">더보기</button>
</div>

<template id="sns-template">

	
      		
            	<div class="col">
                	<div class="card shadow-sm">
                		<a href="detail?snsNo=${snsDto.snsNo }">
						<img src="thumnail?snsNo=${snsDto.snsNo}" id="thumnail" class="bd-placeholder-img card-img-top" width="100%" height="225" >
						</a>
						<div class="d-flex justify-content-between align-items-center mt-2 ms-3">
  								<div>
   									<!-- 좋아요 아이콘 -->
                 					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
										<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
									</svg>
                   					<span id="like"></span>
                   					&nbsp;&nbsp;
                   					
                					<!-- 댓글 아이콘 -->
                   					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots ms-4" viewBox="0 0 16 16">
	  									<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
	  									<path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"></path>
									</svg>
                   					<span id="reply"></span>
                   					
                 				</div>
                 	
            				</div>
						<div class="card-body">
  							<p class="card-text">${snsDto.getSnsDetailSub() }...</p>
								
                 				<small class="text-muted" id="nickname">${loginNick }</small>
                 				<br>
                 				<small class="text-muted" id="date">dddd</small>
          				</div>
        			</div>
      			</div>
			
    

</template>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>