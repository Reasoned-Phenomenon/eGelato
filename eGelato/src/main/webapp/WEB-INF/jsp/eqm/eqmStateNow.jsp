<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>실시간 설비 상태(온도/UPH/생산량)</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>

<br>
<h2>모니터링 관리</h2>
<br>

<div class="col-sm-6">
	<div id="temp_curve_chart" style="width: 900px; height: 500px"></div>
</div>

<div class="col-sm-6">
	
</div>

<script>
let eqmIdFlag, tempFlag;
var tempData,tempOptions,tempChart;

google.charts.load('current', {'packages':['line']});
google.charts.setOnLoadCallback(tempAjax);

function drawChart() {

}

function tempAjax(){
	
	tempData = new google.visualization.DataTable();
	
	tempOptions = {
	  title: '실시간 설비 온도',
	  curveType: 'function',
	  legend: { position: 'bottom' }
	};
	
	tempChart = new google.charts.Line(document.getElementById('temp_curve_chart'));
	
	$.ajax({
			url : "${path}/eqm/findEqmTemp.do",
			dataType : 'json',
			method : 'GET',
			error : function(result){
				console.log('에러',result)
			}
		}).done(function (result){
			tempData.addColumn('number', 'log_tm');
			eqmIdFlag = '';
			let tmSet = new Set();
			for(let i = 0; i<result.data.contents.length; i++){
				if(eqmIdFlag != result.data.contents[i].eqmId){
					tempData.addColumn('number', result.data.contents[i].eqmId);
					eqmIdFlag = result.data.contents[i].eqmId
				}
				
				tmSet.add(result.data.contents[i].logTm.substring(11,19).replace(/:/g,''))
				
			} 
			
			for(let i = 0; i<result.data.contents.length; i++) {
				if ( tmSet.has(result.data.contents[i].logTm.substring(11,19).replace(/:/g,'')) ) {
					
				}
			}
			
			
			
			for(let j = 0 ; j <result.data.contents.length; j++) {
				
				let bodyRow = [];
				
				let tm = result.data.contents[j].logTm.substring(11,19).replace(/:/g,'');
				bodyRow.push(parseInt(tm));
				
				for(let r = 0 ; r < result.data.contents.length; r++ ) {
					if(tm == result.data.contents[r].logTm.substring(11,19).replace(/:/g,'')) {
						bodyRow.push(parseDouble(result.data.contents[r].tempNow))
					} else {
						bodyRow.push(0);
					}
				}
				console.log(tempData)
				//console.log(bodyRow);
				//bodyRows.push(bodyRow);
				//tempData.addRows([bodyRow]);
			} 
			
			//tempData.addRows(bodyRows);
			//tempChart.draw(tempData, google.charts.Line.convertOptions(tempOptions));
			
		})
}

//tempAjax();	
</script>

</body>
</html>