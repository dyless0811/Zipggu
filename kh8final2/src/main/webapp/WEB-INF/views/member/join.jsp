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
	var checkNick = false;
	
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
												
											} else {
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
												checkCode = true;
												
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
			var regex = /^[0-9a-zA-Z]([-]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			var input = document.querySelector("input[name=memberEmail]");
			var notice = input.nextElementSibling;

			if (input.value.length == 0 || regex.test(input.value)) {
				notice.textContent = "";
				return true;
			} else {
				notice.textContent = "이메일 형식이 올바르지 않습니다";
				return false;
			}
		}


		function pwCheck() {
			var regex = /^[A-Za-z0-9!@#$\s_-]{8,16}$/;
			var input = document.querySelector("input[name=memberPw]");
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
			var pwInput = document.querySelector("input[name=memberPw]");
			var pw2Input = document.querySelector("input[name=memberPw2]");
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

		   function emailConfirm(){
		        var memberEmail = $("#email").val();
		        
		        $.ajax({
		            url:"${pageContext.request.contextPath}/member/emailConfirm", 
		            type:"post", 
		            data:{memberEmail:memberEmail},
					dataType : "text",
		            success:function(emailConfirm){
		            	console.log("성공",emailConfirm)
		                if(emailConfirm == 0){
							$("#emailChk").attr("disabled", false);
							$("#emailConfirm").text("");					
							checkEmail = true;
		                } else {
		                    $("#emailConfirm").text("이미 가입한 이메일입니다.");
							$("#emailChk").attr("disabled", true);
							checkEmail = false;							
		                }
		            },
					error:function(e){
						console.log("실패", e);
					}
		        });
		    };
		    
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
			if(emailCheck() && pwCheck() && pw2Check() && nicknameCheck()  && checkNick && checkEmail && checkCode && $("input:checkbox[name=selectItem]").is(":checked") == true){
				
				alert('회원 가입이 완료되었습니다');
				$('form').submit();
				
			}else{
				alert('회원 정보가 올바르지 않습니다.');
				return false;
			}
			
		}			
				
// 		function EmailCheck(){
// 			if(checkCode){
// 				return true;
// 			}else{
// 				alert('이메일 인증을 먼저 해주세요.');	
// 				return false;
// 			}
// 		}
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
	padding: 60px 0;
}

body {
	overflow-y: scroll;
}
</style>

</head>

<body>

	<main>

		<section>

			<div class="sighForm">

				<form method="post" enctype="multipart/form-data">

					<div class="row center">
						<h1 class="title-h1">회원가입</h1>
					</div>

					<div class="snsWrapper">
						<div class="snsLoginTitle">SNS계정으로 간편하게 회원가입</div>
						<div class="snsList">
							<a class="snsItem" href="#"><svg width="48" height="48"
									viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet">
									<g fill="none" fill-rule="evenodd">
									<path fill="#FFEB00"
										d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path>
									<path fill="#3C2929"
										d="M24 11.277c8.284 0 15 5.306 15 11.85 0 6.545-6.716 11.85-15 11.85-.92 0-1.822-.066-2.697-.191l-6.081 4.105a.43.43 0 0 1-.674-.476l1.414-5.282C11.777 31.031 9 27.335 9 23.127c0-6.544 6.716-11.85 15-11.85zm6.22 8.407c-.416 0-.718.297-.718.707v5.939c0 .41.289.686.718.686.41 0 .718-.295.718-.686v-1.932l.515-.526 1.885 2.57c.277.374.426.54.691.568.037.003.075.005.112.005.154 0 .66-.04.716-.563.038-.293-.137-.52-.348-.796l-2.043-2.675 1.727-1.743.176-.196c.234-.26.353-.39.353-.587.009-.422-.34-.652-.687-.661-.274 0-.457.15-.57.262l-2.528 2.634v-2.3c0-.422-.288-.706-.717-.706zm-9.364 0c-.56 0-.918.432-1.067.837l-2.083 5.517a.84.84 0 0 0-.065.315c0 .372.31.663.706.663.359 0 .578-.162.69-.51l.321-.97h2.999l.313.982c.111.335.34.498.7.498.367 0 .655-.273.655-.62 0-.056-.017-.196-.081-.369l-2.019-5.508c-.187-.53-.577-.835-1.069-.835zm-2.92.064h-4.452c-.417 0-.642.337-.642.654 0 .3.168.652.642.652h1.51v5.21c0 .464.274.752.716.752.443 0 .718-.288.718-.751v-5.21h1.508c.474 0 .643-.352.643-.653 0-.317-.225-.654-.643-.654zm7.554-.064c-.442 0-.717.287-.717.75v5.707c0 .497.28.794.75.794h2.674c.434 0 .677-.321.686-.627a.642.642 0 0 0-.17-.479c-.122-.13-.3-.2-.516-.2h-1.99v-5.195c0-.463-.274-.75-.717-.75zm-4.628 1.306l.008.01 1.083 3.265h-2.192L20.842 21a.015.015 0 0 1 .028 0z"></path></g></svg></a>
							<a class="snsItem" href="${naverAuthUrl}"><svg width="48"
									height="48" viewBox="0 0 48 48"
									preserveAspectRatio="xMidYMid meet">
									<g fill="none" fill-rule="evenodd">
									<path fill="#00C63B"
										d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path>
									<path fill="#FFF"
										d="M21 25.231V34h-7V15h7l6 8.769V15h7v19h-7l-6-8.769z"></path></g></svg></a>

						</div>

					</div>

					<div class="row">
						<label class="title-type">이메일</label> <input type="email"
							name="memberEmail" placeholder="이메일" autocomplete="off"
							class="inputItemJ" id="email" oninput = "emailConfirm()" required onblur="emailCheck();" >
						<div class="notice"></div>
						<div id="emailConfirm" style="font-size: 12px; color: red;"></div>
					</div>
					
					<div class="div-button">
						<button type="button"
							class="email-button doubleChk btn_recive_num" id="emailChk">이메일
							인증하기</button>
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



					<div class="bodyForm">
						<div class="row">
							<label class="title-type">비밀번호</label>
							<div class="title-text">영문, 숫자를 포함한 8자 이상의 비밀번호를 입력해주세요.</div>
							<input type="password" name="memberPw" placeholder="비밀번호"
								autocomplete="off" maxlength='16' class="inputItemJ" required
								onkeyup="pwCheck();">
							<div class="notice"></div>
						</div>
					</div>
					<div class="bodyForm">
						<div class="row">
							<label class="title-type">비빌번호 확인</label> <input type="password"
								name="memberPw2" placeholder="비밀번호 확인" autocomplete="off"
								maxlength='16' class="inputItemJ" required onkeyup="pw2Check();">
							<div class="notice"></div>
						</div>
					</div>
					<div class="bodyForm">
						<div class="row">
							<label class="title-type">닉네임</label>
							<div class="title-text">다른 유저와 겹치지 않는 별명을 입력해주세요. (2~10자)</div>
							<input type="text" name="memberNickname" placeholder="별명 (2~10자)"
								autocomplete="off" maxlength='10' class="inputItemJ" required
								onkeyup="nicknameCheck();" id="nick" oninput = "nickConfirm()" >
							<div class="notice"></div>
							<div id="nickConfirm" style="font-size: 12px; color: red;"></div>
						</div>

					</div>
					<div class="bodyForm">
						<div class="row">
							<label class="title-type">프로필 이미지</label> <input type="file"
								name="attach" accept="image/*" class="form-input">
						</div>
					</div>

					<div class="bodyForm">
						<div class="checkForm">
							<div class="row">
								<label class="title-type">약관동의</label>
							</div>
						</div>

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

					<div class="row">
						<button type="button"  class="buttonWrapperJ" onclick="formCheck();">회원가입하기</button>
					</div>

				</form>

			</div>

		</section>
	</main>
</body>
</html>

