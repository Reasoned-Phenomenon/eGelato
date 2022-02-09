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


<div class="col-4">
	<div id="chart-temp"></div>
</div>
<div class="col-4">
	<div id="chart-prod"></div>
</div>

<script>
//--------------------------------------온도 차트 시작-------------------------------------------------------//
//온도 차트 생성
var tempEl = document.getElementById('chart-temp');

var tempData = {
	categories: [],
	series: [],
};

var tempOptions = { 
		chart: { title: '실시간 설비 온도', width: 400, height: 300 },
		xAxis: {
			title: '시간',
			date: { format: 'hh:mm:ss' }
		},
		yAxis: {
			title: '온도',
		},
		tooltip: {
			formatter: (value) =>  value+`°C`,
		},
		legend: {
			align: 'bottom',
		},
        series: {
            spline: true,
        },
	};


var tempChart = toastui.Chart.lineChart({ el:tempEl, data:tempData, options:tempOptions });

//--------------------------------------온도 차트 끝-------------------------------------------------------//

//--------------------------------------생산량 차트 시작-------------------------------------------------------//
var prodEl = document.getElementById('chart-prod');

var prodData = {
	categories: [],
	series: [],
};

var prodOptions = {
  chart: { title: '실시간 설비 생산량', width: 400, height: 300 },
  xAxis: {
    title: '시간',
  },
  yAxis: {
    title: '생산량',
  },
  tooltip: {
	  formatter: (value) =>  value+`개`,
  },
  legend: {
    align: 'bottom',
  },
  series: {
      spline: true,
  },
};	

var prodChart = toastui.Chart.lineChart({ el:prodEl, data:prodData, options:prodOptions });

//--------------------------------------생산량 차트 끝-------------------------------------------------------//

//선언
let tmFlag;
let eqmIdFlag;
let tempFlag;
let prodFlag;

//Ajax
function chartAjax(){
	$.ajax({
			url : "${path}/eqm/selectNowEqm.do",
			dataType : 'json',
			method : 'GET',
			error : function(result){
				console.log('에러',result)
			}
		}).done(function (result){
			//result.data.contents
			//console.log(result.data.contents);
			let eqmData = result.data.contents;
			
			let item = {name:'', data:[]};
			eqmIdFlag = '';
			let logSet = new Set();
			
			for(let i = 0 ; i < eqmData.length ; i ++ ) {
				console.log(eqmData[i].logTm)
				logSet.add(eqmData[i].logTm);
				
				if ( eqmIdFlag != eqmData[i].eqmId) {
					
					if( item.name !='') {
						tempData.series.push(item);
					}
					
					item = {name:'', data:[]};
					eqmIdFlag = eqmData[i].eqmId;
					item.name = eqmData[i].eqmId;
				} 
				
					item.data.push({x:eqmData[i].logTm, y:Number(eqmData[i].tempNow)});
				
				if (i == eqmData.length-1 ) {
					tempData.series.push(item);
				}
				
			}

			for(oneTm of Array.from(logSet).sort()) {
				tempData.categories.push(oneTm);
			}
			
			console.log(tempData)
			console.log(tempData.series)
			console.log(tempData.categories)
			
			tempChart.setData(tempData);
			
		})
}

//setInterval

/* const intervalId = setInterval(() => {
		console.log("인터벌---")
		chartAjax();
}, 5000); */

chartAjax();
</script>

</body>
</html>