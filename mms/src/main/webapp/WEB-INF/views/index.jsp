<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap Core CSS -->
<link href="style/common/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="style/common/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="style/index/bootstrap/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="style/index/bootstrap/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="style/index/bootstrap/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="script/common/jquery.min.js"></script>

<script>

	$(function(){
		$.ajax({
			method : 'POST',
			url : 'ntrInfoTable',
			dataType : 'json',
			success : function(response){
				var rs = "";
				
				rs += "<td>" + response.nutr_cont2 + "</td>";
				rs += "<td>" + response.nutr_cont3 + "</td>";
				rs += "<td>" + response.nutr_cont4 + "</td>";
				rs += "<td>" + response.nutr_cont5 + "</td>";
				rs += "<td>" + response.nutr_cont6 + "</td>";
				rs += "<td>" + response.nutr_cont7 + "</td>";
				rs += "<td>" + response.nutr_cont8 + "</td>";
				rs += "<td>" + response.nutr_cont9 + "</td>";
				
				$('#ntrInfoTable > tbody').html(rs);
				
			}
		});		
	});
	
	function pwdChk() {
		var pwd = prompt("비밀번호를 입력하세요","");
		
		$.ajax({
			method : 'POST',
			url : 'memberChkPwd',
			data : 'userpwd=' + pwd,
			dataType : 'json',
			success : function(response) {
				if(response.userid == "") {
					alert("잘못된 비밀번호를 입력하셨습니다");
				}
				else {
					location.href = 'updatePageMove';
				}
			}
		});		
	}
</script>

<title>영양관리시스템</title>
</head>
<body>
	<div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}">영양관리시스템</a>
            </div>
            <!-- /.navbar-header -->
            
            <ul class="nav navbar-top-links navbar-right">
                
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="javascript:pwdChk()"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${pageContext.request.contextPath}/signout"><i class="fa fa-sign-out fa-fw"></i> Sign out</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">                        
                        <li>
                            <a href="${pageContext.request.contextPath}"><i class="fa fa-bar-chart-o fa-fw"></i> 식단 조절 현황</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/intakeInfo"><i class="fa fa-edit fa-fw"></i> 식단 등록</a>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->  
        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">식단 조절 현황</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
            	<!-- /.col-lg-6 -->
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           	 이달의 영양소 평균 섭취량
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table id="ntrInfoTable" class="table">
                                    <thead>
                                        <tr>
                                            <th>탄수화물(g)</th>
                                            <th>단백질(g)</th>
                                            <th>지방(g)</th>
                                            <th>당류(g)</th>
                                            <th>나트륨(mg)</th>
                                            <th>콜레스테롤(mg)</th>
                                            <th>포화지방산(g)</th>
                                            <th>트랜스지방(g)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <!-- /.row -->
            <div class="row">
                <!-- /.col-lg-6 -->
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        	평균 칼로리 섭취량(Kcal)
                        </div>
						<!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="morris-bar-chart"></div>
                        </div>
					<!-- /.panel-body -->
                    </div>
				<!-- /.panel -->
                </div>
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
							이달의 3대 영양소 평균 섭취 비율
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<div class="flot-chart">
                                <div class="flot-chart-content" id="flot-pie-chart"></div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
            <!-- /.row -->
            
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
    

    <!-- Bootstrap Core JavaScript -->
    <script src="script/common/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="script/index/bootstrap/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="script/index/bootstrap/raphael.min.js"></script>
    <script src="script/index/bootstrap/morris.min.js"></script>
    <script src="script/index/bootstrap/morris-data.js"></script>
    
    <!-- Flot Charts JavaScript -->
    <script src="script/index/bootstrap/excanvas.min.js"></script>
    <script src="script/index/bootstrap/jquery.flot.js"></script>
    <script src="script/index/bootstrap/jquery.flot.pie.js"></script>
    <script src="script/index/bootstrap/jquery.flot.resize.js"></script>
    <script src="script/index/bootstrap/jquery.flot.time.js"></script>
    <script src="script/index/bootstrap/jquery.flot.tooltip.min.js"></script>
    <script src="script/index/bootstrap/flot-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="script/index/bootstrap/sb-admin-2.js"></script>
    
</body>
</html>