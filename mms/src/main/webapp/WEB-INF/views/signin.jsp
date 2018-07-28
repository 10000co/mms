<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<script src="script/common/jquery-3.3.1.min.js"></script>
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link href="style/login/login.css" type="text/css" rel="stylesheet" />

<script>
	$(function() {
		$('#sumitBtn').on('click', signin);
	});
	
	function signin() {
		// 아이디 또는 비밀번호 입력했는지 확인
		
		$('#signinForm').submit();
	}
</script>
</head>
<body>

	<form id="signinForm" action="signin" method="post">
	<div class="container">

		<div class="col-lg-4 col-md-3 col-sm-2"></div>
		<div class="col-lg-4 col-md-6 col-sm-8">
			<div class="row loginbox">
				<div class="col-lg-12">
					<span class="singtext">MMS </span>
				</div>

				<div class="col-lg-12 col-md-12 col-sm-12">
					<input class="form-control" type="text" name="userid"
						placeholder="ID">
				</div>
				<div class="col-lg-12  col-md-12 col-sm-12">
					<input class="form-control" type="password" name="userpwd"
						placeholder="Password">
				</div>
				<div class="col-lg-12  col-md-12 col-sm-12">
					<a href="#" id="sumitBtn" class="btn  submitButton">Sign in </a> <a
						href="${pageContext.request.contextPath}/signup"
						class="btn  submitButton">Sign up </a>
				</div>
			</div>
			<br> <br>

		</div>
		<div class="col-lg-4 col-md-3 col-sm-2"></div>
	</div>
	</form>

</body>
</html>