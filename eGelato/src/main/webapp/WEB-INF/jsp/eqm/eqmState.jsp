<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>실시간 설비 상태(온도/UPH/생산량)</title>
</head>
<body>
	<br>
	<h2>모니터링 관리</h2>
	<br>
	<div>
		<select id="state" onchange="selectState()">
			<option value="온도">온도</option>
			<option value="생산량">생산량</option>
		</select>
	</div>
	<div id="chart-area"></div>
	<div id="chart-area2"></div>

	<script>

	const el = document.getElementById('chart-area');
	const el2 = document.getElementById('chart-area2');
    
	var logTm = 0;
	var tempNow; 
	var data = {
			categories: [],
			series: [],
		};
	var data2 = {
			categories: [],
			series: [],
		};
	var options = {};
	var options2 = {};
	var chart;
	var chart2;
	var flag = 0;
	

	$(function(){
		tempAjax();
		outputAjax();
		setTimeout(() => {
		chart = toastui.Chart.lineChart({ el, data, options });
		//chart2 = toastui.Chart.lineChart({ el2, data, options2 });
		}, 1000);
	})
	
	//온도 ajax
	function tempAjax(){
		$.ajax({
			url : "${path}/eqm/findEqmTemp.do",
			dataType : 'json',
			method : 'GET',
			async : false,
			error : function(result){
				console.log('에러',result)
			}
		}).done(function (result){
			console.log(result)
			console.log(result.data.contents[0].eqmId)
			
			data = {
				categories: [],
				series: [],
			};
			
			var a = {name: '', data: [],};
			
			for(let i = 0; i<result.data.contents.length; i++){
				
				data.categories.push(result.data.contents[i].logTm);
				
				if(flag != result.data.contents[i].eqmId){
					if (a.name != '') {
						console.log("추가")
						data.series.push(a);
					} else {
						console.log("a 초기화")
						a.name = '';
						a.data = [];
					}
					console.log("a 값 넣어줌")
					flag = result.data.contents[i].eqmId;
					a.name = result.data.contents[i].eqmId;
					a.data.push(Number(result.data.contents[i].tempNow));
				} else {
					console.log("데이터만 넣어줌")
					a.data.push(Number(result.data.contents[i].tempNow));
				}
				
				if(i == result.data.contents.length-1) {
					console.log("마지막 넣어줌")
					data.series.push(a);
				}
				//chart.setData(data);
				
			} 
				
			options = { 
				chart: { title: '실시간 설비 온도', width: 1000, height: 500 },
				xAxis: {
					pointOnColumn: true,
					title: '시간',
					date : {format : 'hh:mm:ss'}
				},
				yAxis: {
					title: 'Amount',
				},
				tooltip: {
					formatter: (value) =>  value+`°C`,
				},
				legend: {
					align: 'bottom',
				},
				series: {
					shift: true,
				},
			};
		}) 
	}
	
	//생산량 ajax
	function outputAjax(){
		$.ajax({
			url : "${path}/eqm/findEqmOutput.do",
			dataType : 'json',
			method : 'GET',
			error : function(result){
			console.log('에러',result)
			}
		}).done(function (result){
			
			console.log("값내놔",result)
			
			data2 = {
				categories: [],
				series: [],
			}; 
			
			var b = {name: '', data: [],};
			
			for(let i = 0; i<result.data.contents.length; i++){
				
				data2.categories.push(result.data.contents[i].logTm);
				
				if(flag != result.data.contents[i].eqmId){
					if (b.name != '') {
						console.log("추가")
						data2.series.push(b);
					}else {
						console.log("a 초기화")
						b.name = '';
						b.data = [];
					}
					
					console.log("b 값 넣어줌")
					flag = result.data.contents[i].eqmId;
					b.name = result.data.contents[i].eqmId;
					b.data.push(Number(result.data.contents[i].prodQy));
					}else {
						console.log("데이터만 넣어줌")
						b.data.push(Number(result.data.contents[i].prodQy));
					}
					if(i == result.data.contents.length-1) {
						console.log("마지막 넣어줌")
						data2.series.push(b);
					}
				} 
			
			options2 = { 
				chart: { title:  '실시간 설비 생산량', width: 1000, height: 500 },
				xAxis: {
					pointOnColumn: true,
					title: '시간',
					date : {format : 'hh:mm:ss'}
				},
				yAxis: {
					title: 'Amount',
				},
				tooltip: {
					formatter: (value) =>  value+`개`,
				},
				legend: {
					align: 'bottom',
				},
				series: {
					shift: true,
				},
			};
		})
	}
	
	
	const intervalId = setInterval(() => {
		tempAjax();
		}, 5000);  
	
	//값 가져오기 
	function selectState() {
		
		var state = $('#state option:selected').val();
			console.log("select: ",state)
		
		if(state == '온도'){
			 tempAjax();
		}else {
			 outputAjax();
		}
	}  
	
</script>
</body>
</html>