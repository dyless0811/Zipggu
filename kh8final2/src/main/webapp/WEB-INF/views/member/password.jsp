<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>

	function pwCheck() {
	var regex = /^[A-Za-z0-9!@#$\s_-]{8,16}$/;
	var input = document.querySelector("input[name=changePw]");
	var notice = input.nextElementSibling;

	if (regex.test(input.value)) {
		notice.textContent = "";
		return true;
	} else {
		notice.textContent = "비밀번호는 8~16자 이내의 영문,숫자,특수문자로 작성하세요";
		return false;
	}
}

function pw2Check() {
	//비밀번호 확인은 비밀번호 입력창 2개가 필요하다.
	var pwInput = document.querySelector("input[name=changePw]");
	var pw2Input = document.querySelector("input[name=changePw2]");
	var notice = pw2Input.nextElementSibling;
	//비밀번호 일치 = 입력창이 비어있지 않고 두 비밀번호 입력값이 같은 경우
	if (pwInput.value.length > 0 && pwInput.value == pw2Input.value) {
		notice.textContent = "";
		return true;
	} else {
		notice.textContent = "비밀번호가 일치하지 않습니다";
		return false;
	}
}


function formCheck() {
	if(pwCheck() && pw2Check()){
		
		alert('비밀번호 변경이 완료되었습니다');
		$('form').submit();
		
	}else{
		alert('비밀번호가 올바르지 않습니다.');
		return
	}
	return pwCheck() && pw2Check();
}	





</script>

<style>
a:link {
	color: #424242;
	text-decoration: none;
}

a:visited {
	color: #424242;
	text-decoration: none;
}

li {
	margin: 0 10px;
}

.passwordTitle {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 15px;
}

.page-navigation__item>a.active, .page-navigation__item>a:not(.active):hover {
    color: #35c5f0;
}
.page-navigation__item>a {
    display: block;
    padding: 0 10px;
    font-weight: 700;
    position: relative;
    height: 60px;
    line-height: 60px;
    transition: color .15s ease;
    font-size: 15px;
}

.page-navigation__item {
    display: inline-block;
}

ul{
margin-bottom: 0px;
}

.passwordWrap {
    width: 480px;
    padding: 40px;
    color: #292929;
    box-shadow: 0 1px 3px 0 rgb(0 0 0 / 20%);
    margin: 50px auto;
}

.passwordSection {
    line-height: 1.5;
}

.passwordSectionTitle {
    font-weight: 700;
    margin-bottom: 5px;
}

.expertFormGroup {
    padding: 20px 0;
}



.form-control {
    transition: border-color .2s,box-shadow .2s,background-color .2s;
    display: block;
    box-sizing: border-box;
    height: 40px;
    width: 100%;
    padding: 0 15px;
    line-height: 40px;
    border-radius: 4px;
    border: 1px solid #dbdbdb;
    background-color: #fff;
    color: #424242;
    font-size: 12px;
    font-size: 15px;
    border-radius: 6px;
    text-align: center;  
}

.subTitle{
	font-size: 13px;
}

.update-password__submit {
    width: 100%;
}

.passwordButton{
    padding: 11px 10px;
    font-size: 17px;
    line-height: 26px;
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff;
    display: inline-block;
    margin-top: 10px;
    box-sizing: border-box;
    border: 1px solid transparent;
    font-family: inherit;
    font-weight: 700;
    text-decoration: none;
    text-align: center;
    border-radius: 4px;
}

.notice{
	font-size: 13px;
	color: red;
}

</style>

<div>

	<div class="menu-container">
		<nav class="menu-nav">
			<ul style="transform: translateX(0px);">
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/page?memberNo=${loginNo}">프로필</a></li>
				<li class="page-item"><a href="#">나의 쇼핑</a></li>
				<li class="page-item"><a href="#">나의 리뷰</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/member/profileEdit" class="active">설정</a></li>
			</ul>
		</nav>
		<nav class="menu-nav">
		<ul style="transform: translateX(0px);">
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/profileEdit">회원정보수정</a></li>
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/password" class="active">비밀번호 변경</a></li>
		</ul>
		</nav>
	</div>


<div class="passwordWrap">
		<div class="passwordTitle">비밀번호 변경</div>
	
		
	<div>	
	
	<form method="post">
	
		<div class="passwordSection">
		
			<div class="passwordSectionTitle">새 비밀번호</div>
			<div class="subTitle">비밀번호는 8~16자 이내의 영문,숫자,특수문자로 작성하세요</div>		
		
		</div>			
					
			<div class="expertFormGroup">
				<div class="infoFormItemField">
					<input type="password" name="changePw" class="form-control" required onblur="pwCheck();">
					<div class="notice"></div>
				</div>
			</div>		


		<div class="passwordSection">
			<div class="passwordSectionTitle">새 비밀번호</div>	
		</div>			
					
			<div class="expertFormGroup">
				<div class="infoFormItemField">
					<input type="password" name="changePw2"  class="form-control" required onblur="pw2Check();">
					<div class="notice"></div>
				</div>
			</div>		

		<div class="d-grid gap-2">
			<button type="button" class="passwordButton" onclick="formCheck()">비밀번호 변경</button>
		</div>

	</form>
	</div>
</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>