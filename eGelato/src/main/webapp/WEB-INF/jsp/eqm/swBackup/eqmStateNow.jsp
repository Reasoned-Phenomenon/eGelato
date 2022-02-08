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

<div class="col-sm-6">
	<div id="chart-temp"></div>
</div>

<div class="col-sm-6">
	<div id="chart-prod"></div>
</div>

<script>
//선언
let tempFlag;
let prodFlag;

//--------------------------------------온도 차트 시작-------------------------------------------------------//
//온도 차트 생성
var tempEl = document.getElementById('chart-temp');

var tempData = {
	categories: [
		'1',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'10',
		'11',
		'12',
		'13',
		'14',
		'15',
	],
	series: [],
};

var tempOptions = { 
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


var tempChart = toastui.Chart.lineChart({ el:tempEl, data:tempData, options:tempOptions });

//--------------------------------------온도 차트 끝-------------------------------------------------------//



//--------------------------------------생산량 차트 시작-------------------------------------------------------//
const prodEl = document.getElementById('chart-prod');

const prodData = {
		  categories: [
		    '2022-02-01 12:10:38',
		    '02/01/2020',
		    '03/01/2020',
		    '04/01/2020',
		    '05/01/2020',
		    '06/01/2020',
		    '07/01/2020',
		    '08/01/2020',
		    '09/01/2020',
		    '10/01/2020',
		    '11/01/2020',
		    '12/01/2020',
		  ],
		  series: [
		    {
		      name: 'Seoul',
		      data: [-3.5, -1.1, 4.0, 11.3, 17.5, 21.5, 25.9, 27.2, 24.4, 13.9, 6.6, -0.6],
		    },
		    {
		      name: 'Seattle',
		      data: [3.8, 5.6, 7.0, 9.1, 12.4, 15.3, 17.5, 17.8, 15.0, 10.6, 6.6, 3.7],
		    },
		    {
		      name: 'Sydney',
		      data: [22.1, 22.0, 20.9, 18.3, 15.2, 12.8, 11.8, 13.0, 15.2, 17.6, 19.4, 21.2],
		    },
		    {
		      name: 'Moscow',
		      data: [-10.3, -9.1, -4.1, 4.4, 12.2, 16.3, 18.5, 16.7, 10.9, 4.2, -2.0, -7.5],
		    },
		    {
		      name: 'Jungfrau',
		      data: [-13.2, -13.7, -13.1, -10.3, -6.1, -3.2, 0.0, -0.1, -1.8, -4.5, -9.0, -10.9],
		    },
		  ],
		};

		const prodOptions = {
		  chart: { title: '24-hr Average Temperature', width: 1000, height: 500 },
		  xAxis: {
		    title: 'Month',
		  },
		  yAxis: {
		    title: 'Amount',
		  },
		  tooltip: {
		    formatter: (value) => `${value}°C`,
		  },
		  legend: {
		    align: 'bottom',
		  },
		};	



const prodChart = toastui.Chart.lineChart({ el:prodEl, data:prodData, options:prodOptions });

//--------------------------------------생산량 차트 끝-------------------------------------------------------//

//Ajax

	//온도 Ajax
	function tempAjax(){
		$.ajax({
				url : "${path}/eqm/findEqmTemp.do",
				dataType : 'json',
				method : 'GET',
				error : function(result){
					console.log('에러',result)
				}
			}).done(function (result){
				
				//초기화
				var datum = {name:'', data:[]};
				tempFlag = '';
				tempData.categories = [];
				tempData.series = [];
				
				let logSet = new Set();
				
				for(let i = 0; i<result.data.contents.length; i++){
					//tempData.categories.push(result.data.contents[i].logTm.substring(11,19));
					console.log(result.data.contents[i].logTm.substring(11,19))
					logSet.add(result.data.contents[i].logTm.substring(11,19))
					if(tempFlag != result.data.contents[i].eqmId){
						if (datum.name != '') {
							tempData.series.push(datum);
							console.log(tempData)
						} 
						
						datum = {name:'', data:[]};

						tempFlag = result.data.contents[i].eqmId;
						datum.name = result.data.contents[i].eqmId;
						datum.data.push(Number(result.data.contents[i].tempNow));
					} else {
						datum.data.push(Number(result.data.contents[i].tempNow));
					}
					
					if(i == result.data.contents.length-1) {
						tempData.series.push(datum);
					}
				} 
				
				tempData.categories=Array.from(logSet);
				
				tempChart.setData(tempData);
				console.log(tempData.categories);
			})
	}

//setInterval

/* const intervalId = setInterval(() => {
		console.log("인터벌---")
		tempAjax();
		console.log("인터벌---")
}, 5000); */

$(function () {
	tempAjax();
})

</script>

</body>
</html>