<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	var page = 1;
	var size = 10;
	var order = "order_no";
	var sort = "desc";
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
			var orderNo = $(this).find(".order-no").text();
			location.href="${pageContext.request.contextPath}/admin/order/detail/"+orderNo
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
			formData.push({name: 'admin', value: 1});
			$.ajax({
				url: "${pageContext.request.contextPath}/member/order/list",
				type: "post",
				data: formData,
				success: function(resp){
					console.log("성공",resp);
					
					if(resp.length < size){
						$(".more-btn").hide();
					}
					
					for (var orderListVO of resp) {
						var result = $("<tr class='item-row' style='cursor:pointer'>");
						result.append($("<td>").addClass("order-no").text(orderListVO.orderNo));
						result.append($("<td>").text(orderListVO.orderName));
						result.append($("<td>").text(orderListVO.totalAmount));
						result.append($("<td>").text(orderListVO.memberNickname));
						var dateTime = new Date(Number(orderListVO.orderDate));
						result.append($("<td>").text(dateTime.toLocaleString()));
						result.append($("<td>").text(orderListVO.orderStatus));
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
<jsp:include page="/WEB-INF/views/template/adminHdr.jsp"></jsp:include>

<div class="container-zipggu">
<h2 class="mb-5">주문 내역</h2>

<form action="" method="get">
  <button id="search-btn" type="button" class="btn btn-primary">검색</button>
  <button id="reset-btn" type="button" class="btn btn-primary">초기화</button>
  <table class="table table-hover">
  	<thead>
  	  <tr class="menu-row">
  		<th data-order="order_no"><a href="">주문번호</a></th>
  		<th data-order="order_name"><a href="">주문명</a></th>
  		<th data-order="total_amount"><a href="">결제금액</a></th>
  		<th data-order="member_nickname"><a href="">고객명</a></th>
  		<th data-order="order_date"><a href="">결제시각</a></th>
  		<th data-order="order_status"><a href="">결제상태</a></th>
  	  </tr>  	  
 	  <tr>
  		<th><input type="text" name="orderNo" value="${param.orderNo}" class="form-control"></th>
  		<th><input type="text" name="orderName" value="${param.orderName}" class="form-control"></th>
  		<th></th>
  		<th><input type="text" name="memberNickname" value="${param.memberNickname}" class="form-control"></th>
  		<th>
  		  <div class="d-flex justify-content-between input-group">
  			<input type="date" name="minDate" value="${param.minDate}" class="form-control">
  			<span class="input-group-text">~</span>
  			<input type="date" name="maxDate" value="${param.maxDate}" class="form-control">
  		  </div>
  		</th>
  		<th><input type="text" name="orderStatus" value="${param.orderStatus}" class="form-control"></th>
  	  </tr>
  	  
  	</thead>
  	<tbody>

  	</tbody>
  </table>
</form>
<button class="more-btn btn btn-primary">더보기</button>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>