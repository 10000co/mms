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
<link href="style/index/bootstrap/font-awesome.min.css" rel="stylesheet"
	type="text/css">

<!-- Calendar -->
<link href='style/intake/bootstrap/fullcalendar.min.css'
	rel='stylesheet' />
<link href='style/intake/bootstrap/fullcalendar.print.min.css'
	rel='stylesheet' media='print' />
<script src='script/intake/bootstrap/moment.min.js'></script>
<script src='script/intake/bootstrap/jquery.min.js'></script>
<script src='script/intake/bootstrap/fullcalendar.min.js'></script>

<!-- DataTables CSS -->
<link href="style/intake/bootstrap/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="style/intake/bootstrap/dataTables.responsive.css"
	rel="stylesheet">

<script>
	var dateTmp = new Date();

	var year = dateTmp.getFullYear();
	var month = dateTmp.getMonth() + 1 < 10 ? '0' + (dateTmp.getMonth() + 1)
			: dateTmp.getMonth() + 1;
	var day = dateTmp.getDate() < 10 ? '0' + dateTmp.getDate() : dateTmp
			.getDate();

	var today = year + "-" + month + "-" + day;
	
	var regdate = today;
	
	var addDate = today;

	var example_table = "";
	
	var preBGcolor = "";
	
	$(document).ready(function() {		
		$('#calendar').fullCalendar({
			header : {
				left : 'prev,next',
				center : 'title',
				right : 'today'
			},
			defaultDate : today,
			navLinks : true,
			navLinkDayClick : function(date, jsEvent) {
				console.log('day', date.format('YYYY-MM-DD')); // date is a moment
				console.log('coords', jsEvent.pageX, jsEvent.pageY);

				//#('.fc-day fc-widget-content fc-tue fc-today').css('background-color','red');			
				
				var dt = date.format('YYYY-MM-DD');
// 				var preDt = date.format(preBGcolor);
				
// 				alert('dt: ' + dt + ', preDt: ' + preDt);
				
// 				$('td[data-date=' + dt + ']').css('background-color','#fcf8e3');
				
// 				preBGcolor = dt;
				
				addDate = dt;
				regdate = dt;
				
				$.ajax({
					method : 'get',
					url : 'selectIntakeinfoGet?regdate=' + regdate,
					contentType : 'application/json; charset=UTF-8',
					success : function(response) {
						
						var ary = JSON.parse(response);
						var tmp = [];
						
						for(var i in ary['aaData']) {
							 tmp.push(
								{
			 						"num" : ary['aaData'][i].num, 
			 						"desc_kor" : ary['aaData'][i].desc_kor, 
			 						"nutr_cont1" : ary['aaData'][i].nutr_cont1,
			 						"nutr_cont2" : ary['aaData'][i].nutr_cont2,
			 						"nutr_cont3" : ary['aaData'][i].nutr_cont3,
			 						"nutr_cont4" : ary['aaData'][i].nutr_cont4,
			 						"nutr_cont5" : ary['aaData'][i].nutr_cont5,
			 						"nutr_cont6" : ary['aaData'][i].nutr_cont6,
			 						"nutr_cont7" : ary['aaData'][i].nutr_cont7,
			 						"nutr_cont8" : ary['aaData'][i].nutr_cont8,
			 						"nutr_cont9" : ary['aaData'][i].nutr_cont9,
			 						"modifyBtn" : "<input class='modBtn' type='button' data-pnum='" + ary['aaData'][i].pnum + "'value='삭제' onclick='javascript:modBtnFn(this)' />"
			 					}
							);
						}
						
						example_table.clear().draw();
						example_table.rows.add(tmp);
						example_table.columns.adjust().draw();
					}
				});
			},
			editable : true,
			eventLimit : true,
			events : function(start, end, timezone, callback) {
				var stDate = start.format('YYYY-MM-DD');
				var edDate = end.format('YYYY-MM-DD');
				
				var sendData = [stDate, edDate];
				
				$.ajax({
					method : 'post',
					url : 'searchIntakeinfo',
					data : JSON.stringify(sendData),
					dataType : 'json',
					contentType : 'application/json; charset=UTF-8',
					success : function(response) {
						
						var events = [];
						
						for(var i in response) {
							var regdt = response[i].regdate.split(" ");
							
							events.push({
								title: response[i].desc_kor,
								start: regdt[0]
							});
						}
						callback(events);
					}
				});				
			}
			
		});	
		
		example_table = $('#dataTables-example').DataTable({
            responsive: true,
            serverSide: false,
            "sAjaxSource": "selectIntakeinfoGet?regdate=" + regdate,
            columns : [
            	{data: "num"},
            	{data: "desc_kor"},
            	{data: "nutr_cont1"},
            	{data: "nutr_cont2"},
            	{data: "nutr_cont3"},
            	{data: "nutr_cont4"},
            	{data: "nutr_cont5"},
            	{data: "nutr_cont6"},
            	{data: "nutr_cont7"},
            	{data: "nutr_cont8"},
            	{data: "nutr_cont9"},
            	{data: "modifyBtn"}
            ]
            
        });
		
		$('#addFood').on('click',addBtnFn);
	});
	
	function addBtnFn() {
		var url = "intakeInsert?regdate=" + addDate;
		window.open(url, "intakeInsert", "width=1250,height=500"); 
	}
	
	function modBtnFn(obj) {
		var url = "intakeModify?pnum=" + $(obj).attr('data-pnum');
		window.open(url, "intakeModify", "width=500,height=500"); 
	}
	
	function insertIntake(sendData) {
		alert("결과: " + JSON.stringify(sendData) );
	}
</script>

<style>
#calendar {
	max-width: 80%;
	margin: 0 auto;
}
</style>

<title>섭취정보</title>
</head>
<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath}">영양관리시스템</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">

				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="#"><i class="fa fa-user fa-fw"></i> User
								Profile</a></li>
						<li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
						</li>
						<li class="divider"></li>
						<li><a href="${pageContext.request.contextPath}/signout"><i
								class="fa fa-sign-out fa-fw"></i> Sign out</a></li>
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="${pageContext.request.contextPath}"><i
								class="fa fa-bar-chart-o fa-fw"></i> 식단 조절 현황</a></li>
						<li><a href="${pageContext.request.contextPath}/intakeInfo"><i
								class="fa fa-edit fa-fw"></i> 식단 등록</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">식단등록</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<div class="row">
				<div id='calendar'></div>
				<!-- /.panel-heading -->
                <div class="panel-body">
                	<input id="addFood" type="button" value="추가" />
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                            	<th>식품번호</th>
                                <th>식품이름</th>
                                <th>열량(kcal)</th>
                                <th>탄수화물(g)</th>
                                <th>단백질(g)</th>
                                <th>지방(g)</th>
                                <th>당류(g)</th>
                                <th>나트륨(mg)</th>
                                <th>콜레스테롤(mg)</th>
                                <th>포화지방산(g)</th>
                                <th>트랜스지방(g)</th>
                                <th>삭제</th>
                            </tr>
                        </thead>
                    </table>
                    
                </div>
                <!-- /.panel-body -->
			</div>
		</div>
	</div>
	<!-- /#page-wrapper -->
	
	<!-- Bootstrap Core JavaScript -->
	<script src="script/common/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="script/intake/bootstrap/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="script/intake/bootstrap/jquery.dataTables.min.js"></script>
	<script src="script/intake/bootstrap/dataTables.bootstrap.min.js"></script>
	<script src="script/intake/bootstrap/dataTables.responsive.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="script/intake/bootstrap/sb-admin-2.js"></script>
</body>
</html>