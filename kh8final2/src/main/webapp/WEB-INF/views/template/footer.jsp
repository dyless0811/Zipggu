<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="login" value="${loginNo != null}"></c:set>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>  
</section>
    <div class="company-info">
      <div class="container">
        <div class="row company-menu">
          <li>
            <a href="/agreement/term">이용약관</a>
            <span class="division-line">|</span>
            <span
              onclick="location.href='mailto:info@osquarecorp.com';"
              style="cursor: pointer"
              >제휴문의</span
            >
            <span class="division-line">|</span>
            <a href="/partner/store_inquiry/">입점문의</a>
            <span class="division-line">|</span>
            <a href="/agreement/privacy/new">개인정보처리방침</a>
            <span class="division-line">|</span>
            <a href="/company" target="_blank">회사소개</a>
          </li>
          <p>
            회사명: 주식회사 집꾸미기&nbsp;&nbsp;&nbsp;&nbsp;대표:
            길경환&nbsp;&nbsp;&nbsp;대표전화: 1522-7966&nbsp;&nbsp;&nbsp;주소:
            서울특별시 성동구 왕십리로 125, 11층 1101호(성수동1가)
          </p>
          <p>
            사업자등록번호:
            142-81-50856&nbsp;&nbsp;&nbsp;통신판매업신고&nbsp;&nbsp;&nbsp;<span
              >제 2020-서울성동-00618 호&nbsp;&nbsp;<a
                href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=1428150856"
                target="_blank"
                >[사업자정보확인]</a
              >&nbsp;&nbsp;</span
            >개인정보관리책임자: 이찬희(info@osquarecorp.com)
          </p>
          <p>copyright © 집꾸미기 all rights reserved.</p>
          <p>로그인 = ${login }</p>
          <p>번호 = ${loginNo }</p>
          <p>아이디 = ${loginEmail }</p>
          <p>닉네임 = ${loginNick }</p>
          <p>등급 = ${loginGrade }</p>
          <p style="margin: 20px 0; overflow: hidden">
            <span style="float: left"
              >안전거래를 위해 현금 등으로 결제 시 저희 쇼핑몰에서 가입한<br />KG
              이니시스의 구매안전 서비스를 이용하실 수 있습니다.</span
            >
            <span style="float: left">
              <img
                id="inicis-cert"
                src="https://image.inicis.com/mkt/certmark/escrow/escrow_74x74_gray.png"
                border="0"
                alt="클릭하시면 이니시스 결제시스템의 유효성을 확인하실 수 있습니다."
                style="cursor: pointer"
                onclick='javascript:window.open("https://mark.inicis.com/mark/escrow_popup.php?mid=theggumim2","mark","scrollbars=no,resizable=no,width=565,height=683");'
              />
            </span>
          </p>
        </div>
        <div class="sns-icon">
          <a href="https://www.instagram.com/ggumigi/" target="_blank">
            <i class="fa fa-instagram" aria-hidden="true"></i>
          </a>
          <a href="https://ko-kr.facebook.com/ggumim2013" target="_blank">
            <i class="fa fa-facebook" aria-hidden="true"></i>
          </a>
          <a href="http://band.us/#!/band/56666078" target="_blank">
            <i class="fa fa-bold" aria-hidden="true"></i>
          </a>
          <a href="https://post.naver.com/mdl87" target="_blank">
            <img
              src="//cdn.ggumim.co.kr/storage/20190320185307oimQjGPZym.png"
              style="
                width: 30px;
                height: 30px;
                vertical-align: middle;
                margin: 1px;
              "
            />
          </a>
          <a href="https://story.kakao.com/_2CpjG5" target="_blank">
            <span class="kakao">
              <i class="fa fa-quote-right" aria-hidden="true"></i>
            </span>
          </a>
          <a href="/" target="_blank" style="display: none">
            <i class="fa fa-twitter" aria-hidden="true"></i>
          </a>
        </div>
      </div>
    </div>
  </body>
</html>