<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
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
			<option value="선택">선택</option>
			<option value="온도">온도</option>
			<option value="생산량">생산량</option>
		</select>
	</div>
	<div id="chart-area"></div>

<script>

	const el = document.getElementById('chart-area');
	    
	var logTm = 0;
	var tempNow; 
	var data = {};
	var options = {};
	var chart;
	
	
	//5초마다 반영
	/* const intervalId = setInterval(() => {
		logTm += 1;
		const random = Math.round(Math.random() * 100);
			chart.addData([random],new Date());
		}, 5000);    */
	
	//화면 로드시 바로 보이는 차트
	/*$(function(){
		var state = $('#state option:selected').val();
		console.log(state)
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
			data = {
				categories: [],
				series: [
					{
						name: 'eqmId',
						data: [],
					}
				],
			};
	 
		for(let i = 0; i<result.data.contents.length; i++){
			data.categories.push(result.data.contents[i].logTm);
			data.series[0].data.push(Number(result.data.contents[i].tempNow))
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
				formatter: (value) => value+`°C`,
			},
			legend: {
				align: 'bottom',
			},
			series: {
				shift: true,
			},
		
		};
		
		chart = toastui.Chart.lineChart({ el, data, options });
		
		})
	}) */
	
	var flag = 0;
 
	//값 가져오기 
	function selectState() {
		
		
		var state = $('#state option:selected').val();
		console.log("select: ",state)
		
		
		if(state == '온도'){
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
				
				chart = toastui.Chart.lineChart({ el, data, options });
				
			}) 
		}else {
			$.ajax({
				url : "${path}/eqm/findEqmOutput.do",
				dataType : 'json',
				method : 'GET',
				error : function(result){
				console.log('에러',result)
				}
			}).done(function (result){
				
				console.log("값내놔",result)
				
				data = {
					categories: [],
					series: [
						{
							name: result.data.contents[0].eqmId,
							data: [],
						}
					],
				};
				
				for(let i = 0; i<result.data.contents.length; i++){
					data.categories.push(result.data.contents[i].logTm);
					
					var b = {
						name: '',
						data: [],
					};
					
					b.name = result.data.contents[i].eqmId;
					b.data.push(Number(result.data.contents[i].prodQy));
					
					data.series.push(b);
				}
				
				options = { 
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
				
				chart = toastui.Chart.lineChart({ el, data, options });
			})
		}
	}  
  
  
</script>
</body>
</html>