<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.title-h1{
    font-size: 20px;
    font-weight: bold;
    text-align: left;
    }

.title-text{
    margin-bottom: 10px;
    font-size: 13px;
    color: #757575;
    line-height: 1.4;
}

.title-type{
    display: block;
    margin: 0 0 12px;
    font-size: 15px;
    font-weight: bold;
    color: #292929;
    line-height: 21px;
    word-break: keep-all;
}   

.snsWrapper {
    margin: 30px 0px;
    padding-bottom: 30px;
    border-bottom: 1px solid rgb(237, 237, 237);
}

.snsLoginTitle {
    font-size: 12px;
    text-align: center;
    margin: 15px 0px;
    color: rgb(117, 117, 117);
}

.snsList {
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
}

.snsItem {
    margin: 0px 10px;
}

.inputItem {
    display: inline-block;
    width: 100%;
    margin: 0;
    padding: 8px 15px 9px;
    border: 1px solid #dbdbdb;
    background-color: #fff;
    color: #000;
    border-radius: 4px;
    box-sizing: border-box;
    font-family: Noto Sans KR,Noto Sans CJK KR,ë§‘ì€ ê³ ë”•,Malgun Gothic,sans-serif;
    font-size: 15px;
    line-height: 21px;
    transition: border-color .1s,background-color .1s;
    resize: none;
    -webkit-appearance: none;
}

.check-all{
    font-size: 14px;
    color: #424242;
    line-height: 18px;
    font-weight: bold;
    padding-left: 7px;
}

.check-select{
    font-size: 14px;
    color: #424242;
    line-height: 18px;
}

.check-text{
    font-size: 14px;
    color: #424242;
    line-height: 18px;
    padding-left: 7px;
}

.check-text-ob{
    color: #35c5f0;
    font-size: 12px;
    margin-left: 4px;
}

.check-text-ob2{
    color: #bdbdbd;
    font-size: 12px;
    margin-left: 4px;
}

.check-form{
    display: inline-flex;
    align-items: center;
    vertical-align: middle;
    width: 100%;
}

.check-box{
position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    cursor: inherit;
    opacity: 0;
    box-sizing: border-box;
}

.check-button{
    position: relative;
    display: inline-block;
    font-size: 0;
    padding: 9px;
}

.div-check{
	border: solid 1px #dbdbdb;
    padding: 0 23px 6px 16px;
    height: 235px;
}

.div-check-one{
    border-bottom: 1px solid #ededed;
    height: 70px;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
}

.div-check-two{
    height: 40px;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
}

.div-ob{
	display: inline-flex;
    align-items: center;
    vertical-align: middle;
    width: 100%;
}

input[type="checkbox"]{
	width: 22px;
	height: 22px;
}

.buttonWrapper{
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff;
    width: 100%;
    display: inline-block;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    border: 1px solid transparent;
    font-weight: 700;
    text-decoration: none;
    text-align: center;
    border-radius: 4px;
    cursor: pointer;
    padding: 11px 10px;
    font-size: 17px;
    line-height: 26px;
}
</style>

<h4>email = ${email}</h4>
<h4>password= ${password}</h4>
<h4>nickname = ${nickname}</h4>

<div class="container-400 container-center">

<form method="post">
		<input type="hidden" name="memberPassword"  value="${password}">


	<div class="row center">
		<h1 class="title-h1">추가 정보 입력</h1>
	</div>
	
	<div class="row">
		<input type="text" name="memberEmail" value="${email}" autocomplete="off" required class="inputItem" readonly>
	</div>

	<div class="row">
		<input type="text" name="memberNickname" placeholder="닉네임을 입력해주세요" autocomplete="off"  required class="inputItem">
	</div>
	

		<div class="div-check">
		
		<div class="div-check-one div-ob">
		<input type="checkbox" name="" class="check-button" >
		<label class="check-all">전체동의</label>
		</div>
	
		<div class="div-check-two div-ob">	
		<input type="checkbox" name="" class="check-button" >
		<span class="check-text">만 14세 이상입니다.</span>
		<span class="check-text-ob">(필수)</span>
		</div>
		
		<div class="div-check-two div-ob">	
		<input type="checkbox" name="" class="check-button" >
		<a href="usepolicy" target=”_blank”><span class="check-text">이용약관</span></a>
		<span class="check-text-ob">(필수)</span>
		</div>
		
		<div class="div-check-two div-ob">	
		<input type="checkbox" name="" class="check-button" >
		<a href="privacy" target=”_blank”><span class="check-text">개인정보수집 및 이용동의</span></a>
		<span class="check-text-ob">(필수)</span>
		</div>
		
		<div class="check-select div-ob">	
		<input type="checkbox" name="" class="check-button" >
		<span class="check-text">이벤트, 프로모션 알림 메일 및 SMS 수신</span>
		<span class="check-text-ob2">(선택)</span>
		</div>
		
		</div>
	
	
	<div class="row">
		<input type="submit" value="회원가입 완료" class="buttonWrapper">
	</div>

</form>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>