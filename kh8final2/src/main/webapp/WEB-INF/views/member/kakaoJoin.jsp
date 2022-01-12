<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="loginEmail" value="${memberListVO.memberEmail}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

var checkNick = false;

function emailCheck() {

	var input = document.querySelector("input[name=memberEmail]");
	var notice = input.nextElementSibling;
	var loginEmail = '${loginEmail}';
	
	if (loginEmail == $("input[name=memberEmail]").val() ) {
		return true;
	} else {
		$(".notice").css("color", "red");
		notice.textContent = "이메일 변경이 불가합니다";
		return false;
	}
}

function nicknameCheck() {
	var regex = /^[가-힣0-9]{2,10}$/;
	var input = document.querySelector("input[name=memberNickname]");
	var notice = input.nextElementSibling;

	if (regex.test(input.value)) {
		notice.textContent = "";
		return true;
	} else {
		notice.textContent = "닉네임은 한글, 숫자 2~10자로 작성하세요";
		return false;
	}
}


function nickConfirm(){
    var memberNickname = $("#nick").val();     
    
    $.ajax({
        url:"${pageContext.request.contextPath}/member/nickConfirm", 
        type:"post", 
        data:{memberNickname:memberNickname},
		dataType : "text",
        success:function(nickConfirm){
            if(nickConfirm == 0){
            	console.log("nickConfirm",nickConfirm);
				$("#nickConfirm").text("");
				checkNick = true;
				
            } else {
                $("#nickConfirm").text("사용 중인 별명입니다.");
                checkNick = false;
            }
        },
		error:function(e){
			console.log("실패", e);
		}
    });
};   

$(document).ready(function() {
	$("#selectall").click(function() {
		if($("#selectall").is(":checked")) {
			$("input[name=selectItem]").prop("checked", true);
			$("input[name=selectItem2]").prop("checked", true);
		} else{
			$("input[name=selectItem]").prop("checked", false);
			$("input[name=selectItem2]").prop("checked", false);
		}
	});

	$(".checkall").click(function() {
		var total = $("input[name=selectItem]").length + $("input[name=selectItem2]").length;
		var checked = $("input[name=selectItem]:checked").length + $("input[name=selectItem2]:checked").length;

		console.log("total",total);
		console.log("checked",checked);
		if(total != checked) $("#selectall").prop("checked", false);
		else $("#selectall").prop("checked", true); 
	});
});	

function formCheck() {
	if(emailCheck() && nicknameCheck() && checkNick && $("input:checkbox[name=selectItem]").is(":checked") == true){
		
		alert('회원 가입이 완료되었습니다');
		$('form').submit();
		
	}else{	
		
		alert('회원 정보가 올바르지 않습니다.');
		return false;
		
	}
}	

</script>

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
    font-size: 12px;
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
    margin-top: 10px;
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

.topBottom{
	padding: 100px 0px;
}

.sns-sign-up {
    margin: 30px auto;
    width: 100%;
    max-width: 360px;

    color: #292929;
}

.sns-sign-up__title {
    font-size: 20px;
    font-weight: 700;
    margin-bottom: 25px;
}

.user-sign-up-form__form-group {
    margin: 0 0 20px;
}

.notice {
	font-size: 12px;
	color: red;
}

</style>

<div class="topBottom">

<div class="sns-sign-up">

<form method="post">

		<input type="hidden" name="memberPw"  value="${memberListVO.memberPw}">
		<input type="hidden" name="memberType"  value="카카오">


	<div class="sns-sign-up__title">
		<div class="title-h1">추가 정보 입력</div>
	</div>
	
	<div class="user-sign-up-form__form-group">
	<div class="sns-sign-up -input">
		<input type="text" name="memberEmail" value="${memberListVO.memberEmail}" autocomplete="off" required class="inputItem" readonly onkeyup="emailCheck();">
		<div class="notice"></div>
	</div>
	</div>

	<div class="user-sign-up-form__form-group">
	<div class="sns-sign-up -input">
		<input type="text" name="memberNickname" value="${memberListVO.memberNickname}" placeholder="닉네임을 입력해주세요" autocomplete="off"  required class="inputItem"  id="nick" oninput = "nickConfirm()"  onblur="nicknameCheck();">
		<div class="notice"></div>
		<div id="nickConfirm" style="font-size: 12px; color: red;"></div>
	</div>
	</div>

	<div class="user-sign-up-form__form-group">
		<div class="div-check">
		
							<div class="div-check-one div-ob">
								<input type="checkbox"  name="selectall" class="check-button check-size " id="selectall">
								<label class="check-all">전체동의</label>
							</div>

							<div class="div-check-two div-ob">
								<input type="checkbox" name="selectItem" class="check-button check-size checkall" required>
								<span class="check-text">만 14세 이상입니다.</span> <span
									class="check-text-ob">(필수)</span>
							</div>

							<div class="div-check-two div-ob">
								<input type="checkbox" name="selectItem" class="check-button check-size checkall" required>
								<a href="usepolicy" target=”_blank” style="text-decoration : underline"><span class="check-text">이용약관</span></a>
								<span class="check-text-ob">(필수)</span>
							</div>

							<div class="div-check-two div-ob">
								<input type="checkbox" name="selectItem" class="check-button check-size checkall" required>
								<a href="privacy" target=”_blank” style="text-decoration : underline"  >
								<span class="check-text">개인정보수집 및 이용동의</span></a> <span class="check-text-ob">(필수)</span>
							</div>

							<div class="div-check-two div-ob">
								<input type="checkbox" name="selectItem2" class="check-button check-size checkall">
								<span class="check-text">이벤트, 프로모션 알림 메일 및 SMS 수신</span> <span
									class="check-text-ob2">(선택)</span>
							</div>
		
		</div>
	</div>
	
	<div class="user-sign-up-form__form-group">
		<button type="button" class="buttonWrapper" onclick="formCheck()">회원가입 완료</button>
	</div>
	
</form>

</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
