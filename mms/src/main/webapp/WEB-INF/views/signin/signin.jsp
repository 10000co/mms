<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="script/common/jquery-3.3.1.min.js"></script>
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link href="style/login/login.css" type="text/css" rel="stylesheet" />

<script>
	$(function() {
		signinChk();
		
		$('#sumitBtn').on('click', signin);
	});
	
	function signinChk() {
		if( $('input:text[name=userid]').val() ) {
			var msg = "";
			
			msg += '<div class="form-control" style="color:red; text-align:center">';
			msg += 'Incorrect username or password.';
			msg += '</div>';
			
			$('#error').html(msg);
		}
		
	}
	
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
					<span class="singtext">영양관리시스템 </span>
				</div>
				<div id="error" class="col-lg-12  col-md-12 col-sm-12">
					
				</div>
				<c:if test="${empty member}">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<input class="form-control" type="text" name="userid"
							placeholder="ID">
					</div>
					<div class="col-lg-12  col-md-12 col-sm-12">
						<input class="form-control" type="password" name="userpwd"
							placeholder="Password">
					</div>
				</c:if>
				<c:if test="${not empty member}">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<input class="form-control" type="text" name="userid"
							placeholder="ID" value="${member.userid}">
					</div>
					<div class="col-lg-12  col-md-12 col-sm-12">
						<input class="form-control" type="password" name="userpwd"
							placeholder="Password" value="${member.userpwd}">
					</div>
				</c:if>
				
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