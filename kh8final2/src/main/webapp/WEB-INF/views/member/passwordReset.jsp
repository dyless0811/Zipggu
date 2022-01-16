<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 페이지에서 사용할 JSTL 변수 --%>
<c:set var="login" value="${loginNo != null}"></c:set>
<c:set var="admin" value="${grade == '관리자'}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" type="text/css"
	href="${root}/resources/css/member.css">
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/sha1.min.js"></script>

<script>
	//form이 전송되면 input[type=password]가 자동 암호화되도록 설정
	$(function() {
		$("form").submit(function(e) {
			//this == form
			e.preventDefault();//form 기본 전송 이벤트 방지
			
			//모든 비밀번호 입력창에 SHA-1 방식 암호화 지시(32byte 단방향 암호화)
			$(this).find("input[type=password]").each(function() {
				//this == 입력창
				var origin = $(this).val();
				var hash = CryptoJS.SHA1(origin);//암호화(SHA-1)
				var encrypt = CryptoJS.enc.Hex.stringify(hash);//암호화 값 문자열 변환
				$(this).val(encrypt);
			});

			this.submit();//form 전송 지시/^[0-9a-zA-Z]([-]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/
		});
	});
</script>

<script>
	var checkCode = false;
	var checkEmail = false;
	var emailSave = "";
	
	$(function() {
		
	/* 인증번호 전송 */

		var number = "";
		
		$("#emailChk").click(function(e) {
			e.preventDefault();
			
							var memberEmail = $("#email").val();
							$.ajax({

										url : "${pageContext.request.contextPath}/member/mailCheck?memberEmail=" + memberEmail,
										type : "get",
										dataType : "text",
										success : function(data) {
											if (data == "error") {
												$("#email").attr("disabled", false);
												$("#emailChk").attr("disabled", false);
												$(".passwordDIv").css("display", "none");				
											} else {
												$(".inputItemJ").attr("readonly", true);
												$("#emailChk2").css("display","inline-block");
												$(".successEmail").css("display", "none")
												$(".disNone").css("display","inline-block")
												$("#emailChk2").attr("disabled", false);
												$("#serialChk").attr("readonly", false);
												$("#timerC").css("display","inline-block");
												$("#emailChk").text("이메일 재발송 하기");
												checkCode = false;
												
												number = data;			
											}
										}

									});
						});

		
		/* 인증번호 비교 */
		$("#emailChk2").click(function(e) {
			e.preventDefault();
							var memberEmail = $("#email").val();
							var serial = $("#serialChk").val();

							$.ajax({
										url : "${pageContext.request.contextPath}/member/serialCheck?memberEmail=" + memberEmail + "&serial=" + serial,
										type : "get",
										dataType : "text",
										async: false,
										success : function(data) {
									
											if (data != "" || serial != "") {		
											if (data == serial) {
												$(".successEmail").attr("disabled", true);
												$("#emailChk2").attr("disabled", true);
												$("#email").attr("readonly",true);
												$("#emailChk").attr("disabled",true);
												$("#emailChk").attr("readonly",true);
												$("#serialChk").attr("readonly", true);
												$(".inputTop").attr("disabled",true)
												$(".successEmailChk").css("display", "none");
												$("#serialForm").css("display", "none");
												$("#emailChk").text("이메일 인증 완료");		
												$(".passwordDIv").css("display", "inline-block");
												emailSave = $("#email").val();		
												checkCode = true;
												
												console.log("여긴 인증완료", emailSave)
												console.log(checkCode);
												
											} else {
												
												$(".successEmailChk").text("인증번호가 일치하지 않습니다.");
												$(".successEmailChk").css("color", "red");
												$("#serialChk").attr("autofocus", true);				
												checkCode = false;
												console.log(checkCode);
											}
										}		
										}
									});					
						});
				});	
	
					function emailCheck() {

						var input = document.querySelector("input[name=memberEmail]");
						var notice = input.nextElementSibling;
				
						if (input.value == emailSave) {

							
							console.log("이메일체크완료",emailSave);
							
							return true;
						} else {
							$(".successEmail").attr("disabled", false);
							$("#emailChk2").attr("disabled", false);
							$("#email").attr("readonly",false);
							$("#emailChk").attr("disabled",false);
							$("#emailChk").attr("readonly",false);
							$("#serialChk").attr("readonly", false);
							$(".inputTop").attr("disabled",false)
							$(".successEmailChk").css("display", "inline-block");
							$("#emailChk").text("이메일 인증 하기");		
							$(".passwordDIv").css("display", "none");

							console.log("이메일체크실패",emailSave);
							return false;
						}
					}
					
	

		   function emailConfirm(){
		        var memberEmail = $("#email").val();
		        
		        $.ajax({
		            url:"${pageContext.request.contextPath}/member/emailConfirm", 
		            type:"post", 
		            data:{memberEmail:memberEmail},
					dataType : "text",
		            success:function(emailConfirm){
		            	console.log("성공",emailConfirm)
		                if(emailConfirm != 0) {
							$("#emailChk").attr("disabled", false);
							$("#emailConfirm").text("");					
							checkEmail = true;
		                } else {
		                    $("#emailConfirm").text("등록된 이메일 주소가 아닙니다.");
							$("#emailChk").attr("disabled", true);
							checkEmail = false;							
		                }
		            },
					error:function(e){
						console.log("실패", e);
					}
		        });
		    };
		    

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
			if(checkEmail && checkCode && pwCheck() && pw2Check() && emailCheck()){
				
				alert('비밀번호 재설정이 완료되었습니다');
				$('form').submit();
				
			}else{
				alert('회원 정보가 올바르지 않습니다.');
				return false;
			}
			
		}			
				
 	
</script>

<script>
	var timer = null;
	var isRunning = false;
	$(function() {

		$(".btn_recive_num").click(function(e) {
			var display = $('.timer');
			var leftSec = 180;
			// 남은 시간
			// 이미 타이머가 작동중이면 중지
			if (isRunning) {
				clearInterval(timer);
				display.html("");
				startTimer(leftSec, display);
			} else {
				startTimer(leftSec, display);

			}
		});
	})

	function startTimer(count, display) {

		var minutes, seconds;
		timer = setInterval(function() {
			minutes = parseInt(count / 60, 10);
			seconds = parseInt(count % 60, 10);

			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;

			display.html(minutes + ":" + seconds);

			// 타이머 끝
			if (--count < 0) {
				clearInterval(timer);
				display.html("시간초과");
				$(".btn_chk").attr("disabled", true);
				$("#serialChk").attr("disabled", true);
				$("#serialChk").css("background", "#fff");
				isRunning = false;
			}
		}, 1000);
		isRunning = true;
	}
	
</script>

<script>

 
	
</script>

<style>
.inputItemC {
	display: none;
	width: 100%;
	margin: 0;
	padding: 8px 15px 9px;
	border: 1px solid #dbdbdb;
	background-color: #fff;
	color: #000;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 15px;
	line-height: 21px;
	transition: border-color .1s, background-color .1s;
	resize: none;
	-webkit-appearance: none;
}

.disNone {
	display: none;
	width: 100%;
}

.inputContainer {
	display: block;
	border: 1px solid rgb(219, 219, 219);
	min-height: 45px;
	padding: 0px 16px;
	background: rgb(255, 255, 255);
	margin-bottom: 10px;
	height: 72px;
}

.inputTop {
	display: flex;
	-webkit-box-align: center;
	align-items: center;
	height: 45px;
	-webkit-box-pack: justify;
	justify-content: space-between;
	max-width: 360px
}

.inputSerial {
	border: none;
	font-size: 15px;
	line-height: 15px;
	flex: 1 0 0px;
}

.timer {
	color: rgb(255, 119, 119);
	margin-right: 20px;
}

.oKButton {
	white-space: pre;
	height: 31px;
	font-size: 14px;
	line-height: 17px;
	padding: 7px 10px;
	box-sizing: border-box;
	background-color: #35c5f0;
	border-color: #35c5f0;
	color: #fff;
	border-color: #35c5f0;
	border: 1px solid;
}

.inputSerial:focus {
	outline: none;
}

.serialForm {
	overflow: hidden;
	margin-bottom: 30px;
}

.errorMessage {
	font-size: 12px;
	padding-bottom: 15px;
}

#emailChk2:hover {
	cursor: pointer;
}

#emailChk:hover {
	background-color: rgba(53, 197, 240, 0.1);
	cursor: pointer;
}

.oKButton:disabled {
	background-color: #a3e4f8;
	border-color: #a3e4f8;
	color: #e5f9ff;
	cursor: none;
}

.inputItemJ:disabled {
	background-color: #ededed;
	border-color: #dbdbdb;
	color: #bdbdbd;
}

.email-button:disabled {
	background: rgb(247, 248, 250);
	color: rgb(194, 200, 204);
	border-color: rgb(218, 220, 224);
	pointer-events: none;
}

.notice {
	font-size: 12px;
	color: red;
}

.sMessage {
	font-size: 13px;
	line-height: 20px;
	margin-bottom: 12px;
}

.sWrapper {
	width: 400px;
	min-height: 143px;
	box-sizing: border-box;
	background: rgb(247, 248, 250);
	padding: 20px 16px;
	margin: 0 auto;
}

.resendWrapper {
	font-size: 12px;
	color: rgb(130, 140, 148);
	display: flex;
	-webkit-box-align: center;
	align-items: center;
}

.sighForm {
	display: flex;
	width: 400px;
	margin: 0 auto;
	padding-top: 0px;
	padding-bottom: 60px;
}

body {
	overflow-y: scroll;
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
	width: 400px;
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
</style>

</head>

<body>

	<main>

		<section>

	        <div class="logo">
                  <a href="${pageContext.request.contextPath}/" class="aImage">
                      <img src="${pageContext.request.contextPath}/resources/image/logo.png" width="150px" height="80px">
                  </a>
            </div>

			<div class="mainFormL">
			

				<form method="post" enctype="multipart/form-data">

					<div class="row center">
						<h1 class="title-h1">비밀번호 재설정</h1>
					</div>

					<div class="row" style="width: 400px">
						<label class="title-type formItem">가입한 이메일 주소를 입력해주세요.</label> 
						<input type="email" name="memberEmail" placeholder="이메일" autocomplete="off" class="inputItemJ" oninput = "emailConfirm()" id="email"   onkeyup="emailCheck()" required>
						<div class="notice"></div>
						<div id="emailConfirm" style="font-size: 12px; color: red;"></div>
					</div>
					
					<div class="div-button">
						<button type="button"
							class="email-button doubleChk btn_recive_num" id="emailChk">이메일 인증하기</button>
						<span class="point successEmail"></span>
					</div>

					<div class="serialForm disNone" id="serialForm">
						<div class="sWrapper">
							<div class="sMessage">이메일로 전송된 인증코드를 입력해주세요.</div>
							<div class="inputContainer">
								<div class="inputTop">
									<input id="serialChk" type="text" name="serial" readonly
										placeholder="인증번호 6자리 입력" required class="inputSerial"
										autocomplete="off" maxlength="6" >
									<span class="timer" id="timerC">00:00</span>
									<button type="button" class="oKButton doubleChk btn_chk"
										id="emailChk2" disabled>확인</button>
								</div>
								<div class="errorMessage">
									<span class="point successEmailChk" id="spanC"></span>
								</div>
							</div>
						</div>
						<div class="resendWrapper"></div>
					</div>


			<div class="passwordDIv" style="display: none;">
		
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
				
			</div>

				</form>

			</div>

		</section>
	</main>
</body>
</html>

