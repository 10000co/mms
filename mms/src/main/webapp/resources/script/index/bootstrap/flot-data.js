//Flot Pie Chart
$(function() {
	
	$.ajax({
		method : 'post',
		url : 'selectThreeMajorNutrients',
		dataType : 'json',
		success : function(response) {
			
			var data = [{
		        label: "탄수화물",
		        data: response.nutr_cont2
		    }, {
		        label: "단백질",
		        data: response.nutr_cont3
		    }, {
		        label: "지방",
		        data: response.nutr_cont4
		    }];
			
			var plotObj = $.plot($("#flot-pie-chart"), data, {
		        series: {
		            pie: {
		                show: true
		            }
		        },
		        grid: {
		            hoverable: true
		        },
		        tooltip: true,
		        tooltipOpts: {
		            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
		            shifts: {
		                x: 20,
		                y: 0
		            },
		            defaultTheme: false
		        }
		    });
		}
	});
    

});
