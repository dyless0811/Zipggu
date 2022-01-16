<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${ses != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>

<link rel="stylesheet" type="text/css" href="${root}/resources/css/member.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>


<!--
<script>
$(function (){
	$("#btn_toggle").click(function (){
  	$("#toggle").toggle();
  });
});
</script>
  -->

<script>
    	//form이 전송되면 input[type=password]가 자동 암호화되도록 설정
    	$(function(){
    		$("form").submit(function(e){
    			//this == form
    			e.preventDefault();//form 기본 전송 이벤트 방지
    			
    			//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
    			$(this).find("input[type=password]").each(function(){
    				//this == 입력창
    				var origin = $(this).val();
    				var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
    				var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
    				$(this).val(encrypt);
    			});
    			
    			this.submit();//form 전송 지시
    		});
    	});
</script>

<script>
$(function(){
	$("#login-button").click(function(){
		login();
	})		
})

/**
* 로그인 
*/
function login(){
	$.ajax({
		url:"/login",
		type :  "POST",
		dataType : "json",
		data : {
			memberId : $("#member-id").val(),
			memberPassword : $("#member-password").val()
		},
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success : function(response){
			if(response.code == "200"){
				// 정상 처리 된 경우
				window.location = response.item.url;	//이전페이지로 돌아가기
			} else {
				alert(response.message);
			}
		},
		error : function(a,b,c){
			console.log(a,b,c);
		}
		
	})
	
}
</script>

<style>

</style>

</head>
<body>

    <main>
    
         <section>


<div class="mainFormL">

	            <div class="logo">
                  <a href="${pageContext.request.contextPath}/" class="aImage">
                      <img src="${pageContext.request.contextPath}/resources/image/logo.png" width="150px" height="80px">
                  </a>
            </div>
            
	<form method="post" class="formContent">

	<%--
		saveId라는 이름의 쿠키가 존재하면 "아이디를 저장한 상태"로 간주
		- 아이디 입력창에 아이디(쿠키에 저장된 값)를 표시
		- 아이디 저장하기 체크박스에 체크 표시
	 --%>
	<div class="formItem"> 
		<input type="email" placeholder="이메일" name="memberEmail" required class="inputItemL" 
				autocomplete="off" value="${cookie.saveId.value}">
	</div>
	<div class="formItem">				
		<input type="password" placeholder="비밀번호" name="memberPw" required class="inputItemL">
	</div>

	<div class="inputSave">
		<label>
			<c:choose>
				<c:when test="${cookie.saveId == null}">
					<input type="checkbox" name="saveId">
				</c:when>
				<c:otherwise>
					<input type="checkbox" name="saveId" checked>
				</c:otherwise>
			</c:choose>
			아이디 저장
		</label>
	</div>

	<div class="row right">
		<input type="submit" value="로그인" class="buttonWrapperL">
	</div>
	
	<div class="action">
	<a href="${pageContext.request.contextPath}/member/passwordReset">비밀번호 재설정</a>
	<a href="${pageContext.request.contextPath}/member/join" style="margin-left: 20px;">회원가입</a>
	</div>	
	

<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
	
	<div class="snsWrapper">
	<div class="snsLoginTitle">
	SNS계정으로 간편 로그인/회원가입
	</div>
	
	<div class="snsList">
	<a class="snsItem" href="${pageContext.request.contextPath}/member/kakaoLogin"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#FFEB00" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#3C2929" d="M24 11.277c8.284 0 15 5.306 15 11.85 0 6.545-6.716 11.85-15 11.85-.92 0-1.822-.066-2.697-.191l-6.081 4.105a.43.43 0 0 1-.674-.476l1.414-5.282C11.777 31.031 9 27.335 9 23.127c0-6.544 6.716-11.85 15-11.85zm6.22 8.407c-.416 0-.718.297-.718.707v5.939c0 .41.289.686.718.686.41 0 .718-.295.718-.686v-1.932l.515-.526 1.885 2.57c.277.374.426.54.691.568.037.003.075.005.112.005.154 0 .66-.04.716-.563.038-.293-.137-.52-.348-.796l-2.043-2.675 1.727-1.743.176-.196c.234-.26.353-.39.353-.587.009-.422-.34-.652-.687-.661-.274 0-.457.15-.57.262l-2.528 2.634v-2.3c0-.422-.288-.706-.717-.706zm-9.364 0c-.56 0-.918.432-1.067.837l-2.083 5.517a.84.84 0 0 0-.065.315c0 .372.31.663.706.663.359 0 .578-.162.69-.51l.321-.97h2.999l.313.982c.111.335.34.498.7.498.367 0 .655-.273.655-.62 0-.056-.017-.196-.081-.369l-2.019-5.508c-.187-.53-.577-.835-1.069-.835zm-2.92.064h-4.452c-.417 0-.642.337-.642.654 0 .3.168.652.642.652h1.51v5.21c0 .464.274.752.716.752.443 0 .718-.288.718-.751v-5.21h1.508c.474 0 .643-.352.643-.653 0-.317-.225-.654-.643-.654zm7.554-.064c-.442 0-.717.287-.717.75v5.707c0 .497.28.794.75.794h2.674c.434 0 .677-.321.686-.627a.642.642 0 0 0-.17-.479c-.122-.13-.3-.2-.516-.2h-1.99v-5.195c0-.463-.274-.75-.717-.75zm-4.628 1.306l.008.01 1.083 3.265h-2.192L20.842 21a.015.015 0 0 1 .028 0z"></path></g></svg></a></li>
	<a class="snsItem" href="${naverAuthUrl}"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#00C63B" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#FFF" d="M21 25.231V34h-7V15h7l6 8.769V15h7v19h-7l-6-8.769z"></path></g></svg></a></li>
	</div>
	
	</div>	
</form>

<!-- <div class="non"> -->
<!-- <button type="button" class="openButton" id="btn_toggle">비회원 주문 조회하기</button> -->
<!-- <div class="nonAction" id="toggle"> -->
<!-- <form> -->
<!-- <input class="inputItemL" name="id" placeholder="주문번호" style="margin-bottom: 10px;"> -->
<!-- <input class="inputItemL" name="email" type="email" placeholder="이메일" style="margin-bottom: 10px;"> -->
<!-- <button class="buttonWrapperL" type="submit">주문조회</button> -->
<!-- </form> -->
<!-- </div>	 -->
<!-- </div> -->
	
	<c:if test="${param.error != null}">
	<div class="row center"> 
		<h4 class="error" style="color: red;">로그인 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>

</div>

</section>
    </main>
</body>
</html>