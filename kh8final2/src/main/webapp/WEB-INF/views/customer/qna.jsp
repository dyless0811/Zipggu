<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  
  .layout{
  max-width: 600px;
  margin: 0 auto;
  }

  .qna{
      list-style: none;
      margin: 0;
      padding: 0;
  }
  .qna > li{
    padding: 10px 0;
    box-sizing: border-box;
  }
  .qna > li:nth-child(n+2){ /* 아이템 구분 점선 */
    border-top: 1px dashed #aaa;
  }
  .qna input {
    display: none;
  }
  
  .qna label { /* 제목 - 클릭 영역 */
    font-weight: bold;
    color: #000;
    margin: 20px 0 0;
    cursor: pointer;
  }
  .qna label::before { /* 제목 앞 화살표 */
    display: block;
    content: "";
    width: 0;
    height: 0;
    border: 8px solid transparent;
    border-left: 8px solid #df625c;
    margin: 2px 0 0 8px;
    float: left;
  }
  .qna input:checked + label::before { /* 내용 펼침 상태 제목 앞 화살표 */
    border: 8px solid transparent;
    border-top: 8px solid #df625c;
    border-bottom: 0;
    margin: 8px 4px 0;
  }

  .qna div { /* 내용 영역 - 기본 감춤 상태 */
           display: none;
    color: #666;
    font-size: 0.9375em;
    overflow: hidden;
    padding: 10px 0 10px 30px;
    box-sizing: border-box;
    transition: max-height 0.4s;
  }
  .qna input:checked + label + div { /* 내용 영역 펼침 */
    display: block;
  }

  h1{
    color: #df625c;
  }
  
  h3{
    color: #df625c;
  }
  .box01 {
    text-align: center;
  }

  .box01 input {
    border: none;
    font-size: 15px;
    outline: none;
    text-align: center;
  }

  .box01 button {
    border: none;
    width: 60px;
    max-width: 100px;
    vertical-align: bottom;
  }
  .box01 button img {
    width: 100%;
  }

  .kakaoChat {
    position: fixed;
    right: 15px;
    bottom: 15px;
    width: 80px;
    height: 80px;
    z-index: 99;
  }

  button {
    width: 125px;
    height: 30px;
    background-color: #f15657;
    color: white;
    box-shadow: 0 4px 16px rgba(211, 50, 51, 0.3);
    font-size: 16px;
    font-weight: bold;
    border-radius: 20px;
    transition: 1s;
  }

  button:focus {
    outline: 0;
  }

  button:hover {
    background-color: rgba(211, 50, 51, 0.9);
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(211, 50, 51, 0.6);
  }
</style>



<div class="container-zipggu">
  <div id="contact-us">
    <div class="container--my-page">
        <article id="customer-center" class="customer-center">
            <h1 class="customer-center__title">고객센터</h1>
            <div class="row">
                <section class="col-12 col-md-6 customer-center__contact">
                    <address>
                        운영시간 : 평일 09:00 ~ 18:00 (주말 & 공휴일 제외)
                        <br><br>
                        이메일 : customerservice@zipggu.com &nbsp;
                        <button>
                		<a href="mailto:customerservice@zipggu.com">send mail</a>
              		</button>
              		<br /><br />
                        전화 : 1234-5678
                       <br><br>
                    </address>
                    <a href="http://open.kakao.com/o/sihQn6Sd/" target="_blank"><button>1:1 상담</button></a>
                </section>
            </div>
        </article>
    </div>
</div>
<br><br>
<ul class="qna">
  <h3>주문/결제</h3>
    <li>
        <input type="checkbox" id="qna-1">
        <label for="qna-1">주문 내역은 어떻게 확인할 수 있나요?</label>
        <div>
            <p>우측 상단 프로필 사진/아이디를 클릭하시면 [주문정보]를 통해 확인 가능합니다</p>
        </div>
    </li>
    <li>
        <input type="checkbox" id="qna-2">
        <label for="qna-2">결제 방법은 어떤 것이 있나요?</label>
        <div>
            <p>신용카드 및 체크카드, 무통장 입금, 휴대혼 소액결제, 네이버페이를 이용해 결제 가능합니다.</p>
        </div>
    </li>
    <li>
        <input type="checkbox" id="qna-3">
        <label for="qna-3">비회원주문 및 전화주문이 가능한가요?</label>
        <div>
            <p>전화부문은 준비중에 있습니다.</p>
            <p>비회원 주문은 가능하지만 일부 상품에 한해 제한되어있습니다.</p>
        </div>
    </li>
    <li>
        <input type="checkbox" id="qna-4">
        <label for="qna-4">신용카드 무이자 할부가 되나요?</label>
        <div>
            <p>각 카드사 별로 상이하며, 카드사를 통해 확인 가능합니다.</p>
        </div>
    </li>
    <li>
        <input type="checkbox" id="qna-5">
        <label for="qna-5">신용카드 결제 후 할부 개월 수를 변경 가능한가요?</label>
        <div>
            <p>결제 후 결제 정보 변경은 불가능 합니다.</p>
            <p>단, 결제 완료 단계에서는 취소 후 재주문을 통해 변경 가능합니다.</p>
        </div>
    </li>
    <li>
      <input type="checkbox" id="qna-6">
      <label for="qna-6">가상계좌 은행을 변경 할 수 있나요?</label>
      <div>
          <p>한번 발급 받은 계좌번호는 변경이 불가능합니다.</p>
          <p>재주문을 통해 새로운 계좌를 발급 받으신 후 입금 부탁드립니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-7">
      <label for="qna-7">주문 후 결제 방법을 변겨앟고 싶은데 어떻게 해야 하나요?</label>
      <div>
        <p>결제 후 결제 정보 변경은 불가능 합니다</p>
        <p>다느 입금 대기 및 결제 완료 단계에서는 취소 후 재주문을 통해 변경 가능합니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-8">
      <label for="qna-8">결제 시 에러 메시지가 나오는 경우 해야하나요?</label>
      <div>
        <p>우측 상단 [고객선터>1:1 문의하기]를 통해 문의 부탁드립니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-9">
      <label for="qna-9">신용카드 안전결제(ISP)는 무엇인가요?</label>
      <div>
        <p>국민카드, BC카드는 인터넷 안전결제(ISP)로 결제가 진행됩니다.</p>
        <p>졀제진행시 나타나는 안내에 따라 결제하실 카드번호와 사용하시는 이메일 및 비밀번호를 입력하여 인터넷 안전결제(ISP)등록 후 결제를 진행해 주시면 됩니다"</p>
        <p>단, 30만원 이상 결제 시에는 공인인증서가 필요합니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-10">
      <label for="qna-10">가상계좌 입금은 언제 확인 되나요?</label>
      <div>
        <p>입금 후 24시간 이내에 확인됩니다.</p>
        <p>24시간 이후에도 입금확인이 되지 않는 경우 결제 금액과 입금한 금액이 같은지, 올바른 계좌로 입금하였는지 확인 후</p>
        <p>[고객센터>1:1 문의하기]를 통해 문의 부탁드립니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-11">
      <label for="qna-11">가상계좌 입금인을 다르게 적은경우 어떻게 해야하나요?</label>
      <div>
        <p>입금인이 달라도 가상계좌번호만 같으면 문제없습니다.</p>
      </div>
    </li>
  <br><br>
  <h3>배송</h3>
    <li>
      <input type="checkbox" id="qna-12">
      <label for="qna-12">배송비는 얼마인가요?</label>
      <div>
        <p>집꾸는 상품정보 중계 및 판매 매체이며, 판매 업체 별로 배송비 정책이 상이합니다.</p>
        <p>각 상품상세페이지에서 배송비를 확인하실 수 있습니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-13">
      <label for="qna-13">배송확인은 어떻게 하나요?</label>
      <div>
        <p>우측 상단 프로필 사진/아이디를 클릭하시면 [주문정보]를 통해 배송단계를 한눈에 보실 수 있습니다.</p>
        <p>또한 배송이 시작되면 카카오톡 알림톡 또는 SMS로 안내메시지가 발송됩니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-14">
      <label for="qna-14">배송은 얼마나 걸리나요?</label>
      <div>
        <p>상품 배송 기간은 배송 유형에 따라 출고 일자 차이가 있습니다.</p>
        <p>자세한 사항은 구매하신 상품의 상세 페이지에서 확인 가능하며, 배송 유형 별 기본 출고 기간은 아래와 같습니다.</p>
        <p>• 일반 택배/화물 택배 : 결제 후 1~3 영업일 이내 출고됩니다.</p>
        <p>• 업체 직접 배송 : 배송 지역에 따라 배송 일자가 상이할 수 있으므로 상품 상세 페이지에서 확인 해주세요.</p>
        <p>※ 영업일은 주말, 공휴일을 제외한 기간입니다.</p>
        <p>※ 제조사의 사정에 따라 출고일은 지연될 수 있는 점 양해 부탁드립니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-15">
      <label for="qna-15">여러 상품을 묶음 배송 받으려면 어떻게 해야하나요?</label>
      <div>
        <p>각 상품별로 배송처가 상이할 수 있기 때문에 묶음 배송은 어렵습니다.</p>
        <p>단, 배송처가 같은 경우 배송처의 정책에 따라 가능 할 수 있습니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-16">
      <label for="qna-16">원하는 날짜로 맞춰서 배송을 받을수 있나요?</label>
      <div>
        <p>각 배송처 정책에 따라 상이할 수 있습니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-17">
      <label for="qna-17">배송 시작 알림 메시지를 받았는데, 배송추적이 되지 않습니다. 어떻게 해야하나요?</label>
      <div>
        <p>송장번호 등록 후 1영업일 이내 또는 실제 상품배송이 진행됨과 동시에 배송추적이 가능합니다.</p>
        <p>※ 배송처에서 배송이 시작되기 전, 송장으 ㄹ먼저 출력 후 송장번호를 입력하는 경우가 있습니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-18">
      <label for="qna-18">배송조회를 해보면 배송완료로 확인이되는데 택배를 받지 못했습니다. 어떻게 해야하나요?</label>
      <div>
        <p>경비실 또는 무인택배함을 먼저 확인 부탁드립니다.</p>
        <p>별도의 위탁 장소가 없는 경우 배송기사님께서 임의의 장소에 보관하셨을 수 있으니, 기사님께 문의 부탁드립니다.</p>
      </div>
    </li>
    <li>
      <input type="checkbox" id="qna-19">
      <label for="qna-19">해외배송이 가능한가요?</label>
      <div>
        <p>현재는 국재배송만 진행하고 있습니다.</p>
      </div>
    </li>
</ul>
</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
