<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.searchButton{
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff;
    padding: 0px 30px;
    }
    
    .pageButton{}
</style>

<jsp:include page="/WEB-INF/views/template/adminHdr.jsp"></jsp:include>


<div class="container-zipggu">
<h2 class="mb-5">회원 목록</h2>
<table class="table">
    <thead>
      <tr>
         <th>회원번호</th>
         <th>이메일</th>
         <th>닉네임</th>
         <th>생년월일</th>
         <th>성별</th>
         <th>회원등급</th>
         <th>구분</th>
         <th>가입일</th>
      </tr>
    </thead>
    <tbody>
     		<c:forEach var="memberDto" items="${memberPageVO.list}">
      <tr>
         <td><a href="#">${memberDto.memberNo}</a></td>
         <td>${memberDto.memberEmail}</td>
         <td>${memberDto.memberNickname}</td>
		<c:choose>
			<c:when test="${memberDto.memberBirth == null}">
				<td>${memberDto.memberBirth}</td>
			</c:when>
			<c:otherwise>
       			<td>${memberDto.getMemberBirthDay()}</td>
			</c:otherwise>	            
		</c:choose>				         
         <td>${memberDto.memberGender}</td>
         <td>${memberDto.memberGrade}</td>
         <td>${memberDto.memberType}</td>
         <td>${memberDto.getMemberJoinDay()}</td>

      </tr>
       		</c:forEach>
    </tbody>
   </table>
   
<!-- 페이지 네이션 및 검색 -->
 	<div class="row center">
		<div class="col">
		</div>
		<div class="col center" >
		<!-- 이전 버튼 -->
			<ul class="pagination pagination-lg center" style="justify-content: center;">
			<c:choose>
				<c:when test="${memberPageVO.isPreviousAvailable()}">
					<c:choose>
						<c:when test="${memberPageVO.isSearch()}">
							<li class="page-item">
							<!-- 검색용 링크 -->
							<a href="memberList?column=${memberPageVO.column}&keyword=${memberPageVO.keyword}&p=${memberPageVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="page-item">
							<a href="memberList?p=${memberPageVO.getPreviousBlock()}" class="page-link">&lt;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class=""><a class="page-link">◀</a></li>
				</c:otherwise>
			</c:choose>
		
			<!-- 페이지 네비게이터 -->
			<c:forEach var="i" begin="${memberPageVO.getStartBlock()}" end="${memberPageVO.getRealLastBlock()}" step="1">
				
				<c:choose>
					<c:when test="${memberPageVO.isSearch()}">
						<li class="">
						<!-- 검색용 링크 -->
						<a href="memberList?column=${memberPageVO.column}&keyword=${memberPageVO.keyword}&p=${i}" class="page-link">${i}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="">
						<!-- 목록용 링크 -->
						<a href="memberList?p=${i}" class="page-link">${i}</a>
						</li>
					</c:otherwise>
				</c:choose>
			
			</c:forEach>
	
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${memberPageVO.isNextAvailable()}">
					<c:choose>
						<c:when test="${memberPageVO.isSearch()}">
							<!-- 검색용 링크 -->
							<li class="page-item">
								<a href="memberList?column=${memberPageVO.column}&keyword=${memberPageVO.keyword}&p=${memberPageVO.getNextBlock()}" class="page-link">&gt;</a>
						</c:when>
						<c:otherwise>
							<!-- 목록용 링크 -->
							<li class="">
								<a href="memberList?p=${memberPageVO.getNextBlock()}" class="page-link">&gt;</a>
							</li>					
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class=""><a class="page-link">▶</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div class="col">
		</div>
	</div>
	
	<!-- 검색창 -->

	<div style='display:flex;justify-content: center;'>
		<div>
			<form method="get" class="d-flex">
			
				<select name="column" class="form-input form-inline">
					<c:choose>
						<c:when test="${MemberPageVO.columnIs('member_no')}">
						<option value="member_no" selected>회원번호</option>
						<option value="member_email">이메일</option>
						<option value="member_nickname">닉네임</option>
						<option value="member_type">구분</option>
					</c:when>
					
					<c:when test="${MemberPageVO.columnIs('member_email')}">
						<option value="member_no">회원번호</option>
						<option value="member_email" selected>이메일</option>
						<option value="member_nickname">닉네임</option>
						<option value="member_type">구분</option>
					</c:when>
	
					<c:when test="${MemberPageVO.columnIs('member_type')}">
						<option value="member_no">회원번호</option>
						<option value="member_email" >이메일</option>
						<option value="member_nickname">닉네임</option>
						<option value="member_type" selected>구분</option>
					</c:when>	
					
					<c:otherwise>
						<option value="member_no">회원번호</option>
						<option value="member_email">이메일</option>
						<option value="member_nickname" selected>닉네임</option>
						<option value="member_type">구분</option>
					</c:otherwise>
					</c:choose>
				</select>
				
				<input type="search" name="keyword" placeholder="검색어 입력" required autocomplete="off"
						value="${MemberPageVO.keyword}" class="form-input form-inline">
				
				<input type="submit" value="검색" class="searchButton">
			</form>
		</div>
</div>
</div>


<jsp:include page="/WEB-INF/views/template/adminFtr.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>