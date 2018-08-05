$(function() {
	var dataArr = [];
	var morrisBarKcal = '';
	
	$.ajax({
		method : 'post',
		url : 'kcalStatistics',
		dataType : 'json',
		success : function(response) {
			
			for(var i in response) {
				dataArr.push(response[i]);
			}
			
		    morrisBarKcal = Morris.Bar({
		        element: 'morris-bar-chart',
		        data: dataArr,
		        xkey: 'month',
		        ykeys: ['Kcal'],
		        labels: ['칼로리 섭취량'],
		        hideHover: 'auto',
		        resize: true
		    });
		}
	});
    
});
