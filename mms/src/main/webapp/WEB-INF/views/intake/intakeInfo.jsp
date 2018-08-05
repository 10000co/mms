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

	// 년, 월, 일
	var year = dateTmp.getFullYear();
	var month = dateTmp.getMonth() + 1 < 10 ? '0' + (dateTmp.getMonth() + 1)
			: dateTmp.getMonth() + 1;
	var day = dateTmp.getDate() < 10 ? '0' + dateTmp.getDate() : dateTmp
			.getDate();
	
	// 오늘날짜
	var today = year + "-" + month + "-" + day;
	
	var regdate = today;	// 선택된 날짜(fullcalendar)

	// datatables 지정변수
	var example_table = "";
	
	// fullcalendar 갱신시 필요한 날짜
	var stDate = "";	// 이번달의 시작 날짜
	var edDate = "";	// 이번달의 끝 날짜
	
	var monthFlag = false; // 이전달로가는지 다음달로 가는지 구분(이전달 : false, 다음달 : true)
	
	$(function(){
		init();
		
		$('#addFood').on('click',addBtnFn);
		$("button.fc-next-button").on('click',getMonthDateNext);	// 다음달 첫날과 마지막날 구하기
		$("button.fc-prev-button").on('click',getMonthDatePrev);	// 이전달 첫날과 마지막날 구하기
		
	});
	
	Date.prototype.yyyymmdd = function() {
        var yyyy = this.getFullYear().toString();
        var mm = (this.getMonth() + 1).toString();
        var dd = this.getDate().toString();
        return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
    }
	
	function convertDate(date) {
        var date = new Date(date);
                	
        var stDateSub = date.yyyymmdd();
        var edDateSub = "";
        var edDay = "";
        
		var sp = date.yyyymmdd().split('-');
		
		if(monthFlag == false) {
        	edDay = ( new Date( sp[0], sp[1], 0) ).getDate();
		}
		else {
			edDay = ( new Date( sp[0], sp[1], 0) ).getDate();
		}
		
		edDate = sp[0] + "-" + sp[1] + "-" + edDay;
        
//         stDate = stDateSub;
//         edDate = edDateSub;
    }
	
	function getMonthDateNext() {
		monthFlag = true;
        var date = $("#calendar").fullCalendar("getDate");
        convertDate(date);
    }
	
	function getMonthDatePrev() {
		monthFlag = false;
        var date = $("#calendar").fullCalendar("getDate");
        convertDate(date);
    }
	
	function init() {
		$('#calendar').fullCalendar({
			header : {
				left : 'prev,next',
				center : 'title',
				right : 'today'
			},
			selectable : false,
			defaultDate : today,
			navLinks : true,
			navLinkDayClick : function(date, jsEvent) {
				
				date.backgroundColor = "yellow";	
				
				var dt = date.format('YYYY-MM-DD');
				
				regdate = dt;
				
				$('#calendar').fullCalendar('select',regdate);
				
				$.ajax({
					method : 'get',
					url : 'selectIntakeinfoGet?regdate=' + regdate,
					contentType : 'application/json; charset=UTF-8',
					success : function(response) {
						
						var ary = JSON.parse(response);
						var tmp = [];
						
						for(var i in ary['aaData']) {
							var deleteBtn = "<a href='javascript:delBtnFn(\"" + ary['aaData'][i].pnum + "\")'><img class='delBtn' src='images/intake/intakeinfo/trash.png' /></a>";
							
							 tmp.push(
								{
			 						"num" : ary['aaData'][i].num, 
			 						"desc_kor" : ary['aaData'][i].desc_kor, 
			 						"gram" : ary['aaData'][i].gram,
			 						"nutr_cont1" : ary['aaData'][i].nutr_cont1,
			 						"nutr_cont2" : ary['aaData'][i].nutr_cont2,
			 						"nutr_cont3" : ary['aaData'][i].nutr_cont3,
			 						"nutr_cont4" : ary['aaData'][i].nutr_cont4,
			 						"nutr_cont5" : ary['aaData'][i].nutr_cont5,
			 						"nutr_cont6" : ary['aaData'][i].nutr_cont6,
			 						"nutr_cont7" : ary['aaData'][i].nutr_cont7,
			 						"nutr_cont8" : ary['aaData'][i].nutr_cont8,
			 						"nutr_cont9" : ary['aaData'][i].nutr_cont9,
									"deleteBtn" : deleteBtn
			 					}
							);
						}
						
						example_table.clear().draw();
						example_table.rows.add(tmp);
						example_table.columns.adjust().draw();
						
						$('div.dataTables_filter label').css('text-align','right');
						
					}
				});
			},
			editable : false,
			eventLimit : false,
			events : function(start, end, timezone, callback) {
				
				$('#calendar').fullCalendar( 'removeEvents' );
				
				stDate = start.format('YYYY-MM-DD');
				edDate = end.format('YYYY-MM-DD');
				
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
								id: response[i].pnum,
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
            	{data: "gram"},
            	{data: "nutr_cont1"},
            	{data: "nutr_cont2"},
            	{data: "nutr_cont3"},
            	{data: "nutr_cont4"},
            	{data: "nutr_cont5"},
            	{data: "nutr_cont6"},
            	{data: "nutr_cont7"},
            	{data: "nutr_cont8"},
            	{data: "nutr_cont9"},
            	{data: "deleteBtn"}
            ]
            
        });
		
		$('div.dataTables_filter label').css('text-align','right');
		
		var addBtn = '&nbsp;&nbsp;<a id="addFood" href="#"><img src="images/intake/intakeinfo/add.png" /></a>';
		$('div.dataTables_filter label').append(addBtn);
	}
	
	function calendarRefresh() {		
		var sendData = [stDate, edDate];
		
		$.ajax({
			method : 'post',
			url : 'searchIntakeinfo',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType : 'application/json; charset=UTF-8',
			success : function(response) {
				
				$('#calendar').fullCalendar( 'removeEventSources' );
				
				var events = [];
				
				for(var i in response) {
					var regdt = response[i].regdate.split(" ");
					
					events.push({
						id: response[i].pnum,
						title: response[i].desc_kor,
						start: regdt[0]
					});
				}
				
		        $('#calendar').fullCalendar( 'addEventSource', events);		        
			}
		});
		
	}
	
	function dataTablesRefresh() {
		example_table.ajax.reload();
	}
	
	function addBtnFn() {
		$('#calendar').fullCalendar('select',regdate);
		var url = "intakeInsert?regdate=" + regdate;
		window.open(url, "intakeInsert", "width=1250,height=500"); 
	}
	
	function delEvt(pnum) {
		// 달력에 있는 이벤트 제거
		$.ajax({
			method : 'post',
			url : 'selectIntakeInfoByNum',
			data : "pnum=" + pnum,
			dataType : 'json',
			success : function(response){
				alert(JSON.stringify(response));
				alert(response.pnum);
			}
		});
	}
	
	// 등록정보 삭제 부분
	function delBtnFn(pnum) {
		$('#calendar').fullCalendar('select',regdate);
		
		// 이벤트를 직접 DB에서 제거하는 부분
		$.ajax({
			method : 'post',
			url : 'intakeInsertDelete',
			data : pnum,
			dataType : 'text',
			succsess : function(response) {
				//alert(response);
				dataTablesRefresh();
				
				delEvt(pnum);
			}
		});
		
		//calendarRefresh();
		
		
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
	 						"gram" : ary['aaData'][i].gram,
	 						"nutr_cont1" : ary['aaData'][i].nutr_cont1,
	 						"nutr_cont2" : ary['aaData'][i].nutr_cont2,
	 						"nutr_cont3" : ary['aaData'][i].nutr_cont3,
	 						"nutr_cont4" : ary['aaData'][i].nutr_cont4,
	 						"nutr_cont5" : ary['aaData'][i].nutr_cont5,
	 						"nutr_cont6" : ary['aaData'][i].nutr_cont6,
	 						"nutr_cont7" : ary['aaData'][i].nutr_cont7,
	 						"nutr_cont8" : ary['aaData'][i].nutr_cont8,
	 						"nutr_cont9" : ary['aaData'][i].nutr_cont9,
	 						"deleteBtn" : "<a data-pnum='" + ary['aaData'][i].pnum + "' href='javascript:delBtnFn(this)'><img class='delBtn' data-pnum='" + ary['aaData'][i].pnum + "' src='images/intake/intakeinfo/trash.png' /></a>"
	 					}
					);
				}
				
				example_table.clear().draw();
				example_table.rows.add(tmp);
				example_table.columns.adjust().draw();
				
				$('div.dataTables_filter label').css('text-align','right');
				
				
				$('#calendar').fullCalendar( 'removeEvents', pnum );
			}
		});

	}
	
	function insertIntake(sendData) {
		$('#calendar').fullCalendar('select',regdate);
		
		$.ajax({
			method : 'post',
			url : 'insertIntake',
			data : JSON.stringify(sendData),
			contentType : 'application/json; charset=UTF-8',
			dataType : 'text',
			success : function(response){
				
				dataTablesRefresh();
				
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
			 						"gram" : ary['aaData'][i].gram,
			 						"nutr_cont1" : ary['aaData'][i].nutr_cont1,
			 						"nutr_cont2" : ary['aaData'][i].nutr_cont2,
			 						"nutr_cont3" : ary['aaData'][i].nutr_cont3,
			 						"nutr_cont4" : ary['aaData'][i].nutr_cont4,
			 						"nutr_cont5" : ary['aaData'][i].nutr_cont5,
			 						"nutr_cont6" : ary['aaData'][i].nutr_cont6,
			 						"nutr_cont7" : ary['aaData'][i].nutr_cont7,
			 						"nutr_cont8" : ary['aaData'][i].nutr_cont8,
			 						"nutr_cont9" : ary['aaData'][i].nutr_cont9,
			 						"deleteBtn" : "<a data-pnum='" + ary['aaData'][i].pnum + "' href='javascript:delBtnFn(this)'><img class='delBtn' data-pnum='" + ary['aaData'][i].pnum + "' src='images/intake/intakeinfo/trash.png' /></a>"
			 					}
							);
						}
						
						$('#calendar').fullCalendar( 'addEventSource', [{
							title: sendData.desc_kor,
							start: sendData.regdate
						}]);
						
						//alert(JSON.stringify(tmp));
						
						example_table.clear().draw();
						example_table.rows.add(tmp);
						example_table.columns.adjust().draw();
						
						//$('div.dataTables_filter label').css('text-align','right');
						
					}
				});
			}
		});
		
		
		$('html, body').scrollTop($(document).height());
	}	
	
	function userinfoMod() {
		var ct = window.prompt("비밀번호를 입력하세요","");
		
		if(ct != "") {
			var sendData = {
				"userpwd" : ct
			};
			
			$.ajax({
				method : 'post',
				url : 'memberUpdate',
				data : JSON.stringify(sendData),
				contentType : 'application/json; charset=UTF-8',
				dataType : 'text',
				success : function(response) {
					alert(response);
				}
			});
		}		
	}
	
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

<style>
#calendar {
	max-width: 80%;
	margin: 0 auto;
}

/* 회원정보수정 */
label, input { display:block; }
input.text { margin-bottom:12px; width:95%; padding: .4em; }
fieldset { padding:0; border:0; margin-top:25px; }
h1 { font-size: 1.2em; margin: .6em 0; }
div#users-contain { width: 350px; margin: 20px 0; }
div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
.ui-dialog .ui-state-error { padding: .3em; }
.validateTips { border: 1px solid transparent; padding: 0.3em; }

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
						<li><a href="javascript:pwdChk()"><i class="fa fa-user fa-fw"></i> User
								Profile</a></li>
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
					<h1 class="page-header"> </h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<div class="row">
				<div id='calendar'></div>
				<!-- /.panel-heading -->
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                            	<th>식품번호</th>
                                <th>식품이름</th>
                                <th>섭취량(g)</th>
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