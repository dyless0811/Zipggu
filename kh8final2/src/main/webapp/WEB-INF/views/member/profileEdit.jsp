<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="loginEmail" value="${loginEmail}"></c:set>
<c:set var="loginNick" value="${loginNick}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script type="text/javascript">
    //이미지 미리보기
    var sel_file;
 
    $(document).ready(function() {
        $("#file").on("change", handleImgFileSelect);
    });
 
    function handleImgFileSelect(e) {
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
 
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
 
        filesArr.forEach(function(f) {
            if (!f.type.match(reg)) {
                alert("확장자는 이미지 확장자만 가능합니다.");
                return;
            }
 
            sel_file = f;
 
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#img").attr("src", e.target.result);
                $(".img_wrap").css('display', 'block');
				$(".imageOk").css('display', 'none');
				$(".imageNo").css('display', 'none');
            }
            reader.readAsDataURL(f);
        });
    }
</script>
    
<script>
//파일 업로드
function fn_submit(){
        
        var form = new FormData();
        form.append( "file1", $("#file1")[0].files[0] );
        
         $.ajax({
             url : "${pageContext.request.contextPath}/member/profileEdit"
           , type : "POST"
           , processData : false
           , contentType : false
           , data : form
           , success:function(response) {
               alert("성공하였습니다.");
               console.log(response);
           }
           ,error: function (jqXHR) 
           { 
               alert(jqXHR.responseText); 
           }
       });
}

</script>

<script>

var checkNick = true;

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
    var loginNick = '${loginNick}';
    
    $.ajax({
        url:"${pageContext.request.contextPath}/member/nickConfirm", 
        type:"post", 
        data:{memberNickname:memberNickname},
		dataType : "text",
        success:function(nickConfirm){
        	
        	if(loginNick == memberNickname ){
        		
				$("#nickConfirm").text("");
          	 	 checkNick = true;
            
        	} else {
        		
        		if(nickConfirm == 0){
                	console.log("nickConfirm",nickConfirm);
    				$("#nickConfirm").text("");
    				checkNick = true;
    				
                } else {
                    $("#nickConfirm").text("사용 중인 별명입니다.");
                    checkNick = false;
                }
        	}
            
        },
		error:function(e){
			console.log("실패", e);
		}
    });
};   

function formCheck() {
	if(emailCheck() && nicknameCheck() && checkNick){
		
		alert('회원 정보 변경이 완료되었습니다');
		$('form').submit();
		
	}else{
		alert('회원 정보가 올바르지 않습니다.');
		
		return false;
	}
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

.wrapContainer {
    position: relative;
    margin: 50px 150px;
    box-shadow: 0 1px 3px 0 rgb(0 0 0 / 20%);
    padding: 50px;
    color: #292929;
}

.infoHeader {
    display: flex;
    align-items: center;
    margin-bottom: 60px;
}

.infoHeaderTitle {
    font-size: 24px;
    font-weight: 700;
    flex: 1 0 0px;
}

.infoHeaderWithdrawals {
    font-size: 14px;
    color: #ccc!important;
    text-decoration: underline;
    display: flex;
    border: 1px solid #ccc;
    padding: 2px;
}

.infoFormItem {
    display: flex;
}

.infoFormItemTitle {
    padding-top: 30px;
    width: 120px;
}

.infoFormItemTitleRequire {
    margin-top: 5px;
    font-size: 13px;
    color: #757575;
}

.infoFormItemGroup {
    max-width: 400px;
    flex: 1 0 0px;
    padding: 20px 0;
}

.infoFormItemField {
	width: 100%;
    max-width: 100%;
    position: relative;
}

.formTextControl {
    text-align: left;
    font-size: 16px;
    border-radius: 6px;
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
}

.submitButton {
    margin: 50px 0 0 120px;
    width: 290px;
    padding: 11px 10px;
    font-size: 17px;
    line-height: 26px;
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff;
}

.container-1200 {
  width: 1200px;
}

.profileDiv{
	width: 400px;
	height: 200px;
}

.formItemDelete {
    display: flex;
    top: 5px;
    left: 210px;
    justify-content: center;
    align-items: center;
    position: absolute;
    white-space: nowrap;
    padding: 4px 10px;
    font-size: 13px;
    line-height: 20px;
    font-weight: 700;
    background-color: #35c5f0;
    border-color: #35c5f0;
    color: #fff !important;
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

.notice {
	font-size: 12px;
	color: red;
}

.warning {

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
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/profileEdit" class="active">회원정보수정</a></li>
			<li class="page-navigation__item"><a href="${pageContext.request.contextPath}/member/password">비밀번호 변경</a></li>
		</ul>
		</nav>
	</div>


<div class="container-1200 container-center">

<div class="wrapContainer ">

	<div class="infoHeader">
		<div class="infoHeaderTitle">회원정보수정</div>
		<a href="${pageContext.request.contextPath}/member/withdrawal" class="infoHeaderWithdrawals">탈퇴하기</a>
	</div>	
		
	<div>	
	<form method="post" enctype="multipart/form-data">
	
	<input type="hidden" name="memberNo" class="form-control" value="${memberDto.memberNo}" id="inputDefault">
	
		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">이메일
				<div class="infoFormItemTitleRequire">* 필수항목</div>
			</div>
				
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
					<input type="email" name="memberEmail" class="formTextControl"  value="${memberDto.memberEmail}" readonly onkeyup="emailCheck();">
					<div class="notice" style="  margin-top: 10px; color: #9e9e9e; font-size: 13px;  font-weight: 700;">이메일을 변경하시려면 운영자에게 문의해주세요.</div>	
				</div>
			</div>
			
		</div>

		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">별명
				<div class="infoFormItemTitleRequire">* 필수항목</div>
			</div>
					
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
					<input type="text" name="memberNickname" class="formTextControl" value="${memberDto.memberNickname}" onblur="nicknameCheck();" id="nick" oninput = "nickConfirm()" >
					<div class="notice"></div>
					<div id="nickConfirm" style="font-size: 12px; color: red;"></div>
				</div>
			</div>
			
		</div>
	
		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">성별</div>
					
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
								
					<c:choose>		
						<c:when test="${memberDto.memberGender == null}">
							<input type="radio" class="btn-check" name="memberGender" id="btnradio1" value="남성" autocomplete="off"> 
							<label class="btn btn-outline-primary" for="btnradio1">남성</label>
							<input type="radio" class="btn-check" name="memberGender" id="btnradio2" value="여성" autocomplete="off">
							<label class="btn btn-outline-primary" for="btnradio2">여성</label>
						</c:when>		
				<c:otherwise>	
					<c:choose>	
						<c:when test="${memberDto.memberGender == '남성'}">
							<input type="radio" class="btn-check" name="memberGender" id="btnradio1" value="남성" autocomplete="off" checked="checked"> 
							<label class="btn btn-outline-primary" for="btnradio1">남성</label>
							<input type="radio" class="btn-check" name="memberGender" id="btnradio2" value="여성" autocomplete="off">
							<label class="btn btn-outline-primary" for="btnradio2">여성</label>	
						</c:when>
						<c:otherwise>
							<input type="radio" class="btn-check" name="memberGender" id="btnradio1" value="남성" autocomplete="off"> 
							<label class="btn btn-outline-primary" for="btnradio1">남성</label>
							<input type="radio" class="btn-check" name="memberGender" id="btnradio2" value="여성" autocomplete="off" checked="checked">
							<label class="btn btn-outline-primary" for="btnradio2">여성</label>	
						</c:otherwise>					            
					</c:choose>				
						</c:otherwise>					
					</c:choose>				
					</div>
				</div>
			</div>
		</div>
			
		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">생년월일</div>
					
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
				
				    <c:choose>
						<c:when test="${memberDto.memberBirth == null}">
							<input type="date" name="memberBirth" class="form-control">
						</c:when>
					<c:otherwise>
       						<input type="date" name="memberBirth" class="form-control"   value="${memberDto.getMemberBirthDay()}" >
					</c:otherwise>	            
					</c:choose>				

				
				
				</div>
			</div>
			
		</div>

		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">프로필 이미지</div>
					
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
					<div class="profileDiv">
					               <button type ="button" id="btn-add" onclick="document.all.file.click();">
					        	<input type="file" name="attach" accept="image/*" id="file" class="form-input" style="display:none">
								      <div class="img_wrap" style="display: none;">
			          						<img id="img" style="width: 200px; height: 200px;" />
			     					  </div>
						        <c:choose>
						            <c:when test="${memberProfileDto == null}">
						            <div class="imageNo" style="display: block;">
						            <img src="https://via.placeholder.com/300x300?text=User" style="width: 200px; height: 200px;" class="image image-border">
						            </div>
						            </c:when>
						            <c:otherwise>
						            <div class="imageOk" style="display: block;">
						            <img src="profile?memberNo=${memberProfileDto.memberNo}" style="width: 200px; height: 200px;" class="image image-border">	  
						            </div>          
						            </c:otherwise>	            
						        </c:choose>
						        <div >
   				    		 
   				     		</div>
   				     </button>
   				     <a href="profileDelete?memberNo=${memberProfileDto.memberNo}" class="formItemDelete">삭제</a>
					</div>
				</div>
			</div>
			
		</div>

		<div class="infoFormItem">
		
			<div class="infoFormItemTitle">한줄소개</div>
					
			<div class="infoFormItemGroup">
				<div class="infoFormItemField">
					<input type="text" name="memberIntroduce" value="${memberDto.memberIntroduce}" class="form-control" id="exampleTextarea" >
				</div>
			</div>
			
		</div>

		<div class="d-grid gap-2">
			<button type="button" class="submitButton" onclick="formCheck()" >회원 정보 수정</button>
		</div>

	</form>
	</div>
	





	<c:if test="${param.error != null}">
	<div class="row center">
		<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
	
</div>

</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>