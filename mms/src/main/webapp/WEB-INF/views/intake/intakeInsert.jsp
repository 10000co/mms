<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록</title>
<script src="script/common/jquery-3.3.1.min.js"></script>
<script>
	var naviCurrentPage = "";
	var naviPagePerGroup = "";
	
	var nutrition = "";
	var nutrition_oneGram = "";
	var nutrition_final = "";
	
	var selectFlag = false;
	
	$(function(){
		$('#searchBtn').on('click',search);
		
		var tagInsert = ""
		tagInsert += "<tr>"
		tagInsert += "<td>식품군</td>"
		tagInsert += "<td>식품이름</td>"
		tagInsert += "<td>1회제공량(g)</td>"
		tagInsert += "<td>열량(kcal)</td>"
		tagInsert += "<td>탄수화물(g)</td>"
		tagInsert += "<td>단백질(g)</td>"
		tagInsert += "<td>지방(g)</td>"
		tagInsert += "<td>당류(g)</td>"
		tagInsert += "<td>나트륨(mg)</td>"
		tagInsert += "<td>콜레스테롤(mg)</td>"
		tagInsert += "<td>포화지방산(g)</td>"
		tagInsert += "<td>트랜스지방(g)</td>"
		tagInsert += "<td>가공업체명</td>"
		tagInsert += "</tr>"
		
		$('#searchResult').html(tagInsert);
		$('#nutr_cont1').keyup(calcKcalFn);
		$('#insertBtn').on('click',insertData);
	});
	
	function insertData() {
		if(selectFlag == true) {
			var sendData = JSON.stringify(nutrition_final);
			$(opener.location).attr("href","javascript:insertIntake(" + sendData + ");");
			window.close();
		}
	}
	
	function calcKcalFn() {
		var tpVal = $('#nutr_cont1').val();
		var regdate = $('#regdate').val();
		
		// 숫자 이외에 다른 문자는 입력하지 못하도록 방지
		
		if( isNaN(tpVal) || tpVal.charAt(tpVal.length-1) == ' ' || tpVal.indexOf(".") != -1) {
			alert("숫자만 입력해 주세요 ( 정수만 입력할 수 있습니다 )");
			$('#nutr_cont1').val(tpVal.replace(/[^0-9]/g,''));
		}
		
		// 정수인지 실수인지 확인
// 		if(tpVal.indexOf(".") != -1) {
// 			alert("정수만 입력할 수 있습니다");
// 			$('#nutr_cont1').val(tpVal.replace(".",""));
// 			return;
// 		}
		
		if( !isNaN(tpVal) && tpVal != "" ) {
			var val = parseInt(tpVal);
			
			var serving_wt = val;
			var nutr_cont1 = nutrition_oneGram.nutr_cont1 * val;
			var nutr_cont2 = nutrition_oneGram.nutr_cont2 * val;
			var nutr_cont3 = nutrition_oneGram.nutr_cont3 * val;
			var nutr_cont4 = nutrition_oneGram.nutr_cont4 * val;
			var nutr_cont5 = nutrition_oneGram.nutr_cont5 * val;
			var nutr_cont6 = nutrition_oneGram.nutr_cont6 * val;
			var nutr_cont7 = nutrition_oneGram.nutr_cont7 * val;
			var nutr_cont8 = nutrition_oneGram.nutr_cont8 * val;
			var nutr_cont9 = nutrition_oneGram.nutr_cont9 * val;
			var animal_plant = nutrition_oneGram.animal_plant;
			var bgn_year = nutrition_oneGram.bgn_year;
			
			if(selectFlag == true) {
				var setInsert = $('.rs');
				$('.rs').eq(2).html(nutr_cont1.toFixed(2));
				$('.rs').eq(3).html(nutr_cont2.toFixed(2));
				$('.rs').eq(4).html(nutr_cont3.toFixed(2));
				$('.rs').eq(5).html(nutr_cont4.toFixed(2));
				$('.rs').eq(6).html(nutr_cont5.toFixed(2));
				$('.rs').eq(7).html(nutr_cont6.toFixed(2));
				$('.rs').eq(8).html(nutr_cont7.toFixed(2));
				$('.rs').eq(9).html(nutr_cont8.toFixed(2));
				$('.rs').eq(10).html(nutr_cont9.toFixed(2));
			}			
			
			nutrition_final = {
				"num" : nutrition_oneGram.num,
				"desc_kor" : nutrition_oneGram.desc_kor,
				"gram" :  tpVal,
				"nutr_cont1" : nutr_cont1.toFixed(2),
				"nutr_cont2" : nutr_cont2.toFixed(2),
				"nutr_cont3" : nutr_cont3.toFixed(2),
				"nutr_cont4" : nutr_cont4.toFixed(2),
				"nutr_cont5" : nutr_cont5.toFixed(2),
				"nutr_cont6" : nutr_cont6.toFixed(2),
				"nutr_cont7" : nutr_cont7.toFixed(2),
				"nutr_cont8" : nutr_cont8.toFixed(2),
				"nutr_cont9" : nutr_cont9.toFixed(2),
				"regdate" : regdate
			}
			
		}		
	}
	
	function getSelectedInfo(obj) {
		var sendData = $(obj).attr('data-num');
		var regdate = $('#regdate').val();
		
		selectFlag = true;
		
		$.ajax({
			method : 'post',
			url :  'selectIntakeInfoByNum',
			data : 'num='+sendData,
			dataType : 'json',
			success : function(response) {
				
				$('#nutr_cont1').val(response.serving_wt);
				
				var setInsert = $('.rs');
				$('.rs').eq(0).html(response.fdgrp_nm);
				$('.rs').eq(1).html(response.desc_kor);
				$('.rs').eq(2).html(response.nutr_cont1);
				$('.rs').eq(3).html(response.nutr_cont2);
				$('.rs').eq(4).html(response.nutr_cont3);
				$('.rs').eq(5).html(response.nutr_cont4);
				$('.rs').eq(6).html(response.nutr_cont5);
				$('.rs').eq(7).html(response.nutr_cont6);
				$('.rs').eq(8).html(response.nutr_cont7);
				$('.rs').eq(9).html(response.nutr_cont8);
				$('.rs').eq(10).html(response.nutr_cont9);
				
				nutrition = {
					"num" : response.num,
					"food_cd" : response.food_cd,
					"fdgrp_nm" : response.fdgrp_nm,
					"desc_kor" : response.desc_kor,
					"serving_wt" : response.serving_wt,
					"nutr_cont1" : response.nutr_cont1,
					"nutr_cont2" : response.nutr_cont2,
					"nutr_cont3" : response.nutr_cont3,
					"nutr_cont4" : response.nutr_cont4,
					"nutr_cont5" : response.nutr_cont5,
					"nutr_cont6" : response.nutr_cont6,
					"nutr_cont7" : response.nutr_cont7,
					"nutr_cont8" : response.nutr_cont8,
					"nutr_cont9" : response.nutr_cont9,
					"animal_plant" : response.animal_plant,
					"bgn_year" : response.bgn_year
				}
				
				nutrition_final = {
					"num" : response.num,
					"desc_kor" : response.desc_kor,
					"gram" : response.serving_wt,
					"nutr_cont1" : response.nutr_cont1.toFixed(2),
					"nutr_cont2" : response.nutr_cont2.toFixed(2),
					"nutr_cont3" : response.nutr_cont3.toFixed(2),
					"nutr_cont4" : response.nutr_cont4.toFixed(2),
					"nutr_cont5" : response.nutr_cont5.toFixed(2),
					"nutr_cont6" : response.nutr_cont6.toFixed(2),
					"nutr_cont7" : response.nutr_cont7.toFixed(2),
					"nutr_cont8" : response.nutr_cont8.toFixed(2),
					"nutr_cont9" : response.nutr_cont9.toFixed(2),
					"regdate" : regdate
				}
				
				var dv = parseFloat(response.serving_wt);
				
				var num = response.num;
				var food_cd = response.food_cd;
				var fdgrp_nm = response.fdgrp_nm;
				var desc_kor = response.desc_kor;
				var serving_wt = response.serving_wt;
				var nutr_cont1 = parseFloat(response.nutr_cont1) / dv;
				var nutr_cont2 = parseFloat(response.nutr_cont2) / dv;
				var nutr_cont3 = parseFloat(response.nutr_cont3) / dv;
				var nutr_cont4 = parseFloat(response.nutr_cont4) / dv;
				var nutr_cont5 = parseFloat(response.nutr_cont5) / dv;
				var nutr_cont6 = parseFloat(response.nutr_cont6) / dv;
				var nutr_cont7 = parseFloat(response.nutr_cont7) / dv;
				var nutr_cont8 = parseFloat(response.nutr_cont8) / dv;
				var nutr_cont9 = parseFloat(response.nutr_cont9) / dv;
				var animal_plant = response.animal_plant;
				var bgn_year = response.bgn_year;
				
				nutrition_oneGram = {
					"num" : response.num,
					"food_cd" : response.food_cd,
					"fdgrp_nm" : response.fdgrp_nm,
					"desc_kor" : response.desc_kor,
					"serving_wt" : response.serving_wt,
					"nutr_cont1" : nutr_cont1,
					"nutr_cont2" : nutr_cont2,
					"nutr_cont3" : nutr_cont3,
					"nutr_cont4" : nutr_cont4,
					"nutr_cont5" : nutr_cont5,
					"nutr_cont6" : nutr_cont6,
					"nutr_cont7" : nutr_cont7,
					"nutr_cont8" : nutr_cont8,
					"nutr_cont9" : nutr_cont9,
					"animal_plant" : response.animal_plant,
					"bgn_year" : response.bgn_year
				}
				
			}
		});
	}
	
	function pageClick(num) {
		
		$('#currentPage').val(num);
		
		search();
	}
	
	function forword1() {
		$('#currentPage').val(parseInt(naviCurrentPage) + 1);
		search();
	}
	
	function forword2() {
		$('#currentPage').val(parseInt(naviCurrentPage) + parseInt(naviPagePerGroup));
		search();
	}
	
	function backword1() {
		$('#currentPage').val(parseInt(naviCurrentPage) - 1);
		search();
	}
	
	function backword2() {
		$('#currentPage').val(parseInt(naviCurrentPage) - parseInt(naviPagePerGroup));
		search();
	}
	
	function move(way) {
		switch(way) {
			case 1 : 
				forword1();
				break;
			case 2 : 
				backword1();				
				break;
			case 3 : 
				forword2();
				break;
			case 4 : 
				backword2();
				break;
		}
	}
	
	function search() {		
		var searchOpt = $('#category option:selected').val();
		var regdate = $('#regdate').val();
		var currentPage = $('#currentPage').val();
		var sendData = "";
					
		var searchText = $('#searchText').val();
		if(searchOpt == 'desc_kor') {
			sendData = {
				"desc_kor" : searchText,
				"currentPage" : currentPage
			};
		}
		else {
			sendData = {
				"fdgrp_nm" : searchText,
				"currentPage" : currentPage
			};
		}
			
		$.ajax({
			method : 'post',
			url : 'searchFoodinfo',
			data : JSON.stringify(sendData),
			dataType : 'json',
			contentType : 'application/json; charset=UTF-8',
			success : function(response) {
				
				naviCurrentPage = response.navi.currentPage;
				naviPagePerGroup = response.navi.pagePerGroup;
					
				$('#searchResult').html("");
				
				var tagInsert = "";
				tagInsert += "<tr>";
				tagInsert += "<td>식품군</td>";
				tagInsert += "<td>식품이름</td>";
				tagInsert += "<td>1회제공량(g)</td>";
				tagInsert += "<td>열량(kcal)</td>";
				tagInsert += "<td>탄수화물(g)</td>";
				tagInsert += "<td>단백질(g)</td>";
				tagInsert += "<td>지방(g)</td>";
				tagInsert += "<td>당류(g)</td>";
				tagInsert += "<td>나트륨(mg)</td>";
				tagInsert += "<td>콜레스테롤(mg)</td>";
				tagInsert += "<td>포화지방산(g)</td>";
				tagInsert += "<td>트랜스지방(g)</td>";
				tagInsert += "<td>가공업체명</td>";
				tagInsert += "<td>선택</td>";
				tagInsert += "</tr>";
				
				for(var i in response.list) {
					tagInsert += "<tr>"
					tagInsert += "<td>" + response.list[i].fdgrp_nm + "</td>"
					tagInsert += "<td>" + response.list[i].desc_kor + "</td>"
					tagInsert += "<td>" + response.list[i].serving_wt + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont1 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont2 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont3 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont4 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont5 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont6 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont7 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont8 + "</td>"
					tagInsert += "<td>" + response.list[i].nutr_cont9 + "</td>"
					if( typeof(response.list[i].animal_plant) != "undefined" ) {
						tagInsert += "<td>" + response.list[i].animal_plant + "</td>"	
					}
					else {
						tagInsert += "<td>N/A</td>"
					}
					tagInsert += "<td><input type='button' data-num=" + response.list[i].num + " value='선택' onclick='javascript:getSelectedInfo(this)' /></td>"
					tagInsert += "</tr>"
					
					$('#searchResult').html(tagInsert);
				}
				
				var pagingSet = "";
				pagingSet += '<a href="javascript:move(4)">◁◁</a> ';
				pagingSet += '<a href="javascript:move(2)">◀</a> ';
				pagingSet += '&nbsp;&nbsp; ';
				pagingSet += '<span id="pagingNum"></span> ';
				pagingSet += '&nbsp;&nbsp; ';
				pagingSet += '<a href="javascript:move(1)">▶</a> ';
				pagingSet += '<a href="javascript:move(3)">▷▷</a>';
				
				$('.pagingSet').html(pagingSet);
				
				var startIdx = parseInt(response.navi.startPageGroup);
				var endIdx = parseInt(response.navi.endPageGroup);
				var currentPage = $('#currentPage').val();
				
				for( var i=startIdx; i<=endIdx; i++ ) {
					if(currentPage != i) {
						$('#pagingNum').append('<a href="javascript:pageClick('+ i +')"> ' + i + ' </a>');
					}
					else {
						$('#pagingNum').append(' ' + i + ' ');
					}
				}
			}
		});
		
		
		
	}
</script>
</head>
<body>
	<input id="regdate" type="hidden" value="${regdate}" />
	<input id="currentPage" type="hidden" value="1" />
	
	그램(g) : <input id="nutr_cont1" type="text" /><br /><br />
	
	<hr />
	
	<table id="setInsert" border="1">
		<tr>
			<td>식품군</td>
			<td>식품이름</td>
			<td>열량(kcal)</td>
			<td>탄수화물(g)</td>
			<td>단백질(g)</td>
			<td>지방(g)</td>
			<td>당류(g)</td>
			<td>나트륨(mg)</td>
			<td>콜레스테롤(mg)</td>
			<td>포화지방산(g)</td>
			<td>트랜스지방(g)</td>
		</tr>
		<tr>
			<td class="rs"></td>
			<td class="rs"></td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
			<td class="rs">0</td>
		</tr>
	</table>
	
	<hr />
	
	<input id="searchText" type="text" />
	<select id="category">
		<optgroup label="기본검색">
			<option value="desc_kor">식품이름</option>
		</optgroup>
		<optgroup label="식품군">
			<c:forEach var="food" items="${foodCategory}">
				<option value="${food}">${food}</option>
			</c:forEach>
		</optgroup>
	</select>
	<input id="searchBtn" type="button" value="검색" />
	<input id="insertBtn" type="button" value="추가" />
	
	<table id="searchResult" border="1"></table>
	
	<div class="pagingSet"></div>
	
</body>
</html>

