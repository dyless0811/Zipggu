<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-zipggu">
  <table>
  	<thead>
  	  <tr>
  		<th>c.no</th>
  		<th>카테고리</th>
  		<th>i.no</th>
  		<th>상품명</th>
  		<th>가격</th>
  		<th>배송타입</th>
  	  </tr>  	  
  	  <tr>
  	  <form action="" method="get">
  		<th><input type="text" name="categoryNo"></th>
  		<th><input type="text" name="categoryName"></th>
  		<th><input type="text" name="itemNo"></th>
  		<th><input type="text" name="itemName"></th>
  		<th><input type="text" name="minPrice"><input type="text" name="maxPrice"></th>
  		<th><input type="text" name="itemShippingType"><input type="submit"></th>
  	  </form>
  	  </tr>
  	  
  	</thead>
  	<tbody>
  	  <c:forEach var="itemListVO" items="${itemList}">
  	    <tr>
  	      <td>${itemListVO.categoryNo}</td>
  	      <td>${itemListVO.categoryName}</td>
  	      <td>${itemListVO.itemNo}</td>
  	      <td>${itemListVO.itemName}</td>
  	      <td>${itemListVO.itemPrice}</td>
  	      <td>${itemListVO.itemShippingType}</td>
  	    </tr>
  	  </c:forEach>
  	</tbody>
  </table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
