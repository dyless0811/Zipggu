<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="snsNo" value="${snsDto.snsNo }"></c:set>
<c:set var="writer" value="${loginNo == snsDto.memberNo }"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	//댓글 등록
	$(function(){
		//console.log(1);
		
		$("#btn").click(function(e){
			
			//console.log(2);
			
			var snsReplyDetail = $("#detail").val();
			var memberNo = $("input[name=memberNo]").val();
			var snsNo = $("input[name=snsNo]").val();
			
			
			console.log(snsReplyDetail);
			console.log(memberNo);
			console.log(snsNo);
			
			
			
			$.ajax({
				url:"${pageContext.request.contextPath}/snsReply/insert",
				type:"post",
				data:{
					snsReplyDetail:snsReplyDetail,
					memberNo:memberNo,
					snsNo:snsNo
				},
				success:function(resp){
					console.log("성공", resp);
					
					$("textarea[name=snsReplyDetail]").val("");
					
					$("#result").empty();
					
					page = 1;
					loadList(page,size,snsNo);
					page++;
								
					
					
				},
				error:function(e){
					console.log("실패", e);
				}
				
			});
		});
	});
	

	//페이징
	var page = 1;
	var size = 10;
	var snsNo = ${snsNo};
	console.log(snsNo);
		
		$(function(){
			console.log(1);
			console.log(2);
			$(".more-btn").click(function(){
				loadList(page,size,snsNo);
				page++;
				console.log(3);
		});
		//더보기 버튼을 강제 1회 클릭(트리거)
		$(".more-btn").click();
		console.log(4);
	});
	
	//목록 불러오기
	function loadList(pageValue, sizeValue, snsNoValue){
		console.log(5);
		$.ajax({
			url:"${pageContext.request.contextPath}/snsReply/list",
			type:"get",
			data:{
				page:pageValue,
				size:sizeValue,
				snsNo:snsNoValue
			},
			dataType:"json",
			success:function(resp){
				console.log("성공", resp);
				
				if(resp.length < sizeValue){
					$(".more-btn").hide();
				}
				else{
					$(".more-btn").show();
				}
				
				
				
				for(var i=0; i<resp.length; i++){
					
					var template = $("#reply-template").html();
					
					
					template = template.replace("{{writer}}", resp[i].memberNickname);
				
					template = template.replace("{{replyDetail}}", resp[i].snsReplyDetail);
	
					template = template.replace("{{snsReplyNo}}", resp[i].snsReplyNo);
					
					template = template.replace("{{snsReplyDepth}}", resp[i].snsReplyDepth);
					
					var margin = 20*resp[i].snsReplyDepth;
					console.log(margin);
					template = template.replace("{{margin}}", margin);
					
				
					

					console.log(10);
					var tag = $(template);
					
					
					//대댓글
					tag.find(".re-reply").click(function(){

						var snsReplyNo = $(this).parent().prevAll(".reply-no").text();

							var reform = $("<form class='mb-4' id='re-from'>");
							reform.append("<div>");
							reform.append("<textarea class='form-control' rows='1' cols='80' name='snsReplyDetail' id='detail'></textarea>");
							reform.append("</div>");
							reform.append("<div>");
							reform.append("<input type='hidden' name='snsReplySuperno' value='"+snsReplyNo+"'>");
							reform.append("</div>");
							reform.append("<div>");
							reform.append("<input type='hidden' name='snsNo' value='"+${snsNo}+"'>");
							reform.append("</div>");
							reform.append("<button type='submit' class='btn btn-sm btn-outline-secondary mt-2'>답글등록</button>");
						
							
						reform.submit(function(e){
							e.preventDefault();
							
							var dataValue = $(this).serialize();
							
							$.ajax({
								url:"${pageContext.request.contextPath}/snsReply/insert",
								type:"post",
								data:dataValue,
								success:function(resp){
									console.log("성공", resp);
									
									$("#result").empty();
									
									page = 1;
									loadList(page,size,snsNo);
									page++;
									
								},
								error:function(e){}
							});
						});
					var reReplyDiv = $(this).parent();
					reReplyDiv.html(reform);
					});
							
					
						
							
					
					
					
						
					
					
					
					
					tag.find(".edit-btn").click(function(){						
					console.log(11);
					var memberNickname = $(this).parent().prevAll(".writer").text();
					var snsReplyDetail = $(this).parent().prevAll(".replyDetail").text();
					var snsReplyNo = $(this).parent().prevAll(".reply-no").text();
						var form = $("<form class='mb-4' id='edit-from'>");
						form.append("<div>");
						form.append("<textarea class='form-control' rows='1' cols='80' name='snsReplyDetail' id='detail'>"+snsReplyDetail+"</textarea>");
						form.append("</div>");
						form.append("<div>");
						form.append("<input type='hidden' name='snsReplyNo' value='"+snsReplyNo+"'>");
						form.append("</div>");
						form.append("<button type='submit' class='btn btn-sm btn-outline-secondary mt-2'>수정</button>");
						
						
						form.submit(function(e){
							e.preventDefault();
							
							var dataValue = $(this).serialize();
							
							console.log(dataValue);
							$.ajax({
								url:"${pageContext.request.contextPath}/snsReply/edit",
								type:"post",
								data:dataValue,
								success:function(resp){
									console.log("성공", resp);
								
									$("#result").empty();
									
									page = 1;
									loadList(page,size,snsNo);
									page++;
									
									
								},
								error:function(e){}
							});
						});	
						
						var div = $(this).parent();
						div.html(form);
					});
					
					
					tag.find(".remove-btn").click(function(){
						console.log($(this).parent().parent().find("span").text());
						$(this).parent().parent().find("span").text();
						
						deleteData($(this).parent().parent().find("span").text(), snsNo);
					});
					
					
					$("#result").append(tag);
					
					
					
				}
				
			},
			error:function(e){}
		});
		
	}
	
	//댓글 삭제
	function deleteData(snsReplyNo, snsNo){
		console.log(10);
		$.ajax({
			url:"${pageContext.request.contextPath}/snsReply/delete?snsReplyNo="+snsReplyNo+"&snsNo="+snsNo,
			type:"delete",
			data:{
				snsReplyNo:snsReplyNo,
				snsNo:snsNo
			},
			dataType:"text",
			success:function(resp){
				console.log("성공", resp);
				
				$("#result").empty();
				
				console.log(snsReplyNo);
				console.log(snsNo);
				page = 1;
				loadList(page,size,snsNo);
				page++;
			},
			error:function(e){}
		});
	}
	
	$(function(){
		$("#replybtn").click(function(e){
			$("#detail").focus();
		});
	});
</script>


<h1 class="center">게시글 상세페이지</h1>

	
<div class="container">
	<div class="row mt-3">
    	<div class="col">
    	</div>
    	<div class="col-7">
     		<div class="card mb-3">
     
     			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
	        		<div class="carousel-indicators">
	          			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	          			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
	          			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
	        		</div>
	        
	        
	        		<div class="carousel-inner">
		       			<c:forEach var="snsFileDto" items="${fileList }" varStatus="i">
							<c:choose>
								<c:when test="${i.index == 0}">
									<div class="carousel-item active">
										<img src="file?snsFileNo=${snsFileDto.snsFileNo }" class="d-block w-100" alt="...">
									</div>
								</c:when>
								<c:otherwise>
									<div class="carousel-item">
										<img src="file?snsFileNo=${snsFileDto.snsFileNo }" class="d-block w-100" alt="...">
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
   					</div>
    			
   
   					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
     					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
     					<span class="visually-hidden">Previous</span>
   					</button>
   					<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
     					<span class="carousel-control-next-icon" aria-hidden="true"></span>
     					<span class="visually-hidden">Next</span>
   					</button>
				</div>


				<!-- 버튼 -->	
				<div class="card-body">
 					<button type="button" class="btn btn-sm btn-outline-secondary" id="liveToastBtn">
           				<!-- 좋아요 아이콘 -->
               			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
							<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
						</svg>
           			</button>
           			
            		&nbsp;&nbsp;
            		
           			<button id="replybtn" type="button" class="btn btn-sm btn-outline-secondary">
           				<!-- 댓글 아이콘 -->
              			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
							<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
							<path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"></path>
						</svg>
           			</button>
           			
            		&nbsp;&nbsp;
            		
           			<!-- 수정 아이콘 -->
           			<button type="button" class="btn btn-sm btn-outline-secondary">
						<a href="edit?snsNo=${snsDto.snsNo }">수정</a>
					</button>
					
             		&nbsp;&nbsp;
             		
            		<!-- 삭제 아이콘 -->
           			<button type="button" class="btn btn-sm btn-outline-secondary">
						<a href="delete?snsNo=${snsDto.snsNo }">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
							  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
							  <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
							</svg>
						</a>
					</button>
            		<!-- 내용 -->
					<pre class="card-text mt-3" id="content">${snsDto.snsDetail }</pre>

     					<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
   				</div>
			</div>


			<!-- 댓글 구간 -->
			<div class="card bg-light">
 				<div class="card-body">
 				
 				
 					<!-- 댓글 전송 폼 -->
					<form class="mb-4" id="insert-form">
						<div>
							<textarea class="form-control" rows="1" placeholder="댓글 입력" name="snsReplyDetail" id="detail"></textarea>
						</div>
						<!-- 숨겨서 보내야 할 것들 -->
						<div>
							<input type="hidden" name="memberNo" value="${loginNo }">
						</div>
						<div>
							<input type="hidden" name="snsNo" value="${snsDto.snsNo }">
						</div>
						<div class="container text-end">
							<button type="button" id="btn" class="btn btn-sm btn-outline-secondary mt-2">등록</button>
						</div>
					</form>

					<div id="result">
							
					</div>
					
					<div>
						<button class="more-btn btn btn-sm btn-outline-secondary mt-2">더보기</button>
					</div>
					
					</div>
				</div>


		</div>
		<div class="col">
		</div>
	</div>
</div>


		
<template id="reply-template">
	<div class="reply" style="margin-left:{{margin}}px">
		<!-- 일반 댓글-->
		<div class="d-flex mb-4">
			<!-- Parent comment-->
			<div class="flex-shrink-0">
				<img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
			</div>
			<div class="ms-3">
				
				<span class="reply-no" style="display:none">{{snsReplyNo}}</span>
				<div class="writer fw-bold">{{writer}}</div>
				<pre class="replyDetail">{{replyDetail}}</pre>
				<div>
				
							<c:choose>
			
								<c:when test="${writer }">
									
									<button class="edit-btn btn btn-sm btn-outline-secondary" data-sns-reply-no="{{snsReplyNo}}">수정</button>
									
									
									
									<button class="remove-btn btn btn-sm btn-outline-secondary">삭제</button>
									<button class="re-reply btn btn-sm btn-outline-secondary">대댓글</button>
								</c:when>
								<c:otherwise>
									<button class="re-reply btn btn-sm btn-outline-secondary">대댓글</button>
								</c:otherwise>
				
							</c:choose>
					
				</div>
			</div>		
		</div>
	</div>
</template>


<template>
	<!-- 대댓글-->
	<div class="d-flex mt-4">
		<div class="flex-shrink-0">
			<img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
		</div>
		<div class="ms-3">
				<div class="fw-bold">
					Commenter Name
				</div>
					And under those conditions, you cannot establish a capital-market evaluation of that enterprise. You can't get investors.
		</div>
	</div>
</template>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>