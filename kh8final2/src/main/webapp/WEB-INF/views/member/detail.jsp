<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <title>Document</title>
</head>

<body>

    <div class="h4 text-center">회원 상세</div>
    <div class="row pv-lg">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <form class="form-horizontal ng-pristine ng-valid">
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="inputContact1">이름</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="inputContact1" type="text" placeholder="" value="Audrey Hunt">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="inputContact2">이메일</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="inputContact2" type="email" value="mail@example.com">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="inputContact3">전화번호</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="inputContact3" type="text" value="(123) 465 789">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="inputContact6">주소</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="inputContact6" row="4">Some nice Street, 1234</textarea>
                    </div>
                </div>
        </div>
    </div>
    <div class="form-group">
    </div>
    
    <h2>회원 목록</h2>
	<input type="button" value="회원등록" onclick="location.href='${path}/member/write.do'">
	<table border="1" width="700px">
		<tr>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>주소</th>
		</tr>
		<c:forEach var="row" items="${list}">
		<tr>
			<td>${row.userId}</td>
			<!-- 회원정보 상세조회를 위해 a태그 추가 -->
			<td><a href="${path}/member/view.do?userId=${row.userId}">${row.userName}</a></td>
			<td>${row.userEmail}</td>
			<td>${row.userRegdate}</td>
		</tr>
		</c:forEach>
	</table>
    
</body>

</html>