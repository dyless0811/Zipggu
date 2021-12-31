<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	var page = 1;
	var size = 10;
	var order = "item_no";
	var sort = "asc";
	var preOrder = "";
	var preSort = "asc";
	$(function(){		
		
		
		$(".more-btn").click(function(){
			loadList(page, size);
			page++;
		});
		$(".more-btn").click();
		
		$("#search-btn").click(function(){
			$("tbody").empty();
			page = 1;
			loadList(page, size);
		});

		$("#reset-btn").click(function(){
			$("tbody").empty();
			resetForm();
			page = 1;
			loadList(page, size);
		});
		
		$(document).on("click",".item-row", function(){
			var itemNo = $(this).find(".item-no").text();
			location.href="${pageContext.request.contextPath}/admin/item/update/"+itemNo
		})
		
		$(document).on("click",".menu-row th a",function(e){
			$("tbody").empty();
			e.preventDefault();
			order = $(this).parent().data("order");
			sort = setSort(order);
			preOrder = order;
			page = 1;
			loadList(page, size);
		});
		
		function loadList(page, size) {
			disableForm();
			var formData = $("form").serializeArray();
			formData.push({name: 'page', value: page});
			formData.push({name: 'size', value: size});
			formData.push({name: 'order', value: order});
			formData.push({name: 'sort', value: sort});
			$.ajax({
				url: "${pageContext.request.contextPath}/admin/data/item/list",
				type: "post",
				data: formData,
				success: function(resp){
					console.log("성공",resp);
					
					if(resp.length < size){
						$(".more-btn").hide();
					}
					
					for (var itemListVO of resp) {
						var result = $("<tr class='item-row' style='cursor:pointer'>");
						result.append($("<td>").text(itemListVO.categoryNo));
						result.append($("<td>").text(itemListVO.categoryName));
						result.append($("<td>").addClass("item-no").text(itemListVO.itemNo));
						result.append($("<td>").text(itemListVO.itemName));
						result.append($("<td>").text(itemListVO.itemPrice));
						result.append($("<td>").text(itemListVO.itemShippingType));
						$("tbody").append(result);
					}
				},
				error: function(e){
					console.log("실패",e);
				}
			});
			activeForm();
		}
		function setOrder(order) {
			preOrder = order;
			return order;
		}
		function setSort(order) {
			if(preOrder == order) {
				if(preSort == "asc") {
					preSort = "desc";
					return "desc";
				} else {
					preSort = "asc";
					return "asc";
				}
			}
			preSort = "asc";
			return "asc";
		}
		
		function resetForm() {
			$("input").each(function(){
				$(this).val("");
			});
		}
		function disableForm() {
			$("input").each(function(){
				if($(this).val() == "") {
					$(this).attr("disabled","disabled");
				}
			});
		}
		function activeForm() {
			$("input").each(function(){
				$(this).removeAttr("disabled");
			});
		}
	});
</script>


<div class="container-zipggu">
<form action="" method="get">
  <button id="search-btn" type="button" class="btn btn-primary">검색</button>
  <button id="reset-btn" type="button" class="btn btn-primary">초기화</button>
  <table class="table table-hover">
  	<thead>
  	  <tr class="menu-row">
  		<th data-order="c.category_no"><a href="">c.no</a></th>
  		<th data-order="category_name"><a href="">카테고리</a></th>
  		<th data-order="item_no"><a href="">i.no</a></th>
  		<th data-order="item_name"><a href="">상품명</a></th>
  		<th data-order="item_price"><a href="">가격</a></th>
  		<th data-order="item_shipping_type"><a href="">배송타입</a></th>
  	  </tr>  	  
 	  <tr>
  		<th><input type="text" name="categoryNo" value="${param.categoryNo}" class="form-control"></th>
  		<th><input type="text" name="categoryName" value="${param.categoryName}" class="form-control"></th>
  		<th><input type="text" name="itemNo" value="${param.itemNo}" class="form-control"></th>
  		<th><input type="text" name="itemName" value="${param.itemName}" class="form-control"></th>
  		<th>
  		  <div class="d-flex justify-content-between input-group">
  			<input type="text" name="minPrice" value="${param.minPrice}" class="form-control">
  			<span class="input-group-text">~</span>
  			<input type="text" name="maxPrice" value="${param.maxPrice}" class="form-control">
  		  </div>
  		</th>
  		<th><input type="text" name="itemShippingType" value="${param.itemShippingType}" class="form-control"></th>
  	  </tr>
  	  
  	</thead>
  	<tbody>

  	</tbody>
  </table>
</form>
<button class="more-btn btn btn-primary">더보기</button>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
