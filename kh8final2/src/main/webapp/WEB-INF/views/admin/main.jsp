<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<jsp:include page="/WEB-INF/views/template/adminHdr.jsp"></jsp:include>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.2/chart.js" integrity="sha512-7Fh4YXugCSzbfLXgGvD/4mUJQty68IFFwB65VQwdAf1vnJSG02RjjSCslDPK0TnGRthFI8/bSecJl6vlUHklaw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	//jQuery(document).ready(function(){});
	$(function(){
		var labels = [];
		var data = [];
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/data/sales/chart",
			type: "get",
			async: "false",
			success: function(resp){
				console.log("성공",resp);
				for (var vo of resp) {
					data.push(vo.sales);
					labels.push(vo.day);
				}
				//ctx는 canvas에 그림을 그리기 위한 펜 객체(고정 코드)
				var ctx = $("#myChart")[0].getContext("2d");
				//var ctx = document.querySelector("#myChart").getContext("2d");
				
				//var myChart = new Chart(펜객체, 차트옵션);
				var myChart = new Chart(ctx, {
				    type: 'line', //차트의 유형
				    data: { //차트 데이터
				    	
				    	//하단 제목
				        labels: labels,
				        datasets: [{
				            label: '매출',//차트 범례
				            data: data,//실 데이터(하단 제목과 개수가 일치하도록 구성)
				            backgroundColor: [//배경색상(하단 제목과 개수가 일치하도록 구성)
				                'rgba(255, 99, 132, 0.2)',
				                'rgba(54, 162, 235, 0.2)',
				                'rgba(255, 206, 86, 0.2)',
				                'rgba(75, 192, 192, 0.2)',
				                'rgba(153, 102, 255, 0.2)',
				                'rgba(255, 159, 64, 0.2)'
				            ],
				            borderColor: [//테두리색상(하단 제목과 개수가 일치하도록 구성)
				                'rgba(255, 99, 132, 1)',
				                'rgba(54, 162, 235, 1)',
				                'rgba(255, 206, 86, 1)',
				                'rgba(75, 192, 192, 1)',
				                'rgba(153, 102, 255, 1)',
				                'rgba(255, 159, 64, 1)'
				            ],
				            borderWidth: 5//테두리 두께
				        }]
				    },
				    options: {
				    	responsive: false,
				        scales: {
				            y: {
				                beginAtZero: true
				            }
				        }
				    }
				});
				
			},
			error: function(e){
				console.log("실패",e);
			}
		});
		
		
	});
</script>

<script>
	//jQuery(document).ready(function(){});
	$(function(){
		
		var labels = [];
		var data = [];
		
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/data/member/joinChart",
			type: "get",
			async: "false",
			success: function(resp){
				console.log("성공",resp);
					
				for (var vo of resp) {
					data.push(vo.count);
					labels.push(vo.type);
				}
					
				var ctx = $("#joinChart")[0].getContext("2d");

				var joinChart = new Chart(ctx, {
				    type: 'doughnut',
				   	 data: {
				   			labels: labels,
				            datasets: [{
				            label: '회원수',
				            data: data, 
				            backgroundColor: ['rgb(157, 206, 255)','rgb(255, 231, 46)', 'rgb(97, 231, 99)'],
				            hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
				            hoverBorderColor: "rgba(234, 236, 244, 1)",
				            }],
				    },
				    options: {
				        maintainAspectRatio: false,
				        tooltips: {
				          backgroundColor: "rgb(255,255,255)",
				          bodyFontColor: "#858796",
				          borderColor: '#dddfeb',
				          borderWidth: 1,
				          xPadding: 15,
				          yPadding: 15,
				          displayColors: false,
				          caretPadding: 10,
				        },
				        legend: {
				          display: false
				        },
				        cutoutPercentage: 0,
		            },

		});
				
			},
			error: function(e){
				console.log("실패",e);
			}
		});
		
		
	});
</script>

<style>
	.container-part{
		padding-bottom: 40px;
	}
</style>

    <div class="container-zipggu">
    
   	 <div class="container-part">
      	<h1>금주 매출</h1>
	  	<canvas id="myChart" width="900" height="400"></canvas>
	 </div> 
	  
	  <div class="container-part">
	  	<h1>회원 구분</h1>
	  	<canvas id="joinChart" width="900" height="400" style="max-height: 400px"></canvas>
	   </div> 
	   
    </div>






<jsp:include page="/WEB-INF/views/template/adminFtr.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
