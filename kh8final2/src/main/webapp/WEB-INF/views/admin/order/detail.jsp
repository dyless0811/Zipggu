<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/adminHdr.jsp"></jsp:include>

<div class="container-zipggu">
<h1>대표 결제 정보</h1>

<ul>
	<li>고유번호 : ${ordersDto.orderNo}</li>
	<li>거래번호 : ${ordersDto.tid}</li>
	<li>거래명 : ${ordersDto.orderName}</li>
	<li>거래금액 : ${ordersDto.totalAmount}</li>
	<li>거래시각 : ${ordersDto.orderDate}</li>
	<li>현재상태 : ${ordersDto.orderStatus}</li>
</ul>

<c:if test="${ordersDto.orderStatus != '전체취소'}">
<h2><a href="cancel_all?no=${ordersDto.orderNo}">전체 취소</a></h2>
</c:if>

<hr>

            
<div class="accordion-body">
	<c:forEach var="order" items="${orderDetailList}" varStatus="status">
         <div class="row mt-2">

             <!--상품 썸네일-->
             <div class="col-auto">
               <a href="${pageContext.request.contextPath}/store/detail/${order.itemNo}">
                 <img src="${pageContext.request.contextPath}/item/thumbnail?itemNo=${order.itemNo}" class="d-block w-100" style="width:150px;height:150px" alt="...">
               </a>
             </div>

             <!--상품 옵션 및 수량-->
             <div class="item-detail col-auto me-auto">

                 <!-- 상품명 -->
                 <div class="row m-1">
                     <div class="col-auto me-auto">
                         <span style="font-size: 15px;"><strong>${order.orderItemName}  ${order.orderQuantity}개</strong></span>
                     </div>
                 </div>

                 <!--옵션-->
                 <div class="row m-1">
                     <div class="col-auto me-auto">
                         <span style="font-size: 12px; color: dimgray;">
                         	<c:forEach var="option" items="${order.optionList}" varStatus="status">
                         	<strong>${status.index != 0 ? "/" : ""} ${option.itemOptionGroup}: ${option.itemOptionDetail} </strong>
                         	</c:forEach>
                         </span>
                     </div>
                 </div>

                 <!--상품금액-->
                 <div class="row m-1">
                     <div class="col-auto me-auto">
                         <strong><span style="font-size: 15px;">${order.getTotalPriceToString()}</span>원</strong>
                     </div>
                 </div>
                 
              <c:choose> 
                 <c:when test="${order.orderDetailStatus != '취소'}">
					<a class="btn btn-primary" href="${pageContext.request.contextPath}/payment/cancel_part?orderNo=${order.orderNo}&orderDetailNo=${order.orderDetailNo}&type=admin">해당항목 취소</a>
				</c:when>
				<c:otherwise>
					<span class="btn btn-secondary">취소됨</span>
				</c:otherwise>
			  </c:choose>	
             </div>
         </div>
         </c:forEach>
     </div>


</div>


<jsp:include page="/WEB-INF/views/template/adminFtr.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>